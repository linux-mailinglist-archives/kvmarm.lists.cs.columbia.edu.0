Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 10693692B5
	for <lists+kvmarm@lfdr.de>; Mon, 15 Jul 2019 16:38:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 92BB64A522;
	Mon, 15 Jul 2019 10:38:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uI-4f+-IYY4X; Mon, 15 Jul 2019 10:38:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BA824A4FE;
	Mon, 15 Jul 2019 10:38:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BE9034A4C1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jul 2019 10:38:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZmYb+UY6taS8 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Jul 2019 10:38:45 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 438504A389
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jul 2019 10:38:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C80BF28;
 Mon, 15 Jul 2019 07:38:44 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A613F59C;
 Mon, 15 Jul 2019 07:38:43 -0700 (PDT)
Subject: Re: [RFC v2 12/14] arm64/lib: asid: Allow user to update the context
 under the lock
To: James Morse <james.morse@arm.com>
References: <20190620130608.17230-1-julien.grall@arm.com>
 <20190620130608.17230-13-julien.grall@arm.com>
 <c5d1257c-b522-152f-cb2f-d23fd8110609@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <446cfa1a-71be-3ae2-4107-02dd0f164843@arm.com>
Date: Mon, 15 Jul 2019 15:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <c5d1257c-b522-152f-cb2f-d23fd8110609@arm.com>
Content-Language: en-US
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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



On 03/07/2019 18:35, James Morse wrote:
> Hi Julien,

Hi James,

> On 20/06/2019 14:06, Julien Grall wrote:
>> Some users of the ASID allocator (e.g VMID) will require to update the
>> context when a new ASID is generated. This has to be protected by a lock
>> to prevent concurrent modification.
>>
>> Rather than introducing yet another lock, it is possible to re-use the
>> allocator lock for that purpose. This patch introduces a new callback
>> that will be call when updating the context.
> 
> You're using this later in the series to mask out the generation from the atomic64 to
> leave just the vmid.

You are right.

> 
> Where does this concurrent modification happen? The value is only written if we have a
> rollover, and while its active the only bits that could change are the generation.
> (subsequent vCPUs that take the slow path for the same VM will see the updated generation
> and skip the new_context call)
> 
> If we did the generation filtering in update_vmid() after the call to
> asid_check_context(), what would go wrong?
> It happens more often than is necessary and would need a WRITE_ONCE(), but the vmid can't
> change until we become preemptible and another vCPU gets a chance to make its vmid active.

I think I was over cautious. Pre-filtering after asid_check_context() is equally 
fine as long as update_vttbr() is called from preemptible context.

Cheers,

-- 
Julien Grall
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
