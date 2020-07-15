Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0D2214A4
	for <lists+kvmarm@lfdr.de>; Wed, 15 Jul 2020 20:46:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B7744B407;
	Wed, 15 Jul 2020 14:46:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzkjY5QaAZZZ; Wed, 15 Jul 2020 14:46:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89F3C4B419;
	Wed, 15 Jul 2020 14:46:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CD1B4B3D6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 14:46:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F5+9Cl7QnT6y for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Jul 2020 14:46:12 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 418274B32C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 14:46:11 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id t7so4036455ybk.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=1h5yiVlEcGSjp9MBOFB9/KxLYEWTdRezK4/MxuPKPQc=;
 b=OBDCmtH2wegRr+gXO7OzWZ/BBpjtI0m1anex4KziDwrdaVrFJzx7qU+UEr/3rNh0kv
 GXk5atmvsjfX/KsT6FqEKqcLtCY4Jmhe2SNe9CbsLDaKQsBsjweJBeawLtWlTcYM7fK3
 Tmg+yyg0WZOEZq1lCr6tmaQSr15HL1ZqebqM1BgjkhOGnrn7csGos7tLcGmiU9/lwtuw
 9D5YOjWqD8Q6ysmcfoxlbg2SsdusuESjgkckwa4PqVfU2wvhvkXIIlyufoF6GiaFf8Q+
 +2LPSz2r8VJWp/d+CpwZFasYseR0w6RChbPcAbHbIsVBbEDSw4uf/MX0TqMKIkgxCzMl
 S9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=1h5yiVlEcGSjp9MBOFB9/KxLYEWTdRezK4/MxuPKPQc=;
 b=toO+x3GZaSVef9WErDKnHGJJMWvOD6hGbxW/kl7bQuHt71pb3I1zMcejcPk+l81HQz
 Y+XLikOWTAkZpx5nziYjA3A7MeapLd0VHJRa09WiZAKWG7D0fHlnjkIl8jXtTsl06+KC
 Z/mIAx5fp/ZLp008xChzLtAR0zE30h5urmrBkKZIEbnwmH6QBoiNd2FoKq8wls8lKArq
 ZXzNkSoqXIOaG8Lv17NQzgzoJx69ypfEOmhqRL0iPvM8y0L4ukXeNfpR+/bcHcZi09dd
 oCinFH3AIA1fr/Se1jriT9q3s9Lz9JlWZwiZNtCzzZj+YR1naSZ1Le7ZWibLR+P2Vq29
 ew9A==
X-Gm-Message-State: AOAM5339Boy7k9aNts4zY+dxm+jh4YQQCXtjh2PM7CTcvRL30A/NTDwF
 Y+dK7HN8C2lE31ON/WLC3bGyo62fGBMRX2pjrgegdTkS1cGNDY8Zrb9uO0G4jaHu9NBXKpAvWjg
 OfkZZqCx4WAI9ZqYAh1Hq5BrGFH2ZVOBFkMyRp1CvMsZdNG6Pj2BW5tMw1pDI1lz6RJzkDA==
X-Google-Smtp-Source: ABdhPJyI3zp2R0zq9z+DRZTR0QXAwy5Aa1yAlCGVWokjzc9zNBdWQ1JE90RUFE4y3kcsU8J0CRUxG8ax3ao=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr679496ybi.36.1594838770659;
 Wed, 15 Jul 2020 11:46:10 -0700 (PDT)
Date: Wed, 15 Jul 2020 19:44:38 +0100
In-Reply-To: <20200715184438.1390996-1-ascull@google.com>
Message-Id: <20200715184438.1390996-38-ascull@google.com>
Mime-Version: 1.0
References: <20200715184438.1390996-1-ascull@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 37/37] KVM: arm64: Separate save and restore of vcpu trap state
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, kernel-team@android.com
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

Pending virtual interrupts are saved in the saving phase and restoration
enables or disables traps depending on whether or not the host is being
restored.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c        | 28 +++++++++++--------------
 arch/arm64/kvm/hyp/vhe/switch.c         |  2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 84fd6b0601b2..65a29d029c53 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -113,7 +113,7 @@ static inline void ___activate_traps(struct kvm_vcpu *vcpu)
 		write_sysreg_s(vcpu->arch.vsesr_el2, SYS_VSESR_EL2);
 }
 
-static inline void ___deactivate_traps(struct kvm_vcpu *vcpu)
+static inline void __save_traps(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * If we pended a virtual abort, preserve it until it gets
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 260c5cbb6717..0f7670dabf50 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -45,10 +45,8 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(val, cptr_el2);
 }
 
-static void __deactivate_traps(struct kvm_vcpu *host_vcpu, struct kvm_vcpu *vcpu)
+static void __deactivate_traps(struct kvm_vcpu *host_vcpu)
 {
-	___deactivate_traps(vcpu);
-
 	__deactivate_traps_common();
 
 	write_sysreg(host_vcpu->arch.mdcr_el2, mdcr_el2);
@@ -56,6 +54,14 @@ static void __deactivate_traps(struct kvm_vcpu *host_vcpu, struct kvm_vcpu *vcpu
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 }
 
+static void __restore_traps(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.ctxt.is_host)
+		__deactivate_traps(vcpu);
+	else
+		__activate_traps(vcpu);
+}
+
 static void __restore_stage2(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.hcr_el2 & HCR_VM)
@@ -134,6 +140,7 @@ static void __vcpu_save_state(struct kvm_vcpu *vcpu, bool save_debug)
 
 	__fpsimd_save_fpexc32(vcpu);
 
+	__save_traps(vcpu);
 	__debug_save_spe(vcpu);
 
 	if (save_debug)
@@ -143,14 +150,6 @@ static void __vcpu_save_state(struct kvm_vcpu *vcpu, bool save_debug)
 
 static void __vcpu_restore_state(struct kvm_vcpu *vcpu, bool restore_debug)
 {
-	struct kvm_vcpu *running_vcpu;
-
-	/*
-	 * Restoration is not yet pure so it still makes use of the previously
-	 * running vcpu.
-	 */
-	running_vcpu = __hyp_this_cpu_read(kvm_hyp_running_vcpu);
-
 	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		u64 val;
 
@@ -179,10 +178,7 @@ static void __vcpu_restore_state(struct kvm_vcpu *vcpu, bool restore_debug)
 	__sysreg32_restore_state(vcpu);
 	__sysreg_restore_state_nvhe(&vcpu->arch.ctxt);
 
-	if (vcpu->arch.ctxt.is_host)
-		__deactivate_traps(vcpu, running_vcpu);
-	else
-		__activate_traps(vcpu);
+	__restore_traps(vcpu);
 
 	__hyp_vgic_restore_state(vcpu);
 	__timer_restore_traps(vcpu);
@@ -260,7 +256,7 @@ void __noreturn hyp_panic(void)
 
 	if (vcpu != host_vcpu) {
 		__timer_restore_traps(host_vcpu);
-		__deactivate_traps(host_vcpu, vcpu);
+		__restore_traps(host_vcpu);
 		__restore_stage2(host_vcpu);
 		__sysreg_restore_state_nvhe(&host_vcpu->arch.ctxt);
 	}
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index bc372629e1c1..bc5939581f61 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -67,7 +67,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 {
 	extern char vectors[];	/* kernel exception vectors */
 
-	___deactivate_traps(vcpu);
+	__save_traps(vcpu);
 
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 
-- 
2.27.0.389.gc38d7665816-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
