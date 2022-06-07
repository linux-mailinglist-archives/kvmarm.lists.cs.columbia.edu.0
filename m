Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8B535AEF
	for <lists+kvmarm@lfdr.de>; Fri, 27 May 2022 10:04:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 109404B26D;
	Fri, 27 May 2022 04:04:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ID5Xy0M+olk2; Fri, 27 May 2022 04:04:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77C034B358;
	Fri, 27 May 2022 04:04:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 97B2A4B29C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 May 2022 04:04:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JL+o2pUzhze3 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 May 2022 04:04:12 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B5594B2A7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 May 2022 04:04:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653638650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRMSD2W8voEL7eRWyVgzB/wWa0yFOUK9oL5qAtEgNaU=;
 b=WGaqvAjfT8jdagLv8HZhu41/HZjRHXDRaRW/2FyzcGfhBVdTqQJ3YUcAB/sovF+1fw3cIe
 hQOHkrtevNOkQCONmGia4BiNgmUvvXMDsgxn/sAEIxgOgS9iJI+xMYXdm4C0lwRTU7lOej
 ZkWTqmyImN7VkRukriC/vsMDCMYnMz8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-OFBKgQpaPbW8NeH7NpvF0Q-1; Fri, 27 May 2022 04:04:07 -0400
X-MC-Unique: OFBKgQpaPbW8NeH7NpvF0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED8FB185A7B2;
 Fri, 27 May 2022 08:04:06 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 941352026985;
 Fri, 27 May 2022 08:04:00 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v7 03/22] KVM: arm64: Add SDEI virtualization infrastructure
Date: Fri, 27 May 2022 16:02:34 +0800
Message-Id: <20220527080253.1562538-4-gshan@redhat.com>
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

Software Delegated Exception Interface (SDEI) provides a mechanism
for registering and servicing system events, as defined by ARM DEN0054C
specification. One of these events will be used by Asynchronous Page
Fault (Async PF) to deliver notifications from host to guest.

The events are classified into shared and private ones according to
their scopes. The shared events are system or VM scoped, but the
private events are CPU or VCPU scoped. The shared events can be
registered, enabled, unregistered and reset through hypercalls
issued from any VCPU. However, the private events are registered,
enabled, unregistered and reset on the calling VCPU through
hypercalls. Besides, the events are also classified into critical
and normal events according their priority. During event delivery
and handling, the normal event can be preempted by another critical
event, but not in reverse way. The critical event can't be preempted
by another normal event.

In the implementation, both shared event and critical event aren't
supported. It means all supported events are private and normal.
There are several objects introduced to manage events and their
states.

  * kvm_sdei_event_handler
    SDEI event handler, which is provided through EVENT_REGISTER
    hypercall, is called when the SDEI event is delivered from
    host to guest.

  * kvm_sdei_event_context
    The saved (preempted) context when SDEI event is delivered
    for handling.

  * kvm_sdei_vcpu
    SDEI events and their states.

The flag KVM_ARM64_SDEI_MASKED is set to mask vCPU from SDEI events
by default. Besides, SDEI_NOT_SUPPORTED is returned for all hypercalls
at present. The hypercalls will be supported one by one in subsequent
patches.

Link: Link: https://developer.arm.com/documentation/den0054/latest
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +
 arch/arm64/include/asm/kvm_sdei.h | 70 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/Makefile           |  2 +-
 arch/arm64/kvm/arm.c              |  4 ++
 arch/arm64/kvm/hypercalls.c       |  3 ++
 arch/arm64/kvm/sdei.c             | 59 ++++++++++++++++++++++++++
 include/linux/arm-smccc.h         |  2 +
 7 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/kvm/sdei.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 47a1e25e25bb..c9d053c2569e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -366,6 +366,7 @@ struct kvm_vcpu_arch {
 	 * Anything that is not used directly from assembly code goes
 	 * here.
 	 */
+	struct kvm_sdei_vcpu *sdei;
 
 	/*
 	 * Guest registers we preserve during guest debugging.
@@ -466,6 +467,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_ON_UNSUPPORTED_CPU	(1 << 15) /* Physical CPU not in supported_cpus */
 #define KVM_ARM64_HOST_SME_ENABLED	(1 << 16) /* SME enabled for EL0 */
 #define KVM_ARM64_WFIT			(1 << 17) /* WFIT instruction trapped */
+#define KVM_ARM64_SDEI_MASKED		(1 << 18) /* SDEI is masked */
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
new file mode 100644
index 000000000000..609338b17478
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Definitions of various KVM SDEI events.
+ *
+ * Copyright (C) 2022 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#ifndef __ARM64_KVM_SDEI_H__
+#define __ARM64_KVM_SDEI_H__
+
+#include <uapi/linux/arm_sdei.h>
+#include <linux/arm-smccc.h>
+#include <linux/bits.h>
+
+enum {
+	KVM_NR_SDEI_EVENTS,
+};
+
+/**
+ * struct kvm_sdei_event_handler - SDEI event handler
+ *
+ * @ep_addr:	Address of SDEI event handler
+ * @ep_arg:	Argument passed to SDEI event handler
+ */
+struct kvm_sdei_event_handler {
+	unsigned long	ep_addr;
+	unsigned long	ep_arg;
+};
+
+/**
+ * struct kvm_sdei_event_context - Saved context during SDEI event delivery
+ *
+ * @pc:		PC of the saved context
+ * @pstate:	PSTATE of the saved context
+ * @regs:	x0 to x17 of the saved context
+ */
+struct kvm_sdei_event_context {
+	unsigned long	pc;
+	unsigned long	pstate;
+	unsigned long	regs[18];
+};
+
+/**
+ * struct kvm_sdei_vcpu - SDEI events and their sates
+ *
+ * @registered:	Bitmap of registration states for SDEI events
+ * @enabled:	Bitmap of enablement states for SDEI events
+ * @running:	Bitmap of running states for SDEI events
+ * @pending:	Bitmap of pending states for SDEI events
+ * @handlers:	Array of SDEI event handlers
+ * @ctxt:	Saved context during SDEI event delivery
+ */
+struct kvm_sdei_vcpu {
+	unsigned long			registered;
+	unsigned long			enabled;
+	unsigned long			running;
+	unsigned long			pending;
+
+	struct kvm_sdei_event_handler	handlers[KVM_NR_SDEI_EVENTS];
+	struct kvm_sdei_event_context	ctxt;
+};
+
+/* APIs */
+int kvm_sdei_call(struct kvm_vcpu *vcpu);
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
+
+#endif /* __ARM64_KVM_SDEI_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index aa127ae9f675..26e9d62875a8 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -14,7 +14,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pkvm.o \
-	 arch_timer.o trng.o vmid.o \
+	 arch_timer.o trng.o vmid.o sdei.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 400bb0fe2745..e9516f951e7b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -38,6 +38,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_sdei.h>
 #include <asm/sections.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -337,6 +338,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
+	kvm_sdei_create_vcpu(vcpu);
+
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
 
 	err = kvm_vgic_vcpu_init(vcpu);
@@ -358,6 +361,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_pmu_vcpu_destroy(vcpu);
+	kvm_sdei_destroy_vcpu(vcpu);
 
 	kvm_arm_vcpu_destroy(vcpu);
 }
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index d66f464e0eb5..88561ac47301 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -5,6 +5,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_sdei.h>
 
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
@@ -199,6 +200,8 @@ static int kvm_hvc_standard(struct kvm_vcpu *vcpu, u32 func)
 	switch (ARM_SMCCC_FUNC_NUM(func)) {
 	case ARM_SMCCC_STANDARD_PSCI_START ... ARM_SMCCC_STANDARD_PSCI_END:
 		return kvm_psci_call(vcpu);
+	case ARM_SMCCC_STANDARD_SDEI_START ... ARM_SMCCC_STANDARD_SDEI_END:
+		return kvm_sdei_call(vcpu);
 	case ARM_SMCCC_STANDARD_TRNG_START ... ARM_SMCCC_STANDARD_TRNG_END:
 		return kvm_trng_call(vcpu);
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
new file mode 100644
index 000000000000..0c4415fcad16
--- /dev/null
+++ b/arch/arm64/kvm/sdei.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDEI virtualization support.
+ *
+ * Copyright (C) 2022 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/slab.h>
+#include <kvm/arm_hypercalls.h>
+#include <asm/kvm_sdei.h>
+
+int kvm_sdei_call(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	u32 func = smccc_get_function(vcpu);
+	bool has_result = true;
+	unsigned long ret;
+
+	/* No return value for COMPLETE or COMPLETE_AND_RESUME */
+	if (func == SDEI_1_0_FN_SDEI_EVENT_COMPLETE ||
+	    func == SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME)
+		has_result = false;
+
+	if (!vsdei) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	switch (func) {
+	default:
+		ret = SDEI_NOT_SUPPORTED;
+	}
+
+out:
+	if (has_result)
+		smccc_set_retval(vcpu, ret, 0, 0, 0);
+
+	return 1;
+}
+
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei;
+
+	vcpu->arch.sdei = kzalloc(sizeof(*vsdei), GFP_KERNEL_ACCOUNT);
+	if (vcpu->arch.sdei)
+		vcpu->arch.flags |= KVM_ARM64_SDEI_MASKED;
+}
+
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.flags &= ~KVM_ARM64_SDEI_MASKED;
+	kfree(vcpu->arch.sdei);
+	vcpu->arch.sdei = NULL;
+}
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 834fb963a689..18159a9c6703 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -57,6 +57,8 @@
 
 #define ARM_SMCCC_STANDARD_PSCI_START	0x0000
 #define ARM_SMCCC_STANDARD_PSCI_END	0x001f
+#define ARM_SMCCC_STANDARD_SDEI_START	0x0020
+#define ARM_SMCCC_STANDARD_SDEI_END	0x003f
 #define ARM_SMCCC_STANDARD_TRNG_START	0x0050
 #define ARM_SMCCC_STANDARD_TRNG_END	0x005f
 
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
