Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 96E6552D48A
	for <lists+kvmarm@lfdr.de>; Thu, 19 May 2022 15:46:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 461194B448;
	Thu, 19 May 2022 09:46:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTUzvUY673m8; Thu, 19 May 2022 09:46:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1172D4B436;
	Thu, 19 May 2022 09:46:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CC804B437
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:46:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jhg9wZnw1S+5 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 May 2022 09:46:02 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2E50B4B3CD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:46:01 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 181F061783;
 Thu, 19 May 2022 13:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3E1C36AE5;
 Thu, 19 May 2022 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652967959;
 bh=cvBKGfWFAbmH68bmeDTUSse0RpVg4TXL+HSHAKVcsow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XQp2SFcckGWaZ9r0J9knvbktkXOKat0vRrw0drOozmkrj5NmVw+v4Z1R1k2SIUxh/
 tZNo0nxM6bw4OZGYXFVFUR2oF9sQ2KLHxFgTEMcna2qXdo7NDaeG3hkx+WH2jsnXiH
 xlxQcV3WCwpZWdkEK6BnY/k5Ca1DblJjAl/yKHX6pct9uCx/nLEZa2UBebBkYHq9JZ
 l0fQFEOiUQMJpeZbA51jyKB3gtseKc8z4xyhtMzLuWBxXsc2mphJwz61qYXJ1cNL/f
 SimpwFLv03rxan7C6ccAVnO/6rzgBCSNmoIIWii5vMFHu+SEutvx5hKD5X4YPZmAmq
 mmtHtc6gGT3FQ==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 54/89] KVM: arm64: Reduce host/shadow vcpu state copying
Date: Thu, 19 May 2022 14:41:29 +0100
Message-Id: <20220519134204.5379-55-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220519134204.5379-1-will@kernel.org>
References: <20220519134204.5379-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-arm-kernel@lists.infradead.org,
 Michael Roth <michael.roth@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Will Deacon <will@kernel.org>
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

When running with pKVM enabled, protected guests run with a fixed CPU
configuration and therefore features such as hardware debug and SVE are
unavailable and their state does not need to be copied from the host
structures on each flush operation. Although non-protected guests do
require the host and shadow structures to be kept in-sync with each
other, we can defer writing back to the host to an explicit sync
hypercall, rather than doing it after every vCPU run.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 228736a9ab40..e82c0faf6c81 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -196,17 +196,18 @@ static void flush_shadow_state(struct kvm_shadow_vcpu_state *shadow_state)
 
 		if (host_flags & KVM_ARM64_PKVM_STATE_DIRTY)
 			__flush_vcpu_state(shadow_state);
-	}
 
-	shadow_vcpu->arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
-	shadow_vcpu->arch.sve_max_vl	= host_vcpu->arch.sve_max_vl;
+		shadow_vcpu->arch.sve_state = kern_hyp_va(host_vcpu->arch.sve_state);
+		shadow_vcpu->arch.sve_max_vl = host_vcpu->arch.sve_max_vl;
 
-	shadow_vcpu->arch.hcr_el2	= host_vcpu->arch.hcr_el2;
-	shadow_vcpu->arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
+		shadow_vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS & ~(HCR_RW | HCR_TWI | HCR_TWE);
+		shadow_vcpu->arch.hcr_el2 |= READ_ONCE(host_vcpu->arch.hcr_el2);
 
-	shadow_vcpu->arch.debug_ptr	= kern_hyp_va(host_vcpu->arch.debug_ptr);
+		shadow_vcpu->arch.mdcr_el2 = host_vcpu->arch.mdcr_el2;
+		shadow_vcpu->arch.debug_ptr = kern_hyp_va(host_vcpu->arch.debug_ptr);
+	}
 
-	shadow_vcpu->arch.vsesr_el2	= host_vcpu->arch.vsesr_el2;
+	shadow_vcpu->arch.vsesr_el2 = host_vcpu->arch.vsesr_el2;
 
 	flush_vgic_state(host_vcpu, shadow_vcpu);
 	flush_timer_state(shadow_state);
@@ -238,10 +239,10 @@ static void sync_shadow_state(struct kvm_shadow_vcpu_state *shadow_state,
 	unsigned long host_flags;
 	u8 esr_ec;
 
-	host_vcpu->arch.ctxt		= shadow_vcpu->arch.ctxt;
-
-	host_vcpu->arch.hcr_el2		= shadow_vcpu->arch.hcr_el2;
-
+	/*
+	 * Don't sync the vcpu GPR/sysreg state after a run. Instead,
+	 * leave it in the shadow until someone actually requires it.
+	 */
 	sync_vgic_state(host_vcpu, shadow_vcpu);
 	sync_timer_state(shadow_state);
 
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
