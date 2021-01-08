Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A201C2EF22B
	for <lists+kvmarm@lfdr.de>; Fri,  8 Jan 2021 13:16:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54F584B41D;
	Fri,  8 Jan 2021 07:16:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mKrE68RXjAGn; Fri,  8 Jan 2021 07:16:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14E0E4B278;
	Fri,  8 Jan 2021 07:16:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F133E4B3D8
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Jan 2021 07:16:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FDlsiDBkC7lr for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Jan 2021 07:16:15 -0500 (EST)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B09D14B45D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Jan 2021 07:16:14 -0500 (EST)
Received: by mail-yb1-f202.google.com with SMTP id m203so15433024ybf.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Jan 2021 04:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=UneVgNM1tyQijhnQQmLMVb1v446RL4t+C96eG3CaS6s=;
 b=sjy+Rq4XVFYrNu/u8dYKqV5xzTkxrsryfinUxE4vTpQxNEMUawE0WVAXTYAxrZrRxK
 3AQucel0UXMfP6Z1Fpjunu5VnUt1x7FYQpkVARaMlEMqOoPg0rEpkTKfdvwdD4PNY1ho
 lP9zsxTHuFqSVVGhBMwFWckCWtFWKgAs+clmqF5nYdn1Tix2xYcJIfcboKppux/K+q6g
 0f9UzpCDoWW2Drr/z5io3pGP2/80Wr2zCw//2zx2HfLq17hY58yPvumPXSHa44HUbFM3
 Zm6CqmHh74BUuZd0yCaychVURrioQxlyJilhlVhE/sUyuEzx8GXENr6x9SEOLk/jOx8p
 kQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=UneVgNM1tyQijhnQQmLMVb1v446RL4t+C96eG3CaS6s=;
 b=mjxk8KbaZ2ckfCLqJ3Xu62F04J5Yav6ocOsn5Zh9Lq7NlW1ZUUDiksxDLM2NA37G9D
 pvAygp81L23Q4/v/NMWNlLb+biWCS1AW5oZn6j6vh/nFDXPWpN7fxlovTyPptwR2oH2C
 QJe08kUEJgwCBKM/29Mu25We2Xab1mWYllKhAyDTq4ZVkZwQUdw2JljafuackcPfVrgT
 xSBvgFlclrJLCl7rJrXXG6RZOYBmKLLDNjbkEbXAWKS2BZymPZvo+axAhe94OzKymvUA
 2Y3vlehFiDj87/8ZPwDWUuxtSPaJ/3xHQi5egbckLi0yOl0dqCvFPvFtYpO4HpijFDdD
 28iA==
X-Gm-Message-State: AOAM530pQRzYVOcoSCfGSkZxeNAvhk4fULi85I4X5b7oez8CTX6mO20U
 MKWTT1YA+ptz/NYCQ3x/CyPFU2Un1BFK
X-Google-Smtp-Source: ABdhPJx2tvQM5pHxJ1110zxDP3Dc7/b7XCKfM0MD28OR/73itm2z2W+f9Cz7ihMgWsQ1O6tYqWDGlPIiIyMg
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a25:6405:: with SMTP id
 y5mr5295727ybb.328.1610108174241; Fri, 08 Jan 2021 04:16:14 -0800 (PST)
Date: Fri,  8 Jan 2021 12:15:20 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-23-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 22/26] KVM: arm64: Refactor __load_guest_stage2()
From: Quentin Perret <qperret@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, android-kvm@google.com,
 linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Refactor __load_guest_stage2() to introduce __load_stage2() which will
be re-used when loading the host stage 2.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 83b4c5cf4768..8d37d6d1ed29 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -345,9 +345,9 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  * Must be called from hyp code running at EL2 with an updated VTTBR
  * and interrupts disabled.
  */
-static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
 {
-	write_sysreg(kern_hyp_va(mmu->arch)->vtcr, vtcr_el2);
+	write_sysreg(vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -358,6 +358,11 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
+static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+{
+	__load_stage2(mmu, kern_hyp_va(mmu->arch)->vtcr);
+}
+
 static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
 {
 	return container_of(mmu->arch, struct kvm, arch);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
