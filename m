Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D51E26EF
	for <lists+kvmarm@lfdr.de>; Tue, 26 May 2020 18:29:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D5E764B168;
	Tue, 26 May 2020 12:29:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H00ypeZ0hVSw; Tue, 26 May 2020 12:29:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B44FA4B164;
	Tue, 26 May 2020 12:29:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C50F4B090
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 12:28:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nLeYLiHIJSR8 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 May 2020 12:28:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 244864B07F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 12:28:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C079730E;
 Tue, 26 May 2020 09:28:57 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2CF3F52E;
 Tue, 26 May 2020 09:28:55 -0700 (PDT)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 10/26] KVM: arm64: Refactor vcpu_{read,write}_sys_reg
To: Marc Zyngier <maz@kernel.org>
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-11-maz@kernel.org>
Message-ID: <09da829c-1640-40fe-313f-df021759fb34@arm.com>
Date: Tue, 26 May 2020 17:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200422120050.3693593-11-maz@kernel.org>
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
> Extract the direct HW accessors for later reuse.

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 51db934702b64..46f218982df8c 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c

> +u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
> +{
> +	u64 val = 0x8badf00d8badf00d;
> +
> +	if (!vcpu->arch.sysregs_loaded_on_cpu) {
> +		goto memory_read;
>  	}
>  
> -immediate_write:
> +	if (__vcpu_read_sys_reg_from_cpu(reg, &val))
> +		return val;
> +
> +memory_read:
> +	return __vcpu_sys_reg(vcpu, reg);
> +}


The goto here is a bit odd, is it just an artefact of how we got here?
Is this easier on the eye?:
| u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
| {
|	u64 val = 0x8badf00d8badf00d;
|
|	if (vcpu->arch.sysregs_loaded_on_cpu &&
|	    __vcpu_read_sys_reg_from_cpu(reg, &val))
|		return val;
|
| 	return __vcpu_sys_reg(vcpu, reg);
| }


> +void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
> +{
> +	if (!vcpu->arch.sysregs_loaded_on_cpu)
> +		goto memory_write;
> +
> +	if (__vcpu_write_sys_reg_to_cpu(val, reg))
> +		return;
> +
> +memory_write:
>  	 __vcpu_sys_reg(vcpu, reg) = val;
>  }

Again I think its clearer without the goto....


Regardless:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
