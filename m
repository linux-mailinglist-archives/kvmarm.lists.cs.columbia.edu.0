Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F02B3E61
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 09:17:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E8BE4C0E0;
	Mon, 16 Nov 2020 03:17:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9goCsZYcmKK2; Mon, 16 Nov 2020 03:17:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 807CF4C0DD;
	Mon, 16 Nov 2020 03:17:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F5844BFBB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 03:17:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xG+JXyPh3LB for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 03:16:57 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6581F4BD38
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 03:16:57 -0500 (EST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZMNn14dWzhb6w;
 Mon, 16 Nov 2020 16:16:41 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 16:16:45 +0800
Subject: Re: [RFC] vfio-pci/migration: Dirty logging of the Memory BAR region?
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <fd18627a-e012-1af8-9d9f-9ae8a1415258@huawei.com>
 <2825e816-9ade-07f9-19e3-ccfd57ffb568@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8f19cf24-8844-fa9b-a462-a55cf718002e@huawei.com>
Date: Mon, 16 Nov 2020 16:16:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2825e816-9ade-07f9-19e3-ccfd57ffb568@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, kvmarm@lists.cs.columbia.edu
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

On 2020/11/15 23:03, Paolo Bonzini wrote:
> On 15/11/20 15:31, Zenghui Yu wrote:
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index 71951fe4dc..0958db1a08 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -1806,7 +1806,10 @@ bool memory_region_is_ram_device(MemoryRegion *mr)
>>  uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>>  {
>>      uint8_t mask = mr->dirty_log_mask;
>> -    if (global_dirty_log && (mr->ram_block || 
>> memory_region_is_iommu(mr))) {
>> +    RAMBlock *rb = mr->ram_block;
>> +
>> +    if (global_dirty_log && ((rb && qemu_ram_is_migratable(rb)) ||
>> +                             memory_region_is_iommu(mr))) {
>>          mask |= (1 << DIRTY_MEMORY_MIGRATION);
>>      }
>>      return mask;
> 
> Yes, this makes sense.  Please send it as a patch, thanks!

Sure, I'm going to write a commit message for it.  Thanks for your
review.


Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
