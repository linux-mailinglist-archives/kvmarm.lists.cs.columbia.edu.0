Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA2246401
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 12:06:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27C9D4C007;
	Mon, 17 Aug 2020 06:06:19 -0400 (EDT)
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
	with ESMTP id kypYlTZeSDvF; Mon, 17 Aug 2020 06:06:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A23F4C01C;
	Mon, 17 Aug 2020 06:06:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BB284BF95
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:06:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEkBGmhNJOrm for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 06:06:15 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E95A4BFFA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:06:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597658775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OElRZjP6JXO/OB6PEEqAJaD4uENzrShziqFCI70qwc=;
 b=fNtFYzWFcjxko4e7gSi4qqXx7dq3zMd0IxYQ9IwAxf22KTD0leZP1nXwbpiUilJodELmwt
 XGwfiRLX+IuU8YdypiRNGMmhu7Ir9KbaXPDnscAJxI/ru9T5RBt6IVVzNKkpMT/Uhq+kUi
 WaJ/0o5tjjgcLGJmQTSgPGYZE4KwXKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-0PDzaDEtPnOsNfi7f5u3AA-1; Mon, 17 Aug 2020 06:06:13 -0400
X-MC-Unique: 0PDzaDEtPnOsNfi7f5u3AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D5B3FE9;
 Mon, 17 Aug 2020 10:06:12 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-130.bne.redhat.com [10.64.54.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1ACE78414;
 Mon, 17 Aug 2020 10:06:09 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 08/18] arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_UNREGISTER
 hypercall
Date: Mon, 17 Aug 2020 20:05:21 +1000
Message-Id: <20200817100531.83045-9-gshan@redhat.com>
In-Reply-To: <20200817100531.83045-1-gshan@redhat.com>
References: <20200817100531.83045-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Cc: maz@kernel.org, shan.gavin@gmail.com, pbonzini@redhat.com
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

This supports SDEI_1_0_FN_SDEI_EVENT_UNREGISTER hypercall by adding
function kvm_sdei_hypercall_unregister(). For event owned by KVM
itself, the register status is updated accordingly and the event is
released if the event isn't needed. For passthrou event, the event
is also unregistered from the underly firmware in that case.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 320b79528211..63d621dc9711 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -343,6 +343,77 @@ static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_event *event = NULL;
+	struct kvm_sdei_kvm_event *kevent = NULL;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long event_type;
+	int index = 0;
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Validate event number */
+	if (!kvm_sdei_num_is_valid(event_num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	if (!(kvm_sdei_data && kvm_sdei_data->supported) &&
+	    kvm_sdei_num_is_virt(event_num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	/* Find the event */
+	spin_lock(&kvm_sdei_lock);
+	event = kvm_sdei_find_event(kvm, event_num, &kevent, NULL, NULL);
+	if (!kevent) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Sanity check */
+	spin_lock(&event->lock);
+	if (kevent->users) {
+		ret = SDEI_PENDING;
+		goto unlock_event;
+	}
+
+	event_type = event->priv ? event->priv->type : event->event->type;
+	index = (event_type == SDEI_EVENT_TYPE_PRIVATE) ? vcpu->vcpu_idx : 0;
+	if (!test_bit(index, kevent->registered)) {
+		ret = SDEI_DENIED;
+		goto unlock_event;
+	}
+
+	/* Update status and destroy it if needed */
+	clear_bit(index, kevent->registered);
+	clear_bit(index, kevent->enabled);
+	if (!bitmap_empty(kevent->registered, KVM_MAX_VCPUS))
+		goto unlock_event;
+
+	rb_erase(&kevent->node, &event->root);
+	kfree(kevent);
+	event->count--;
+	if (event->count)
+		goto unlock_event;
+
+	spin_unlock(&event->lock);
+	list_del(&event->link);
+	if (event->event)
+		kvm_sdei_unregister_event(event->event);
+	kfree(event);
+	goto unlock;
+
+unlock_event:
+	spin_unlock(&event->lock);
+unlock:
+	spin_unlock(&kvm_sdei_lock);
+out:
+	return ret;
+}
+
 static unsigned long kvm_sdei_reset(struct kvm *kvm, unsigned int types)
 {
 	struct kvm_sdei_event *e, *event = NULL;
@@ -429,6 +500,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+		ret = kvm_sdei_hypercall_unregister(vcpu);
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
