Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7721F25E
	for <lists+kvmarm@lfdr.de>; Tue, 14 Jul 2020 15:23:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 062C84B205;
	Tue, 14 Jul 2020 09:23:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsFziBLokIE0; Tue, 14 Jul 2020 09:22:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFA794B1E8;
	Tue, 14 Jul 2020 09:22:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 816E44B1DC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jul 2020 09:22:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PagqrtY87oaf for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Jul 2020 09:22:54 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 77B9A4B1B2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jul 2020 09:22:54 -0400 (EDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6FA8D32829F7A1378D6D;
 Tue, 14 Jul 2020 21:22:51 +0800 (CST)
Received: from [10.174.187.22] (10.174.187.22) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 21:22:42 +0800
Subject: Re: [Question] About scaling factor of Enhanced Counter Virtualization
To: Marc Zyngier <maz@kernel.org>
References: <e435efd2-f894-ecbb-5eb4-abf446aa1e56@huawei.com>
 <ccc11488876b8222414389d0cbcead6b@kernel.org>
 <0bbe0709-c055-2d97-9a88-814821dd9c2f@huawei.com>
 <eda57587fe701c9eee8641c94496dbc3@kernel.org>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <b594559f-6a63-94e2-4288-c1da330f56d3@huawei.com>
Date: Tue, 14 Jul 2020 21:22:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <eda57587fe701c9eee8641c94496dbc3@kernel.org>
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>, yebiaoxiang@huawei.com,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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



On 2020/7/14 20:23, Marc Zyngier wrote:
> On 2020-07-14 13:15, zhukeqian wrote:
>> Hi Marc,
>>
>> On 2020/7/14 19:34, Marc Zyngier wrote:
>>> Hi Keqian,
>>>
>>> On 2020-07-14 03:20, zhukeqian wrote:
>>>> Hi all,
>>>>
>>>> We are studying Enhanced Counter Virtualization (introduced by ARMv8.6
>>>> extension), and here is a question
>>>> raised by Biaoxiang Ye <yebiaoxiang@huawei.com>:
>>>>
>>>> Described in the ARMv8.6 Extension Specification:
>>>> Note: the scaling factor CNTSCALE is designed as a 2.62 bit fixed
>>>> point number, so permitting a scaling up by
>>>> (nearly) a factor 4. The scaling factor CNTISCALE is signed as an 8.56
>>>> number for the scaling of the values
>>>> written into the timers for comparison with the actual count. This
>>>> implies that the greatest scaling down of the
>>>> counter supported in (nearly) a factor of *512*.
>>>>
>>>> We think the number "512" should be "256" (2^8), or do we miss something?
>>>
>>> This register doesn't seem to be described in ARM DDI 0487F.b,
>>> which is the official documentation and does contain the ARMv8.6
>>> material, including ARMv8.6-ECV.
>>>
>>> Either you are looking at confidential information (and nobody
>>> can answer you in public), or obsolete information (and nobody
>>> knows what this is about).
>>>
>> Well, it's alpha release version :( . Many thanks!
> 
> Wow. I suggest you discard this document, as it is obsolete.
> ARMv8.6 is a released version of the architecture, and
> everything should be in the ARM ARM.
OK, there are many difference :) .

Thanks,
Keqian
> 
>         M.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
