Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B523CB85
	for <lists+kvmarm@lfdr.de>; Wed,  5 Aug 2020 16:34:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 316BA4B81A;
	Wed,  5 Aug 2020 10:34:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id seJTyzvKJUKC; Wed,  5 Aug 2020 10:34:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 057C14B84E;
	Wed,  5 Aug 2020 10:34:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 659634B70A
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 10:34:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oia+rHVnxr-z for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Aug 2020 10:34:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B2554B6B6
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 10:34:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E96D71424;
 Wed,  5 Aug 2020 07:34:13 -0700 (PDT)
Received: from [192.168.0.57] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52D43F7D7;
 Wed,  5 Aug 2020 07:34:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: arm64: nVHE: Don't consume host SErrors with RAS
To: Andrew Scull <ascull@google.com>, kvmarm@lists.cs.columbia.edu
References: <20200730151823.1414808-1-ascull@google.com>
 <20200730151823.1414808-2-ascull@google.com>
 <20200730223144.GA2022880@google.com>
From: James Morse <james.morse@arm.com>
Message-ID: <6ecc47f3-4733-4f49-660f-f21229176efb@arm.com>
Date: Wed, 5 Aug 2020 15:34:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730223144.GA2022880@google.com>
Content-Language: en-GB
Cc: will@kernel.org, maz@kernel.org, catalin.marinas@arm.com,
 kernel-team@android.com
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

On 30/07/2020 23:31, Andrew Scull wrote:
> On Thu, Jul 30, 2020 at 04:18:23PM +0100, Andrew Scull wrote:
>> The ESB at the start of the vectors causes any SErrors to be consumed to
>> DISR_EL1. If the exception came from the host and the ESB caught an
>> SError, it would not be noticed until a guest exits and DISR_EL1 is
>> checked. Further, the SError would be attributed to the guest and not
>> the host.
>>
>> To avoid these problems, use a different exception vector for the host
>> that does not use an ESB but instead leaves any host SError pending. A
>> guest will not be entered if an SError is pending so it will always be
>> the host that will receive and handle it.

> Thinking further, I'm not sure this actually solves all of the problem.
> It does prevent hyp from causing a host SError to be consumed but, IIUC,
> there could be an SError already deferred by the host and logged in
> DISR_EL1 that hyp would not preserve if a guest is run.

I think that would be a host bug.

The ESB-instruction is the only thing that writes to DISR_EL1, and only if PSTATE.A is
set. The host should:
* Read DISR_EL1 after running the ESB-instruction,
* Not call into HYP from SError masked code!

(VHE only does it to match the nVHE behaviour, as KVM isn't prepared to handle these).


'ESB-instruction' is pedantry to avoid the risk of it being confused with IESB, which is
just the barrier bit, not the writes-to-DISR bit.


> I think the host's DISR_EL1 would need to be saved and restored in the
> vcpu context switch which, from a cursory read of the ARM, is possible
> without having to virtualize SErrors for the host.

... I thought this was a redirected register. Reads from EL1 when HCR_EL2.AMO is set get
the value from VDISR_EL2, meaning the guest can't read DISR_EL1 at all.
(see 'Accessing DISR_EL1' in the register description, "D13.7.1
DISR_EL1, Deferred Interrupt Status Register" of DDI0487F.a


>> Hyp initialization is now passed the vector that is used for the host
>> and the vector for guests is stored in a percpu variable as
>> kvm_get_hyp_vector() is not suitable for calling from nVHE hyp.


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
