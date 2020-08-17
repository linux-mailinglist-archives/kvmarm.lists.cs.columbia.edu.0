Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 075A32463CD
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 11:53:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D15F4BFD5;
	Mon, 17 Aug 2020 05:53:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtR6U7kkMA3b; Mon, 17 Aug 2020 05:53:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C5584BFD1;
	Mon, 17 Aug 2020 05:53:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 405B64BFCE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 05:53:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jCyitHPxfDxl for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 05:53:12 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 38EF64BFCD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 05:53:12 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7054031B;
 Mon, 17 Aug 2020 02:53:11 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EC453F66B;
 Mon, 17 Aug 2020 02:53:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] KVM: arm64: Use kvm_write_guest_lock when init stolen
 time
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20200817033729.10848-1-zhukeqian1@huawei.com>
 <20200817033729.10848-4-zhukeqian1@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <41523036-7492-d554-e256-32f42959684d@arm.com>
Date: Mon, 17 Aug 2020 10:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817033729.10848-4-zhukeqian1@huawei.com>
Content-Language: en-GB
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 17/08/2020 04:37, Keqian Zhu wrote:
> There is a lock version kvm_write_guest. Use it to simplify code.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   arch/arm64/kvm/pvtime.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
> index f7b52ce..2b24e7f 100644
> --- a/arch/arm64/kvm/pvtime.c
> +++ b/arch/arm64/kvm/pvtime.c
> @@ -55,7 +55,6 @@ gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu)
>   	struct pvclock_vcpu_stolen_time init_values = {};
>   	struct kvm *kvm = vcpu->kvm;
>   	u64 base = vcpu->arch.steal.base;
> -	int idx;
>   
>   	if (base == GPA_INVALID)
>   		return base;
> @@ -66,10 +65,7 @@ gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu)
>   	 */
>   	vcpu->arch.steal.steal = 0;
>   	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
> -
> -	idx = srcu_read_lock(&kvm->srcu);
> -	kvm_write_guest(kvm, base, &init_values, sizeof(init_values));
> -	srcu_read_unlock(&kvm->srcu, idx);
> +	kvm_write_guest_lock(kvm, base, &init_values, sizeof(init_values));
>   
>   	return base;
>   }
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
