Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0127C1B495A
	for <lists+kvmarm@lfdr.de>; Wed, 22 Apr 2020 18:02:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 895294B1A2;
	Wed, 22 Apr 2020 12:02:37 -0400 (EDT)
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
	with ESMTP id 3pDQFLYUAfJF; Wed, 22 Apr 2020 12:02:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A9714B19E;
	Wed, 22 Apr 2020 12:02:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C15494B190
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 12:02:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NIxclw7z9TR for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Apr 2020 12:02:33 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AFABF4B0D4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 12:02:33 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 931AC20774;
 Wed, 22 Apr 2020 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587571352;
 bh=c4mJd8byYus85ZsVq6dYD/xxB2BiJlruuIkokhIEKR8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z+QMPPJzNk3+41X0OaGHcAW/KCZhzEDtlfz68Hfe63NKhA0eHmHvKOsKHRwfCgIhn
 gn/N+5nNLRqAEZp/A5UjMr1Og6z/8RGOdAETRurSvjNmLi7kluFG+OVW1K3eq2DMFC
 JRRCuddtCYva7c/zbgj10qJ6winkquJ56MFPFHLo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jRHpW-005YSC-Rg; Wed, 22 Apr 2020 17:02:31 +0100
MIME-Version: 1.0
Date: Wed, 22 Apr 2020 17:02:30 +0100
From: Marc Zyngier <maz@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 4/6] KVM: arm: vgic-v2: Only use the virtual state when
 userspace accesses pending bits
In-Reply-To: <5aa2acf8-e775-325c-0340-fa000a4e3513@arm.com>
References: <20200417083319.3066217-1-maz@kernel.org>
 <20200417083319.3066217-5-maz@kernel.org>
 <4133d5f2-ed0e-9c4a-8a66-953fb6bf6e70@arm.com> <20200417134140.0a901749@why>
 <7b001ee4-0a8e-d79c-1be4-563dab4ca452@arm.com> <20200420110350.675a3393@why>
 <5aa2acf8-e775-325c-0340-fa000a4e3513@arm.com>
Message-ID: <299b5f1307cff29944e5f89e307b2015@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, yuzenghui@huawei.com,
 eric.auger@redhat.com, Andre.Przywara@arm.com, julien@xen.org,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Julien Grall <julien@xen.org>, kvm@vger.kernel.org,
 Andre Przywara <Andre.Przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi James,

On 2020-04-22 16:55, James Morse wrote:
> Hi Marc,
> 
> On 20/04/2020 11:03, Marc Zyngier wrote:
>> On Fri, 17 Apr 2020 17:48:34 +0100
>> James Morse <james.morse@arm.com> wrote:

[...]

>>> (but if user-space never actually does this, then we should do the 
>>> simplest thing)
> 
> Adding printk() to this combined patch and using 'loadvm' on the qemu
> console, I see Qemu
> writing '0xffffffff' into cpending to clear all 16 SGIs. I guess it is
> 'resetting' the
> in-kernel state to replace it with the state read from disk.
> 
> 
>> A third way would be to align on what GICv3 does, which is that 
>> ISPENDR
>> is used for both setting and clearing in one go. Given that the 
>> current
>> state it broken (and has been for some time now), I'm tempted to adopt
>> the same behaviour...
> 
>> What do you think?
> 
> I think Qemu is expecting the bank of cpending writes to clear
> whatever the kernel has
> stored, so that it can replay the new state. Ignoring the cpending
> writes means the kernel
> keeps an interrupt pending if nothing else in that 64bit group was
> set. Its not what Qemu
> expects, it looks like we'd get away with it, but I don't think we 
> should do it!
> 
> I think we should let user-space write to those WI registers, and
> clearing the SGIs should clear all sources of SGI...

I'd be happy with that. Let me rework the patch, and I'll post the 
series again
shortly.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
