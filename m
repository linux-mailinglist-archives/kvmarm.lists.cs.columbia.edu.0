Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 501B1C3E6C
	for <lists+kvmarm@lfdr.de>; Tue,  1 Oct 2019 19:19:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 305414A676;
	Tue,  1 Oct 2019 13:19:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7B270VnzD+hP; Tue,  1 Oct 2019 13:19:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 003CF4A6B3;
	Tue,  1 Oct 2019 13:19:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 88CA14A67F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Oct 2019 13:19:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kuA6n2cE+VNr for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Oct 2019 13:19:41 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 41CCD4A65C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Oct 2019 13:19:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28001570;
 Tue,  1 Oct 2019 10:19:40 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BF1A3F918;
 Tue,  1 Oct 2019 10:19:32 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] kvm/arm64: expose hypercall_forwarding capability
To: Heyi Guo <guoheyi@huawei.com>
References: <1569338454-26202-1-git-send-email-guoheyi@huawei.com>
 <1569338454-26202-3-git-send-email-guoheyi@huawei.com>
From: James Morse <james.morse@arm.com>
Message-ID: <bd2c398b-7703-03a2-052b-1414630d0b43@arm.com>
Date: Tue, 1 Oct 2019 18:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1569338454-26202-3-git-send-email-guoheyi@huawei.com>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Heyi,

On 24/09/2019 16:20, Heyi Guo wrote:
> Add new KVM capability "KVM_CAP_FORWARD_HYPERCALL" for user space to
> probe whether KVM supports forwarding hypercall.
> 
> The capability should be enabled by user space explicitly, for we
> don't want user space application to deal with unexpected hypercall
> exits. We also use an additional argument to pass exception bit mask,
> to request KVM to forward all hypercalls except the classes specified
> in the bit mask.
> 
> Currently only PSCI can be set as exception, so that we can still keep
> consistent with the old PSCI processing flow.

I agree this needs to be default-on, but I don't think this exclusion mechanism is extensible.


> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index f4a8ae9..2201b62 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -102,6 +105,28 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	return r;
>  }
>  
> +int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> +			    struct kvm_enable_cap *cap)
> +{
> +	if (cap->flags)
> +		return -EINVAL;
> +
> +	switch (cap->cap) {
> +	case KVM_CAP_FORWARD_HYPERCALL: {
> +		__u64 exclude_flags = cap->args[0];

and if there are more than 64 things to exclude?


> +		/* Only support excluding PSCI right now */
> +		if (exclude_flags & ~KVM_CAP_FORWARD_HYPERCALL_EXCL_PSCI)
> +			return -EINVAL;

Once we have a 65th bit, older kernels will let user-space set it, but nothing happens.


> +		kvm->arch.hypercall_forward = true;
> +		if (exclude_flags & KVM_CAP_FORWARD_HYPERCALL_EXCL_PSCI)
> +			kvm->arch.hypercall_excl_psci = true;
> +		return 0;
> +	}
> +	}
> +
> +	return -EINVAL;
> +}

While 4*64 'named bits' for SMC/HVC ranges might be enough, it is tricky to work with.
Both the kernel and user-space have to maintain a list of bit->name and
name->call-number-range, which may change over time.

A case in point: According to PSCI's History (Section 7 of DEN022D), PSCIv1.1 added
SYSTEM_RESET2, MEM_PROTECT and MEM_PROTECT_CHECK_RANGE.

I think its simpler for the HYPERCALL thing to act as a catch-all, and we provide
something to enumerate the list of function id's the kernel implements.

We can then add controls to disable the PSCI (which I think is the only one we have a case
for disabling). I think the PSCI disable should wait until it has a user.


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
