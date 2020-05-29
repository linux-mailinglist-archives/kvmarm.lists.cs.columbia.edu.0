Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 80FFB1E82CF
	for <lists+kvmarm@lfdr.de>; Fri, 29 May 2020 18:01:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 18DED4B2A6;
	Fri, 29 May 2020 12:01:57 -0400 (EDT)
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
	with ESMTP id hvmCmrBsP+6M; Fri, 29 May 2020 12:01:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BAE9E4B2A3;
	Fri, 29 May 2020 12:01:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6636E4B1F2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 12:01:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DyniKT8Gf9pI for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 May 2020 12:01:49 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 134704B274
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 12:01:47 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3202A2145D;
 Fri, 29 May 2020 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590768106;
 bh=PtgXYMxsBbdXRBCTL48ndwUY3jYZvLqzZqr/d+1pk5I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BS7EqjDsT9wMf3axjFkd2hxFKW8HVeYYu7p10YTlyNWYAmW9wxl0xD2PU+9Jofez3
 jBWB0wMluKofR2V8YawqK7FWMPag/l8/5Lfwjmqx0JJD/yu5bBk+ecmj/qKwrRsG4H
 Bwv5VFDL9gvZHAlS3zjLt99+95cRwYdrZ1N9J+gY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jehS4-00GJKc-Lp; Fri, 29 May 2020 17:01:44 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 06/24] KVM: arm64: Simplify __kvm_timer_set_cntvoff
 implementation
Date: Fri, 29 May 2020 17:01:03 +0100
Message-Id: <20200529160121.899083-7-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529160121.899083-1-maz@kernel.org>
References: <20200529160121.899083-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 ascull@google.com, ardb@kernel.org, christoffer.dall@arm.com,
 dbrazdil@google.com, tabba@google.com, james.morse@arm.com, giangyi@amazon.com,
 zhukeqian1@huawei.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
 will@kernel.org, yuzenghui@huawei.com, julien.thierry.kdev@gmail.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Jiang Yi <giangyi@amazon.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Now that this function isn't constrained by the 32bit PCS,
let's simplify it by taking a single 64bit offset instead
of two 32bit parameters.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_asm.h |  2 +-
 arch/arm64/kvm/arch_timer.c      | 12 +-----------
 arch/arm64/kvm/hyp/timer-sr.c    |  3 +--
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 7c7eeeaab9fa..59e314f38e43 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -64,7 +64,7 @@ extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 extern void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu);
 
-extern void __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high);
+extern void __kvm_timer_set_cntvoff(u64 cntvoff);
 
 extern int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 93bd59b46848..487eba9f87cd 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -451,17 +451,7 @@ static void timer_restore_state(struct arch_timer_context *ctx)
 
 static void set_cntvoff(u64 cntvoff)
 {
-	u32 low = lower_32_bits(cntvoff);
-	u32 high = upper_32_bits(cntvoff);
-
-	/*
-	 * Since kvm_call_hyp doesn't fully support the ARM PCS especially on
-	 * 32-bit systems, but rather passes register by register shifted one
-	 * place (we put the function address in r0/x0), we cannot simply pass
-	 * a 64-bit value as an argument, but have to split the value in two
-	 * 32-bit halves.
-	 */
-	kvm_call_hyp(__kvm_timer_set_cntvoff, low, high);
+	kvm_call_hyp(__kvm_timer_set_cntvoff, cntvoff);
 }
 
 static inline void set_timer_irq_phys_active(struct arch_timer_context *ctx, bool active)
diff --git a/arch/arm64/kvm/hyp/timer-sr.c b/arch/arm64/kvm/hyp/timer-sr.c
index ff76e6845fe4..fb5c0be33223 100644
--- a/arch/arm64/kvm/hyp/timer-sr.c
+++ b/arch/arm64/kvm/hyp/timer-sr.c
@@ -10,9 +10,8 @@
 
 #include <asm/kvm_hyp.h>
 
-void __hyp_text __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high)
+void __hyp_text __kvm_timer_set_cntvoff(u64 cntvoff)
 {
-	u64 cntvoff = (u64)cntvoff_high << 32 | cntvoff_low;
 	write_sysreg(cntvoff, cntvoff_el2);
 }
 
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
