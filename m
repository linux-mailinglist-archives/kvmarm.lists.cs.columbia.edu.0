Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CE6FD1D7201
	for <lists+kvmarm@lfdr.de>; Mon, 18 May 2020 09:37:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 826CE4B195;
	Mon, 18 May 2020 03:37:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u0PjyWgydKGU; Mon, 18 May 2020 03:37:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E97294B19F;
	Mon, 18 May 2020 03:37:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 081724B125
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 02:58:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XhLYDdEVS+rE for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 May 2020 02:58:51 -0400 (EDT)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 61DB94B122
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 02:58:51 -0400 (EDT)
Received: by mail-wm1-f65.google.com with SMTP id f13so8058963wmc.5
 for <kvmarm@lists.cs.columbia.edu>; Sun, 17 May 2020 23:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O7T+/EGumFSPzoOShum9m7oeL5f+uhtFZ57+Qat4aGY=;
 b=eCPmxWUnK7EZiv6XRk9PslSaCFoBEQqK9p521XIp3vnintA5UrePzZoI91QBRt0W/a
 epmW/Ccb0KMoafOaIIAHLsLSv/hyQ8Q7PeFvoF7hFbxDEh4flB8LwM30a6DTNDjlHXyY
 /BZ15mhRb4hgKKMzcKbHyj82XvqR3UVTN72MyAPu3/2D1ajtfcbbuMQhWeB4pKfRX2Zr
 k03+PYMFBFQcPfARxQ8cFHnJaPfeDgo0wMe6cXprb4zP++iCyKmxMJiKkqWAMSdgdhIW
 R5xKRCl4J7fZOMxiTmbf4wkqnsvqfuzBdXbNElOrRRFxC6vf2HO5N7a7XogEvECkYK1B
 CUBQ==
X-Gm-Message-State: AOAM533vSrhRLOTx9LwdWsDVb8PQPSZIGrvHQDm4AZ+aapdgheQkmi9F
 2EptasCpqH+oRxw3lPoCsn4=
X-Google-Smtp-Source: ABdhPJziKeISVJeZjvh8zgBsBnkBAV8uaBCLMrL8C5IqWyVUZSxvDOo3NNfa5lAX30DJd3X9N42Eug==
X-Received: by 2002:a1c:2c0b:: with SMTP id s11mr14062813wms.97.1589785130035; 
 Sun, 17 May 2020 23:58:50 -0700 (PDT)
Received: from bf.nubificus.co.uk ([2a02:587:b919:800:aaa1:59ff:fe09:f176])
 by smtp.gmail.com with ESMTPSA id c143sm13770779wmd.43.2020.05.17.23.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 23:58:49 -0700 (PDT)
Date: Mon, 18 May 2020 09:58:48 +0300
From: Anastassios Nanos <ananos@nubificus.co.uk>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVMM: export needed symbols
Message-ID: <33dddce13cd34448620b95db80a28b7b0bb906ad.1589784221.git.ananos@nubificus.co.uk>
References: <cover.1589784221.git.ananos@nubificus.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1589784221.git.ananos@nubificus.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Mon, 18 May 2020 03:37:55 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jim Mattson <jmattson@google.com>
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

Expose a set of KVM functions to the kernel, in order to be
able to spawn a VM instance without assistance from user-space.
To handle a guest instance, the system needs access to the following
functions:

    kvm_arch_vcpu_run_map_fp
    kvm_arch_vcpu_ioctl_get_regs
    kvm_arch_vcpu_ioctl_set_regs
    kvm_arm_get_reg
    kvm_arm_set_reg
    kvm_arch_vcpu_ioctl_get_sregs
    kvm_arch_vcpu_ioctl_set_sregs
    kvm_vcpu_preferred_target
    kvm_vcpu_ioctl_set_cpuid2
    kvm_vcpu_ioctl_get_cpuid2
    kvm_dev_ioctl_get_cpuid
    kvm_arch_vcpu_ioctl_run
    kvm_arch_vcpu_ioctl_get_regs
    kvm_arch_vcpu_ioctl_set_regs
    kvm_arch_vcpu_ioctl_get_sregs
    kvm_arch_vcpu_ioctl_set_sregs
    kvm_vcpu_initialized
    kvm_arch_vcpu_ioctl_run
    kvm_arch_vcpu_ioctl_vcpu_init
    kvm_coalesced_mmio_init
    kvm_create_vm
    kvm_destroy_vm
    kvm_vm_ioctl_set_memory_region
    kvm_vm_ioctl_create_vcpu

Signed-off-by: Anastassios Nanos <ananos@nubificus.co.uk>
Signed-off-by: Charalampos Mainas <cmainas@nubificus.co.uk>
Signed-off-by: Konstantinos Papazafeiropoulos <kostis@nubificus.co.uk>
Signed-off-by: Stratos Psomadakis <psomas@nubificus.co.uk>
---
 arch/arm64/include/asm/kvm_host.h |  6 ++++
 arch/arm64/kvm/fpsimd.c           |  6 ++++
 arch/arm64/kvm/guest.c            | 48 +++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c              | 25 ++++++++++++++++
 arch/x86/kvm/x86.c                | 31 ++++++++++++++++++++
 include/linux/kvm_host.h          | 24 ++++++++++++++++
 virt/kvm/arm/arm.c                | 18 ++++++++++++
 virt/kvm/coalesced_mmio.c         |  6 ++++
 virt/kvm/kvm_main.c               | 23 +++++++++++++++
 9 files changed, 187 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 32c8a675e5a4..79b51a4eeaac 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -602,6 +602,7 @@ static inline void __cpu_init_stage2(void) {}
 
 /* Guest/host FPSIMD coordination helpers */
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
+int kvmm_kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
@@ -617,6 +618,11 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	return kvm_arch_vcpu_run_map_fp(vcpu);
 }
 
+static inline int kvmm_kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
+{
+	return kvmm_kvm_arch_vcpu_run_map_fp(vcpu);
+}
+
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u32 clr);
 
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index e329a36b2bee..274f8c47b22c 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -48,6 +48,12 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+int kvmm_kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
+{
+	return kvm_arch_vcpu_run_map_fp(vcpu);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_run_map_fp);
+
 /*
  * Prepare vcpu for saving the host's FPSIMD state and loading the guest's.
  * The actual loading is done by the FPSIMD access trap taken to hyp.
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 50a279d3ddd7..f64fe3a999ac 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -443,11 +443,26 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
+int kvmm_kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu,
+				struct kvm_regs *regs)
+{
+	return kvm_arch_vcpu_ioctl_get_regs(vcpu, regs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_get_regs);
+
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	return -EINVAL;
 }
 
+int kvmm_kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu,
+				struct kvm_regs *regs)
+{
+	return kvm_arch_vcpu_ioctl_set_regs(vcpu, regs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_set_regs);
+
+
 static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
 				 u64 __user *uindices)
 {
@@ -678,6 +693,12 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return kvm_arm_sys_reg_get_reg(vcpu, reg);
 }
 
+int kvmm_kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	return kvm_arm_get_reg(vcpu, reg);
+}
+EXPORT_SYMBOL(kvmm_kvm_arm_get_reg);
+
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	/* We currently use nothing arch-specific in upper 32 bits */
@@ -696,18 +717,39 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return kvm_arm_sys_reg_set_reg(vcpu, reg);
 }
 
+int kvmm_kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	return kvm_arm_set_reg(vcpu, reg);
+}
+EXPORT_SYMBOL(kvmm_kvm_arm_set_reg);
+
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
 	return -EINVAL;
 }
 
+
+int kvmm_kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				struct kvm_sregs *sregs)
+{
+	return kvm_arch_vcpu_ioctl_get_sregs(vcpu, sregs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_get_sregs);
+
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
 	return -EINVAL;
 }
 
+int kvmm_kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				struct kvm_sregs *sregs)
+{
+	return kvm_arch_vcpu_ioctl_set_sregs(vcpu, sregs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_set_sregs);
+
 int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events)
 {
@@ -801,6 +843,12 @@ int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
 	return 0;
 }
 
+int kvmm_kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
+{
+	return kvm_vcpu_preferred_target(init);
+}
+EXPORT_SYMBOL(kvmm_kvm_vcpu_preferred_target);
+
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
 	return -EINVAL;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 901cd1fdecd9..c7d2071da47a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -238,6 +238,14 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+int kvmm_kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
+			      struct kvm_cpuid2 *cpuid,
+			      struct kvm_cpuid_entry2 __user *entries)
+{
+	return kvm_vcpu_ioctl_set_cpuid2(vcpu, cpuid, entries);
+}
+EXPORT_SYMBOL(kvmm_kvm_vcpu_ioctl_set_cpuid2);
+
 int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
 			      struct kvm_cpuid2 *cpuid,
 			      struct kvm_cpuid_entry2 __user *entries)
@@ -258,6 +266,14 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+int kvmm_kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
+			      struct kvm_cpuid2 *cpuid,
+			      struct kvm_cpuid_entry2 __user *entries)
+{
+	return kvm_vcpu_ioctl_get_cpuid2(vcpu, cpuid, entries);
+}
+EXPORT_SYMBOL(kvmm_kvm_vcpu_ioctl_get_cpuid2);
+
 static __always_inline void kvm_cpu_cap_mask(enum cpuid_leafs leaf, u32 mask)
 {
 	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);
@@ -900,6 +916,15 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 	return r;
 }
 
+int kvmm_kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
+			    struct kvm_cpuid_entry2 __user *entries,
+			    unsigned int type)
+{
+	return kvm_dev_ioctl_get_cpuid(cpuid, entries, type);
+
+}
+EXPORT_SYMBOL(kvmm_kvm_dev_ioctl_get_cpuid);
+
 struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
 					      u32 function, u32 index)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3bf2ecafd027..b4039402aa7d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8776,6 +8776,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	return r;
 }
 
+int kvmm_kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	return kvm_arch_vcpu_ioctl_run(vcpu, kvm_run);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_run);
+
+
 static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
@@ -8819,6 +8826,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu_put(vcpu);
 	return 0;
 }
+int kvmm_kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu,
+				struct kvm_regs *regs)
+{
+	return kvm_arch_vcpu_ioctl_get_regs(vcpu, regs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_get_regs);
 
 static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
@@ -8859,6 +8872,12 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu_put(vcpu);
 	return 0;
 }
+int kvmm_kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu,
+				struct kvm_regs *regs)
+{
+	return kvm_arch_vcpu_ioctl_set_regs(vcpu, regs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_set_regs);
 
 void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 {
@@ -8914,6 +8933,12 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 	vcpu_put(vcpu);
 	return 0;
 }
+int kvmm_kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return kvm_arch_vcpu_ioctl_get_sregs(vcpu, sregs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_get_sregs);
 
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
@@ -9113,6 +9138,12 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	vcpu_put(vcpu);
 	return ret;
 }
+int kvmm_kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return kvm_arch_vcpu_ioctl_set_sregs(vcpu, sregs);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_set_sregs);
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6d58beb65454..794b97c4ddf9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1408,11 +1408,16 @@ int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 
 #ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
 int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu);
+int kvmm_kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu);
 #else
 static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
+static inline int kvmm_kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
 #endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */
 
 typedef int (*kvm_vm_thread_fn_t)(struct kvm *kvm, uintptr_t data);
@@ -1421,4 +1426,23 @@ int kvm_vm_create_worker_thread(struct kvm *kvm, kvm_vm_thread_fn_t thread_fn,
 				uintptr_t data, const char *name,
 				struct task_struct **thread_ptr);
 
+/* KVMM related functions */
+struct kvm *kvmm_kvm_create_vm(unsigned long type);
+int kvmm_kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id);
+void kvmm_kvm_destroy_vm(struct kvm *kvm);
+int kvmm_kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
+				 struct kvm_run *kvm_run);
+int kvmm_kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				       struct kvm_sregs *sregs);
+int kvmm_kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				       struct kvm_sregs *sregs);
+int kvmm_kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu,
+				      struct kvm_regs *regs);
+int kvmm_kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu,
+				      struct kvm_regs *regs);
+int kvmm_kvm_coalesced_mmio_init(struct kvm *kvm);
+int kvmm_kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
+				   struct kvm_userspace_memory_region *mem);
+
+
 #endif
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 48d0ec44ad77..d33bbb64b515 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -607,6 +607,11 @@ static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.target >= 0;
 }
+int kvmm_kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_initialized(vcpu);
+}
+EXPORT_SYMBOL(kvmm_kvm_vcpu_initialized);
 
 static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 {
@@ -830,6 +835,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return ret;
 }
 
+int kvmm_kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	return kvm_arch_vcpu_ioctl_run(vcpu, run);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_run);
+
 static int vcpu_interrupt_line(struct kvm_vcpu *vcpu, int number, bool level)
 {
 	int bit_index;
@@ -1000,6 +1011,13 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+int kvmm_kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
+					 struct kvm_vcpu_init *init)
+{
+	return kvm_arch_vcpu_ioctl_vcpu_init(vcpu, init);
+}
+EXPORT_SYMBOL(kvmm_kvm_arch_vcpu_ioctl_vcpu_init);
+
 static int kvm_arm_vcpu_set_attr(struct kvm_vcpu *vcpu,
 				 struct kvm_device_attr *attr)
 {
diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 00c747dbc82e..ad7e540dcbd7 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -128,6 +128,12 @@ int kvm_coalesced_mmio_init(struct kvm *kvm)
 	return 0;
 }
 
+int kvmm_kvm_coalesced_mmio_init(struct kvm *kvm)
+{
+	return kvm_coalesced_mmio_init(kvm);
+}
+EXPORT_SYMBOL(kvmm_kvm_coalesced_mmio_init);
+
 void kvm_coalesced_mmio_free(struct kvm *kvm)
 {
 	if (kvm->coalesced_mmio_ring)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 74bdb7bf3295..dcbecc2ab370 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -761,6 +761,11 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	mmdrop(current->mm);
 	return ERR_PTR(r);
 }
+struct kvm *kvmm_kvm_create_vm(unsigned long type)
+{
+	return kvm_create_vm(type);
+}
+EXPORT_SYMBOL(kvmm_kvm_create_vm);
 
 static void kvm_destroy_devices(struct kvm *kvm)
 {
@@ -816,6 +821,12 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	mmdrop(mm);
 }
 
+void kvmm_kvm_destroy_vm(struct kvm *kvm)
+{
+	kvm_destroy_vm(kvm);
+}
+EXPORT_SYMBOL(kvmm_kvm_destroy_vm);
+
 void kvm_get_kvm(struct kvm *kvm)
 {
 	refcount_inc(&kvm->users_count);
@@ -1332,6 +1343,12 @@ static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
 
 	return kvm_set_memory_region(kvm, mem);
 }
+int kvmm_kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
+				  struct kvm_userspace_memory_region *mem)
+{
+	return kvm_vm_ioctl_set_memory_region(kvm, mem);
+}
+EXPORT_SYMBOL_GPL(kvmm_kvm_vm_ioctl_set_memory_region);
 
 #ifndef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
 /**
@@ -3078,6 +3095,12 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	return r;
 }
 
+int kvmm_kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
+{
+	return kvm_vm_ioctl_create_vcpu(kvm, id);
+}
+EXPORT_SYMBOL(kvmm_kvm_vm_ioctl_create_vcpu);
+
 static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 {
 	if (sigset) {
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
