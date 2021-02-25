Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD3324823
	for <lists+kvmarm@lfdr.de>; Thu, 25 Feb 2021 02:00:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B8F74B2EB;
	Wed, 24 Feb 2021 20:00:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x2a7oEt0qz-K; Wed, 24 Feb 2021 20:00:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A22454B2C1;
	Wed, 24 Feb 2021 20:00:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 462884B2EE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E1OIRFtBrtn9 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Feb 2021 20:00:45 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 148D94B2C1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:45 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C99A3143B;
 Wed, 24 Feb 2021 17:00:44 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2593F73B;
 Wed, 24 Feb 2021 17:00:43 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v2 12/22] hw/vesa: Switch trap handling to use MMIO
 handler
Date: Thu, 25 Feb 2021 00:59:05 +0000
Message-Id: <20210225005915.26423-13-andre.przywara@arm.com>
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

To be able to use the VESA device with the new generic I/O trap handler,
we need to use the different MMIO handler callback routine.

Replace the existing dummy in and out handlers with a joint dummy
MMIO handler, and register this using the new registration function.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 hw/vesa.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/hw/vesa.c b/hw/vesa.c
index 8659a002..7f82cdb4 100644
--- a/hw/vesa.c
+++ b/hw/vesa.c
@@ -43,21 +43,11 @@ static struct framebuffer vesafb = {
 	.mem_size	= VESA_MEM_SIZE,
 };
 
-static bool vesa_pci_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static void vesa_pci_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
+		        u8 is_write, void *ptr)
 {
-	return true;
 }
 
-static bool vesa_pci_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
-{
-	return true;
-}
-
-static struct ioport_operations vesa_io_ops = {
-	.io_in			= vesa_pci_io_in,
-	.io_out			= vesa_pci_io_out,
-};
-
 static int vesa__bar_activate(struct kvm *kvm, struct pci_device_header *pci_hdr,
 			      int bar_num, void *data)
 {
@@ -82,7 +72,8 @@ struct framebuffer *vesa__init(struct kvm *kvm)
 	BUILD_BUG_ON(VESA_MEM_SIZE < VESA_BPP/8 * VESA_WIDTH * VESA_HEIGHT);
 
 	vesa_base_addr = pci_get_io_port_block(PCI_IO_SIZE);
-	r = ioport__register(kvm, vesa_base_addr, &vesa_io_ops, PCI_IO_SIZE, NULL);
+	r = kvm__register_pio(kvm, vesa_base_addr, PCI_IO_SIZE, vesa_pci_io,
+			      NULL);
 	if (r < 0)
 		goto out_error;
 
@@ -116,7 +107,7 @@ unmap_dev:
 unregister_device:
 	device__unregister(&vesa_device);
 unregister_ioport:
-	ioport__unregister(kvm, vesa_base_addr);
+	kvm__deregister_pio(kvm, vesa_base_addr);
 out_error:
 	return ERR_PTR(r);
 }
-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
