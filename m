Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D84EA4E3A29
	for <lists+kvmarm@lfdr.de>; Tue, 22 Mar 2022 09:10:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 886A549ED7;
	Tue, 22 Mar 2022 04:10:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6t4dvSVXIcYb; Tue, 22 Mar 2022 04:10:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B0D0D49F00;
	Tue, 22 Mar 2022 04:10:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C25C940CDE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:10:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IrixYPDUBSWD for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Mar 2022 04:10:00 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 469A240BE7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:10:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647936600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDLPhdNil8yIekdEaTNLezmS6s9ralEFlQuei0yDjLk=;
 b=aP7MfD65gFuhwLTC7LlM6ZYFyQaBRZLoYu8lo/XKqXQ7lrTHUOJWFTLvE92gqCjo28qrZe
 XjTjU/3FVkncz6dn1bWLeLajNJDn+lEFy1G9uaPtLgb7uLcbeOUVXM2LzZs4nO5UrVtj6F
 Nrtx1gegcnITx1SmzuxZr2pafjp7gqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-mY_uTFJ6PLWkyTLln4adnw-1; Tue, 22 Mar 2022 04:09:58 -0400
X-MC-Unique: mY_uTFJ6PLWkyTLln4adnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8331801585;
 Tue, 22 Mar 2022 08:09:57 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 177A81121324;
 Tue, 22 Mar 2022 08:09:51 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 14/22] KVM: arm64: Support SDEI event injection,
 delivery and cancellation
Date: Tue, 22 Mar 2022 16:07:02 +0800
Message-Id: <20220322080710.51727-15-gshan@redhat.com>
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
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

This supports SDEI event injection, delivery and cancellation. The
SDEI event is injected by kvm_sdei_inject_event(). The injected
event can be cancelled by kvm_sdei_cancel_event() before it's
delivered and handled.

KVM_REQ_SDEI request becomes pending once the SDEI event is injected
and kvm_sdei_deliver_event() is called to accommodate the request.
The injected SDEI event is delivered and handled in this way. The
context for execution is switched like below:

   * x0 - x17 are saved. All of them are cleared except the following
     registers:

     x0: SDEI event number
     x1: user argument associated with the SDEI event
     x2: PC of the interrupted or preempted context
     x3: PSTATE of the interrupted or preempted context

   * PC is set to the handler of the SDEI event, which was provided
     during its registration. PSTATE is modified according to the
     SDEI specification.

   * The SDEI event with normal priority can be preempted by that
     with critical priority. However, no one can preempt the SDEI
     event with critical event.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/include/asm/kvm_sdei.h |   4 +
 arch/arm64/kvm/arm.c              |   3 +
 arch/arm64/kvm/sdei.c             | 284 ++++++++++++++++++++++++++++++
 4 files changed, 292 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5d37e046a458..e2762d08ab1c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -46,6 +46,7 @@
 #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
 #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
 #define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
+#define KVM_REQ_SDEI		KVM_ARCH_REQ(6)
 
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 6f58a846d05c..54c730acd298 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -165,6 +165,10 @@ KVM_SDEI_REGISTERED_EVENT_FUNC(unregister_pending)
 void kvm_sdei_init_vm(struct kvm *kvm);
 void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
+int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
+			  unsigned long num, bool immediate);
+int kvm_sdei_cancel_event(struct kvm_vcpu *vcpu, unsigned long num);
+void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vm(struct kvm *kvm);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 96fcae5beee4..00c136a6e8df 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -734,6 +734,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
 			kvm_reset_vcpu(vcpu);
 
+		if (kvm_check_request(KVM_REQ_SDEI, vcpu))
+			kvm_sdei_deliver_event(vcpu);
+
 		/*
 		 * Clear IRQ_PENDING requests that were made to guarantee
 		 * that a VCPU sees new virtual interrupts.
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 1e0ca9022eaa..a24270378305 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -43,6 +43,25 @@ find_registered_event(struct kvm *kvm, unsigned long num)
 	return NULL;
 }
 
+static struct kvm_sdei_vcpu_event *
+find_vcpu_event(struct kvm_vcpu *vcpu, unsigned long num)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *vcpu_event;
+
+	list_for_each_entry(vcpu_event, &vsdei->critical_events, link) {
+		if (vcpu_event->state.num == num)
+			return vcpu_event;
+	}
+
+	list_for_each_entry(vcpu_event, &vsdei->normal_events, link) {
+		if (vcpu_event->state.num == num)
+			return vcpu_event;
+	}
+
+	return NULL;
+}
+
 static void remove_all_exposed_events(struct kvm *kvm)
 {
 	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
@@ -637,6 +656,76 @@ static unsigned long hypercall_mask(struct kvm_vcpu *vcpu, bool mask)
 	return ret;
 }
 
+static int do_inject_event(struct kvm_vcpu *vcpu,
+			   struct kvm_sdei_registered_event *registered_event,
+			   bool immediate)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_vcpu_event *vcpu_event;
+	unsigned int vcpu_event_count;
+
+	/*
+	 * In some cases, the injected event is expected to be delivered
+	 * immediately. However, there are two cases the injected event
+	 * can't be delivered immediately: (a) the injected event is a
+	 * critical one, but we already have pending critical events for
+	 * delivery. (b) the injected event is a normal one, but we have
+	 * pending events for delivery, regardless of their priorities.
+	 */
+	exposed_event = registered_event->exposed_event;
+	if (immediate) {
+		vcpu_event_count = vsdei->critical_event_count;
+		if (kvm_sdei_is_normal(exposed_event->state.priority))
+			vcpu_event_count += vsdei->normal_event_count;
+
+		if (vcpu_event_count > 0)
+			return -ENOSPC;
+	}
+
+	/* Check if the vcpu event exists */
+	vcpu_event = find_vcpu_event(vcpu, registered_event->state.num);
+	if (vcpu_event) {
+		vcpu_event->state.event_count++;
+		kvm_make_request(KVM_REQ_SDEI, vcpu);
+		return 0;
+	}
+
+	/* Check if the count of vcpu event instances exceeds the limit */
+	vcpu_event_count = vsdei->critical_event_count +
+			   vsdei->normal_event_count;
+	if (vcpu_event_count >= KVM_SDEI_MAX_EVENTS)
+		return -ERANGE;
+
+	/* Allocate the vcpu event */
+	vcpu_event = kzalloc(sizeof(*vcpu_event), GFP_KERNEL_ACCOUNT);
+	if (!vcpu_event)
+		return -ENOMEM;
+
+	/*
+	 * We should take lock to update the registered event because its
+	 * reference count might be zero. In that case, the registered event
+	 * could be released.
+	 */
+	vcpu_event->state.num         = registered_event->state.num;
+	vcpu_event->state.event_count = 1;
+	vcpu_event->vcpu              = vcpu;
+	vcpu_event->registered_event  = registered_event;
+
+	registered_event->vcpu_event_count++;
+	if (kvm_sdei_is_critical(exposed_event->state.priority)) {
+		list_add_tail(&vcpu_event->link, &vsdei->critical_events);
+		vsdei->critical_event_count++;
+	} else {
+		list_add_tail(&vcpu_event->link, &vsdei->normal_events);
+		vsdei->normal_event_count++;
+	}
+
+	kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+	return 0;
+}
+
 static unsigned long hypercall_reset(struct kvm_vcpu *vcpu, bool private)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -761,6 +850,201 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
+			  unsigned long num,
+			  bool immediate)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event = NULL;
+	struct kvm_sdei_registered_event *registered_event = NULL;
+	int index, ret = 0;
+
+	if (!(ksdei && vsdei)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (!kvm_sdei_is_supported(num)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+
+	/* Check if the registered event exists */
+	registered_event = find_registered_event(kvm, num);
+	if (!registered_event) {
+		ret = -ENOENT;
+		goto unlock_kvm;
+	}
+
+	/* Check if the event has been registered and enabled */
+	exposed_event = registered_event->exposed_event;
+	index = kvm_sdei_vcpu_index(vcpu, exposed_event);
+	if (!kvm_sdei_is_registered(registered_event, index) ||
+	    !kvm_sdei_is_enabled(registered_event, index) ||
+	    kvm_sdei_is_unregister_pending(registered_event, index)) {
+		ret = -EPERM;
+		goto unlock_kvm;
+	}
+
+	/* Check if the vcpu has been masked off */
+	spin_lock(&vsdei->lock);
+	if (vsdei->state.masked) {
+		ret = -EPERM;
+		goto unlock_vcpu;
+	}
+
+	/* Inject the event */
+	ret = do_inject_event(vcpu, registered_event, immediate);
+
+unlock_vcpu:
+	spin_unlock(&vsdei->lock);
+unlock_kvm:
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
+int kvm_sdei_cancel_event(struct kvm_vcpu *vcpu, unsigned long num)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event = NULL;
+	struct kvm_sdei_registered_event *registered_event = NULL;
+	struct kvm_sdei_vcpu_event *vcpu_event = NULL;
+	int ret = 0;
+
+	if (!(ksdei && vsdei)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+	spin_lock(&vsdei->lock);
+
+	/* Find the vcpu event */
+	vcpu_event = find_vcpu_event(vcpu, num);
+	if (!vcpu_event) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* We can't cancel the event if it has been delivered */
+	if (vcpu_event->state.event_count <= 1 &&
+	    (vsdei->critical_event == vcpu_event ||
+	     vsdei->normal_event == vcpu_event)) {
+		ret = -EINPROGRESS;
+		goto unlock;
+	}
+
+	/* Destroy the vcpu event instance if needed */
+	registered_event = vcpu_event->registered_event;
+	exposed_event = registered_event->exposed_event;
+	vcpu_event->state.event_count--;
+	if (!vcpu_event->state.event_count)
+		remove_one_vcpu_event(vcpu, vcpu_event);
+
+unlock:
+	spin_unlock(&vsdei->lock);
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
+void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+	struct kvm_sdei_vcpu_event *vcpu_event;
+	struct kvm_sdei_vcpu_regs_state *regs;
+	unsigned long pstate;
+	int index;
+
+	if (!(ksdei && vsdei))
+		return;
+
+	spin_lock(&vsdei->lock);
+
+	/* The critical event can't be preempted */
+	if (vsdei->critical_event)
+		goto unlock;
+
+	/*
+	 * The normal event can be preempted by the critical event.
+	 * However, the normal event can't be preempted by another
+	 * normal event.
+	 */
+	vcpu_event = list_first_entry_or_null(&vsdei->critical_events,
+				struct kvm_sdei_vcpu_event, link);
+	if (!vcpu_event && !vsdei->normal_event) {
+		vcpu_event = list_first_entry_or_null(&vsdei->normal_events,
+					struct kvm_sdei_vcpu_event, link);
+	}
+
+	if (!vcpu_event)
+		goto unlock;
+
+	registered_event = vcpu_event->registered_event;
+	exposed_event = registered_event->exposed_event;
+	if (kvm_sdei_is_critical(exposed_event->state.priority)) {
+		vsdei->critical_event = vcpu_event;
+		vsdei->state.critical_num = vcpu_event->state.num;
+		regs = &vsdei->state.critical_regs;
+	} else {
+		vsdei->normal_event = vcpu_event;
+		vsdei->state.normal_num = vcpu_event->state.num;
+		regs = &vsdei->state.normal_regs;
+	}
+
+	/*
+	 * Save registers: x0 -> x17, PC, PState. There might be pending
+	 * exception or PC increment request in the last run on this vCPU.
+	 * In this case, we need to save the site in advance. Otherwise,
+	 * the passed entry point could be floated by 4 bytes in the
+	 * subsequent call to __kvm_adjust_pc().
+	 */
+	__kvm_adjust_pc(vcpu);
+	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
+		regs->regs[index] = vcpu_get_reg(vcpu, index);
+
+	regs->pc = *vcpu_pc(vcpu);
+	regs->pstate = *vcpu_cpsr(vcpu);
+
+	/*
+	 * Inject SDEI event: x0 -> x3, PC, PState. We needn't take lock
+	 * for the registered event as it can't be released because of
+	 * its reference count.
+	 */
+	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
+		vcpu_set_reg(vcpu, index, 0);
+
+	index = kvm_sdei_vcpu_index(vcpu, exposed_event);
+	vcpu_set_reg(vcpu, 0, registered_event->state.num);
+	vcpu_set_reg(vcpu, 1, registered_event->state.ep_arg[index]);
+	vcpu_set_reg(vcpu, 2, regs->pc);
+	vcpu_set_reg(vcpu, 3, regs->pstate);
+
+	pstate = regs->pstate;
+	pstate |= (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT);
+	pstate &= ~PSR_MODE_MASK;
+	pstate |= PSR_MODE_EL1h;
+	pstate &= ~PSR_MODE32_BIT;
+
+	vcpu_write_sys_reg(vcpu, regs->pstate, SPSR_EL1);
+	*vcpu_cpsr(vcpu) = pstate;
+	*vcpu_pc(vcpu) = registered_event->state.ep_address[index];
+
+unlock:
+	spin_unlock(&vsdei->lock);
+}
+
 void kvm_sdei_init_vm(struct kvm *kvm)
 {
 	struct kvm_sdei_kvm *ksdei;
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
