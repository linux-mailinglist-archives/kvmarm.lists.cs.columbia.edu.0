Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1A39B534
	for <lists+kvmarm@lfdr.de>; Fri,  4 Jun 2021 10:51:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32CF84B118;
	Fri,  4 Jun 2021 04:51:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yuYOR-owPGjk; Fri,  4 Jun 2021 04:51:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D4A774B102;
	Fri,  4 Jun 2021 04:51:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CAE9F4B0F0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 12:43:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dmPzqJqkV3LE for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Jun 2021 12:43:53 -0400 (EDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5EB674B0BD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 12:43:53 -0400 (EDT)
Received: by mail-pf1-f169.google.com with SMTP id u18so5290444pfk.11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 03 Jun 2021 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Q2DATu13P1pzwQHWEVjGMuJXKz5nnidG53u8t/T69Y=;
 b=oZWknSmeVZZfZwya3xUfjHMkrSowYXFuz2O2dLlUa9GiJ/jfDEeFrwHMXwjBA4wEI+
 KgJVTITaDxvaEi2nzAHfwWTEAk9ONAyP6YJm2+/EYC4K3inpb83m3E64GzZtZ9U1kDBl
 lZo5D5cvDzPWuhMzO9hZfc3PzZmWok9dwf5rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Q2DATu13P1pzwQHWEVjGMuJXKz5nnidG53u8t/T69Y=;
 b=VMEYmUFUViavPTuxTI7+IYhyLRpFcPKANddh3dcBZMafZHZ2E6aQUcMJ+Uc8O64pwf
 JgXU6UAZAUGqrY8Er5xnxcS3Hya5WR8ikR8de2hy0X3nVCBXcQjZxizXpQFpJFHCBUv1
 pi7nOgmxgXH82w+CkMbvVnnDwmLTZ+hlhwxm06UF9XFOV+2BoUoENm4H0kD8nNHcpsJG
 1W1itVUZKdjo4OJoabQFgDWCvREmJRlkE3CWFpfn2OpzkZp3+Z9HAG/L4qq66BIjqp3G
 KbBE5r0f/fZJ/xbMGcmFHQuHb+bYFlbc6owy7l3jVF9n1VmXadM0FmdC1xj4t52BDWtD
 aVfw==
X-Gm-Message-State: AOAM532hy9JhIzji7BDuKhgdX5xS93f6igHAALtlnSwkGaAuIba7CBMx
 x4VEzKb/mrUMfR3+40hmyyB9RQ==
X-Google-Smtp-Source: ABdhPJx7I5PtkMSKl9b8zDas4WwIKw7SMCpW5CkmtGzDxyA7T/ENxk1ZY0pC15QcFzNPM4JDV5yvgQ==
X-Received: by 2002:a63:dc4e:: with SMTP id f14mr368523pgj.378.1622738632157; 
 Thu, 03 Jun 2021 09:43:52 -0700 (PDT)
Received: from senozhatsky.flets-east.jp
 ([2409:10:2e40:5100:1585:76c1:e367:901a])
 by smtp.gmail.com with ESMTPSA id 76sm2749589pfy.82.2021.06.03.09.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:43:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>
Subject: [RFC][PATCH] kvm: add suspend pm-notifier
Date: Fri,  4 Jun 2021 01:43:15 +0900
Message-Id: <20210603164315.682994-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 04 Jun 2021 04:51:53 -0400
Cc: linux-s390@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Suleiman Souhlal <suleiman@google.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Add KVM suspend/hibernate PM-notifier which lets architectures
to implement arch-specific VM suspend code. For instance, on x86
this sets PVCLOCK_GUEST_STOPPED on all the VCPUs.

Our case is that user puts the host system into sleep multiple
times a day (e.g. closes the laptop's lid) so we need a reliable
way to suspend VMs properly.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/arm64/kvm/arm.c       |  4 ++++
 arch/mips/kvm/mips.c       |  4 ++++
 arch/powerpc/kvm/powerpc.c |  4 ++++
 arch/s390/kvm/kvm-s390.c   |  4 ++++
 arch/x86/kvm/x86.c         | 21 ++++++++++++++++++++
 include/linux/kvm_host.h   |  8 ++++++++
 virt/kvm/kvm_main.c        | 40 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 85 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1126eae27400..547dbe44d039 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1311,6 +1311,10 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
 	}
 }
 
+void kvm_arch_pm_notifier(struct kvm *kvm)
+{
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 4d4af97dcc88..d4408acd2be6 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -980,6 +980,10 @@ void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
 	kvm_flush_remote_tlbs(kvm);
 }
 
+void kvm_arch_pm_notifier(struct kvm *kvm)
+{
+}
+
 long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
 	long r;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a2a68a958fa0..96e8a7b6fcf0 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -2334,6 +2334,10 @@ static int kvmppc_get_cpu_char(struct kvm_ppc_cpu_char *cp)
 }
 #endif
 
+void kvm_arch_pm_notifier(struct kvm *kvm)
+{
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
                        unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1296fc10f80c..c5f86fc1e497 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2367,6 +2367,10 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 	return r;
 }
 
+void kvm_arch_pm_notifier(struct kvm *kvm)
+{
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbc4e04e67ad..3f3d6497593f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5613,6 +5613,27 @@ static int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm, void __user *argp)
 	return 0;
 }
 
+void kvm_arch_pm_notifier(struct kvm *kvm)
+{
+#ifdef CONFIG_PM
+	int c;
+
+	mutex_lock(&kvm->lock);
+	for (c = 0; c < kvm->created_vcpus; c++) {
+		struct kvm_vcpu *vcpu = kvm->vcpus[c];
+		int r;
+
+		if (!vcpu)
+			continue;
+		r = kvm_set_guest_paused(vcpu);
+		if (!r)
+			continue;
+		pr_err("Failed to suspend VCPU-%d: %d\n", vcpu->vcpu_id,  r);
+	}
+	mutex_unlock(&kvm->lock);
+#endif
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2f34487e21f2..86695320a6b7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -37,6 +37,8 @@
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
 
+#include <linux/notifier.h>
+
 #ifndef KVM_MAX_VCPU_ID
 #define KVM_MAX_VCPU_ID KVM_MAX_VCPUS
 #endif
@@ -579,6 +581,10 @@ struct kvm {
 	pid_t userspace_pid;
 	unsigned int max_halt_poll_ns;
 	u32 dirty_ring_size;
+
+#ifdef CONFIG_PM
+	struct notifier_block pm_notifier;
+#endif
 };
 
 #define kvm_err(fmt, ...) \
@@ -992,6 +998,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu);
 
+void kvm_arch_pm_notifier(struct kvm *kvm);
+
 #ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
 void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6b4feb92dc79..86925ab7d162 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -51,6 +51,7 @@
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -779,6 +780,43 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
+#ifdef CONFIG_PM
+static int kvm_pm_notifier_call(struct notifier_block *bl,
+				unsigned long state,
+				void *unused)
+{
+	struct kvm *kvm = container_of(bl, struct kvm, pm_notifier);
+
+	switch (state) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		kvm_arch_pm_notifier(kvm);
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static void kvm_init_pm_notifier(struct kvm *kvm)
+{
+	kvm->pm_notifier.notifier_call = kvm_pm_notifier_call;
+	kvm->pm_notifier.priority = INT_MAX;
+	register_pm_notifier(&kvm->pm_notifier);
+}
+
+static void kvm_destroy_pm_notifier(struct kvm *kvm)
+{
+	unregister_pm_notifier(&kvm->pm_notifier);
+}
+#else
+static void kvm_init_pm_notifier(struct kvm *kvm)
+{
+}
+
+static void kvm_destroy_pm_notifier(struct kvm *kvm)
+{
+}
+#endif /* CONFIG_PM */
+
 static struct kvm_memslots *kvm_alloc_memslots(void)
 {
 	int i;
@@ -962,6 +1000,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	mutex_unlock(&kvm_lock);
 
 	preempt_notifier_inc();
+	kvm_init_pm_notifier(kvm);
 
 	return kvm;
 
@@ -1009,6 +1048,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	int i;
 	struct mm_struct *mm = kvm->mm;
 
+	kvm_destroy_pm_notifier(kvm);
 	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
 	kvm_destroy_vm_debugfs(kvm);
 	kvm_arch_sync_events(kvm);
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
