Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A53AC281
	for <lists+kvmarm@lfdr.de>; Fri, 18 Jun 2021 06:48:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E05044B08A;
	Fri, 18 Jun 2021 00:48:34 -0400 (EDT)
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
	with ESMTP id oN1hJ4OYh+Fl; Fri, 18 Jun 2021 00:48:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 546C04B0A1;
	Fri, 18 Jun 2021 00:48:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 143D14B08F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 00:48:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXZ+WZmhZ9NY for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Jun 2021 00:48:28 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 980214048B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 00:48:28 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 k9-20020a63d1090000b029021091ebb84cso3217477pgg.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=CFVi+z2mf3tcxTeka+vBro0+oe+hOysH+c9hAxWeWVo=;
 b=uRdhHd2FJhXPtnC9SbU3cRty3cjlLGihohwmzpC8mfQiDCWNjubCtj07F8KNToIH89
 Xu/36HI8KutWUOwe8vargnHjr5+Jd1S/z/Z478njl3rG8rRx051N8QyeQi/RKq15FAiv
 KPa/6RvX/VOo1AvLrsLnfGyuIddRw5+dGNwvl+cyulVAQA34FSCsDoOmePyBNPOAR9FL
 7+2lpLInWWX4NbjXSomOXA4hu9lgDJBT0PlS2XlmLvA9AzqEj5cZElKgOgavPPyl8FAe
 3vPrPHHssp1SnkkMnK5Uq1fI8inE/X5row9Ny9Sk1Wf9I93rxqRVScGDyP2T85FvRQyH
 Jevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=CFVi+z2mf3tcxTeka+vBro0+oe+hOysH+c9hAxWeWVo=;
 b=RGplyPr+bXAFEih7Yzl+WtLwUgIMVylQ7Obt8MvgVXtAgmXkYntYGiGkzPZrjWkfLI
 yQezUMjQPFUs8aet58k6ryI3dc8fwqMtDCwi3goqAk2LiQIYM8ibIimbJShVPiNFUwnO
 y4jb0B1dnFZRhvS4Mi5Lj78/B4+ZD6zoQ6D2m3l8wUqsG0cFjeZxBlChVJJ3VL+i7lHE
 uYnEh5FJDIr8uyqK5O+ES7btFrVCxTiJTArXdcdTHpknN59FTx+WnzXtJY5+4ptsLUpl
 P+axv4OwHvABNsjtk4nKlmTNmoV4iCmRpztvxq/P5bKEvyQkB0rdeGI78KuPTeIO3mdh
 w1VQ==
X-Gm-Message-State: AOAM5324cGz6GpdnjaaJqIg+5PTARYoo1d8O/N2A7Rkd0gdfmlK2y6xs
 kDo8VynLXkvGfdM9mjTwvOK/4mh4ideQEMFggw==
X-Google-Smtp-Source: ABdhPJysMqXUJAzO1vOoSFxrn6Aqqbe6XuMMmvJplKcRhx9s+1fOYKylH+vH6p4FZQqqeG12u8KOOqP753MAiOVEjA==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:902:7601:b029:108:8f75:915b with
 SMTP id k1-20020a1709027601b02901088f75915bmr2976682pll.71.1623991707762;
 Thu, 17 Jun 2021 21:48:27 -0700 (PDT)
Date: Fri, 18 Jun 2021 04:48:15 +0000
In-Reply-To: <20210618044819.3690166-1-jingzhangos@google.com>
Message-Id: <20210618044819.3690166-4-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v11 3/7] KVM: stats: Support binary stats retrieval for a VM
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>, 
 LinuxMIPS <linux-mips@vger.kernel.org>, KVMPPC <kvm-ppc@vger.kernel.org>, 
 LinuxS390 <linux-s390@vger.kernel.org>, 
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, 
 Peter Shier <pshier@google.com>, Oliver Upton <oupton@google.com>, 
 David Rientjes <rientjes@google.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>, 
 David Matlack <dmatlack@google.com>, Ricardo Koller <ricarkol@google.com>, 
 Krish Sadhukhan <krish.sadhukhan@oracle.com>, Fuad Tabba <tabba@google.com>, 
 Greg KH <gregkh@linuxfoundation.org>
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

Add a VM ioctl to get a statistics file descriptor by which a read
functionality is provided for userspace to read out VM stats header,
descriptors and data.
Define VM statistics descriptors and header for all architectures.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com> #arm64
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kvm/guest.c    | 14 +++++++++++++
 arch/mips/kvm/mips.c      | 14 +++++++++++++
 arch/powerpc/kvm/book3s.c | 16 +++++++++++++++
 arch/powerpc/kvm/booke.c  | 16 +++++++++++++++
 arch/s390/kvm/kvm-s390.c  | 19 +++++++++++++++++
 arch/x86/kvm/x86.c        | 24 ++++++++++++++++++++++
 include/linux/kvm_host.h  |  6 ++++++
 virt/kvm/kvm_main.c       | 43 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 152 insertions(+)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 4962331d01e6..f456d1defe2b 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -28,6 +28,20 @@
 
 #include "trace.h"
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS()
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vm_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vm_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vm_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
 	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index ff205b35719b..a1c6b9c5a4ae 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -38,6 +38,20 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS()
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vm_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vm_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vm_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("wait", wait_exits),
 	VCPU_STAT("cache", cache_exits),
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 92cdb4175945..d3dfdddb4f7d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -38,6 +38,22 @@
 
 /* #define EXIT_DEBUG */
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_ICOUNTER(VM, num_2M_pages),
+	STATS_DESC_ICOUNTER(VM, num_1G_pages)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vm_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vm_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vm_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("exits", sum_exits),
 	VCPU_STAT("mmio", mmio_exits),
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 80d3b39aa7ac..4e4a58b19487 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -36,6 +36,22 @@
 
 unsigned long kvmppc_booke_handlers;
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_ICOUNTER(VM, num_2M_pages),
+	STATS_DESC_ICOUNTER(VM, num_1G_pages)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vm_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vm_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vm_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("mmio", mmio_exits),
 	VCPU_STAT("sig", signal_exits),
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e8bc7cd06794..89c0a2722183 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -58,6 +58,25 @@
 #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_COUNTER(VM, inject_io),
+	STATS_DESC_COUNTER(VM, inject_float_mchk),
+	STATS_DESC_COUNTER(VM, inject_pfault_done),
+	STATS_DESC_COUNTER(VM, inject_service_signal),
+	STATS_DESC_COUNTER(VM, inject_virtio)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vm_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vm_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vm_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("userspace_handled", exit_userspace),
 	VCPU_STAT("exit_null", exit_null),
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 157212157aee..a461d9d79865 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -223,6 +223,30 @@ EXPORT_SYMBOL_GPL(host_xss);
 u64 __read_mostly supported_xss;
 EXPORT_SYMBOL_GPL(supported_xss);
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
+	STATS_DESC_COUNTER(VM, mmu_pte_write),
+	STATS_DESC_COUNTER(VM, mmu_pde_zapped),
+	STATS_DESC_COUNTER(VM, mmu_flooded),
+	STATS_DESC_COUNTER(VM, mmu_recycled),
+	STATS_DESC_COUNTER(VM, mmu_cache_miss),
+	STATS_DESC_ICOUNTER(VM, mmu_unsync),
+	STATS_DESC_ICOUNTER(VM, lpages),
+	STATS_DESC_ICOUNTER(VM, nx_lpage_splits),
+	STATS_DESC_ICOUNTER(VM, max_mmu_page_hash_collisions)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vm_stats_header = {
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vm_stats_desc),
+		.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+		.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+			       sizeof(kvm_vm_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("pf_fixed", pf_fixed),
 	VCPU_STAT("pf_guest", pf_guest),
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2f0d12064ae7..4c73bc761f96 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -599,6 +599,7 @@ struct kvm {
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 	struct notifier_block pm_notifier;
 #endif
+	char stats_id[KVM_STATS_ID_MAXLEN];
 };
 
 #define kvm_err(fmt, ...) \
@@ -1427,11 +1428,16 @@ struct _kvm_stats_desc {
 	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
 		KVM_STATS_BASE_POW10, -9)
 
+#define KVM_GENERIC_VM_STATS()						       \
+	STATS_DESC_COUNTER(VM_GENERIC, remote_tlb_flush)
+
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
 ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
 		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
 		char __user *user_buffer, size_t size, loff_t *offset);
+extern struct kvm_stats_header kvm_vm_stats_header;
+extern struct _kvm_stats_desc kvm_vm_stats_desc[];
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cec986487b30..cf0d487272b9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4055,6 +4055,46 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
 	}
 }
 
+static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
+			      size_t size, loff_t *offset)
+{
+	struct kvm *kvm = file->private_data;
+
+	return kvm_stats_read(kvm->stats_id, &kvm_vm_stats_header,
+				&kvm_vm_stats_desc[0], &kvm->stat,
+				sizeof(kvm->stat), user_buffer, size, offset);
+}
+
+static const struct file_operations kvm_vm_stats_fops = {
+	.read = kvm_vm_stats_read,
+	.llseek = noop_llseek,
+};
+
+static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
+{
+	int fd;
+	struct file *file;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	file = anon_inode_getfile("kvm-vm-stats",
+			&kvm_vm_stats_fops, kvm, O_RDONLY);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+	file->f_mode |= FMODE_PREAD;
+	fd_install(fd, file);
+
+	/* Fill the stats id string */
+	snprintf(kvm->stats_id, sizeof(kvm->stats_id),
+			"kvm-%d", task_pid_nr(current));
+
+	return fd;
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4237,6 +4277,9 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_RESET_DIRTY_RINGS:
 		r = kvm_vm_ioctl_reset_dirty_pages(kvm);
 		break;
+	case KVM_GET_STATS_FD:
+		r = kvm_vm_ioctl_get_stats_fd(kvm);
+		break;
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
 	}
-- 
2.32.0.288.g62a8d224e6-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
