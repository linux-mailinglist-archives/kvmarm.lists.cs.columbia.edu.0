Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CFD602464F1
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 12:56:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 307D44C06B;
	Mon, 17 Aug 2020 06:56:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdbteIroefdX; Mon, 17 Aug 2020 06:56:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 270994C064;
	Mon, 17 Aug 2020 06:56:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF2784C060
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:56:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 88Ba4NHwPUkh for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 06:56:37 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2AC634C05F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:56:37 -0400 (EDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EA7F5FA70E4499864175;
 Mon, 17 Aug 2020 18:56:31 +0800 (CST)
Received: from [10.174.187.22] (10.174.187.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 18:56:26 +0800
Subject: Re: [PATCH 2/3] KVM: uapi: Remove KVM_DEV_TYPE_ARM_PV_TIME in
 kvm_device_type
To: Steven Price <steven.price@arm.com>, Marc Zyngier <maz@kernel.org>
References: <20200817033729.10848-1-zhukeqian1@huawei.com>
 <20200817033729.10848-3-zhukeqian1@huawei.com>
 <f97633b4a39c301f916bb76030dcabf0@kernel.org>
 <4cd543a2-4d5b-882c-38d6-f5055512f0dc@huawei.com>
 <72e34f84-5bea-8f69-6699-29e2970c80b4@arm.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <40a10c89-d876-5aea-dd45-b7e75ef31c71@huawei.com>
Date: Mon, 17 Aug 2020 18:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <72e34f84-5bea-8f69-6699-29e2970c80b4@arm.com>
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Steven,

On 2020/8/17 17:49, Steven Price wrote:
> On 17/08/2020 09:43, zhukeqian wrote:
>> Hi Marc,
>>
[...]
>>>
>>> It is pretty unfortunate that PV time has turned into such a train wreck,
>>> but that's what we have now, and it has to stay.
>> Well, I see. It is a sad thing indeed.
> 
> Sorry about that, this got refactored so many times I guess I lost track of what was actually needed and this hunk remained when it should have been removed.
> 
It's fine :-) , not a serious problem.
> I would hope that I'm the only one who has any userspace code which uses this, but I guess we should still be cautious since this has been in several releases now.
> 
OK. For insurance purposes, we ought to ignore this patch to avoid breaking any user-space program.
> Steve
> .
Thanks,
Keqian
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
