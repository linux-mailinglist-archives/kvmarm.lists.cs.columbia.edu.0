Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8F035258F23
	for <lists+kvmarm@lfdr.de>; Tue,  1 Sep 2020 15:33:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43BE44B29D;
	Tue,  1 Sep 2020 09:33:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TVrb0MiuBqF; Tue,  1 Sep 2020 09:33:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D97E4B297;
	Tue,  1 Sep 2020 09:33:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D2A5C4B090
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 09:33:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XKvPo6Pwpz6x for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Sep 2020 09:33:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B51044B0F4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 09:33:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65840113E;
 Tue,  1 Sep 2020 06:33:01 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C3EF3F66F;
 Tue,  1 Sep 2020 06:33:00 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 1/2] KVM: arm64: Update page shift if stage 2 block mapping
 not supported
Date: Tue,  1 Sep 2020 14:33:56 +0100
Message-Id: <20200901133357.52640-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901133357.52640-1-alexandru.elisei@arm.com>
References: <20200901133357.52640-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: maz@kernel.org
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

Commit 196f878a7ac2e (" KVM: arm/arm64: Signal SIGBUS when stage2 discovers
hwpoison memory") modifies user_mem_abort() to send a SIGBUS signal when
the fault IPA maps to a hwpoisoned page. Commit 1559b7583ff6 ("KVM:
arm/arm64: Re-check VMA on detecting a poisoned page") changed
kvm_send_hwpoison_signal() to use the page shift instead of the VMA because
at that point the code had already released the mmap lock, which means
userspace could have modified the VMA.

If userspace uses hugetlbfs for the VM memory, user_mem_abort() tries to
map the guest fault IPA using block mappings in stage 2. That is not always
possible, if, for example, userspace uses dirty page logging for the VM.
Update the page shift appropriately in those cases when we downgrade the
stage 2 entry from a block mapping to a page.

Fixes: 1559b7583ff6 ("KVM: arm/arm64: Re-check VMA on detecting a poisoned page")
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ba00bcc0c884..25e7dc52c086 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1877,6 +1877,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	    !fault_supports_stage2_huge_mapping(memslot, hva, vma_pagesize)) {
 		force_pte = true;
 		vma_pagesize = PAGE_SIZE;
+		vma_shift = PAGE_SHIFT;
 	}
 
 	/*
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
