Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 03F613A101C
	for <lists+kvmarm@lfdr.de>; Wed,  9 Jun 2021 12:23:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96C4F40629;
	Wed,  9 Jun 2021 06:23:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkaaZ8UdOyZZ; Wed,  9 Jun 2021 06:23:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52C144086D;
	Wed,  9 Jun 2021 06:23:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1704B407A0
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 06:23:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aA5wX9V2WZWh for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Jun 2021 06:23:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CBC14402A9
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 06:23:38 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABF1F611BD;
 Wed,  9 Jun 2021 10:23:37 +0000 (UTC)
Received: from 82-132-234-177.dab.02.net ([82.132.234.177]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lqvN1-006SFR-K6; Wed, 09 Jun 2021 11:23:35 +0100
Date: Wed, 09 Jun 2021 11:23:34 +0100
Message-ID: <877dj3z68p.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 02/10] KVM: arm64: Implement initial support for
 KVM_CAP_SYSTEM_COUNTER_STATE
In-Reply-To: <20210608214742.1897483-3-oupton@google.com>
References: <20210608214742.1897483-1-oupton@google.com>
 <20210608214742.1897483-3-oupton@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 82.132.234.177
X-SA-Exim-Rcpt-To: oupton@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, pbonzini@redhat.com, seanjc@google.com,
 pshier@google.com, jmattson@google.com, dmatlack@google.com,
 ricarkol@google.com, jingzhangos@google.com, rananta@google.com,
 Alexandru.Elisei@arm.com, james.morse@arm.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Peter Shier <pshier@google.com>, Raghavendra Rao Anata <rananta@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

Hi Oliver,

Please Cc the KVM/arm64 reviewers (now added). Also, please consider
subscribing to the kvmarm mailing list so that I don't have to
manually approve your posts ;-).

On Tue, 08 Jun 2021 22:47:34 +0100,
Oliver Upton <oupton@google.com> wrote:
> 
> ARMv8 provides for a virtual counter-timer offset that is added to guest
> views of the virtual counter-timer (CNTVOFF_EL2). To date, KVM has not
> provided userspace with any perception of this, and instead affords a
> value-based scheme of migrating the virtual counter-timer by directly
> reading/writing the guest's CNTVCT_EL0. This is problematic because
> counters continue to elapse while the register is being written, meaning
> it is possible for drift to sneak in to the guest's time scale. This is
> exacerbated by the fact that KVM will calculate an appropriate
> CNTVOFF_EL2 every time the register is written, which will be broadcast
> to all virtual CPUs. The only possible way to avoid causing guest time
> to drift is to restore counter-timers by offset.

Well, the current method has one huge advantage: time can never go
backward from the guest PoV if you restore what you have saved. Yes,
time can elapse, but you don't even need to migrate to observe that.

>
> Implement initial support for KVM_{GET,SET}_SYSTEM_COUNTER_STATE ioctls
> to migrate the value of CNTVOFF_EL2. These ioctls yield precise control
> of the virtual counter-timers to userspace, allowing it to define its
> own heuristics for managing vCPU offsets.

I'm not really in favour of inventing a completely new API, for
multiple reasons:

- CNTVOFF is an EL2 concept. I'd rather not expose it as such as it
  becomes really confusing with NV (which does expose its own CNTVOFF
  via the ONE_REG interface)

- You seem to allow each vcpu to get its own offset. I don't think
  that's right. The architecture defines that all PEs have the same
  view of the counters, and an EL1 guest should be given that
  illusion.

- by having a parallel save/restore interface, you make it harder to
  reason about what happens with concurrent calls to both interfaces

- the userspace API is already horribly bloated, and I'm not overly
  keen on adding more if we can avoid it.

I'd rather you extend the current ONE_REG interface and make it modal,
either allowing the restore of an absolute value or an offset for
CNTVCT_EL0. This would also keep a consistent behaviour when restoring
vcpus. The same logic would apply to the physical offset.

As for how to make it modal, we have plenty of bits left in the
ONE_REG encoding. Pick one, and make that a "relative" attribute. This
will result in some minor surgery in the get/set code paths, but at
least no entirely new mechanism.

One question though: how do you plan to reliably compute the offset?
As far as I can see, it is subject to the same issues you described
above (while the guest is being restored, time flies), and you have
the added risk of exposing a counter going backward from a guest
perspective.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
