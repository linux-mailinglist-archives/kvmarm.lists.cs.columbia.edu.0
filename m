Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B61A857604
	for <lists+kvmarm@lfdr.de>; Thu, 27 Jun 2019 02:35:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C5E34A50C;
	Wed, 26 Jun 2019 20:35:29 -0400 (EDT)
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
	with ESMTP id Qp9ngsUnIkbv; Wed, 26 Jun 2019 20:35:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F73C4A4FC;
	Wed, 26 Jun 2019 20:35:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CA9C4A4F0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jun 2019 20:35:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gX1V-tvDAEe6 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jun 2019 20:35:26 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3DC574A49F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jun 2019 20:35:26 -0400 (EDT)
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63E40217F4;
 Thu, 27 Jun 2019 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561595725;
 bh=fpOF9X+K6MX51S2lgAmlVhrDgGS7QuhMNiVq3/Zuy0M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PnMtstHAOnK/+cYq3j/SygXW6dTPlCktQVE/4TRnwFzA1IQE/u00bggRs+ttYmiQ7
 c55GIMHbAe+zBaJLhtkB6h2YcNOOTG19ydgWKxoiD+lHqtBJeD+GObNonx4CV5OOvY
 jYQp+OZu7/K65vijQtfgmCtxAPNjQypIhk5Jg1Xc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 93/95] KVM: arm/arm64: Fix emulated ptimer irq
 injection
Date: Wed, 26 Jun 2019 20:30:18 -0400
Message-Id: <20190627003021.19867-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Marc Zyngier <marc.zyngier@arm.com>, Sasha Levin <sashal@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

From: Andrew Jones <drjones@redhat.com>

[ Upstream commit e4e5a865e9a9e8e47ac1959b629e9f3ae3b062f2 ]

The emulated ptimer needs to track the level changes, otherwise the
the interrupt will never get deasserted, resulting in the guest getting
stuck in an interrupt storm if it enables ptimer interrupts. This was
found with kvm-unit-tests; the ptimer tests hung as soon as interrupts
were enabled. Typical Linux guests don't have a problem as they prefer
using the virtual timer.

Fixes: bee038a674875 ("KVM: arm/arm64: Rework the timer code to use a timer_map")
Signed-off-by: Andrew Jones <drjones@redhat.com>
[Simplified the patch to res we only care about emulated timers here]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/arch_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 7fc272ecae16..1b1c449ceaf4 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -321,14 +321,15 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
 	}
 }
 
+/* Only called for a fully emulated timer */
 static void timer_emulate(struct arch_timer_context *ctx)
 {
 	bool should_fire = kvm_timer_should_fire(ctx);
 
 	trace_kvm_timer_emulate(ctx, should_fire);
 
-	if (should_fire) {
-		kvm_timer_update_irq(ctx->vcpu, true, ctx);
+	if (should_fire != ctx->irq.level) {
+		kvm_timer_update_irq(ctx->vcpu, should_fire, ctx);
 		return;
 	}
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
