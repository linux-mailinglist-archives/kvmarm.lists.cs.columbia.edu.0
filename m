Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2FB5F5DD5
	for <lists+kvmarm@lfdr.de>; Thu,  6 Oct 2022 02:34:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 92F634B105;
	Wed,  5 Oct 2022 20:34:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sj2t5OfZwP4Z; Wed,  5 Oct 2022 20:34:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14F514B0B4;
	Wed,  5 Oct 2022 20:34:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B638401AF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Oct 2022 20:34:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gn4mIJsAkdMd for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Oct 2022 20:34:21 -0400 (EDT)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A5E9149AF7
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Oct 2022 20:34:19 -0400 (EDT)
Received: by mail-pj1-f73.google.com with SMTP id
 o11-20020a17090aac0b00b0020625062cbaso1845696pjq.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 05 Oct 2022 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=AQ72VyTuC/G3NaFOUF1Q9p1kgky8uONLmSUXoU5Uqn0=;
 b=pBFla8vff11asOIVrrsdSDGgRIsMj5WDsoRCPe/nnZxrjhLRNVkE9ijzfDY9MTOWE6
 4iTpL3UP5G+LZhda8tcJFid9AbOKKeHWh6wlxeEE4MeERuyoOz9R4aUU0h5y450QoGxx
 Yi0sU7MKEH4rPmZzszx865t5TJrijF5QpBLyLxysnc0WZuLeDwbwS2I6lFrt0slb3Gni
 wSUq/ciZPtt3B93MBR18dMz8lhRCPy7e/67pm2fvY4znks8bV55gEBOHIp9+jK9MPMEd
 S2D5mKtvW3KoElaqz/tG4SrzkXJrOFNK4RAa8sWmRAVihEHVxjx12ClNgfmqWXso1VUp
 1XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQ72VyTuC/G3NaFOUF1Q9p1kgky8uONLmSUXoU5Uqn0=;
 b=C8v/DTr220t0u6FZMCuP/jxETWR/CWp+e1RX8MXzQrYRdNHEfm2Hmmp+lySY22hej9
 ZJ5MZBtDWqFBRuXk7r1MTbtgq1cqEuXzSgtfkTy7VfLoOePUPuA+KOiWEg1aJEbd9UAG
 7edRGlGrNgUnCfssl6J59z08f9UjWVF89JOr80Srye+5prrNWblVgqIh/olnQXeokAJC
 OOMRZQ8ajb2ik8JUKi246cyvWNIoPy35fzhUZI+PcCrGkfpVYl6uOTvZ15QOYiCHctqU
 Acsx6+MeZdP2OpoVf2iFvRQJchJbGm14lewzDSkVVgDQbmd7pq+fQRpJxsc6tD9SYRMQ
 0OTg==
X-Gm-Message-State: ACrzQf2ORJDj1+V0F+Cma8AnDHzgg5231UaBZxSF6aEiqVVIVysmGqLU
 YTgvVcxHZQo37SZCC4VJLm0/Fu5z8+o=
X-Google-Smtp-Source: AMsMyM7ziffhKF8pCDO53rLOABTCCpOGYw0oqnohwYfvQ0lVqMNad50omt0jUjZ62lBHtGHdcAnw4muK5Go=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:328b:b0:53e:816a:ee5a with SMTP id
 ck11-20020a056a00328b00b0053e816aee5amr2234384pfb.71.1665016458849; Wed, 05
 Oct 2022 17:34:18 -0700 (PDT)
Date: Thu,  6 Oct 2022 00:34:05 +0000
In-Reply-To: <20221006003409.649993-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006003409.649993-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006003409.649993-4-seanjc@google.com>
Subject: [PATCH v6 3/7] KVM: selftests: Automatically do init_ucall() for
 non-barebones VMs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Marc Zyngier <maz@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: llvm@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>,
 Peter Gonda <pgonda@google.com>, linux-kselftest@vger.kernel.org,
 Atish Patra <atishp@atishpatra.org>, kvmarm@lists.linux.dev,
 linux-riscv@lists.infradead.org, Andrew Jones <andrew.jones@linux.dev>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Do init_ucall() automatically during VM creation to kill two (three?)
birds with one stone.

First, initializing ucall immediately after VM creations allows forcing
aarch64's MMIO ucall address to immediately follow memslot0.  This is
still somewhat fragile as tests could clobber the MMIO address with a
new memslot, but it's safe-ish since tests have to be conversative when
accounting for memslot0.  And this can be hardened in the future by
creating a read-only memslot for the MMIO page (KVM ARM exits with MMIO
if the guest writes to a read-only memslot).  Add a TODO to document that
selftests can and should use a memslot for the ucall MMIO (doing so
requires yet more rework because tests assumes thay can use all memslots
except memslot0).

Second, initializing ucall for all VMs prepares for making ucall
initialization meaningful on all architectures.  aarch64 is currently the
only arch that needs to do any setup, but that will change in the future
by switching to a pool-based implementation (instead of the current
stack-based approach).

Lastly, defining the ucall MMIO address from common code will simplify
switching all architectures (except s390) to a common MMIO-based ucall
implementation (if there's ever sufficient motivation to do so).

Cc: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Tested-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/aarch64/arch_timer.c        |  1 -
 .../selftests/kvm/aarch64/debug-exceptions.c  |  1 -
 .../selftests/kvm/aarch64/hypercalls.c        |  1 -
 .../testing/selftests/kvm/aarch64/psci_test.c |  1 -
 .../testing/selftests/kvm/aarch64/vgic_init.c |  2 -
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |  1 -
 tools/testing/selftests/kvm/dirty_log_test.c  |  2 -
 .../selftests/kvm/include/ucall_common.h      |  6 +--
 .../selftests/kvm/kvm_page_table_test.c       |  1 -
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 54 ++-----------------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 11 ++++
 .../selftests/kvm/lib/perf_test_util.c        |  2 -
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  2 +-
 tools/testing/selftests/kvm/lib/s390x/ucall.c |  2 +-
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  2 +-
 .../testing/selftests/kvm/memslot_perf_test.c |  1 -
 tools/testing/selftests/kvm/rseq_test.c       |  1 -
 tools/testing/selftests/kvm/steal_time.c      |  1 -
 .../kvm/system_counter_offset_test.c          |  1 -
 19 files changed, 20 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 574eb73f0e90..37c0ddebf4db 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -375,7 +375,6 @@ static struct kvm_vm *test_vm_create(void)
 	for (i = 0; i < nr_vcpus; i++)
 		vcpu_init_descriptor_tables(vcpus[i]);
 
-	ucall_init(vm, NULL);
 	test_init_timer_irq(vm);
 	gic_fd = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
 	__TEST_REQUIRE(gic_fd >= 0, "Failed to create vgic-v3");
diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index 947bd201435c..b08b1edc369f 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -295,7 +295,6 @@ static void test_guest_debug_exceptions(void)
 	int stage;
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	ucall_init(vm, NULL);
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
index a39da3fe4952..3dceecfd1f62 100644
--- a/tools/testing/selftests/kvm/aarch64/hypercalls.c
+++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
@@ -236,7 +236,6 @@ static struct kvm_vm *test_vm_create(struct kvm_vcpu **vcpu)
 
 	vm = vm_create_with_one_vcpu(vcpu, guest_code);
 
-	ucall_init(vm, NULL);
 	steal_time_init(*vcpu);
 
 	return vm;
diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index e0b9e81a3e09..cfa36f387948 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -79,7 +79,6 @@ static struct kvm_vm *setup_vm(void *guest_code, struct kvm_vcpu **source,
 	struct kvm_vm *vm;
 
 	vm = vm_create(2);
-	ucall_init(vm, NULL);
 
 	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
 	init.features[0] |= (1 << KVM_ARM_VCPU_PSCI_0_2);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index e05ecb31823f..cc828fb53d8f 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -68,8 +68,6 @@ static void guest_code(void)
 /* we don't want to assert on run execution, hence that helper */
 static int run_vcpu(struct kvm_vcpu *vcpu)
 {
-	ucall_init(vcpu->vm, NULL);
-
 	return __vcpu_run(vcpu) ? -errno : 0;
 }
 
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 17417220a083..d1817f852daf 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -756,7 +756,6 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 	print_args(&args);
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	ucall_init(vm, NULL);
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index b5234d6efbe1..b458a2701634 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -756,8 +756,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	/* Cache the HVA pointer of the region */
 	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
 
-	ucall_init(vm, NULL);
-
 	/* Export the shared variables to the guest */
 	sync_global_to_guest(vm, host_page_size);
 	sync_global_to_guest(vm, guest_page_size);
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 63bfc60be995..8077a6d8b1ba 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -24,7 +24,7 @@ struct ucall {
 	uint64_t args[UCALL_MAX_ARGS];
 };
 
-void ucall_arch_init(struct kvm_vm *vm, void *arg);
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
 void ucall_arch_uninit(struct kvm_vm *vm);
 void ucall_arch_do_ucall(vm_vaddr_t uc);
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
@@ -32,9 +32,9 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 void ucall(uint64_t cmd, int nargs, ...);
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 
-static inline void ucall_init(struct kvm_vm *vm, void *arg)
+static inline void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
-	ucall_arch_init(vm, arg);
+	ucall_arch_init(vm, mmio_gpa);
 }
 
 static inline void ucall_uninit(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index f42c6ac6d71d..20533c48ba3d 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -289,7 +289,6 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
 
 	/* Export shared structure test_args to guest */
-	ucall_init(vm, NULL);
 	sync_global_to_guest(vm, test_args);
 
 	ret = sem_init(&test_stage_updated, 0, 0);
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index f214f5cc53d3..f02ae27c3e43 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -8,60 +8,12 @@
 
 static vm_vaddr_t *ucall_exit_mmio_addr;
 
-static bool ucall_mmio_init(struct kvm_vm *vm, vm_paddr_t gpa)
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
-	if (kvm_userspace_memory_region_find(vm, gpa, gpa + 1))
-		return false;
+	virt_pg_map(vm, mmio_gpa, mmio_gpa);
 
-	virt_pg_map(vm, gpa, gpa);
-
-	ucall_exit_mmio_addr = (vm_vaddr_t *)gpa;
+	ucall_exit_mmio_addr = (vm_vaddr_t *)mmio_gpa;
 	sync_global_to_guest(vm, ucall_exit_mmio_addr);
-
-	return true;
-}
-
-void ucall_arch_init(struct kvm_vm *vm, void *arg)
-{
-	vm_paddr_t gpa, start, end, step, offset;
-	unsigned int bits;
-	bool ret;
-
-	if (arg) {
-		gpa = (vm_paddr_t)arg;
-		ret = ucall_mmio_init(vm, gpa);
-		TEST_ASSERT(ret, "Can't set ucall mmio address to %lx", gpa);
-		return;
-	}
-
-	/*
-	 * Find an address within the allowed physical and virtual address
-	 * spaces, that does _not_ have a KVM memory region associated with
-	 * it. Identity mapping an address like this allows the guest to
-	 * access it, but as KVM doesn't know what to do with it, it
-	 * will assume it's something userspace handles and exit with
-	 * KVM_EXIT_MMIO. Well, at least that's how it works for AArch64.
-	 * Here we start with a guess that the addresses around 5/8th
-	 * of the allowed space are unmapped and then work both down and
-	 * up from there in 1/16th allowed space sized steps.
-	 *
-	 * Note, we need to use VA-bits - 1 when calculating the allowed
-	 * virtual address space for an identity mapping because the upper
-	 * half of the virtual address space is the two's complement of the
-	 * lower and won't match physical addresses.
-	 */
-	bits = vm->va_bits - 1;
-	bits = min(vm->pa_bits, bits);
-	end = 1ul << bits;
-	start = end * 5 / 8;
-	step = end / 16;
-	for (offset = 0; offset < end - start; offset += step) {
-		if (ucall_mmio_init(vm, start - offset))
-			return;
-		if (ucall_mmio_init(vm, start + offset))
-			return;
-	}
-	TEST_FAIL("Can't find a ucall mmio address");
 }
 
 void ucall_arch_uninit(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f1cb1627161f..f12ebd27f6e5 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -334,6 +334,7 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 {
 	uint64_t nr_pages = vm_nr_pages_required(mode, nr_runnable_vcpus,
 						 nr_extra_pages);
+	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
 
 	vm = ____vm_create(mode, nr_pages);
@@ -343,6 +344,16 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
 #endif
+
+	/*
+	 * TODO: Add proper defines to protect the library's memslots, and then
+	 * carve out memslot1 for the ucall MMIO address.  KVM treats writes to
+	 * read-only memslots as MMIO, and creating a read-only memslot for the
+	 * MMIO region would prevent silently clobbering the MMIO region.
+	 */
+	slot0 = memslot2region(vm, 0);
+	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
+
 	return vm;
 }
 
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 9618b37c66f7..5161fa68cdf3 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -209,8 +209,6 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 		perf_test_setup_nested(vm, nr_vcpus, vcpus);
 	}
 
-	ucall_init(vm, NULL);
-
 	/* Export the shared variables to the guest. */
 	sync_global_to_guest(vm, perf_test_args);
 
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index 37e091d4366e..c58ecb8a0981 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -10,7 +10,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-void ucall_arch_init(struct kvm_vm *vm, void *arg)
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
 }
 
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
index 0f695a031d35..208f0f04299b 100644
--- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -6,7 +6,7 @@
  */
 #include "kvm_util.h"
 
-void ucall_arch_init(struct kvm_vm *vm, void *arg)
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index ead9946399ab..016a0487cf72 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -8,7 +8,7 @@
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
-void ucall_arch_init(struct kvm_vm *vm, void *arg)
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
 }
 
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 44995446d942..4ed5acd74278 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -277,7 +277,6 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
 	TEST_ASSERT(data->hva_slots, "malloc() fail");
 
 	data->vm = __vm_create_with_one_vcpu(&data->vcpu, mempages, guest_code);
-	ucall_init(data->vm, NULL);
 
 	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
 		max_mem_slots - 1, data->pages_per_slot, rempages);
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 6f88da7e60be..0e9e2b48a51f 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -224,7 +224,6 @@ int main(int argc, char *argv[])
 	 * CPU affinity.
 	 */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	ucall_init(vm, NULL);
 
 	pthread_create(&migration_thread, NULL, migration_worker,
 		       (void *)(unsigned long)syscall(SYS_gettid));
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index db8967f1a17b..c87f38712073 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -266,7 +266,6 @@ int main(int ac, char **av)
 	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE * NR_VCPUS);
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
 	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, gpages);
-	ucall_init(vm, NULL);
 
 	TEST_REQUIRE(is_steal_time_supported(vcpus[0]));
 
diff --git a/tools/testing/selftests/kvm/system_counter_offset_test.c b/tools/testing/selftests/kvm/system_counter_offset_test.c
index 1c274933912b..7f5b330b6a1b 100644
--- a/tools/testing/selftests/kvm/system_counter_offset_test.c
+++ b/tools/testing/selftests/kvm/system_counter_offset_test.c
@@ -121,7 +121,6 @@ int main(void)
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 	check_preconditions(vcpu);
-	ucall_init(vm, NULL);
 
 	enter_guest(vcpu);
 	kvm_vm_free(vm);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
