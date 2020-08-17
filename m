Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0EC2463FE
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 12:06:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EAFD4C032;
	Mon, 17 Aug 2020 06:06:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X44Cvg3Ba2xi; Mon, 17 Aug 2020 06:06:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D06644C00A;
	Mon, 17 Aug 2020 06:06:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ADD594C005
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:06:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7CI0nE3sX-w for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 06:06:09 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95AE94BFFF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:06:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597658769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2JasmbC6VpPjvg9E/Ssoo4tc38d/qYzi5GE93FZDIE=;
 b=ct204+kWG0P62ZGUSpLMD/T/CYXYGHsR2c2A2L7iLDx6BAQRQ32NH8viLc2TfS4qccmMb9
 gEKeoOyoVFiWNKCbxD6Ptotd810hh1WsTSSI6wNZmlCwRkz2C9Y01TtaFogzI5GB+Hfwa8
 HdBI8WuKSMrDeM6fKtCEbpaDXFj6Lw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-frZ-OoakNHCV2cBOpKH0Cw-1; Mon, 17 Aug 2020 06:06:08 -0400
X-MC-Unique: frZ-OoakNHCV2cBOpKH0Cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD0E010066FB;
 Mon, 17 Aug 2020 10:06:06 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-130.bne.redhat.com [10.64.54.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBE9878414;
 Mon, 17 Aug 2020 10:06:01 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 06/18] arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_REGISTER
Date: Mon, 17 Aug 2020 20:05:19 +1000
Message-Id: <20200817100531.83045-7-gshan@redhat.com>
In-Reply-To: <20200817100531.83045-1-gshan@redhat.com>
References: <20200817100531.83045-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0.001
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

This supports SDEI_1_0_FN_SDEI_EVENT_REGISTER hypercall by adding
kvm_sdei_hypercall_register(), which works like below:

   * if both the specific event and kvm event exist and the registered
     status is off, the registered status is turned on in system or vCPU
     scope, depending on the event type (private or shared). Otherwise,
     errno is returned.

   * If the specific event doesn't exist, the event is created and put
     into the linked list (@kvm_sdei_events). Also, the event is registered
     to underly firmware if there is valid one.

   * If the specific kvm event doesn't exist, the kvm event is created
     and put into the RB-tree of the parent event. The registered status
     is updated either.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 230 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index f5739c0063df..740694d7f0ff 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -13,6 +13,16 @@
 static struct kvm_sdei_info *kvm_sdei_data;
 static DEFINE_SPINLOCK(kvm_sdei_lock);
 static LIST_HEAD(kvm_sdei_events);
+static struct kvm_sdei_priv kvm_sdei_privs[] = {
+	{ 0x40200000,
+	  SDEI_EVENT_TYPE_PRIVATE,
+	  1,
+	  SDEI_EVENT_PRIORITY_CRITICAL,
+	  SDEI_EVENT_REGISTER_RM_ANY,
+	  0,
+	  NULL
+	},
+};
 
 #ifdef CONFIG_ARM_SDE_INTERFACE
 static struct kvm_sdei_info *kvm_sdei_get_kvm_info(void)
@@ -20,6 +30,14 @@ static struct kvm_sdei_info *kvm_sdei_get_kvm_info(void)
 	return sdei_get_kvm_info();
 }
 
+static struct sdei_event *kvm_sdei_register_event(unsigned long event_num,
+						  sdei_event_callback *cb,
+						  void *arg)
+{
+	return sdei_event_register(kvm_sdei_num_to_std(event_num),
+				   cb, arg);
+}
+
 static int kvm_sdei_unregister_event(struct sdei_event *event)
 {
 	return sdei_event_unregister(event);
@@ -30,12 +48,78 @@ static inline struct kvm_sdei_info *kvm_sdei_get_kvm_info(void)
 	return NULL;
 }
 
+static inline struct sdei_event *kvm_sdei_register_event(
+					unsigned long event_num,
+					sdei_event_callback *cb,
+					void *arg)
+{
+	return NULL;
+}
+
 static inline int kvm_sdei_unregister_event(struct sdei_event *event)
 {
 	return -EPERM;
 }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
+static struct kvm_sdei_priv *kvm_sdei_find_priv(unsigned long num)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(kvm_sdei_privs); i++) {
+		if (kvm_sdei_privs[i].num == num)
+			return &kvm_sdei_privs[i];
+	}
+
+	return NULL;
+}
+
+static struct kvm_sdei_event *kvm_sdei_find_event(struct kvm *kvm,
+		unsigned long num, struct kvm_sdei_kvm_event **kvm_event,
+		struct rb_node **rb_parent, struct rb_node ***rb_link)
+{
+	struct kvm_sdei_event *event = NULL;
+	struct kvm_sdei_kvm_event *tmp, *kevent = NULL;
+	struct rb_node *p, *parent = NULL;
+
+	list_for_each_entry(event, &kvm_sdei_events, link) {
+		if (event->num == num)
+			break;
+	}
+
+	if (!event || event->num != num) {
+		event = NULL;
+		goto out;
+	}
+
+	if (!kvm || !kvm_event)
+		goto out;
+
+	spin_lock(&event->lock);
+	p = event->root.rb_node;
+	while (p) {
+		parent = p;
+		tmp = rb_entry(parent, struct kvm_sdei_kvm_event, node);
+		if (tmp->kvm->userspace_pid > kvm->userspace_pid) {
+			p = parent->rb_left;
+		} else if (tmp->kvm->userspace_pid < kvm->userspace_pid) {
+			p = parent->rb_right;
+		} else {
+			kevent = tmp;
+			break;
+		}
+	}
+
+	spin_unlock(&event->lock);
+	*kvm_event = kevent;
+	if (rb_parent)
+		*rb_parent = parent;
+	if (rb_link)
+		*rb_link = &p;
+out:
+	return event;
+}
+
 static unsigned long kvm_sdei_hypercall_version(struct kvm_vcpu *vcpu)
 {
 	unsigned long ret = SDEI_NOT_SUPPORTED;
@@ -51,6 +135,150 @@ static unsigned long kvm_sdei_hypercall_version(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_sdei_handler(u32 num, struct pt_regs *regs, void *arg)
+{
+	return 0;
+}
+
+static unsigned long kvm_sdei_hypercall_register(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_event *event = NULL, *new = NULL;
+	struct kvm_sdei_kvm_event *kevent = NULL;
+	struct kvm_sdei_priv *priv = NULL;
+	struct rb_node *rb_parent, **rb_link;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long event_entry = smccc_get_arg2(vcpu);
+	unsigned long event_param = smccc_get_arg3(vcpu);
+	unsigned long route_mode = smccc_get_arg4(vcpu);
+	unsigned long route_affinity = smccc_get_arg5(vcpu);
+	unsigned long event_type;
+	int index = vcpu->vcpu_idx;
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
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
+	if (!(route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
+	      route_mode == SDEI_EVENT_REGISTER_RM_PE)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	/*
+	 * Find the event. We just need to set the registered
+	 * bit if it already exists.
+	 */
+	spin_lock(&kvm_sdei_lock);
+
+	event = kvm_sdei_find_event(kvm, event_num, &kevent,
+				    &rb_parent, &rb_link);
+	if (kevent) {
+		event_type = event->priv ? event->priv->type :
+					   event->event->type;
+		index = (event_type == SDEI_EVENT_TYPE_PRIVATE) ?
+			vcpu->vcpu_idx : 0;
+
+		spin_lock(&event->lock);
+		if (test_bit(index, kevent->registered)) {
+			spin_unlock(&event->lock);
+			ret = SDEI_DENIED;
+			goto unlock;
+		}
+
+		kevent->route_mode = route_mode;
+		kevent->route_affinity = route_affinity;
+		kevent->entries[index] = event_entry;
+		kevent->params[index] = event_param;
+		set_bit(index, kevent->registered);
+		spin_unlock(&event->lock);
+
+		ret = SDEI_SUCCESS;
+		goto unlock;
+	}
+
+	/*
+	 * Create the event. The event is going to be registered
+	 * if it's a passthrou event.
+	 */
+	if (!event) {
+		if (kvm_sdei_num_is_priv(event_num)) {
+			priv = kvm_sdei_find_priv(event_num);
+			if (!priv) {
+				ret = SDEI_INVALID_PARAMETERS;
+				goto unlock;
+			}
+		}
+
+		event = kzalloc(sizeof(*event), GFP_KERNEL);
+		if (!event) {
+			ret = SDEI_OUT_OF_RESOURCE;
+			goto unlock;
+		}
+
+		if (!priv) {
+			event->event = kvm_sdei_register_event(event_num,
+						kvm_sdei_handler, event);
+			if (!event->event) {
+				kfree(event);
+				ret = SDEI_OUT_OF_RESOURCE;
+				goto unlock;
+			}
+		}
+
+		new = event;
+		spin_lock_init(&event->lock);
+		event->priv = priv;
+		event->root = RB_ROOT;
+		event->count = 0;
+		event->num = event_num;
+		list_add_tail(&event->link, &kvm_sdei_events);
+
+		new = event;
+		rb_parent = NULL;
+		rb_link = &event->root.rb_node;
+	}
+
+	/* Create KVM event */
+	kevent = kzalloc(sizeof(*kevent), GFP_KERNEL);
+	if (!kevent) {
+		kfree(new);
+		ret = SDEI_OUT_OF_RESOURCE;
+		goto unlock;
+	}
+
+	event_type = priv ? priv->type : event->event->type;
+	index = (event_type == SDEI_EVENT_TYPE_PRIVATE) ? vcpu->vcpu_idx : 0;
+	kevent->event = event;
+	kevent->kvm = kvm;
+	kevent->users = 0;
+	kevent->route_mode = route_mode;
+	kevent->route_affinity = route_affinity;
+	kevent->entries[index] = event_entry;
+	kevent->params[index] = event_param;
+	set_bit(index, kevent->registered);
+
+	spin_lock(&event->lock);
+	rb_link_node(&kevent->node, rb_parent, rb_link);
+	rb_insert_color(&kevent->node, &event->root);
+	event->count++;
+	spin_unlock(&event->lock);
+
+unlock:
+	spin_unlock(&kvm_sdei_lock);
+out:
+	return ret;
+}
+
 static unsigned long kvm_sdei_reset(struct kvm *kvm, unsigned int types)
 {
 	struct kvm_sdei_event *e, *event = NULL;
@@ -125,6 +353,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_version(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+		ret = kvm_sdei_hypercall_register(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
 	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
