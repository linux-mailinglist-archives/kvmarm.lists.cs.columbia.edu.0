Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0953D5E7D05
	for <lists+kvmarm@lfdr.de>; Fri, 23 Sep 2022 16:28:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 426F440F93;
	Fri, 23 Sep 2022 10:28:51 -0400 (EDT)
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
	with ESMTP id epdc6LFOOvWz; Fri, 23 Sep 2022 10:28:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 003DB40E62;
	Fri, 23 Sep 2022 10:28:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9549440C0A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Sep 2022 10:28:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CAhvEK4DirzP for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Sep 2022 10:28:47 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5309540B6C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Sep 2022 10:28:47 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 36608B826A6;
 Fri, 23 Sep 2022 14:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD072C433D6;
 Fri, 23 Sep 2022 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663943322;
 bh=XdwAQ7r76Ceyap/NQFs1/P5fXYkQaKma7S1I8J/xUX4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lqJnEk+JX8DogYeTRJh2XxVetLFAYZu04lq7o2wNzBVw54qt6cueE4ZwNM8XzlPVH
 VJFw5eAqu8V5U+eCik4OTqEKvmSN9PqrQ4H7ThVGqTph+LJjCyb8IcCHLbo06ARvIY
 qBOWjBDOvgm80XhOSwvuWVWRFGE5MGy/4XXp/DJx5XxeskUBTauD1Id5Ma9/XKG2e6
 gGNN/LOMajCXBwmQcwuvZe3BeoZ5O9uDg8BYFHqwSK5QbjLtpNWyizxmmq/RRz/Qey
 pO3WxJka+h6f6udujauK4bZED8SZATPUOFqBssHMypgm+aGllj1DvfROXKUw67ECa1
 4wNMdSE5iAijg==
Received: from [82.141.251.28] (helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1objfU-00CAnA-LE;
 Fri, 23 Sep 2022 15:28:40 +0100
Date: Fri, 23 Sep 2022 15:28:34 +0100
Message-ID: <87czbmjhbh.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/6] KVM: Add KVM_CAP_DIRTY_LOG_RING_ORDERED capability
 and config option
In-Reply-To: <YyzYI/bvp/JnbcxS@xz-m1.local>
References: <20220922170133.2617189-1-maz@kernel.org>
 <20220922170133.2617189-3-maz@kernel.org>
 <YyzYI/bvp/JnbcxS@xz-m1.local>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 82.141.251.28
X-SA-Exim-Rcpt-To: peterx@redhat.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, catalin.marinas@arm.com, bgardon@google.com,
 shuah@kernel.org, andrew.jones@linux.dev, will@kernel.org, dmatlack@google.com,
 pbonzini@redhat.com, zhenyzha@redhat.com, shan.gavin@gmail.com,
 gshan@redhat.com, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, oliver.upton@linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 will@kernel.org, shan.gavin@gmail.com, bgardon@google.com, dmatlack@google.com,
 pbonzini@redhat.com, zhenyzha@redhat.com, shuah@kernel.org,
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

On Thu, 22 Sep 2022 22:48:19 +0100,
Peter Xu <peterx@redhat.com> wrote:
> 
> On Thu, Sep 22, 2022 at 06:01:29PM +0100, Marc Zyngier wrote:
> > In order to differenciate between architectures that require no extra
> > synchronisation when accessing the dirty ring and those who do,
> > add a new capability (KVM_CAP_DIRTY_LOG_RING_ORDERED) that identify
> > the latter sort. TSO architectures can obviously advertise both, while
> > relaxed architectures most only advertise the ORDERED version.
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  include/linux/kvm_dirty_ring.h |  6 +++---
> >  include/uapi/linux/kvm.h       |  1 +
> >  virt/kvm/Kconfig               | 14 ++++++++++++++
> >  virt/kvm/Makefile.kvm          |  2 +-
> >  virt/kvm/kvm_main.c            | 11 +++++++++--
> >  5 files changed, 28 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
> > index 906f899813dc..7a0c90ae9a3f 100644
> > --- a/include/linux/kvm_dirty_ring.h
> > +++ b/include/linux/kvm_dirty_ring.h
> > @@ -27,7 +27,7 @@ struct kvm_dirty_ring {
> >  	int index;
> >  };
> >  
> > -#ifndef CONFIG_HAVE_KVM_DIRTY_RING
> > +#ifndef CONFIG_HAVE_KVM_DIRTY_LOG
> 
> s/LOG/LOG_RING/ according to the commit message? Or the name seems too
> generic.

The commit message talks about the capability, while the above is the
config option. If you find the names inappropriate, feel free to
suggest alternatives (for all I care, they could be called FOO, BAR
and BAZ).

> Pure question to ask: is it required to have a new cap just for the
> ordering?  IIUC if x86 was the only supported anyway before, it means all
> released old kvm binaries are always safe even without the strict
> orderings.  As long as we rework all the memory ordering bits before
> declaring support of yet another arch, we're good.  Or am I wrong?

Someone will show up with an old userspace which probes for the sole
existing capability, and things start failing subtly. It is quite
likely that the userspace code is built for all architectures, and we
want to make sure that userspace actively buys into the new ordering
requirements. A simple way to do this is to expose a new capability,
making the new requirement obvious. Architectures with relaxed
ordering semantics will only implement the new one, while x86 will
implement both.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
