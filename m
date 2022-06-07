Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8C533BAC
	for <lists+kvmarm@lfdr.de>; Wed, 25 May 2022 13:24:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 946604B2F0;
	Wed, 25 May 2022 07:24:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level: 
X-Spam-Status: No, score=-1.898 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_BLOCKED=0.001, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qz7jgqDkNIMD; Wed, 25 May 2022 07:24:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DDCC4B306;
	Wed, 25 May 2022 07:24:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F2A94B31D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 May 2022 07:23:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7q1j1KPp-Py0 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 May 2022 07:23:57 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B63C04B2E3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 May 2022 07:23:57 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600B01FB;
 Wed, 25 May 2022 04:23:57 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D5C93F70D;
 Wed, 25 May 2022 04:23:55 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org,
 suzuki.poulose@arm.com, julien@xen.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com, andre.przywara@arm.com
Subject: [PATCH v3 kvmtool 10/13] kvm__arch_init: Remove hugetlbfs_path and
 ram_size as parameters
Date: Wed, 25 May 2022 12:23:42 +0100
Message-Id: <20220525112345.121321-11-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525112345.121321-1-alexandru.elisei@arm.com>
References: <20220525112345.121321-1-alexandru.elisei@arm.com>
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
2.36.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
