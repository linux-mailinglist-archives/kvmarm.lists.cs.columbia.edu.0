Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCB1E26F9
	for <lists+kvmarm@lfdr.de>; Tue, 26 May 2020 18:29:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E6F54B17C;
	Tue, 26 May 2020 12:29:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3oIpF1a6d3kp; Tue, 26 May 2020 12:29:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21E2F4B168;
	Tue, 26 May 2020 12:29:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 18CFB4B15C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 12:29:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NvG0Uy5XOjnL for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 May 2020 12:29:45 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 168B74B0F4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 12:29:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C352B30E;
 Tue, 26 May 2020 09:29:44 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53183F52E;
 Tue, 26 May 2020 09:29:42 -0700 (PDT)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 19/26] KVM: arm64: Make struct kvm_regs userspace-only
To: Marc Zyngier <maz@kernel.org>
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-20-maz@kernel.org>
Message-ID: <0a38305f-77f8-11b0-cb74-2bec07ce0a0a@arm.com>
Date: Tue, 26 May 2020 17:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200422120050.3693593-20-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 kvmarm@lists.cs.columbia.edu, Will Deacon <will@kernel.org>,
 George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Marc,

On 22/04/2020 13:00, Marc Zyngier wrote:
> struct kvm_regs is used by userspace to indicate which register gets
> accessed by the {GET,SET}_ONE_REG API. But as we're about to refactor
> the layout of the in-kernel register structures, we need the kernel to
> move away from it.
> 
> Let's make kvm_regs userspace only, and let the kernel map it to its own
> internal representation.

> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 23ebe51410f06..9fec9231b63e2 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -102,6 +102,55 @@ static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
>  	return size;
>  }
>  
> +static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	u64 off = core_reg_offset_from_id(reg->id);
> +
> +	switch (off) {

> +	default:
> +		return NULL;

Doesn't this switch statement catch an out of range offset, and a misaligned offset?

... We still test for those explicitly in the caller. Better safe than implicit?


> +	}
> +}

With the reset thing reported by Zenghui and Zengtao on the previous patch fixed:
Reviewed-by: James Morse <james.morse@arm.com>

(otherwise struct kvm_regs isn't userspace-only!)


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
