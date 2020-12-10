Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3D2D5DA1
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 15:29:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD92D4B236;
	Thu, 10 Dec 2020 09:29:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inltShjliDmE; Thu, 10 Dec 2020 09:29:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 418EF4B20C;
	Thu, 10 Dec 2020 09:29:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 34E694B201
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:29:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C+5M1sM2dNAM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 09:29:38 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 76E1E4B1F4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:29:35 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39190147A;
 Thu, 10 Dec 2020 06:29:35 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F3853F718;
 Thu, 10 Dec 2020 06:29:34 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool 10/21] hw/rtc: Refactor trap handlers
Date: Thu, 10 Dec 2020 14:28:57 +0000
Message-Id: <20201210142908.169597-11-andre.przywara@arm.com>
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

With the planned retirement of the special ioport emulation code, we
need to provide emulation functions compatible with the MMIO prototype.

Merge the two different trap handlers into one function, checking for
read/write and data/index register inside.
Adjust the trap handlers to use that new function, and provide shims to
implement the old ioport interface, for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 hw/rtc.c | 70 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/hw/rtc.c b/hw/rtc.c
index 5483879f..664d4cb0 100644
--- a/hw/rtc.c
+++ b/hw/rtc.c
@@ -42,11 +42,37 @@ static inline unsigned char bin2bcd(unsigned val)
 	return ((val / 10) << 4) + val % 10;
 }
 
-static bool cmos_ram_data_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static void cmos_ram_io(struct kvm_cpu *vcpu, u64 addr, u8 *data,
+			u32 len, u8 is_write, void *ptr)
 {
 	struct tm *tm;
 	time_t ti;
 
+	if (is_write) {
+		if (addr == 0x70) {	/* index register */
+			u8 value = ioport__read8(data);
+
+			vcpu->kvm->nmi_disabled	= value & (1UL << 7);
+			rtc.cmos_idx		= value & ~(1UL << 7);
+
+			return;
+		}
+
+		switch (rtc.cmos_idx) {
+		case RTC_REG_C:
+		case RTC_REG_D:
+			/* Read-only */
+			break;
+		default:
+			rtc.cmos_data[rtc.cmos_idx] = ioport__read8(data);
+			break;
+		}
+		return;
+	}
+
+	if (addr == 0x70)
+		return;
+
 	time(&ti);
 
 	tm = gmtime(&ti);
@@ -92,42 +118,23 @@ static bool cmos_ram_data_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 po
 		ioport__write8(data, rtc.cmos_data[rtc.cmos_idx]);
 		break;
 	}
-
-	return true;
 }
 
-static bool cmos_ram_data_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static bool cmos_ram_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
 {
-	switch (rtc.cmos_idx) {
-	case RTC_REG_C:
-	case RTC_REG_D:
-		/* Read-only */
-		break;
-	default:
-		rtc.cmos_data[rtc.cmos_idx] = ioport__read8(data);
-		break;
-	}
-
+	cmos_ram_io(vcpu, port, data, size, false, NULL);
 	return true;
 }
 
-static struct ioport_operations cmos_ram_data_ioport_ops = {
-	.io_out		= cmos_ram_data_out,
-	.io_in		= cmos_ram_data_in,
-};
-
-static bool cmos_ram_index_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static bool cmos_ram_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
 {
-	u8 value = ioport__read8(data);
-
-	vcpu->kvm->nmi_disabled	= value & (1UL << 7);
-	rtc.cmos_idx		= value & ~(1UL << 7);
-
+	cmos_ram_io(vcpu, port, data, size, true, NULL);
 	return true;
 }
 
-static struct ioport_operations cmos_ram_index_ioport_ops = {
-	.io_out		= cmos_ram_index_out,
+static struct ioport_operations cmos_ram_ioport_ops = {
+	.io_out		= cmos_ram_out,
+	.io_in		= cmos_ram_in,
 };
 
 #ifdef CONFIG_HAS_LIBFDT
@@ -162,21 +169,15 @@ int rtc__init(struct kvm *kvm)
 		return r;
 
 	/* PORT 0070-007F - CMOS RAM/RTC (REAL TIME CLOCK) */
-	r = ioport__register(kvm, 0x0070, &cmos_ram_index_ioport_ops, 1, NULL);
+	r = ioport__register(kvm, 0x0070, &cmos_ram_ioport_ops, 2, NULL);
 	if (r < 0)
 		goto out_device;
 
-	r = ioport__register(kvm, 0x0071, &cmos_ram_data_ioport_ops, 1, NULL);
-	if (r < 0)
-		goto out_ioport;
-
 	/* Set the VRT bit in Register D to indicate valid RAM and time */
 	rtc.cmos_data[RTC_REG_D] = RTC_REG_D_VRT;
 
 	return r;
 
-out_ioport:
-	ioport__unregister(kvm, 0x0070);
 out_device:
 	device__unregister(&rtc_dev_hdr);
 
@@ -188,7 +189,6 @@ int rtc__exit(struct kvm *kvm)
 {
 	/* PORT 0070-007F - CMOS RAM/RTC (REAL TIME CLOCK) */
 	ioport__unregister(kvm, 0x0070);
-	ioport__unregister(kvm, 0x0071);
 
 	return 0;
 }
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
