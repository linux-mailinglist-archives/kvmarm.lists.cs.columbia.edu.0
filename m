Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 01066627C71
	for <lists+kvmarm@lfdr.de>; Mon, 14 Nov 2022 12:37:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F0094BB05;
	Mon, 14 Nov 2022 06:37:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Ibfc9FALRlV; Mon, 14 Nov 2022 06:37:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC4804BB04;
	Mon, 14 Nov 2022 06:37:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D4FC64BB00
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Nov 2022 06:37:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aimMozjFubNm for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Nov 2022 06:37:26 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9BF964BAFE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Nov 2022 06:37:26 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F2B6C61046;
 Mon, 14 Nov 2022 11:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5718EC433C1;
 Mon, 14 Nov 2022 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668425845;
 bh=X1WXUuEiCKYnCaSnllroe9lO9yo1oclX61iorR2hfP8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W8W7cT4G0eRhxxQtb/fG1Agad036i8WDiWbKv+7fyVCRbtdWrMK0YRAUyw3aA0cHv
 ZixjCxb6xkWxqH5vTFUokG6TPXIq7Ol4JOU4fSPj46hFKxF9o6LqvVYGAf/qIj0dRx
 fzjrxfpBWMiGe9oed60NTUh8lNzyzzztJ24pcs+XFTQKWOSURKyt2/4vkP2VMwB4hU
 2AXgwCfpB9N9TCctCLljVhTZhCWNhexgwkpNsr3ukcvsbqh3zrRDfkPWGGY5+s3sqc
 uNh4JUM9cFMn4VTneWbR/GZGzDkGHZVvYV/vwdjfN4/ZrdQ+0qVyexESqBNmYgvaoh
 sm39gLiANN6CA==
Received: from [82.3.55.76] (helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1ouXmE-005wky-Vy;
 Mon, 14 Nov 2022 11:37:23 +0000
Date: Mon, 14 Nov 2022 11:36:56 +0000
Message-ID: <878rkdvkbr.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Allow userspace to trap SMCCC
 sub-ranges
In-Reply-To: <Y27dHf+PRt+G4jNg@google.com>
References: <20221110015327.3389351-1-oliver.upton@linux.dev>
 <20221110015327.3389351-3-oliver.upton@linux.dev>
 <86o7tfov7v.wl-maz@kernel.org> <Y21pktYPLPM6eYga@google.com>
 <87fsepvqw5.wl-maz@kernel.org> <Y27dHf+PRt+G4jNg@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 82.3.55.76
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, pbonzini@redhat.com, rananta@google.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Fri, 11 Nov 2022 23:39:09 +0000,
Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> On Fri, Nov 11, 2022 at 08:26:02AM +0000, Marc Zyngier wrote:
> > On Thu, 10 Nov 2022 21:13:54 +0000, Oliver Upton <oliver.upton@linux.dev> wrote:
> > > The goal of what I was trying to get at is that either the kernel or
> > > userspace takes ownership of a range that has an ABI, but not both. i.e.
> > > you really wouldn't want some VMM or cloud provider trapping portions of
> > > KVM's vendor-specific range while still reporting a 'vanilla' ABI at the
> > > time of discovery. Same goes for PSCI, TRNG, etc.
> > 
> > But I definitely think this is one of the major use cases. For
> > example, there is value in taking PSCI to userspace in order to
> > implement a newer version of the spec, or to support sub-features that
> > KVM doesn't (want to) implement. I don't think this changes the ABI from
> > the guest perspective.
> 
> I disagree for the implications of partially trapping the 'Vendor
> Specific Hypervisor Service'. If the UID for the range still reports KVM
> but userspace decided to add some new widget, then from the guest
> perspective that widget is now part of KVM's own ABI with the guest.

But that's what I mean by "I don't think this changes the ABI from the
guest perspective". The guest cannot know who is doing the emulation
anyway, so it is userspace's duty to preserve the illusion. At the
end of the day, this is only a configuration mechanism, and it is no
different from all other configuration bits (i.e. they need to be
identical on both side for migration).

> Trapping the whole range is a bit of a hack to workaround the need for
> more complicated verification of a hypercall filter.

We already need these things for architected hypercalls. Once we have
the infrastructure, it doesn't matter anymore which range this is for.

> 
> But for everything else, I'm fine with arbitrary function filtering.
> Userspace is always welcome to shoot itself in the foot.
> 
> > pKVM also has a use case for this where userspace gets a notification
> > of the hypercall that a guest has performed to share memory.
> 
> Is that hypercall in the 'Vendor Specific Hypervisor Service' range?

Yes. It is get another KVM hypercall.

> 
> > Communication with a TEE also is on the cards, as would be a FFA
> > implementation. All of this could be implemented in KVM, or in
> > userspace, depending what users of these misfeatures want to do.
> 
> I'm very hopeful that by forwarding all of this to userspace we can get
> out of the business of implementing every darn spec that comes along.

Good luck. All the TEEs have private, home grown APIs, and every
vendor will want to implement their own crap (i.e. there is no spec).

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
