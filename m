Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4837F8D6A1
	for <lists+kvmarm@lfdr.de>; Wed, 14 Aug 2019 16:52:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D16364A542;
	Wed, 14 Aug 2019 10:52:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -3.291
X-Spam-Level: 
X-Spam-Status: No, score=-3.291 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2Q1p3b6zEOp; Wed, 14 Aug 2019 10:52:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 60FF34A531;
	Wed, 14 Aug 2019 10:52:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC39C4A52C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Aug 2019 10:52:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMe-FrcbrJVr for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Aug 2019 10:52:48 -0400 (EDT)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 256714A4A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Aug 2019 10:52:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1565794368; x=1597330368;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=uU2vXqQn2xE4aIoP2zRUvSscT0xOogCLYBrPAGfZQmY=;
 b=ZFqNFZbdtP2AhOvhUwcJAKKTB1PSaJQb809BZNDggEsZ0gsyA+PWMPC9
 cFU4ZRnTfJL/JU11klrb5pZ3iFFd1eN23sdoGrSSlDh+5bTtsWovWZhhv
 OPvMbfHB56HVm9WN1pXqv72rYJnhiayA+452mphCzAruzelmmp1wc46BW o=;
X-IronPort-AV: E=Sophos;i="5.64,385,1559520000"; d="scan'208";a="693828962"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO
 email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 14 Aug 2019 14:52:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS
 id 65391A21DD; Wed, 14 Aug 2019 14:52:38 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 14 Aug 2019 14:52:37 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.160.245) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 14 Aug 2019 14:52:34 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH 0/9] arm64: Stolen time support
To: Marc Zyngier <maz@kernel.org>
References: <20190802145017.42543-1-steven.price@arm.com>
 <20190803190522.5fec8f7d@why> <6789f477-8ab5-cc54-1ad2-8627917b07c9@arm.com>
 <8ca5c106-7c12-4c6e-6d81-a90f281a9894@amazon.com>
 <8636i3omnd.wl-maz@kernel.org>
From: Alexander Graf <graf@amazon.com>
Message-ID: <bda4e0f7-e5f4-32af-e998-00b6240b5260@amazon.com>
Date: Wed, 14 Aug 2019 16:52:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8636i3omnd.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D18UWA002.ant.amazon.com (10.43.160.199) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Precedence: Bulk
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, Catalin
 Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Paolo Bonzini <pbonzini@redhat.com>,
 Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
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



On 14.08.19 16:19, Marc Zyngier wrote:
> On Wed, 14 Aug 2019 14:02:25 +0100,
> Alexander Graf <graf@amazon.com> wrote:
>>
>>
>>
>> On 05.08.19 15:06, Steven Price wrote:
>>> On 03/08/2019 19:05, Marc Zyngier wrote:
>>>> On Fri,  2 Aug 2019 15:50:08 +0100
>>>> Steven Price <steven.price@arm.com> wrote:
>>>>
>>>> Hi Steven,
>>>>
>>>>> This series add support for paravirtualized time for arm64 guests and
>>>>> KVM hosts following the specification in Arm's document DEN 0057A:
>>>>>
>>>>> https://developer.arm.com/docs/den0057/a
>>>>>
>>>>> It implements support for stolen time, allowing the guest to
>>>>> identify time when it is forcibly not executing.
>>>>>
>>>>> It doesn't implement support for Live Physical Time (LPT) as there are
>>>>> some concerns about the overheads and approach in the above
>>>>> specification, and I expect an updated version of the specification to
>>>>> be released soon with just the stolen time parts.
>>>>
>>>> Thanks for posting this.
>>>>
>>>> My current concern with this series is around the fact that we allocate
>>>> memory from the kernel on behalf of the guest. It is the first example
>>>> of such thing in the ARM port, and I can't really say I'm fond of it.
>>>>
>>>> x86 seems to get away with it by having the memory allocated from
>>>> userspace, why I tend to like more. Yes, put_user is more
>>>> expensive than a straight store, but this isn't done too often either.
>>>>
>>>> What is the rational for your current approach?
>>>
>>> As I see it there are 3 approaches that can be taken here:
>>>
>>> 1. Hypervisor allocates memory and adds it to the virtual machine. This
>>> means that everything to do with the 'device' is encapsulated behind the
>>> KVM_CREATE_DEVICE / KVM_[GS]ET_DEVICE_ATTR ioctls. But since we want the
>>> stolen time structure to be fast it cannot be a trapping region and has
>>> to be backed by real memory - in this case allocated by the host kernel.
>>>
>>> 2. Host user space allocates memory. Similar to above, but this time
>>> user space needs to manage the memory region as well as the usual
>>> KVM_CREATE_DEVICE dance. I've no objection to this, but it means
>>> kvmtool/QEMU needs to be much more aware of what is going on (e.g. how
>>> to size the memory region).
>>
>> You ideally want to get the host overhead for a VM to as little as you
>> can. I'm not terribly fond of the idea of reserving a full page just
>> because we're too afraid of having the guest donate memory.
> 
> Well, reduce the amount of memory you give to the guest by one page,
> and allocate that page to the stolen time device. Problem solved!
> 
> Seriously, if you're worried about the allocation of a single page,
> you should first look at how many holes we have in the vcpu structure,
> for example (even better, with the 8.4 NV patches applied). Just
> fixing that would give you that page back *per vcpu*.

I'm worried about additional memory slots, about fragmenting the 
cachable guest memory regions, about avoidable HV taxes.

I think we need to distinguish here between the KVM implementation and 
the hypervisor/guest interface. Just because in KVM we can save overhead 
today doesn't mean that the HV interface should be built around the 
assumption that "memory is free".

> 
>>> 3. Guest kernel "donates" the memory to the hypervisor for the
>>> structure. As far as I'm aware this is what x86 does. The problems I see
>>> this approach are:
>>>
>>>    a) kexec becomes much more tricky - there needs to be a disabling
>>> mechanism for the guest to stop the hypervisor scribbling on memory
>>> before starting the new kernel.
>>
>> I wouldn't call "quiesce a device" much more tricky. We have to do
>> that for other devices as well today.
> 
> And since there is no standard way of doing it, we keep inventing
> weird and wonderful ways of doing so -- cue the terrible GICv3 LPI
> situation, and all the various hacks to keep existing IOMMU mappings
> around across firmware/kernel handovers as well as kexec.

Well, the good news here is that we don't have to keep it around ;).

> 
>>
>>>    b) If there is more than one entity that is interested in the
>>> information (e.g. firmware and kernel) then this requires some form of
>>> arbitration in the guest because the hypervisor doesn't want to have to
>>> track an arbitrary number of regions to update.
>>
>> Why would FW care?
> 
> Exactly. It doesn't care. Not caring means it doesn't know about the
> page the guest has allocated for stolen time, and starts using it for
> its own purposes. Hello, memory corruption. Same thing goes if you
> reboot into a non stolen time aware kernel.

If you reboot, you go via the vcpu reset path which clears the map, no? 
Same goes for FW entry. If you enter firmware that does not set up the 
map, you never see it.

> 
>>
>>>    c) Performance can suffer if the host kernel doesn't have a suitably
>>> aligned/sized area to use. As you say - put_user() is more expensive.
>>
>> Just define the interface to always require natural alignment when
>> donating a memory location?
>>
>>> The structure is updated on every return to the VM.
>>
>> If you really do suffer from put_user(), there are alternatives. You
>> could just map the page on the registration hcall and then leave it
>> pinned until the vcpu gets destroyed again.
> 
> put_user() should be cheap enough. It is one of the things we tend to
> optimise anyway. And yes, worse case, we pin the page.
> 
>>
>>> Of course x86 does prove the third approach can work, but I'm not sure
>>> which is actually better. Avoid the kexec cancellation requirements was
>>> the main driver of the current approach. Although many of the
>>
>> I really don't understand the problem with kexec cancellation. Worst
>> case, let guest FW set it up for you and propagate only the address
>> down via ACPI/DT. That way you can mark the respective memory as
>> reserved too.
> 
> We already went down that road with the LPI hack. I'm not going there
> again if we can avoid it. And it turn out that we can. Just allocate
> the stolen time page as a separate memblock, give it to KVM for that
> purpose.
> 
> Your suggestion of letting the guest firmware set something up only
> works if whatever you're booting after that understands it. If it
> doesn't, you're screwed.

Why? For UEFI, mark the region as reserved in the memory map. For DT, 
just mark it straight on reserved.

That said, I'm not advocating for doing it in the FW. I think this can 
be solved really easily with a simple guest driver to enable and a vcpu 
reset hook to disable the map.

> 
>> But even with a Linux only mechanism, just take a look at
>> arch/x86/kernel/kvmclock.c. All they do to remove the map is to hook
>> into machine_crash_shutdown() and machine_shutdown().
> 
> I'm not going to take something that is Linux specific. It has to work
> for all guests, at all times, whether they know about the hypervisor
> service or not.

If they don't know about the HV service, they don't register the writer, 
so they don't see corruption.

If they know about the HV service and they don't support kexec, they 
don't have to worry because a vcpu reset should also clear the map.

If they do support kexec, they already have a mechanism to quiesce devices.

So I don't understand how this is Linux specific? The question was Linux 
specific, so I answered with precedence to show that disabling on kexec 
is not all that hard :).


Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
