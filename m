Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 48C82535B14
	for <lists+kvmarm@lfdr.de>; Fri, 27 May 2022 10:06:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D1AC44B373;
	Fri, 27 May 2022 04:06:30 -0400 (EDT)
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
	with ESMTP id Ls2dHp4+BOEF; Fri, 27 May 2022 04:06:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 489F24B33D;
	Fri, 27 May 2022 04:06:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F6654B284
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 May 2022 04:06:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OYfOpBtOpqH5 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 May 2022 04:06:26 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AA6B54B186
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 May 2022 04:06:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653638786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fyjs17cQuU2U21OwKMwjdN3jGGY3Oxumv8wAG92m2EA=;
 b=GZku+/kauDv0vOue7rnF4Rp6gXKQKIpZeVeB99nyXewmkZhYj5OnQ24UxRvtSgYRfRqYFS
 fPXwyNLHcqAikzLteLU2ac4+RqOnZNEcE0rJ2lKTxPiY2zNinyxkwBCt+WUm8mMbUyavkC
 yY7btj80B2xB23wKcZfI5b/oVLEsBc0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-PsGwo5UTOaOLMy8tj08cCw-1; Fri, 27 May 2022 04:06:22 -0400
X-MC-Unique: PsGwo5UTOaOLMy8tj08cCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F110185A79C;
 Fri, 27 May 2022 08:06:21 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3662026D64;
 Fri, 27 May 2022 08:06:14 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v7 19/22] KVM: arm64: Support SDEI event migration
Date: Fri, 27 May 2022 16:02:50 +0800
Message-Id: <20220527080253.1562538-20-gshan@redhat.com>
In-Reply-To: <20220527080253.1562538-1-gshan@redhat.com>
References: <20220527080253.1562538-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: maz@kernel.org, shijie@amperemail.onmicrosoft.com,
 linux-kernel@vger.kernel.org, eauger@redhat.com, shan.gavin@gmail.com,
 Jonathan.Cameron@huawei.com, pbonzini@redhat.com, vkuznets@redhat.com,
 will@kernel.org
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

This supports migration for SDEI event handlers, states and context.
Several pseudo firmware registers are added to assist the migration
work.

   * KVM_REG_ARM_SDEI_EVENT_HANDLER_0
     KVM_REG_ARM_SDEI_EVENT_HANDLER_1
     KVM_REG_ARM_SDEI_EVENT_HANDLER_2
     KVM_REG_ARM_SDEI_EVENT_HANDLER_3

     128-bits in length. They're mapped to the handler's address
     and argument for Software Signaled event and Async PF event.
     Additinal two events are reserved for future needs without
     too much considerations to the compatible issue. Not too much
     bandwidth needed to migrate those two additional registers.

  * KVM_REG_ARM_SDEI_EVENT_REGISTERED
    KVM_REG_ARM_SDEI_EVENT_ENABLED
    KVM_REG_ARM_SDEI_EVENT_RUNNING
    KVM_REG_ARM_SDEI_EVENT_PENDING

    64-bits in length. They're mapped to registered, enabled,
    running and pending bitmap.

  * KVM_REG_ARM_SDEI_EVENT_CONTEXT

    2048-bits in length. It's mapped to saved or interrupted
    context.

  * KVM_REG_ARM_SDEI_PE_STATE

    64-bits in length. It's mapped to PE's states, which is masked
    or unmasked.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h |   2 +
 arch/arm64/include/uapi/asm/kvm.h |  17 ++++
 arch/arm64/kvm/hypercalls.c       |  32 ++++++
 arch/arm64/kvm/sdei.c             | 161 ++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index a68d40137a88..d11964b88b58 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -73,6 +73,8 @@ int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
 			  unsigned int num, bool immediate);
 int kvm_sdei_cancel_event(struct kvm_vcpu *vcpu, unsigned int num);
 void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu);
+int kvm_sdei_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_sdei_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index cc3251381960..90247ce8de59 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -262,6 +262,11 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_FW_REG_128(r)	(KVM_REG_ARM64 | KVM_REG_SIZE_U128 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_FW_REG_2048(r)	(KVM_REG_ARM64 | KVM_REG_SIZE_U2048 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
@@ -288,6 +293,18 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3_AVAIL		1
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3_NOT_REQUIRED	2
 
+/* SDEI registers */
+#define KVM_REG_ARM_SDEI_EVENT_HANDLER_0	KVM_REG_ARM_FW_REG_128(4)
+#define KVM_REG_ARM_SDEI_EVENT_HANDLER_1	KVM_REG_ARM_FW_REG_128(5)
+#define KVM_REG_ARM_SDEI_EVENT_HANDLER_2	KVM_REG_ARM_FW_REG_128(6)
+#define KVM_REG_ARM_SDEI_EVENT_HANDLER_3	KVM_REG_ARM_FW_REG_128(7)
+#define KVM_REG_ARM_SDEI_EVENT_REGISTERED	KVM_REG_ARM_FW_REG(8)
+#define KVM_REG_ARM_SDEI_EVENT_ENABLED		KVM_REG_ARM_FW_REG(9)
+#define KVM_REG_ARM_SDEI_EVENT_RUNNING		KVM_REG_ARM_FW_REG(10)
+#define KVM_REG_ARM_SDEI_EVENT_PENDING		KVM_REG_ARM_FW_REG(11)
+#define KVM_REG_ARM_SDEI_EVENT_CONTEXT		KVM_REG_ARM_FW_REG_2048(12)
+#define KVM_REG_ARM_SDEI_PE_STATE		KVM_REG_ARM_FW_REG(13)
+
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
 
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 8e0df54d1422..d330aee968a9 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -290,6 +290,16 @@ static const u64 kvm_arm_fw_reg_ids[] = {
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1,
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3,
+	KVM_REG_ARM_SDEI_EVENT_HANDLER_0,
+	KVM_REG_ARM_SDEI_EVENT_HANDLER_1,
+	KVM_REG_ARM_SDEI_EVENT_HANDLER_2,
+	KVM_REG_ARM_SDEI_EVENT_HANDLER_3,
+	KVM_REG_ARM_SDEI_EVENT_REGISTERED,
+	KVM_REG_ARM_SDEI_EVENT_ENABLED,
+	KVM_REG_ARM_SDEI_EVENT_RUNNING,
+	KVM_REG_ARM_SDEI_EVENT_PENDING,
+	KVM_REG_ARM_SDEI_EVENT_CONTEXT,
+	KVM_REG_ARM_SDEI_PE_STATE,
 	KVM_REG_ARM_STD_BMAP,
 	KVM_REG_ARM_STD_HYP_BMAP,
 	KVM_REG_ARM_VENDOR_HYP_BMAP,
@@ -387,6 +397,17 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3:
 		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
 		break;
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_0:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_1:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_2:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_3:
+	case KVM_REG_ARM_SDEI_EVENT_REGISTERED:
+	case KVM_REG_ARM_SDEI_EVENT_ENABLED:
+	case KVM_REG_ARM_SDEI_EVENT_RUNNING:
+	case KVM_REG_ARM_SDEI_EVENT_PENDING:
+	case KVM_REG_ARM_SDEI_EVENT_CONTEXT:
+	case KVM_REG_ARM_SDEI_PE_STATE:
+		return kvm_sdei_get_reg(vcpu, reg);
 	case KVM_REG_ARM_STD_BMAP:
 		val = READ_ONCE(smccc_feat->std_bmap);
 		break;
@@ -537,6 +558,17 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 			return -EINVAL;
 
 		return 0;
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_0:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_1:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_2:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_3:
+	case KVM_REG_ARM_SDEI_EVENT_REGISTERED:
+	case KVM_REG_ARM_SDEI_EVENT_ENABLED:
+	case KVM_REG_ARM_SDEI_EVENT_RUNNING:
+	case KVM_REG_ARM_SDEI_EVENT_PENDING:
+	case KVM_REG_ARM_SDEI_EVENT_CONTEXT:
+	case KVM_REG_ARM_SDEI_PE_STATE:
+		return kvm_sdei_set_reg(vcpu, reg);
 	case KVM_REG_ARM_STD_BMAP:
 	case KVM_REG_ARM_STD_HYP_BMAP:
 	case KVM_REG_ARM_VENDOR_HYP_BMAP:
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index f95b9bcce13c..c14532de48f5 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -498,6 +498,167 @@ void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu)
 	set_bit(num, &vsdei->running);
 }
 
+int kvm_sdei_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event_context *ctxt = &vsdei->ctxt;
+	struct kvm_sdei_event_handler handler;
+	void __user *uaddr = (void __user *)(long)reg->addr;
+	unsigned int num, i;
+	unsigned long val, *pstate = NULL;
+
+	if (!vsdei)
+		return -EPERM;
+
+	switch (reg->id) {
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_0:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_1:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_2:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_3:
+		 num = (reg->id & 0xffff) -
+		       (KVM_REG_ARM_SDEI_EVENT_HANDLER_0 & 0xffff);
+
+		if (num < KVM_NR_SDEI_EVENTS)
+			handler = vsdei->handlers[num];
+		else
+			memset(&handler, 0, sizeof(handler));
+
+		if (copy_to_user(uaddr, &handler, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		break;
+	case KVM_REG_ARM_SDEI_EVENT_REGISTERED:
+		pstate = &vsdei->registered;
+		fallthrough;
+	case KVM_REG_ARM_SDEI_EVENT_ENABLED:
+		pstate = pstate ? : &vsdei->enabled;
+		fallthrough;
+	case KVM_REG_ARM_SDEI_EVENT_RUNNING:
+		pstate = pstate ? : &vsdei->running;
+		fallthrough;
+	case KVM_REG_ARM_SDEI_EVENT_PENDING:
+		pstate = pstate ? : &vsdei->pending;
+		if (copy_to_user(uaddr, pstate, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		break;
+	case KVM_REG_ARM_SDEI_EVENT_CONTEXT:
+		if (copy_to_user(uaddr, &ctxt->pc, sizeof(ctxt->pc)))
+			return -EFAULT;
+
+		uaddr += sizeof(ctxt->pc);
+		if (copy_to_user(uaddr, &ctxt->pstate, sizeof(ctxt->pstate)))
+			return -EFAULT;
+
+		uaddr += sizeof(ctxt->pstate);
+		for (i = 0; i < ARRAY_SIZE(ctxt->regs); i++) {
+			if (copy_to_user(uaddr, &ctxt->regs[i],
+					 sizeof(ctxt->regs[i])))
+				return -EFAULT;
+
+			uaddr += sizeof(ctxt->regs[i]);
+		}
+
+		break;
+	case KVM_REG_ARM_SDEI_PE_STATE:
+		val = (vcpu->arch.flags & KVM_ARM64_SDEI_MASKED) ? 1 : 0;
+		if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+int kvm_sdei_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event_context *ctxt = &vsdei->ctxt;
+	void __user *uaddr = (void __user *)(long)reg->addr;
+	unsigned int num, i;
+	unsigned long val, *pstate = NULL;
+
+	if (!vsdei)
+		return -EPERM;
+
+	switch (reg->id) {
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_0:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_1:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_2:
+	case KVM_REG_ARM_SDEI_EVENT_HANDLER_3:
+		num = (reg->id & 0xffff) -
+		      (KVM_REG_ARM_SDEI_EVENT_HANDLER_0 & 0xffff);
+		if (num >= KVM_NR_SDEI_EVENTS)
+			break;
+
+		if (copy_from_user(&vsdei->handlers[num], uaddr,
+				   sizeof(vsdei->handlers[num])))
+			return -EFAULT;
+
+		break;
+	case KVM_REG_ARM_SDEI_EVENT_REGISTERED:
+		pstate = &vsdei->registered;
+		fallthrough;
+	case KVM_REG_ARM_SDEI_EVENT_ENABLED:
+		pstate = pstate ? : &vsdei->enabled;
+		fallthrough;
+	case KVM_REG_ARM_SDEI_EVENT_RUNNING:
+		pstate = pstate ? : &vsdei->running;
+		fallthrough;
+	case KVM_REG_ARM_SDEI_EVENT_PENDING:
+		pstate = pstate ? : &vsdei->pending;
+		if (copy_from_user(&val, uaddr, sizeof(val)))
+			return -EFAULT;
+
+		*pstate = (val & GENMASK(KVM_NR_SDEI_EVENTS - 1, 0));
+		if (!(vcpu->arch.flags & KVM_ARM64_SDEI_MASKED) &&
+		    pstate == &vsdei->pending &&
+		    vsdei->pending)
+			kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+		break;
+	case KVM_REG_ARM_SDEI_EVENT_CONTEXT:
+		if (copy_from_user(&ctxt->pc, uaddr, sizeof(ctxt->pc)))
+			return -EFAULT;
+
+		uaddr += sizeof(ctxt->pc);
+		if (copy_from_user(&ctxt->pstate, uaddr, sizeof(ctxt->pstate)))
+			return -EFAULT;
+
+		uaddr += sizeof(ctxt->pstate);
+		for (i = 0; i < ARRAY_SIZE(ctxt->regs); i++) {
+			if (copy_from_user(&ctxt->regs[i], uaddr,
+					   sizeof(ctxt->regs[i])))
+				return -EFAULT;
+
+			uaddr += sizeof(ctxt->regs[i]);
+		}
+
+		break;
+	case KVM_REG_ARM_SDEI_PE_STATE:
+		if (copy_from_user(&val, uaddr, sizeof(val)))
+			return -EFAULT;
+
+		if (val) {
+			vcpu->arch.flags |= KVM_ARM64_SDEI_MASKED;
+		} else {
+			vcpu->arch.flags &= ~KVM_ARM64_SDEI_MASKED;
+			if (vsdei->pending)
+				kvm_make_request(KVM_REQ_SDEI, vcpu);
+		}
+
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return 0;
+
+}
+
 void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei;
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
