Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 08C933EE818
	for <lists+kvmarm@lfdr.de>; Tue, 17 Aug 2021 10:11:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A7AC54B15B;
	Tue, 17 Aug 2021 04:11:56 -0400 (EDT)
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
	with ESMTP id AVBriPnMZ4a6; Tue, 17 Aug 2021 04:11:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BFB14B13F;
	Tue, 17 Aug 2021 04:11:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A43A94B14B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Aug 2021 04:11:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cwig0khSGAcV for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Aug 2021 04:11:50 -0400 (EDT)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 631C14B153
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Aug 2021 04:11:42 -0400 (EDT)
Received: by mail-qk1-f201.google.com with SMTP id
 p14-20020a05620a22eeb02903b94aaa0909so15079391qki.15
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Aug 2021 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kxbHyzuejPRe5tvXTGShAymHj1TyBjbvjR2Be6oEzJU=;
 b=rYgOZ9fzQCCR7qlcFHJ+oPGgdAGWl4I71j6g1HdyCZ05v2GW/jxjIs3lmEYqBUW2kJ
 b2+oqFA9Ad1TV9LHeVRS8a27D4LjSwJ+4Xdg+YZhvg+5Qy4KyvvmpOVxh+8mYJgvO98l
 JTLQOCtPtA0Yhg+56g1CmqaMCsn2bp45w6Na06MK+SDVhIQ4uehI5BK9o4t/Kfi9K936
 ry7FA6XKoH4zke4gHPz+PgyRHu/NIK8eJ+NoejpQZO/Thj1jLRJzGDbWeKtSlJhiX2Ty
 QUdqR+rQfbr44sb8RW+wSI2jhvx/RgSuwaGnViJTCUSqUD/mJNdrz4LpKW0M4796Rzxz
 ds9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kxbHyzuejPRe5tvXTGShAymHj1TyBjbvjR2Be6oEzJU=;
 b=Yg6KAW1mu+dE2nkT5jJmRjFNEo896bYvEeTybT/FXjU/lUsCVoc5fAsfMocaZgih+s
 tC3fBqDbPju2ZTji9Gujj8bD9EXGe73bnhs2yy9krnyjfaZagQiIgeOH6Fpx5nbHG4gQ
 /SAwyOMr8u1yhkwt0py2OEDTNZzvrEHNel1LJXUeb9mjAzNkNAMWnvUWfsR0zoIieD5P
 0yeNXOYT+GWfuEL7WdYPWEgGEupbFro3D0/UZ5Qfx1d+O3/DMglwCxla30c7V8QyMG4g
 hX4WVSnJGmb5wJBL8ASQ5ycs8+4FzH1N4y2kEdzM0Ru9Tl17bRkGDhoInMo0usdhfOrW
 QfYg==
X-Gm-Message-State: AOAM533tlfN9PM8kYhh0KWesXfYRmKTkei1/ie9aiUc8i91nxdEzzX7C
 Kzhz76xsHrofWTs38hxqYd6CwIyzjrogw8OIwasGOggm/r5Xa7y+MOyiGOxlLy36wlDtg3I4cnw
 jHHENymDKDez4UgS3sKkng0f7OW2cBivQjO0yAz/ytpI/3/Lf+0Om/H/HZOoKL94JeOI=
X-Google-Smtp-Source: ABdhPJydZOXLwWz+mECzbOOTIPXj4LsEBgQbXJdrm1r79h8AzOlx5mvXBwR4Dz2Ys80n/4OkjwruE1bJrw==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:ad4:4b33:: with SMTP id
 s19mr2160771qvw.13.1629187901982; 
 Tue, 17 Aug 2021 01:11:41 -0700 (PDT)
Date: Tue, 17 Aug 2021 09:11:22 +0100
In-Reply-To: <20210817081134.2918285-1-tabba@google.com>
Message-Id: <20210817081134.2918285-4-tabba@google.com>
Mime-Version: 1.0
References: <20210817081134.2918285-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v4 03/15] KVM: arm64: MDCR_EL2 is a 64-bit register
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Fix the places in KVM that treat MDCR_EL2 as a 32-bit register.
More recent features (e.g., FEAT_SPEv1p2) use bits above 31.

No functional change intended.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/kvm_arm.h   | 20 ++++++++++----------
 arch/arm64/include/asm/kvm_asm.h   |  2 +-
 arch/arm64/include/asm/kvm_host.h  |  2 +-
 arch/arm64/kvm/debug.c             |  2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c |  2 +-
 arch/arm64/kvm/hyp/vhe/debug-sr.c  |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index d436831dd706..6a523ec83415 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -281,18 +281,18 @@
 /* Hyp Debug Configuration Register bits */
 #define MDCR_EL2_E2TB_MASK	(UL(0x3))
 #define MDCR_EL2_E2TB_SHIFT	(UL(24))
-#define MDCR_EL2_TTRF		(1 << 19)
-#define MDCR_EL2_TPMS		(1 << 14)
+#define MDCR_EL2_TTRF		(UL(1) << 19)
+#define MDCR_EL2_TPMS		(UL(1) << 14)
 #define MDCR_EL2_E2PB_MASK	(UL(0x3))
 #define MDCR_EL2_E2PB_SHIFT	(UL(12))
-#define MDCR_EL2_TDRA		(1 << 11)
-#define MDCR_EL2_TDOSA		(1 << 10)
-#define MDCR_EL2_TDA		(1 << 9)
-#define MDCR_EL2_TDE		(1 << 8)
-#define MDCR_EL2_HPME		(1 << 7)
-#define MDCR_EL2_TPM		(1 << 6)
-#define MDCR_EL2_TPMCR		(1 << 5)
-#define MDCR_EL2_HPMN_MASK	(0x1F)
+#define MDCR_EL2_TDRA		(UL(1) << 11)
+#define MDCR_EL2_TDOSA		(UL(1) << 10)
+#define MDCR_EL2_TDA		(UL(1) << 9)
+#define MDCR_EL2_TDE		(UL(1) << 8)
+#define MDCR_EL2_HPME		(UL(1) << 7)
+#define MDCR_EL2_TPM		(UL(1) << 6)
+#define MDCR_EL2_TPMCR		(UL(1) << 5)
+#define MDCR_EL2_HPMN_MASK	(UL(0x1F))
 
 /* For compatibility with fault code shared with 32-bit */
 #define FSC_FAULT	ESR_ELx_FSC_FAULT
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 9f0bf2109be7..63ead9060ab5 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -210,7 +210,7 @@ extern u64 __vgic_v3_read_vmcr(void);
 extern void __vgic_v3_write_vmcr(u32 vmcr);
 extern void __vgic_v3_init_lrs(void);
 
-extern u32 __kvm_get_mdcr_el2(void);
+extern u64 __kvm_get_mdcr_el2(void);
 
 #define __KVM_EXTABLE(from, to)						\
 	"	.pushsection	__kvm_ex_table, \"a\"\n"		\
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 347781f99b6a..4d2d974c1522 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -289,7 +289,7 @@ struct kvm_vcpu_arch {
 
 	/* HYP configuration */
 	u64 hcr_el2;
-	u32 mdcr_el2;
+	u64 mdcr_el2;
 
 	/* Exception Information */
 	struct kvm_vcpu_fault_info fault;
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index d5e79d7ee6e9..db9361338b2a 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -21,7 +21,7 @@
 				DBG_MDSCR_KDE | \
 				DBG_MDSCR_MDE)
 
-static DEFINE_PER_CPU(u32, mdcr_el2);
+static DEFINE_PER_CPU(u64, mdcr_el2);
 
 /**
  * save/restore_guest_debug_regs
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 7d3f25868cae..df361d839902 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -109,7 +109,7 @@ void __debug_switch_to_host(struct kvm_vcpu *vcpu)
 	__debug_switch_to_host_common(vcpu);
 }
 
-u32 __kvm_get_mdcr_el2(void)
+u64 __kvm_get_mdcr_el2(void)
 {
 	return read_sysreg(mdcr_el2);
 }
diff --git a/arch/arm64/kvm/hyp/vhe/debug-sr.c b/arch/arm64/kvm/hyp/vhe/debug-sr.c
index f1e2e5a00933..289689b2682d 100644
--- a/arch/arm64/kvm/hyp/vhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/debug-sr.c
@@ -20,7 +20,7 @@ void __debug_switch_to_host(struct kvm_vcpu *vcpu)
 	__debug_switch_to_host_common(vcpu);
 }
 
-u32 __kvm_get_mdcr_el2(void)
+u64 __kvm_get_mdcr_el2(void)
 {
 	return read_sysreg(mdcr_el2);
 }
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
