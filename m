Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3E25A922
	for <lists+kvmarm@lfdr.de>; Wed,  2 Sep 2020 12:09:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 35EF34B24F;
	Wed,  2 Sep 2020 06:09:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9TRQx1Np6ilU; Wed,  2 Sep 2020 06:09:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CAA674B286;
	Wed,  2 Sep 2020 06:09:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 57C704B125
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Sep 2020 06:09:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dfe+Ys8FzWmK for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Sep 2020 06:09:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE4F64B281
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Sep 2020 06:09:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E238D6E;
 Wed,  2 Sep 2020 03:09:11 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF5313F66F;
 Wed,  2 Sep 2020 03:09:09 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] KVM: arm64: Add pvtime LPT support
To: Marc Zyngier <maz@kernel.org>
References: <20200817084110.2672-1-zhukeqian1@huawei.com>
 <8308f52e4c906cad710575724f9e3855@kernel.org>
 <f14cfd5b-c103-5d56-82fb-59d0371c6f21@arm.com> <87h7svm0o5.wl-maz@kernel.org>
From: Steven Price <steven.price@arm.com>
Message-ID: <75ce4c12-f0e3-32c4-604f-9745980022e0@arm.com>
Date: Wed, 2 Sep 2020 11:09:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7svm0o5.wl-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Sorry for the slow response, I've been on holiday.

On 22/08/2020 11:31, Marc Zyngier wrote:
> Hi Steven,
> 
> On Wed, 19 Aug 2020 09:54:40 +0100,
> Steven Price <steven.price@arm.com> wrote:
>>
>> On 18/08/2020 15:41, Marc Zyngier wrote:
>>> On 2020-08-17 09:41, Keqian Zhu wrote:
[...]
>>>>
>>>> Things need concern:
>>>> 1. https://developer.arm.com/docs/den0057/a needs update.
>>>
>>> LPT was explicitly removed from the spec because it doesn't really
>>> solve the problem, specially for the firmware: EFI knows
>>> nothing about this, for example. How is it going to work?
>>> Also, nobody was ever able to explain how this would work for
>>> nested virt.
>>>
>>> ARMv8.4 and ARMv8.6 have the feature set that is required to solve
>>> this problem without adding more PV to the kernel.
>>
>> Hi Marc,
>>
>> These are good points, however we do still have the situation that
>> CPUs that don't have ARMv8.4/8.6 clearly cannot implement this. I
>> presume the use-case Keqian is looking at predates the necessary
>> support in the CPU - Keqian if you can provide more details on the
>> architecture(s) involved that would be helpful.
> 
> My take on this is that it is a fictional use case. In my experience,
> migration happens across *identical* systems, and *any* difference
> visible to guests will cause things to go wrong. Errata management
> gets in the way, as usual (name *one* integration that isn't broken
> one way or another!).

Keqian appears to have a use case - but obviously I don't know the 
details. I guess Keqian needs to convince you of that.

> Allowing migration across heterogeneous hosts requires a solution to
> the errata management problem, which everyone (including me) has
> decided to ignore so far (and I claim that not having a constant timer
> frequency exposed to guests is an architecture bug).

I agree - errata management needs to be solved before LPT. Between 
restricted subsets of hosts this doesn't seem impossible, but I guess we 
should stall LPT until a credible solution is proposed. I'm certainly 
not proposing one at the moment.

>> Nested virt is indeed more of an issue - we did have some ideas around
>> using SDEI that never made it to the spec.
> 
> SDEI? Sigh... Why would SDEI be useful for NV and not for !NV?

SDEI provides a way of injecting a synchronous exception on migration - 
although that certainly isn't the only possible mechanism. For NV we 
have the problem that a guest-guest may be running at the point of 
migration. However it's not practical for the host hypervisor to provide 
the necessary table directly to the guest-guest which means the 
guest-hypervisor must update the tables before the guest-guest is 
allowed to run on the new host. The only plausible route I could see for 
this is injecting a synchronous exception into the guest (per VCPU) to 
ensure any guest-guests running are exited at migration time.

!NV is easier because we don't have to worry about multiple levels of 
para-virtualisation.

>> However I would argue that the most pragmatic approach would be to
>> not support the combination of nested virt and LPT. Hopefully that
>> can wait until the counter scaling support is available and not
>> require PV.
> 
> And have yet another set of band aids that paper over the fact that we
> can't get a consistent story on virtualization? No, thank you.
> 
> NV is (IMHO) much more important than LPT as it has a chance of
> getting used. LPT is just another tick box, and the fact that ARM is
> ready to ignore sideline a decent portion of the architecture is a
> clear sign that it hasn't been thought out.

Different people have different priorities. NV is definitely important 
for many people. LPT may also be important if you've already got a bunch 
of VMs running on machines and you want to be able to (gradually) 
replace them with newer hosts which happen to have a different clock 
frequency. Those VMs running now clearly aren't using NV.

However, I have to admit it's not me that has the use-case, so I'll 
leave it for others who might actually know the specifics to explain the 
details.

>> We are discussing (re-)releasing the spec with the LPT parts added. If
>> you have fundamental objections then please me know.
> 
> I do, see above. I'm stating that the use case doesn't really exist
> given the state of the available HW and the fragmentation of the
> architecture, and that ignoring the most important innovation in the
> virtualization architecture since ARMv7 is at best short-sighted.
> 
> Time scaling is just an instance of the errata management problem, and
> that is the issue that needs solving. Papering over part of the
> problem is not helping.

I fully agree - errata management is definitely the first step that 
needs solving. This is why I abandoned LPT originally because I don't 
have a generic solution and the testing I did involved really ugly hacks 
just to make the migration possible.

For now I propose we (again) park LPT until some progress has been made 
on errata management.

Thanks,

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
