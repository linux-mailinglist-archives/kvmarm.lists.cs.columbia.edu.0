Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF6C591125
	for <lists+kvmarm@lfdr.de>; Fri, 12 Aug 2022 15:05:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F26B4EFEC;
	Fri, 12 Aug 2022 09:05:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYp+--wptMiU; Fri, 12 Aug 2022 09:05:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 485D04F028;
	Fri, 12 Aug 2022 09:05:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CAB9D4F018
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Aug 2022 09:05:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kGvgBVfyNqSk for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Aug 2022 09:05:05 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CB6EE4EFEC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Aug 2022 09:05:05 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3648106F;
 Fri, 12 Aug 2022 06:05:05 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 381053F70D;
 Fri, 12 Aug 2022 06:05:04 -0700 (PDT)
Date: Fri, 12 Aug 2022 14:05:45 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Subject: Re: KVM/arm64: SPE: Translate VA to IPA on a stage 2 fault instead
 of pinning VM memory
Message-ID: <YvZQKXtRpptpaWAI@monolith.localdoman>
References: <Yl6+JWaP+mq2Nc0b@monolith.localdoman>
 <20220419141012.GB6143@willie-the-truck>
 <Yt5nFAscgrRGNGoH@monolith.localdoman>
 <20220801170055.GB26471@willie-the-truck>
 <YujzE33aPSD22wvY@monolith.localdoman>
 <Yul8UBoDcy6GQddq@google.com>
 <YvJowFt+U/qCqNVV@monolith.localdoman>
 <YvKq1IK7T/nGSKpt@google.com>
 <YvN8VvqvutZ4ti8g@monolith.localdoman>
 <YvPOBPZa2/cHombZ@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvPOBPZa2/cHombZ@google.com>
Cc: maz@kernel.org, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Oliver,

Just a note, for some reason some of your emails, but not all, don't show up in
my email client (mutt). That's why it might take me a while to send a reply
(noticed that you replied by looking for this thread on lore.kernel.org).

On Wed, Aug 10, 2022 at 10:25:56AM -0500, Oliver Upton wrote:
> On Wed, Aug 10, 2022 at 10:37:26AM +0100, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Tue, Aug 09, 2022 at 01:43:32PM -0500, Oliver Upton wrote:
> > > Hi Alex,
> > > 
> > > On Tue, Aug 09, 2022 at 03:01:36PM +0100, Alexandru Elisei wrote:
> > > 
> > > [...]
> > > 
> > > > > > To summarize the approaches we've discussed so far:
> > > > > > 
> > > > > > 1. Pinning the entire guest memory
> > > > > > - Heavy handed and not ideal.
> > > > > > - Tried this approach in v5 of the SPE series [1], patches #2-#12.
> > > > > > 
> > > > > > 2. Mapping the guest SPE buffer on demand, page by page, as a result of stage 2
> > > > > > faults reported by SPE.
> > > > > > - Not feasible, because the entire contents of the buffer must be discarded is
> > > > > >   PMBSR_EL1.DL is set to 1 when taking the fault.
> > > > > > - Requires KVM to walk the guest's stage 1 tables, because SPE reports the VA,
> > > > > >   not the IPA.
> > > > > > 
> > > > > > 3. Pinning the guest SPE buffer when profiling becomes enabled*:
> > > > > > - There is the corner case described above, when profiling becomes enabled as a
> > > > > >   result of an ERET to EL0. This can happen when the buffer is enabled and
> > > > > >   PMSCR_EL1.{E0SPE,E1SPE} = {1,0};
> > > > > > - The previous buffer is unpinned when a new buffer is pinned, to avoid SPE
> > > > > >   stage 2 faults when draining the buffer, which is performed with profiling
> > > > > >   disabled.
> > > > > > - Also requires KVM to walk the guest's stage 1 tables.
> > > > > > 
> > > > > > 4. Pin the entire guest SPE buffer after the first stage 2 fault reported by
> > > > > > SPE.
> > > > > > - Gets rid of the corner case at 3.
> > > > > > - Same approach to buffer unpinning as 3.
> > > > > > - Introduces a blackout window before the first record is written.
> > > > > > - Also requires KVM to walk the guest's stage 1 tables.
> > > > > > 
> > > > > > As for the corner case at 3, I proposed either:
> > > > > > 
> > > > > > a) Mandate that guest operating systems must never modify the buffer
> > > > > > translation entries if the buffer is enabled and
> > > > > > PMSCR_EL1.{E0SPE,E1SPE} = {1,0}.
> > > > > > 
> > > > > > b) Pin the entire buffer as a result of the first stage 2 fault reported by SPE,
> > > > > > but **only** for this corner case. For all other cases, the buffer is pinned
> > > > > > when profiling becomes enabled, to eliminate the blackout window. Guest
> > > > > > operating systems can be modified to not change the translation entries for the
> > > > > > buffer if this blackout window is not desirable.
> > > > > > 
> > > > > > Pinning as a result of the **first** stage 2 fault should work, because there
> > > > > > are no prior records that would have to be discarded if PMSBR_EL1.DL = 1.
> > > > > > 
> > > > > > I hope I haven't missed anything. Thoughts and suggestions more than welcome.
> > > > > 
> > > > > Thanks Alex for pulling together all of the context here.
> > > > > 
> > > > > Unless there's any other strong opinions on the topic, it seems to me
> > > > > that option #4 (pin on S2 fault) is probably the best approach for
> > > > > the initial implementation. No amount of tricks in KVM can work around
> > > > > the fact that SPE has some serious issues w.r.t. virtualization. With
> > > > > that, we should probably document the behavior of SPE as a known erratum
> > > > > of KVM.
> > > > > 
> > > > > If folks complain about EL1 profile blackout, eagerly pinning when
> > > > > profiling is enabled could layer on top quite easily by treating it as
> > > > > a synthetic S2 fault and triggering the implementation of #4. Having
> > > > 
> > > > I'm not sure I follow, I understand what you mean by "treating it as a
> > > > synthetic S2 fault", would you mind elaborating?
> > > 
> > > Assuming approach #4 is implemented, we will already have an SPE fault
> > > handler that walks stage-1 and pins the buffer. At that point,
> > > implementing approach #3 would be relatively easy. When EL1 sets
> > > PMSCR_EL1.E1SPE, call the SPE fault handler on the GVA of the buffer.
> > 
> > I see, that makes sense, thanks,
> > 
> > > 
> > > > > said that I don't believe it is a hard requirement for enabling some
> > > > > flavor of SPE for guests.
> > > > > 
> > > > > Walking guest S1 in KVM doesn't sound too exciting although it'll need to
> > > > > be done eventually.
> > > > > 
> > > > > Do you feel like this is an OK route forward, or have I missed
> > > > > something?
> > > > 
> > > > I've been giving this some thought, and I prefer approach #3 because with
> > > > #4, pinning the buffer as a result of a stage 2 fault reported by SPE, it
> > > > will be impossible to distinguish between a valid stage 2 fault (a fault
> > > > caused by the guest reprogramming the buffer and enabling profiling) and
> > > > KVM messing something up when pinning the buffer. I believe this to be
> > > > important, as experience has shown me that pinning the buffer at stage 2 is
> > > > not trivial and there isn't a mechanism today in Linux to do that
> > > > (explanation and examples here [1]).
> > > 
> > > How does eagerly pinning avoid stage-2 aborts, though? As you note in
> > > [1], page pinning does not avoid the possibility of the MMU notifiers
> > > being called on a given range. Want to make sure I'm following, what
> > > is your suggestion for approach #3 to handle the profile buffer when
> > > only enabled at EL0?
> > > 
> > > > With approach #4, it would be impossible to figure out if the results of a
> > > > profiling operations inside a guest are representative of the workload or
> > > > not, because those SPE stage 2 faults triggered by a bug in KVM can happen
> > > > multiple times per profiling session, introducing multiple blackout windows
> > > > that can skew the results.
> > > > 
> > > > If you're proposing that the blackout window when the first record is
> > > > written be documented as an erratum for KVM, then why no got a step further
> > > > and document as an erratum that changing the buffer translation tables
> > > > after the buffer has been enabled will lead to an SPE Serror? That will
> > > > allow us to always pin the buffer when profiling is enabled.
> > > 
> > > Ah, there are certainly more errata in virtualizing SPE beyond what I
> > > had said :) Preserving the stage-1 translations while profiling is
> > > active is a good recommendation, although I'm not sure that we've
> > > completely eliminated the risk of stage-2 faults. 
> > > 
> > > It seems impossible to blame the guest for all stage-2 faults that happen
> > > in the middle of a profiling session. In addition to host mm driven changes
> > > to stage-2, live migration is a busted as well. You'd need to build out
> > > stage-2 on the target before resuming the guest and guarantee that the
> > > appropriate pages have been demanded from the source (in case of post-copy).
> > > 
> > > So, are we going to inject an SError for stage-2 faults outside of guest
> > > control as well? An external abort reported as an SPE buffer management
> > > event seems to be gracefully handled by the Linux driver, but that behavior
> > > is disallowed by SPEv1p3.
> > > 
> > > To sum up the point I'm getting at: I agree that there are ways to
> > > reduce the risk of stage-2 faults in the middle of profiling, but I
> > > don't believe the current architecture allows KVM to virtualize the
> > > feature to the letter of the specification.
> > 
> > I believe there's some confusion here: emulating SPE **does not work** if
> > stage 2 faults are triggered in the middle of a profiling session. Being
> > able to have a memory range never unmapped from stage 2 is a
> > **prerequisite** and is **required** for SPE emulation, it's not a nice to
> > have.
> > 
> > A stage 2 fault before the first record is written is acceptable because
> > there are no other records already written which need to be thrown away.
> > Stage 2 faults after at least one record has been written are unacceptable
> > because it means that the contents of the buffer needs to thrown away.
> > 
> > Does that make sense to you?
> > 
> > I believe it is doable to have addresses always mapped at stage 2 with some
> > changes to KVM, but that's not what this thread is about. This thread is
> > about how and when to pin the buffer.
> 
> Sorry if I've been forcing a tangent, but I believe there is a lot of
> value in discussing what is to be done for keeping the stage-2 mapping
> alive. I've been whining about it out of the very concern you highlight:
> a stage-2 fault in the middle of the profile is game over. Otherwise,
> optimizations in *when* we pin the buffer seem meaningless as stage-2
> faults appear unavoidable.

The idea I had was to propagate the mmu_notifier_range->event field to the
arch code. Then keep track of the IPAs which KVM pinned with
pin_user_page(s) that translate the guest buffer, and don't unmap that IPA
from stage 2 if the event != MMU_NOTIFY_UNMAP. For a pinned page, all
notifier events except MMU_NOTIFY_UNMAP are caused by the mm subsystem
trying to change how that particular page is mapped.

> 
> Nonetheless, back to your proposal. Injecting some context from earlier:
> 
> > 3. Pinning the guest SPE buffer when profiling becomes enabled*:
> 
> So we are only doing this when enabled for EL1, right?
> (PMSCR_EL1.{E0SPE,E1SPE} = {x, 1})

Yes, pin when PMBLIMITR_EL1.E = 1 and PMSCR_EL1.{E0SPE,E1SPE} = {x, 1}.
Accesses to those registers can be trapped by KVM, and to verify the
condition becomes trivial.

> 
> > - There is the corner case described above, when profiling becomes enabled as a
> >   result of an ERET to EL0. This can happen when the buffer is enabled and
> >   PMSCR_EL1.{E0SPE,E1SPE} = {1,0};
> 
> Is your proposal for the EL0 case to pin on fault or pin when E0SPE is set
> (outside of the architectures definition of when profiling is enabled)?

The original proposal was to pin on the first fault in this case, yes.
That's because the architecture doesn't forbid changing the translation
entries for the buffer when PMBLIMITR_EL1.E = 1 and sampling is disabled
(PMSCR_EL1.{E0SPE, E1SPE] = {x, 0}).

But you mentioned adding a quirk/erratum to KVM in your proposal, and I was
thinking that we could add an erratum to avoid the case above by saying
that that behaviour is impredictable. But that might restrict what
operating systems KVM can run in an SPE-enabled VM, I can do some digging
to find out how other operating systems use SPE, if you think adding the
quirk sounds reasonable.

> 
> > - The previous buffer is unpinned when a new buffer is pinned, to avoid SPE
> >   stage 2 faults when draining the buffer, which is performed with profiling
> >   disabled.
> 
> Sounds reasonable.
> 
> > As long as we're all agreed that buffer memory needs "pinning" (as in the
> > IPA are never unmapped from stage 2 until KVM decides otherwise as part of
> > SPE emulation), I believe that live migration is tangential to figuring out
> > how and when the buffer should be "pinned". I'm more than happy to start a
> > separate thread about live migration after we figure out how we should go
> > about "pinning" the buffer, I think your insight would be most helpful :)
> 
> Fair enough, let's see how this all shakes out and then figure out LM
> thereafter :)

Great, thanks!

Alex

> 
> --
> Thanks,
> Oliver
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
