Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A24F0ACD
	for <lists+kvmarm@lfdr.de>; Sun,  3 Apr 2022 17:41:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8608B4B215;
	Sun,  3 Apr 2022 11:41:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cG9NNu+ZKyMy; Sun,  3 Apr 2022 11:41:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E3214B1D2;
	Sun,  3 Apr 2022 11:41:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D550B4B0DF
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Apr 2022 11:41:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SkD4XtZi67dw for <kvmarm@lists.cs.columbia.edu>;
 Sun,  3 Apr 2022 11:41:02 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4ED74B0D9
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Apr 2022 11:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649000462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDyhK0N42QTYxzvptLYmEfOmEf+1ls/8SVfr1kkXkvg=;
 b=akWlU4WW3I9Lnw6YYt9bv8aUup+aKOqy3cRo6PaBau5P7AB3GE8wyUDZN+eNI1pjWIwO7v
 XSUBsnJWbk1xoQI82NS/Q3e9tR6jxUOWGWzX9HlPxBufT9wznEHvvcqPw7sTVYmjBfL+P9
 BamU+t8Meu9qzgKg7Qj6GBqaOV5kpk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-vXCcNdQtNb2K6-e3mqzp7Q-1; Sun, 03 Apr 2022 11:41:01 -0400
X-MC-Unique: vXCcNdQtNb2K6-e3mqzp7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F05FE85A5BC;
 Sun,  3 Apr 2022 15:41:00 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F071D403172;
 Sun,  3 Apr 2022 15:40:54 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v6 13/18] KVM: arm64: Support SDEI_EVENT_{COMPLETE,
 COMPLETE_AND_RESUME} hypercall
Date: Sun,  3 Apr 2022 23:39:06 +0800
Message-Id: <20220403153911.12332-14-gshan@redhat.com>
In-Reply-To: <20220403153911.12332-1-gshan@redhat.com>
References: <20220403153911.12332-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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

This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
They are used by guest to notify the completion of event in its
handler. The previously interrupted or preempted context is restored
like below.

   * x0 - x17, PC and PState are restored to what values we had in
     the interrupted or preempted context.

   * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
     is injected.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/kvm/hyp/exception.c       |  7 +++
 arch/arm64/kvm/inject_fault.c        | 29 ++++++++++
 arch/arm64/kvm/sdei.c                | 79 ++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index d62405ce3e6d..ca9de9f24923 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -37,6 +37,7 @@ bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+void kvm_inject_irq(struct kvm_vcpu *vcpu);
 void kvm_inject_vabt(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 951264d4b64d..ac475d3b9151 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -431,6 +431,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_EXCEPT_AA32_UND	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA32_IABT	(1 << 9)
 #define KVM_ARM64_EXCEPT_AA32_DABT	(2 << 9)
+#define KVM_ARM64_EXCEPT_AA32_IRQ	(3 << 9)
 /* For AArch64: */
 #define KVM_ARM64_EXCEPT_AA64_ELx_SYNC	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA64_ELx_IRQ	(1 << 9)
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index c5d009715402..f425ea11e4f6 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -313,6 +313,9 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 		case KVM_ARM64_EXCEPT_AA32_DABT:
 			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
 			break;
+		case KVM_ARM64_EXCEPT_AA32_IRQ:
+			enter_exception32(vcpu, PSR_AA32_MODE_IRQ, 24);
+			break;
 		default:
 			/* Err... */
 			break;
@@ -323,6 +326,10 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 		      KVM_ARM64_EXCEPT_AA64_EL1):
 			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
 			break;
+		case (KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
+		      KVM_ARM64_EXCEPT_AA64_EL1):
+			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
+			break;
 		default:
 			/*
 			 * Only EL1_SYNC makes sense so far, EL2_{SYNC,IRQ}
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index b47df73e98d7..c8a8791bdf28 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -66,6 +66,13 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
 }
 
+static void inject_irq64(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1     |
+			     KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
+			     KVM_ARM64_PENDING_EXCEPTION);
+}
+
 #define DFSR_FSC_EXTABT_LPAE	0x10
 #define DFSR_FSC_EXTABT_nLPAE	0x08
 #define DFSR_LPAE		BIT(9)
@@ -77,6 +84,12 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
 			     KVM_ARM64_PENDING_EXCEPTION);
 }
 
+static void inject_irq32(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IRQ |
+			     KVM_ARM64_PENDING_EXCEPTION);
+}
+
 /*
  * Modelled after TakeDataAbortException() and TakePrefetchAbortException
  * pseudocode.
@@ -160,6 +173,22 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 		inject_undef64(vcpu);
 }
 
+/**
+ * kvm_inject_irq - inject an IRQ into the guest
+ * @vcpu: The vCPU in which to inject IRQ
+ *
+ * Inject IRQs to the target vCPU. It is assumed that this code is
+ * called from the VCPU thread and that the VCPU therefore is not
+ * currently executing guest code.
+ */
+void kvm_inject_irq(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_el1_is_32bit(vcpu))
+		inject_irq32(vcpu);
+	else
+		inject_irq64(vcpu);
+}
+
 void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
 {
 	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 9d18fee59751..ebdbe7810cf0 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -243,6 +243,79 @@ static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_complete(struct kvm_vcpu *vcpu, bool resume)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_event *event;
+	struct kvm_sdei_vcpu_context *context;
+	unsigned int i;
+	unsigned long ret = SDEI_SUCCESS;
+
+	spin_lock(&vsdei->lock);
+
+	/* Check if there is any event being handled */
+	context = &vsdei->context[SDEI_EVENT_PRIORITY_CRITICAL];
+	context = context->event ? context : NULL;
+	context = context ? : &vsdei->context[SDEI_EVENT_PRIORITY_NORMAL];
+	context = context->event ? context : NULL;
+	if (!context) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Restore registers: x0 -> x17, PC, PState */
+	for (i = 0; i < ARRAY_SIZE(context->regs); i++)
+		vcpu_set_reg(vcpu, i, context->regs[i]);
+
+	*vcpu_cpsr(vcpu) = context->pstate;
+	*vcpu_pc(vcpu) = context->pc;
+
+	/* Inject interrupt if needed */
+	if (resume)
+		kvm_inject_irq(vcpu);
+
+	/*
+	 * Decrease the event count and invalidate the event in the
+	 * vcpu context.
+	 */
+	event = context->event;
+	exposed_event = event->exposed_event;
+	context->event = NULL;
+	event->event_count--;
+	if (kvm_sdei_is_critical(exposed_event->priority))
+		vsdei->critical_event_count--;
+	else
+		vsdei->normal_event_count--;
+
+	/*
+	 * We need to check if the event is pending for unregistration.
+	 * In that case, the event should be disabled and unregistered.
+	 * All the pending events are cancelled either.
+	 */
+	if (kvm_sdei_is_unregister_pending(event)) {
+		if (kvm_sdei_is_critical(exposed_event->priority))
+			vsdei->critical_event_count -= event->event_count;
+		else
+			vsdei->normal_event_count -= event->event_count;
+
+		event->event_count = 0;
+		kvm_sdei_clear_enabled(event);
+		kvm_sdei_clear_registered(event);
+		kvm_sdei_clear_unregister_pending(event);
+	}
+
+	/* Another request if we have more events to be handled */
+	if (vsdei->critical_event_count > 0 ||
+	    vsdei->normal_event_count > 0)
+		kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+unlock:
+	spin_unlock(&vsdei->lock);
+
+	return ret;
+}
+
 static unsigned long hypercall_unregister(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -445,6 +518,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
 		ret = hypercall_context(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+		ret = hypercall_complete(vcpu, false);
+		break;
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+		ret = hypercall_complete(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
 		ret = hypercall_unregister(vcpu);
 		break;
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
