Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8813C4E3A22
	for <lists+kvmarm@lfdr.de>; Tue, 22 Mar 2022 09:09:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D668C49ECB;
	Tue, 22 Mar 2022 04:09:01 -0400 (EDT)
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
	with ESMTP id C27BlIkUGZxT; Tue, 22 Mar 2022 04:09:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 875C4411C7;
	Tue, 22 Mar 2022 04:09:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB6DB49EDE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:08:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SHH2TjKDm3eL for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Mar 2022 04:08:58 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CF3449ECC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:08:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647936538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiu9RjNPKo0dVPTWpVo+lOgd3Qb2+2dr9PAVFbVsol0=;
 b=XxeDI0HUGGjp42C2DCNbctRw6nACP8ENv0/Ix9GmK6farJ0qZmVOLrDoQjL1yPhLaGnahy
 lFiUGc5SNg3pXR7Q4dINxT7uGKahvkSbGGIjr4SqkRhLepL1qm8cgKidRfJYOvwpIUwL8D
 mShg3x//VsXigJemD5Y+71nrWwZ/F/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-aqx-ZFLUPc2h8Xc4Xdgv-A-1; Tue, 22 Mar 2022 04:08:52 -0400
X-MC-Unique: aqx-ZFLUPc2h8Xc4Xdgv-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AD48811E75;
 Tue, 22 Mar 2022 08:08:52 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 822931121324;
 Tue, 22 Mar 2022 08:08:43 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 07/22] KVM: arm64: Support SDEI_EVENT_UNREGISTER hypercall
Date: Tue, 22 Mar 2022 16:06:55 +0800
Message-Id: <20220322080710.51727-8-gshan@redhat.com>
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

This supports SDEI_EVENT_UNREGISTER hypercall. It's used by the
guest to unregister SDEI event. The SDEI event won't be raised to
the guest after it's unregistered. The SDEI event is disabled
automatically on unregistration.

The currently handled events can't be unregistered. We set the
unregistration pending state for the event so that it can be
unregistered when the event handler is completed by receiving
SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 133 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 4488d3f044f2..36eda31e0392 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -325,6 +325,135 @@ static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long
+unregister_one_event(struct kvm *kvm, struct kvm_vcpu *vcpu,
+		     struct kvm_sdei_registered_event *registered_event)
+{
+	struct kvm_vcpu *vcpup;
+	struct kvm_sdei_vcpu *vsdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	int index;
+	bool pending;
+	unsigned long i, ret = SDEI_SUCCESS;
+
+	/*
+	 * Cancel all vcpu events that have been queued, but not dispatched
+	 * yet. If the vcpu event has been dispatched, we should mark it
+	 * as pending for unregistration. The unregistration will be executed
+	 * when the event handler is to be completed.
+	 */
+	exposed_event = registered_event->exposed_event;
+	kvm_for_each_vcpu(i, vcpup, kvm) {
+		vsdei = vcpup->arch.sdei;
+		if (!vsdei)
+			continue;
+
+		/*
+		 * The private vcpu events are requested to be unregistered
+		 * on the specific vcpu or all vcpus. @vcpu is used to
+		 * identify the cases. For the shared vcpu events, we need
+		 * to unregister them on all vcpus.
+		 */
+		if (kvm_sdei_is_private(exposed_event->state.type) &&
+		    vcpu && vcpu != vcpup)
+			continue;
+
+		if (registered_event->vcpu_event_count > 0) {
+			spin_lock(&vsdei->lock);
+			pending = remove_all_vcpu_events(vcpup,
+					registered_event->state.num);
+			spin_unlock(&vsdei->lock);
+		} else {
+			pending = false;
+		}
+
+		/*
+		 * For the private event, the pending state for unregistration
+		 * is scattered and we need to update them individually.
+		 * However, that same state for the shared event has to be
+		 * updated at once according to @ret after the iteration is
+		 * done.
+		 */
+		ret = pending ? SDEI_PENDING : ret;
+		if (!kvm_sdei_is_private(exposed_event->state.type))
+			continue;
+
+		index = kvm_sdei_vcpu_index(vcpup, exposed_event);
+		if (pending) {
+			kvm_sdei_set_unregister_pending(registered_event,
+							index);
+		} else {
+			kvm_sdei_clear_enabled(registered_event, index);
+			kvm_sdei_clear_registered(registered_event, index);
+		}
+	}
+
+	/*
+	 * Update the pending state for unregistration for the shared event
+	 * at once.
+	 */
+	if (kvm_sdei_is_shared(exposed_event->state.type)) {
+		index = kvm_sdei_vcpu_index(vcpu, exposed_event);
+		if (ret == SDEI_PENDING) {
+			kvm_sdei_set_unregister_pending(registered_event,
+							index);
+		} else {
+			kvm_sdei_clear_enabled(registered_event, index);
+			kvm_sdei_clear_registered(registered_event, index);
+		}
+	}
+
+	/* Destroy the registered event instance if needed */
+	if (kvm_sdei_none_registered(registered_event))
+		remove_one_registered_event(kvm, registered_event);
+
+	return ret;
+}
+
+static unsigned long hypercall_unregister(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	int index;
+	unsigned long ret = SDEI_SUCCESS;
+
+	if (!kvm_sdei_is_supported(event_num))
+		return SDEI_INVALID_PARAMETERS;
+
+	spin_lock(&ksdei->lock);
+
+	/* Check if the registered event exists */
+	registered_event = find_registered_event(kvm, event_num);
+	if (!registered_event) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Check if the event has been registered */
+	exposed_event = registered_event->exposed_event;
+	index = kvm_sdei_vcpu_index(vcpu, exposed_event);
+	if (!kvm_sdei_is_registered(registered_event, index)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Check if the event has been pending for unregistration */
+	if (kvm_sdei_is_unregister_pending(registered_event, index)) {
+		ret = SDEI_PENDING;
+		goto unlock;
+	}
+
+	ret = unregister_one_event(kvm, vcpu, registered_event);
+
+unlock:
+	spin_unlock(&ksdei->lock);
+
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -365,7 +494,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+		ret = SDEI_NOT_SUPPORTED;
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+		ret = hypercall_unregister(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
 	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
 	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
