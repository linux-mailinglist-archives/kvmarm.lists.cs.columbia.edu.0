Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E45BD235
	for <lists+kvmarm@lfdr.de>; Mon, 19 Sep 2022 18:28:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76B9E4B62A;
	Mon, 19 Sep 2022 12:28:37 -0400 (EDT)
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
	with ESMTP id ITEtGrg-PPra; Mon, 19 Sep 2022 12:28:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC3054B632;
	Mon, 19 Sep 2022 12:28:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A63B4B4D7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Sep 2022 12:28:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O57kcZDAao0L for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Sep 2022 12:28:32 -0400 (EDT)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4A26E4B17C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Sep 2022 12:28:32 -0400 (EDT)
Received: by mail-pf1-f170.google.com with SMTP id d82so78959pfd.10
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Sep 2022 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=BeNgxypZ++tYokyzCzy2MgZStF+Vzvrtba8d/ClgD9U=;
 b=sWKbKFhtV85kHWR9QgsR+UeSvVMXtP/MTvBCqAc9k8kmvyoxmZDBr1Fe/wR42BXR0L
 6+sp7FM7+tfU8cCiy4c5IHaMG5Ex/VW97URJ1HHIvLPJfdHlXWCe9yvpNTK7Q/9t/KQ6
 loXdgzs8W7N1RPQSigt+B/rw+9oZcRGMy8mLKcK666Dq6gTHuJlpsNPMQnHNoI/tvAhk
 UuhFKn1cmzve5rHnif8DNwX3a3k0t8F83B2kjEj9Dl4VmQRLTyIp1Gfd+Ns1ps1Yojm2
 /6RsxNQzIDBPG3hMLjLAmZ0BmTFF4nUSExOBZH5lQBFlU8MKF+sXeAGJPJ89ShM/3W+r
 KBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=BeNgxypZ++tYokyzCzy2MgZStF+Vzvrtba8d/ClgD9U=;
 b=FvRzO2NYit2QcSwSD825icTBJA3PtnZBtFocJQtiVAPYjSjm3RN50fkQro9PxP78wB
 dS1mCIuTjPC0xPJIREvF5FZwzVxsaxmtvxLGaEB+x+Zb/jXDUzXIRzonIPaz7cqW7Rac
 zRxSdbFesnL9Q7NRPDrnyhNOrZc8BA4/dwRHX83rCGOu8gjd5f7dSAlfYxj8vc51T7Ym
 saRfVkPFDvIpywY4mGY8vR7vaBqm7ls4T3hE6KkS52UTV8HcfVjQ6qzF56AQD/HyUe/B
 fLOtqIBRTd2d6x1ZJ7bKZVcsmbUEvvu+zMCVER2K4UxcLtw/cdMKqs3PW2J80TWGq6cX
 UelQ==
X-Gm-Message-State: ACrzQf1O9hOVfWicBb45+oKC4T1Xs/8mlTKZpEm+An+PWGfpDX6ocs6D
 a8fwnKWkHsxTnxwbkWszeqgZtQ==
X-Google-Smtp-Source: AMsMyM5//88XB2tB4m0JA7YwVNADDyKYWq6O5h5UI+9WiXc8W6ueZ/xacuwZ/egdpM0ST/JqSmR+eg==
X-Received: by 2002:a63:da02:0:b0:439:cc64:27fd with SMTP id
 c2-20020a63da02000000b00439cc6427fdmr12571925pgh.313.1663604910795; 
 Mon, 19 Sep 2022 09:28:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com.
 [34.168.104.7]) by smtp.gmail.com with ESMTPSA id
 x2-20020a655382000000b00412a708f38asm18909697pgq.35.2022.09.19.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Sep 2022 09:28:30 -0700 (PDT)
Date: Mon, 19 Sep 2022 16:28:26 +0000
From: Sean Christopherson <seanjc@google.com>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v6 07/13] KVM: selftests: Change ____vm_create() to take
 struct kvm_vm_mem_params
Message-ID: <YyiYqjjhlB8LUVB/@google.com>
References: <20220906180930.230218-1-ricarkol@google.com>
 <20220906180930.230218-8-ricarkol@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220906180930.230218-8-ricarkol@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, bgardon@google.com,
 andrew.jones@linux.dev, dmatlack@google.com, pbonzini@redhat.com,
 axelrasmussen@google.com, kvmarm@lists.cs.columbia.edu
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

On Tue, Sep 06, 2022, Ricardo Koller wrote:
> @@ -637,19 +658,45 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>  			      vm_paddr_t paddr_min, uint32_t memslot);
>  vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
>  
> +struct kvm_vm_mem_params {
> +	enum vm_guest_mode mode;
> +
> +	struct {
> +		enum vm_mem_backing_src_type src_type;
> +		uint64_t guest_paddr;
> +		/*
> +		 * KVM region slot (same meaning as in struct
> +		 * kvm_userspace_memory_region).
> +		 */
> +		uint32_t slot;
> +		uint64_t npages;
> +		uint32_t flags;
> +		bool enabled;

"enabled" is unnecessary, just have ____vm_create() skip over regions with npages=0.
Likely ends up being a moot point though.

> +	} region[NR_MEM_REGIONS];
> +
> +	/* Each region type points to a region in the above array. */
> +	uint16_t region_idx[NR_MEM_REGIONS];

Eww.  This is going to be super confusing and it's one more thing for tests to
screw up.  And open coding the indices for region[] is beyond gross.

> +};
> +
> +extern struct kvm_vm_mem_params kvm_vm_mem_default;
> +
>  /*
>   * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
>   * loads the test binary into guest memory and creates an IRQ chip (x86 only).
>   * __vm_create() does NOT create vCPUs, @nr_runnable_vcpus is used purely to
>   * calculate the amount of memory needed for per-vCPU data, e.g. stacks.
>   */
> -struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages);
> +struct kvm_vm *____vm_create(struct kvm_vm_mem_params *mem_params);
>  struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
>  			   uint64_t nr_extra_pages);
>  
>  static inline struct kvm_vm *vm_create_barebones(void)
>  {
> -	return ____vm_create(VM_MODE_DEFAULT, 0);
> +	struct kvm_vm_mem_params params_wo_memslots = {
> +		.mode = kvm_vm_mem_default.mode,
> +	};
> +
> +	return ____vm_create(&params_wo_memslots);

Very related to the above complaints, this is rather ugly.  I liked the idea of
passing a struct to __vm_create(), but passing it to ____vm_create() feels extremely
forced.

In an ideal world, my preference would still be to modify __vm_create() to take the
struct so that a test that wants to utilize different memslots doesn't need to
manually duplicate all the other stuff in __vm_create(), but that might end up
being too forced as well.  For now, I'm ok punting on that so the page_fault_test
can get merged.

Looking at this with fresh eyes, there's simply no reason ____vm_create() should be
creating memslots.  If this series first moves the memslot creation into __vm_create()
where it belongs (patch below), then there's no need to force ____vm_create() to take
a struct.  And if we punt on refactoring __vm_create(), then there's no need to
add kvm_vm_mem_default and no real need to add struct kvm_vm_mem_params either.

If/when there's a second test that wants fine-grained control over memslots then
we can figure out a proper API to share between page_fault_test and whatever the
new test is, but for now if page_fault_test is going to call ____vm_create()
directly, then I think it's easier to forego the common API and just have page_fault_test
and __vm_create() open code setting vm->memslots.

Alternatively, if we really want a common API right away, then we can add a helper
to populate the memory region + vm->memslots.

Option A (open code):

struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
			   uint64_t nr_extra_pages)
{
	uint64_t nr_pages = vm_nr_pages_required(mode, nr_runnable_vcpus,
						 nr_extra_pages);
	struct kvm_vm *vm;
	int i;

	vm = ____vm_create(mode);

	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);

	for (i = 0; i < NR_MEM_REGIONS; i++)
		vm->memslots[i] = 0;

	kvm_vm_elf_load(vm, program_invocation_name);

#ifdef __x86_64__
	vm_create_irqchip(vm);
#endif
	return vm;
}

...

enum pf_test_memslots {
	CODE_MEMSLOT,
	PAGE_TABLE_MEMSLOT,
	DATA_MEMSLOT,
}

/* Create a code memslot at pfn=0, and data and PT ones at max_gfn. */
static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
{
	uint64_t backing_src_pagesz = get_backing_src_pagesz(p->src_type);
	uint64_t guest_page_size = vm_guest_mode_params[mode].page_size;
	uint64_t max_gfn = get_max_gfn(mode);
	/* Enough for 2M of code when using 4K guest pages. */
	uint64_t code_npages = 512;
	uint64_t pt_size, data_size, data_gpa;

	/*
	 * This test requires 1 pgd, 2 pud, 4 pmd, and 6 pte pages when using
	 * VM_MODE_P48V48_4K. Note that the .text takes ~1.6MBs.  That's 13
	 * pages. VM_MODE_P48V48_4K is the mode with most PT pages; let's use
	 * twice that just in case.
	 */
	pt_size = 26 * guest_page_size;

	/* memslot sizes and gpa's must be aligned to the backing page size */
	pt_size = align_up(pt_size, backing_src_pagesz);
	data_size = align_up(guest_page_size, backing_src_pagesz);
	data_gpa = (max_gfn * guest_page_size) - data_size;
	data_gpa = align_down(data_gpa, backing_src_pagesz);

	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, CODE_MEMSLOT,
				    code_npages, 0);
	vm->memslots[MEM_REGION_CODE] = CODE_MEMSLOT;

	vm_userspace_mem_region_add(vm, p->src_type, data_gpa - pt_size,
				    PAGE_TABLE_MEMSLOT, pt_size / guest_page_size,
				    p->test_desc->pt_memslot_flags);
	vm->memslots[MEM_REGION_PT] = PAGE_TABLE_MEMSLOT;

	vm_userspace_mem_region_add(vm, p->src_type, data_gpa, DATA_MEMSLOT,
				    data_size / guest_page_size,
				    p->test_desc->data_memslot_flags);
	vm->memslots[MEM_REGION_PT] = DATA_MEMSLOT;
}


static void run_test(enum vm_guest_mode mode, void *arg)
{
	struct test_params *p = (struct test_params *)arg;
	struct test_desc *test = p->test_desc;
	struct kvm_vm *vm;
	struct kvm_vcpu *vcpu;
	struct uffd_desc *pt_uffd, *data_uffd;

	print_test_banner(mode, p);

	vm = ____vm_create(mode);
	setup_memslots(vm, p);
	kvm_vm_elf_load(vm, program_invocation_name);
	vcpu = vm_vcpu_add(vm, 0, guest_code);

	...
}

Option B (helper):

enum kvm_mem_region_mask {
	MEM_REGION_CODE_MASK	= BIT(MEM_REGION_CODE),
	MEM_REGION_PT_MASK	= BIT(MEM_REGION_PT),
	MEM_REGION_DATA_MASK	= BIT(MEM_REGION_DATA),

	MEM_REGION_ALL_MASK	= MEM_REGION_CODE_MASK |
				  MEM_REGION_PT_MASK |
				  MEM_REGION_DATA_MASK,
};

void kvm_vm_add_mem_region(struct kvm_vm *vm, enum kvm_mem_region_mask type_mask,
			   enum vm_mem_backing_src_type src_type, uint32_t slot,
			   uint64_t guest_paddr, uint64_t nr_pages, uint32_t flags)
{
	int i;

	vm_userspace_mem_region_add(vm, src_type, guest_paddr, slot, nr_pages, 0);

	for (i = 0; i < NR_MEM_REGIONS; i++) {
		if (BIT(i) & type_mask)
			vm->memslots[i] = slot;
	}
}

struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
			   uint64_t nr_extra_pages)
{
	uint64_t nr_pages = vm_nr_pages_required(mode, nr_runnable_vcpus,
						 nr_extra_pages);
	struct kvm_vm *vm;
	int i;

	vm = ____vm_create(mode);

	kvm_vm_add_mem_region(vm, MEM_REGION_ALL_MASK, VM_MEM_SRC_ANONYMOUS, 0,
			      0, nr_pages, 0);

	kvm_vm_elf_load(vm, program_invocation_name);

#ifdef __x86_64__
	vm_create_irqchip(vm);
#endif
	return vm;
}

static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
{
	...

	kvm_vm_add_mem_region(vm, MEM_REGION_CODE_MASK, VM_MEM_SRC_ANONYMOUS,
			      CODE_MEMSLOT, 0, code_npages, 0);

	kvm_vm_add_mem_region(vm, MEM_REGION_PT_MASK p->src_type,
			      PAGE_TABLE_MEMSLOT, data_gpa - pt_size,
			      pt_size / guest_page_size,
			      p->test_desc->pt_memslot_flags);

	kvm_vm_add_mem_region(vm, MEM_REGION_DATA_MASK, p->src_type,
			      DATA_MEMSLOT, data_gpa,
			      data_size / guest_page_size,
			      p->test_desc->data_memslot_flags);
}

---
 .../testing/selftests/kvm/include/kvm_util_base.h |  4 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c        | 15 +++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 24fde97f6121..107cb87908f8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -642,13 +642,13 @@ vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
  * __vm_create() does NOT create vCPUs, @nr_runnable_vcpus is used purely to
  * calculate the amount of memory needed for per-vCPU data, e.g. stacks.
  */
-struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages);
+struct kvm_vm *____vm_create(enum vm_guest_mode mode);
 struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages);
 
 static inline struct kvm_vm *vm_create_barebones(void)
 {
-	return ____vm_create(VM_MODE_DEFAULT, 0);
+	return ____vm_create(VM_MODE_DEFAULT);
 }
 
 static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9889fe0d8919..c761422faa17 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -143,13 +143,10 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
 
-struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages)
+struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 {
 	struct kvm_vm *vm;
 
-	pr_debug("%s: mode='%s' pages='%ld'\n", __func__,
-		 vm_guest_mode_string(mode), nr_pages);
-
 	vm = calloc(1, sizeof(*vm));
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
 
@@ -245,9 +242,6 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages)
 
 	/* Allocate and setup memory for guest. */
 	vm->vpages_mapped = sparsebit_alloc();
-	if (nr_pages != 0)
-		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-					    0, 0, nr_pages, 0);
 
 	return vm;
 }
@@ -294,7 +288,12 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct kvm_vm *vm;
 
-	vm = ____vm_create(mode, nr_pages);
+	pr_debug("%s: mode='%s' pages='%ld'\n", __func__,
+		 vm_guest_mode_string(mode), nr_pages);
+
+	vm = ____vm_create(mode);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 

base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
-- 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
