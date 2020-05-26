Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D1DAA19AC0D
	for <lists+kvmarm@lfdr.de>; Wed,  1 Apr 2020 14:52:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E3A94B0D3;
	Wed,  1 Apr 2020 08:52:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrswLB6YtuVT; Wed,  1 Apr 2020 08:52:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 126C14A551;
	Wed,  1 Apr 2020 08:52:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 655474A551
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 08:52:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ed4NjpmTCAcd for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Apr 2020 08:52:42 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BF67D4A531
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 08:52:41 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 59BA9BD97E6FA23F202D;
 Wed,  1 Apr 2020 20:52:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 20:52:22 +0800
Subject: Re: [PATCH] KVM: arm64: vgic-v3: Clear pending bit in guest memory
 after synchronization
To: Marc Zyngier <maz@kernel.org>
References: <20200331031245.1562-1-yuzenghui@huawei.com>
 <20200331090709.17d2087d@why>
 <fe30a834-fdb0-e1ca-5e4a-0c7863236c5f@huawei.com>
 <20200401112757.6716cbf3@why>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bb59df5a-be43-1132-e78a-3c6b354694d6@huawei.com>
Date: Wed, 1 Apr 2020 20:52:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200401112757.6716cbf3@why>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: andre.przywara@arm.com, linux-kernel@vger.kernel.org,
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

On 2020/4/1 18:27, Marc Zyngier wrote:

>>> And I think there is a similar issue in vgic_v3_lpi_sync_pending_status().
>>> Why sync something back from the pending table when the LPI wasn't
>>> mapped yet?
>>
>> vgic_v3_lpi_sync_pending_status() can be called on the ITE restore path:
>> vgic_its_restore_ite/vgic_add_lpi/vgic_v3_lpi_sync_pending_status.
>> We should rely on it to sync the pending bit from guest memory (which
>> was saved on the source side).
> 
> The fact that we have *two* paths to restore pending bits is pretty
> annoying. There is certainly some scope for simplification here.

One thing need to be clarified first (if we're going to do some 
simplification here) is that if we follow the "ITS Restore Sequence"
rule (in Documentation/virt/kvm/devices/arm-vgic-its.rst, which says
that all redistributors are restored *before* ITS table data), then
the pending bits will *only* be restored on the ITE restore path.

When we're restoring the GICR_CTLR, we invoke vgic_enable_lpis()->
its_sync_lpi_pending_table(). But since no LPI has been restored yet,
we will get an empty lpi_list snapshot from vgic_copy_lpi_list().
No pending table synchronization will happen on this path.

I think this is what we have in the current code.


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
