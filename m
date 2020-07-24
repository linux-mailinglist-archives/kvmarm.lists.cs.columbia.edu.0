Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF4122C409
	for <lists+kvmarm@lfdr.de>; Fri, 24 Jul 2020 13:08:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C05704B43F;
	Fri, 24 Jul 2020 07:08:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SjoTMCNZP1g7; Fri, 24 Jul 2020 07:08:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7662C4B438;
	Fri, 24 Jul 2020 07:08:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 262494B435
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jul 2020 07:08:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LyhZqWH6KLhp for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Jul 2020 07:08:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E9AC04B42E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jul 2020 07:08:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BDD430E;
 Fri, 24 Jul 2020 04:08:03 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B53563F66E;
 Fri, 24 Jul 2020 04:08:02 -0700 (PDT)
Subject: Re: kvm-unit-tests: Question about the "no interrupt when timer is
 disabled" case
To: Zenghui Yu <yuzenghui@huawei.com>
References: <fd421647-6526-41dd-ef3a-c714f9d513d6@huawei.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <195f5f7b-b1a4-8c82-c5e3-aac950737ff5@arm.com>
Date: Fri, 24 Jul 2020 12:08:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fd421647-6526-41dd-ef3a-c714f9d513d6@huawei.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
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

Hi Zenghui,

I don't believe this issue can be triggered by a Linux guest. Details below.

On 7/23/20 9:56 AM, Zenghui Yu wrote:
> Hi Alexandru,
>
> I've noticed that the timer case will fail in the -stable 4.19 kernel.
> The log is as follows:
>
> FAIL: vtimer-busy-loop: no interrupt when timer is disabled
> FAIL: vtimer-busy-loop: interrupt signal no longer pending
>
> And it's because the related fix [16e604a437c8, "KVM: arm/arm64: vgic:
> Reevaluate level sensitive interrupts on enable"] hasn't been backported
> to the stable tree.

This is not an actual fix (hence no "Fixes" tag), this is more like an improvement
of the behaviour of the GIC. Like the patch description says, this can happen even
on hardware if the GIC hasn't sampled the device interrupt state (or the device
itself hasn't updated it) before the CPU re-enables the interrupt.

>
> Just out of curiosity, _without_ this fix, had you actually seen the
> guest getting into trouble due to an un-retired level-sensitive
> interrupt and your patch fixed it? Or this was found by code inspection?

This issue was found when running kvm-unit-tests on the model.

>
> Take the exact vtimer case as an example, is it possible that the Linux
> guest would disable the vtimer (the input interrupt line is driven to 0
> but the old KVM doesn't take this into account) and potentially hit this
> issue? I'm not familiar with it.

To trigger this, a guest has to do the following steps:

1. Disable the timer interrupt at the Redistributor level.
2. Trigger the timer interrupt in the timer.
3. Disable the timer entirely (CNT{P,V}_CTL_EL0.ENABLE = 0), which also disables
the timer interrupt.
4. Enable the timer interrupt at the Redistributor level.

I believe there are two reasons why this will never happen for a Linux guest:

- This isn't the way Linux handles interrupts. Furthermore, I don't believe Linux
will ever disable a specific interrupt at the irqchip level.
- The timer IRQ handler checks the ISTATUS flag in the timer control register
before handling the interrupt. The flag is unset if the timer is disabled.

I hope my explanation made sense, please chime in if I missed something or you
want more details.

Thanks,
Alex
>
> One of our internal tree is based on the stable 4.19 and I'm sure this
> fix is not included. But I havn't received any bad reports from our
> users yet. But if there's any potential problem without this fix, it'd
> good to get it properly backported. I can help to send a backport
> request if so.
>
>
> Thanks,
> Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
