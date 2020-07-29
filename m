Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8431E231CAE
	for <lists+kvmarm@lfdr.de>; Wed, 29 Jul 2020 12:28:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 379154B590;
	Wed, 29 Jul 2020 06:28:36 -0400 (EDT)
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
	with ESMTP id PAUqLFq-5oqL; Wed, 29 Jul 2020 06:28:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15D9E4B582;
	Wed, 29 Jul 2020 06:28:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C855C4B548
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Jul 2020 06:28:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgBQ1DaOWdFF for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Jul 2020 06:28:32 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6CCFD4B552
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Jul 2020 06:28:32 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 439B8206D4;
 Wed, 29 Jul 2020 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596018511;
 bh=LYlPZd8d9yHn5jCIMkg56g8w4VoNaOxcimdZZswPGLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ulqa/g5kQNPcj8sM7Eir9ygH/dn4MFiEXvmJHvAzK2hAfrrxbrbMBd+J1utcgPqQN
 xg+dCZ6w8uTn3VcYO8y31B4Wl/i+mFKNCZxNZyVVB+veDSYmfciFvqVUzPrqObQPcA
 Hzt0EJimviDn2FjduiePIC5mejr22UqnYzuoo33I=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 3/4] KVM: arm64: Don't skip cache maintenance for read-only
 memslots
Date: Wed, 29 Jul 2020 11:28:20 +0100
Message-Id: <20200729102821.23392-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200729102821.23392-1-will@kernel.org>
References: <20200729102821.23392-1-will@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

If a guest performs cache maintenance on a read-only memslot, we should
inform userspace rather than skip the instruction altogether.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 96d995a1ef68..4150bce3d0b6 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2121,7 +2121,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * So let's assume that the guest is just being
 		 * cautious, and skip the instruction.
 		 */
-		if (kvm_vcpu_dabt_is_cm(vcpu)) {
+		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
 			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 			ret = 1;
 			goto out_unlock;
-- 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
