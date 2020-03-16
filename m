Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5511E18696F
	for <lists+kvmarm@lfdr.de>; Mon, 16 Mar 2020 11:50:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B82A94A531;
	Mon, 16 Mar 2020 06:50:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQKuZEt1OALl; Mon, 16 Mar 2020 06:50:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 91B684A588;
	Mon, 16 Mar 2020 06:50:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 208114A523
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Mar 2020 06:50:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 43wh42Jn8z1J for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Mar 2020 06:50:10 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 21AF840456
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Mar 2020 06:50:10 -0400 (EDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1798D6017481BD96D1A2;
 Mon, 16 Mar 2020 18:50:02 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Mar 2020
 18:49:53 +0800
Subject: Re: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
To: KarimAllah Ahmed <karahmed@amazon.de>, <linux-kernel@vger.kernel.org>
References: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7ed91b9b-e968-770c-28f9-0ca479359657@huawei.com>
Date: Mon, 16 Mar 2020 18:49:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi,

On 2020/3/16 17:39, KarimAllah Ahmed wrote:
> Use the physical timer object when reading the physical timer counter
> instead of using the virtual timer object. This is only visible when
> reading it from user-space as kvm_arm_timer_get_reg() is only executed on
> the get register patch from user-space.

s/patch/path/

I think the physical counter hasn't yet been accessed by the current
userspace, wrong?

> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

And this might also deserve:

Fixes: 84135d3d18da ("KVM: arm/arm64: consolidate arch timer trap handlers")


Thanks.

> ---
>   virt/kvm/arm/arch_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 0d9438e..93bd59b 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -788,7 +788,7 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
>   					  vcpu_ptimer(vcpu), TIMER_REG_CTL);
>   	case KVM_REG_ARM_PTIMER_CNT:
>   		return kvm_arm_timer_read(vcpu,
> -					  vcpu_vtimer(vcpu), TIMER_REG_CNT);
> +					  vcpu_ptimer(vcpu), TIMER_REG_CNT);
>   	case KVM_REG_ARM_PTIMER_CVAL:
>   		return kvm_arm_timer_read(vcpu,
>   					  vcpu_ptimer(vcpu), TIMER_REG_CVAL);
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
