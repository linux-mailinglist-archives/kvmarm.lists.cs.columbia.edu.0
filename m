Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5832D5D9F
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 15:29:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3060A4B242;
	Thu, 10 Dec 2020 09:29:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3OqQ3ZMbXdWg; Thu, 10 Dec 2020 09:29:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F01A14B1E3;
	Thu, 10 Dec 2020 09:29:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2FAA44B201
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:29:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYvIGZo++PPX for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 09:29:32 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BE3E4B1FE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:29:31 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 455FA1474;
 Thu, 10 Dec 2020 06:29:31 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA443F718;
 Thu, 10 Dec 2020 06:29:30 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool 07/21] hw/i8042: Switch to new trap handlers
Date: Thu, 10 Dec 2020 14:28:54 +0000
Message-Id: <20201210142908.169597-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210142908.169597-1-andre.przywara@arm.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
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

Now that the PC keyboard has a trap handler adhering to the MMIO fault
handler prototype, let's switch over to the joint registration routine.

This allows us to get rid of the ioport shim routines.

Make the kbd_init() function static on the way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 hw/i8042.c          | 30 ++++--------------------------
 include/kvm/i8042.h |  1 -
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/hw/i8042.c b/hw/i8042.c
index eb1f9d28..91d79dc4 100644
--- a/hw/i8042.c
+++ b/hw/i8042.c
@@ -325,40 +325,18 @@ static void kbd_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
 		ioport__write8(data, value);
 }
 
-/*
- * Called when the OS has written to one of the keyboard's ports (0x60 or 0x64)
- */
-static bool kbd_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
-{
-	kbd_io(vcpu, port, data, size, false, NULL);
-
-	return true;
-}
-
-static bool kbd_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
-{
-	kbd_io(vcpu, port, data, size, true, NULL);
-
-	return true;
-}
-
-static struct ioport_operations kbd_ops = {
-	.io_in		= kbd_in,
-	.io_out		= kbd_out,
-};
-
-int kbd__init(struct kvm *kvm)
+static int kbd__init(struct kvm *kvm)
 {
 	int r;
 
 	kbd_reset();
 	state.kvm = kvm;
-	r = ioport__register(kvm, I8042_DATA_REG, &kbd_ops, 2, NULL);
+	r = kvm__register_pio(kvm, I8042_DATA_REG, 2, kbd_io, NULL);
 	if (r < 0)
 		return r;
-	r = ioport__register(kvm, I8042_COMMAND_REG, &kbd_ops, 2, NULL);
+	r = kvm__register_pio(kvm, I8042_COMMAND_REG, 2, kbd_io, NULL);
 	if (r < 0) {
-		ioport__unregister(kvm, I8042_DATA_REG);
+		kvm__deregister_pio(kvm, I8042_DATA_REG);
 		return r;
 	}
 
diff --git a/include/kvm/i8042.h b/include/kvm/i8042.h
index 3b4ab688..cd4ae6bb 100644
--- a/include/kvm/i8042.h
+++ b/include/kvm/i8042.h
@@ -7,6 +7,5 @@ struct kvm;
 
 void mouse_queue(u8 c);
 void kbd_queue(u8 c);
-int kbd__init(struct kvm *kvm);
 
 #endif
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
