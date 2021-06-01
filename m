Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF0396A91
	for <lists+kvmarm@lfdr.de>; Tue,  1 Jun 2021 03:16:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CBF24064F;
	Mon, 31 May 2021 21:16:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZ3ezPKOtakn; Mon, 31 May 2021 21:16:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 50220407F1;
	Mon, 31 May 2021 21:16:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F879402DB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 31 May 2021 21:16:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 97NoJ50QZzTx for <kvmarm@lists.cs.columbia.edu>;
 Mon, 31 May 2021 21:16:50 -0400 (EDT)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 626B14019D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 31 May 2021 21:16:50 -0400 (EDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FvDg11D2Cz678n;
 Tue,  1 Jun 2021 09:13:01 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 09:16:44 +0800
Received: from [10.174.187.224] (10.174.187.224) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 09:16:43 +0800
Subject: Re: [PATCH v5 0/2] kvm/arm64: Try stage2 block mapping for host
 device MMIO
To: Marc Zyngier <maz@kernel.org>
References: <20210507110322.23348-1-zhukeqian1@huawei.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <dcd01056-4d9f-c55f-7c84-ecba0e0a2810@huawei.com>
Date: Tue, 1 Jun 2021 09:16:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210507110322.23348-1-zhukeqian1@huawei.com>
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

Hi Marc,

Kindly remind. :)

BRs,
Keqian

On 2021/5/7 19:03, Keqian Zhu wrote:
> Hi Marc,
> 
> This rebases to newest mainline kernel.
> 
> Thanks,
> Keqian
> 
> 
> We have two pathes to build stage2 mapping for MMIO regions.
> 
> Create time's path and stage2 fault path.
> 
> Patch#1 removes the creation time's mapping of MMIO regions
> Patch#2 tries stage2 block mapping for host device MMIO at fault path
> 
> Changelog:
> 
> v5:
>  - Rebase to newest mainline.
> 
> v4:
>  - use get_vma_page_shift() handle all cases. (Marc)
>  - get rid of force_pte for device mapping. (Marc)
> 
> v3:
>  - Do not need to check memslot boundary in device_rough_page_shift(). (Marc)
> 
> 
> Keqian Zhu (2):
>   kvm/arm64: Remove the creation time's mapping of MMIO regions
>   kvm/arm64: Try stage2 block mapping for host device MMIO
> 
>  arch/arm64/kvm/mmu.c | 99 ++++++++++++++++++++++++--------------------
>  1 file changed, 54 insertions(+), 45 deletions(-)
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
