Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9893E4422D9
	for <lists+kvmarm@lfdr.de>; Mon,  1 Nov 2021 22:40:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4650A4B1D3;
	Mon,  1 Nov 2021 17:40:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7E1R0-QD27w; Mon,  1 Nov 2021 17:40:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4242D4B263;
	Mon,  1 Nov 2021 17:40:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C1778401A2
 for <kvmarm@lists.cs.columbia.edu>; Sun, 31 Oct 2021 18:30:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Ve7RM0jawME for <kvmarm@lists.cs.columbia.edu>;
 Sun, 31 Oct 2021 18:30:45 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D508840162
 for <kvmarm@lists.cs.columbia.edu>; Sun, 31 Oct 2021 18:30:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635719445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjQhiLyEbEDnD4Y2r5pZNoATO4AoPvr4JeskA/KrBlI=;
 b=Y2zPxUiePWrYoTYNkf85cU0LvFN3JXlQW9deZq2gban7dWU0w1rIOWlv35DTW1U5IHJ0eJ
 pJqKu4c9sye9V6Aufmv8dcFVzLPC0NTl9GW/WPPrdNaCgZm7FZ+0JNPDdlW9ph2xPd2Dwk
 IaF6QRXofsbs8EUZwUqFuXc09CLyLRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-e9ofhHeAOOizUfULmvajlw-1; Sun, 31 Oct 2021 18:30:42 -0400
X-MC-Unique: e9ofhHeAOOizUfULmvajlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB52D18125C0;
 Sun, 31 Oct 2021 22:30:38 +0000 (UTC)
Received: from starship (unknown [10.40.194.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8110517155;
 Sun, 31 Oct 2021 22:30:08 +0000 (UTC)
Message-ID: <ffce26d0540acb7550be719255689b61210919c1.camel@redhat.com>
Subject: Re: [PATCH v2 42/43] KVM: VMX: Fold fallback path into triggering
 posted IRQ helper
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, Aleksandar Markovic
 <aleksandar.qemu.devel@gmail.com>, Paul Mackerras <paulus@ozlabs.org>, Anup
 Patel <anup.patel@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 01 Nov 2021 00:30:07 +0200
In-Reply-To: <20211009021236.4122790-43-seanjc@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-43-seanjc@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mailman-Approved-At: Mon, 01 Nov 2021 17:40:12 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Joerg Roedel <joro@8bytes.org>, kvm-ppc@vger.kernel.org,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Fri, 2021-10-08 at 19:12 -0700, Sean Christopherson wrote:
> Move the fallback "wake_up" path into the helper to trigger posted
> interrupt helper now that the nested and non-nested paths are identical.

Nit: I think you refer to patch 41 here, but I think that nested and non nested paths were identical
before as well, so this patch could be done without patch 41 as well.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f505fee3cf5c..b0d97cf18c34 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3927,7 +3927,7 @@ static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
>  	pt_update_intercept_for_msr(vcpu);
>  }
>  
> -static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
> +static inline void kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
>  						     int pi_vec)
>  {
>  #ifdef CONFIG_SMP
> @@ -3958,10 +3958,15 @@ static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
>  		 */
>  
>  		apic->send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
> -		return true;
> +		return;
>  	}
>  #endif
> -	return false;
> +	/*
> +	 * The vCPU isn't in the guest; wake the vCPU in case it is blocking,
> +	 * otherwise do nothing as KVM will grab the highest priority pending
> +	 * IRQ via ->sync_pir_to_irr() in vcpu_enter_guest().
> +	 */
> +	kvm_vcpu_wake_up(vcpu);
>  }
>  
>  static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
> @@ -3984,8 +3989,7 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
>  		 */
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
>  		/* the PIR and ON have been set by L1. */
> -		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR))
> -			kvm_vcpu_wake_up(vcpu);
> +		kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR);
>  		return 0;
>  	}
>  	return -1;
> @@ -4022,9 +4026,7 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
>  	 * guaranteed to see PID.ON=1 and sync the PIR to IRR if triggering a
>  	 * posted interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
>  	 */
> -	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR))
> -		kvm_vcpu_wake_up(vcpu);
> -
> +	kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR);
>  	return 0;
>  }
>  


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
