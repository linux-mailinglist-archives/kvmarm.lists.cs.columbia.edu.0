Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA03E40E999
	for <lists+kvmarm@lfdr.de>; Thu, 16 Sep 2021 20:15:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EC7B4B14D;
	Thu, 16 Sep 2021 14:15:33 -0400 (EDT)
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
	with ESMTP id RN6X5l9FO922; Thu, 16 Sep 2021 14:15:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C71E84B1AB;
	Thu, 16 Sep 2021 14:15:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D10264B16F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDfm+iLmNNju for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Sep 2021 14:15:28 -0400 (EDT)
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com
 [209.85.161.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8F9B44B139
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:28 -0400 (EDT)
Received: by mail-oo1-f73.google.com with SMTP id
 w6-20020a4adec6000000b0028b7d13a4c8so34366897oou.13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=55xrmh9lgMW6M2ssQu0fBglBZGwM9FWEGXzTQGVuGWY=;
 b=Qn9e69PhcaHLM14cvIlW3cb9FlPFIeKSEhZbVl7jFRaO8lwbIpc3Oz5kl45Sw0Vbu8
 YwDWn/DWn30qVhP+vjhXYwB89m0LuyY2EgPnw8F11b2zDtssR/QRzxdsIySIB59DnPf8
 kXh0MVnt1/0Wk+NmZe/Zuj/dqdrikmxuxZX5jXYayKuSHzVMKlDndGNiDP8uk6rDkMpq
 LTp2Wjt95TAxr8eztyyioaUnALuMAwwAnawa8s/XDBHibzrM2kfDaZ3jK0LqZXkYSgbr
 1je2lL8g+29HqtvbtRUfnNyoWzKBEBHM5pJIYTraEeoBng+vBvg9MoYEFElW0sk44y6n
 Q9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=55xrmh9lgMW6M2ssQu0fBglBZGwM9FWEGXzTQGVuGWY=;
 b=FN2DmE0Nv/EMSNV6PC1x/MSqgQDGu1sBoEqRudjXT3sT4rXsZ2OJ0G0QuzJA/rGQ+I
 6Mw5+jWre/NrCPC0zdIgzI5lLPUbT2BM2jE4qFVBaIySrlH6PPEQk7AgMQ9brXN7EQa1
 R96Pu73UvNR6QrPu9AA6b8F9YDFSO57jGR34bIXddOgQEOCaGpOOopZXaY8G86xLR3Q8
 vn/yW/ls7n2AThP558N1ALMRli2mqd+Pa+qjVTASAlh0XGPoq83y+Ou9PmJnZoEgN3sV
 uJCpot/lTqDuMKkpPwO6HmKbwSdk++fTv3RKkID1Oblicx4AKS09HXEdbv3TOjcy4vm2
 5ZfA==
X-Gm-Message-State: AOAM533Y0S/WV+qp7SG1JxW/e87jtRA00o//ZKTIStj2t+As8bF7XP86
 DsE0FQSZGwfVc1sY2nqyIkwRDI8iMJc=
X-Google-Smtp-Source: ABdhPJwZIEsplNCwLDp9os07YQadzLLra9bQkjq4LrDGnDchF5TTdhOL9ohrB/FHpcdY1ozAs2967nYIe7k=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:aca:ac93:: with SMTP id
 v141mr974939oie.20.1631816127883; 
 Thu, 16 Sep 2021 11:15:27 -0700 (PDT)
Date: Thu, 16 Sep 2021 18:15:06 +0000
In-Reply-To: <20210916181510.963449-1-oupton@google.com>
Message-Id: <20210916181510.963449-5-oupton@google.com>
Mime-Version: 1.0
References: <20210916181510.963449-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 4/8] KVM: arm64: Allow userspace to configure a vCPU's
 virtual offset
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

Allow userspace to access the guest's virtual counter-timer offset
through the ONE_REG interface. The value read or written is defined to
be an offset from the guest's physical counter-timer. Add some
documentation to clarify how a VMM should use this and the existing
CNTVCT_EL0.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 Documentation/virt/kvm/api.rst    | 23 +++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/include/uapi/asm/kvm.h |  1 +
 arch/arm64/kvm/arch_timer.c       | 23 +++++++++++++++++++++++
 arch/arm64/kvm/arm.c              |  5 +++++
 arch/arm64/kvm/guest.c            | 21 +++++++++++++++++----
 include/kvm/arm_arch_timer.h      |  1 +
 include/uapi/linux/kvm.h          |  1 +
 8 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a6729c8cf063..5136e61d7587 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -2463,6 +2463,16 @@ arm64 system registers have the following id bit patterns::
      derived from the register encoding for CNTV_CVAL_EL0.  As this is
      API, it must remain this way.
 
+.. warning::
+
+     The value of KVM_REG_ARM_TIMER_OFFSET is defined as an offset from
+     the guest's view of the physical counter-timer.
+
+     Userspace should use either KVM_REG_ARM_TIMER_OFFSET or
+     KVM_REG_ARM_TIMER_CNT to pause and resume a guest's virtual
+     counter-timer. Mixed use of these registers could result in an
+     unpredictable guest counter value.
+
 arm64 firmware pseudo-registers have the following bit pattern::
 
   0x6030 0000 0014 <regno:16>
@@ -7265,3 +7275,16 @@ The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
 of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
 the hypercalls whose corresponding bit is in the argument, and return
 ENOSYS for the others.
+
+8.35 KVM_CAP_ARM_VTIMER_OFFSET
+------------------------------
+
+:Capability: KVM_CAP_ARM_VTIMER_OFFSET
+:Architectures: arm64
+:Type: vm
+
+This capability, if enabled, will cause KVM to expose the
+KVM_REG_ARM_TIMER_OFFSET register offset through the
+KVM_{GET,SET}_ONE_REG and KVM_GET_REG_LIST ioctls. Implementing VMMs
+must observe the warning prescribed in section 4.68 with regard to the
+mixed use of timer registers.
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f8be56d5342b..dd4f6737421c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -136,6 +136,9 @@ struct kvm_arch {
 
 	/* Memory Tagging Extension enabled for the guest */
 	bool mte_enabled;
+
+	/* KVM_REG_ARM_TIMER_OFFSET enabled for the guest */
+	bool vtimer_offset_enabled;
 };
 
 struct kvm_vcpu_fault_info {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index b3edde68bc3e..949a31bc10f0 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -255,6 +255,7 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_TIMER_CTL		ARM64_SYS_REG(3, 3, 14, 3, 1)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
 #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
+#define KVM_REG_ARM_TIMER_OFFSET	ARM64_SYS_REG(3, 4, 14, 0, 3)
 
 /* KVM-as-firmware specific pseudo-registers */
 #define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index cf2f4a034dbe..9d9bac3ec40e 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -92,6 +92,18 @@ static u64 timer_get_offset(struct arch_timer_context *ctxt)
 	}
 }
 
+static u64 timer_get_guest_offset(struct arch_timer_context *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+
+	switch (arch_timer_ctx_index(ctxt)) {
+	case TIMER_VTIMER:
+		return __vcpu_sys_reg(vcpu, CNTVOFF_EL2);
+	default:
+		return 0;
+	}
+}
+
 static void timer_set_ctl(struct arch_timer_context *ctxt, u32 ctl)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
@@ -852,6 +864,10 @@ int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, u64 regid, u64 value)
 		timer = vcpu_vtimer(vcpu);
 		kvm_arm_timer_write(vcpu, timer, TIMER_REG_CVAL, value);
 		break;
+	case KVM_REG_ARM_TIMER_OFFSET:
+		timer = vcpu_vtimer(vcpu);
+		update_vtimer_cntvoff(vcpu, value);
+		break;
 	case KVM_REG_ARM_PTIMER_CTL:
 		timer = vcpu_ptimer(vcpu);
 		kvm_arm_timer_write(vcpu, timer, TIMER_REG_CTL, value);
@@ -896,6 +912,9 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
 	case KVM_REG_ARM_TIMER_CVAL:
 		return kvm_arm_timer_read(vcpu,
 					  vcpu_vtimer(vcpu), TIMER_REG_CVAL);
+	case KVM_REG_ARM_TIMER_OFFSET:
+		return kvm_arm_timer_read(vcpu,
+					  vcpu_vtimer(vcpu), TIMER_REG_OFFSET);
 	case KVM_REG_ARM_PTIMER_CTL:
 		return kvm_arm_timer_read(vcpu,
 					  vcpu_ptimer(vcpu), TIMER_REG_CTL);
@@ -933,6 +952,10 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
 		val = kvm_phys_timer_read() - timer_get_offset(timer);
 		break;
 
+	case TIMER_REG_OFFSET:
+		val = timer_get_guest_offset(timer);
+		break;
+
 	default:
 		BUG();
 	}
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index fe102cd2e518..a562b36f28e2 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -101,6 +101,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_ARM_VTIMER_OFFSET:
+		r = 0;
+		kvm->arch.vtimer_offset_enabled = true;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -215,6 +219,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
 	case KVM_CAP_PTP_KVM:
+	case KVM_CAP_ARM_VTIMER_OFFSET:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index a13a79f5e0e2..098e87451fa5 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -590,16 +590,23 @@ static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
 
 static inline unsigned long num_timer_regs(struct kvm_vcpu *vcpu)
 {
-	return 3;
+	unsigned long nr_regs = 3;
+
+	if (vcpu->kvm->arch.vtimer_offset_enabled)
+		nr_regs++;
+
+	return nr_regs;
 }
 
-static bool is_timer_reg(u64 index)
+static bool is_timer_reg(struct kvm_vcpu *vcpu, u64 index)
 {
 	switch (index) {
 	case KVM_REG_ARM_TIMER_CTL:
 	case KVM_REG_ARM_TIMER_CNT:
 	case KVM_REG_ARM_TIMER_CVAL:
 		return true;
+	case KVM_REG_ARM_TIMER_OFFSET:
+		return vcpu->kvm->arch.vtimer_offset_enabled;
 	}
 	return false;
 }
@@ -615,6 +622,12 @@ static int copy_timer_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	if (put_user(KVM_REG_ARM_TIMER_CVAL, uindices))
 		return -EFAULT;
 
+	if (vcpu->kvm->arch.vtimer_offset_enabled) {
+		uindices++;
+		if (put_user(KVM_REG_ARM_TIMER_OFFSET, uindices))
+			return -EFAULT;
+	}
+
 	return 0;
 }
 
@@ -763,7 +776,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
 	}
 
-	if (is_timer_reg(reg->id))
+	if (is_timer_reg(vcpu, reg->id))
 		return get_timer_reg(vcpu, reg);
 
 	return kvm_arm_sys_reg_get_reg(vcpu, reg);
@@ -781,7 +794,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
 	}
 
-	if (is_timer_reg(reg->id))
+	if (is_timer_reg(vcpu, reg->id))
 		return set_timer_reg(vcpu, reg);
 
 	return kvm_arm_sys_reg_set_reg(vcpu, reg);
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 9d65d4a29f81..615f9314f6a5 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -21,6 +21,7 @@ enum kvm_arch_timer_regs {
 	TIMER_REG_CVAL,
 	TIMER_REG_TVAL,
 	TIMER_REG_CTL,
+	TIMER_REG_OFFSET,
 };
 
 struct arch_timer_context {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a067410ebea5..70c76537417e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_BINARY_STATS_FD 203
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
+#define KVM_CAP_ARM_VTIMER_OFFSET 206
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
