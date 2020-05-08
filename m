Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C58441CAA56
	for <lists+kvmarm@lfdr.de>; Fri,  8 May 2020 14:11:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 784084B1CF;
	Fri,  8 May 2020 08:11:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AETr0Gzh81Sz; Fri,  8 May 2020 08:11:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43AE74B1C2;
	Fri,  8 May 2020 08:11:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 302EC4B583
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 23:31:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sAY4Z6m+RaXd for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 May 2020 23:31:04 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 43E964B582
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 23:31:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588908664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOxS8qUh1P601xhSbaR+Vu3Pd0b4Lw9cqUexthKtkJg=;
 b=coTi/0SvN7TAEt20wSqlJfovMtO1mS1g5PlDNpG6LXVEhpWKMm7P2iPcYarw6AzGi/1e29
 n1CMvIf80290aqK1vTT7ohloJENzorR4UOLYHOAZdxV5mioBTjRQleDRuorqpwrcPqCbEI
 UD1MP0KBeVOlZBYy3F82B/Mi1cTHY8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-U2Rao8xiNb2Hn3U1HK1l_A-1; Thu, 07 May 2020 23:30:59 -0400
X-MC-Unique: U2Rao8xiNb2Hn3U1HK1l_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B041895A29;
 Fri,  8 May 2020 03:30:58 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-199.bne.redhat.com
 [10.64.54.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8109699CF;
 Fri,  8 May 2020 03:30:51 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH RFCv2 6/9] kvm/arm64: Export kvm_handle_user_mem_abort() with
 prefault mode
Date: Fri,  8 May 2020 13:29:16 +1000
Message-Id: <20200508032919.52147-7-gshan@redhat.com>
In-Reply-To: <20200508032919.52147-1-gshan@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mailman-Approved-At: Fri, 08 May 2020 08:11:07 -0400
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

This renames user_mem_abort() to kvm_handle_user_mem_abort(), and
then export it. The function will be used in asynchronous page fault
to populate a page table entry once the corresponding page is populated
from the backup device (e.g. swap partition):

   * Parameter @fault_status is replace by @esr.
   * The parameters are reorder based on their importance.

This shouldn't cause any functional changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  4 ++++
 virt/kvm/arm/mmu.c                | 14 ++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 32c8a675e5a4..f77c706777ec 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -437,6 +437,10 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
+int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu, unsigned int esr,
+			      struct kvm_memory_slot *memslot,
+			      phys_addr_t fault_ipa, unsigned long hva,
+			      bool prefault);
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e462e0368fd9..95aaabb2b1fc 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1656,12 +1656,12 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
 	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
 }
 
-static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  unsigned long fault_status)
+int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu, unsigned int esr,
+			      struct kvm_memory_slot *memslot,
+			      phys_addr_t fault_ipa, unsigned long hva,
+			      bool prefault)
 {
-	int ret;
-	u32 esr = kvm_vcpu_get_esr(vcpu);
+	unsigned int fault_status = kvm_vcpu_trap_get_fault_type(esr);
 	bool write_fault, writable, force_pte = false;
 	bool exec_fault, needs_exec;
 	unsigned long mmu_seq;
@@ -1674,6 +1674,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	pgprot_t mem_type = PAGE_S2;
 	bool logging_active = memslot_is_logging(memslot);
 	unsigned long vma_pagesize, flags = 0;
+	int ret;
 
 	write_fault = kvm_is_write_fault(esr);
 	exec_fault = kvm_vcpu_trap_is_iabt(esr);
@@ -1995,7 +1996,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		goto out_unlock;
 	}
 
-	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
+	ret = kvm_handle_user_mem_abort(vcpu, esr, memslot,
+					fault_ipa, hva, false);
 	if (ret == 0)
 		ret = 1;
 out:
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
