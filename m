Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C99C233AC4F
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 08:33:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 45AD84B277;
	Mon, 15 Mar 2021 03:33:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XgLdJt1MegK; Mon, 15 Mar 2021 03:33:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AF464B2B0;
	Mon, 15 Mar 2021 03:33:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 63E244B2B0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 03:33:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWUSJ6rjv+1g for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 03:33:45 -0400 (EDT)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 434FF4B2A4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 03:33:45 -0400 (EDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DzSm56Pybz8yRT;
 Mon, 15 Mar 2021 15:31:49 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 15:33:39 +0800
Subject: Re: [PATCH 3/4] KVM: arm64: Fix address check for memory slot
To: Gavin Shan <gshan@redhat.com>, <kvmarm@lists.cs.columbia.edu>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-4-gshan@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <be57b9fb-89c4-9c32-f273-9f4bbe973b00@huawei.com>
Date: Mon, 15 Mar 2021 15:33:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210315041844.64915-4-gshan@redhat.com>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com
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

Hi Gavin,

FYI, this has been fixed by Marc in commit 262b003d059c.

Thanks,
Keqian

On 2021/3/15 12:18, Gavin Shan wrote:
> The last (IPA) page can't be specified when a new memory slot is
> added. The error -EFAULT is returned when the memory slot is added
> with the following parameters for the VM, which has 40-bits IPA
> limit. The host has 4KB base page size. It's not correct because
> the last (IPA) page is still usable.
> 
>    struct kvm_userspace_memory_region {
>       __u32 slot;               /* 1            */
>       __u32 flags;              /* 0            */
>       __u64 guest_phys_addr;    /* 0xfffffff000 */
>       __u64 memory_size;        /* 0x1000       */
>       __u64 userspace_addr;
>    };
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 286b603ed0d3..a5a8ade9fde4 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1313,7 +1313,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  	 * Prevent userspace from creating a memory region outside of the IPA
>  	 * space addressable by the KVM guest IPA space.
>  	 */
> -	if (memslot->base_gfn + memslot->npages >=
> +	if (memslot->base_gfn + memslot->npages >
>  	    (kvm_phys_size(kvm) >> PAGE_SHIFT))
>  		return -EFAULT;
>  
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
