Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B9564136E26
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jan 2020 14:34:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E3FA4B1AD;
	Fri, 10 Jan 2020 08:34:34 -0500 (EST)
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
	with ESMTP id ydW5ddHh-DoJ; Fri, 10 Jan 2020 08:34:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD6374B18F;
	Fri, 10 Jan 2020 08:34:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC76C4B171
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 08:34:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S5eeNfB6AXXl for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jan 2020 08:34:30 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7D1904B16E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 08:34:30 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 469B720721;
 Fri, 10 Jan 2020 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578663269;
 bh=/50iOG87qgQkwYRzMG9xveGZkWaz2PiNIMaDoYAD8Ds=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jPGqPImOeO5JV/j2Xd1oChnLiUTRh+iDltUfx7iYdOz3l5g5s0427VBiYH7fR8P06
 RxtHlWvLrgB9retjJltgtG+De1RmQ2LwTFK+2pFn4HYN63BjiNAgLgb3EiK6M8sBeZ
 dxpthEQIN8r/5oHYdNagNS7v1Gy8bcino15nqvT4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ipuQl-0000tK-Ix; Fri, 10 Jan 2020 13:34:27 +0000
MIME-Version: 1.0
Date: Fri, 10 Jan 2020 13:34:27 +0000
From: Marc Zyngier <maz@kernel.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2 09/18] arm64: KVM: enable conditional save/restore full
 SPE profiling buffer controls
In-Reply-To: <20200110121211.GE42593@e119886-lin.cambridge.arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
 <20191220143025.33853-10-andrew.murray@arm.com>
 <20191221141325.5a177343@why>
 <20200110105435.GC42593@e119886-lin.cambridge.arm.com>
 <2a9c9076588ef1dd36a6a365848cdfe7@kernel.org>
 <20200110121211.GE42593@e119886-lin.cambridge.arm.com>
Message-ID: <485799f09fbf0c43c86c70b13cbcecd6@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: andrew.murray@arm.com, Catalin.Marinas@arm.com,
 Mark.Rutland@arm.com, will@kernel.org, Sudeep.Holla@arm.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
 linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>,
 will@kernel.org, kvmarm <kvmarm@lists.cs.columbia.edu>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On 2020-01-10 12:12, Andrew Murray wrote:
> On Fri, Jan 10, 2020 at 11:18:48AM +0000, Marc Zyngier wrote:
>> On 2020-01-10 10:54, Andrew Murray wrote:
>> > On Sat, Dec 21, 2019 at 02:13:25PM +0000, Marc Zyngier wrote:
>> > > On Fri, 20 Dec 2019 14:30:16 +0000
>> > > Andrew Murray <andrew.murray@arm.com> wrote:
>> > >
>> > > [somehow managed not to do a reply all, re-sending]
>> > >
>> > > > From: Sudeep Holla <sudeep.holla@arm.com>
>> > > >
>> > > > Now that we can save/restore the full SPE controls, we can enable it
>> > > > if SPE is setup and ready to use in KVM. It's supported in KVM only if
>> > > > all the CPUs in the system supports SPE.
>> > > >
>> > > > However to support heterogenous systems, we need to move the check if
>> > > > host supports SPE and do a partial save/restore.
>> > >
>> > > No. Let's just not go down that path. For now, KVM on heterogeneous
>> > > systems do not get SPE. If SPE has been enabled on a guest and a CPU
>> > > comes up without SPE, this CPU should fail to boot (same as exposing a
>> > > feature to userspace).
>> > >
>> > > >
>> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> > > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> > > > ---
>> > > >  arch/arm64/kvm/hyp/debug-sr.c | 33 ++++++++++++++++-----------------
>> > > >  include/kvm/arm_spe.h         |  6 ++++++
>> > > >  2 files changed, 22 insertions(+), 17 deletions(-)
>> > > >
>> > > > diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
>> > > > index 12429b212a3a..d8d857067e6d 100644
>> > > > --- a/arch/arm64/kvm/hyp/debug-sr.c
>> > > > +++ b/arch/arm64/kvm/hyp/debug-sr.c
>> > > > @@ -86,18 +86,13 @@
>> > > >  	}
>> > > >
>> > > >  static void __hyp_text
>> > > > -__debug_save_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> > > > +__debug_save_spe_context(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> > > >  {
>> > > >  	u64 reg;
>> > > >
>> > > >  	/* Clear pmscr in case of early return */
>> > > >  	ctxt->sys_regs[PMSCR_EL1] = 0;
>> > > >
>> > > > -	/* SPE present on this CPU? */
>> > > > -	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
>> > > > -						  ID_AA64DFR0_PMSVER_SHIFT))
>> > > > -		return;
>> > > > -
>> > > >  	/* Yes; is it owned by higher EL? */
>> > > >  	reg = read_sysreg_s(SYS_PMBIDR_EL1);
>> > > >  	if (reg & BIT(SYS_PMBIDR_EL1_P_SHIFT))
>> > > > @@ -142,7 +137,7 @@ __debug_save_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> > > >  }
>> > > >
>> > > >  static void __hyp_text
>> > > > -__debug_restore_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> > > > +__debug_restore_spe_context(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> > > >  {
>> > > >  	if (!ctxt->sys_regs[PMSCR_EL1])
>> > > >  		return;
>> > > > @@ -210,11 +205,14 @@ void __hyp_text __debug_restore_guest_context(struct kvm_vcpu *vcpu)
>> > > >  	struct kvm_guest_debug_arch *host_dbg;
>> > > >  	struct kvm_guest_debug_arch *guest_dbg;
>> > > >
>> > > > +	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
>> > > > +	guest_ctxt = &vcpu->arch.ctxt;
>> > > > +
>> > > > +	__debug_restore_spe_context(guest_ctxt, kvm_arm_spe_v1_ready(vcpu));
>> > > > +
>> > > >  	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
>> > > >  		return;
>> > > >
>> > > > -	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
>> > > > -	guest_ctxt = &vcpu->arch.ctxt;
>> > > >  	host_dbg = &vcpu->arch.host_debug_state.regs;
>> > > >  	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
>> > > >
>> > > > @@ -232,8 +230,7 @@ void __hyp_text __debug_restore_host_context(struct kvm_vcpu *vcpu)
>> > > >  	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
>> > > >  	guest_ctxt = &vcpu->arch.ctxt;
>> > > >
>> > > > -	if (!has_vhe())
>> > > > -		__debug_restore_spe_nvhe(host_ctxt, false);
>> > > > +	__debug_restore_spe_context(host_ctxt, kvm_arm_spe_v1_ready(vcpu));
>> > >
>> > > So you now do an unconditional save/restore on the exit path for VHE
>> > > as
>> > > well? Even if the host isn't using the SPE HW? That's not acceptable
>> > > as, in most cases, only the host /or/ the guest will use SPE. Here,
>> > > you
>> > > put a measurable overhead on each exit.
>> > >
>> > > If the host is not using SPE, then the restore/save should happen in
>> > > vcpu_load/vcpu_put. Only if the host is using SPE should you do
>> > > something in the run loop. Of course, this only applies to VHE and
>> > > non-VHE must switch eagerly.
>> > >
>> >
>> > On VHE where SPE is used in the guest only - we save/restore in
>> > vcpu_load/put.
>> 
>> Yes.
>> 
>> > On VHE where SPE is used in the host only - we save/restore in the run
>> > loop.
>> 
>> Why? If only the host is using SPE, why should we do *anything at 
>> all*?
> 
> Oh yeah of course, we trap them in this case.
> 
> (Do I understand correctly that we don't/can't trap them for nVHE? - 
> and so
> we should save/restore them for this use-case in nVHE)

We can always trap. Otherwise we wouldn't be able to hide the feature
from the guest.

>> > On VHE where SPE is used in guest and host - we save/restore in the run
>> > loop.
>> >
>> > As the guest can't trace EL2 it doesn't matter if we restore guest SPE
>> > early
>> > in the vcpu_load/put functions. (I assume it doesn't matter that we
>> > restore
>> > an EL0/EL1 profiling buffer address at this point and enable tracing
>> > given
>> > that there is nothing to trace until entering the guest).
>> 
>> As long as you do it after the EL1 sysregs have need restored so that 
>> the
>> SPE
>> HW has a valid context, we should be fine. Don't restore it before 
>> that
>> point
>> though (you have no idea whether the SPE HW can do speculative memory
>> accesses
>> that would use the wrong page tables).
> 
> Right, so don't enable tracing until SPE has a valid context. I 
> understand
> that to mean at least the SPE buffer address registers (PMBPTR, 
> PMBLIMITR)
> in the right context with respect to the E2PB bits (translation regime)
> and having those tables mapped in (which I think relate to the 
> __activateX,
> __sysreg_restore_guest_stateX type of calls in kvm_vcpu_run_X right?).

The full MM context has to be in place before you can do anything. This 
means
at least TTBR*_EL1, TCR_EL1 and co. But maybe this note in the SPE 
architecture
document would allow us to relax things:

"The Statistical Profiling Extension is always disabled if the owning 
Exception
level is a lower Exception level than the current Exception level."

So as long as you restore the guest state from EL2, SPE should be 
disabled.

> I think that means we can restore the registers no earler than 
> vcpu_load/put
> but we can't re-enable the tracing (PMSCR) until no earlier than just 
> before
> __set_guest_arch_workaround_state. I think that applies to both VHE and 
> nVHE?

I'm sorry, but I don't understand what you mean.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
