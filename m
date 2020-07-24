Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 661AE22C81C
	for <lists+kvmarm@lfdr.de>; Fri, 24 Jul 2020 16:35:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 13F864A524;
	Fri, 24 Jul 2020 10:35:22 -0400 (EDT)
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
	with ESMTP id KLligWr1hmGZ; Fri, 24 Jul 2020 10:35:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8C1A4B4CE;
	Fri, 24 Jul 2020 10:35:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14C984B4AC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jul 2020 10:35:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ll-fCdq2vktr for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Jul 2020 10:35:19 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2EED84B418
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jul 2020 10:35:19 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ECCED2078D;
 Fri, 24 Jul 2020 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595601318;
 bh=1bIUieX2HmjuBqC9V0MncwzHE+Mu6QjPYz3OPP1AvzQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r1uRDTfX6y7a7Bu27IHDDtliTwi9q17DC0oH/zu8/vm4b6qbG2iKwVFPun2irduAM
 2J5YLekWU7/CBiHXctu0+sYiYm3UqBT5yZPWPGCKOHqFKsXT2qjkAoAVbrMsiBJHns
 nu3P14AIsSE/spmB2mJbOxBXebmxAVMPA/ddndcc=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 3/7] KVM: arm64: Handle data and instruction external aborts
 the same way
Date: Fri, 24 Jul 2020 15:35:02 +0100
Message-Id: <20200724143506.17772-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724143506.17772-1-will@kernel.org>
References: <20200724143506.17772-1-will@kernel.org>
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

If the guest generates a synchronous external abort which is not handled
by the host, we inject it back into the guest as a virtual SError, but
only if the original fault was reported on the data side. Instruction
faults are reported as "Unsupported FSC", causing the vCPU run loop to
bail with -EFAULT.

Although synchronous external aborts from a guest are pretty unusual,
treat them the same regardless of whether they are taken as data or
instruction aborts by EL2.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 660a83a172e4..ae17a99243e2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2079,13 +2079,10 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * For RAS the host kernel may handle this abort.
 		 * There is no need to pass the error into the guest.
 		 */
-		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
-			return 1;
-
-		if (unlikely(!is_iabt)) {
+		if (kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
 			kvm_inject_vabt(vcpu);
-			return 1;
-		}
+
+		return 1;
 	}
 
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
-- 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
