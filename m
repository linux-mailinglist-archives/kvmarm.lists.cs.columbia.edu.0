Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB124E3A45
	for <lists+kvmarm@lfdr.de>; Tue, 22 Mar 2022 09:10:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32B1049F4A;
	Tue, 22 Mar 2022 04:10:52 -0400 (EDT)
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
	with ESMTP id zYlbBQ9I-O21; Tue, 22 Mar 2022 04:10:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CD2649F26;
	Tue, 22 Mar 2022 04:10:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 278F640CDE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:10:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yncZkq4tBFBl for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Mar 2022 04:10:47 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8DA240BE7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 04:10:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647936647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVcTHfrpc1eLanJnwIYziD/n9zbr8iiHwU6wRa4N1ZU=;
 b=VuLs9Ihj/mj3SI3andhlMdbGQbAEWQfBaGa8A9sNSlf3tDYxMD2r30R/uGib7ikYzJ+LW6
 K23i7ee/8t7lKb/KivCUamH2cJb1BWBV+csfJZwdiWo1FT6O46EzBewvxBgr6gLy/1aGN+
 0KdaSMDaQ1a20InjcMneJsY4WpNSuNY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-jQnDMaSINpmzb7YjdNjk1A-1; Tue, 22 Mar 2022 04:10:44 -0400
X-MC-Unique: jQnDMaSINpmzb7YjdNjk1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95C0038041CF;
 Tue, 22 Mar 2022 08:10:43 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96B0C1121324;
 Tue, 22 Mar 2022 08:10:31 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 18/22] KVM: arm64: Support SDEI ioctl commands on VM
Date: Tue, 22 Mar 2022 16:07:06 +0800
Message-Id: <20220322080710.51727-19-gshan@redhat.com>
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

This supports ioctl commands on VM to manage the various objects.
It's primarily used by VMM to accomplish migration. The ioctl
commands introduced by this are highlighted as below:

   * KVM_SDEI_CMD_GET_VERSION
     Retrieve the version of current implementation. It's different
     from the version of the followed SDEI specification. This version
     is used to indicates what functionalities documented in the SDEI
     specification have been supported or not supported.

   * KVM_SDEI_CMD_GET_EXPOSED_EVENT_COUNT
     Return the total count of exposed events.

   * KVM_SDEI_CMD_GET_EXPOSED_EVENT
   * KVM_SDEI_CMD_SET_EXPOSED_EVENT
     Get or set exposed event

   * KVM_SDEI_CMD_GET_REGISTERED_EVENT_COUNT
     Return the total count of registered events.

   * KVM_SDEI_CMD_GET_REGISTERED_EVENT
   * KVM_SDEI_CMD_SET_REGISTERED_EVENT
     Get or set registered event.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h            |   1 +
 arch/arm64/include/uapi/asm/kvm_sdei_state.h |  20 ++
 arch/arm64/kvm/arm.c                         |   3 +
 arch/arm64/kvm/sdei.c                        | 302 +++++++++++++++++++
 include/uapi/linux/kvm.h                     |   3 +
 5 files changed, 329 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 2480ec0e9824..64f00cc79162 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -179,6 +179,7 @@ int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
 			  unsigned long num, bool immediate);
 int kvm_sdei_cancel_event(struct kvm_vcpu *vcpu, unsigned long num);
 void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu);
+long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vm(struct kvm *kvm);
 
diff --git a/arch/arm64/include/uapi/asm/kvm_sdei_state.h b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
index b14844230117..2bd6d11627bc 100644
--- a/arch/arm64/include/uapi/asm/kvm_sdei_state.h
+++ b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
@@ -68,5 +68,25 @@ struct kvm_sdei_vcpu_state {
 	struct kvm_sdei_vcpu_regs_state	normal_regs;
 };
 
+#define KVM_SDEI_CMD_GET_VERSION		0
+#define KVM_SDEI_CMD_GET_EXPOSED_EVENT_COUNT	1
+#define KVM_SDEI_CMD_GET_EXPOSED_EVENT		2
+#define KVM_SDEI_CMD_SET_EXPOSED_EVENT		3
+#define KVM_SDEI_CMD_GET_REGISTERED_EVENT_COUNT	4
+#define KVM_SDEI_CMD_GET_REGISTERED_EVENT	5
+#define KVM_SDEI_CMD_SET_REGISTERED_EVENT	6
+
+struct kvm_sdei_cmd {
+	__u32                                           cmd;
+	union {
+		__u32                                   version;
+		__u32                                   count;
+	};
+	union {
+		struct kvm_sdei_exposed_event_state     *exposed_event_state;
+		struct kvm_sdei_registered_event_state  *registered_event_state;
+	};
+};
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _UAPI__ASM_KVM_SDEI_STATE_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 00c136a6e8df..ebfd504a1c08 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1465,6 +1465,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			return -EFAULT;
 		return kvm_vm_ioctl_mte_copy_tags(kvm, &copy_tags);
 	}
+	case KVM_ARM_SDEI_COMMAND: {
+		return kvm_sdei_vm_ioctl(kvm, arg);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 9f1959653318..d9cf494990a9 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -1265,6 +1265,308 @@ void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.sdei = vsdei;
 }
 
+static long vm_ioctl_get_exposed_event(struct kvm *kvm,
+				       struct kvm_sdei_cmd *cmd)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_exposed_event_state *state;
+	void __user *user_state = (void __user *)(cmd->exposed_event_state);
+	unsigned int count, i;
+	long ret = 0;
+
+	if (!cmd->count)
+		return 0;
+
+	state = kcalloc(cmd->count, sizeof(*state), GFP_KERNEL_ACCOUNT);
+	if (!state)
+		return -ENOMEM;
+
+	i = 0;
+	count = cmd->count;
+	list_for_each_entry(exposed_event, &ksdei->exposed_events, link) {
+		state[i++] = exposed_event->state;
+		if (!--count)
+			break;
+	}
+
+	if (copy_to_user(user_state, state, sizeof(*state) * cmd->count))
+		ret = -EFAULT;
+
+	kfree(state);
+	return ret;
+}
+
+static long vm_ioctl_set_exposed_event(struct kvm *kvm,
+				       struct kvm_sdei_cmd *cmd)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_exposed_event_state *state;
+	void __user *user_state = (void __user *)(cmd->exposed_event_state);
+	unsigned int i, j;
+	long ret = 0;
+
+	if (!cmd->count)
+		return 0;
+
+	if ((ksdei->exposed_event_count + cmd->count) > KVM_SDEI_MAX_EVENTS)
+		return -ERANGE;
+
+	state = kcalloc(cmd->count, sizeof(*state), GFP_KERNEL_ACCOUNT);
+	if (!state)
+		return -ENOMEM;
+
+	if (copy_from_user(state, user_state, sizeof(*state) * cmd->count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	for (i = 0; i < cmd->count; i++) {
+		if (!kvm_sdei_is_supported(state[i].num)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (!kvm_sdei_is_shared(state[i].type) &&
+		    !kvm_sdei_is_private(state[i].type)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (!kvm_sdei_is_critical(state[i].priority) &&
+		    !kvm_sdei_is_normal(state[i].priority)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/*
+		 * Check if the event has been exposed. The notifier is
+		 * allowed to be changed.
+		 */
+		exposed_event = find_exposed_event(kvm, state[i].num);
+		if (exposed_event &&
+		    (state[i].num != exposed_event->state.num           ||
+		     state[i].type != exposed_event->state.type         ||
+		     state[i].signaled != exposed_event->state.signaled ||
+		     state[i].priority != exposed_event->state.priority)) {
+			ret = -EEXIST;
+			goto out;
+		}
+
+		/* Avoid the duplicated event */
+		for (j = 0; j < cmd->count; j++) {
+			if (i != j && state[i].num == state[j].num) {
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	for (i = 0; i < cmd->count; i++) {
+		exposed_event = find_exposed_event(kvm, state[i].num);
+		if (exposed_event) {
+			exposed_event->state = state[i];
+			continue;
+		}
+
+		exposed_event = kzalloc(sizeof(*exposed_event),
+					GFP_KERNEL_ACCOUNT);
+		if (!exposed_event) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		exposed_event->state = state[i];
+		exposed_event->kvm   = kvm;
+
+		ksdei->exposed_event_count++;
+		list_add_tail(&exposed_event->link, &ksdei->exposed_events);
+	}
+
+out:
+	kfree(state);
+	return ret;
+}
+
+static long vm_ioctl_get_registered_event(struct kvm *kvm,
+					  struct kvm_sdei_cmd *cmd)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_registered_event *registered_event;
+	struct kvm_sdei_registered_event_state *state;
+	void __user *user_state = (void __user *)(cmd->registered_event_state);
+	unsigned int count, i;
+	long ret = 0;
+
+	if (!cmd->count)
+		return 0;
+
+	state = kcalloc(cmd->count, sizeof(*state), GFP_KERNEL_ACCOUNT);
+	if (!state)
+		return -ENOMEM;
+
+	i = 0;
+	count = cmd->count;
+	list_for_each_entry(registered_event,
+			    &ksdei->registered_events, link) {
+		state[i++] = registered_event->state;
+		if (!--count)
+			break;
+	}
+
+	if (copy_to_user(user_state, state, sizeof(*state) * cmd->count))
+		ret = -EFAULT;
+
+	kfree(state);
+	return ret;
+}
+
+static long vm_ioctl_set_registered_event(struct kvm *kvm,
+					  struct kvm_sdei_cmd *cmd)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+	struct kvm_sdei_registered_event_state *state;
+	void __user *user_state = (void __user *)(cmd->registered_event_state);
+	unsigned int i, j;
+	long ret = 0;
+
+	if (!cmd->count)
+		return 0;
+
+	if ((ksdei->registered_event_count + cmd->count) > KVM_SDEI_MAX_EVENTS)
+		return -ERANGE;
+
+	state = kcalloc(cmd->count, sizeof(*state), GFP_KERNEL_ACCOUNT);
+	if (!state)
+		return -ENOMEM;
+
+	if (copy_from_user(state, user_state, sizeof(*state) * cmd->count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	for (i = 0; i < cmd->count; i++) {
+		if (!kvm_sdei_is_supported(state[i].num)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (state[i].route_mode != SDEI_EVENT_REGISTER_RM_ANY &&
+		    state[i].route_mode != SDEI_EVENT_REGISTER_RM_PE) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Check if the event has been exposed */
+		exposed_event = find_exposed_event(kvm, state[i].num);
+		if (!exposed_event) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		/* Check if the event has been registered */
+		registered_event = find_registered_event(kvm, state[i].num);
+		if (registered_event) {
+			ret = -EEXIST;
+			goto out;
+		}
+
+		/* Avoid the duplicated event */
+		for (j = 0; j < cmd->count; j++) {
+			if (i != j && state[i].num == state[j].num) {
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	for (i = 0; i < cmd->count; i++) {
+		registered_event = kzalloc(sizeof(*registered_event),
+					   GFP_KERNEL_ACCOUNT);
+		if (!registered_event) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		exposed_event = find_exposed_event(kvm, state[i].num);
+		registered_event->state         = state[i];
+		registered_event->kvm           = kvm;
+		registered_event->exposed_event = exposed_event;
+
+		ksdei->registered_event_count++;
+		exposed_event->registered_event_count++;
+		list_add_tail(&registered_event->link,
+			      &ksdei->registered_events);
+	}
+
+out:
+	kfree(state);
+	return ret;
+}
+
+long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_cmd *cmd;
+	void __user *argp = (void __user *)arg;
+	long ret = 0;
+
+	if (!ksdei)
+		return -EPERM;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL_ACCOUNT);
+	if (!cmd)
+		return -ENOMEM;
+
+	if (copy_from_user(cmd, argp, sizeof(*cmd))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+
+	switch (cmd->cmd) {
+	case KVM_SDEI_CMD_GET_VERSION:
+		cmd->version = (1 << 16);       /* v1.0.0 */
+		if (copy_to_user(argp, cmd, sizeof(*cmd)))
+			ret = -EFAULT;
+		break;
+	case KVM_SDEI_CMD_GET_EXPOSED_EVENT_COUNT:
+		cmd->count = ksdei->exposed_event_count;
+		if (copy_to_user(argp, cmd, sizeof(*cmd)))
+			ret = -EFAULT;
+		break;
+	case KVM_SDEI_CMD_GET_EXPOSED_EVENT:
+		ret = vm_ioctl_get_exposed_event(kvm, cmd);
+		break;
+	case KVM_SDEI_CMD_SET_EXPOSED_EVENT:
+		ret = vm_ioctl_set_exposed_event(kvm, cmd);
+		break;
+	case KVM_SDEI_CMD_GET_REGISTERED_EVENT_COUNT:
+		cmd->count = ksdei->registered_event_count;
+		if (copy_to_user(argp, cmd, sizeof(*cmd)))
+			ret = -EFAULT;
+		break;
+	case KVM_SDEI_CMD_GET_REGISTERED_EVENT:
+		ret = vm_ioctl_get_registered_event(kvm, cmd);
+		break;
+	case KVM_SDEI_CMD_SET_REGISTERED_EVENT:
+		ret = vm_ioctl_set_registered_event(kvm, cmd);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	spin_unlock(&ksdei->lock);
+out:
+
+	kfree(cmd);
+	return ret;
+}
+
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 507ee1f2aa96..2d11c909ec42 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -2049,4 +2049,7 @@ struct kvm_stats_desc {
 /* Available with KVM_CAP_XSAVE2 */
 #define KVM_GET_XSAVE2		  _IOR(KVMIO,  0xcf, struct kvm_xsave)
 
+/* Available with KVM_CAP_ARM_SDEI */
+#define KVM_ARM_SDEI_COMMAND	_IOWR(KVMIO, 0xd0, struct kvm_sdei_cmd)
+
 #endif /* __LINUX_KVM_H */
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
