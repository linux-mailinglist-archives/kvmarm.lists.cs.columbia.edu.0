Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D0B4F5B059
	for <lists+kvmarm@lfdr.de>; Sun, 30 Jun 2019 17:19:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 50FBB4A50A;
	Sun, 30 Jun 2019 11:19:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@web.de
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7AnGkJ7qqRp; Sun, 30 Jun 2019 11:19:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 061F64A4FF;
	Sun, 30 Jun 2019 11:19:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 03BBA4A417
 for <kvmarm@lists.cs.columbia.edu>; Sun, 30 Jun 2019 11:19:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3IM1C32SljPa for <kvmarm@lists.cs.columbia.edu>;
 Sun, 30 Jun 2019 11:19:08 -0400 (EDT)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 723884A3B4
 for <kvmarm@lists.cs.columbia.edu>; Sun, 30 Jun 2019 11:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561907945;
 bh=1hzO1yqzuoU2fg4Q62rIyXmu6NICF9gBDI9a9A6JwII=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=pVCmD1l5uDu3WLPNPKm/whdFq6I0+2mJNVv/+ad2kSC6P529pHX4kSqudpJNreQGd
 MrP/bI1lNh5Kijk8L+jAKocefQV6loNePWpyepm54aBe62NVJEZtIoWTrPDybuVm2t
 1Q5SEKGqGi+A+DP/uhV68DuM3vMlXEWSopvmchI0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.54.22]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkPmd-1iFIWo0xdj-00cUJS; Sun, 30
 Jun 2019 17:19:05 +0200
To: Marc Zyngier <marc.zyngier@arm.com>, kvmarm <kvmarm@lists.cs.columbia.edu>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] kvm: arm: Promote KVM_ARM_TARGET_CORTEX_A7 to generic V7 core
Message-ID: <b486cb75-4b8e-c847-a019-81e822223fb6@web.de>
Date: Sun, 30 Jun 2019 17:19:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:S/S0poinZh/eiAEBjJJ0x7oxvYcEnjk1BZhcitM7MWJPf1wBfWi
 NFNdMcBhXkBPLCP4AHhDp7SNb4R8VWOkRuz15H1J5qoRkj1QfHWZjPo5WiU2+PX7nN2kbm1
 0N7LKvU23eSq2fAKgp0QNYpPFXgyUMP/url3E2b60JSJoNNOh+JtyzvSVtBydpgau7ZDbRr
 YK2ude4yZhRZjSUrvlNWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gLP2ToO4w7w=:ON/U2A/drwShL7xPSuBFGP
 A/OvLkrdrrtCntIWy6CCzL9bTvacCA2vlT1paz9PNJfWJjoxYQiOBfKkDyUg8s+dk4gDe9pcn
 FeaAi74ZfjTFbkISsKoAOz9HZfHSeOLyU4aZDjJrIXntVOpYaFjVkYUg0tS2RfVYcChon3VOg
 z4FpRFUjRGKHjBEB1NbfY6pjQo4//fiqPbZZAxjG28Gj5qrNdYNN4lQHZGFSzz3navIdcVt9k
 fSycbG4kqZ3Nj1eit9E+Ce/rrUrdZ7o9qKdVg679wR0ABAj1iUHZ+f+EQIKBppUX1kGOFpCy2
 jg0NO0NiUNcbgex2bDC5Wqqk9aLWoHuX/YKhWBInNVUHofzgp0T5bvYA2qV7q9BpYJsoxsmxP
 D+5ledQi3cT2GoXrSGqlucRwit3Q06ZPBEG5ytsdiUP1q1jrTGSU4YFXsLwyEnPFRSqJry0gi
 8jAFlsHek9ue80tJyUJHwWfKPktomHhlY8OXy/3rkNE5d1OE18RY5WiTiA6/28zC8xnKyaVT2
 hT2t5StbfutwE1yuS0q3Qmebpn57biad4sQRy90fE9dyb1wEWxfYPR92s/jCEeoD4GPAwoyDf
 RCFsDI4QxN0n7AbOvfGCpjdOq6J3zMsl5VWvHGY+YyOINfj7RYS2SsBMKrcSea6TlPz4okhcd
 RjEs05GyrBRnWzBaaRqPNe0C1VSgKhiRn68AnW1c7GGoutF+UpfT3LNrjekNd//y5lgCqg7Wn
 08HtkRS78Urt51jYf+AIUp2TJqFPsXpYDtVBRjBWr3k2f5K17G58U+u89gnlDiohuIaaPw1nh
 BUpQwgP9Vj9lXv6l6GPQZTHcPxJdrIFHjhFOY3n26Hq1HYi4rVUUmIq99nDUlMyO/GiTRZdHs
 Rce2WEprzXH+QCFrA93HdId4t23jgXsYYXfWI/UAbi004uUL5yELObz29kaeRb6cETAG9i3Qa
 0CqryFNu/r/2IyyyA6ZsOfHXdJdt/xdPZKE29xLC/0R8HmP0+I0+nkF+tbEBKcGVHhOhjjWIj
 JEnvebU01s7akPL+9fM/OCcXRLQUEernPwqboJRIUBI5KyW8kDRVnsTn/watvgi5nrtomCVZj
 38FbLOt7v8f57n/cNtZZcC0IRSah8TT0LWo
Cc: kvm <kvm@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

From: Jan Kiszka <jan.kiszka@siemens.com>

The only difference between the currently supported A15 and A7 target
cores is the reset state of bit 11 in SCTLR. This bit is RES1 or RAO/WI
in other ARM cores, including ARMv8 ones. By promoting A7 to a generic
default target, this allows to use yet unsupported core types. E.g.,
this enables KVM on the A72 of the RPi4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/uapi/asm/kvm.h                |  1 +
 arch/arm/kvm/Makefile                          |  2 +-
 arch/arm/kvm/{coproc_a7.c => coproc_generic.c} | 18 +++++++++---------
 arch/arm/kvm/guest.c                           |  4 +---
 arch/arm/kvm/reset.c                           |  5 +----
 5 files changed, 13 insertions(+), 17 deletions(-)
 rename arch/arm/kvm/{coproc_a7.c => coproc_generic.c} (70%)

diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 4602464ebdfb..e0c5bbec3d3d 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -70,6 +70,7 @@ struct kvm_regs {
 /* Supported Processor Types */
 #define KVM_ARM_TARGET_CORTEX_A15	0
 #define KVM_ARM_TARGET_CORTEX_A7	1
+#define KVM_ARM_TARGET_GENERIC_V7	KVM_ARM_TARGET_CORTEX_A7
 #define KVM_ARM_NUM_TARGETS		2

 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 531e59f5be9c..d959f89135d6 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_KVM_ARM_HOST) += hyp/

 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += handle_exit.o guest.o emulate.o reset.o
-obj-y += coproc.o coproc_a15.o coproc_a7.o   vgic-v3-coproc.o
+obj-y += coproc.o coproc_a15.o coproc_generic.o   vgic-v3-coproc.o
 obj-y += $(KVM)/arm/arm.o $(KVM)/arm/mmu.o $(KVM)/arm/mmio.o
 obj-y += $(KVM)/arm/psci.o $(KVM)/arm/perf.o
 obj-y += $(KVM)/arm/aarch32.o
diff --git a/arch/arm/kvm/coproc_a7.c b/arch/arm/kvm/coproc_generic.c
similarity index 70%
rename from arch/arm/kvm/coproc_a7.c
rename to arch/arm/kvm/coproc_generic.c
index 40f643e1e05c..b32a541ad7bf 100644
--- a/arch/arm/kvm/coproc_a7.c
+++ b/arch/arm/kvm/coproc_generic.c
@@ -15,28 +15,28 @@
 #include "coproc.h"

 /*
- * Cortex-A7 specific CP15 registers.
+ * Generic CP15 registers.
  * CRn denotes the primary register number, but is copied to the CRm in the
  * user space API for 64-bit register access in line with the terminology used
  * in the ARM ARM.
  * Important: Must be sorted ascending by CRn, CRM, Op1, Op2 and with 64-bit
  *            registers preceding 32-bit ones.
  */
-static const struct coproc_reg a7_regs[] = {
+static const struct coproc_reg generic_regs[] = {
 	/* SCTLR: swapped by interrupt.S. */
 	{ CRn( 1), CRm( 0), Op1( 0), Op2( 0), is32,
 			access_vm_reg, reset_val, c1_SCTLR, 0x00C50878 },
 };

-static struct kvm_coproc_target_table a7_target_table = {
-	.target = KVM_ARM_TARGET_CORTEX_A7,
-	.table = a7_regs,
-	.num = ARRAY_SIZE(a7_regs),
+static struct kvm_coproc_target_table generic_target_table = {
+	.target = KVM_ARM_TARGET_GENERIC_V7,
+	.table = generic_regs,
+	.num = ARRAY_SIZE(generic_regs),
 };

-static int __init coproc_a7_init(void)
+static int __init coproc_generic_init(void)
 {
-	kvm_register_target_coproc_table(&a7_target_table);
+	kvm_register_target_coproc_table(&generic_target_table);
 	return 0;
 }
-late_initcall(coproc_a7_init);
+late_initcall(coproc_generic_init);
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 684cf64b4033..d33a24e70f49 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -275,12 +275,10 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 int __attribute_const__ kvm_target_cpu(void)
 {
 	switch (read_cpuid_part()) {
-	case ARM_CPU_PART_CORTEX_A7:
-		return KVM_ARM_TARGET_CORTEX_A7;
 	case ARM_CPU_PART_CORTEX_A15:
 		return KVM_ARM_TARGET_CORTEX_A15;
 	default:
-		return -EINVAL;
+		return KVM_ARM_TARGET_GENERIC_V7;
 	}
 }

diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index eb4174f6ebbd..d6e07500bab4 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -43,13 +43,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	struct kvm_regs *reset_regs;

 	switch (vcpu->arch.target) {
-	case KVM_ARM_TARGET_CORTEX_A7:
-	case KVM_ARM_TARGET_CORTEX_A15:
+	default:
 		reset_regs = &cortexa_regs_reset;
 		vcpu->arch.midr = read_cpuid_id();
 		break;
-	default:
-		return -ENODEV;
 	}

 	/* Reset core registers */
--
2.16.4
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
