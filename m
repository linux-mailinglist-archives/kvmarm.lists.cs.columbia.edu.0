Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AE43125360B
	for <lists+kvmarm@lfdr.de>; Wed, 26 Aug 2020 19:41:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 590044BD0B;
	Wed, 26 Aug 2020 13:41:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OESQvVtfFUSF; Wed, 26 Aug 2020 13:41:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC3144BD06;
	Wed, 26 Aug 2020 13:41:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F122F4BCC1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Aug 2020 13:41:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DCOMeg1jF-E for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Aug 2020 13:41:05 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C0A694BCCB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Aug 2020 13:41:05 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717C91045;
 Wed, 26 Aug 2020 10:41:05 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009513F8C6;
 Wed, 26 Aug 2020 10:41:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: arm64: nVHE: Don't consume host SErrors with RAS
To: Andrew Scull <ascull@google.com>
References: <20200730151823.1414808-1-ascull@google.com>
 <20200730151823.1414808-2-ascull@google.com>
 <20200730223144.GA2022880@google.com>
 <6ecc47f3-4733-4f49-660f-f21229176efb@arm.com>
 <20200811145338.GB2917393@google.com>
From: James Morse <james.morse@arm.com>
Message-ID: <456017df-e0fe-12cc-beea-374825ab25f6@arm.com>
Date: Wed, 26 Aug 2020 18:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811145338.GB2917393@google.com>
Content-Language: en-GB
Cc: kernel-team@android.com, catalin.marinas@arm.com, maz@kernel.org,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

Hi Andrew,

On 11/08/2020 15:53, Andrew Scull wrote:
> On Wed, Aug 05, 2020 at 03:34:11PM +0100, James Morse wrote:
>> On 30/07/2020 23:31, Andrew Scull wrote:
>>> On Thu, Jul 30, 2020 at 04:18:23PM +0100, Andrew Scull wrote:
>>>> The ESB at the start of the vectors causes any SErrors to be consumed to
>>>> DISR_EL1. If the exception came from the host and the ESB caught an

>>> I think the host's DISR_EL1 would need to be saved and restored in the
>>> vcpu context switch which, from a cursory read of the ARM, is possible
>>> without having to virtualize SErrors for the host.
>>
>> ... I thought this was a redirected register. Reads from EL1 when HCR_EL2.AMO is set get
>> the value from VDISR_EL2, meaning the guest can't read DISR_EL1 at all.
>> (see 'Accessing DISR_EL1' in the register description, "D13.7.1
>> DISR_EL1, Deferred Interrupt Status Register" of DDI0487F.a

> The host doesn't run with HCR_EL2.AMO set so it uses DISR_EL1 directly,
> but hyp also uses DISR_EL1 directly during __guest_exit. That is the
> clobbering I was concerned about. It may not be a problem most of the
> time given what you said above, but I think something like the diff
> below should be enough to be sure it is preserved:

On guest-exit, can't we just clobber the register, and make it the hosts problem to ensure
it always cleared it after use? (as it does today).

Save restore here is extra work to do all the time, to preserve a value the the host
should never need anyway.

I think this is just another weird case where the host really isn't like a vcpu.


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
