Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3A252263145
	for <lists+kvmarm@lfdr.de>; Wed,  9 Sep 2020 18:04:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B316C4B29F;
	Wed,  9 Sep 2020 12:04:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iUE-FZXxrasF; Wed,  9 Sep 2020 12:04:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CE294B2D5;
	Wed,  9 Sep 2020 12:04:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A7AB4B281
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 12:04:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Os8auepwel9 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Sep 2020 12:04:19 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F78E4B26E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 12:04:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27522101E;
 Wed,  9 Sep 2020 09:04:19 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC103F66E;
 Wed,  9 Sep 2020 09:04:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Andrew Jones <drjones@redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <857566df-1b98-84f7-9268-d092722dc749@arm.com>
Date: Wed, 9 Sep 2020 17:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
Content-Language: en-GB
Cc: Peter Maydell <Peter.Maydell@arm.com>, Juan Quintela <quintela@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
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

On 09/09/2020 16:25, Andrew Jones wrote:
> On Fri, Sep 04, 2020 at 05:00:16PM +0100, Steven Price wrote:
>> Arm's Memory Tagging Extension (MTE) adds 4 bits of tag data to every 16
>> bytes of memory in the system. This along with stashing a tag within the
>> high bit of virtual addresses allows runtime checking of memory
>> accesses.
>>
>> These patches add support to KVM to enable MTE within a guest. They are
>> based on Catalin's v9 MTE user-space support series[1].
>>
>> I'd welcome feedback on the proposed user-kernel ABI. Specifically this
>> series currently:
>>
>     0. Feature probing
> 
> Probably a KVM cap, rather than requiring userspace to attempt VCPU
> features one at a time with a scratch VCPU.

Ah, good point - thanks for pointing that out.

>>   1. Requires the VMM to enable MTE per-VCPU.
> 
> I suppose. We're collecting many features that are enabling CPU features,
> so they map nicely to VCPU features, yet they're effectively VM features
> due to a shared resource such as an irq or memory.

Yeah this is a little weird I'll admit. The architectural feature is 
described per-CPU (well "processing element"), but it makes little sense 
to have it only on some CPUs and has effects on the rest of the memory 
system. Given that it's theoretically possible to build e.g. a 
big.LITTLE setup with only some CPUs support MTE it seemed more 
future-proof to design the API to allow it even though I hope no-one 
will use it.

>>   2. Automatically promotes (normal host) memory given to the guest to be
>>      tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
>>      tags are cleared if the memory wasn't previously MTE enabled.
> 
> Shouldn't this be up to the guest? Or, is this required in order for the
> guest to use tagging at all. Something like making the guest IPAs memtag
> capable, but if the guest doesn't enable tagging then there is no guest
> impact? In any case, shouldn't userspace be the one that adds PROT_MTE
> to the memory regions it wants the guest to be able to use tagging with,
> rather than KVM adding the attribute page by page?

I think I've probably explained this badly.

The guest can choose how to populate the stage 1 mapping - so can choose 
which parts of memory are accessed tagged or not. However, the 
hypervisor cannot restrict this in stage 2 (except by e.g. making the 
memory uncached but that's obviously not great - however devices forward 
to the guest can be handled like this).

Because the hypervisor cannot restrict the guest's access to the tags, 
the hypervisor must assume that all memory given to the guest could have 
the tags accessed. So it must (a) clear any stale data from the tags, 
and (b) ensure that the tags are preserved (e.g. when swapping pages out).

Because of the above the current series automatically sets PG_mte_tagged 
on the pages. Note that this doesn't change the mappings that the VMM 
has (a non-PROT_MTE mapping will still not have access to the tags).

It's a shame that the stage-2 can't usefully restrict tag access, but 
this matches the architectural expectation: that if MTE is supported 
then all standard memory will be MTE-enabled.

>>   3. Doesn't provide any new methods for the VMM to access the tags on
>>      memory.
>>
>> (2) and (3) are particularly interesting from the aspect of VM migration.
>> The guest is able to store/retrieve data in the tags (presumably for the
>> purpose of tag checking, but architecturally it could be used as just
>> storage). This means that when migrating a guest the data needs to be
>> transferred (or saved/restored).
>>
>> MTE tags are controlled by the same permission model as normal pages
>> (i.e. a read-only page has read-only tags), so the normal methods of
>> detecting guest changes to pages can be used. But this would also
>> require the tags within a page to be migrated at the same time as the
>> data (since the access control for tags is the same as the normal data
>> within a page).
>>
>> (3) may be problematic and I'd welcome input from those familiar with
>> VMMs. User space cannot access tags unless the memory is mapped with the
>> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
>> for the user space process (assuming the VMM enables tag checking for
>> the process) and since the tags in memory are controlled by the guest
>> it's unlikely the VMM would have an appropriately tagged pointer for its
>> access. This means the VMM would either need to maintain two mappings of
>> memory (one to access tags, the other to access data) or disable tag
>> checking during the accesses to data.
> 
> If userspace needs to write to guest memory then it should be due to
> a device DMA or other specific hardware emulation. Those accesses can
> be done with tag checking disabled.

Yes, the question is can the VMM (sensibly) wrap the accesses with a 
disable/renable tag checking for the process sequence. The alternative 
at the moment is to maintain a separate (untagged) mapping for the 
purpose which might present it's own problems.

>>
>> If it's not practical to either disable tag checking in the VMM or
>> maintain multiple mappings then the alternatives I'm aware of are:
>>
>>   * Provide a KVM-specific method to extract the tags from guest memory.
>>     This might also have benefits in terms of providing an easy way to
>>     read bulk tag data from guest memory (since the LDGM instruction
>>     isn't available at EL0).
> 
> Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> the tags for all addresses of each dirty page.

Certainly possible, although it seems to conflate two operations: "get 
list of dirty pages", "get tags from page". It would also require a lot 
of return space (size of slot/32).

>>   * Provide support for user space setting the TCMA0 or TCMA1 bits in
>>     TCR_EL1. These would allow the VMM to generate pointers which are not
>>     tag checked.
> 
> So this is necessary to allow the VMM to keep tag checking enabled for
> itself, plus map guest memory as PROT_MTE, and write to that memory when
> needed?

This is certainly one option. The architecture provides two "magic" 
values (all-0s and all-1s) which can be configured using TCMAx to be 
treated differently. The VMM could therefore construct pointers to 
otherwise tagged memory which would be treated as untagged.

However, Catalin's user space series doesn't at the moment expose this 
functionality.

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
