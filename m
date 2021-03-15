Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF833BFD6
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 16:34:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63BFE4B5DD;
	Mon, 15 Mar 2021 11:34:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l+ylFJKlRX+C; Mon, 15 Mar 2021 11:34:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 626F64B674;
	Mon, 15 Mar 2021 11:34:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0791E4B653
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ckklzOAmJQM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 11:34:31 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BEF1D4B639
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:31 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6849E1FB;
 Mon, 15 Mar 2021 08:34:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C3FA3F792;
 Mon, 15 Mar 2021 08:34:29 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v3 13/22] hw/serial: Refactor trap handler
Date: Mon, 15 Mar 2021 15:33:41 +0000
Message-Id: <20210315153350.19988-14-andre.przywara@arm.com>
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

With the planned retirement of the special ioport emulation code, we
need to provide an emulation function compatible with the MMIO prototype.

Adjust the trap handler to use that new function, and provide shims to
implement the old ioport interface, for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 hw/serial.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/hw/serial.c b/hw/serial.c
index b0465d99..3f797452 100644
--- a/hw/serial.c
+++ b/hw/serial.c
@@ -242,18 +242,14 @@ void serial8250__inject_sysrq(struct kvm *kvm, char sysrq)
 	sysrq_pending = sysrq;
 }
 
-static bool serial8250_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port,
-			   void *data, int size)
+static bool serial8250_out(struct serial8250_device *dev, struct kvm_cpu *vcpu,
+			   u16 offset, void *data)
 {
-	struct serial8250_device *dev = ioport->priv;
-	u16 offset;
 	bool ret = true;
 	char *addr = data;
 
 	mutex_lock(&dev->mutex);
 
-	offset = port - dev->iobase;
-
 	switch (offset) {
 	case UART_TX:
 		if (dev->lcr & UART_LCR_DLAB) {
@@ -336,16 +332,13 @@ static void serial8250_rx(struct serial8250_device *dev, void *data)
 	}
 }
 
-static bool serial8250_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static bool serial8250_in(struct serial8250_device *dev, struct kvm_cpu *vcpu,
+			  u16 offset, void *data)
 {
-	struct serial8250_device *dev = ioport->priv;
-	u16 offset;
 	bool ret = true;
 
 	mutex_lock(&dev->mutex);
 
-	offset = port - dev->iobase;
-
 	switch (offset) {
 	case UART_RX:
 		if (dev->lcr & UART_LCR_DLAB)
@@ -389,6 +382,37 @@ static bool serial8250_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port,
 	return ret;
 }
 
+static void serial8250_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
+			    u8 is_write, void *ptr)
+{
+	struct serial8250_device *dev = ptr;
+
+	if (is_write)
+		serial8250_out(dev, vcpu, addr - dev->iobase, data);
+	else
+		serial8250_in(dev, vcpu, addr - dev->iobase, data);
+}
+
+static bool serial8250_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
+				  u16 port, void *data, int size)
+{
+	struct serial8250_device *dev = ioport->priv;
+
+	serial8250_mmio(vcpu, port, data, 1, true, dev);
+
+	return true;
+}
+
+static bool serial8250_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
+				 u16 port, void *data, int size)
+{
+	struct serial8250_device *dev = ioport->priv;
+
+	serial8250_mmio(vcpu, port, data, 1, false, dev);
+
+	return true;
+}
+
 #ifdef CONFIG_HAS_LIBFDT
 
 char *fdt_stdout_path = NULL;
@@ -427,8 +451,8 @@ void serial8250_generate_fdt_node(void *fdt, struct device_header *dev_hdr,
 #endif
 
 static struct ioport_operations serial8250_ops = {
-	.io_in			= serial8250_in,
-	.io_out			= serial8250_out,
+	.io_in			= serial8250_ioport_in,
+	.io_out			= serial8250_ioport_out,
 };
 
 static int serial8250__device_init(struct kvm *kvm,
-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
