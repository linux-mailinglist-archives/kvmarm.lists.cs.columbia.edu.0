Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA32B98B2
	for <lists+kvmarm@lfdr.de>; Thu, 19 Nov 2020 17:58:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C356D4B567;
	Thu, 19 Nov 2020 11:58:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SLzgnKKTdEm; Thu, 19 Nov 2020 11:58:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C66D4B55A;
	Thu, 19 Nov 2020 11:58:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D5E9A4B4F6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 11:58:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h7NmOaNS2lfA for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Nov 2020 11:58:29 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C1D594B545
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 11:58:29 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7954D15AD;
 Thu, 19 Nov 2020 08:58:29 -0800 (PST)
Received: from [192.168.2.21] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 456D93F718;
 Thu, 19 Nov 2020 08:58:28 -0800 (PST)
From: James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v3 06/16] KVM: arm64: Introduce SPE primitives
To: Alexandru Elisei <alexandru.elisei@arm.com>
References: <20201027172705.15181-1-alexandru.elisei@arm.com>
 <20201027172705.15181-7-alexandru.elisei@arm.com>
Message-ID: <8939725c-0922-e147-2622-ae5f752a74fc@arm.com>
Date: Thu, 19 Nov 2020 16:58:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027172705.15181-7-alexandru.elisei@arm.com>
Content-Language: en-GB
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

Hi Alex,

On 27/10/2020 17:26, Alexandru Elisei wrote:
> KVM SPE emulation depends on the configuration option KVM_ARM_SPE and on on
> having hardware SPE support on all CPUs.

> The host driver must be
> compiled-in because we need the SPE interrupt to be enabled; it will be
> used to kick us out of the guest when the profiling buffer management
> interrupt is asserted by the GIC (for example, when the buffer is full).

Great: SPE IRQ very important...


> Add a VCPU flag to inform KVM that the guest has SPE enabled.
> 
> It's worth noting that even though the KVM_ARM_SPE config option is gated
> by the SPE host driver being compiled-in, we don't actually check that the
> driver was loaded successfully when we advertise SPE support for guests.

Eh?

> That's because we can live with the SPE interrupt being disabled. There is
> a delay between when the SPE hardware asserts the interrupt and when the
> GIC samples the interrupt line and asserts it to the CPU. If the SPE
> interrupt is disabled at the GIC level, this delay will be larger,

How does this work? Surely the IRQ needs to be enabled before it can become pending at the
CPU to kick us out of the guest...


> at most a host timer tick.

(Because the timer brings us out of the guest anyway?)


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
