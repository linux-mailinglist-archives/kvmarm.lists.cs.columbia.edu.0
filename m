Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2906E5EA8A
	for <lists+kvmarm@lfdr.de>; Wed,  3 Jul 2019 19:35:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B93F4A52C;
	Wed,  3 Jul 2019 13:35:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id POmJyzVQ3PCO; Wed,  3 Jul 2019 13:35:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 472754A51E;
	Wed,  3 Jul 2019 13:35:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F7EF4A4F7
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 13:35:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id paCOW9U94f8Z for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Jul 2019 13:35:28 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A56AC4A4F6
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 13:35:28 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C437344;
 Wed,  3 Jul 2019 10:35:28 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38253F718;
 Wed,  3 Jul 2019 10:35:25 -0700 (PDT)
Subject: Re: [RFC v2 12/14] arm64/lib: asid: Allow user to update the context
 under the lock
To: Julien Grall <julien.grall@arm.com>
References: <20190620130608.17230-1-julien.grall@arm.com>
 <20190620130608.17230-13-julien.grall@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <c5d1257c-b522-152f-cb2f-d23fd8110609@arm.com>
Date: Wed, 3 Jul 2019 18:35:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620130608.17230-13-julien.grall@arm.com>
Content-Language: en-GB
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Julien,

On 20/06/2019 14:06, Julien Grall wrote:
> Some users of the ASID allocator (e.g VMID) will require to update the
> context when a new ASID is generated. This has to be protected by a lock
> to prevent concurrent modification.
> 
> Rather than introducing yet another lock, it is possible to re-use the
> allocator lock for that purpose. This patch introduces a new callback
> that will be call when updating the context.

You're using this later in the series to mask out the generation from the atomic64 to
leave just the vmid.

Where does this concurrent modification happen? The value is only written if we have a
rollover, and while its active the only bits that could change are the generation.
(subsequent vCPUs that take the slow path for the same VM will see the updated generation
and skip the new_context call)

If we did the generation filtering in update_vmid() after the call to
asid_check_context(), what would go wrong?
It happens more often than is necessary and would need a WRITE_ONCE(), but the vmid can't
change until we become preemptible and another vCPU gets a chance to make its vmid active.

This thing is horribly subtle, so I'm sure I've missed something here!

I can't see where the arch code's equivalent case is. It also filters the generation out
of the atomic64 in cpu_do_switch_mm(). This happens with interrupts masked so we can't
re-schedule and set another asid as 'active'. KVM's equivalent is !preemptible.


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
