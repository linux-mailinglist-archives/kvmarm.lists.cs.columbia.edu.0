Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79E35EDE9
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 08:59:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A80E14B663;
	Wed, 14 Apr 2021 02:58:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcHF7bvbAcZB; Wed, 14 Apr 2021 02:58:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 738B64B69A;
	Wed, 14 Apr 2021 02:58:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C992E4B652
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 02:58:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZzCmnc5sptar for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Apr 2021 02:58:56 -0400 (EDT)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8BA3A4B643
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 02:58:56 -0400 (EDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKtYZ4WhCz9xGM;
 Wed, 14 Apr 2021 14:56:34 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 14:58:40 +0800
Subject: Re: [RFC PATCH v2 2/2] kvm/arm64: Try stage2 block mapping for host
 device MMIO
To: Marc Zyngier <maz@kernel.org>
References: <20210316134338.18052-1-zhukeqian1@huawei.com>
 <20210316134338.18052-3-zhukeqian1@huawei.com> <878s5up71v.wl-maz@kernel.org>
 <9f74392b-1086-a85e-72d8-f7bd99d65ea7@huawei.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <f1d9f7c2-969f-336a-9744-5706d6c59298@huawei.com>
Date: Wed, 14 Apr 2021 14:58:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <9f74392b-1086-a85e-72d8-f7bd99d65ea7@huawei.com>
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Marc,

On 2021/4/8 15:28, Keqian Zhu wrote:
> Hi Marc,
> 
> On 2021/4/7 21:18, Marc Zyngier wrote:
>> On Tue, 16 Mar 2021 13:43:38 +0000,
>> Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>>
[...]

>>>  
>>> +/*
>>> + * Find a mapping size that properly insides the intersection of vma and
>>> + * memslot. And hva and pa have the same alignment to this mapping size.
>>> + * It's rough because there are still other restrictions, which will be
>>> + * checked by the following fault_supports_stage2_huge_mapping().
>>
>> I don't think these restrictions make complete sense to me. If this is
>> a PFNMAP VMA, we should use the biggest mapping size that covers the
>> VMA, and not more than the VMA.
> But as described by kvm_arch_prepare_memory_region(), the memslot may not fully
> cover the VMA. If that's true and we just consider the boundary of the VMA, our
> block mapping may beyond the boundary of memslot. Is this a problem?
emm... Sorry I missed something. The fault_supports_stage2_huge_mapping() will check
the boundary of memslot, so we don't need to check it here. I have send v3, please
check that.

BRs,
Keqian
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
