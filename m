Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9F81CA5
	for <lists+kvmarm@lfdr.de>; Mon,  5 Aug 2019 15:26:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89D8B4A547;
	Mon,  5 Aug 2019 09:26:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNVXIEeBezDT; Mon,  5 Aug 2019 09:26:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A1C44A527;
	Mon,  5 Aug 2019 09:26:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 49DB64A4FB
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Aug 2019 09:26:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eJybgLvMREdT for <kvmarm@lists.cs.columbia.edu>;
 Mon,  5 Aug 2019 09:26:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E12494A4BE
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Aug 2019 09:26:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AE44337;
 Mon,  5 Aug 2019 06:26:10 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 97F263F706; Mon,  5 Aug 2019 06:26:08 -0700 (PDT)
Subject: Re: [PATCH 0/9] arm64: Stolen time support
To: Steven Price <steven.price@arm.com>
References: <20190802145017.42543-1-steven.price@arm.com>
 <20190803190522.5fec8f7d@why> <6789f477-8ab5-cc54-1ad2-8627917b07c9@arm.com>
From: Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e36e8baa-7c8b-ca95-95a7-7411599fa0b0@kernel.org>
Date: Mon, 5 Aug 2019 14:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6789f477-8ab5-cc54-1ad2-8627917b07c9@arm.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On 05/08/2019 14:06, Steven Price wrote:
> On 03/08/2019 19:05, Marc Zyngier wrote:
>> On Fri,  2 Aug 2019 15:50:08 +0100
>> Steven Price <steven.price@arm.com> wrote:
>>
>> Hi Steven,
>>
>>> This series add support for paravirtualized time for arm64 guests and
>>> KVM hosts following the specification in Arm's document DEN 0057A:
>>>
>>> https://developer.arm.com/docs/den0057/a
>>>
>>> It implements support for stolen time, allowing the guest to
>>> identify time when it is forcibly not executing.
>>>
>>> It doesn't implement support for Live Physical Time (LPT) as there are
>>> some concerns about the overheads and approach in the above
>>> specification, and I expect an updated version of the specification to
>>> be released soon with just the stolen time parts.
>>
>> Thanks for posting this.
>>
>> My current concern with this series is around the fact that we allocate
>> memory from the kernel on behalf of the guest. It is the first example
>> of such thing in the ARM port, and I can't really say I'm fond of it.
>>
>> x86 seems to get away with it by having the memory allocated from
>> userspace, why I tend to like more. Yes, put_user is more
>> expensive than a straight store, but this isn't done too often either.
>>
>> What is the rational for your current approach?
> 
> As I see it there are 3 approaches that can be taken here:
> 
> 1. Hypervisor allocates memory and adds it to the virtual machine. This
> means that everything to do with the 'device' is encapsulated behind the
> KVM_CREATE_DEVICE / KVM_[GS]ET_DEVICE_ATTR ioctls. But since we want the
> stolen time structure to be fast it cannot be a trapping region and has
> to be backed by real memory - in this case allocated by the host kernel.
> 
> 2. Host user space allocates memory. Similar to above, but this time
> user space needs to manage the memory region as well as the usual
> KVM_CREATE_DEVICE dance. I've no objection to this, but it means
> kvmtool/QEMU needs to be much more aware of what is going on (e.g. how
> to size the memory region).
> 
> 3. Guest kernel "donates" the memory to the hypervisor for the
> structure. As far as I'm aware this is what x86 does. The problems I see
> this approach are:
> 
>  a) kexec becomes much more tricky - there needs to be a disabling
> mechanism for the guest to stop the hypervisor scribbling on memory
> before starting the new kernel.
> 
>  b) If there is more than one entity that is interested in the
> information (e.g. firmware and kernel) then this requires some form of
> arbitration in the guest because the hypervisor doesn't want to have to
> track an arbitrary number of regions to update.
> 
>  c) Performance can suffer if the host kernel doesn't have a suitably
> aligned/sized area to use. As you say - put_user() is more expensive.
> The structure is updated on every return to the VM.
> 
> 
> Of course x86 does prove the third approach can work, but I'm not sure
> which is actually better. Avoid the kexec cancellation requirements was
> the main driver of the current approach. Although many of the
> conversations about this were also tied up with Live Physical Time which
> adds its own complications.

My current train of thoughts is around (2):

- We don't need a new mechanism to track pages or deal with overlapping
IPA ranges
- We can get rid of the save/restore interface

The drawback is that the amount of memory required per vcpu becomes ABI.
I don't think that's a huge deal, as the hypervisor has the same
contract with the guest.

We also take a small hit with put_user(), but this is only done as a
consequence of vcpu_load() (and not on every entry as you suggest
above). It'd be worth quantifying this overhead before making any
decision one way or another.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
