Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 37745324826
	for <lists+kvmarm@lfdr.de>; Thu, 25 Feb 2021 02:00:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DEDAA4B2EC;
	Wed, 24 Feb 2021 20:00:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3h3pjWpWwWHo; Wed, 24 Feb 2021 20:00:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 043BC4B2C4;
	Wed, 24 Feb 2021 20:00:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 24E644B2BB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbHqRyvxq8z0 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Feb 2021 20:00:50 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BAE274B24F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:49 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72CF31476;
 Wed, 24 Feb 2021 17:00:49 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2755E3F73B;
 Wed, 24 Feb 2021 17:00:48 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v2 15/22] vfio: Refactor ioport trap handler
Date: Thu, 25 Feb 2021 00:59:08 +0000
Message-Id: <20210225005915.26423-16-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210225005915.26423-1-andre.przywara@arm.com>
References: <20210225005915.26423-1-andre.przywara@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Sami Mujawar <sami.mujawar@arm.com>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

With the planned retirement of the special ioport emulation code, we
need to provide an emulation function compatible with the MMIO prototype.

Adjust the I/O port trap handler to use that new function, and provide
shims to implement the old ioport interface, for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 vfio/core.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/vfio/core.c b/vfio/core.c
index 0b45e78b..ddd3c2c7 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -81,15 +81,12 @@ out_free_buf:
 	return ret;
 }
 
-static bool vfio_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
-			   u16 port, void *data, int len)
+static bool _vfio_ioport_in(struct vfio_region *region, u32 offset,
+			    void *data, int len)
 {
-	u32 val;
-	ssize_t nr;
-	struct vfio_region *region = ioport->priv;
 	struct vfio_device *vdev = region->vdev;
-
-	u32 offset = port - region->port_base;
+	ssize_t nr;
+	u32 val;
 
 	if (!(region->info.flags & VFIO_REGION_INFO_FLAG_READ))
 		return false;
@@ -97,7 +94,7 @@ static bool vfio_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
 	nr = pread(vdev->fd, &val, len, region->info.offset + offset);
 	if (nr != len) {
 		vfio_dev_err(vdev, "could not read %d bytes from I/O port 0x%x\n",
-			     len, port);
+			     len, offset + region->port_base);
 		return false;
 	}
 
@@ -118,15 +115,13 @@ static bool vfio_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
 	return true;
 }
 
-static bool vfio_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
-			    u16 port, void *data, int len)
+static bool _vfio_ioport_out(struct vfio_region *region, u32 offset,
+			     void *data, int len)
 {
-	u32 val;
-	ssize_t nr;
-	struct vfio_region *region = ioport->priv;
 	struct vfio_device *vdev = region->vdev;
+	ssize_t nr;
+	u32 val;
 
-	u32 offset = port - region->port_base;
 
 	if (!(region->info.flags & VFIO_REGION_INFO_FLAG_WRITE))
 		return false;
@@ -148,11 +143,37 @@ static bool vfio_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
 	nr = pwrite(vdev->fd, &val, len, region->info.offset + offset);
 	if (nr != len)
 		vfio_dev_err(vdev, "could not write %d bytes to I/O port 0x%x",
-			     len, port);
+			     len, offset + region->port_base);
 
 	return nr == len;
 }
 
+static void vfio_ioport_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
+			     u8 is_write, void *ptr)
+{
+	struct vfio_region *region = ptr;
+	u32 offset = addr - region->port_base;
+
+	if (is_write)
+		_vfio_ioport_out(region, offset, data, len);
+	else
+		_vfio_ioport_in(region, offset, data, len);
+}
+
+static bool vfio_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
+			    u16 port, void *data, int len)
+{
+	vfio_ioport_mmio(vcpu, port, data, len, true, ioport->priv);
+	return true;
+}
+
+static bool vfio_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
+			   u16 port, void *data, int len)
+{
+	vfio_ioport_mmio(vcpu, port, data, len, false, ioport->priv);
+	return true;
+}
+
 static struct ioport_operations vfio_ioport_ops = {
 	.io_in	= vfio_ioport_in,
 	.io_out	= vfio_ioport_out,
-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
