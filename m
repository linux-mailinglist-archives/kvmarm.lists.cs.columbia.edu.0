Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E958ABF6
	for <lists+kvmarm@lfdr.de>; Fri,  5 Aug 2022 15:58:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E0FFB4E9E6;
	Fri,  5 Aug 2022 09:58:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NUhN71o0jU7s; Fri,  5 Aug 2022 09:58:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BAE9D4E98E;
	Fri,  5 Aug 2022 09:58:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C54A24E90C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Aug 2022 09:58:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rB0W5EpMpuuX for <kvmarm@lists.cs.columbia.edu>;
 Fri,  5 Aug 2022 09:58:22 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BC4534E8E6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Aug 2022 09:58:22 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3289360D35;
 Fri,  5 Aug 2022 13:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B56C433B5;
 Fri,  5 Aug 2022 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659707902;
 bh=dBKvaZDhCi9DouA27myxfAIXtO31NNdUkGySntAyHmM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PLqeAahMT0DLdkL+wxt6tGbWKVBu4Gh9JMSMhBNOQGy0XZeu5CDopiD1uy6m7v4Zv
 yQMeS+diyp7KaFuQRCt5UnYTW/Cptab1cGlW4yq2l22NKaPFY6uJWGjGyzUtkeFbXK
 SQBpeSbXF1XYJzO7MySf3Js3NFsOQyLngJooSvGvOiViaFosD9h/z4eCmSeXt93ZBz
 GbgMrh9W+Q/9nxEKmPIFXMWGOW1Oa65ty1ebYaFtQZ11T5Mo0fc/sArIhVaidGjuwW
 Dkmro6uXHNQzHrVStknR3JvL2QO2IAfITH26poqUU0WHalCRycs8Ez3fWuMRtVf+BD
 hP/J2TwwS/CKA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oJxqF-001AeL-Su;
 Fri, 05 Aug 2022 14:58:19 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 3/9] KVM: arm64: PMU: Only narrow counters that are not 64bit
 wide
Date: Fri,  5 Aug 2022 14:58:07 +0100
Message-Id: <20220805135813.2102034-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220805135813.2102034-1-maz@kernel.org>
References: <20220805135813.2102034-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 ricarkol@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

The current PMU emulation sometimes narrows counters to 32bit
if the counter isn't the cycle counter. As this is going to
change with PMUv3p5 where the counters are all 64bit, only
perform the narrowing on 32bit counters.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/pmu-emul.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 9040d3c80096..0ab6f59f433c 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -149,22 +149,22 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
  */
 static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
 {
-	u64 counter, reg, val;
+	u64 counter, reg;
 
 	if (!pmc->perf_event)
 		return;
 
 	counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
 
-	if (pmc->idx == ARMV8_PMU_CYCLE_IDX) {
+	if (pmc->idx == ARMV8_PMU_CYCLE_IDX)
 		reg = PMCCNTR_EL0;
-		val = counter;
-	} else {
+	else
 		reg = PMEVCNTR0_EL0 + pmc->idx;
-		val = lower_32_bits(counter);
-	}
 
-	__vcpu_sys_reg(vcpu, reg) = val;
+	if (!kvm_pmu_idx_is_64bit(vcpu, pmc->idx))
+		counter = lower_32_bits(counter);
+
+	__vcpu_sys_reg(vcpu, reg) = counter;
 
 	kvm_pmu_release_perf_event(pmc);
 }
@@ -417,7 +417,8 @@ static void kvm_pmu_counter_increment(struct kvm_vcpu *vcpu,
 
 		/* Increment this counter */
 		reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
-		reg = lower_32_bits(reg);
+		if (!kvm_pmu_idx_is_64bit(vcpu, i))
+			reg = lower_32_bits(reg);
 		__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
 
 		if (reg) /* No overflow? move on */
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
