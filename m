Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 693CB3EC66D
	for <lists+kvmarm@lfdr.de>; Sun, 15 Aug 2021 03:02:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CDFB4B086;
	Sat, 14 Aug 2021 21:02:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzYeAP94LXCn; Sat, 14 Aug 2021 21:02:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F4324AED4;
	Sat, 14 Aug 2021 21:02:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3757C49FE6
 for <kvmarm@lists.cs.columbia.edu>; Sat, 14 Aug 2021 21:02:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ilXAJZYDZlZv for <kvmarm@lists.cs.columbia.edu>;
 Sat, 14 Aug 2021 21:02:05 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EFD649E93
 for <kvmarm@lists.cs.columbia.edu>; Sat, 14 Aug 2021 21:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628989325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Pn+9Bhmey0hAJUvL54jnfu+eDSYV7uNB+RaNeR8i2I=;
 b=B9Y7EUuQziDpAMd4YCTey++zYqfdsW9KbohX5tjv6e3RwoeNposrZ5B63oSvHdq/OTMYBc
 6qCSCUKIncAnCFqNmVxld8ZNPPAfKSzDSPeztaZdeC2P6XfYI91+Z2wNKl+D70RvOPmnG8
 EAgkMIuazqG6p9CbSsQDe7JlV6kzYzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-OEe-63RQMAGNWMCf71IHyA-1; Sat, 14 Aug 2021 21:02:03 -0400
X-MC-Unique: OEe-63RQMAGNWMCf71IHyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F82A1008062;
 Sun, 15 Aug 2021 01:02:02 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F316260C59;
 Sun, 15 Aug 2021 01:01:53 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 04/15] KVM: x86: Use generic async PF slot management
Date: Sun, 15 Aug 2021 08:59:36 +0800
Message-Id: <20210815005947.83699-5-gshan@redhat.com>
In-Reply-To: <20210815005947.83699-1-gshan@redhat.com>
References: <20210815005947.83699-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org
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

This uses the generic slot management mechanism for asynchronous
page fault by enabling CONFIG_KVM_ASYNC_PF_SLOT because the private
implementation is totally duplicate to the generic one.

The changes introduced by this is pretty mechanical and shouldn't
cause any logical changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 -
 arch/x86/kvm/Kconfig            |  1 +
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/x86.c              | 86 +++------------------------------
 4 files changed, 8 insertions(+), 83 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 974cbfb1eefe..409c1e7137cd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -810,7 +810,6 @@ struct kvm_vcpu_arch {
 
 	struct {
 		bool halted;
-		gfn_t gfns[ASYNC_PF_PER_VCPU];
 		struct gfn_to_hva_cache data;
 		u64 msr_en_val; /* MSR_KVM_ASYNC_PF_EN */
 		u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
@@ -1878,7 +1877,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
 			       struct kvm_async_pf *work);
 void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu);
 bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
-extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index ac69894eab88..53a6ef30b6ee 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -32,6 +32,7 @@ config KVM
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_EVENTFD
 	select KVM_ASYNC_PF
+	select KVM_ASYNC_PF_SLOT
 	select USER_RETURN_NOTIFIER
 	select KVM_MMIO
 	select SCHED_INFO
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c4f4fa23320e..cd8aaa662ac2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3799,7 +3799,7 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 
 	if (!prefault && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(cr2_or_gpa, gfn);
-		if (kvm_find_async_pf_gfn(vcpu, gfn)) {
+		if (kvm_async_pf_find_slot(vcpu, gfn)) {
 			trace_kvm_async_pf_doublefault(cr2_or_gpa, gfn);
 			kvm_make_request(KVM_REQ_APF_HALT, vcpu);
 			return true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7f35d9324b99..a5f7d6122178 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -332,13 +332,6 @@ static struct kmem_cache *kvm_alloc_emulator_cache(void)
 
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
-static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
-{
-	int i;
-	for (i = 0; i < ASYNC_PF_PER_VCPU; i++)
-		vcpu->arch.apf.gfns[i] = ~0;
-}
-
 static void kvm_on_user_return(struct user_return_notifier *urn)
 {
 	unsigned slot;
@@ -854,7 +847,7 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
 {
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
+		kvm_async_pf_reset_slot(vcpu);
 	}
 
 	if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
@@ -3118,7 +3111,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 
 	if (!kvm_pv_async_pf_enabled(vcpu)) {
 		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
+		kvm_async_pf_reset_slot(vcpu);
 		return 0;
 	}
 
@@ -10704,7 +10697,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
-	kvm_async_pf_hash_reset(vcpu);
+	kvm_async_pf_reset_slot(vcpu);
 	kvm_pmu_init(vcpu);
 
 	vcpu->arch.pending_external_vector = -1;
@@ -10828,7 +10821,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvmclock_reset(vcpu);
 
 	kvm_clear_async_pf_completion_queue(vcpu);
-	kvm_async_pf_hash_reset(vcpu);
+	kvm_async_pf_reset_slot(vcpu);
 	vcpu->arch.apf.halted = false;
 
 	if (vcpu->arch.guest_fpu && kvm_mpx_supported()) {
@@ -11737,73 +11730,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
 }
 
-static inline u32 kvm_async_pf_hash_fn(gfn_t gfn)
-{
-	BUILD_BUG_ON(!is_power_of_2(ASYNC_PF_PER_VCPU));
-
-	return hash_32(gfn & 0xffffffff, order_base_2(ASYNC_PF_PER_VCPU));
-}
-
-static inline u32 kvm_async_pf_next_probe(u32 key)
-{
-	return (key + 1) & (ASYNC_PF_PER_VCPU - 1);
-}
-
-static void kvm_add_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	u32 key = kvm_async_pf_hash_fn(gfn);
-
-	while (vcpu->arch.apf.gfns[key] != ~0)
-		key = kvm_async_pf_next_probe(key);
-
-	vcpu->arch.apf.gfns[key] = gfn;
-}
-
-static u32 kvm_async_pf_gfn_slot(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	int i;
-	u32 key = kvm_async_pf_hash_fn(gfn);
-
-	for (i = 0; i < ASYNC_PF_PER_VCPU &&
-		     (vcpu->arch.apf.gfns[key] != gfn &&
-		      vcpu->arch.apf.gfns[key] != ~0); i++)
-		key = kvm_async_pf_next_probe(key);
-
-	return key;
-}
-
-bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	return vcpu->arch.apf.gfns[kvm_async_pf_gfn_slot(vcpu, gfn)] == gfn;
-}
-
-static void kvm_del_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	u32 i, j, k;
-
-	i = j = kvm_async_pf_gfn_slot(vcpu, gfn);
-
-	if (WARN_ON_ONCE(vcpu->arch.apf.gfns[i] != gfn))
-		return;
-
-	while (true) {
-		vcpu->arch.apf.gfns[i] = ~0;
-		do {
-			j = kvm_async_pf_next_probe(j);
-			if (vcpu->arch.apf.gfns[j] == ~0)
-				return;
-			k = kvm_async_pf_hash_fn(vcpu->arch.apf.gfns[j]);
-			/*
-			 * k lies cyclically in ]i,j]
-			 * |    i.k.j |
-			 * |....j i.k.| or  |.k..j i...|
-			 */
-		} while ((i <= j) ? (i < k && k <= j) : (i < k || k <= j));
-		vcpu->arch.apf.gfns[i] = vcpu->arch.apf.gfns[j];
-		i = j;
-	}
-}
-
 static inline int apf_put_user_notpresent(struct kvm_vcpu *vcpu)
 {
 	u32 reason = KVM_PV_REASON_PAGE_NOT_PRESENT;
@@ -11867,7 +11793,7 @@ bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 	struct x86_exception fault;
 
 	trace_kvm_async_pf_not_present(work->arch.token, work->cr2_or_gpa);
-	kvm_add_async_pf_gfn(vcpu, work->arch.gfn);
+	kvm_async_pf_add_slot(vcpu, work->arch.gfn);
 
 	if (kvm_can_deliver_async_pf(vcpu) &&
 	    !apf_put_user_notpresent(vcpu)) {
@@ -11904,7 +11830,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 	if (work->wakeup_all)
 		work->arch.token = ~0; /* broadcast wakeup */
 	else
-		kvm_del_async_pf_gfn(vcpu, work->arch.gfn);
+		kvm_async_pf_remove_slot(vcpu, work->arch.gfn);
 	trace_kvm_async_pf_ready(work->arch.token, work->cr2_or_gpa);
 
 	if ((work->wakeup_all || work->notpresent_injected) &&
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
