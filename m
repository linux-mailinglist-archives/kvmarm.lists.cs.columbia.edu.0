Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9AE888E
	for <lists+kvmarm@lfdr.de>; Tue, 29 Oct 2019 13:45:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 358FC4A95B;
	Tue, 29 Oct 2019 08:45:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DAOKyT9Rx2A0; Tue, 29 Oct 2019 08:45:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E91804A8E8;
	Tue, 29 Oct 2019 08:45:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD48C4A59D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Oct 2019 08:45:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5QlFO7Z4Aowg for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Oct 2019 08:45:30 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 237924A534
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Oct 2019 08:45:30 -0400 (EDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5FDA78BCD0989B2D6C0A;
 Tue, 29 Oct 2019 20:45:26 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 20:45:17 +0800
Subject: Re: [PATCH 2/3] KVM: arm/arm64: vgic: Fix some comments typo
To: Marc Zyngier <maz@kernel.org>
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-3-yuzenghui@huawei.com> <86o8xzylb1.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7055e836-cdad-1cfa-66f3-fba88dad5f5b@huawei.com>
Date: Tue, 29 Oct 2019 20:45:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <86o8xzylb1.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2019/10/29 17:04, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On Tue, 29 Oct 2019 07:19:18 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> s/vgic_its_save_pending_tables/vgic_v3_save_pending_tables/
>> s/then/the/
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   include/kvm/arm_vgic.h      | 2 +-
>>   virt/kvm/arm/vgic/vgic-v3.c | 2 +-
>>   virt/kvm/arm/vgic/vgic-v4.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index 0fb240ec0a2a..01f8b3739a09 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -240,7 +240,7 @@ struct vgic_dist {
>>   	 * Contains the attributes and gpa of the LPI configuration table.
>>   	 * Since we report GICR_TYPER.CommonLPIAff as 0b00, we can share
>>   	 * one address across all redistributors.
>> -	 * GICv3 spec: 6.1.2 "LPI Configuration tables"
>> +	 * GICv3 spec "LPI Configuration tables"

Ah, this part shouldn't have been in this patch, as the description in
the commit message.
(And I remember the reason is just that, it it "6.1.1" in IHI 0069E but
"6.1.2" in some older versions.)

> 
> Why the change here? Pointing to the chapter in the spec is pretty
> helpful, given that it is 800 pages long (although it should mention
> what revision of the spec this refers to). For example, it should say
> something like "IHI 0069E 6.1.1 ...".

Yes, I agreed with you.  Marc, please feel free to drop this part,
or I can resend it with your suggestion.


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
