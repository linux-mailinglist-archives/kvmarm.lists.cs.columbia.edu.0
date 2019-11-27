Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 11A3110B52F
	for <lists+kvmarm@lfdr.de>; Wed, 27 Nov 2019 19:07:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 82C264A7FD;
	Wed, 27 Nov 2019 13:07:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fs4fjYhN3AO7; Wed, 27 Nov 2019 13:07:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 577C34A7E4;
	Wed, 27 Nov 2019 13:07:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DE224A5C3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Nov 2019 13:07:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v9FfnhumLhHR for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Nov 2019 13:07:33 -0500 (EST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9857F4A535
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Nov 2019 13:07:33 -0500 (EST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 10:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,250,1571727600"; d="scan'208";a="410432346"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.41])
 by fmsmga006.fm.intel.com with ESMTP; 27 Nov 2019 10:07:31 -0800
Date: Wed, 27 Nov 2019 10:07:31 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v4 1/5] KVM: x86: Move memcache allocation to
 GFP_PGTABLE_USER
Message-ID: <20191127180731.GC16845@linux.intel.com>
References: <20191105110357.8607-1-christoffer.dall@arm.com>
 <20191105110357.8607-2-christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191105110357.8607-2-christoffer.dall@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

On Tue, Nov 05, 2019 at 12:03:53PM +0100, Christoffer Dall wrote:
> Recent commit 50f11a8a4620eee6b6831e69ab5d42456546d7d8 moved page table
> allocations for both KVM and normal user page table allocations to
> GFP_PGTABLE_USER in order to get __GFP_ACCOUNT for the page tables.
> 
> However, while KVM on other architectures such as arm64 were included in
> this change, curiously KVM on x86 was not.
> 
> Currently, KVM on x86 uses kmem_cache_zalloc(GFP_KERNEL_ACCOUNT) for
> kmem_cache-based allocations, which expands in the following way:
>   kmem_cache_zalloc(..., GFP_KERNEL_ACCOUNT) =>
>   kmem_cache_alloc(..., GFP_KERNEL_ACCOUNT | __GFP_ZERO) =>
>   kmem_cache_alloc(..., GFP_KERNEL | __GFP_ACCOUNT | __GFP_ZERO)
> 
> It so happens that GFP_PGTABLE_USER expands as:
>   GFP_PGTABLE_USER =>
>   (GFP_PGTABLE_KERNEL | __GFP_ACCOUNT) =>
>   ((GFP_KERNEL | __GFP_ZERO) | __GFP_ACCOUNT) =>
>   (GFP_KERNEL | __GFP_ACCOUNT | __GFP_ZERO)
> 
> Which means that we can replace the current KVM on x86 call as:
> -  obj = kmem_cache_zalloc(base_cache, GFP_KERNEL_ACCOUNT);
> +  obj = kmem_cache_alloc(base_cache, GFP_PGTABLE_USER);
> 
> For the single page cache topup allocation, KVM on x86 currently uses
> __get_free_page(GFP_KERNEL_ACCOUNT).  It seems to me that is equivalent
> to the above, except that the allocated page is not guaranteed to be
> zero (unless I missed the place where __get_free_page(!__GFP_ZERO) is
> still guaranteed to be zeroed.  It seems natural (and in fact desired)
> to have both topup functions implement the same expectations towards the
> caller, and we therefore move to GFP_PGTABLE_USER here as well.
> 
> This will make it easier to unify the memchace implementation between
> architectures.

Functionally, this looks correct (I haven't actually tested).  But, it
means that x86's shadow pages will be zeroed out twice, which could lead
to performance regressions.  The cache is also used for the gfns array,
and I'm pretty sure the gfns array is never zeroed out in the current code,
i.e. zeroing gfns would also introduce overhead.

The redudant zeroing of shadow pages could likely be addressed by removing
the call to clear_page() in kvm_mmu_get_page(), but I'd prefer not to go
that route because it doesn't address the gfns issue, means KVM pays the
cost of zeroing up front (as opposed to when a page is actually used), and
I have a future use case where the shadow page needs to be initialized to
a non-zero value.

What about having the common mmu_topup_memory_cache{_page}() take a GFP
param?  That would allow consolidating the bulk of the code while allowing
x86 to optimize its specific scenarios.

> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  arch/x86/kvm/mmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 24c23c66b226..540190cee3cb 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -40,6 +40,7 @@
>  
>  #include <asm/page.h>
>  #include <asm/pat.h>
> +#include <asm/pgalloc.h>
>  #include <asm/cmpxchg.h>
>  #include <asm/e820/api.h>
>  #include <asm/io.h>
> @@ -1025,7 +1026,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>  	if (cache->nobjs >= min)
>  		return 0;
>  	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -		obj = kmem_cache_zalloc(base_cache, GFP_KERNEL_ACCOUNT);
> +		obj = kmem_cache_alloc(base_cache, GFP_PGTABLE_USER);
>  		if (!obj)
>  			return cache->nobjs >= min ? 0 : -ENOMEM;
>  		cache->objects[cache->nobjs++] = obj;
> @@ -1053,7 +1054,7 @@ static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
>  	if (cache->nobjs >= min)
>  		return 0;
>  	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
> +		page = (void *)__get_free_page(GFP_PGTABLE_USER);
>  		if (!page)
>  			return cache->nobjs >= min ? 0 : -ENOMEM;
>  		cache->objects[cache->nobjs++] = page;
> -- 
> 2.18.0
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
