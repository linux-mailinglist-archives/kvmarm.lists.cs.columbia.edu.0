Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3486A142207
	for <lists+kvmarm@lfdr.de>; Mon, 20 Jan 2020 04:34:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE39C4AEE4;
	Sun, 19 Jan 2020 22:34:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ozlabs.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6q3WfLznGYS8; Sun, 19 Jan 2020 22:34:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 575124A830;
	Sun, 19 Jan 2020 22:34:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E5A4B4A830
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 22:34:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oXsq5fL75hOZ for <kvmarm@lists.cs.columbia.edu>;
 Sun, 19 Jan 2020 22:34:18 -0500 (EST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D37354AEB9
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 22:34:17 -0500 (EST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 481HMj2M00z9sRQ; Mon, 20 Jan 2020 14:34:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1579491249; bh=6J0yPKo/kn+WbG/Jx05ZU6+6m/AlQNEvaTssDj+re3g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J+bOs+MonJV9E7pI5lPc45XM0RCY2NjfQhio5m6/DttgJzWYQ3HNgH1xNUIV476t1
 ts+G5ufVu2nlLxna51nc4RLV4i+BMxNIj8OtXWtlekVH++JUnEo50tNL+EcDdMfnkK
 0tKNeAH0zTIwzwjt/ddygd75H6MloM9kMawF09dx8px7N8Z19MLfg0DZDiMcl7Jxj9
 O7BDLwTM/8mWG+Mi5fGu3SEx+TpDcDN2c+ViWcUIssgNg+IQQZy1GA8JrmdTUkDUam
 B5LzqGm2UwjQc0vxq2SUD2N7ikcbM2cnwWO5UhkiGCsdd5z9MQlNdr+cIMYXi//Jw1
 JWsmSqN7nCbMg==
Date: Mon, 20 Jan 2020 14:00:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 02/45] KVM: PPC: Book3S PR: Free shared page if mmu
 initialization fails
Message-ID: <20200120030041.GB14307@blackberry>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
 <20191218215530.2280-3-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191218215530.2280-3-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Cornelia Huck <cohuck@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Hildenbrand <david@redhat.com>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>,
 linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>,
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

On Wed, Dec 18, 2019 at 01:54:47PM -0800, Sean Christopherson wrote:
> Explicitly free the shared page if kvmppc_mmu_init() fails during
> kvmppc_core_vcpu_create(), as the page is freed only in
> kvmppc_core_vcpu_free(), which is not reached via kvm_vcpu_uninit().
> 
> Fixes: 96bc451a15329 ("KVM: PPC: Introduce shared page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/powerpc/kvm/book3s_pr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index ce4fcf76e53e..26ca62b6d773 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1806,10 +1806,12 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_pr(struct kvm *kvm,
>  
>  	err = kvmppc_mmu_init(vcpu);
>  	if (err < 0)
> -		goto uninit_vcpu;
> +		goto free_shared_page;
>  
>  	return vcpu;
>  
> +free_shared_page:
> +	free_page((unsigned long)vcpu->arch.shared);
>  uninit_vcpu:
>  	kvm_vcpu_uninit(vcpu);
>  free_shadow_vcpu:
> -- 
> 2.24.1

Looks correct.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
