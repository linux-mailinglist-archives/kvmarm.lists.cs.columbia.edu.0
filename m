Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1769118E43F
	for <lists+kvmarm@lfdr.de>; Sat, 21 Mar 2020 21:26:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B5ACB4B0CD;
	Sat, 21 Mar 2020 16:26:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZB1dd9cyqZSy; Sat, 21 Mar 2020 16:26:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 390A74B081;
	Sat, 21 Mar 2020 16:26:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C89D24AF1F
 for <kvmarm@lists.cs.columbia.edu>; Sat, 21 Mar 2020 16:26:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B-HEvam57x-E for <kvmarm@lists.cs.columbia.edu>;
 Sat, 21 Mar 2020 16:26:07 -0400 (EDT)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 66EE74B08A
 for <kvmarm@lists.cs.columbia.edu>; Sat, 21 Mar 2020 16:26:07 -0400 (EDT)
IronPort-SDR: KmswlJIBVi0CGt20e1tjSOnx68pJzzrfE7tkhl50eLmOUxVm6P0u7XU4ZDEgkbG56x5qOUeH84
 5Njz8u2WTh6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2020 13:26:06 -0700
IronPort-SDR: BUVJNNHlRThKyTU9dFmNUOVLY/obQ3IkbxXUUdftUhdb95lStNwyoKb4weq7HdN7yVr0471LqZ
 HiWHKp178kYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,289,1580803200"; d="scan'208";a="280773539"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2020 13:26:05 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/9] KVM: x86: Move init-only kvm_x86_ops to separate struct
Date: Sat, 21 Mar 2020 13:25:56 -0700
Message-Id: <20200321202603.19355-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200321202603.19355-1-sean.j.christopherson@intel.com>
References: <20200321202603.19355-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org, Wanpeng Li <wanpengli@tencent.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, kvm-ppc@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

Move the kvm_x86_ops functions that are used only within the scope of
kvm_init() into a separate struct, kvm_x86_init_ops.  In addition to
identifying the init-only functions without restorting to code comments,
this also sets the stage for waiting until after ->hardware_setup() to
set kvm_x86_ops.  Setting kvm_x86_ops after ->hardware_setup() is
desirable as many of the hooks are not usable until ->hardware_setup()
completes.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 13 +++++++++----
 arch/x86/kvm/svm.c              | 15 ++++++++++-----
 arch/x86/kvm/vmx/vmx.c          | 16 +++++++++++-----
 arch/x86/kvm/x86.c              | 10 ++++++----
 4 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9a183e9d4cb1..f4c5b49299ff 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1054,12 +1054,8 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 }
 
 struct kvm_x86_ops {
-	int (*cpu_has_kvm_support)(void);          /* __init */
-	int (*disabled_by_bios)(void);             /* __init */
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
-	int (*check_processor_compatibility)(void);/* __init */
-	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
 	bool (*cpu_has_accelerated_tpr)(void);
 	bool (*has_emulated_msr)(int index);
@@ -1260,6 +1256,15 @@ struct kvm_x86_ops {
 	int (*enable_direct_tlbflush)(struct kvm_vcpu *vcpu);
 };
 
+struct kvm_x86_init_ops {
+	int (*cpu_has_kvm_support)(void);
+	int (*disabled_by_bios)(void);
+	int (*check_processor_compatibility)(void);
+	int (*hardware_setup)(void);
+
+	struct kvm_x86_ops *runtime_ops;
+};
+
 struct kvm_arch_async_pf {
 	u32 token;
 	gfn_t gfn;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 2125c6ae5951..33e67c3389c2 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7351,11 +7351,7 @@ static void svm_pre_update_apicv_exec_ctrl(struct kvm *kvm, bool activate)
 }
 
 static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
-	.cpu_has_kvm_support = has_svm,
-	.disabled_by_bios = is_disabled,
-	.hardware_setup = svm_hardware_setup,
 	.hardware_unsetup = svm_hardware_teardown,
-	.check_processor_compatibility = svm_check_processor_compat,
 	.hardware_enable = svm_hardware_enable,
 	.hardware_disable = svm_hardware_disable,
 	.cpu_has_accelerated_tpr = svm_cpu_has_accelerated_tpr,
@@ -7480,9 +7476,18 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.check_nested_events = svm_check_nested_events,
 };
 
+static struct kvm_x86_init_ops svm_init_ops __initdata = {
+	.cpu_has_kvm_support = has_svm,
+	.disabled_by_bios = is_disabled,
+	.hardware_setup = svm_hardware_setup,
+	.check_processor_compatibility = svm_check_processor_compat,
+
+	.runtime_ops = &svm_x86_ops,
+};
+
 static int __init svm_init(void)
 {
-	return kvm_init(&svm_x86_ops, sizeof(struct vcpu_svm),
+	return kvm_init(&svm_init_ops, sizeof(struct vcpu_svm),
 			__alignof__(struct vcpu_svm), THIS_MODULE);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 07299a957d4a..ffcdcc86f5b7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7842,11 +7842,8 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
 }
 
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
-	.cpu_has_kvm_support = cpu_has_kvm_support,
-	.disabled_by_bios = vmx_disabled_by_bios,
-	.hardware_setup = hardware_setup,
 	.hardware_unsetup = hardware_unsetup,
-	.check_processor_compatibility = vmx_check_processor_compat,
+
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
 	.cpu_has_accelerated_tpr = report_flexpriority,
@@ -7981,6 +7978,15 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
 };
 
+static struct kvm_x86_init_ops vmx_init_ops __initdata = {
+	.cpu_has_kvm_support = cpu_has_kvm_support,
+	.disabled_by_bios = vmx_disabled_by_bios,
+	.check_processor_compatibility = vmx_check_processor_compat,
+	.hardware_setup = hardware_setup,
+
+	.runtime_ops = &vmx_x86_ops,
+};
+
 static void vmx_cleanup_l1d_flush(void)
 {
 	if (vmx_l1d_flush_pages) {
@@ -8065,7 +8071,7 @@ static int __init vmx_init(void)
 	}
 #endif
 
-	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
+	r = kvm_init(&vmx_init_ops, sizeof(struct vcpu_vmx),
 		     __alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r)
 		return r;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0f08e1b4e762..20f989d1bba8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7298,8 +7298,8 @@ static struct notifier_block pvclock_gtod_notifier = {
 
 int kvm_arch_init(void *opaque)
 {
+	struct kvm_x86_init_ops *ops = opaque;
 	int r;
-	struct kvm_x86_ops *ops = opaque;
 
 	if (kvm_x86_ops) {
 		printk(KERN_ERR "kvm: already loaded the other module\n");
@@ -7354,7 +7354,7 @@ int kvm_arch_init(void *opaque)
 	if (r)
 		goto out_free_percpu;
 
-	kvm_x86_ops = ops;
+	kvm_x86_ops = ops->runtime_ops;
 
 	kvm_mmu_set_mask_ptes(PT_USER_MASK, PT_ACCESSED_MASK,
 			PT_DIRTY_MASK, PT64_NX_MASK, 0,
@@ -9623,6 +9623,7 @@ void kvm_arch_hardware_disable(void)
 
 int kvm_arch_hardware_setup(void *opaque)
 {
+	struct kvm_x86_init_ops *ops = opaque;
 	int r;
 
 	rdmsrl_safe(MSR_EFER, &host_efer);
@@ -9630,7 +9631,7 @@ int kvm_arch_hardware_setup(void *opaque)
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		rdmsrl(MSR_IA32_XSS, host_xss);
 
-	r = kvm_x86_ops->hardware_setup();
+	r = ops->hardware_setup();
 	if (r != 0)
 		return r;
 
@@ -9665,13 +9666,14 @@ void kvm_arch_hardware_unsetup(void)
 int kvm_arch_check_processor_compat(void *opaque)
 {
 	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	struct kvm_x86_init_ops *ops = opaque;
 
 	WARN_ON(!irqs_disabled());
 
 	if (kvm_host_cr4_reserved_bits(c) != cr4_reserved_bits)
 		return -EIO;
 
-	return kvm_x86_ops->check_processor_compatibility();
+	return ops->check_processor_compatibility();
 }
 
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
