Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D298C63E4AF
	for <lists+kvmarm@lfdr.de>; Thu,  1 Dec 2022 00:11:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78E8F40458;
	Wed, 30 Nov 2022 18:11:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vppwg4KS24Wx; Wed, 30 Nov 2022 18:11:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 99C1E4B739;
	Wed, 30 Nov 2022 18:11:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2285F4B636
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 18:11:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WzhLL2YDbxNs for <kvmarm@lists.cs.columbia.edu>;
 Wed, 30 Nov 2022 18:11:09 -0500 (EST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CF0B44B74F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 18:11:03 -0500 (EST)
Received: by mail-pl1-f201.google.com with SMTP id
 m13-20020a170902f64d00b001899a70c8f1so8273561plg.14
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 15:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=6morZmBBP0CV2BvCfkeiOQYAEytvQNjuspBMIyc2id0=;
 b=sWQzejDxj89fP/6h20g08xJE4rIjODMnosC3GmCSUfi+aSeNDHNKftXKhh8nYT3l2D
 0YK4iSHo8A04ByrB9qf3ZTd0XUbiMRcMFGBiIM/mHqplDmmEfAjOk9uIC81j45nqClMy
 v2jwYosdvWDLVw0MCV9UfthiEkgsqhc9Bc9tz5Enb/CFlxInO603HpDl//Lik3bmkg1m
 bBZtpxEk9GCvMmsM3ZPE+UjVHdMMXjkLtGTIGBqyljnfD/K4nvullx146+dygbRTS/Bh
 KJn5a954k2T5IJlWupgrvVwtXJhy4B7Pc5j+rX2xLePCLmpO6bBgk7atqvBnF48/gjyK
 Oz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6morZmBBP0CV2BvCfkeiOQYAEytvQNjuspBMIyc2id0=;
 b=TT1GHfXylhOtGbxuV3g8KGB2Wa2fVQpJVG7aJH8zVqPc489kZuT2qL4BF4x+BBzMqF
 VF2Xyi26BrtNWJeh0ebsedtEPu96H+Xg8TWe7m5uSCJW3KnzjGQuWOpjD3Iu5deVMFAE
 WA8vHKMa2lBAyYxEcx3cfAQJhxlJUvEDasxlzXl9k46ghMktCcjDDx8yBodyJDmZ85rz
 PZlU1GRHBdaJMS52/MbyYThOJYifYWnuoXKfLTDJ/eodkAASN9OpweCln2CHF0DsFz26
 LYnLdN+vr8Rwf2F6P3WU8q0L1ezQP8MxqdsiQsKxtw6jv7tYJQzWkW9bvvaRskqknQpH
 d0Vg==
X-Gm-Message-State: ANoB5pmgHU5EfT5wgu8qSfPOymtf/UqGpg+82eSDFR2yRaCQFQ7FthuO
 3RLcjAlwKSJQOTkBPYXAMITYjaGdrmI=
X-Google-Smtp-Source: AA0mqf4+0TRXr+cnrk+BZdgZcvjM1FWymvWLiwE/quV2nt1zGgBs/MDCausMUoavyu2bOWxbpEos7xdiJdA=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b48f:b0:189:8b6:95f6 with SMTP id
 y15-20020a170902b48f00b0018908b695f6mr44843975plr.71.1669849862778; Wed, 30
 Nov 2022 15:11:02 -0800 (PST)
Date: Wed, 30 Nov 2022 23:09:33 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-50-seanjc@google.com>
Subject: [PATCH v2 49/50] KVM: Opt out of generic hardware enabling on s390
 and PPC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
 Kai Huang <kai.huang@intel.com>, linux-riscv@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Chao Gao <chao.gao@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, kvmarm@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

Allow architectures to opt out of the generic hardware enabling logic,
and opt out on both s390 and PPC, which don't need to manually enable
virtualization as it's always on (when available).

In addition to letting s390 and PPC drop a bit of dead code, this will
hopefully also allow ARM to clean up its related code, e.g. ARM has its
own per-CPU flag to track which CPUs have enable hardware due to the
need to keep hardware enabled indefinitely when pKVM is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/arm64/kvm/Kconfig              |  1 +
 arch/mips/kvm/Kconfig               |  1 +
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          |  5 -----
 arch/riscv/kvm/Kconfig              |  1 +
 arch/s390/include/asm/kvm_host.h    |  1 -
 arch/s390/kvm/kvm-s390.c            |  6 ------
 arch/x86/kvm/Kconfig                |  1 +
 include/linux/kvm_host.h            |  4 ++++
 virt/kvm/Kconfig                    |  3 +++
 virt/kvm/kvm_main.c                 | 30 +++++++++++++++++++++++------
 11 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 815cc118c675..0a7d2116b27b 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -21,6 +21,7 @@ if VIRTUALIZATION
 menuconfig KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
+	select KVM_GENERIC_HARDWARE_ENABLING
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 91d197bee9c0..29e51649203b 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -28,6 +28,7 @@ config KVM
 	select MMU_NOTIFIER
 	select SRCU
 	select INTERVAL_TREE
+	select KVM_GENERIC_HARDWARE_ENABLING
 	help
 	  Support for hosting Guest kernels.
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0a80e80c7b9e..959f566a455c 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -876,7 +876,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index f5b4ff6bfc89..4c5405fc5538 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -435,11 +435,6 @@ int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr,
 }
 EXPORT_SYMBOL_GPL(kvmppc_ld);
 
-int kvm_arch_hardware_enable(void)
-{
-	return 0;
-}
-
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	struct kvmppc_ops *kvm_ops = NULL;
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index f36a737d5f96..d5a658a047a7 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -20,6 +20,7 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTAL)"
 	depends on RISCV_SBI && MMU
+	select KVM_GENERIC_HARDWARE_ENABLING
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select KVM_MMIO
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d67ce719d16a..2bbc3d54959d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -1031,7 +1031,6 @@ extern char sie_exit;
 extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
 extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7ad8252e92c2..bd25076aa19b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -256,12 +256,6 @@ debug_info_t *kvm_s390_dbf;
 debug_info_t *kvm_s390_dbf_uv;
 
 /* Section: not file related */
-int kvm_arch_hardware_enable(void)
-{
-	/* every s390 is virtualization enabled ;-) */
-	return 0;
-}
-
 /* forward declarations */
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 			      unsigned long end);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index fbeaa9ddef59..8e578311ca9d 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -49,6 +49,7 @@ config KVM
 	select SRCU
 	select INTERVAL_TREE
 	select HAVE_KVM_PM_NOTIFIER if PM
+	select KVM_GENERIC_HARDWARE_ENABLING
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 616e8e90558b..ffb4f9c3371f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1457,8 +1457,10 @@ void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_
 static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
 #endif
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
+#endif
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
@@ -2090,7 +2092,9 @@ static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
 	}
 }
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 extern bool kvm_rebooting;
+#endif
 
 extern unsigned int halt_poll_ns;
 extern unsigned int halt_poll_ns_grow;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 800f9470e36b..d28df77345e1 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -86,3 +86,6 @@ config KVM_XFER_TO_GUEST_WORK
 
 config HAVE_KVM_PM_NOTIFIER
        bool
+
+config KVM_GENERIC_HARDWARE_ENABLING
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c12db3839114..6a2be96557c2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -102,9 +102,6 @@ EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);
 DEFINE_MUTEX(kvm_lock);
 LIST_HEAD(vm_list);
 
-static DEFINE_PER_CPU(bool, hardware_enabled);
-static int kvm_usage_count;
-
 static struct kmem_cache *kvm_vcpu_cache;
 
 static __read_mostly struct preempt_ops kvm_preempt_ops;
@@ -146,9 +143,6 @@ static void hardware_disable_all(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
-__visible bool kvm_rebooting;
-EXPORT_SYMBOL_GPL(kvm_rebooting);
-
 #define KVM_EVENT_CREATE_VM 0
 #define KVM_EVENT_DESTROY_VM 1
 static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm);
@@ -5024,6 +5018,13 @@ static struct miscdevice kvm_dev = {
 	&kvm_chardev_ops,
 };
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
+__visible bool kvm_rebooting;
+EXPORT_SYMBOL_GPL(kvm_rebooting);
+
+static DEFINE_PER_CPU(bool, hardware_enabled);
+static int kvm_usage_count;
+
 static int __hardware_enable_nolock(void)
 {
 	if (__this_cpu_read(hardware_enabled))
@@ -5185,6 +5186,17 @@ static struct syscore_ops kvm_syscore_ops = {
 	.suspend = kvm_suspend,
 	.resume = kvm_resume,
 };
+#else /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
+static int hardware_enable_all(void)
+{
+	return 0;
+}
+
+static void hardware_disable_all(void)
+{
+
+}
+#endif /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus)
 {
@@ -5873,6 +5885,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	int r;
 	int cpu;
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 	r = cpuhp_setup_state_nocalls(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
 				      kvm_online_cpu, kvm_offline_cpu);
 	if (r)
@@ -5880,6 +5893,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 
 	register_reboot_notifier(&kvm_reboot_notifier);
 	register_syscore_ops(&kvm_syscore_ops);
+#endif
 
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
@@ -5947,9 +5961,11 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
 out_free_3:
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_ONLINE);
+#endif
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_init);
@@ -5971,9 +5987,11 @@ void kvm_exit(void)
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_ONLINE);
+#endif
 	kvm_irqfd_exit();
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
-- 
2.38.1.584.g0f3c55d4c2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
