Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A36164CCCC
	for <lists+kvmarm@lfdr.de>; Thu, 20 Jun 2019 13:23:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5176C4A4FA;
	Thu, 20 Jun 2019 07:23:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VKiy-f1XpF4E; Thu, 20 Jun 2019 07:23:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A8014A4F6;
	Thu, 20 Jun 2019 07:23:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F2DD4A4F0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 07:23:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3q7+URMQMvF2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Jun 2019 07:23:13 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D4744A379
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 07:23:13 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7EA8C0A;
 Thu, 20 Jun 2019 04:23:12 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57FE23F718;
 Thu, 20 Jun 2019 04:23:11 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 1/4] KVM: arm64: Implement vq_present() as a macro
Date: Thu, 20 Jun 2019 12:22:58 +0100
Message-Id: <20190620112301.138137-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620112301.138137-1-marc.zyngier@arm.com>
References: <20190620112301.138137-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Dave Martin <Dave.Martin@arm.com>,
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

From: Viresh Kumar <viresh.kumar@linaro.org>

This routine is a one-liner and doesn't really need to be function and
can be implemented as a macro.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/guest.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 3ae2f82fca46..ae734fcfd4ea 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -207,13 +207,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
-
-static bool vq_present(
-	const u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
-	unsigned int vq)
-{
-	return (*vqs)[vq_word(vq)] & vq_mask(vq);
-}
+#define vq_present(vqs, vq) ((vqs)[vq_word(vq)] & vq_mask(vq))
 
 static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
@@ -258,7 +252,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 	max_vq = 0;
 	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; ++vq)
-		if (vq_present(&vqs, vq))
+		if (vq_present(vqs, vq))
 			max_vq = vq;
 
 	if (max_vq > sve_vq_from_vl(kvm_sve_max_vl))
@@ -272,7 +266,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	 * maximum:
 	 */
 	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
-		if (vq_present(&vqs, vq) != sve_vq_available(vq))
+		if (vq_present(vqs, vq) != sve_vq_available(vq))
 			return -EINVAL;
 
 	/* Can't run with no vector lengths at all: */
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
