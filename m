Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C3324827
	for <lists+kvmarm@lfdr.de>; Thu, 25 Feb 2021 02:00:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 231124B0C7;
	Wed, 24 Feb 2021 20:00:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V2qhmIqJ2l1P; Wed, 24 Feb 2021 20:00:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F0A44B2F3;
	Wed, 24 Feb 2021 20:00:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D5C54B2C2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NrgGRmYiVIcN for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Feb 2021 20:00:51 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4AC464B2EE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:51 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06C591477;
 Wed, 24 Feb 2021 17:00:51 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD6EF3F73B;
 Wed, 24 Feb 2021 17:00:49 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v2 16/22] vfio: Switch to new ioport trap handlers
Date: Thu, 25 Feb 2021 00:59:09 +0000
Message-Id: <20210225005915.26423-17-andre.przywara@arm.com>
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

Now that the vfio device has a trap handler adhering to the MMIO fault
handler prototype, let's switch over to the joint registration routine.

This allows us to get rid of the ioport shim routines.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 vfio/core.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/vfio/core.c b/vfio/core.c
index ddd3c2c7..3ff2c0b0 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -81,7 +81,7 @@ out_free_buf:
 	return ret;
 }
 
-static bool _vfio_ioport_in(struct vfio_region *region, u32 offset,
+static bool vfio_ioport_in(struct vfio_region *region, u32 offset,
 			    void *data, int len)
 {
 	struct vfio_device *vdev = region->vdev;
@@ -115,7 +115,7 @@ static bool _vfio_ioport_in(struct vfio_region *region, u32 offset,
 	return true;
 }
 
-static bool _vfio_ioport_out(struct vfio_region *region, u32 offset,
+static bool vfio_ioport_out(struct vfio_region *region, u32 offset,
 			     void *data, int len)
 {
 	struct vfio_device *vdev = region->vdev;
@@ -155,30 +155,11 @@ static void vfio_ioport_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
 	u32 offset = addr - region->port_base;
 
 	if (is_write)
-		_vfio_ioport_out(region, offset, data, len);
+		vfio_ioport_out(region, offset, data, len);
 	else
-		_vfio_ioport_in(region, offset, data, len);
+		vfio_ioport_in(region, offset, data, len);
 }
 
-static bool vfio_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
-			    u16 port, void *data, int len)
-{
-	vfio_ioport_mmio(vcpu, port, data, len, true, ioport->priv);
-	return true;
-}
-
-static bool vfio_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
-			   u16 port, void *data, int len)
-{
-	vfio_ioport_mmio(vcpu, port, data, len, false, ioport->priv);
-	return true;
-}
-
-static struct ioport_operations vfio_ioport_ops = {
-	.io_in	= vfio_ioport_in,
-	.io_out	= vfio_ioport_out,
-};
-
 static void vfio_mmio_access(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
 			     u8 is_write, void *ptr)
 {
@@ -223,9 +204,11 @@ static int vfio_setup_trap_region(struct kvm *kvm, struct vfio_device *vdev,
 				  struct vfio_region *region)
 {
 	if (region->is_ioport) {
-		int port = ioport__register(kvm, region->port_base,
-					   &vfio_ioport_ops, region->info.size,
-					   region);
+		int port;
+
+		port = kvm__register_pio(kvm, region->port_base,
+					 region->info.size, vfio_ioport_mmio,
+					 region);
 		if (port < 0)
 			return port;
 		return 0;
@@ -292,7 +275,7 @@ void vfio_unmap_region(struct kvm *kvm, struct vfio_region *region)
 		munmap(region->host_addr, region->info.size);
 		region->host_addr = NULL;
 	} else if (region->is_ioport) {
-		ioport__unregister(kvm, region->port_base);
+		kvm__deregister_pio(kvm, region->port_base);
 	} else {
 		kvm__deregister_mmio(kvm, region->guest_phys_addr);
 	}
-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
