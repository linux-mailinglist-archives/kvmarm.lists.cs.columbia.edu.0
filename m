Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7241502C
	for <lists+kvmarm@lfdr.de>; Wed, 22 Sep 2021 20:53:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 12E044B103;
	Wed, 22 Sep 2021 14:53:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aas0-3NmBVqC; Wed, 22 Sep 2021 14:53:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0B134B0E6;
	Wed, 22 Sep 2021 14:53:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 277CA4A500
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 14:53:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eX1k8KIC2wou for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Sep 2021 14:53:21 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EE99149F6C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 14:53:20 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D453461107;
 Wed, 22 Sep 2021 18:53:19 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mT7Mr-00CO9Z-MC; Wed, 22 Sep 2021 19:53:17 +0100
Date: Wed, 22 Sep 2021 19:53:17 +0100
Message-ID: <875yusv3vm.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v1 3/3] KVM: arm64: Add histogram stats for handling time
 of arch specific exit reasons
In-Reply-To: <YUtyVEpMBityBBNl@google.com>
References: <20210922010851.2312845-1-jingzhangos@google.com>
 <20210922010851.2312845-3-jingzhangos@google.com>
 <87czp0voqg.wl-maz@kernel.org>
 <d16ecbd2-2bc9-2691-a21d-aef4e6f007b9@redhat.com>
 <YUtyVEpMBityBBNl@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: seanjc@google.com, pbonzini@redhat.com,
 jingzhangos@google.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, dmatlack@google.com, pshier@google.com, oupton@google.com,
 jmattson@google.com, bgardon@google.com, aaronlewis@google.com,
 venkateshs@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Aaron Lewis <aaronlewis@google.com>, KVM <kvm@vger.kernel.org>,
 Venkatesh Srinivas <venkateshs@google.com>, Peter Shier <pshier@google.com>,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>, Jim Mattson <jmattson@google.com>
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

On Wed, 22 Sep 2021 19:13:40 +0100,
Sean Christopherson <seanjc@google.com> wrote:

> Stepping back a bit, this is one piece of the larger issue of how to
> modernize KVM for hyperscale usage.  BPF and tracing are great when
> the debugger has root access to the machine and can rerun the
> failing workload at will.  They're useless for identifying trends
> across large numbers of machines, triaging failures after the fact,
> debugging performance issues with workloads that the debugger
> doesn't have direct access to, etc...

Which is why I suggested the use of trace points as kernel module
hooks to perform whatever accounting you require. This would give you
the same level of detail this series exposes.

And I'm all for adding these hooks where it matters as long as they
are not considered ABI and don't appear in /sys/debug/tracing (in
general, no userspace visibility).

The scheduler is a interesting example of this, as it exposes all sort
of hooks for people to look under the hood. No user of the hook? No
overhead, no additional memory used. I may have heard that Android
makes heavy use of this.

Because I'm pretty sure that whatever stat we expose, every cloud
vendor will want their own variant, so we may just as well put the
matter in their own hands.

I also wouldn't discount BPF as a possibility. You could perfectly
have permanent BPF programs running from the moment you boot the
system, and use that to generate your histograms. This isn't necessary
a one off, debug only solution.

> Logging is a similar story, e.g. using _ratelimited() printk to aid
> debug works well when there are a very limited number of VMs and
> there is a human that can react to arbitrary kernel messages, but
> it's basically useless when there are 10s or 100s of VMs and taking
> action on a kernel message requires a prior knowledge of the
> message.

I'm not sure logging is remotely the same. For a start, the kernel
should not log anything unless something has oopsed (and yes, I still
have some bits to clean on the arm64 side). I'm not even sure what you
would want to log. I'd like to understand the need here, because I
feel like I'm missing something.

> I'm certainly not expecting other people to solve our challenges,
> and I fully appreciate that there are many KVM users that don't care
> at all about scalability, but I'm hoping we can get the community at
> large, and especially maintainers and reviewers, to also consider
> at-scale use cases when designing, implementing, reviewing, etc...

My take is that scalability has to go with flexibility. Anything that
gets hardcoded will quickly become a burden: I definitely regret
adding the current KVM trace points, as they don't show what I need,
and I can't change them as they are ABI.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
