Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 487383D99F8
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 02:10:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EBAC14B0C3;
	Wed, 28 Jul 2021 20:10:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JhXCphrTEKux; Wed, 28 Jul 2021 20:10:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C9524B0F8;
	Wed, 28 Jul 2021 20:10:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C7594086C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 20:10:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZIT0zntoJgXi for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Jul 2021 20:10:31 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 646DA4B09B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 20:10:31 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 t101-20020a25aaee0000b0290578c0c455b2so4848393ybi.13
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 17:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=5DbD1Q+qmrgXW1lgcWRvAuq0EQtstHhiJ0h0O5Opgts=;
 b=Z0pFd+fRkipK8U/pIAuUqtwvdVc9bEtZHmh/lq85Abvzhs5wjcYtzX2H3ZtFokcwqx
 eFSqqr2JIZzkkdZ2Sgoj19OzmTFwDsaozKtGyeK8AzoZqClGTmfVmPxopBamClvTTpRf
 kZmLya08L+m+O/tFpv9IXq/kfLsueulX4mGILCb9UBg47awjjy/LxWbS4/XUJcs4+fxO
 eiDGg5elS7VOqz54L3FzfLusNXSYZNpqXPV3oEa/OaeYy4y7KFJsgAB5MxOi8smZQ6AT
 jyhCHBP/iIoWJZgL7SgImPXg1TK29bNScECn30ZqGmtRP74JLyoWf9XdrQTzfPZGydOB
 RYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=5DbD1Q+qmrgXW1lgcWRvAuq0EQtstHhiJ0h0O5Opgts=;
 b=rkO1s/camTgbSFmdsYvO0EG4N71xtr/FOQCqPzz4FuDW6geYH9cvk7uU/d9rLPuh3X
 ray3wCQv6VoySx92KpBafTguBlxqslhFRFE8O85rnA9HlRWuQrVjbFGQVYmESs9EnYkR
 eZB+ugCEld5xlgxVO/Cx2q2vEAwGCsBtcPw7hFMAeU9Yi4WUMmZmlBdfbdLmiQhmM98k
 3RFwk86Ee5F0lqcNPCMSGcnzI3RjfYk5lOsV2VY+tU3+2RGRUp8sODeIyxLydNlLs4ja
 eLHuMGIHborTk3QUyhOQG0HnJvVTzzPJMXecasHNi5i0L6H8FvnA+47sab+VGTLMcdV4
 /Pug==
X-Gm-Message-State: AOAM532sMwGFrhnrciC/yapEMQzWycfWXhPyG1AGdVS+crRer+SlFoC+
 7Jd+OyKhA2DMr40Npbnvz5LMWAZ90yM=
X-Google-Smtp-Source: ABdhPJz/QxbjCh4OAB6U0SLDDIYt3vC9UfRhP52R2YQR2YhIealazv3Pac7KW7OwIkfUIEfN9ABqvxBOSnI=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a25:6088:: with SMTP id
 u130mr3181834ybb.257.1627517430962; 
 Wed, 28 Jul 2021 17:10:30 -0700 (PDT)
Date: Thu, 29 Jul 2021 00:10:08 +0000
In-Reply-To: <20210729001012.70394-1-oupton@google.com>
Message-Id: <20210729001012.70394-10-oupton@google.com>
Mime-Version: 1.0
References: <20210729001012.70394-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v4 09/13] KVM: arm64: Allow userspace to configure a vCPU's
 virtual offset
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

Add a new vCPU attribute that allows userspace to directly manipulate
the virtual counter-timer offset. Exposing such an interface allows for
the precise migration of guest virtual counter-timers, as it is an
indepotent interface.

Uphold the existing behavior of writes to CNTVOFF_EL2 for this new
interface, wherein a write to a single vCPU is broadcasted to all vCPUs
within a VM.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 Documentation/virt/kvm/devices/vcpu.rst | 22 ++++++++
 arch/arm64/include/uapi/asm/kvm.h       |  1 +
 arch/arm64/kvm/arch_timer.c             | 68 ++++++++++++++++++++++++-
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index b46d5f742e69..7b57cba3416a 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -139,6 +139,28 @@ configured values on other VCPUs.  Userspace should configure the interrupt
 numbers on at least one VCPU after creating all VCPUs and before running any
 VCPUs.
 
+2.2. ATTRIBUTE: KVM_ARM_VCPU_TIMER_OFFSET_VTIMER
+------------------------------------------------
+
+:Parameters: Pointer to a 64-bit unsigned counter-timer offset.
+
+Returns:
+
+	 ======= ======================================
+	 -EFAULT Error reading/writing the provided
+	 	 parameter address
+	 -ENXIO  Attribute not supported
+	 ======= ======================================
+
+Specifies the guest's virtual counter-timer offset from the host's
+virtual counter. The guest's virtual counter is then derived by
+the following equation:
+
+  guest_cntvct = host_cntvct - KVM_ARM_VCPU_TIMER_OFFSET_VTIMER
+
+KVM does not allow the use of varying offset values for different vCPUs;
+the last written offset value will be broadcasted to all vCPUs in a VM.
+
 3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL
 ==================================
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index b3edde68bc3e..008d0518d2b1 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -365,6 +365,7 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
+#define   KVM_ARM_VCPU_TIMER_OFFSET_VTIMER	2
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
 
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 3df67c127489..d2b1b13af658 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -1305,7 +1305,7 @@ static void set_timer_irqs(struct kvm *kvm, int vtimer_irq, int ptimer_irq)
 	}
 }
 
-int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+int kvm_arm_timer_set_attr_irq(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
 	int __user *uaddr = (int __user *)(long)attr->addr;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
@@ -1338,7 +1338,39 @@ int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	return 0;
 }
 
-int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+int kvm_arm_timer_set_attr_offset(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
+	u64 offset;
+
+	if (get_user(offset, uaddr))
+		return -EFAULT;
+
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
+		update_vtimer_cntvoff(vcpu, offset);
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
+	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
+		return kvm_arm_timer_set_attr_irq(vcpu, attr);
+	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
+		return kvm_arm_timer_set_attr_offset(vcpu, attr);
+	}
+
+	return -ENXIO;
+}
+
+int kvm_arm_timer_get_attr_irq(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
 	int __user *uaddr = (int __user *)(long)attr->addr;
 	struct arch_timer_context *timer;
@@ -1359,11 +1391,43 @@ int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	return put_user(irq, uaddr);
 }
 
+int kvm_arm_timer_get_attr_offset(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
+	struct arch_timer_context *timer;
+	u64 offset;
+
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
+		timer = vcpu_vtimer(vcpu);
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	offset = timer_get_offset(timer);
+	return put_user(offset, uaddr);
+}
+
+int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
+	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
+		return kvm_arm_timer_get_attr_irq(vcpu, attr);
+	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
+		return kvm_arm_timer_get_attr_offset(vcpu, attr);
+	}
+
+	return -ENXIO;
+}
+
 int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
 	switch (attr->attr) {
 	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
 	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
+	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
 		return 0;
 	}
 
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
