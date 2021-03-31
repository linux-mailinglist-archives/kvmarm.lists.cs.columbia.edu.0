Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1662E348C74
	for <lists+kvmarm@lfdr.de>; Thu, 25 Mar 2021 10:15:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE6374B44A;
	Thu, 25 Mar 2021 05:15:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xve76x5CRVMQ; Thu, 25 Mar 2021 05:15:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC69F4B390;
	Thu, 25 Mar 2021 05:15:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DFCE34B2D9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Mar 2021 05:15:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i9DEDr6IdYCc for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Mar 2021 05:15:26 -0400 (EDT)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 27DED4B29C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Mar 2021 05:15:26 -0400 (EDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5fX06SNtznTqc;
 Thu, 25 Mar 2021 17:12:48 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.26.249) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 17:15:11 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>
Subject: [PATCH for-stable-5.10 1/2] KVM: arm64: Rename
 __vgic_v3_get_ich_vtr_el2() to __vgic_v3_get_gic_config()
Date: Thu, 25 Mar 2021 09:14:23 +0000
Message-ID: <20210325091424.26348-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210325091424.26348-1-shameerali.kolothum.thodi@huawei.com>
References: <20210325091424.26348-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.26.249]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, linuxarm@huawei.com, pbonzini@redhat.com
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

From: Marc Zyngier <maz@kernel.org>

commit b9d699e2694d032aa8ecc15141f698ccb050dc95 upstream.

As we are about to report a bit more information to the rest of
the kernel, rename __vgic_v3_get_ich_vtr_el2() to the more
explicit __vgic_v3_get_gic_config().

No functional change.

Cc: stable@vger.kernel.org #5.10
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Message-Id: <20210305185254.3730990-7-maz@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[Shameer: Back ported to 5.10]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/kvm_asm.h   | 4 ++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 4 ++--
 arch/arm64/kvm/hyp/vgic-v3-sr.c    | 7 ++++++-
 arch/arm64/kvm/vgic/vgic-v3.c      | 4 +++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 54387ccd1ab2..21de2d632f97 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -52,7 +52,7 @@
 #define __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_local_vmid	5
 #define __KVM_HOST_SMCCC_FUNC___kvm_timer_set_cntvoff		6
 #define __KVM_HOST_SMCCC_FUNC___kvm_enable_ssbs			7
-#define __KVM_HOST_SMCCC_FUNC___vgic_v3_get_ich_vtr_el2		8
+#define __KVM_HOST_SMCCC_FUNC___vgic_v3_get_gic_config		8
 #define __KVM_HOST_SMCCC_FUNC___vgic_v3_read_vmcr		9
 #define __KVM_HOST_SMCCC_FUNC___vgic_v3_write_vmcr		10
 #define __KVM_HOST_SMCCC_FUNC___vgic_v3_init_lrs		11
@@ -191,7 +191,7 @@ extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
 extern void __kvm_enable_ssbs(void);
 
-extern u64 __vgic_v3_get_ich_vtr_el2(void);
+extern u64 __vgic_v3_get_gic_config(void);
 extern u64 __vgic_v3_read_vmcr(void);
 extern void __vgic_v3_write_vmcr(u32 vmcr);
 extern void __vgic_v3_init_lrs(void);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index e2eafe2c93af..1e09d0052bf3 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -62,8 +62,8 @@ static void handle_host_hcall(unsigned long func_id,
 	case KVM_HOST_SMCCC_FUNC(__kvm_enable_ssbs):
 		__kvm_enable_ssbs();
 		break;
-	case KVM_HOST_SMCCC_FUNC(__vgic_v3_get_ich_vtr_el2):
-		ret = __vgic_v3_get_ich_vtr_el2();
+	case KVM_HOST_SMCCC_FUNC(__vgic_v3_get_gic_config):
+		ret = __vgic_v3_get_gic_config();
 		break;
 	case KVM_HOST_SMCCC_FUNC(__vgic_v3_read_vmcr):
 		ret = __vgic_v3_read_vmcr();
diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index 452f4cacd674..54ce4048d7d1 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -403,7 +403,12 @@ void __vgic_v3_init_lrs(void)
 		__gic_v3_set_lr(0, i);
 }
 
-u64 __vgic_v3_get_ich_vtr_el2(void)
+/*
+ * Return the GIC CPU configuration:
+ * - [31:0]  ICH_VTR_EL2
+ * - [63:32] RES0
+ */
+u64 __vgic_v3_get_gic_config(void)
 {
 	return read_gicreg(ICH_VTR_EL2);
 }
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 9cdf39a94a63..8e7bf3151057 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -583,9 +583,11 @@ early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
  */
 int vgic_v3_probe(const struct gic_kvm_info *info)
 {
-	u32 ich_vtr_el2 = kvm_call_hyp_ret(__vgic_v3_get_ich_vtr_el2);
+	u64 ich_vtr_el2 = kvm_call_hyp_ret(__vgic_v3_get_gic_config);
 	int ret;
 
+	ich_vtr_el2 = (u32)ich_vtr_el2;
+
 	/*
 	 * The ListRegs field is 5 bits, but there is an architectural
 	 * maximum of 16 list registers. Just ignore bit 4...
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
