Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EF3BE625535
	for <lists+kvmarm@lfdr.de>; Fri, 11 Nov 2022 09:27:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB74D4BAFB;
	Fri, 11 Nov 2022 03:27:40 -0500 (EST)
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
	with ESMTP id l2wJbNLJmK9y; Fri, 11 Nov 2022 03:27:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 808AA4BADE;
	Fri, 11 Nov 2022 03:27:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 383924BACB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Nov 2022 03:27:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QghiqRPJWOFg for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Nov 2022 03:27:36 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C80744BAC4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Nov 2022 03:27:36 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1ABF6B82455;
 Fri, 11 Nov 2022 08:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B667EC433D6;
 Fri, 11 Nov 2022 08:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668155253;
 bh=e1/d/8WJcd5q4Zo+wAS3Yn8BOJ7hTNu5U8ybWGzTWSA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z5Lo6/QxPZZi4/tmWRUwTkusz+fQQk/7gsE9/crjsG55v2Z6z08e23HfnklH6VzT2
 wChL012poapeFKpMu+BSLo9D3Oc9QG8c16Gj2j6So7CBeU0XjudS6dMeu6CQNHSkdI
 USGb3AOBLBe9RbbCaM2tXYnup+Hk8eUX9vgrng4/kGbKCLuytHFwQduzxjoENMgU0P
 m51kt2c1AI+lveMeHr9pyvpQfZV9HFFkrMlwdx/v53gCZW0zGVNGGaqAM3avyr32br
 Kj2Xewc3c9nHeDfr94d4YGc732/P00mx3+PiggLlxocooMFw/o1Nv2FcocojC8tWzq
 I3ZDnFbw/SgEA==
Received: from ip-185-104-136-29.ptr.icomera.net ([185.104.136.29]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1otPNr-005Lew-C3;
 Fri, 11 Nov 2022 08:27:31 +0000
Date: Fri, 11 Nov 2022 08:26:02 +0000
Message-ID: <87fsepvqw5.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Allow userspace to trap SMCCC
 sub-ranges
In-Reply-To: <Y21pktYPLPM6eYga@google.com>
References: <20221110015327.3389351-1-oliver.upton@linux.dev>
 <20221110015327.3389351-3-oliver.upton@linux.dev>
 <86o7tfov7v.wl-maz@kernel.org> <Y21pktYPLPM6eYga@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.104.136.29
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

On Thu, 10 Nov 2022 21:13:54 +0000,
Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> On Thu, Nov 10, 2022 at 12:22:12PM +0000, Marc Zyngier wrote:
> > > +static bool kvm_hvc_call_user_trapped(struct kvm_vcpu *vcpu, u32 func_id)
> > > +{
> > > +	struct kvm *kvm = vcpu->kvm;
> > > +	unsigned long *bmap = &kvm->arch.smccc_feat.user_trap_bmap;
> > > +
> > > +	switch (ARM_SMCCC_OWNER_NUM(func_id)) {
> > > +	case ARM_SMCCC_OWNER_ARCH:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_ARCH, bmap);
> > > +	case ARM_SMCCC_OWNER_CPU:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_CPU, bmap);
> > > +	case ARM_SMCCC_OWNER_SIP:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_SIP, bmap);
> > > +	case ARM_SMCCC_OWNER_OEM:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_OEM, bmap);
> > > +	case ARM_SMCCC_OWNER_STANDARD:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_STANDARD, bmap);
> > > +	case ARM_SMCCC_OWNER_STANDARD_HYP:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_STANDARD_HYP, bmap);
> > > +	case ARM_SMCCC_OWNER_VENDOR_HYP:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_VENDOR_HYP, bmap);
> > > +	case ARM_SMCCC_OWNER_TRUSTED_APP ... ARM_SMCCC_OWNER_TRUSTED_APP_END:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_TRUSTED_APP, bmap);
> > > +	case ARM_SMCCC_OWNER_TRUSTED_OS ... ARM_SMCCC_OWNER_TRUSTED_OS_END:
> > > +		return test_bit(KVM_ARM_USER_HYPERCALL_OWNER_TRUSTED_OS, bmap);
> > > +	default:
> > > +		return false;
> > > +	}
> > 
> > You have multiple problems here:
> > 
> > - the granularity is way too coarse. You want to express arbitrary
> >   ranges, and not necessarily grab a whole owner range.
> > 
> > - you have now an overlap between ranges that are handled in the
> >   kernel (PSCI, spectre mitigations) and ranges that userspace wants
> >   to observe. Not good.
> 
> We need to come to agreement on what degree of mix-and-match should be
> supported.
> 
> Spectre really ought to be in the kernel, and I don't think anyone is
> particularly excited about reimplementing PSCI. Right now my interest
> in this starts and ends with forwarding the vendor-specific hypercall
> range to userspace, allowing something like Hyper-V PV on KVM.
> 
> > If we are going down this road, this can only be done at the
> > *function* level. And userspace must know that the kernel will refuse
> > to forward some ranges.
> 
> The goal of what I was trying to get at is that either the kernel or
> userspace takes ownership of a range that has an ABI, but not both. i.e.
> you really wouldn't want some VMM or cloud provider trapping portions of
> KVM's vendor-specific range while still reporting a 'vanilla' ABI at the
> time of discovery. Same goes for PSCI, TRNG, etc.

But I definitely think this is one of the major use cases. For
example, there is value in taking PSCI to userspace in order to
implement a newer version of the spec, or to support sub-features that
KVM doesn't (want to) implement. I don't think this changes the ABI
from the guest perspective.

pKVM also has a use case for this where userspace gets a notification
of the hypercall that a guest has performed to share memory.

Communication with a TEE also is on the cards, as would be a FFA
implementation. All of this could be implemented in KVM, or in
userspace, depending what users of these misfeatures want to do.

> 
> > So obviously, this cannot be a simple bitmap. Making it a radix tree
> > (or an xarray, which is basically the same thing) could work. And the
> > filtering request from userspace can be similar to what we have for
> > the PMU filters.
> 
> Right, we'll need a more robust data structure for all this.
> 
> My only concern is that communicating the hypercall filter between
> user/kernel with a set of ranges or function numbers is that we could be
> mutating what KVM *doesn't* already implement into an ABI of sorts.
> 
> i.e. suppose that userspace wants to filter function(s) in an
> unallocated/unused range of function numbers. Later down the line KVM
> adds support for a new shiny thing and the filter becomes a subset of a
> now allocated range of calls. We then reject the filter due to the
> incongruence.

But isn't the problem to ask for ranges that are unallocated the first
place? What semantic can userspace give to such a thing other than
replying "not implemented", which is what the kernel would do anyway?

The more interesting problem is when you want to emulate another
hypervisor, and that the vendor spaces overlap (a very likely
outcome). Somehow, this means overriding all the KVM-specific
hypercalls, and let userspace deal with it. But again, this can be
done on a per function basis.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
