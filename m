Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9926B984
	for <lists+kvmarm@lfdr.de>; Wed, 16 Sep 2020 03:52:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B0BFF4B302;
	Tue, 15 Sep 2020 21:52:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vIdWVhB+MtX4; Tue, 15 Sep 2020 21:52:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 95A934B2F6;
	Tue, 15 Sep 2020 21:52:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B425F4B2E2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Sep 2020 21:51:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1s2RCwqPhAZ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 15 Sep 2020 21:51:58 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BB8224B2E0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Sep 2020 21:51:57 -0400 (EDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8B4CFF0684C28E4090F6;
 Wed, 16 Sep 2020 09:51:53 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 09:51:42 +0800
Subject: Re: [PATCH] KVM: arm64: fix doc warnings in mmu code
To: Marc Zyngier <maz@kernel.org>
References: <1600175890-7435-1-git-send-email-tanxiaofei@huawei.com>
 <7bcb5fd9b6490e98cfa8aa22496a8a71@kernel.org>
From: Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F616FAE.4030006@huawei.com>
Date: Wed, 16 Sep 2020 09:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <7bcb5fd9b6490e98cfa8aa22496a8a71@kernel.org>
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

OK, I will send v2 patch based on kvmarm-next branch. thanks.

On 2020/9/15 21:47, Marc Zyngier wrote:
> Hi Xiaofei,
> 
> On 2020-09-15 14:18, Xiaofei Tan wrote:
>> Fix following warnings caused by mismatch bewteen function parameters
>> and comments.
>> arch/arm64/kvm/mmu.c:119: warning: Function parameter or member
>> 'pudp'not described in 'stage2_dissolve_pud'
>> arch/arm64/kvm/mmu.c:119: warning: Excess function parameter 'pud'
>> description in 'stage2_dissolve_pud'
> 
> [...]
> 
> Most of this code is being deleted. If you want to fix comments,
> please look at what is in -next.
> 
> Thanks,
> 
>         M.

-- 
 thanks
tanxiaofei

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
