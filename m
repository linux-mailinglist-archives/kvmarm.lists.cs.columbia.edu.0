Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB754FA42
	for <lists+kvmarm@lfdr.de>; Fri, 17 Jun 2022 17:28:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 912D64B35D;
	Fri, 17 Jun 2022 11:28:24 -0400 (EDT)
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
	with ESMTP id qnxMPWsCF99p; Fri, 17 Jun 2022 11:28:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 554614B350;
	Fri, 17 Jun 2022 11:28:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DCF84B249
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 11:28:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wl6O+HAIi-ws for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Jun 2022 11:28:21 -0400 (EDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E61924B229
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 11:28:20 -0400 (EDT)
Received: by mail-pj1-f53.google.com with SMTP id
 k5-20020a17090a404500b001e8875e6242so4440943pjg.5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9lnCWB9zsyKOczCBSceUjigaztv7AStK8BeDoARKMKM=;
 b=MRDsetQVY8MyaT0DSP6tz4YsogDP3sj0rr5b0qt8A1QJdSxqRb2FK2SCRN4Rv61+Xf
 uskMCdC3eAPe8Jxgq7H0ZOFru5CTDkW409Q1LHVbJCTaXzRXAGYKGhrYiVfIRJl1ZDdV
 LIWk1N1oBF6dDpzc/XNOmabSkUSj7Za5iwn8ezuXDyex9GiKIa3Y5J+JPuzFG0UAgVNV
 5KoEC5iY+aBJCAWXTTjVyrG3AY5I7cI8s2MhNOBu3VH1llzYd24SxPA1cXi3c6/zWkOJ
 18PuIj7gGXc1WYJ5hDHcxEV/8icIiaWpaFpD0nfNGnI9Fae7NamaLQf8acl4eJ/wls2K
 dMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9lnCWB9zsyKOczCBSceUjigaztv7AStK8BeDoARKMKM=;
 b=0KKMATu71vaFkxxFemULyUU6UqQ/WIM9DDPLvJ+8W1pECvavv0owbezsQzM0gdVLya
 /pPl8dcA3WAjVl1RJ/dRUqpsHZQHg9PwQknix8wNtDK8wqvXmdPh8YPmJpjWAR3a/H58
 JNOWJdSIPklb8miX5uRqVppB05xXMLLrJn9iHh7wv2+SKvRLq8OMFpxefJWxc0fO4ipl
 /gWACc9gIag8RjCGrn0jiEc3KWd04g7GIjGVmYEvHaEAmVXoiv1xo1f+ex/phcWTklpH
 z7Y2rnfafxarKoGjiY2ezI6901LtwvuQhQexPY7jv62ButX/xgm9IT/NzewJOkBxNQ/f
 f+jA==
X-Gm-Message-State: AJIora+6Z6enGHjRN3htSeKbG5RxqDJoHh7Ab9Z88M7Zay1zMXlxDkHI
 55ievXbkh8aJDkFbe7IkkZLHSw==
X-Google-Smtp-Source: AGRyM1tIpViIJ0OwvugoNaYPS81DxsMmaeO15jp/Gqk615TT7T4/NIE2uXviTLDn9T52SnoA3upg+w==
X-Received: by 2002:a17:90b:1b48:b0:1e8:5885:f8b with SMTP id
 nv8-20020a17090b1b4800b001e858850f8bmr11152803pjb.122.1655479699649; 
 Fri, 17 Jun 2022 08:28:19 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com.
 [35.230.65.123]) by smtp.gmail.com with ESMTPSA id
 x6-20020a1709029a4600b0015e8d4eb1d1sm3742777plv.27.2022.06.17.08.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jun 2022 08:28:18 -0700 (PDT)
Date: Fri, 17 Jun 2022 15:28:15 +0000
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v6 13/22] KVM: x86/mmu: Allow NULL @vcpu in
 kvm_mmu_find_shadow_page()
Message-ID: <YqydjxjnuaYTIYMt@google.com>
References: <20220516232138.1783324-1-dmatlack@google.com>
 <20220516232138.1783324-14-dmatlack@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516232138.1783324-14-dmatlack@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <kvm@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <linux-mips@vger.kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR RISC-V \(KVM/riscv\)"
 <kvm-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Ben Gardon <bgardon@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 maciej.szmigiero@oracle.com,
 "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Peter Feiner <pfeiner@google.com>
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

On Mon, May 16, 2022, David Matlack wrote:
> Allow @vcpu to be NULL in kvm_mmu_find_shadow_page() (and its only
> caller __kvm_mmu_get_shadow_page()). @vcpu is only required to sync
> indirect shadow pages, so it's safe to pass in NULL when looking up
> direct shadow pages.
> 
> This will be used for doing eager page splitting, which allocates direct

"hugepage" again, because I need constant reminders :-)

> shadow pages from the context of a VM ioctl without access to a vCPU
> pointer.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---

With nits addressed,

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  arch/x86/kvm/mmu/mmu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4fbc2da47428..acb54d6e0ea5 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1850,6 +1850,7 @@ static int kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>  
>  	if (ret < 0)
>  		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
> +

Unrelated whitespace change leftover from the previous approach.

>  	return ret;
>  }
>  
> @@ -2001,6 +2002,7 @@ static void clear_sp_write_flooding_count(u64 *spte)
>  	__clear_sp_write_flooding_count(sptep_to_sp(spte));
>  }
>  
> +/* Note, @vcpu may be NULL if @role.direct is true. */
>  static struct kvm_mmu_page *kvm_mmu_find_shadow_page(struct kvm *kvm,
>  						     struct kvm_vcpu *vcpu,
>  						     gfn_t gfn,
> @@ -2039,6 +2041,16 @@ static struct kvm_mmu_page *kvm_mmu_find_shadow_page(struct kvm *kvm,
>  			goto out;
>  
>  		if (sp->unsync) {
> +			/*
> +			 * A vCPU pointer should always be provided when finding

s/should/must, and "be provided" in unnecessarily ambiguous, simply state that
"@vcpu must be non-NULL".  E.g. if a caller provides a pointer, but that pointer
happens to be NULL.

> +			 * indirect shadow pages, as that shadow page may
> +			 * already exist and need to be synced using the vCPU
> +			 * pointer. Direct shadow pages are never unsync and
> +			 * thus do not require a vCPU pointer.
> +			 */

"vCPU pointer" over and over is a bit versbose, and I prefer to refer to vCPUs/VMs
as objects themselves.  E.g. "XYZ requires a vCPU" versus "XYZ requires a vCPU
pointer" since it's not the pointer itself that's required, it's all the context
of the vCPU that is needed.

			/*
			 * @vcpu must be non-NULL when finding indirect shadow
			 * pages, as such pages may already exist and need to
			 * be synced, which requires a vCPU.  Direct pages are
			 * never unsync and thus do not require a vCPU.
			 */

> +			if (KVM_BUG_ON(!vcpu, kvm))
> +				break;
> +
>  			/*
>  			 * The page is good, but is stale.  kvm_sync_page does
>  			 * get the latest guest state, but (unlike mmu_unsync_children)
> @@ -2116,6 +2128,7 @@ static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
>  	return sp;
>  }
>  
> +/* Note, @vcpu may be NULL if @role.direct is true. */
>  static struct kvm_mmu_page *__kvm_mmu_get_shadow_page(struct kvm *kvm,
>  						      struct kvm_vcpu *vcpu,
>  						      struct shadow_page_caches *caches,
> -- 
> 2.36.0.550.gb090851708-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
