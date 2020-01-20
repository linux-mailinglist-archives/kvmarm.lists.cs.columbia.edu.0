Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EC991142241
	for <lists+kvmarm@lfdr.de>; Mon, 20 Jan 2020 04:56:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F4D44AF19;
	Sun, 19 Jan 2020 22:56:57 -0500 (EST)
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
	with ESMTP id OqZ22VpQfxV9; Sun, 19 Jan 2020 22:56:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 658834AF01;
	Sun, 19 Jan 2020 22:56:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A03A34AEF9
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 22:56:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVUu42Ua+Z5Y for <kvmarm@lists.cs.columbia.edu>;
 Sun, 19 Jan 2020 22:56:53 -0500 (EST)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6738B4AEB1
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 22:56:53 -0500 (EST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 481Hsr4GqVz9sRK; Mon, 20 Jan 2020 14:56:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1579492608; bh=lAGKBdtognRp9MuKBdR+5b2SjLz9x55FpMJWqSfQ6qY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dUAKAq0v+fVttWJxioZvNG0BtMhcZUat99t698VbzX1F/zlmSKB330Etdpr8dhc76
 LgQ0zJdbhuyR1H/vR0aYkaoRDTWcKoSWaqcXj6ErDly+Tn2yz7PSXHSNyMImPMl9tP
 xyavDDW3J6vU7xLt0EzjiAP8W7GOt+xqqQHnwlIoIwKSt8mNIQuX2kFmVUUOR/AB+1
 223kTr75BFvJJpA2PeWzgxHtia7sYccOJwK6fdQs+TGCFIgaTI9QqAo127pLrxO2BS
 vw/3QB56iD9jMWi9IFVNiAA2HJNbXbWM7qMcFTfg7AwfcraXsEohfC0CAqwPxUayYv
 d19QF6AMoz1qQ==
Date: Mon, 20 Jan 2020 14:56:44 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 15/45] KVM: PPC: Move kvm_vcpu_init() invocation to
 common code
Message-ID: <20200120035644.GE14307@blackberry>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
 <20191218215530.2280-16-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191218215530.2280-16-sean.j.christopherson@intel.com>
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

On Wed, Dec 18, 2019 at 01:55:00PM -0800, Sean Christopherson wrote:
> Move the kvm_cpu_{un}init() calls to common PPC code as an intermediate
> step towards removing kvm_cpu_{un}init() altogether.
> 
> No functional change intended.

Another error to fix:

> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 047c9f707704..dd7440e50c7a 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -2114,10 +2114,9 @@ int kvmppc_core_init_vm(struct kvm *kvm)
>  	return kvm->arch.kvm_ops->init_vm(kvm);
>  }
>  
> -int kvmppc_core_vcpu_create(struct kvm *kvm, struct kvm_vcpu *vcpu,
> -			    unsigned int id)
> +int kvmppc_core_vcpu_create(struct kvm_vcpu *vcpu)
>  {
> -	return kvm->arch.kvm_ops->vcpu_create(kvm, vcpu, id);
> +	return kvm->arch.kvm_ops->vcpu_create(vcpu);

This also needs s/kvm/vcpu->kvm/.

Paul.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
