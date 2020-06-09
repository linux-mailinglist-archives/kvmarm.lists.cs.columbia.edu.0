Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A91EF1F5300
	for <lists+kvmarm@lfdr.de>; Wed, 10 Jun 2020 13:20:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 429C94B2CB;
	Wed, 10 Jun 2020 07:20:50 -0400 (EDT)
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
	with ESMTP id X2RkAVaZI8iN; Wed, 10 Jun 2020 07:20:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DFB814B2CC;
	Wed, 10 Jun 2020 07:20:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB97D4B192
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jun 2020 18:54:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fi1BKiheBXKh for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Jun 2020 18:54:15 -0400 (EDT)
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
 [209.85.217.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D9F794B17D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jun 2020 18:54:15 -0400 (EDT)
Received: by mail-vs1-f66.google.com with SMTP id t132so134748vst.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 09 Jun 2020 15:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uselWGWC3qoQQOxqWlrwlyYH4mqd92kQlOeG7RAljPU=;
 b=FyAfw76hywaz53lg/VPnGi9e8IgE5jPMksWxgn5Xkbqe/yhjElKv8fMDCl4QFtXQIt
 pSyJYqrnMJYgTyWBELqlUZa5CVrDBu1huuKU9dWbO6W+XR2+iweBUHxOBj0i2RvfGdFs
 8NiNQVMybZaYdmRyiKjkdD25LAg7GOjVAE2ahVKfo1TFfOTPVhQxv3vrhhJB1ZZYju2x
 Sdae+oKvdyfhBYlT1ObztTGi8b7ZlawE8tQkILK8OymFeQLH+QUknrl0lziOECLhGpgE
 9Z2h7cuvDa588K6R2CH8Tk7KwRtyK4jUdgDpy+UOvR8NULevc8eRomSXClkk9nY8gFC8
 7ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uselWGWC3qoQQOxqWlrwlyYH4mqd92kQlOeG7RAljPU=;
 b=T+B9s8SmDF52MAQgMuWsQtkta257LuaAniuSAqaPIxuYACOi6e8bXJ7r9E/5TC90vd
 JPmZOzg88moHqLaY1D4H9M0kGx9EO/AnoADA5NkAQf5CHcbm1AtY43w9kH+qrHMi9c+u
 agkn9EwMe61AG1/U+S1hfhMeuVLCb91f4DiQCOFWWfmpjq3/hnqK1UpDagyc8o6JpgEd
 wxe4Z+4Igk55/ALgG58muCpatwtixeRXIm1pxFnkRFe/vUq+w6qjsQgH1nyWDCCUr9kO
 Bgn/aCJuyic5nkdX41FX3OC9JhcLG+oZydbFXsasyWcENgWiRe9qaz058iLYekw8WSaV
 qxbQ==
X-Gm-Message-State: AOAM532JPd2PO1kwJNqQJqNKDljXW4Deeohu56PEe8OjdSLFBGW8pWe2
 SHkwNJr4sWD1pUz2/m6l9qgsZinGtGRlqBpsWmKJpw==
X-Google-Smtp-Source: ABdhPJx3dLS9VTThWqaFRDlqN1S9f5h0OrZVTBbY5/ftQgTD5GsCLfsUQ7mDqtAcQKwPK2rVrq3OTLOUBty+qRmGSEY=
X-Received: by 2002:a67:af10:: with SMTP id v16mr448564vsl.235.1591743255002; 
 Tue, 09 Jun 2020 15:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com>
 <20200605213853.14959-3-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-3-sean.j.christopherson@intel.com>
From: Ben Gardon <bgardon@google.com>
Date: Tue, 9 Jun 2020 15:54:04 -0700
Message-ID: <CANgfPd-hDAUe188X4HNt7bQ=5_RxtOmpnEet3C3CwpJPxi4y4Q@mail.gmail.com>
Subject: Re: [PATCH 02/21] KVM: x86/mmu: Consolidate "page" variant of memory
 cache helpers
To: Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailman-Approved-At: Wed, 10 Jun 2020 07:20:46 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 kvmarm@lists.cs.columbia.edu, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Junaid Shahid <junaids@google.com>, kvm-ppc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Shier <pshier@google.com>,
 linux-mips@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Feiner <pfeiner@google.com>
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

On Fri, Jun 5, 2020 at 2:39 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Drop the "page" variants of the topup/free memory cache helpers, using
> the existence of an associated kmem_cache to select the correct alloc
> or free routine.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0830c195c9ed..cbc101663a89 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1067,7 +1067,10 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
>         if (cache->nobjs >= min)
>                 return 0;
>         while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -               obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
> +               if (cache->kmem_cache)
> +                       obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
> +               else
> +                       obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
>                 if (!obj)
>                         return cache->nobjs >= min ? 0 : -ENOMEM;
>                 cache->objects[cache->nobjs++] = obj;
> @@ -1082,30 +1085,12 @@ static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *cache)
>
>  static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
>  {
> -       while (mc->nobjs)
> -               kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
> -}
> -
> -static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
> -                                      int min)
> -{
> -       void *page;
> -
> -       if (cache->nobjs >= min)
> -               return 0;
> -       while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -               page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
> -               if (!page)
> -                       return cache->nobjs >= min ? 0 : -ENOMEM;
> -               cache->objects[cache->nobjs++] = page;
> +       while (mc->nobjs) {
> +               if (mc->kmem_cache)
> +                       kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
> +               else
> +                       free_page((unsigned long)mc->objects[--mc->nobjs]);
>         }
> -       return 0;
> -}
> -
> -static void mmu_free_memory_cache_page(struct kvm_mmu_memory_cache *mc)
> -{
> -       while (mc->nobjs)
> -               free_page((unsigned long)mc->objects[--mc->nobjs]);
>  }
>
>  static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
> @@ -1116,7 +1101,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
>                                    8 + PTE_PREFETCH_NUM);
>         if (r)
>                 goto out;
> -       r = mmu_topup_memory_cache_page(&vcpu->arch.mmu_page_cache, 8);
> +       r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache, 8);
>         if (r)
>                 goto out;
>         r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
> @@ -1127,7 +1112,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
>  static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
>  {
>         mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
> -       mmu_free_memory_cache_page(&vcpu->arch.mmu_page_cache);
> +       mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
>         mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
>  }
>
> --
> 2.26.0
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
