Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 357123E29A3
	for <lists+kvmarm@lfdr.de>; Fri,  6 Aug 2021 13:31:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD4364B0F8;
	Fri,  6 Aug 2021 07:31:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DiC-VKfGvYq3; Fri,  6 Aug 2021 07:31:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CEC34B0EC;
	Fri,  6 Aug 2021 07:31:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 03E284B0EB
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Aug 2021 07:31:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwAN873H2aje for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Aug 2021 07:31:28 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AFCA54B0F9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Aug 2021 07:31:28 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED5760FE7;
 Fri,  6 Aug 2021 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628249487;
 bh=giYlm+RhVr3oiAFmcpa/YUkxPfS6Fn6zcEf0IHpmalk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kml46dOdNnplKZ8Eq4KYTWTyVgZq6HUOzCuIZGrTK3n1kpgcnf4PVDzXrVhW6A18E
 6+Ec1pFFxG14gMt6O8curxl4c5KPRFBM0xC578fEn7n+M+W3W8S5Jv0sY9KBSu+JUc
 wjuGgFfnT6doYQMMB6hy/Cm68oN5FsRiiMpBVuWmEgwTws63RZtmvbkcsLLMKXN6Rm
 T4cQ3hFJgr5zRsDYkZyoXZELys5PVjGhrL4ewqNdL66d/rFMMr8N3skUShoVztbSP9
 oanMN00X914Ugq8dANH2igPaLBS3W1BRoFvdZSQzcAus6KNm6HZdlwp59JJIxAKLuV
 glszAtfkO0wmA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] KVM: arm64: Move kern_hyp_va() usage in
 __load_guest_stage2() into the callers
Date: Fri,  6 Aug 2021 12:31:06 +0100
Message-Id: <20210806113109.2475-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806113109.2475-1-will@kernel.org>
References: <20210806113109.2475-1-will@kernel.org>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Jade Alglave <jade.alglave@arm.com>
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

It is a bit awkward to use kern_hyp_va() in __load_guest_stage2(),
specially as the helper is shared between VHE and nVHE.

Instead, move the use of kern_hyp_va() in the nVHE code, and
pass a pointer to the kvm->arch structure instead. Although
this may look a bit awkward, it allows for some further simplification.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jade Alglave <jade.alglave@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_mmu.h | 5 +++--
 arch/arm64/kvm/hyp/nvhe/switch.c | 4 +++-
 arch/arm64/kvm/hyp/nvhe/tlb.c    | 2 +-
 arch/arm64/kvm/hyp/vhe/switch.c  | 2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c     | 2 +-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b52c5c4b9a3d..05e089653a1a 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -280,9 +280,10 @@ static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
-static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu,
+						struct kvm_arch *arch)
 {
-	__load_stage2(mmu, kern_hyp_va(mmu->arch)->vtcr);
+	__load_stage2(mmu, arch->vtcr);
 }
 
 static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index f7af9688c1f7..e50a49082923 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -170,6 +170,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *host_ctxt;
 	struct kvm_cpu_context *guest_ctxt;
+	struct kvm_s2_mmu *mmu;
 	bool pmu_switch_needed;
 	u64 exit_code;
 
@@ -213,7 +214,8 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	__sysreg32_restore_state(vcpu);
 	__sysreg_restore_state_nvhe(guest_ctxt);
 
-	__load_guest_stage2(kern_hyp_va(vcpu->arch.hw_mmu));
+	mmu = kern_hyp_va(vcpu->arch.hw_mmu);
+	__load_guest_stage2(mmu, kern_hyp_va(mmu->arch));
 	__activate_traps(vcpu);
 
 	__hyp_vgic_restore_state(vcpu);
diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
index 38ed0f6f2703..76229407d8f0 100644
--- a/arch/arm64/kvm/hyp/nvhe/tlb.c
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -39,7 +39,7 @@ static void __tlb_switch_to_guest(struct kvm_s2_mmu *mmu,
 	 * ensuring that we always have an ISB, but not two ISBs back
 	 * to back.
 	 */
-	__load_guest_stage2(mmu);
+	__load_guest_stage2(mmu, kern_hyp_va(mmu->arch));
 	asm(ALTERNATIVE("isb", "nop", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index b3229924d243..0cb7523a501a 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -128,7 +128,7 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	 * __load_guest_stage2 configures stage 2 translation, and
 	 * __activate_traps clear HCR_EL2.TGE (among other things).
 	 */
-	__load_guest_stage2(vcpu->arch.hw_mmu);
+	__load_guest_stage2(vcpu->arch.hw_mmu, vcpu->arch.hw_mmu->arch);
 	__activate_traps(vcpu);
 
 	__kvm_adjust_pc(vcpu);
diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index 66f17349f0c3..5e9fb3989e0b 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -53,7 +53,7 @@ static void __tlb_switch_to_guest(struct kvm_s2_mmu *mmu,
 	 * place before clearing TGE. __load_guest_stage2() already
 	 * has an ISB in order to deal with this.
 	 */
-	__load_guest_stage2(mmu);
+	__load_guest_stage2(mmu, mmu->arch);
 	val = read_sysreg(hcr_el2);
 	val &= ~HCR_TGE;
 	write_sysreg(val, hcr_el2);
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
