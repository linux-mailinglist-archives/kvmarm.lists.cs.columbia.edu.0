Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 55542A4C38
	for <lists+kvmarm@lfdr.de>; Sun,  1 Sep 2019 23:13:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F0AB64A593;
	Sun,  1 Sep 2019 17:13:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-KoKzY29Tvl; Sun,  1 Sep 2019 17:13:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6C094A5A2;
	Sun,  1 Sep 2019 17:13:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B5D64A55D
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Sep 2019 17:13:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9i3qle51YMnQ for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 Sep 2019 17:13:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2386B4A4F6
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Sep 2019 17:13:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E29DE15A2;
 Sun,  1 Sep 2019 14:13:00 -0700 (PDT)
Received: from why.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABBDD3F77D;
 Sun,  1 Sep 2019 14:12:59 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
Subject: [PATCH 3/3] arm64: KVM: Kill hyp_alternate_select()
Date: Sun,  1 Sep 2019 22:12:37 +0100
Message-Id: <20190901211237.11673-4-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190901211237.11673-1-maz@kernel.org>
References: <20190901211237.11673-1-maz@kernel.org>
MIME-Version: 1.0
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

hyp_alternate_select() is now completely unused. Goodbye.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 86825aa20852..97f21cc66657 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -47,30 +47,6 @@
 #define read_sysreg_el2(r)	read_sysreg_elx(r, _EL2, _EL1)
 #define write_sysreg_el2(v,r)	write_sysreg_elx(v, r, _EL2, _EL1)
 
-/**
- * hyp_alternate_select - Generates patchable code sequences that are
- * used to switch between two implementations of a function, depending
- * on the availability of a feature.
- *
- * @fname: a symbol name that will be defined as a function returning a
- * function pointer whose type will match @orig and @alt
- * @orig: A pointer to the default function, as returned by @fname when
- * @cond doesn't hold
- * @alt: A pointer to the alternate function, as returned by @fname
- * when @cond holds
- * @cond: a CPU feature (as described in asm/cpufeature.h)
- */
-#define hyp_alternate_select(fname, orig, alt, cond)			\
-typeof(orig) * __hyp_text fname(void)					\
-{									\
-	typeof(alt) *val = orig;					\
-	asm volatile(ALTERNATIVE("nop		\n",			\
-				 "mov	%0, %1	\n",			\
-				 cond)					\
-		     : "+r" (val) : "r" (alt));				\
-	return val;							\
-}
-
 int __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu);
 
 void __vgic_v3_save_state(struct kvm_vcpu *vcpu);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
