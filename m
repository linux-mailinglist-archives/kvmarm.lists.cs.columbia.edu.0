Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D528739A809
	for <lists+kvmarm@lfdr.de>; Thu,  3 Jun 2021 19:13:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AFCF4B11C;
	Thu,  3 Jun 2021 13:13:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YoEeLi8PIrjW; Thu,  3 Jun 2021 13:13:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E11C24B112;
	Thu,  3 Jun 2021 13:13:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C366F4B0C8
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 13:13:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NbsFQ1+BBF3e for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Jun 2021 13:13:43 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8BFD44B0C7
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 13:13:43 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95F3961420;
 Thu,  3 Jun 2021 17:13:39 +0000 (UTC)
Date: Thu, 3 Jun 2021 18:13:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v13 7/8] KVM: arm64: ioctl to fetch/store tags in a guest
Message-ID: <20210603171336.GH20338@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-8-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210524104513.13258-8-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On Mon, May 24, 2021 at 11:45:12AM +0100, Steven Price wrote:
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 24223adae150..b3edde68bc3e 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -184,6 +184,17 @@ struct kvm_vcpu_events {
>  	__u32 reserved[12];
>  };
>  
> +struct kvm_arm_copy_mte_tags {
> +	__u64 guest_ipa;
> +	__u64 length;
> +	void __user *addr;
> +	__u64 flags;
> +	__u64 reserved[2];
> +};
> +
> +#define KVM_ARM_TAGS_TO_GUEST		0
> +#define KVM_ARM_TAGS_FROM_GUEST		1
> +
>  /* If you need to interpret the index values, here is the key: */
>  #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
>  #define KVM_REG_ARM_COPROC_SHIFT	16
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e89a5e275e25..baa33359e477 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1345,6 +1345,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  
>  		return 0;
>  	}
> +	case KVM_ARM_MTE_COPY_TAGS: {
> +		struct kvm_arm_copy_mte_tags copy_tags;
> +
> +		if (copy_from_user(&copy_tags, argp, sizeof(copy_tags)))
> +			return -EFAULT;
> +		return kvm_vm_ioctl_mte_copy_tags(kvm, &copy_tags);
> +	}

I wonder whether we need an update of the user structure following a
fault, like how much was copied etc. In case of an error, some tags were
copied and the VMM may want to skip the page before continuing. But here
there's no such information provided.

On the ptrace interface, we return 0 on the syscall if any bytes were
copied and update iov_len to such number. Maybe you want to still return
an error here but updating copy_tags.length would be nice (and, of
course, a copy_to_user() back).

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
