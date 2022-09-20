Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E2F4E5BDF33
	for <lists+kvmarm@lfdr.de>; Tue, 20 Sep 2022 10:05:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 104234B601;
	Tue, 20 Sep 2022 04:05:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGL3tj6d2FY2; Tue, 20 Sep 2022 04:05:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E47CA4B637;
	Tue, 20 Sep 2022 04:05:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C7A04B629
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Sep 2022 04:05:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nFGgK+i6XK9F for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Sep 2022 04:05:25 -0400 (EDT)
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 486AA4B601
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Sep 2022 04:05:25 -0400 (EDT)
Date: Tue, 20 Sep 2022 10:05:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1663661123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRE+wqaIknwOCZgtLWFPadbfTQK8MnD3gYUb5Lpmp1A=;
 b=GVeXK6fFJLmqkGPMr+/XR2PVcDJs6Or8WaCVzJbPbjtTF/wqMAg0c07zmL27a1It4OduUj
 ryCFeXAj6jD0vPp2Vx3maOhMpM90YwY1fCUiMfUGDJGeD2CCIbbDHGaMN+I+yKk3gKCx5D
 g7j2j7A5dyfMNvPf9w5NpOQSz/MdMVk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v7 09/13] KVM: selftests: aarch64: Add
 aarch64/page_fault_test
Message-ID: <20220920080515.x3v4gjvgtfatt55c@kamzik>
References: <20220920042551.3154283-1-ricarkol@google.com>
 <20220920042551.3154283-10-ricarkol@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220920042551.3154283-10-ricarkol@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: kvm@vger.kernel.org, maz@kernel.org, bgardon@google.com,
 pbonzini@redhat.com, axelrasmussen@google.com, kvmarm@lists.cs.columbia.edu,
 dmatlack@google.com
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

On Tue, Sep 20, 2022 at 04:25:47AM +0000, Ricardo Koller wrote:
> Add a new test for stage 2 faults when using different combinations of
> guest accesses (e.g., write, S1PTW), backing source type (e.g., anon)
> and types of faults (e.g., read on hugetlbfs with a hole). The next
> commits will add different handling methods and more faults (e.g., uffd
> and dirty logging). This first commit starts by adding two sanity checks
> for all types of accesses: AF setting by the hw, and accessing memslots
> with holes.
> 
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/aarch64/page_fault_test.c   | 601 ++++++++++++++++++
>  .../selftests/kvm/include/aarch64/processor.h |   8 +
>  4 files changed, 611 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/page_fault_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index d625a3f83780..7a9022cfa033 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -3,6 +3,7 @@
>  /aarch64/debug-exceptions
>  /aarch64/get-reg-list
>  /aarch64/hypercalls
> +/aarch64/page_fault_test
>  /aarch64/psci_test
>  /aarch64/vcpu_width_config
>  /aarch64/vgic_init
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 1bb471aeb103..850e317b9e82 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -149,6 +149,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
>  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
> +TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
>  TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>  TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
>  TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
> diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> new file mode 100644
> index 000000000000..98f12e7af14b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * page_fault_test.c - Test stage 2 faults.
> + *
> + * This test tries different combinations of guest accesses (e.g., write,
> + * S1PTW), backing source type (e.g., anon) and types of faults (e.g., read on
> + * hugetlbfs with a hole). It checks that the expected handling method is
> + * called (e.g., uffd faults with the right address and write/read flag).
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/bitmap.h>
> +#include <fcntl.h>
> +#include <test_util.h>
> +#include <kvm_util.h>
> +#include <processor.h>
> +#include <asm/sysreg.h>
> +#include <linux/bitfield.h>
> +#include "guest_modes.h"
> +#include "userfaultfd_util.h"
> +
> +/* Guest virtual addresses that point to the test page and its PTE. */
> +#define TEST_GVA				0xc0000000
> +#define TEST_EXEC_GVA				(TEST_GVA + 0x8)
> +#define TEST_PTE_GVA				0xb0000000
> +#define TEST_DATA				0x0123456789ABCDEF
> +
> +static uint64_t *guest_test_memory = (uint64_t *)TEST_GVA;
> +
> +#define CMD_NONE				(0)
> +#define CMD_SKIP_TEST				(1ULL << 1)
> +#define CMD_HOLE_PT				(1ULL << 2)
> +#define CMD_HOLE_DATA				(1ULL << 3)
> +
> +#define PREPARE_FN_NR				10
> +#define CHECK_FN_NR				10
> +
> +struct test_desc {
> +	const char *name;
> +	uint64_t mem_mark_cmd;
> +	/* Skip the test if any prepare function returns false */
> +	bool (*guest_prepare[PREPARE_FN_NR])(void);
> +	void (*guest_test)(void);
> +	void (*guest_test_check[CHECK_FN_NR])(void);
> +	void (*dabt_handler)(struct ex_regs *regs);
> +	void (*iabt_handler)(struct ex_regs *regs);
> +	uint32_t pt_memslot_flags;
> +	uint32_t data_memslot_flags;
> +	bool skip;
> +};
> +
> +struct test_params {
> +	enum vm_mem_backing_src_type src_type;
> +	struct test_desc *test_desc;
> +};
> +
> +static inline void flush_tlb_page(uint64_t vaddr)
> +{
> +	uint64_t page = vaddr >> 12;
> +
> +	dsb(ishst);
> +	asm volatile("tlbi vaae1is, %0" :: "r" (page));
> +	dsb(ish);
> +	isb();
> +}
> +
> +static void guest_write64(void)
> +{
> +	uint64_t val;
> +
> +	WRITE_ONCE(*guest_test_memory, TEST_DATA);
> +	val = READ_ONCE(*guest_test_memory);
> +	GUEST_ASSERT_EQ(val, TEST_DATA);
> +}
> +
> +/* Check the system for atomic instructions. */
> +static bool guest_check_lse(void)
> +{
> +	uint64_t isar0 = read_sysreg(id_aa64isar0_el1);
> +	uint64_t atomic;
> +
> +	atomic = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64ISAR0_ATOMICS), isar0);
> +	return atomic >= 2;
> +}
> +
> +static bool guest_check_dc_zva(void)
> +{
> +	uint64_t dczid = read_sysreg(dczid_el0);
> +	uint64_t dzp = FIELD_GET(ARM64_FEATURE_MASK(DCZID_DZP), dczid);
> +
> +	return dzp == 0;
> +}
> +
> +/* Compare and swap instruction. */
> +static void guest_cas(void)
> +{
> +	uint64_t val;
> +
> +	GUEST_ASSERT(guest_check_lse());
> +	asm volatile(".arch_extension lse\n"
> +		     "casal %0, %1, [%2]\n"
> +			:: "r" (0), "r" (TEST_DATA), "r" (guest_test_memory));
> +	val = READ_ONCE(*guest_test_memory);
> +	GUEST_ASSERT_EQ(val, TEST_DATA);
> +}
> +
> +static void guest_read64(void)
> +{
> +	uint64_t val;
> +
> +	val = READ_ONCE(*guest_test_memory);
> +	GUEST_ASSERT_EQ(val, 0);
> +}
> +
> +/* Address translation instruction */
> +static void guest_at(void)
> +{
> +	uint64_t par;
> +
> +	asm volatile("at s1e1r, %0" :: "r" (guest_test_memory));
> +	par = read_sysreg(par_el1);
> +	isb();
> +
> +	/* Bit 1 indicates whether the AT was successful */
> +	GUEST_ASSERT_EQ(par & 1, 0);
> +}
> +
> +/*
> + * The size of the block written by "dc zva" is guaranteed to be between (2 <<
> + * 0) and (2 << 9), which is safe in our case as we need the write to happen
> + * for at least a word, and not more than a page.
> + */
> +static void guest_dc_zva(void)
> +{
> +	uint16_t val;
> +
> +	asm volatile("dc zva, %0" :: "r" (guest_test_memory));
> +	dsb(ish);
> +	val = READ_ONCE(*guest_test_memory);
> +	GUEST_ASSERT_EQ(val, 0);
> +}
> +
> +/*
> + * Pre-indexing loads and stores don't have a valid syndrome (ESR_EL2.ISV==0).
> + * And that's special because KVM must take special care with those: they
> + * should still count as accesses for dirty logging or user-faulting, but
> + * should be handled differently on mmio.
> + */
> +static void guest_ld_preidx(void)
> +{
> +	uint64_t val;
> +	uint64_t addr = TEST_GVA - 8;
> +
> +	/*
> +	 * This ends up accessing "TEST_GVA + 8 - 8", where "TEST_GVA - 8" is
> +	 * in a gap between memslots not backing by anything.
> +	 */
> +	asm volatile("ldr %0, [%1, #8]!"
> +			: "=r" (val), "+r" (addr));
> +	GUEST_ASSERT_EQ(val, 0);
> +	GUEST_ASSERT_EQ(addr, TEST_GVA);
> +}
> +
> +static void guest_st_preidx(void)
> +{
> +	uint64_t val = TEST_DATA;
> +	uint64_t addr = TEST_GVA - 8;
> +
> +	asm volatile("str %0, [%1, #8]!"
> +			: "+r" (val), "+r" (addr));
> +
> +	GUEST_ASSERT_EQ(addr, TEST_GVA);
> +	val = READ_ONCE(*guest_test_memory);
> +}
> +
> +static bool guest_set_ha(void)
> +{
> +	uint64_t mmfr1 = read_sysreg(id_aa64mmfr1_el1);
> +	uint64_t hadbs, tcr;
> +
> +	/* Skip if HA is not supported. */
> +	hadbs = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64MMFR1_HADBS), mmfr1);
> +	if (hadbs == 0)
> +		return false;
> +
> +	tcr = read_sysreg(tcr_el1) | TCR_EL1_HA;
> +	write_sysreg(tcr, tcr_el1);
> +	isb();
> +
> +	return true;
> +}
> +
> +static bool guest_clear_pte_af(void)
> +{
> +	*((uint64_t *)TEST_PTE_GVA) &= ~PTE_AF;
> +	flush_tlb_page(TEST_GVA);
> +
> +	return true;
> +}
> +
> +static void guest_check_pte_af(void)
> +{
> +	dsb(ish);
> +	GUEST_ASSERT_EQ(*((uint64_t *)TEST_PTE_GVA) & PTE_AF, PTE_AF);
> +}
> +
> +static void guest_exec(void)
> +{
> +	int (*code)(void) = (int (*)(void))TEST_EXEC_GVA;
> +	int ret;
> +
> +	ret = code();
> +	GUEST_ASSERT_EQ(ret, 0x77);
> +}
> +
> +static bool guest_prepare(struct test_desc *test)
> +{
> +	bool (*prepare_fn)(void);
> +	int i;
> +
> +	for (i = 0; i < PREPARE_FN_NR; i++) {
> +		prepare_fn = test->guest_prepare[i];
> +		if (prepare_fn && !prepare_fn())
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void guest_test_check(struct test_desc *test)
> +{
> +	void (*check_fn)(void);
> +	int i;
> +
> +	for (i = 0; i < CHECK_FN_NR; i++) {
> +		check_fn = test->guest_test_check[i];
> +		if (check_fn)
> +			check_fn();
> +	}
> +}
> +
> +static void guest_code(struct test_desc *test)
> +{
> +	if (!guest_prepare(test))
> +		GUEST_SYNC(CMD_SKIP_TEST);
> +
> +	GUEST_SYNC(test->mem_mark_cmd);
> +
> +	if (test->guest_test)
> +		test->guest_test();
> +
> +	guest_test_check(test);
> +	GUEST_DONE();
> +}
> +
> +static void no_dabt_handler(struct ex_regs *regs)
> +{
> +	GUEST_ASSERT_1(false, read_sysreg(far_el1));
> +}
> +
> +static void no_iabt_handler(struct ex_regs *regs)
> +{
> +	GUEST_ASSERT_1(false, regs->pc);
> +}
> +
> +/* Returns true to continue the test, and false if it should be skipped. */
> +static bool punch_hole_in_memslot(struct kvm_vm *vm,
> +				  struct userspace_mem_region *region)
> +{
> +	void *hva = (void *)region->region.userspace_addr;
> +	uint64_t paging_size = region->region.memory_size;
> +	int ret, fd = region->fd;
> +
> +	if (fd != -1) {
> +		ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				0, paging_size);
> +		TEST_ASSERT(ret == 0, "fallocate failed, errno: %d\n", errno);
> +	} else {
> +		if (is_backing_src_hugetlb(region->backing_src_type))
> +			return false;
> +
> +		ret = madvise(hva, paging_size, MADV_DONTNEED);
> +		TEST_ASSERT(ret == 0, "madvise failed, errno: %d\n", errno);
> +	}
> +
> +	return true;
> +}
> +
> +/* Returns true to continue the test, and false if it should be skipped. */
> +static bool handle_cmd(struct kvm_vm *vm, int cmd)
> +{
> +	struct userspace_mem_region *data_region, *pt_region;
> +	bool continue_test = true;
> +
> +	data_region = vm_get_mem_region(vm, MEM_REGION_DATA);
> +	pt_region = vm_get_mem_region(vm, MEM_REGION_PT);
> +
> +	if (cmd == CMD_SKIP_TEST)
> +		continue_test = false;
> +
> +	if (cmd & CMD_HOLE_PT)
> +		continue_test = punch_hole_in_memslot(vm, pt_region);
> +	if (cmd & CMD_HOLE_DATA)
> +		continue_test = punch_hole_in_memslot(vm, data_region);
> +
> +	return continue_test;
> +}
> +
> +typedef uint32_t aarch64_insn_t;
> +extern aarch64_insn_t __exec_test[2];
> +
> +void noinline __return_0x77(void)
> +{
> +	asm volatile("__exec_test: mov x0, #0x77\n"
> +			"ret\n");
> +}
> +
> +/*
> + * Note that this function runs on the host before the test VM starts: there's
> + * no need to sync the D$ and I$ caches.
> + */
> +static void load_exec_code_for_test(struct kvm_vm *vm)
> +{
> +	uint64_t *code;
> +	struct userspace_mem_region *region;
> +	void *hva;
> +
> +	region = vm_get_mem_region(vm, MEM_REGION_DATA);
> +	hva = (void *)region->region.userspace_addr;
> +
> +	assert(TEST_EXEC_GVA > TEST_GVA);
> +	code = hva + TEST_EXEC_GVA - TEST_GVA;
> +	memcpy(code, __exec_test, sizeof(__exec_test));
> +}
> +
> +static void setup_abort_handlers(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
> +		struct test_desc *test)
> +{
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vcpu);
> +
> +	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
> +			ESR_EC_DABT, no_dabt_handler);
> +	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
> +			ESR_EC_IABT, no_iabt_handler);
> +}
> +
> +static void setup_gva_maps(struct kvm_vm *vm)
> +{
> +	struct userspace_mem_region *region;
> +	uint64_t pte_gpa;
> +
> +	region = vm_get_mem_region(vm, MEM_REGION_DATA);
> +	/* Map TEST_GVA first. This will install a new PTE. */
> +	virt_pg_map(vm, TEST_GVA, region->region.guest_phys_addr);
> +	/* Then map TEST_PTE_GVA to the above PTE. */
> +	pte_gpa = addr_hva2gpa(vm, virt_get_pte_hva(vm, TEST_GVA));
> +	virt_pg_map(vm, TEST_PTE_GVA, pte_gpa);
> +}
> +
> +unsigned long get_max_gfn(enum vm_guest_mode mode)
> +{
> +	unsigned int pa_bits = vm_guest_mode_params[mode].pa_bits;
> +	unsigned int page_shift = vm_guest_mode_params[mode].page_shift;
> +
> +	return ((1ULL << pa_bits) >> page_shift) - 1;
> +}

The above function should be deleted.

> +
> +enum pf_test_memslots {
> +	CODE_MEMSLOT,
> +	PAGE_TABLE_MEMSLOT,
> +	DATA_MEMSLOT,
> +};
> +
> +/* Create a code memslot at pfn=0, and data and PT ones at max_gfn. */
> +static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
> +{
> +	uint64_t backing_src_pagesz = get_backing_src_pagesz(p->src_type);
> +	uint64_t guest_page_size = vm->page_size;
> +	uint64_t max_gfn = vm_compute_max_gfn(vm);
> +	/* Enough for 2M of code when using 4K guest pages. */
> +	uint64_t code_npages = 512;
> +	uint64_t pt_size, data_size, data_gpa;
> +
> +	/*
> +	 * This test requires 1 pgd, 2 pud, 4 pmd, and 6 pte pages when using
> +	 * VM_MODE_P48V48_4K. Note that the .text takes ~1.6MBs.  That's 13
> +	 * pages. VM_MODE_P48V48_4K is the mode with most PT pages; let's use
> +	 * twice that just in case.
> +	 */
> +	pt_size = 26 * guest_page_size;
> +
> +	/* memslot sizes and gpa's must be aligned to the backing page size */
> +	pt_size = align_up(pt_size, backing_src_pagesz);
> +	data_size = align_up(guest_page_size, backing_src_pagesz);
> +	data_gpa = (max_gfn * guest_page_size) - data_size;
> +	data_gpa = align_down(data_gpa, backing_src_pagesz);
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, CODE_MEMSLOT,
> +				    code_npages, 0);
> +	vm->memslots[MEM_REGION_CODE] = CODE_MEMSLOT;
> +
> +	vm_userspace_mem_region_add(vm, p->src_type, data_gpa - pt_size,
> +				    PAGE_TABLE_MEMSLOT, pt_size / guest_page_size,
> +				    p->test_desc->pt_memslot_flags);
> +	vm->memslots[MEM_REGION_PT] = PAGE_TABLE_MEMSLOT;
> +
> +	vm_userspace_mem_region_add(vm, p->src_type, data_gpa, DATA_MEMSLOT,
> +				    data_size / guest_page_size,
> +				    p->test_desc->data_memslot_flags);
> +	vm->memslots[MEM_REGION_DATA] = DATA_MEMSLOT;
> +}
> +
> +static void print_test_banner(enum vm_guest_mode mode, struct test_params *p)
> +{
> +	struct test_desc *test = p->test_desc;
> +
> +	pr_debug("Test: %s\n", test->name);
> +	pr_debug("Testing guest mode: %s\n", vm_guest_mode_string(mode));
> +	pr_debug("Testing memory backing src type: %s\n",
> +			vm_mem_backing_src_alias(p->src_type)->name);
> +}
> +
> +/*
> + * This function either succeeds, skips the test (after setting test->skip), or
> + * fails with a TEST_FAIL that aborts all tests.
> + */
> +static void vcpu_run_loop(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
> +			  struct test_desc *test)
> +{
> +	struct ucall uc;
> +
> +	for (;;) {
> +		vcpu_run(vcpu);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_SYNC:
> +			if (!handle_cmd(vm, uc.args[1])) {
> +				test->skip = true;
> +				goto done;
> +			}
> +			break;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
> +			break;
> +		case UCALL_DONE:
> +			goto done;
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		}
> +	}
> +
> +done:
> +	pr_debug(test->skip ? "Skipped.\n" : "Done.\n");
> +	return;
> +}
> +
> +static void run_test(enum vm_guest_mode mode, void *arg)
> +{
> +	struct test_params *p = (struct test_params *)arg;
> +	struct test_desc *test = p->test_desc;
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	print_test_banner(mode, p);
> +
> +	vm = ____vm_create(mode);
> +	setup_memslots(vm, p);
> +	kvm_vm_elf_load(vm, program_invocation_name);
> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
> +
> +	setup_gva_maps(vm);
> +
> +	ucall_init(vm, NULL);
> +
> +	load_exec_code_for_test(vm);
> +	setup_abort_handlers(vm, vcpu, test);
> +	vcpu_args_set(vcpu, 1, test);
> +
> +	vcpu_run_loop(vm, vcpu, test);
> +
> +	ucall_uninit(vm);
> +	kvm_vm_free(vm);
> +}
> +
> +static void help(char *name)
> +{
> +	puts("");
> +	printf("usage: %s [-h] [-s mem-type]\n", name);
> +	puts("");
> +	guest_modes_help();
> +	backing_src_help("-s");
> +	puts("");
> +}
> +
> +#define SNAME(s)			#s
> +#define SCAT2(a, b)			SNAME(a ## _ ## b)
> +#define SCAT3(a, b, c)			SCAT2(a, SCAT2(b, c))
> +
> +#define _CHECK(_test)			_CHECK_##_test
> +#define _PREPARE(_test)			_PREPARE_##_test
> +#define _PREPARE_guest_read64		NULL
> +#define _PREPARE_guest_ld_preidx	NULL
> +#define _PREPARE_guest_write64		NULL
> +#define _PREPARE_guest_st_preidx	NULL
> +#define _PREPARE_guest_exec		NULL
> +#define _PREPARE_guest_at		NULL
> +#define _PREPARE_guest_dc_zva		guest_check_dc_zva
> +#define _PREPARE_guest_cas		guest_check_lse
> +
> +/* With or without access flag checks */
> +#define _PREPARE_with_af		guest_set_ha, guest_clear_pte_af
> +#define _PREPARE_no_af			NULL
> +#define _CHECK_with_af			guest_check_pte_af
> +#define _CHECK_no_af			NULL
> +
> +/* Performs an access and checks that no faults were triggered. */
> +#define TEST_ACCESS(_access, _with_af, _mark_cmd)				\
> +{										\
> +	.name			= SCAT3(_access, _with_af, #_mark_cmd),		\
> +	.guest_prepare		= { _PREPARE(_with_af),				\
> +				    _PREPARE(_access) },			\
> +	.mem_mark_cmd		= _mark_cmd,					\
> +	.guest_test		= _access,					\
> +	.guest_test_check	= { _CHECK(_with_af) },				\
> +}
> +
> +static struct test_desc tests[] = {
> +
> +	/* Check that HW is setting the Access Flag (AF) (sanity checks). */
> +	TEST_ACCESS(guest_read64, with_af, CMD_NONE),
> +	TEST_ACCESS(guest_ld_preidx, with_af, CMD_NONE),
> +	TEST_ACCESS(guest_cas, with_af, CMD_NONE),
> +	TEST_ACCESS(guest_write64, with_af, CMD_NONE),
> +	TEST_ACCESS(guest_st_preidx, with_af, CMD_NONE),
> +	TEST_ACCESS(guest_dc_zva, with_af, CMD_NONE),
> +	TEST_ACCESS(guest_exec, with_af, CMD_NONE),
> +
> +	/*
> +	 * Accessing a hole in the data memslot (punched with fallocate or
> +	 * madvise) shouldn't fault (more sanity checks).
> +	 */
> +	TEST_ACCESS(guest_read64, no_af, CMD_HOLE_DATA),
> +	TEST_ACCESS(guest_cas, no_af, CMD_HOLE_DATA),
> +	TEST_ACCESS(guest_ld_preidx, no_af, CMD_HOLE_DATA),
> +	TEST_ACCESS(guest_write64, no_af, CMD_HOLE_DATA),
> +	TEST_ACCESS(guest_st_preidx, no_af, CMD_HOLE_DATA),
> +	TEST_ACCESS(guest_at, no_af, CMD_HOLE_DATA),
> +	TEST_ACCESS(guest_dc_zva, no_af, CMD_HOLE_DATA),
> +
> +	{ 0 }
> +};
> +
> +static void for_each_test_and_guest_mode(
> +		void (*func)(enum vm_guest_mode m, void *a),
> +		enum vm_mem_backing_src_type src_type)
> +{
> +	struct test_desc *t;
> +
> +	for (t = &tests[0]; t->name; t++) {
> +		if (t->skip)
> +			continue;
> +
> +		struct test_params p = {
> +			.src_type = src_type,
> +			.test_desc = t,
> +		};
> +
> +		for_each_guest_mode(run_test, &p);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	enum vm_mem_backing_src_type src_type;
> +	int opt;
> +
> +	setbuf(stdout, NULL);
> +
> +	src_type = DEFAULT_VM_MEM_SRC;
> +
> +	guest_modes_append_default();

This guest mode append call is redundant with the one already done in the
constructor function, so it isn't necessary for aarch64-only tests.

> +
> +	while ((opt = getopt(argc, argv, "hm:s:")) != -1) {
> +		switch (opt) {
> +		case 'm':
> +			guest_modes_cmdline(optarg);
> +			break;
> +		case 's':
> +			src_type = parse_backing_src_type(optarg);
> +			break;
> +		case 'h':
> +		default:
> +			help(argv[0]);
> +			exit(0);
> +		}
> +	}
> +
> +	for_each_test_and_guest_mode(run_test, src_type);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index c1ddca8db225..5f977528e09c 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -105,11 +105,19 @@ enum {
>  #define ESR_EC_MASK		(ESR_EC_NUM - 1)
>  
>  #define ESR_EC_SVC64		0x15
> +#define ESR_EC_IABT		0x21
> +#define ESR_EC_DABT		0x25
>  #define ESR_EC_HW_BP_CURRENT	0x31
>  #define ESR_EC_SSTEP_CURRENT	0x33
>  #define ESR_EC_WP_CURRENT	0x35
>  #define ESR_EC_BRK_INS		0x3c
>  
> +/* Access flag */
> +#define PTE_AF			(1ULL << 10)
> +
> +/* Access flag update enable/disable */
> +#define TCR_EL1_HA		(1ULL << 39)
> +
>  void aarch64_get_supported_page_sizes(uint32_t ipa,
>  				      bool *ps4k, bool *ps16k, bool *ps64k);
>  
> -- 
> 2.37.3.968.ga6b4b080e4-goog
>

Thanks,
drew
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
