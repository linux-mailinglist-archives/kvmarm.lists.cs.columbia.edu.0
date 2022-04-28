Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64551392B
	for <lists+kvmarm@lfdr.de>; Thu, 28 Apr 2022 17:56:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25DA44B2B5;
	Thu, 28 Apr 2022 11:56:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N7HP4NGaVtla; Thu, 28 Apr 2022 11:56:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 287924B28C;
	Thu, 28 Apr 2022 11:56:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B9F9C4B25C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Apr 2022 11:56:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YvqyKYIde4nk for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Apr 2022 11:56:22 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 48B2A4B2AB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Apr 2022 11:56:22 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5E0314BF;
 Thu, 28 Apr 2022 08:56:21 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502CB3F774;
 Thu, 28 Apr 2022 08:56:20 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: julien.thierry.kdev@gmail.com, will@kernel.org, maz@kernel.org,
 suzuki.poulose@arm.com, julien@xen.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com
Subject: [PATCH kvmtool 09/15] kvm__arch_init: Remove hugetlbfs_path and
 ram_size as parameters
Date: Thu, 28 Apr 2022 16:55:56 +0100
Message-Id: <20220428155602.29445-10-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220428155602.29445-1-alexandru.elisei@arm.com>
References: <20220428155602.29445-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: Julien Grall <julien.grall@arm.com>
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

From: Julien Grall <julien.grall@arm.com>

The kvm struct already contains a pointer to the configuration, which
contains both hugetlbfs_path and ram_size, so is it not necessary to pass
them as arguments to kvm__arch_init().

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/kvm.c         | 7 ++++---
 include/kvm/kvm.h | 2 +-
 kvm.c             | 2 +-
 mips/kvm.c        | 7 ++++---
 powerpc/kvm.c     | 5 +++--
 riscv/kvm.c       | 7 ++++---
 x86/kvm.c         | 4 +++-
 7 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arm/kvm.c b/arm/kvm.c
index af0feae495d7..bd44aa350796 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -57,7 +57,7 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 {
 }
 
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
 	/*
 	 * Allocate guest memory. We must align our buffer to 64K to
@@ -65,9 +65,10 @@ void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
 	 * If using THP, then our minimal alignment becomes 2M.
 	 * 2M trumps 64K, so let's go with that.
 	 */
-	kvm->ram_size = ram_size;
+	kvm->ram_size = kvm->cfg.ram_size;
 	kvm->arch.ram_alloc_size = kvm->ram_size + SZ_2M;
-	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
+	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm,
+						kvm->cfg.hugetlbfs_path,
 						kvm->arch.ram_alloc_size);
 
 	if (kvm->arch.ram_alloc_start == MAP_FAILED)
diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index 9f7b2fb26e95..640b76c095f9 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -189,7 +189,7 @@ void kvm__remove_socket(const char *name);
 
 void kvm__arch_validate_cfg(struct kvm *kvm);
 void kvm__arch_set_cmdline(char *cmdline, bool video);
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size);
+void kvm__arch_init(struct kvm *kvm);
 void kvm__arch_delete_ram(struct kvm *kvm);
 int kvm__arch_setup_firmware(struct kvm *kvm);
 int kvm__arch_free_firmware(struct kvm *kvm);
diff --git a/kvm.c b/kvm.c
index 952ef1fbb41c..42b881217df6 100644
--- a/kvm.c
+++ b/kvm.c
@@ -479,7 +479,7 @@ int kvm__init(struct kvm *kvm)
 		goto err_vm_fd;
 	}
 
-	kvm__arch_init(kvm, kvm->cfg.hugetlbfs_path, kvm->cfg.ram_size);
+	kvm__arch_init(kvm);
 
 	INIT_LIST_HEAD(&kvm->mem_banks);
 	kvm__init_ram(kvm);
diff --git a/mips/kvm.c b/mips/kvm.c
index f5b137f46dff..d8610cf81b94 100644
--- a/mips/kvm.c
+++ b/mips/kvm.c
@@ -61,12 +61,13 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 }
 
 /* Architecture-specific KVM init */
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
 	int ret;
 
-	kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram_size);
-	kvm->ram_size = ram_size;
+	kvm->ram_size = kvm->cfg.ram_size;
+	kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, kvm->cfg.hugetlbfs_path,
+						kvm->ram_size);
 
 	if (kvm->ram_start == MAP_FAILED)
 		die("out of memory");
diff --git a/powerpc/kvm.c b/powerpc/kvm.c
index 3215b579f5dc..d281b070fd0e 100644
--- a/powerpc/kvm.c
+++ b/powerpc/kvm.c
@@ -92,12 +92,13 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 }
 
 /* Architecture-specific KVM init */
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
+	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
 	int cap_ppc_rma;
 	unsigned long hpt;
 
-	kvm->ram_size		= ram_size;
+	kvm->ram_size		= kvm->cfg.ram_size;
 
 	/* Map "default" hugetblfs path to the standard 16M mount point */
 	if (hugetlbfs_path && !strcmp(hugetlbfs_path, "default"))
diff --git a/riscv/kvm.c b/riscv/kvm.c
index 7fb496282f4c..c46660772aa0 100644
--- a/riscv/kvm.c
+++ b/riscv/kvm.c
@@ -56,7 +56,7 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 {
 }
 
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
 	/*
 	 * Allocate guest memory. We must align our buffer to 64K to
@@ -64,9 +64,10 @@ void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
 	 * If using THP, then our minimal alignment becomes 2M.
 	 * 2M trumps 64K, so let's go with that.
 	 */
-	kvm->ram_size = min(ram_size, (u64)RISCV_MAX_MEMORY(kvm));
+	kvm->ram_size = min(kvm->cfg.ram_size, (u64)RISCV_MAX_MEMORY(kvm));
 	kvm->arch.ram_alloc_size = kvm->ram_size + SZ_2M;
-	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
+	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm,
+						kvm->cfg.hugetlbfs_path,
 						kvm->arch.ram_alloc_size);
 
 	if (kvm->arch.ram_alloc_start == MAP_FAILED)
diff --git a/x86/kvm.c b/x86/kvm.c
index 6683a5c81d49..24b0305a1841 100644
--- a/x86/kvm.c
+++ b/x86/kvm.c
@@ -134,9 +134,11 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 }
 
 /* Architecture-specific KVM init */
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
+	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
 	struct kvm_pit_config pit_config = { .flags = 0, };
+	u64 ram_size = kvm->cfg.ram_size;
 	int ret;
 
 	ret = ioctl(kvm->vm_fd, KVM_SET_TSS_ADDR, 0xfffbd000);
-- 
2.36.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
