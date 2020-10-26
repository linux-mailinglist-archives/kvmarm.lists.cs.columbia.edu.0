Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BBE612988D0
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 09:55:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 549584B38F;
	Mon, 26 Oct 2020 04:55:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BXyvGYvFxfr6; Mon, 26 Oct 2020 04:55:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1ACFF4B3C2;
	Mon, 26 Oct 2020 04:55:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5228F4B38D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 04:55:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57vtf7TrCdmS for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 04:55:28 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4BD834B38C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 04:55:28 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18ED82242A;
 Mon, 26 Oct 2020 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603702527;
 bh=0AQLbU4PmLOdIQmrKNxHvxVbWNPNxMURUiD8Vm9U/yo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Wp7kCm4UMZKrNAwr+uJU01I9oXa+GnBqC59htF77K5v/C86wJOW/Le7+SyszbL647
 TzrShXQ0xfVIL+78gZ+j2rZrZPJsRaaVWYOJiAZ21ygcdrwzfbdeVO4KhxQdmoGmDg
 otJBllCCAOJRGxLJY3pjZwjnR9A9SSIKy7MB6z+Y=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kWyHl-004GvP-3A; Mon, 26 Oct 2020 08:55:25 +0000
MIME-Version: 1.0
Date: Mon, 26 Oct 2020 08:55:25 +0000
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 3/3] KVM: arm64: Failback on unsupported huge page sizes
In-Reply-To: <74539016-f41f-c6a0-5c37-034204dc00cc@redhat.com>
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-4-gshan@redhat.com> <87y2juoa2s.wl-maz@kernel.org>
 <74539016-f41f-c6a0-5c37-034204dc00cc@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <baa5b87f4fe72163c3e16f7411a0ef46@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, will@kernel.org, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
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

On 2020-10-25 23:04, Gavin Shan wrote:
> Hi Marc,
> 
> On 10/25/20 9:48 PM, Marc Zyngier wrote:
>> On Sun, 25 Oct 2020 01:27:39 +0100,
>> Gavin Shan <gshan@redhat.com> wrote:
>>> 
>>> The huge page could be mapped through multiple contiguous PMDs or 
>>> PTEs.
>>> The corresponding huge page sizes aren't supported by the page table
>>> walker currently.
>>> 
>>> This fails the unsupported huge page sizes to the near one. 
>>> Otherwise,
>>> the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
>>> fail back to PMD_SHIFT and PAGE_SHIFT separately.
>>> 
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/mmu.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>> 
>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>> index 0f51585adc04..81cbdc368246 100644
>>> --- a/arch/arm64/kvm/mmu.c
>>> +++ b/arch/arm64/kvm/mmu.c
>>> @@ -793,12 +793,20 @@ static int user_mem_abort(struct kvm_vcpu 
>>> *vcpu, phys_addr_t fault_ipa,
>>>   		vma_shift = PMD_SHIFT;
>>>   #endif
>>>   +	if (vma_shift == CONT_PMD_SHIFT)
>>> +		vma_shift = PMD_SHIFT;
>>> +
>>>   	if (vma_shift == PMD_SHIFT &&
>>>   	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
>>>   		force_pte = true;
>>>   		vma_shift = PAGE_SHIFT;
>>>   	}
>>>   +	if (vma_shift == CONT_PTE_SHIFT) {
>>> +		force_pte = true;
>>> +		vma_shift = PAGE_SHIFT;
>>> +	}
>>> +
>>>   	vma_pagesize = 1UL << vma_shift;
>>>   	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
>>>   		fault_ipa &= ~(vma_pagesize - 1);
>> 
>> Yup, nice catch. However, I think we should take this opportunity to
>> rationalise the logic here, and catch future discrepancies (should
>> someone add contiguous PUD or something similarly silly). How about
>> something like this (untested):
>> 
> 
> Yeah, I started the work to support contiguous PMDs/PTEs, but I'm not
> sure when I can post the patches for review as my time becomes a bit
> fragmented recently. At least, I need focus on "async page fault" in
> the coming weeks :)
> 
> Thanks for the suggested code and it worked for me. I'll post v2 to
> integrate them. However, I would like to drop PATCH[1] and PATCH[2]
> as I really don't have strong reasons to have them.

Yes, please drop these patches, and focus on the actual bug fix.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
