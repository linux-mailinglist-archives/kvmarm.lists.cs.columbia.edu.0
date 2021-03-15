Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1933AD04
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 09:04:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 794E94B525;
	Mon, 15 Mar 2021 04:04:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f5y+wyd21YjY; Mon, 15 Mar 2021 04:04:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 654374B495;
	Mon, 15 Mar 2021 04:04:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A6AE4B486
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 04:04:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LvU4BfHld22Y for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 04:04:46 -0400 (EDT)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B51DE4B481
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 04:04:46 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DzTRw1Y4nz8y3T;
 Mon, 15 Mar 2021 16:02:52 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 16:04:40 +0800
Subject: Re: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
To: Gavin Shan <gshan@redhat.com>, <kvmarm@lists.cs.columbia.edu>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-3-gshan@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <65dfdca3-af94-7d5a-86fe-24825301655b@huawei.com>
Date: Mon, 15 Mar 2021 16:04:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210315041844.64915-3-gshan@redhat.com>
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

On 2021/3/15 12:18, Gavin Shan wrote:
> find_vma_intersection() has been existing to search the intersected
> vma. This uses the function where it's applicable, to simplify the
> code.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/mmu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 84e70f953de6..286b603ed0d3 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -421,10 +421,11 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>  	 *     +--------------------------------------------+
>  	 */
>  	do {
> -		struct vm_area_struct *vma = find_vma(current->mm, hva);
> +		struct vm_area_struct *vma;
>  		hva_t vm_start, vm_end;
>  
> -		if (!vma || vma->vm_start >= reg_end)
> +		vma = find_vma_intersection(current->mm, hva, reg_end);
Nit: Keep a same style may be better(Assign vma when declare it).
Other looks good to me.

Thank,
Keqian


> +		if (!vma)
>  			break;
>  
>  		/*
> @@ -1330,10 +1331,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  	 *     +--------------------------------------------+
>  	 */
>  	do {
> -		struct vm_area_struct *vma = find_vma(current->mm, hva);
> +		struct vm_area_struct *vma;
>  		hva_t vm_start, vm_end;
>  
> -		if (!vma || vma->vm_start >= reg_end)
> +		vma = find_vma_intersection(current->mm, hva, reg_end);
> +		if (!vma)
>  			break;
>  
>  		/*
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
