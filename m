Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DA86033AEF6
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 10:40:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 645DF4B560;
	Mon, 15 Mar 2021 05:40:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MjACAKSdsaYM; Mon, 15 Mar 2021 05:40:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3976E4B525;
	Mon, 15 Mar 2021 05:40:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D2844B4A9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 05:40:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qow89hsAcB3s for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 05:40:26 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D4B54B4A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 05:40:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615801226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIA9uAdrAsc0WNE5pHXgO80SUEbsiEpbQtctUapRlUU=;
 b=ekdSpY30SWlYQ+QrXUX/jZF8/AQVwjnsBFXcgniniPmiiZv/KFSFX2eh7isWE9nQ2SAAUt
 5U0EwaXv5lbUhdirleVClpG2mYxX8x7iB1LCKexc9QwSXMtXLQRtkYnDmFFPbpOfw0XfeJ
 vZy4Do3dnugzDvHKcUvgtPew1e1up6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-npB8E8JqPrW9mu9ad9xpXA-1; Mon, 15 Mar 2021 05:40:24 -0400
X-MC-Unique: npB8E8JqPrW9mu9ad9xpXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 682228710F1;
 Mon, 15 Mar 2021 09:40:22 +0000 (UTC)
Received: from [10.64.54.175] (vpn2-54-175.bne.redhat.com [10.64.54.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B66F6627DD;
 Mon, 15 Mar 2021 09:40:19 +0000 (UTC)
Subject: Re: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
To: Marc Zyngier <maz@kernel.org>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-3-gshan@redhat.com> <87eeggg5nt.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <86cd410a-d62c-9023-7371-a9d178bfafc1@redhat.com>
Date: Mon, 15 Mar 2021 20:40:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87eeggg5nt.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: will@kernel.org, kvmarm@lists.cs.columbia.edu, shan.gavin@gmail.com,
 linux-kernel@vger.kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

On 3/15/21 7:52 PM, Marc Zyngier wrote:
> On Mon, 15 Mar 2021 04:18:42 +0000,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> find_vma_intersection() has been existing to search the intersected
>> vma. This uses the function where it's applicable, to simplify the
>> code.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 84e70f953de6..286b603ed0d3 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -421,10 +421,11 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>>   	 *     +--------------------------------------------+
>>   	 */
>>   	do {
>> -		struct vm_area_struct *vma = find_vma(current->mm, hva);
>> +		struct vm_area_struct *vma;
>>   		hva_t vm_start, vm_end;
>>   
>> -		if (!vma || vma->vm_start >= reg_end)
>> +		vma = find_vma_intersection(current->mm, hva, reg_end);
> 
> For context, here's the definition of find_vma_intersection():
> 
> <quote>
> static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * mm, unsigned long start_addr, unsigned long end_addr)
> {
> 	struct vm_area_struct * vma = find_vma(mm,start_addr);
> 
> 	if (vma && end_addr <= vma->vm_start)
> 		vma = NULL;
> 	return vma;
> }
> </quote>
> 
> It seems that there is a boundary issue in either the old code or the
> new one in the case where (reg_end == vma->start).
> 
> Which one is which?
> 

The old and new code is interchangeable, meaning "reg_end == vma->start"
is invalid in both cases. So if there is a boundary issue, the old and new
code should have same issue.

According to the code, "reg_end == vma->start" is invalid. So I don't see
there is a boundary issue. Hopefully, I don't miss anything :)

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
