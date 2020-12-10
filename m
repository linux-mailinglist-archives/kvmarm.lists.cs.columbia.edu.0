Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9345C2D5DA6
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 15:29:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 485354B235;
	Thu, 10 Dec 2020 09:29:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GK5lEeGlF2tb; Thu, 10 Dec 2020 09:29:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B9C0A4B272;
	Thu, 10 Dec 2020 09:29:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E43D4B1A6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:29:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id keB8jwsoycx7 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 09:29:43 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA1534B129
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:29:40 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7919A152B;
 Thu, 10 Dec 2020 06:29:40 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6B13F718;
 Thu, 10 Dec 2020 06:29:39 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool 14/21] hw/serial: Switch to new trap handlers
Date: Thu, 10 Dec 2020 14:29:01 +0000
Message-Id: <20201210142908.169597-15-andre.przywara@arm.com>
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

Now that the serial device has a trap handler adhering to the MMIO fault
handler prototype, let's switch over to the joint registration routine.

This allows us to get rid of the ioport shim routines.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 hw/serial.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/serial.c b/hw/serial.c
index 2907089c..d840eebc 100644
--- a/hw/serial.c
+++ b/hw/serial.c
@@ -397,31 +397,6 @@ static void serial8250_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
 	}
 }
 
-static bool serial8250_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
-				  u16 port, void *data, int size)
-{
-	struct serial8250_device *dev = ioport->priv;
-	u8 value = ioport__read8(data);
-
-	serial8250_mmio(vcpu, port, &value, 1, true, dev);
-
-	return true;
-}
-
-static bool serial8250_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
-				 u16 port, void *data, int size)
-{
-	struct serial8250_device *dev = ioport->priv;
-	u8 value = 0;
-
-
-	serial8250_mmio(vcpu, port, &value, 1, false, dev);
-
-	ioport__write8(data, value);
-
-	return true;
-}
-
 #ifdef CONFIG_HAS_LIBFDT
 
 char *fdt_stdout_path = NULL;
@@ -459,11 +434,6 @@ void serial8250_generate_fdt_node(void *fdt, struct device_header *dev_hdr,
 }
 #endif
 
-static struct ioport_operations serial8250_ops = {
-	.io_in			= serial8250_ioport_in,
-	.io_out			= serial8250_ioport_out,
-};
-
 static int serial8250__device_init(struct kvm *kvm,
 				   struct serial8250_device *dev)
 {
@@ -474,7 +444,7 @@ static int serial8250__device_init(struct kvm *kvm,
 		return r;
 
 	ioport__map_irq(&dev->irq);
-	r = ioport__register(kvm, dev->iobase, &serial8250_ops, 8, dev);
+	r = kvm__register_pio(kvm, dev->iobase, 8, serial8250_mmio, dev);
 
 	return r;
 }
@@ -497,7 +467,7 @@ cleanup:
 	for (j = 0; j <= i; j++) {
 		struct serial8250_device *dev = &devices[j];
 
-		ioport__unregister(kvm, dev->iobase);
+		kvm__deregister_pio(kvm, dev->iobase);
 		device__unregister(&dev->dev_hdr);
 	}
 
@@ -513,7 +483,7 @@ int serial8250__exit(struct kvm *kvm)
 	for (i = 0; i < ARRAY_SIZE(devices); i++) {
 		struct serial8250_device *dev = &devices[i];
 
-		r = ioport__unregister(kvm, dev->iobase);
+		r = kvm__deregister_pio(kvm, dev->iobase);
 		if (r < 0)
 			return r;
 		device__unregister(&dev->dev_hdr);
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
