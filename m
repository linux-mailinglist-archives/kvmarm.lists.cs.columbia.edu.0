Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBE5BEC7F
	for <lists+kvmarm@lfdr.de>; Tue, 20 Sep 2022 20:07:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CF734B600;
	Tue, 20 Sep 2022 14:07:23 -0400 (EDT)
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
	with ESMTP id aCQprtR9z+kR; Tue, 20 Sep 2022 14:07:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED12A4B630;
	Tue, 20 Sep 2022 14:07:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ACF24B293
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Sep 2022 14:07:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lONbB0X9FwJ5 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Sep 2022 14:07:19 -0400 (EDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 230B549EFA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Sep 2022 14:07:19 -0400 (EDT)
Received: by mail-pl1-f173.google.com with SMTP id x1so3203327plv.5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Sep 2022 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=LQlW6UOkhRZTHD6MttbLwFYAPie8UK4aYfFA+NrIqeA=;
 b=UeRwiyZtGGRCxSBKGeQxjPgOG7vJZ9Q7IGjNm070agx+UMJVhhMNTo46yE9EU3bNiU
 VD9g6g2yUijnrfmSqUTkcU+JrPEBnBNeEiT8cbMY8RF7mbzhe7Jm+BxABvuEcWlN8rBi
 YoJizy2tGWyP2bTAuGgEFPTt08ecKFRMd0+3kt/9EYmEJKsl3YK6OQIL1puLeiwYGdA+
 ZlZOVSW3iK8oc/aIk95sX1PllQIGiBTpsadtOzvuABZGRSrdk0XfpKoNMK3GYcITx1uV
 CLkzdwY1tvYeX7MPk8lTnnNH63ybli4YC1HTKLIsWQfxraEZ8z41MkiRP4Kgy8XyX2YX
 FbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=LQlW6UOkhRZTHD6MttbLwFYAPie8UK4aYfFA+NrIqeA=;
 b=0xno8lkPVhnIjIdKIhH2z6x1aVBtu3QjSkDNQB8fMw7KYoFFKH4iIR3YwHWh9Qaa/l
 Yshq/S7U8UNLMd0y2bBL85Ksl06YNqY2XhtkzAg7ufPpZfxolGsHbnzMMb6YkHxGq9fB
 JHImRC8GPRPNFR1e3yzEWppIEfZnzmCESOsuWIGfDgsZ5/hFepRvgf5CBpFiQXdJD7cQ
 9D7oWzjJCqCUSNrRte/QIextbBeWKjmZglbO6qhVVB3w0XkPBFujdbaO7lc94+Cvf2XL
 h+Z0mPGhO3NLVbyjOb5z8Sk3L0MVJCLz6JgKzvr292F7xdRwT0dkwJNeMwhaa8RSk7uz
 nWmA==
X-Gm-Message-State: ACrzQf0HZfO3XcSyWj13m7p5qt7T8o6080/cmbgIElQooluGv40DINRa
 m0TZ9Xa9D379YjrPeUhF3/hdZQ==
X-Google-Smtp-Source: AMsMyM7h7UVlDhq8fLg6l0hlljwN4NHT67iRz3Wu1y/Vv8fGKttuwGw8oRjQRGooqwmQJFg0IZ6uAA==
X-Received: by 2002:a17:90a:a25:b0:202:d174:d7bd with SMTP id
 o34-20020a17090a0a2500b00202d174d7bdmr5308240pjo.134.1663697237990; 
 Tue, 20 Sep 2022 11:07:17 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com.
 [34.168.104.7]) by smtp.gmail.com with ESMTPSA id
 n123-20020a622781000000b0054cbad1cd21sm176413pfn.180.2022.09.20.11.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Sep 2022 11:07:17 -0700 (PDT)
Date: Tue, 20 Sep 2022 18:07:13 +0000
From: Sean Christopherson <seanjc@google.com>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v7 08/13] KVM: selftests: Use the right memslot for code, 
 page-tables, and data allocations
Message-ID: <YyoBUcSD6ZyxKxza@google.com>
References: <20220920042551.3154283-1-ricarkol@google.com>
 <20220920042551.3154283-9-ricarkol@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220920042551.3154283-9-ricarkol@google.com>
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

On Tue, Sep 20, 2022, Ricardo Koller wrote:
> The previous commit added support for callers of ____vm_create() to specify

Changelog is stale, ____vm_create() no longer takes the struct.

Side topic, it's usually a good idea to use "strong" terminology when referencing
past/future changes, e.g. if patches get shuffled around for whatever reason,
then "previous commit" may become stale/misleading.

It's fairly easy to convey the same info ("something happened recently" or
"something is going to happen soon") without being so explicit, e.g.

  Wire up common code to use the appropriate code, page table, and data
  memmslots that were recently added instead of hardcoding '0' for the
  memslot.

or

  Now that kvm_vm allows specifying different memslots for code, page
  tables, and data, use the appropriate memslot when making allocations
  in common/libraty code.

> what memslots to use for code, page-tables, and data allocations. Change
> them accordingly:
> 
> - stacks, code, and exception tables use the code memslot

Huh?  Stacks and exceptions are very much data, not code.

> - page tables and the pgd use the pt memslot
> - data (anything allocated with vm_vaddr_alloc()) uses the data memslot
> 
> No functional change intended. All allocators keep using memslot #0.

...

> -vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
> +vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> +			    vm_vaddr_t vaddr_min, enum kvm_mem_region_type mrt)

Similar to other feedback, I'd prefer "type" over "mrt".

>  {
>  	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
>  
>  	virt_pgd_alloc(vm);
>  	vm_paddr_t paddr = vm_phy_pages_alloc(vm, pages,
> -					      KVM_UTIL_MIN_PFN * vm->page_size, 0);
> +				KVM_UTIL_MIN_PFN * vm->page_size,
> +				vm->memslots[mrt]);

Please align parameters.

>  
>  	/*
>  	 * Find an unused range of virtual page addresses of at least
> @@ -1230,6 +1213,30 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
>  	return vaddr_start;
>  }

...

> +vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
> +{
> +	return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_DATA);

I like the vm_alloc_page_table() wrapper, what about adding vm_alloc_code() and
vm_alloc_data() too?  Feel free to ignore if it's not much of a benefit.

> +}
> +
>  /*
>   * VM Virtual Address Allocate Pages
>   *
> @@ -1249,6 +1256,11 @@ vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages)
>  	return vm_vaddr_alloc(vm, nr_pages * getpagesize(), KVM_UTIL_MIN_VADDR);
>  }
>  
> +vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm, enum kvm_mem_region_type mrt)
> +{
> +	return __vm_vaddr_alloc(vm, getpagesize(), KVM_UTIL_MIN_VADDR, mrt);
> +}
> +
>  /*
>   * VM Virtual Address Allocate Page
>   *
> @@ -1814,7 +1826,8 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
>  
>  vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
>  {
> -	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> +	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> +				 vm->memslots[MEM_REGION_PT]);
>  }
>  
>  /*
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 604478151212..26c8d3dffb9a 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -58,7 +58,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
>  	if (!vm->pgd_created) {
>  		vm_paddr_t paddr = vm_phy_pages_alloc(vm,
>  			page_align(vm, ptrs_per_pte(vm) * 8) / vm->page_size,
> -			KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> +			KVM_GUEST_PAGE_TABLE_MIN_PADDR, vm->memslots[MEM_REGION_PT]);


Ah, more copy-paste from aarch64.  Not your code (though the s390x change below is
new badness), but align params please.  Similar to newlines before function names,
running over the 80 char soft limit is preferrable to weird alignment.  And for
the soft limit, it's often easy to stay under the soft limit by refactoring,
e.g. in a separate prep patch for RISC-V and aarch64, do:

	size_t nr_pages = page_align(vm, ptrs_per_pgd(vm) * 8) / vm->page_size;

	if (vm->pgd_created)
		return;
	
	vm->pgd = vm_phy_pages_alloc(vm, nr_pages,
				     KVM_GUEST_PAGE_TABLE_MIN_PADDR,
				     vm->memslots[MEM_REGION_PT]);
	vm->pgd_created = true;

>  		vm->pgd = paddr;
>  		vm->pgd_created = true;
>  	}
> @@ -282,8 +282,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  	size_t stack_size = vm->page_size == 4096 ?
>  					DEFAULT_STACK_PGS * vm->page_size :
>  					vm->page_size;
> -	unsigned long stack_vaddr = vm_vaddr_alloc(vm, stack_size,
> -					DEFAULT_RISCV_GUEST_STACK_VADDR_MIN);
> +	unsigned long stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
> +					DEFAULT_RISCV_GUEST_STACK_VADDR_MIN,
> +					MEM_REGION_CODE);

Stack is data, not code.

>  	unsigned long current_gp = 0;
>  	struct kvm_mp_state mps;
>  	struct kvm_vcpu *vcpu;
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 89d7340d9cbd..410ae2b59847 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -21,7 +21,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
>  		return;
>  
>  	paddr = vm_phy_pages_alloc(vm, PAGES_PER_REGION,
> -				   KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> +			KVM_GUEST_PAGE_TABLE_MIN_PADDR, vm->memslots[MEM_REGION_PT]);

Please align.

	paddr = vm_phy_pages_alloc(vm, PAGES_PER_REGION,
				   KVM_GUEST_PAGE_TABLE_MIN_PADDR,
				   vm->memslots[MEM_REGION_PT]);

>  	memset(addr_gpa2hva(vm, paddr), 0xff, PAGES_PER_REGION * vm->page_size);
>  
>  	vm->pgd = paddr;
> @@ -167,8 +167,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
>  		    vm->page_size);
>  
> -	stack_vaddr = vm_vaddr_alloc(vm, stack_size,
> -				     DEFAULT_GUEST_STACK_VADDR_MIN);
> +	stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
> +				       DEFAULT_GUEST_STACK_VADDR_MIN,
> +				       MEM_REGION_CODE);

Same bug here.

>  
>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 2e6e61bbe81b..f7b90a6c7d19 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -525,7 +525,7 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>  static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
>  {
>  	if (!vm->gdt)
> -		vm->gdt = vm_vaddr_alloc_page(vm);
> +		vm->gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_CODE);

GDT is data, not code.

>  	dt->base = vm->gdt;
>  	dt->limit = getpagesize();
> @@ -535,7 +535,7 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
>  				int selector)
>  {
>  	if (!vm->tss)
> -		vm->tss = vm_vaddr_alloc_page(vm);
> +		vm->tss = __vm_vaddr_alloc_page(vm, MEM_REGION_CODE);

TSS is data, not code.

>  
>  	memset(segp, 0, sizeof(*segp));
>  	segp->base = vm->tss;
> @@ -620,8 +620,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  	vm_vaddr_t stack_vaddr;
>  	struct kvm_vcpu *vcpu;
>  
> -	stack_vaddr = vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
> -				     DEFAULT_GUEST_STACK_VADDR_MIN);
> +	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
> +				       DEFAULT_GUEST_STACK_VADDR_MIN,
> +				       MEM_REGION_CODE);

Stack is data, not code.

>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> @@ -1118,8 +1119,8 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
>  	extern void *idt_handlers;
>  	int i;
>  
> -	vm->idt = vm_vaddr_alloc_page(vm);
> -	vm->handlers = vm_vaddr_alloc_page(vm);
> +	vm->idt = __vm_vaddr_alloc_page(vm, MEM_REGION_CODE);

IDT is data, not code.

> +	vm->handlers = __vm_vaddr_alloc_page(vm, MEM_REGION_CODE);
>  	/* Handlers have the same address in both address spaces.*/
>  	for (i = 0; i < NUM_INTERRUPTS; i++)
>  		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0,
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
