Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54540E99B
	for <lists+kvmarm@lfdr.de>; Thu, 16 Sep 2021 20:15:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D09504B0B8;
	Thu, 16 Sep 2021 14:15:35 -0400 (EDT)
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
	with ESMTP id 0yxVAU37YFBe; Thu, 16 Sep 2021 14:15:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 126C64B16F;
	Thu, 16 Sep 2021 14:15:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E79864B16C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFOxlBCctAgQ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Sep 2021 14:15:30 -0400 (EDT)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 582754B0B8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:30 -0400 (EDT)
Received: by mail-qt1-f201.google.com with SMTP id
 l22-20020a05622a175600b0029d63a970f6so63127362qtk.23
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=dipIrpzZATGonVYiGwAjXnT9f7aDE2/nEBZeeEl+HAE=;
 b=fdrwNgV0var9ReK53my1Sg+IxZynFfGjeORBxELuzDoGkKHGn//iPCEKZgKQS9DuWC
 DLjt2MFpu/BiR0Kfc7NhxRC80PYWrv6nIstcUfXtEysELCh3waQbX/9ypFfZuWSu8vB7
 BMeI3izHVdGT6Y2jFqfpirRJICUyDZ2vhqkAKCrMrvkqUlxscVYxSb6EVrB056KQ9+zN
 0BVTnSnER6MQHp2YuplBuwQWbS88oml1jZoPJ2o3CKD6V5iHTnhI9EFpCykCwf7mqYLj
 2Xnq7baWCHAoylih6GI26AukaOeQDR5dBLKafG4YXrZQ3hExMFXXI5OJeO4XVFSS2Ib2
 CW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=dipIrpzZATGonVYiGwAjXnT9f7aDE2/nEBZeeEl+HAE=;
 b=nWru657OnoyIFfxfNGU98l3fqH0qVDnuPTHqrorFfhvlRU7bk7ib9eKlyE8MJI7+3H
 AhS5AOiy63Q1sp7tk7PUB14Xqei9RU79/uK0siXITdwzNsIqOHOSLeJoEEkTX5aTICEa
 fWJoXSigrC3A6SfMphSBbh5rwF/GH9xYD/G2bKhGk9puSvAyEQViXiv1Yb0e1nUSP92M
 r+i9ZB2NfQQ7PmoFlK3JGMGe5BASMeJuRFpBn+IjsmaOSp3Stz4CwhHU/pOeP7RjFH6f
 1GQ1hdMbmO7m2sf7UNt32fuVSlS1hYH0E88KcB7G9dWxisV7cHRvzED+q6LVM5jwSMmH
 11lQ==
X-Gm-Message-State: AOAM531XDvz34DEpLQ2k+vRz2CKP/QjRNO9P3OQFGvNnlmxpEXfbmWaI
 BHP+17gNuh0Bsh531oi1rUYKBtFBk/g=
X-Google-Smtp-Source: ABdhPJye4wC5nqfm4XkFXfzIKP+q+VSdx7bMxvPybHCyHUYWL+c3+cKdlDBiOStJIYufJU/TW2zN0DYcbdg=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6214:1593:: with SMTP id
 m19mr6800612qvw.36.1631816129947; Thu, 16 Sep 2021 11:15:29 -0700 (PDT)
Date: Thu, 16 Sep 2021 18:15:08 +0000
In-Reply-To: <20210916181510.963449-1-oupton@google.com>
Message-Id: <20210916181510.963449-7-oupton@google.com>
Mime-Version: 1.0
References: <20210916181510.963449-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 6/8] KVM: arm64: Allow userspace to configure a guest's
 counter-timer offset
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

Presently, KVM provides no facilities for correctly migrating a guest
that depends on the physical counter-timer. While most guests (barring
NV, of course) should not depend on the physical counter-timer, an
operator may wish to provide a consistent view of the physical
counter-timer across migrations.

Provide userspace with a new vCPU attribute to modify the guest
counter-timer offset. Unlike KVM_REG_ARM_TIMER_OFFSET, this attribute is
hidden from the guest's architectural state. The value offsets *both*
the virtual and physical counter-timer views for the guest. Only support
this attribute on ECV systems as ECV is required for hardware offsetting
of the physical counter-timer.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 Documentation/arm64/booting.rst         |  7 ++
 Documentation/virt/kvm/devices/vcpu.rst | 28 ++++++++
 arch/arm64/include/asm/sysreg.h         |  2 +
 arch/arm64/include/uapi/asm/kvm.h       |  1 +
 arch/arm64/kvm/arch_timer.c             | 96 ++++++++++++++++++++++++-
 include/clocksource/arm_arch_timer.h    |  1 +
 include/kvm/arm_arch_timer.h            |  5 ++
 7 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 3f9d86557c5e..b0e012da9b3b 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -340,6 +340,13 @@ Before jumping into the kernel, the following conditions must be met:
     - SMCR_EL2.LEN must be initialised to the same value for all CPUs the
       kernel will execute on.
 
+  For CPUs with the Enhanced Counter Virtualization (FEAT_ECV) extension
+  present with ID_AA64MMFR0_EL1.ECV >= 0x2:
+
+  - if EL3 is present and the kernel is entered at EL2:
+
+    - SCR_EL3.ECVEn (bit 28) must be initialized to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 2acec3b9ef65..f240ecc174ef 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -139,6 +139,34 @@ configured values on other VCPUs.  Userspace should configure the interrupt
 numbers on at least one VCPU after creating all VCPUs and before running any
 VCPUs.
 
+2.2. ATTRIBUTE: KVM_ARM_VCPU_TIMER_PHYS_OFFSET
+-----------------------------------------
+
+:Parameters: in kvm_device_attr.addr the address for the timer offset is a
+             pointer to a __u64
+
+Returns:
+
+	 ======= ==================================
+	 -EFAULT Error reading/writing the provided
+		 parameter address
+	 -ENXIO  Timer offsetting not implemented
+	 ======= ==================================
+
+Specifies the guest's counter-timer offset from the host's virtual counter.
+The guest's physical counter value is then derived by the following
+equation:
+
+  guest_cntpct = host_cntvct - KVM_ARM_VCPU_TIMER_PHYS_OFFSET
+
+The guest's virtual counter value is derived by the following equation:
+
+  guest_cntvct = host_cntvct - KVM_REG_ARM_TIMER_OFFSET
+			- KVM_ARM_VCPU_TIMER_PHYS_OFFSET
+
+KVM does not allow the use of varying offset values for different vCPUs;
+the last written offset value will be broadcasted to all vCPUs in a VM.
+
 3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL
 ==================================
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 3fa6b091384d..d5a686dff57e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -587,6 +587,8 @@
 #define SYS_ICH_LR14_EL2		__SYS__LR8_EL2(6)
 #define SYS_ICH_LR15_EL2		__SYS__LR8_EL2(7)
 
+#define SYS_CNTPOFF_EL2			sys_reg(3, 4, 14, 0, 6)
+
 /* VHE encodings for architectural EL0/1 system registers */
 #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
 #define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 949a31bc10f0..70e2893c1749 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -366,6 +366,7 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
+#define   KVM_ARM_VCPU_TIMER_PHYS_OFFSET	2
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
 
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 9d9bac3ec40e..4bba149d140c 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -86,8 +86,11 @@ static u64 timer_get_offset(struct arch_timer_context *ctxt)
 {
 	switch(arch_timer_ctx_index(ctxt)) {
 	case TIMER_VTIMER:
+	case TIMER_PTIMER:
 		return ctxt->host_offset;
 	default:
+		WARN_ONCE(1, "unrecognized timer %ld\n",
+			  arch_timer_ctx_index(ctxt));
 		return 0;
 	}
 }
@@ -140,6 +143,7 @@ static void timer_set_offset(struct arch_timer_context *ctxt, u64 offset)
 {
 	switch(arch_timer_ctx_index(ctxt)) {
 	case TIMER_VTIMER:
+	case TIMER_PTIMER:
 		ctxt->host_offset = offset;
 		break;
 	default:
@@ -568,6 +572,11 @@ static void set_cntvoff(u64 cntvoff)
 	kvm_call_hyp(__kvm_timer_set_cntvoff, cntvoff);
 }
 
+static void set_cntpoff(u64 cntpoff)
+{
+	write_sysreg_s(cntpoff, SYS_CNTPOFF_EL2);
+}
+
 static inline void set_timer_irq_phys_active(struct arch_timer_context *ctx, bool active)
 {
 	int r;
@@ -643,6 +652,8 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
 	}
 
 	set_cntvoff(timer_get_offset(map.direct_vtimer));
+	if (kvm_timer_physical_offset_allowed())
+		set_cntpoff(timer_get_offset(map.direct_ptimer));
 
 	kvm_timer_unblocking(vcpu);
 
@@ -810,6 +821,22 @@ static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
 	mutex_unlock(&kvm->lock);
 }
 
+static void update_ptimer_cntpoff(struct kvm_vcpu *vcpu, u64 cntpoff)
+{
+	struct kvm *kvm = vcpu->kvm;
+	u64 cntvoff;
+
+	mutex_lock(&kvm->lock);
+
+	/* adjustments to the physical offset also affect vtimer */
+	cntvoff = timer_get_offset(vcpu_vtimer(vcpu));
+	cntvoff += cntpoff - timer_get_offset(vcpu_ptimer(vcpu));
+
+	update_timer_offset(vcpu, TIMER_PTIMER, cntpoff, false);
+	update_timer_offset(vcpu, TIMER_VTIMER, cntvoff, false);
+	mutex_unlock(&kvm->lock);
+}
+
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
@@ -1346,6 +1373,9 @@ void kvm_timer_init_vhe(void)
 	val = read_sysreg(cnthctl_el2);
 	val |= (CNTHCTL_EL1PCEN << cnthctl_shift);
 	val |= (CNTHCTL_EL1PCTEN << cnthctl_shift);
+
+	if (cpus_have_final_cap(ARM64_HAS_ECV2))
+		val |= CNTHCTL_ECV;
 	write_sysreg(val, cnthctl_el2);
 }
 
@@ -1360,7 +1390,8 @@ static void set_timer_irqs(struct kvm *kvm, int vtimer_irq, int ptimer_irq)
 	}
 }
 
-int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+static int kvm_arm_timer_set_attr_irq(struct kvm_vcpu *vcpu,
+				      struct kvm_device_attr *attr)
 {
 	int __user *uaddr = (int __user *)(long)attr->addr;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
@@ -1393,7 +1424,37 @@ int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	return 0;
 }
 
-int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+static int kvm_arm_timer_set_attr_offset(struct kvm_vcpu *vcpu,
+					 struct kvm_device_attr *attr)
+{
+	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
+	u64 offset;
+
+	if (!kvm_timer_physical_offset_allowed())
+		return -ENXIO;
+
+	if (get_user(offset, uaddr))
+		return -EFAULT;
+
+	update_ptimer_cntpoff(vcpu, offset);
+	return 0;
+}
+
+int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
+	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
+		return kvm_arm_timer_set_attr_irq(vcpu, attr);
+	case KVM_ARM_VCPU_TIMER_PHYS_OFFSET:
+		return kvm_arm_timer_set_attr_offset(vcpu, attr);
+	default:
+		return -ENXIO;
+	}
+}
+
+static int kvm_arm_timer_get_attr_irq(struct kvm_vcpu *vcpu,
+				      struct kvm_device_attr *attr)
 {
 	int __user *uaddr = (int __user *)(long)attr->addr;
 	struct arch_timer_context *timer;
@@ -1414,12 +1475,43 @@ int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	return put_user(irq, uaddr);
 }
 
+static int kvm_arm_timer_get_attr_offset(struct kvm_vcpu *vcpu,
+					 struct kvm_device_attr *attr)
+{
+	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
+	u64 offset;
+
+	if (!kvm_timer_physical_offset_allowed())
+		return -ENXIO;
+
+	offset = timer_get_offset(vcpu_ptimer(vcpu));
+	return put_user(offset, uaddr);
+}
+
+int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu,
+			   struct kvm_device_attr *attr)
+{
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
+	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
+		return kvm_arm_timer_get_attr_irq(vcpu, attr);
+	case KVM_ARM_VCPU_TIMER_PHYS_OFFSET:
+		return kvm_arm_timer_get_attr_offset(vcpu, attr);
+	default:
+		return -ENXIO;
+	}
+}
+
 int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
 	switch (attr->attr) {
 	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
 	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
 		return 0;
+	case KVM_ARM_VCPU_TIMER_PHYS_OFFSET:
+		if (kvm_timer_physical_offset_allowed())
+			return 0;
+		break;
 	}
 
 	return -ENXIO;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 73c7139c866f..7252ffa3d675 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -21,6 +21,7 @@
 #define CNTHCTL_EVNTEN			(1 << 2)
 #define CNTHCTL_EVNTDIR			(1 << 3)
 #define CNTHCTL_EVNTI			(0xF << 4)
+#define CNTHCTL_ECV			(1 << 12)
 
 enum arch_timer_reg {
 	ARCH_TIMER_REG_CTRL,
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 615f9314f6a5..aa666373f603 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -110,4 +110,9 @@ void kvm_arm_timer_write_sysreg(struct kvm_vcpu *vcpu,
 u32 timer_get_ctl(struct arch_timer_context *ctxt);
 u64 timer_get_cval(struct arch_timer_context *ctxt);
 
+static inline bool kvm_timer_physical_offset_allowed(void)
+{
+	return cpus_have_final_cap(ARM64_HAS_ECV2) && has_vhe();
+}
+
 #endif
-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
