Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8E68F6171D3
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 00:20:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A0964B81A;
	Wed,  2 Nov 2022 19:20:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saPIFBwBBe57; Wed,  2 Nov 2022 19:20:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CCB94B851;
	Wed,  2 Nov 2022 19:20:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A29E4B814
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 19:20:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApfbUN2puol4 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Nov 2022 19:20:01 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59E2D4B811
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 19:20:01 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 s82-20020a632c55000000b0046b2491aa95so93824pgs.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Nov 2022 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=dcXVHMPmodJgyjWSWzUUXYPY5IgSqzwbkOwCWMHEoLw=;
 b=OPMCatdO1d8dL+Ta8Py6rxwydwCiY6zCNCXIb+egUN7DrF+5aRQAdkSuE5LIETIlxg
 0Xu5vf6/r2RvlVD4iPwtBSi99UeaHj7aM3+HXPcw2HDQ3PJiTzACg++YppAQSVFrXlbX
 445lXkuRBueb2zaC++Qprbqu7U3tfRRmn8brlw2hji0dV80X6loBURwB99xjrgySZrY+
 JKVDqIwyg7Uc9H75OQ5JSJ5+ZEwkliA75F0m2UzpP0JooJPxj9jKI/TjUoYSf5R0ENlU
 Tfi5fLmiuggsYA2KxI7KZkbk+jQJ4dmmmS2w7RXuC7D2A7bEXPHvjmHFsXPqV4OoFfix
 VIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dcXVHMPmodJgyjWSWzUUXYPY5IgSqzwbkOwCWMHEoLw=;
 b=WWNmSxS3eia1PmYOXPsQzavia8wJbg0c7m0px+Kdf/7JHxhy+7aXCqestwvrueZMKp
 N5kzUwexJyETC+Gd31nCy0b2M1i+ppvZZ7u0YlpW6/ifDrIoIeTJx/mnART+/8hXQ8Y0
 xybXa5ITUwrpIKaSS8vOVy46yrt1Wb5nNODJJUtq3dIte2n4TXM/PUN59PYyQe8I7Ftd
 kOOwahzuHvgooW+6+OKhb/e5Hkawf6mRVmf0KJ2UnshXL26EYcpKLymrCgQ0GEtYEbHq
 JOcj5ktfKJm2K7y8ORP55+GRESaPnoLG3jN4St0qH2yLi6DL2Pxge8BEv7xis9XbCizt
 gq2A==
X-Gm-Message-State: ACrzQf13m6IwelxqRJuE7rBMEsxr6uNw+1seMoO1jRx2qgTIK6DYU/Yo
 gTuEG8x22ah0QZxqv5XiJ7eV779NWMc=
X-Google-Smtp-Source: AMsMyM6kcll1bBJ/V+TtC0ABRP5ZMtZsbPePz3XyDhX5IOsFn05p1qBMSY73qSxElpChUue2jr1DdAtUr0w=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8e89:0:b0:56c:636a:fa37 with SMTP id
 a9-20020aa78e89000000b0056c636afa37mr27413782pfr.83.1667431200240; Wed, 02
 Nov 2022 16:20:00 -0700 (PDT)
Date: Wed,  2 Nov 2022 23:18:54 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-28-seanjc@google.com>
Subject: [PATCH 27/44] KVM: Drop kvm_arch_{init,exit}() hooks
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
 Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Chao Gao <chao.gao@intel.com>, Yuan Yao <yuan.yao@intel.com>,
 kvmarm@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, linux-mips@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
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

Drop kvm_arch_init() and kvm_arch_exit() now that all implementations
are nops.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c                | 11 -----------
 arch/mips/kvm/mips.c                | 10 ----------
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          |  5 -----
 arch/riscv/kvm/main.c               |  9 ---------
 arch/s390/kvm/kvm-s390.c            | 10 ----------
 arch/x86/kvm/x86.c                  | 10 ----------
 include/linux/kvm_host.h            |  3 ---
 virt/kvm/kvm_main.c                 | 19 ++-----------------
 9 files changed, 2 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6e0061eac627..75c5125b0dd3 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2284,17 +2284,6 @@ static __init int kvm_arm_init(void)
 	return err;
 }
 
-int kvm_arch_init(void *opaque)
-{
-	return 0;
-}
-
-/* NOP: Compiling as a module not supported */
-void kvm_arch_exit(void)
-{
-
-}
-
 static int __init early_kvm_mode_cfg(char *arg)
 {
 	if (!arg)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index ae7a24342fdf..3cade648827a 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1010,16 +1010,6 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	return r;
 }
 
-int kvm_arch_init(void *opaque)
-{
-	return 0;
-}
-
-void kvm_arch_exit(void)
-{
-
-}
-
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 5d2c3a487e73..0a80e80c7b9e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -881,7 +881,6 @@ static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
-static inline void kvm_arch_exit(void) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 36c27381a769..34278042ad27 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -2525,11 +2525,6 @@ void kvmppc_init_lpid(unsigned long nr_lpids_param)
 }
 EXPORT_SYMBOL_GPL(kvmppc_init_lpid);
 
-int kvm_arch_init(void *opaque)
-{
-	return 0;
-}
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ppc_instr);
 
 void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index cb063b8a9a0f..4710a6751687 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -65,15 +65,6 @@ void kvm_arch_hardware_disable(void)
 	csr_write(CSR_HIDELEG, 0);
 }
 
-int kvm_arch_init(void *opaque)
-{
-	return 0;
-}
-
-void kvm_arch_exit(void)
-{
-}
-
 static int __init riscv_kvm_init(void)
 {
 	const char *str;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f6ae845bc1c1..7c1c6d81b5d7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -533,16 +533,6 @@ static void __kvm_s390_exit(void)
 	debug_unregister(kvm_s390_dbf_uv);
 }
 
-int kvm_arch_init(void *opaque)
-{
-	return 0;
-}
-
-void kvm_arch_exit(void)
-{
-
-}
-
 /* Section: device related */
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 218707597bea..2b4530a33298 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9271,16 +9271,6 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 	kvm_pmu_ops_update(ops->pmu_ops);
 }
 
-int kvm_arch_init(void *opaque)
-{
-	return 0;
-}
-
-void kvm_arch_exit(void)
-{
-
-}
-
 static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 {
 	u64 host_pat;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9b52bd40be56..6c2a28c4c684 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1423,9 +1423,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg);
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu);
 
-int kvm_arch_init(void *opaque);
-void kvm_arch_exit(void);
-
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu);
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 27ce263a80e4..17c852cb6842 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5833,20 +5833,8 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	int r;
 	int cpu;
 
-	/*
-	 * FIXME: Get rid of kvm_arch_init(), vendor code should call arch code
-	 * directly.  Note, kvm_arch_init() _must_ be called before anything
-	 * else as x86 relies on checks buried in kvm_arch_init() to guard
-	 * against multiple calls to kvm_init().
-	 */
-	r = kvm_arch_init(opaque);
-	if (r)
-		return r;
-
-	if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL)) {
-		r = -ENOMEM;
-		goto err_hw_enabled;
-	}
+	if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL))
+		return -ENOMEM;
 
 	c.ret = &r;
 	c.opaque = opaque;
@@ -5934,8 +5922,6 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
 out_free_2:
 	free_cpumask_var(cpus_hardware_enabled);
-err_hw_enabled:
-	kvm_arch_exit();
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_init);
@@ -5963,7 +5949,6 @@ void kvm_exit(void)
 	on_each_cpu(hardware_disable_nolock, NULL, 1);
 	kvm_irqfd_exit();
 	free_cpumask_var(cpus_hardware_enabled);
-	kvm_arch_exit();
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
 
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
