Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE313A158
	for <lists+kvmarm@lfdr.de>; Tue, 14 Jan 2020 08:10:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF4624AF97;
	Tue, 14 Jan 2020 02:10:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVL2AltLHjBw; Tue, 14 Jan 2020 02:10:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CBDE24B022;
	Tue, 14 Jan 2020 02:10:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEB814AF97
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jan 2020 02:10:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pL5VwBRVGdcf for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Jan 2020 02:10:30 -0500 (EST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8CE354AEBD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jan 2020 02:10:30 -0500 (EST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F2952AAD54E551A6FA5C;
 Tue, 14 Jan 2020 15:10:25 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 15:10:19 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Check hopefully the last
 DISCARD command error
To: Auger Eric <eric.auger@redhat.com>, <maz@kernel.org>
References: <20191225133014.1825-1-yuzenghui@huawei.com>
 <f9997198-c990-d638-24d0-41d6280a9d8a@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <41c88abb-433a-f87c-c858-7f2eb4c40926@huawei.com>
Date: Tue, 14 Jan 2020 15:10:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <f9997198-c990-d638-24d0-41d6280a9d8a@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: andre.przywara@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Eric,

On 2020/1/10 16:37, Auger Eric wrote:
> Hi Zenghui,
> 
> On 12/25/19 2:30 PM, Zenghui Yu wrote:
>> DISCARD command error occurs if any of the following apply:
>>
>>   - [ ... (those which we have already handled) ]
> nit: I would remove the above and simply say the discard is supposed to
> fail if the collection is not mapped to any target redistributor. If an
> ITE exists then the ite->collection is non NULL.

I think this is not always true. Let's talk about the following scenario
(a bit insane, though):

1. First map a LPI to an unmapped Collection, then ite->collection is
    non NULL and its target_addr is COLLECTION_NOT_MAPPED.

2. Then issue MAPC and unMAPC(V=0) commands on this Collection, the
    ite->collection will be NULL, see vgic_its_free_collection().

Discard the LPI mapping after "1" or "2", we will both encounter the
unmapped collection command error.

> What needs to be checked is its_is_collection_mapped().
> 
> By the way update_affinity_collection() also tests ite->collection. I
> think this is useless or do I miss something?

Yeah, I agree. We managed to invoke update_affinity_collection(,, coll),
ensure that the 'coll' can _not_ be NULL.
So '!ite->collection' is already a subcase of 'coll != ite->collection'.
We can safely get rid of it.

> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 

Thanks for that. I'll change the commit message with your suggestion and
add your R-b in v2.


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
