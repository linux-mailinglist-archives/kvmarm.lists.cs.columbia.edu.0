Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CB035142206
	for <lists+kvmarm@lfdr.de>; Mon, 20 Jan 2020 04:34:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C57D4AEDA;
	Sun, 19 Jan 2020 22:34:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ozlabs.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-ShCuttUXLF; Sun, 19 Jan 2020 22:34:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 41DCC4AEE5;
	Sun, 19 Jan 2020 22:34:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D47974AECC
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 22:34:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d+8SlNtOYwRa for <kvmarm@lists.cs.columbia.edu>;
 Sun, 19 Jan 2020 22:34:17 -0500 (EST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 842094A830
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 22:34:17 -0500 (EST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 481HMj02PMz9sRK; Mon, 20 Jan 2020 14:34:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1579491249; bh=Bx1QENbI/taNJYozRF14LNd8JjoLRwCSpGh5bRXaoZc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BalvDW2whNPsvCmtISkbOhDMpZauUgvHl09Uaty2WElwJ6Cza+b4DeHGcnUNwOLV3
 g6DRm1DMzCI/vBJ1PlZfghThTKRiDTXm/9cEYl1gDtPWzG4q+29NKYsabkOFnLKJZW
 pu7HnKn8KFD4ACQ0z1wJAaZ09+iERSqPxVmZuqJ9tVnb3xT4AbRscYT7AxP5jHVWa0
 3Gb0VAa6x9zDA27RPpRqnF9yfWp6Q9n39W6+HvqOjYYy/h9z34BptPYaZs8RzgPLLz
 x8CTvY8aTo7+f8KU7v7y459Sv+srWbj2FDlNPNQXb3Ix1Y7vabAiDRVuXNEoR2XexB
 QTFYCAbB5+mEg==
Date: Mon, 20 Jan 2020 13:57:16 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 01/45] KVM: PPC: Book3S HV: Uninit vCPU if vcore
 creation fails
Message-ID: <20200120025716.GA14307@blackberry>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
 <20191218215530.2280-2-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191218215530.2280-2-sean.j.christopherson@intel.com>
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

On Wed, Dec 18, 2019 at 01:54:46PM -0800, Sean Christopherson wrote:
> Call kvm_vcpu_uninit() if vcore creation fails to avoid leaking any
> resources allocated by kvm_vcpu_init(), i.e. the vcpu->run page.
> 
> Fixes: 371fefd6f2dc4 ("KVM: PPC: Allow book3s_hv guests to use SMT processor modes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dc53578193ee..d07d2f5273e5 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2368,7 +2368,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>  	mutex_unlock(&kvm->lock);
>  
>  	if (!vcore)
> -		goto free_vcpu;
> +		goto uninit_vcpu;
>  
>  	spin_lock(&vcore->lock);
>  	++vcore->num_threads;
> @@ -2385,6 +2385,8 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>  
>  	return vcpu;
>  
> +uninit_vcpu:
> +	kvm_vcpu_uninit(vcpu);
>  free_vcpu:
>  	kmem_cache_free(kvm_vcpu_cache, vcpu);
>  out:
> -- 
> 2.24.1

Looks correct.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
