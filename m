Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 95866338A7F
	for <lists+kvmarm@lfdr.de>; Fri, 12 Mar 2021 11:47:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F57B4B6EC;
	Fri, 12 Mar 2021 05:47:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bWWXibyEzaiu; Fri, 12 Mar 2021 05:47:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1471C4B66A;
	Fri, 12 Mar 2021 05:47:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6114A4B4C5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 05:47:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zfqqq6z7W1lG for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Mar 2021 05:47:16 -0500 (EST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 80D394B424
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 05:47:16 -0500 (EST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DxjBr137Kz8x4p;
 Fri, 12 Mar 2021 18:45:24 +0800 (CST)
Received: from [10.174.184.135] (10.174.184.135) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 18:47:04 +0800
Subject: Re: [PATCH v3 2/4] KVM: arm64: GICv4.1: Try to save hw pending state
 in save_pending_tables
To: Marc Zyngier <maz@kernel.org>
References: <20210127121337.1092-1-lushenming@huawei.com>
 <20210127121337.1092-3-lushenming@huawei.com> <87v99yf450.wl-maz@kernel.org>
 <3b47598f-0795-a165-1a64-abe02258b306@huawei.com>
 <87lfasg2wt.wl-maz@kernel.org>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <f43021d8-81f5-81ee-4561-7cfa52ae8023@huawei.com>
Date: Fri, 12 Mar 2021 18:47:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <87lfasg2wt.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
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

On 2021/3/12 17:02, Marc Zyngier wrote:
> On Thu, 11 Mar 2021 12:31:48 +0000,
> Shenming Lu <lushenming@huawei.com> wrote:
>>
>> On 2021/3/11 17:09, Marc Zyngier wrote:
> 
>>> I have asked that question in the past: is it actually safe to remap
>>> the vPEs and expect them to be runnable
>>
>> In my opinion, logically it can work, but there might be problems like the
>> one below that I didn't notice...
> 
> One thing is that you will have lost interrupts in the meantime
> (assuming your devices are still alive). How will you make up for
> that?

I think that devices should be paused for (not only) saving interrupt states,
and in fact, that's exactly what such as VFIO devices do...

> 
>>
>>>
>>> Also, the current code assumes that VMAPP.PTZ can be advertised if a
>>> VPT is mapped for the first time. Clearly, it is unlikely that the VPT
>>> will be only populated with 0s, so you'll end up with state corruption
>>> on the first remap.
>>
>> Oh, thanks for pointing it out.
>> And if we always signal PTZ when alloc = 1, does it mean that we
>> can't remap the vPE when the VPT is not empty, thus there is no
>> chance to get the VLPI state?  Could we just assume that the VPT is
>> not empty when first mapping the vPE?
> 
> I think we should drop the setting of PTZ altogether. It is a silly
> micro-optimisation, and if the HW can't parse the VPT efficiently when
> it is empty, then the HW is pretty bad, PTZ or not.

agree :-)

Thanks,
Shenming

> 
> Thanks,
> 
> 	M.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
