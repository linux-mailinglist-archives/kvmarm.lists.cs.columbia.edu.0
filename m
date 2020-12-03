Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5EF2CD8C7
	for <lists+kvmarm@lfdr.de>; Thu,  3 Dec 2020 15:18:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E8964B1D4;
	Thu,  3 Dec 2020 09:18:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBgZCGC0iHud; Thu,  3 Dec 2020 09:18:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B89A4B1CF;
	Thu,  3 Dec 2020 09:18:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 932544B1C0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 09:18:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pf7zVqwXLgNE for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Dec 2020 09:18:19 -0500 (EST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3C3B34B08E
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 09:18:19 -0500 (EST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CmybY5N94z15VPL;
 Thu,  3 Dec 2020 22:17:45 +0800 (CST)
Received: from [10.174.187.37] (10.174.187.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 22:18:03 +0800
Subject: Re: [PATCH v2 0/2] clocksource: arm_arch_timer: Some fixes
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
References: <20200818032814.15968-1-zhukeqian1@huawei.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <63334212-e151-07f4-ccf6-63eedaaf33bc@huawei.com>
Date: Thu, 3 Dec 2020 22:18:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200818032814.15968-1-zhukeqian1@huawei.com>
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

Found that this bugfix series is not applied for now.
Does it need some modification? Wish you can pick it up :-)

Thanks,
Keqian

On 2020/8/18 11:28, Keqian Zhu wrote:
> change log:
> 
> v2:
>  - Do not revert commit 0ea415390cd3, fix it instead.
>  - Correct the tags of second patch.
> 
> Keqian Zhu (2):
>   clocksource: arm_arch_timer: Use stable count reader in erratum sne
>   clocksource: arm_arch_timer: Correct fault programming of
>     CNTKCTL_EL1.EVNTI
> 
>  drivers/clocksource/arm_arch_timer.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
