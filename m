Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8B718216BF9
	for <lists+kvmarm@lfdr.de>; Tue,  7 Jul 2020 13:47:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1772D4B16D;
	Tue,  7 Jul 2020 07:47:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IX865mTVmJWz; Tue,  7 Jul 2020 07:47:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A66B74B14F;
	Tue,  7 Jul 2020 07:47:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 27D414B110
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jul 2020 07:47:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqIuQEoEUL9x for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Jul 2020 07:47:31 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D13EC4B10C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jul 2020 07:47:31 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1540E1FB;
 Tue,  7 Jul 2020 04:47:31 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0B733F71E;
 Tue,  7 Jul 2020 04:47:29 -0700 (PDT)
Subject: Re: [PATCH v3 00/17] KVM: arm64: Preliminary NV patches
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20200706125425.1671020-1-maz@kernel.org>
 <c5cd34b2-3360-e634-fe0f-9bbb91275235@arm.com>
Message-ID: <45c17750-1cc2-9a44-9b71-55481870f522@arm.com>
Date: Tue, 7 Jul 2020 12:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5cd34b2-3360-e634-fe0f-9bbb91275235@arm.com>
Content-Language: en-US
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>
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

Hi,

On 7/7/20 12:24 PM, Alexandru Elisei wrote:
> Hi,
>
> On 7/6/20 1:54 PM, Marc Zyngier wrote:
>> Hi all,
>>
>> In order not to repeat the 90+ patch series that resulted in a
>> deafening silence last time, I've extracted a smaller set of patches
>> that form the required dependencies that allow the rest of the 65 NV
>> patches to be added on top. Yes, it is that bad.
>>
>> The one real feature here is support for the ARMv8.4-TTL extension at
>> Stage-2 only. The reason to support it is that it helps the hypervisor
>> a lot when it comes to finding out how much to invalidate. It is thus
>> always "supported" with NV.
>>
>> The rest doesn't contain any functionality change. Most of it reworks
>> existing data structures and adds new accessors for the things that
>> get moved around. The reason for this is that:
>>
>> - With NV, we end-up with multiple Stage-2 MMU contexts per VM instead
>>   of a single one. This requires we divorce struct kvm from the S2 MMU
>>   configuration. Of course, we stick with a single MMU context for now.
>>
>> - With ARMv8.4-NV, a number of system register accesses are turned
>>   into memory accesses into the so-called VNCR page. It is thus
>>   convenient to make this VNCR page part of the vcpu context and avoid
>>   copying data back and forth. For this to work, we need to make sure
>>   that all the VNCR-aware sysregs are moved into our per-vcpu sys_regs
>>   array instead of leaving in other data structures (the timers, for
>>   example). The VNCR page itself isn't introduced with these patches.
>>
>> - As some of these data structures change, we need a way to isolate
>>   the userspace ABI from such change.
>>
>> There is also a number of cleanups that were in the full fat series
>> that I decided to move early to get them out of the way.
>>
>> The whole this is a bit of a mix of vaguely unrelated "stuff", but it
>> all comes together if you look at the final series. This applies on
>> top of David Brazdil's series splitting the VHE and nVHE objects.
>>
>> I plan on taking this early into v5.9, and I really mean it this time!
>>
>> Catalin: How do you want to proceed for patches 2, 3, and 4? I could
>> make a stable branch that gets you pull into the arm64 tree, or the
>> other way around. Just let me know.
>>
>> Thanks,
>>
>> 	M.
>>
>> * From v2:
>>   - Rebased on top of David's el2-obj series
> I tried to apply the patches on top of v5.8-rc1, but I get a conflict on the very
> first patch. I guess it's because I don't have the el2-obj series. Is that v4 of
> "Split off nVHE hyp code" patches from David Brazil?

Nevermind, figured it out and used your kvm-arm64/el2-obj-4.1 branch as a base.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
