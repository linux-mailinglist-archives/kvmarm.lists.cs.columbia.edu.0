Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E91F01A448C
	for <lists+kvmarm@lfdr.de>; Fri, 10 Apr 2020 11:42:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B3184B1F2;
	Fri, 10 Apr 2020 05:42:28 -0400 (EDT)
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
	with ESMTP id jRxoeB6suoM9; Fri, 10 Apr 2020 05:42:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 095CB4B1DE;
	Fri, 10 Apr 2020 05:42:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 39AD64B0E7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Apr 2020 04:59:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDpgcrfRu4-R for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Apr 2020 04:59:25 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E15C94B126
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Apr 2020 04:59:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586509165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qp85j3Ww6peY8Wbag3wB90rR+4zWsfNL0ygD8ka/6uQ=;
 b=RIEbjLMhbla78Z8JhwUAGJgJv71ARj2pt1NECbHC2T4dXHJQRAjlJaW2XmF1uXgYibYLUn
 ud7x4ExpvAoCTwBoI3Rl8UyB621V3WHcDB8eq4eZbze6Ci5Kg8jcKUeGhx2pYvLeisxYMz
 W6CjJv3rWKCvDCN7l4LR2QlL+gDmTn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-EO1QQ635NFCAijv335azhQ-1; Fri, 10 Apr 2020 04:59:22 -0400
X-MC-Unique: EO1QQ635NFCAijv335azhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D16178017FE;
 Fri, 10 Apr 2020 08:59:20 +0000 (UTC)
Received: from 192-168-1-115.tpgi.com.com (vpn2-54-29.bne.redhat.com
 [10.64.54.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9637B5E001;
 Fri, 10 Apr 2020 08:59:17 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH RFCv1 7/7] arm64: Support async page fault
Date: Fri, 10 Apr 2020 18:58:20 +1000
Message-Id: <20200410085820.758686-8-gshan@redhat.com>
In-Reply-To: <20200410085820.758686-1-gshan@redhat.com>
References: <20200410085820.758686-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Fri, 10 Apr 2020 05:42:17 -0400
Cc: maz@kernel.org, sudeep.holla@arm.com, shan.gavin@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

This supports asynchronous page fault for the guest. The design is
similar to what x86 has: on receiving a PAGE_NOT_PRESENT signal from
the hypervisor, the current task is either rescheduled or put into
power-saving mode. The task will be waken up when PAGE_READY signal
is received.

The signals are conveyed through data abort with specific (IMPDEF)
Data Fault Status Code (DFSC). Besides, a hash table is introduced
to track the processes that have been put into waiting state, to
avoid out-of-consistency.

The feature is put into the CONFIG_KVM_GUEST umbrella, which is added
by this patch.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/Kconfig                 |  11 ++
 arch/arm64/include/asm/exception.h |   5 +
 arch/arm64/include/asm/kvm_para.h  |  42 ++++-
 arch/arm64/kernel/smp.c            |  47 ++++++
 arch/arm64/mm/fault.c              | 239 ++++++++++++++++++++++++++++-
 5 files changed, 336 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..2d5e5ee62d6d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1045,6 +1045,17 @@ config PARAVIRT
 	  under a hypervisor, potentially improving performance significantly
 	  over full virtualization.
 
+config KVM_GUEST
+	bool "KVM Guest Support"
+	depends on PARAVIRT
+	default y
+	help
+	  This option enables various optimizations for running under the KVM
+	  hypervisor. Overhead for the kernel when not running inside KVM should
+	  be minimal.
+
+	  In case of doubt, say Y
+
 config PARAVIRT_TIME_ACCOUNTING
 	bool "Paravirtual steal time accounting"
 	select PARAVIRT
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 7a6e81ca23a8..17ac2db36472 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -46,4 +46,9 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr);
 void do_cp15instr(unsigned int esr, struct pt_regs *regs);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
+
+#ifdef CONFIG_KVM_GUEST
+void kvm_pv_async_pf_enable(void);
+void kvm_pv_async_pf_disable(void);
+#endif /* CONFIG_KVM_GUEST */
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/kvm_para.h b/arch/arm64/include/asm/kvm_para.h
index 0ea481dd1c7a..a43bed479c2b 100644
--- a/arch/arm64/include/asm/kvm_para.h
+++ b/arch/arm64/include/asm/kvm_para.h
@@ -3,6 +3,30 @@
 #define _ASM_ARM_KVM_PARA_H
 
 #include <uapi/asm/kvm_para.h>
+#include <linux/of.h>
+
+#ifdef CONFIG_KVM_GUEST
+static inline int kvm_para_available(void)
+{
+	struct device_node *hyper_node;
+	int ret = 0;
+
+	hyper_node = of_find_node_by_path("/hypervisor");
+	if (!hyper_node)
+		return 0;
+
+	if (of_device_is_compatible(hyper_node, "linux,kvm"))
+		ret = 1;
+
+	of_node_put(hyper_node);
+	return ret;
+}
+#else
+static inline int kvm_para_available(void)
+{
+	return 0;
+}
+#endif /* CONFIG_KVM_GUEST */
 
 static inline bool kvm_check_and_clear_guest_paused(void)
 {
@@ -11,17 +35,21 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 
 static inline unsigned int kvm_arch_para_features(void)
 {
-	return 0;
+	struct device_node *hyper_node;
+	unsigned int features = 0;
+
+	if (!kvm_para_available())
+		return 0;
+
+	hyper_node = of_find_node_by_path("/hypervisor");
+	of_property_read_u32(hyper_node, "para-features", &features);
+	of_node_put(hyper_node);
+
+	return features;
 }
 
 static inline unsigned int kvm_arch_para_hints(void)
 {
 	return 0;
 }
-
-static inline bool kvm_para_available(void)
-{
-	return false;
-}
-
 #endif /* _ASM_ARM_KVM_PARA_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 061f60fe452f..cc97a8462d7f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -40,6 +40,7 @@
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/daifflags.h>
+#include <asm/exception.h>
 #include <asm/kvm_mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
@@ -443,6 +444,38 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	mark_linear_text_alias_ro();
 }
 
+#ifdef CONFIG_KVM_GUEST
+static void kvm_cpu_reboot(void *unused)
+{
+	kvm_pv_async_pf_disable();
+}
+
+static int kvm_cpu_reboot_notify(struct notifier_block *nb,
+				 unsigned long code, void *unused)
+{
+	if (code == SYS_RESTART)
+		on_each_cpu(kvm_cpu_reboot, NULL, 1);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kvm_cpu_reboot_nb = {
+	.notifier_call = kvm_cpu_reboot_notify,
+};
+
+static int kvm_cpu_online(unsigned int cpu)
+{
+	kvm_pv_async_pf_enable();
+	return 0;
+}
+
+static int kvm_cpu_offline(unsigned int cpu)
+{
+	kvm_pv_async_pf_disable();
+	return 0;
+}
+#endif /* CONFIG_KVM_GUEST */
+
 void __init smp_prepare_boot_cpu(void)
 {
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
@@ -458,6 +491,20 @@ void __init smp_prepare_boot_cpu(void)
 	/* Conditionally switch to GIC PMR for interrupt masking */
 	if (system_uses_irq_prio_masking())
 		init_gic_priority_masking();
+
+
+	/* Enable async page fault */
+#ifdef CONFIG_KVM_GUEST
+	register_reboot_notifier(&kvm_cpu_reboot_nb);
+	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+		"arm/kvm:online", kvm_cpu_online, kvm_cpu_offline) < 0) {
+		pr_warn("%s: Failed to install cpu hotplug callbacks\n",
+			__func__);
+		return;
+	}
+
+	kvm_pv_async_pf_enable();
+#endif /* CONFIG_KVM_GUEST */
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1027851d469a..39c7570fe303 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -19,10 +19,12 @@
 #include <linux/page-flags.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/swait.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/kvm_para.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -48,8 +50,31 @@ struct fault_info {
 	const char *name;
 };
 
+#ifdef CONFIG_KVM_GUEST
+#define KVM_TASK_SLEEP_HASHBITS		8
+#define KVM_TASK_SLEEP_HASHSIZE	(1 << KVM_TASK_SLEEP_HASHBITS)
+
+struct kvm_task_sleep_node {
+	struct hlist_node	link;
+	struct swait_queue_head	wq;
+	u32			token;
+	int			cpu;
+	bool			halted;
+};
+
+struct kvm_task_sleep_head {
+	raw_spinlock_t		lock;
+	struct hlist_head	list;
+};
+#endif /* CONFIG_KVM_GUEST */
+
 static const struct fault_info fault_info[];
 static struct fault_info debug_fault_info[];
+#ifdef CONFIG_KVM_GUEST
+static DEFINE_PER_CPU(struct kvm_vcpu_pv_apf_data, apf_data) __aligned(64);
+static struct kvm_task_sleep_head async_pf_sleepers[KVM_TASK_SLEEP_HASHSIZE];
+static bool async_pf_initialized;
+#endif
 
 static inline const struct fault_info *esr_to_fault_info(unsigned int esr)
 {
@@ -623,6 +648,178 @@ static int do_alignment_fault(unsigned long addr, unsigned int esr,
 	return 0;
 }
 
+#ifdef CONFIG_KVM_GUEST
+static struct kvm_task_sleep_node *kvm_pv_async_pf_find(
+		struct kvm_task_sleep_head *b, u32 token)
+{
+	struct kvm_task_sleep_node *n;
+	struct hlist_node *p;
+
+	hlist_for_each(p, &b->list) {
+		n = hlist_entry(p, typeof(*n), link);
+		if (n->token == token)
+			return n;
+	}
+
+	return NULL;
+}
+
+static void kvm_pv_async_pf_wait(u32 token, int interrupt_kernel)
+{
+	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
+	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
+	struct kvm_task_sleep_node n, *e;
+	DECLARE_SWAITQUEUE(wait);
+
+	raw_spin_lock(&b->lock);
+	e = kvm_pv_async_pf_find(b, token);
+	if (e) {
+		/* dummy entry exist -> wake up was delivered ahead of PF */
+		hlist_del(&e->link);
+		kfree(e);
+		raw_spin_unlock(&b->lock);
+
+		return;
+	}
+
+	n.token = token;
+	n.cpu = smp_processor_id();
+	n.halted = is_idle_task(current) ||
+		   (IS_ENABLED(CONFIG_PREEMPT_COUNT) ?
+			preempt_count() > 1 || rcu_preempt_depth() :
+			interrupt_kernel);
+	init_swait_queue_head(&n.wq);
+	hlist_add_head(&n.link, &b->list);
+	raw_spin_unlock(&b->lock);
+
+	for (;;) {
+		if (!n.halted) {
+			prepare_to_swait_exclusive(&n.wq, &wait,
+						   TASK_UNINTERRUPTIBLE);
+		}
+
+		if (hlist_unhashed(&n.link))
+			break;
+
+		/*
+		 * Enable the IRQ explicitly. Otherwise, the task
+		 * won't be scheduled or waken up properly.
+		 */
+		local_irq_enable();
+
+		if (!n.halted) {
+			schedule();
+		} else {
+			dsb(sy);
+			wfi();
+		}
+
+		local_irq_disable();
+	}
+
+	if (!n.halted)
+		finish_swait(&n.wq, &wait);
+}
+
+static inline void kvm_pv_async_pf_wake_one(struct kvm_task_sleep_node *n)
+{
+	/* The task will be waken up once being detached */
+	hlist_del_init(&n->link);
+
+	if (!n->halted)
+		swake_up_one(&n->wq);
+	else
+		smp_send_reschedule(n->cpu);
+}
+
+static void kvm_pv_async_pf_wake_all(void)
+{
+	struct kvm_task_sleep_head *b;
+	struct kvm_task_sleep_node *n;
+	struct hlist_node *p, *next;
+	int i;
+
+	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++) {
+		b = &async_pf_sleepers[i];
+
+		raw_spin_lock(&b->lock);
+
+		hlist_for_each_safe(p, next, &b->list) {
+			n = hlist_entry(p, typeof(*n), link);
+			if (n->cpu != smp_processor_id())
+				continue;
+
+			kvm_pv_async_pf_wake_one(n);
+		}
+
+		raw_spin_unlock(&b->lock);
+	}
+}
+
+static void kvm_pv_async_pf_wake(u32 token)
+{
+	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
+	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
+	struct kvm_task_sleep_node *n;
+
+	if (token == ~0) {
+		kvm_pv_async_pf_wake_all();
+		return;
+	}
+
+again:
+	raw_spin_lock(&b->lock);
+
+	n = kvm_pv_async_pf_find(b, token);
+	if (!n) {
+		/*
+		 * Async PF was not yet handled. Add dummy entry
+		 * for the token. Busy wait until other CPU handles
+		 * the async PF on allocation failure.
+		 */
+		n = kzalloc(sizeof(*n), GFP_ATOMIC);
+		if (!n) {
+			raw_spin_unlock(&b->lock);
+			cpu_relax();
+			goto again;
+		}
+		n->token = token;
+		n->cpu = smp_processor_id();
+		init_swait_queue_head(&n->wq);
+		hlist_add_head(&n->link, &b->list);
+	} else {
+		kvm_pv_async_pf_wake_one(n);
+	}
+
+	raw_spin_unlock(&b->lock);
+}
+#endif /* CONFIG_KVM_GUEST */
+
+static int do_lockdown(unsigned long addr, unsigned int esr,
+		       struct pt_regs *regs)
+{
+#ifdef CONFIG_KVM_GUEST
+	u32 reason = 0;
+
+	if (__this_cpu_read(apf_data.enabled)) {
+		reason = __this_cpu_read(apf_data.reason);
+		__this_cpu_write(apf_data.reason, 0);
+	}
+
+	switch (reason) {
+	case KVM_PV_REASON_PAGE_NOT_PRESENT:
+		kvm_pv_async_pf_wait((u32)addr, !user_mode(regs));
+		return 0;
+	case KVM_PV_REASON_PAGE_READY:
+		kvm_pv_async_pf_wake((u32)addr);
+		return 0;
+	}
+#endif /* CONFIG_KVM_GUEST */
+
+	pr_info("%s: addr=0x%lx, esr=0x%x\n", __func__, addr, esr);
+	return 1;
+}
+
 static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	return 1; /* "fault" */
@@ -703,7 +900,8 @@ static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGKILL, SI_KERNEL,	"Unsupported atomic hardware update fault"	},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 50"			},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 51"			},
-	{ do_bad,		SIGKILL, SI_KERNEL,	"implementation fault (lockdown abort)" },
+	{ do_lockdown,		SIGKILL, SI_KERNEL,
+	  "implementation fault (lockdown abort)" },
 	{ do_bad,		SIGBUS,  BUS_OBJERR,	"implementation fault (unsupported exclusive)" },
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 54"			},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 55"			},
@@ -878,3 +1076,42 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 	debug_exception_exit(regs);
 }
 NOKPROBE_SYMBOL(do_debug_exception);
+
+#ifdef CONFIG_KVM_GUEST
+void kvm_pv_async_pf_enable(void)
+{
+	u64 pa;
+	int i;
+
+	if (!kvm_para_has_feature(KVM_FEATURE_ASYNC_PF) ||
+	     __this_cpu_read(apf_data.enabled))
+		return;
+
+	if (!async_pf_initialized) {
+		async_pf_initialized = true;
+		for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++)
+			raw_spin_lock_init(&async_pf_sleepers[i].lock);
+	}
+
+	/* FIXME: Enable KVM_ASYNC_PF_SEND_ALWAYS on CONFIG_PREEMPTION */
+	pa = virt_to_phys(this_cpu_ptr(&apf_data));
+	pa |= KVM_ASYNC_PF_ENABLED;
+
+	__this_cpu_write(apf_data.enabled, 1);
+	write_sysreg_s(pa, SYS_ASYNC_PF_EL1);
+
+	pr_info("Async PF enabled on CPU %d\n", smp_processor_id());
+}
+
+void kvm_pv_async_pf_disable(void)
+{
+	if (!kvm_para_has_feature(KVM_FEATURE_ASYNC_PF) ||
+	    !__this_cpu_read(apf_data.enabled))
+		return;
+
+	write_sysreg_s(0, SYS_ASYNC_PF_EL1);
+	__this_cpu_write(apf_data.enabled, 0);
+
+	pr_info("Async PF disabled on CPU %d\n", smp_processor_id());
+}
+#endif /* CONFIG_KVM_GUEST */
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
