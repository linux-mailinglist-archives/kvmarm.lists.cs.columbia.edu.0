Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA1C32B36F
	for <lists+kvmarm@lfdr.de>; Mon, 27 May 2019 13:46:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2732B4A501;
	Mon, 27 May 2019 07:46:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95kPq-aGlxmi; Mon, 27 May 2019 07:46:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D2C84A4EC;
	Mon, 27 May 2019 07:46:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E02954A4E5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 May 2019 07:46:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uwm4hcvjlT3O for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 May 2019 07:46:26 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AC7494A379
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 May 2019 07:46:26 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A0E230821DF;
 Mon, 27 May 2019 11:46:23 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48CEB1001E60;
 Mon, 27 May 2019 11:46:21 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm/arm64: fix emulated ptimer irq injection
Date: Mon, 27 May 2019 13:46:19 +0200
Message-Id: <20190527114619.16252-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 27 May 2019 11:46:25 +0000 (UTC)
Cc: marc.zyngier@arm.com
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

The emulated ptimer needs to track the level changes, otherwise the
the interrupt will never get deasserted, resulting in the guest getting
stuck in an interrupt storm if it enables ptimer interrupts. This was
found with kvm-unit-tests; the ptimer tests hung as soon as interrupts
were enabled. Typical Linux guests don't have a problem as they prefer
using the virtual timer.

Fixes: bee038a674875 ("KVM: arm/arm64: Rework the timer code to use a timer_map")
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 virt/kvm/arm/arch_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 7fc272ecae16..9f5d8cc8b5e5 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -324,10 +324,15 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
 static void timer_emulate(struct arch_timer_context *ctx)
 {
 	bool should_fire = kvm_timer_should_fire(ctx);
+	struct timer_map map;
+
+	get_timer_map(ctx->vcpu, &map);
 
 	trace_kvm_timer_emulate(ctx, should_fire);
 
-	if (should_fire) {
+	if (ctx == map.emul_ptimer && should_fire != ctx->irq.level) {
+		kvm_timer_update_irq(ctx->vcpu, !ctx->irq.level, ctx);
+	} else if (should_fire) {
 		kvm_timer_update_irq(ctx->vcpu, true, ctx);
 		return;
 	}
-- 
2.18.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
