Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6921F6233
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jun 2020 09:22:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EF5C4B1A2;
	Thu, 11 Jun 2020 03:22:41 -0400 (EDT)
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
	with ESMTP id C3aPfgQdEYmp; Thu, 11 Jun 2020 03:22:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D906A4B1F4;
	Thu, 11 Jun 2020 03:22:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 917094B1D3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 18:34:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UVyLiru9fusI for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Jun 2020 18:34:39 -0400 (EDT)
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
 [209.85.217.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 974634B15B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 18:34:39 -0400 (EDT)
Received: by mail-vs1-f66.google.com with SMTP id y123so2284931vsb.6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C9LYQ8aclMkdwfJP4cdhxWD4N8cMJMuN6znPHlB3Rsc=;
 b=UevvpOtsXUfdMcqvIgRfPVVQSDyZs6oXq/Xnj/8uJDFNeQBZ7vzloiU32xzvK6mFCu
 cGGLwNrdnw/Q0on5lLXJlkuu8D4VI6gjZehfPhGO6t/torNaJ6NxHMQ2JuDgO8FwHc4P
 o8FP7KzD9QWU8u7G49I5aLDbEK8X8zhTnPGPK+25pdCKJLn9W7w1iBlkb84D2LADSGpc
 tCqhhzfq26VpCG0se8b1WZwp4CCFSusJSn+larn2+KMSi4aCsCQRQ/S3A4qsfTfUDCpT
 JYfiX91/2CIDQozv8ZBX3SClrislUPBF+zqSWJE7quvH7sEsU2MJoNuxaq5T13FcVb0X
 ExAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C9LYQ8aclMkdwfJP4cdhxWD4N8cMJMuN6znPHlB3Rsc=;
 b=tHYY7BDB39AeICuE7LzpN5/wc3eya4ju5G3JBzM6mAylyvCzDARCuOEPxc8WsMlWCb
 I8jn37Yp0WaeCyK52rh2r2zI64Y7s46N6zrA6DY/VEnw40rV/zyilGyEAWm9CKkNlwvx
 rCHODvzv14GS8lNddPQ6JFO+Lz5yRINOBjYxX6CgXrfKxopok1qw4V74QoAGPqvCDGcM
 Tb6evBheSBIeGEkQ0qEuPl+kezo51eZdRZrN1XUYd8Y+VQ6KHC09urNo56L0Dcn+iq+N
 L1ksr1Lf3PP7OlkPGH6foMgNA8IK1V32Nlm8Sx6uTILYPBP8MHnN0pUaR8da4khlvN/u
 iR0A==
X-Gm-Message-State: AOAM533YEKh/V1wZ9PfdEcF7MPV1oUCo6Xz9uOdU+wuaNT67PYkDXQod
 ZURWgz8s/75Bp29SVgWo5rREdcpt1CS0I29zBgj2QQ==
X-Google-Smtp-Source: ABdhPJzdt1t5lYhNZNFDbxTCIee/fOpBW2dvkZTK5r9pH/LqHC+MVWmHSuu/UxjSaFUQydIW/izqWRJz+CsXZPttueA=
X-Received: by 2002:a67:79ce:: with SMTP id u197mr4725019vsc.17.1591828478904; 
 Wed, 10 Jun 2020 15:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com>
 <20200605213853.14959-8-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-8-sean.j.christopherson@intel.com>
From: Ben Gardon <bgardon@google.com>
Date: Wed, 10 Jun 2020 15:34:28 -0700
Message-ID: <CANgfPd9UH01vO1SYJ3vrKq4H_DXcJ3OL_VaeY2TV8_ZH9cR1GQ@mail.gmail.com>
Subject: Re: [PATCH 07/21] KVM: x86/mmu: Topup memory caches after walking
 GVA->GPA
To: Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailman-Approved-At: Thu, 11 Jun 2020 03:22:32 -0400
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
> Topup memory caches after walking the GVA->GPA translation during a
> shadow page fault, there is no need to ensure the caches are full when
> walking the GVA.  As of commit f5a1e9f89504f ("KVM: MMU: remove call
> to kvm_mmu_pte_write from walk_addr"), the FNAME(walk_addr) flow no
> longer add rmaps via kvm_mmu_pte_write().
>
> This avoids allocating memory in the case that the GVA is unmapped in
> the guest, and also provides a paper trail of why/when the memory caches
> need to be filled.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index 38c576495048..3de32122f601 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -791,10 +791,6 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
>
>         pgprintk("%s: addr %lx err %x\n", __func__, addr, error_code);
>
> -       r = mmu_topup_memory_caches(vcpu);
> -       if (r)
> -               return r;
> -
>         /*
>          * If PFEC.RSVD is set, this is a shadow page fault.
>          * The bit needs to be cleared before walking guest page tables.
> @@ -822,6 +818,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
>                 return RET_PF_EMULATE;
>         }
>
> +       r = mmu_topup_memory_caches(vcpu);
> +       if (r)
> +               return r;
> +
>         vcpu->arch.write_fault_to_shadow_pgtable = false;
>
>         is_self_change_mapping = FNAME(is_self_change_mapping)(vcpu,
> --
> 2.26.0
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
