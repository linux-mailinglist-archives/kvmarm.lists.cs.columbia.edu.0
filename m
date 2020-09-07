Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F1ED125FCF8
	for <lists+kvmarm@lfdr.de>; Mon,  7 Sep 2020 17:24:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A58294B51F;
	Mon,  7 Sep 2020 11:24:44 -0400 (EDT)
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
	with ESMTP id K5zYD6AEA4La; Mon,  7 Sep 2020 11:24:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D76D4B543;
	Mon,  7 Sep 2020 11:24:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2213C4B4DD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 11:24:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H6gkWyuOMQA4 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Sep 2020 11:24:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 229F24B537
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 11:24:41 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B714217A0;
 Mon,  7 Sep 2020 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599492280;
 bh=J9c/PRVLg9vkAq63DkWstIMWTum17tiCiANXLCxWIlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c/0egv5uey+6gJL99E6FnWbZUPEJY0G20thVR1b2doLdU4AQjOcUHlNeid2LbZLTR
 R3GuOvoSR4cXoBX5V2c34MeoauDws4Oy2AsXrkiyaOn86BpzcNF71mB8JRNvNpqs3O
 TGs4FtPctU3hY9sQKev1MNJCfa2oc1DvVcOphCfE=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 20/21] KVM: arm64: Remove unused 'pgd' field from 'struct
 kvm_s2_mmu'
Date: Mon,  7 Sep 2020 16:23:43 +0100
Message-Id: <20200907152344.12978-21-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907152344.12978-1-will@kernel.org>
References: <20200907152344.12978-1-will@kernel.org>
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

The stage-2 page-tables are entirely encapsulated by the 'pgt' field of
'struct kvm_s2_mmu', so remove the unused 'pgd' field.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 1 -
 arch/arm64/kvm/mmu.c              | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0b7c702b2151..41caf29bd93c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -79,7 +79,6 @@ struct kvm_s2_mmu {
 	 * for vEL1/EL0 with vHCR_EL2.VM == 0.  In that case, we use the
 	 * canonical stage-2 page tables.
 	 */
-	pgd_t		*pgd;
 	phys_addr_t	pgd_phys;
 	struct kvm_pgtable *pgt;
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ba27eb537e9d..1041be1fafe4 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -389,7 +389,6 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	mmu->kvm = kvm;
 	mmu->pgt = pgt;
 	mmu->pgd_phys = __pa(pgt->pgd);
-	mmu->pgd = (void *)pgt->pgd;
 	mmu->vmid.vmid_gen = 0;
 	return 0;
 
@@ -475,7 +474,6 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 	spin_lock(&kvm->mmu_lock);
 	pgt = mmu->pgt;
 	if (pgt) {
-		mmu->pgd = NULL;
 		mmu->pgd_phys = 0;
 		mmu->pgt = NULL;
 		free_percpu(mmu->last_vcpu_ran);
-- 
2.28.0.526.ge36021eeef-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
