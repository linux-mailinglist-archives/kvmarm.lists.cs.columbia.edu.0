Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE6454A01
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 16:37:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 126824B134;
	Wed, 17 Nov 2021 10:37:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U89vkYfRxOfL; Wed, 17 Nov 2021 10:37:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A10BE4B125;
	Wed, 17 Nov 2021 10:37:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF2B84B15A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i4ox4+hATyce for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 10:37:23 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E2214B125
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:21 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28576ED1;
 Wed, 17 Nov 2021 07:37:21 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2F9E3F5A1;
 Wed, 17 Nov 2021 07:37:19 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, mark.rutland@arm.com
Subject: [RFC PATCH v5 11/38] KVM: arm64: Print a warning for unexpected
 faults on locked memslots
Date: Wed, 17 Nov 2021 15:38:15 +0000
Message-Id: <20211117153842.302159-12-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117153842.302159-1-alexandru.elisei@arm.com>
References: <20211117153842.302159-1-alexandru.elisei@arm.com>
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

When userspace unmaps a VMA backing a memslot, the corresponding stage 2
address range gets unmapped via the MMU notifiers. This makes it possible
to get stage 2 faults on a locked memslot, which might not be what
userspace wants because the purpose of locking a memslot is to avoid stage
2 faults in the first place.

Addresses being unmapped from stage 2 can happen from other reasons too,
like bugs in the implementation of the lock memslot API, however unlikely
that might seem (or not).

Let's try to make debugging easier by printing a warning when this happens.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/mmu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index bc2a546f65c3..3e9ec646cc34 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1352,6 +1352,27 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	/* Userspace should not be able to register out-of-bounds IPAs */
 	VM_BUG_ON(fault_ipa >= kvm_phys_size(vcpu->kvm));
 
+	if (memslot_is_locked(memslot)) {
+		const char *fault_type_str;
+
+		if (kvm_vcpu_trap_is_exec_fault(vcpu))
+			goto handle_fault;
+
+		if (fault_status == FSC_ACCESS)
+			fault_type_str = "access";
+		else if (write_fault && (memslot->arch.flags & KVM_MEMSLOT_LOCK_WRITE))
+			fault_type_str = "write";
+		else if (!write_fault)
+			fault_type_str = "read";
+		else
+			goto handle_fault;
+
+		kvm_warn_ratelimited("Unexpected L2 %s fault on locked memslot %d: IPA=%#llx, ESR_EL2=%#08x]\n",
+				     fault_type_str, memslot->id, fault_ipa,
+				     kvm_vcpu_get_esr(vcpu));
+	}
+
+handle_fault:
 	if (fault_status == FSC_ACCESS) {
 		handle_access_fault(vcpu, fault_ipa);
 		ret = 1;
-- 
2.33.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
