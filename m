Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4061F3B
	for <lists+kvmarm@lfdr.de>; Mon,  8 Jul 2019 15:05:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE6DE4A54F;
	Mon,  8 Jul 2019 09:05:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnTyEf2n30Gf; Mon,  8 Jul 2019 09:05:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 549A24A534;
	Mon,  8 Jul 2019 09:05:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B0714A519
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jul 2019 09:04:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pdMeL9Ak-Yrt for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Jul 2019 09:04:57 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 605834A518
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jul 2019 09:04:57 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0552B;
 Mon,  8 Jul 2019 06:04:56 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 503BA3F738; Mon,  8 Jul 2019 06:04:56 -0700 (PDT)
Subject: Re: FYI: Possible HPFAR_EL2 corruption (LPAE guests on AArch64 hosts)
To: Jon Masters <jcm@jonmasters.org>, Mark Rutland <mark.rutland@arm.com>
References: <7dd77cea-d673-269a-044f-4df269db7e5e@jonmasters.org>
 <20190708114716.GA33099@lakrids.cambridge.arm.com>
 <de6f5ca5-9485-620f-b748-9a38e9a4a0ba@jonmasters.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
 Z46HaNmN2hZS/oJ69c1DI5Rcww==
Organization: ARM Ltd
Message-ID: <57b7e837-7dba-3735-fd1f-56ded26cc98b@arm.com>
Date: Mon, 8 Jul 2019 14:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <de6f5ca5-9485-620f-b748-9a38e9a4a0ba@jonmasters.org>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
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

[Adding myself to the cc-list, for real this time! ;-)]

On 08/07/2019 13:16, Jon Masters wrote:
> Hi Mark,
> 
> Thanks for adding the CCs. See below for more.
> 
> On 7/8/19 7:47 AM, Mark Rutland wrote:
>> On Sun, Jul 07, 2019 at 11:39:46PM -0400, Jon Masters wrote:
>>> Hi all,
>>
>> Hi Jon,
>>
>> [adding Marc and the kvm-arm list]
>>
>>> TLDR: We think $subject may be a hardware errata and we are
>>> investigating. I was asked to drop a note to share my initial analysis
>>> in case others have been experiencing similar problems with 32-bit VMs.
>>>
>>> The Fedora Arm 32-bit builders run as "armv7hl+lpae" (aarch32) LPAE
>>> (VMSAv8-32 Long-descriptor table format in aarch32 execution state) VMs
>>> on AArch64 hosts. Under certain conditions, those builders will "pause"
>>> with the following obscure looking error message:
>>>
>>> kvm [10652]: load/store instruction decoding not implemented
>>>
>>> (which is caused by a fall-through in io_mem_abort, the code assumes
>>> that if we couldn't find the guest memslot we're taking an IO abort)
>>>
>>> This has been happening on and off for more than a year, tickled further
>>> by various 32-bit Fedora guest updates, leading to some speculation that
>>> there was actually a problem with guest toolchains generating
>>> hard-to-emulate complex load/store instruction sequences not handled in KVM.
>>>
>>> After extensive analysis, I believe instead that it appears on the
>>> platform we are using in Fedora that a stage 2 fault (e.g. v8.0 software
>>> access bit update in the host) taken during stage 1 guest page table
>>> walk will result in an HPFAR_EL2 truncation to a 32-bit address instead
>>> of the full 48-bit IPA in use due to aarch32 LPAE. I believe that this
>>> is a hardware errata and have requested that the vendor investigate.
>>>
>>> Meanwhile, I have a /very/ nasty patch that checks the fault conditions
>>> in kvm_handle_guest_abort and if they match (S1 PTW, etc.), does a
>>> software walk through the guest page tables looking for a PTE that
>>> matches with the lower part of the faulting address bits we did get
>>> reported to the host, then re-injects the correct fault. With this
>>> patch, the test builder stays up, albeit correcting various faults:
>>>
>>> [  143.670063] JCM: WARNING: Mismatched FIPA and PA translation detected!
>>> [  143.748447] JCM: Hyper faulting far: 0x3deb0000
>>> [  143.802808] JCM: Guest faulting far: 0xb6dce3c4 (gfn: 0x3deb)
>>> [  143.871776] JCM: Guest TTBCR: 0xb5023500, TTBR0: 0x5b06cc40
>>> [  143.938649] JCM: Guest PGD address: 0x5b06cc50
>>> [  143.991962] JCM: Guest PGD: 0x5b150003
>>> [  144.036925] JCM: Guest PMD address: 0x5b150db0
>>> [  144.090238] JCM: Guest PMD: 0x43deb0003
>>> [  144.136241] JCM: Guest PTE address: 0x43deb0e70
>>> [  144.190604] JCM: Guest PTE: 0x42000043bb72fdf
>>> [  144.242884] JCM: Manually translated as: 0xb6dce3c4->0x43bb72000
>>> [  144.314972] JCM: Faulting IPA page: 0x3deb0000
>>> [  144.368286] JCM: Faulting PTE page: 0x43deb0000
>>> [  144.422641] JCM: Fault occurred while performing S1 PTW -fixing
>>> [  144.493684] JCM: corrected fault_ipa: 0x43deb0000
>>> [  144.550133] JCM: Corrected gfn: 0x43deb
>>> [  144.596145] JCM: handle user_mem_abort
>>> [  144.641155] JCM: ret: 0x1
>>
>> When the conditions are met, does the issue continue to trigger
>> reliably?
> 
> Yeah. But only for certain faults - seems to be specifically for stage 1
> page table walks that cause a trap to stage 2.

Do we know for sure this is limited to the guest using LPAE? I
appreciate that this is the configuration you're running in, but it
would be an interesting data point to work out what is happening with
small descriptors.

> 
>> e.g. if you return to the guest without fixing the fault, do you always
>> see the truncation when taking the fault again?
> 
> I believe so, but I need to specifically check that.
> 
>> If you try the translation with an AT, does that work as expected? We've
>> had to use that elsewhere; see __populate_fault_info() in
>> arch/arm64/kvm/hyp/switch.c.
> 
> Yea, I've seen that code for the other errata :) The problem is the
> virtual address in the FAR is different from the one we ultimately have
> a PA translation for. We take a fault when the hardware walker tries to
> perform a load to (e.g.) the PTE leaf during the translation of the VA.
> So the PTE itself is what we are trying to load, not the PA of the VA
> that the guest userspace/kernel tried to load. Hence an AT won't work,
> unless I'm missing something. My first thought had been to do that.

Ah, that's the bit I was missing: S1PTW not completing in S2 because of
the access flag. Duh.

Random idea: an option (although not a desirable one) would be to change
the way we handle page aging on the host by forcing an unmap at S2
instead of twiddling the access flag. Does this change anything on your
system?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
