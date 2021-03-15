Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E247733BFD2
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 16:34:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 950C04B487;
	Mon, 15 Mar 2021 11:34:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4Qcuu5BfspS; Mon, 15 Mar 2021 11:34:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D7F794B61E;
	Mon, 15 Mar 2021 11:34:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AFAC24B548
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fvBtBL6ukW-i for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 11:34:25 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 78A664B483
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:25 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3109E1FB;
 Mon, 15 Mar 2021 08:34:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBDFF3F792;
 Mon, 15 Mar 2021 08:34:23 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v3 09/22] x86/ioport: Switch to new trap handlers
Date: Mon, 15 Mar 2021 15:33:37 +0000
Message-Id: <20210315153350.19988-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210315153350.19988-1-andre.przywara@arm.com>
References: <20210315153350.19988-1-andre.przywara@arm.com>
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

Now that the x86 I/O ports have trap handlers adhering to the MMIO fault
handler prototype, let's switch over to the joint registration routine.

This allows us to get rid of the ioport shim routines.

Since the debug output was done in ioport.c, we would lose this
functionality when moving over to the MMIO handlers. So bring this back
here explicitly, by introducing debug_io().

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 x86/ioport.c | 101 +++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 64 deletions(-)

diff --git a/x86/ioport.c b/x86/ioport.c
index b198de7a..06b7defb 100644
--- a/x86/ioport.c
+++ b/x86/ioport.c
@@ -8,15 +8,29 @@ static void dummy_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
 {
 }
 
-static bool debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static void debug_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
+		     u8 is_write, void *ptr)
 {
-	dummy_io(vcpu, port, data, size, true, NULL);
-	return 0;
-}
+	if (!vcpu->kvm->cfg.ioport_debug)
+		return;
 
-static struct ioport_operations debug_ops = {
-	.io_out		= debug_io_out,
-};
+	fprintf(stderr, "debug port %s from VCPU%lu: port=0x%lx, size=%u",
+		is_write ? "write" : "read", vcpu->cpu_id,
+		(unsigned long)addr, len);
+	if (is_write) {
+		u32 value;
+
+		switch (len) {
+		case 1: value = ioport__read8(data); break;
+		case 2: value = ioport__read16((u16*)data); break;
+		case 4: value = ioport__read32((u32*)data); break;
+		default: value = 0; break;
+		}
+		fprintf(stderr, ", data: 0x%x\n", value);
+	} else {
+		fprintf(stderr, "\n");
+	}
+}
 
 static void seabios_debug_io(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 			     u32 len, u8 is_write, void *ptr)
@@ -31,37 +45,6 @@ static void seabios_debug_io(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 	putchar(ch);
 }
 
-static bool seabios_debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
-{
-	seabios_debug_io(vcpu, port, data, size, true, NULL);
-	return 0;
-}
-
-static struct ioport_operations seabios_debug_ops = {
-	.io_out		= seabios_debug_io_out,
-};
-
-static bool dummy_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
-{
-	dummy_io(vcpu, port, data, size, false, NULL);
-	return true;
-}
-
-static bool dummy_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
-{
-	dummy_io(vcpu, port, data, size, true, NULL);
-	return true;
-}
-
-static struct ioport_operations dummy_read_write_ioport_ops = {
-	.io_in		= dummy_io_in,
-	.io_out		= dummy_io_out,
-};
-
-static struct ioport_operations dummy_write_only_ioport_ops = {
-	.io_out		= dummy_io_out,
-};
-
 /*
  * The "fast A20 gate"
  */
@@ -76,17 +59,6 @@ static void ps2_control_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
 		ioport__write8(data, 0x02);
 }
 
-static bool ps2_control_a_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
-{
-	ps2_control_io(vcpu, port, data, size, false, NULL);
-	return true;
-}
-
-static struct ioport_operations ps2_control_a_ops = {
-	.io_in		= ps2_control_a_io_in,
-	.io_out		= dummy_io_out,
-};
-
 void ioport__map_irq(u8 *irq)
 {
 }
@@ -98,75 +70,76 @@ static int ioport__setup_arch(struct kvm *kvm)
 	/* Legacy ioport setup */
 
 	/* 0000 - 001F - DMA1 controller */
-	r = ioport__register(kvm, 0x0000, &dummy_read_write_ioport_ops, 32, NULL);
+	r = kvm__register_pio(kvm, 0x0000, 32, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* 0x0020 - 0x003F - 8259A PIC 1 */
-	r = ioport__register(kvm, 0x0020, &dummy_read_write_ioport_ops, 2, NULL);
+	r = kvm__register_pio(kvm, 0x0020, 2, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* PORT 0040-005F - PIT - PROGRAMMABLE INTERVAL TIMER (8253, 8254) */
-	r = ioport__register(kvm, 0x0040, &dummy_read_write_ioport_ops, 4, NULL);
+	r = kvm__register_pio(kvm, 0x0040, 4, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* 0092 - PS/2 system control port A */
-	r = ioport__register(kvm, 0x0092, &ps2_control_a_ops, 1, NULL);
+	r = kvm__register_pio(kvm, 0x0092, 1, ps2_control_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* 0x00A0 - 0x00AF - 8259A PIC 2 */
-	r = ioport__register(kvm, 0x00A0, &dummy_read_write_ioport_ops, 2, NULL);
+	r = kvm__register_pio(kvm, 0x00A0, 2, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* 00C0 - 001F - DMA2 controller */
-	r = ioport__register(kvm, 0x00C0, &dummy_read_write_ioport_ops, 32, NULL);
+	r = kvm__register_pio(kvm, 0x00c0, 32, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* PORT 00E0-00EF are 'motherboard specific' so we use them for our
 	   internal debugging purposes.  */
-	r = ioport__register(kvm, IOPORT_DBG, &debug_ops, 1, NULL);
+	r = kvm__register_pio(kvm, IOPORT_DBG, 1, debug_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* PORT 00ED - DUMMY PORT FOR DELAY??? */
-	r = ioport__register(kvm, 0x00ED, &dummy_write_only_ioport_ops, 1, NULL);
+	r = kvm__register_pio(kvm, 0x00ed, 1, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* 0x00F0 - 0x00FF - Math co-processor */
-	r = ioport__register(kvm, 0x00F0, &dummy_write_only_ioport_ops, 2, NULL);
+	r = kvm__register_pio(kvm, 0x00f0, 2, dummy_io, NULL);
+
 	if (r < 0)
 		return r;
 
 	/* PORT 0278-027A - PARALLEL PRINTER PORT (usually LPT1, sometimes LPT2) */
-	r = ioport__register(kvm, 0x0278, &dummy_read_write_ioport_ops, 3, NULL);
+	r = kvm__register_pio(kvm, 0x0278, 3, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* PORT 0378-037A - PARALLEL PRINTER PORT (usually LPT2, sometimes LPT3) */
-	r = ioport__register(kvm, 0x0378, &dummy_read_write_ioport_ops, 3, NULL);
+	r = kvm__register_pio(kvm, 0x0378, 3, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* PORT 03D4-03D5 - COLOR VIDEO - CRT CONTROL REGISTERS */
-	r = ioport__register(kvm, 0x03D4, &dummy_read_write_ioport_ops, 1, NULL);
+	r = kvm__register_pio(kvm, 0x03d4, 1, dummy_io, NULL);
 	if (r < 0)
 		return r;
-	r = ioport__register(kvm, 0x03D5, &dummy_write_only_ioport_ops, 1, NULL);
+	r = kvm__register_pio(kvm, 0x03d5, 1, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
-	r = ioport__register(kvm, 0x402, &seabios_debug_ops, 1, NULL);
+	r = kvm__register_pio(kvm, 0x0402, 1, seabios_debug_io, NULL);
 	if (r < 0)
 		return r;
 
 	/* 0510 - QEMU BIOS configuration register */
-	r = ioport__register(kvm, 0x510, &dummy_read_write_ioport_ops, 2, NULL);
+	r = kvm__register_pio(kvm, 0x0510, 2, dummy_io, NULL);
 	if (r < 0)
 		return r;
 
-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
