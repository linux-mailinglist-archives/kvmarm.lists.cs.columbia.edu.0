Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD511B0DAF
	for <lists+kvmarm@lfdr.de>; Mon, 20 Apr 2020 16:03:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E3424B144;
	Mon, 20 Apr 2020 10:03:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qehh1z+vWQXL; Mon, 20 Apr 2020 10:03:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C37B4B111;
	Mon, 20 Apr 2020 10:03:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C22104B0DD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 10:03:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dYM8aEEnDs37 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Apr 2020 10:03:22 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AAB154B0D7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 10:03:22 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 918E420722;
 Mon, 20 Apr 2020 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587391401;
 bh=GPT20fEi2/FOGz+OkWS9srVMj+Rsxisj5E5BJqEY3UU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bQ8HBwamtxiv7Lhgcap7xcBV4Jlc9CX5VQNZlpTf0yVkbH9kEl5RE8gBvInvva93g
 L4UulNBvuMdIJR8930Fx1dR/9O25nYqJSi1DKOPDBZoVX9F47jjaSRSr2uWm8H/mMg
 Nsa/xcz6YHHICI8JzH58nRHy4kE+RfdMsNOcJ3ME=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jQX15-004ttw-TP; Mon, 20 Apr 2020 15:03:20 +0100
MIME-Version: 1.0
Date: Mon, 20 Apr 2020 15:03:19 +0100
From: Marc Zyngier <maz@kernel.org>
To: "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 00/94] KVM: arm64: ARMv8.3/8.4 Nested Virtualization
 support
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED3A545C71@dggemm526-mbx.china.huawei.com>
References: <MN2PR18MB26869A6CA4E67558324F655CC5C70@MN2PR18MB2686.namprd18.prod.outlook.com>
 <06d08f904f003160a48eac3c5ab3c7ff@kernel.org>
 <678F3D1BB717D949B966B68EAEB446ED342E29B9@dggemm526-mbx.china.huawei.com>
 <86r1wus7df.wl-maz@kernel.org>
 <678F3D1BB717D949B966B68EAEB446ED3A535FCF@DGGEMM506-MBX.china.huawei.com>
 <3e84aaf8b757bc5a7685a291e54c232b@kernel.org> <20200417160602.26706917@why>
 <678F3D1BB717D949B966B68EAEB446ED3A545C71@dggemm526-mbx.china.huawei.com>
Message-ID: <dd1283e9b31fd01ac5c9f434aa00d34e@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: prime.zeng@hisilicon.com, gcherian@marvell.com,
 Dave.Martin@arm.com, alexandru.elisei@arm.com, andre.przywara@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, jintack@cs.columbia.edu,
 julien.thierry.kdev@gmail.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com, areddy3@marvell.com, gkulkarni@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, Ganapatrao Kulkarni <gkulkarni@marvell.com>,
 kvm@vger.kernel.org, andre.przywara@arm.com,
 George Cherian <gcherian@marvell.com>, linux-arm-kernel@lists.infradead.org,
 Anil Kumar Reddy H <areddy3@marvell.com>, Dave.Martin@arm.com
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

On 2020-04-18 03:49, Zengtao (B) wrote:
> -----Original Message-----
>> From: Marc Zyngier [mailto:maz@kernel.org]
>> Sent: Friday, April 17, 2020 11:06 PM
>> To: Zengtao (B)
>> Cc: George Cherian; Dave.Martin@arm.com; alexandru.elisei@arm.com;
>> andre.przywara@arm.com; christoffer.dall@arm.com;
>> james.morse@arm.com; jintack@cs.columbia.edu;
>> julien.thierry.kdev@gmail.com; kvm@vger.kernel.org;
>> kvmarm@lists.cs.columbia.edu; linux-arm-kernel@lists.infradead.org;
>> suzuki.poulose@arm.com; Anil Kumar Reddy H; Ganapatrao Kulkarni
>> Subject: Re: [PATCH v2 00/94] KVM: arm64: ARMv8.3/8.4 Nested
>> Virtualization support
>> 
>> On Thu, 16 Apr 2020 19:22:21 +0100
>> Marc Zyngier <maz@kernel.org> wrote:
>> 
>> > Hi Zengtao,
>> >
>> > On 2020-04-16 02:38, Zengtao (B) wrote:
>> > > Hi Marc:
>> > >
>> > > Got it.
>> > > Really a bit patch set :)
>> >
>> > Well, yeah... ;-)
>> >
>> > >
>> > > BTW, I have done a basic kvm unit test
>> > > git://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
>> > > And I find that after apply the patch KVM: arm64: VNCR-ize ELR_EL1,
>> > > The psci test failed for some reason, I can't understand why, this
>> > > is only the test result.(find the patch by git bisect + kvm test)
>> >
>> > That it is that mechanical, we should be able to quickly nail that one.
>> >
>> > > My platform: Hisilicon D06 board.
>> > > Linux kernel: Linux 5.6-rc6 + nv patches(some rebases)
>> > > Could you help to take a look?
>> >
>> > I'll have a look tomorrow. I'm in the middle of refactoring the series
>> > for 5.7, and things have changed quite a bit. Hopefully this isn't a VHE
>> > vs non-VHE issue.
>> 
>> So I've repeatedly tried with the current state of the NV patches[1],
>> on both an ARMv8.0 system (Seattle) and an ARMv8.2 pile of putrid junk
>> (vim3l). PSCI is pretty happy, although I can only test with at most 8
>> vcpus (GICv2 gets in the way).
>> 
>> Can you please:
>> 
>> - post the detailed error by running the PSCI unit test on its own
> I tried to trace the error, and I found in kernel function 
> kvm_mpidr_to_vcpu,
> casually, mpidr returns zero and we can't get the expected vcpu, and 
> psci
>  test failed due to this.

Can you post the exact error message from the unit test?

> And as I mentioned in my last before, the psci error is introduced by 
> the
>  patch KVM: arm64: VNCR-ize ELR_EL1.(Only test result)
> Maybe you have to try tens of times to reproduce. :)
> Deep into the patch itself, I don't find any connection between the 
> patch
> and the issue.

Me neither, and I haven't managed to reproduce your issue.

>> - test with the current state of the patches
> I test with your nv-5.7-rc1-WIP branch and latest kvm_unit_test, the
> error still exist.

How many vcpus do you create with this PSCI test?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
