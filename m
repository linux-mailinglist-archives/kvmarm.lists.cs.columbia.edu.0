Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BCAF8C2
	for <lists+kvmarm@lfdr.de>; Wed, 11 Sep 2019 11:21:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CA384A5E5;
	Wed, 11 Sep 2019 05:21:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHiCIszZ3lEs; Wed, 11 Sep 2019 05:21:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E9D4B4A5E4;
	Wed, 11 Sep 2019 05:21:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BEE44A5A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Sep 2019 05:21:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2iEj8AO1LAK for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Sep 2019 05:21:25 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D503B4A524
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Sep 2019 05:21:24 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E6267DBB613FD0A61D59;
 Wed, 11 Sep 2019 17:21:21 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 17:21:13 +0800
Subject: Re: [PATCH 2/2] KVM: arm/arm64: Print the EC hex value with its exact
 width
To: Marc Zyngier <maz@kernel.org>
References: <1568169216-12632-1-git-send-email-yuzenghui@huawei.com>
 <1568169216-12632-3-git-send-email-yuzenghui@huawei.com>
 <86h85js083.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e013e828-5e61-8c07-510f-6cb4c59367cf@huawei.com>
Date: Wed, 11 Sep 2019 17:19:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <86h85js083.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
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

Hi Marc,

On 2019/9/11 16:31, Marc Zyngier wrote:
> On Wed, 11 Sep 2019 03:33:36 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> EC is the bits [31:26] of ESR_ELx on arm64 (HSR on arm). Print the
>> hex value with its exact width (8).
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   virt/kvm/arm/trace.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
>> index 204d210d01c2..022b0a060034 100644
>> --- a/virt/kvm/arm/trace.h
>> +++ b/virt/kvm/arm/trace.h
>> @@ -42,7 +42,7 @@ TRACE_EVENT(kvm_exit,
>>   		__entry->vcpu_pc		= vcpu_pc;
>>   	),
>>   
>> -	TP_printk("%s: HSR_EC: 0x%04x (%s), PC: 0x%08lx",
>> +	TP_printk("%s: HSR_EC: 0x%02x (%s), PC: 0x%08lx",
>>   		  __print_symbolic(__entry->ret, kvm_arm_exception_type),
>>   		  __entry->esr_ec,
>>   		  __print_symbolic(__entry->esr_ec, kvm_arm_exception_class),
> 
> Although you're right that 8 bits ought to be enough, this is a change
> to the output of the tracepoint, which userspace could (does?) parse.

Well-written userspace tools should only parse the low 8 bits (if they
do parse). But even if the high bits are parsed, they're always 0.
So I don't think this change will have a bad impact on userspace.

> I'm thus reluctant to change anything there, knowing that we don't
> lose any information, and just print two extra zeroes.

Anyway this is not a fix, feel free to ignore it if you're worried about
that there might be some issues ;)

> Am I missing anything?

No.


Thanks,
zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
