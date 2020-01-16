Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 509DC13D439
	for <lists+kvmarm@lfdr.de>; Thu, 16 Jan 2020 07:22:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D46CA4B10F;
	Thu, 16 Jan 2020 01:22:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdPqM+dktNI7; Thu, 16 Jan 2020 01:22:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D56794B11C;
	Thu, 16 Jan 2020 01:22:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C8B324B10F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jan 2020 01:22:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8ie0GuAdmFa for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Jan 2020 01:22:00 -0500 (EST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 080274B10E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jan 2020 01:21:59 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BD99A811C5DD757182DD;
 Thu, 16 Jan 2020 14:21:56 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 14:21:50 +0800
Subject: Re: [Question about KVM on arm64] Consider putting VINVALL to
 deactivation
To: Marc Zyngier <maz@kernel.org>
References: <bf470803-8e1c-d1c3-d5ac-731536196543@hisilicon.com>
 <37126a877e1160ed50ee6d95a03d1574@kernel.org>
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <d41bcfbd-69b1-641b-fc54-9255ac3e82b2@hisilicon.com>
Date: Thu, 16 Jan 2020 14:21:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <37126a877e1160ed50ee6d95a03d1574@kernel.org>
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Cc: wangwudi <wangwudi@hisilicon.com>, Lizixian <lizixian@hisilicon.com>,
 jiayanlei@huawei.com, fanhenglong@huawei.com, kvmarm@lists.cs.columbia.edu,
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

On 2020/1/15 21:50, Marc Zyngier wrote:
> Hi Shaokun,
> 
> On 2020-01-14 14:20, Shaokun Zhang wrote:
>> Hi Marc,
>>
>> On activation, VMAPP command is followed by a VINVALL, which could be
>> quite expensive for the start-up of virtual machine. If a vpeid is allowed
>> successfully, it is not used in system.
> 
> How expensive? This is exactly similar to what happens on a physical machine
> where we perform an INVALL on MAPC. And yet you don't complain about that.
> 

Agree, I didn't consider this before.

> Please provide numbers.
> 
>> We may consider put VINVALL to deactivation to ensure all cache of certain
>> vpeid is invalid, to simplify activation. We consider start-up may be more
>> common and more time-consuming-sensitive than shutdown process.
> 
> In my world, they cost the same thing, and happen just as often. Also, I want
> guarantees that on VMAPP, there is no stale information even if this is the
> first time we're using this VPEid (who knows what happens over kexec, for
> example).
> 
>> Do you think it's all right?
> 
> I don't, for the reasons stated above. You also provide no numbers showing
> how bad the overhead is, so I'm left guessing.
> 

Got it, you are right :-).

Thanks for your explaination
Shaokun

> Thanks,
> 
>         M.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
