Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF2F186B2C
	for <lists+kvmarm@lfdr.de>; Mon, 16 Mar 2020 13:39:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 90DAB4B090;
	Mon, 16 Mar 2020 08:39:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16U7Uxq2lP-T; Mon, 16 Mar 2020 08:39:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 82F434B080;
	Mon, 16 Mar 2020 08:39:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CBEB4B080
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Mar 2020 08:39:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4c-8U9D1lrjn for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Mar 2020 08:39:03 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C1A8A4A523
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Mar 2020 08:39:02 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7A402E500B6ABF9507E3;
 Mon, 16 Mar 2020 20:38:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Mar 2020
 20:38:38 +0800
Subject: Re: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
To: Marc Zyngier <maz@kernel.org>
References: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
 <7ed91b9b-e968-770c-28f9-0ca479359657@huawei.com>
 <a8b72d6c0a28e0554050e98d011f32d9@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <a9fd7e22-f46a-fd47-26ee-44d2d36783fd@huawei.com>
Date: Mon, 16 Mar 2020 20:38:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a8b72d6c0a28e0554050e98d011f32d9@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

Hi Marc,

On 2020/3/16 19:09, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-03-16 10:49, Zenghui Yu wrote:
>> Hi,
>>
>> On 2020/3/16 17:39, KarimAllah Ahmed wrote:
>>> Use the physical timer object when reading the physical timer counter
>>> instead of using the virtual timer object. This is only visible when
>>> reading it from user-space as kvm_arm_timer_get_reg() is only 
>>> executed on
>>> the get register patch from user-space.
>>
>> s/patch/path/
>>
>> I think the physical counter hasn't yet been accessed by the current
>> userspace, wrong?
> 
> I don't think userspace can access it, as the ONE_REG API only exposes 
> the virtual
> timer so far, and userspace is much better off just reading the counter 
> directly
> (it has access to the virtual counter, and the guarantee that cntvoff is 
> 0 in this
> context).

Yeah, I see. The physical timer registers are all ignored in
walk_one_sys_reg() and won't be exposed.

> 
> But as we move towards a situation where we can save/restore the 
> physical timer
> just like the virtual one, we're going to use this path and hit this bug.

Thanks for the explanation.


Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
