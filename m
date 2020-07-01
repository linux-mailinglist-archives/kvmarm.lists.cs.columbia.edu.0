Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 086B8210AAE
	for <lists+kvmarm@lfdr.de>; Wed,  1 Jul 2020 14:01:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 862914B320;
	Wed,  1 Jul 2020 08:01:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W1hAecHdxTrO; Wed,  1 Jul 2020 08:01:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D07D4B2D3;
	Wed,  1 Jul 2020 08:01:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C1D34B2B9
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 08:01:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8IVu9EATchY for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Jul 2020 08:01:09 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C303B4B2A8
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 08:01:09 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED2A1045;
 Wed,  1 Jul 2020 05:01:09 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BBDA3F73C;
 Wed,  1 Jul 2020 05:01:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: Add workaround for Arm Cortex-A77 erratum
 1508412
To: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20200629213321.2953022-1-robh@kernel.org>
 <20200629213321.2953022-2-robh@kernel.org>
 <bfe3f27495152e4888f2ab2c02dd13a4@kernel.org>
 <20200630083618.GA13574@willie-the-truck>
From: James Morse <james.morse@arm.com>
Message-ID: <1c5f29f4-5c25-110f-8dee-6fb304c89901@arm.com>
Date: Wed, 1 Jul 2020 13:00:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200630083618.GA13574@willie-the-truck>
Content-Language: en-GB
Cc: Rob Herring <robh@kernel.org>, Jose.Marinho@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

Hi guys,

On 30/06/2020 09:36, Will Deacon wrote:
> On Tue, Jun 30, 2020 at 09:15:15AM +0100, Marc Zyngier wrote:
>> On 2020-06-29 22:33, Rob Herring wrote:
>>> On Cortex-A77 r0p0 and r1p0, a sequence of a non-cacheable or device
>>> load
>>> and a store exclusive or PAR_EL1 read can cause a deadlock.
>>>
>>> The workaround requires a DMB SY before and after a PAR_EL1 register
>>> read
>>> and the disabling of KVM. KVM must be disabled to prevent the
>>> problematic
>>> sequence in guests' EL1. This workaround also depends on a firmware
>>> counterpart to enable the h/w to insert DMB SY after load and store
>>> exclusive instructions. See the errata document SDEN-1152370 v10 [1] for
>>> more information.
> 
> Jose -- having an SMC interface to see if the firmware is holding up its
> side of the bargian would be really helpful here. There's been one in
> development for _months_ now; any update?
> 
>> This seems a bit extreme. Given that this CPU is most likely
>> used in big-little systems, there is still a bunch of CPUs
>> on which we could reliably execute guests.

(I'm guessing you don't want KVM to second guess the scheduler's placement on big.little
systems?)


>> It is also likely that people could run trusted guests.

Knowing whether the user trusts the guest not to tickle this is the piece of information
that would change what we do here.


>> I would suggest printing a big fat warning and taining the
>> kernel with TAINT_CPU_OUT_OF_SPEC, together with the required
>> DSBs in the KVM code.
> 
> Honestly, I think a TAINT is pointless here and we shouldn't be in the
> business of trying to police what people do with their systems when there's
> absolutely nothing we can do to help them. After all, they can always
> disable KVM themselves if they want to. The only sensible action you can
> take on seeing the taint is to disable the workaround to get rid of it,
> which is also the worst thing you can do! As another example, imagine if
> we had the ability to detect whether or not firmware was setting the patch
> registers. If we knew that it wasn't applying the workaround, would we
> TAINT on entering userspace? I don't think so. We'd probably just print a
> message when trying to apply the workaround, indicating that it was
> incomplete and the system may deadlock.
> 
> Finally, we have another erratum that allows guests to deadlock the system
> (Cortex-A57 832075)

Aha! Precedent.

We don't print any warning about untrusted guests in that case.


> so ultimately it's up to the person deploying the system
> to decide whether or not they can tolerate the risk of deadlock. In many
> cases, it won't be an issue, but if it is and they require KVM, then the
> part is dead in the water and Linux can't help with that.

Sure. So the plan here is to add the barriers around KVMs PAR_EL1 accesses, and get KVM to
print a warning that this platform is only suitable for trusted guests? (and do that for
A57's 832075 too).
As its a deadlock, not the guest influence/corrupting the host, I think this is fine. Not
printing a warning implies we hope anyone deploying KVM on affected silicon has read the
errata document...


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
