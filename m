Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC2136BD9
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jan 2020 12:18:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7B674B1C2;
	Fri, 10 Jan 2020 06:18:54 -0500 (EST)
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
	with ESMTP id bodkjZj6f5hn; Fri, 10 Jan 2020 06:18:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52F664B19D;
	Fri, 10 Jan 2020 06:18:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DADF34B18B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 06:18:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H100k837VnhL for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jan 2020 06:18:51 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 798744B15B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 06:18:51 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5495220721;
 Fri, 10 Jan 2020 11:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578655130;
 bh=1LXfK2dJUcjEJ/EmR+OcVddqMQyjQI8vDoMgOjLi3b0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uZTO5Gz+DQOgGNkBKt57eCylxQVOQJ13c1PEu/PUgWHYK2TzX0uZZrC2CqODnE1MI
 cNypNlMcjguIdHHa1okYIgyDOe5Ff60aVCYwNLaP122m1SJiSTG5PZF4Gkv3xvfQ1Y
 vAk5zesvuPiBciANd04ELBjbDQzRC7nl0HcJO0g8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ipsJU-0007qA-M4; Fri, 10 Jan 2020 11:18:48 +0000
MIME-Version: 1.0
Date: Fri, 10 Jan 2020 11:18:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2 09/18] arm64: KVM: enable conditional save/restore full
 SPE profiling buffer controls
In-Reply-To: <20200110105435.GC42593@e119886-lin.cambridge.arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
 <20191220143025.33853-10-andrew.murray@arm.com>
 <20191221141325.5a177343@why>
 <20200110105435.GC42593@e119886-lin.cambridge.arm.com>
Message-ID: <2a9c9076588ef1dd36a6a365848cdfe7@kernel.org>
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

On 2020-01-10 10:54, Andrew Murray wrote:
> On Sat, Dec 21, 2019 at 02:13:25PM +0000, Marc Zyngier wrote:
>> On Fri, 20 Dec 2019 14:30:16 +0000
>> Andrew Murray <andrew.murray@arm.com> wrote:
>> 
>> [somehow managed not to do a reply all, re-sending]
>> 
>> > From: Sudeep Holla <sudeep.holla@arm.com>
>> >
>> > Now that we can save/restore the full SPE controls, we can enable it
>> > if SPE is setup and ready to use in KVM. It's supported in KVM only if
>> > all the CPUs in the system supports SPE.
>> >
>> > However to support heterogenous systems, we need to move the check if
>> > host supports SPE and do a partial save/restore.
>> 
>> No. Let's just not go down that path. For now, KVM on heterogeneous
>> systems do not get SPE. If SPE has been enabled on a guest and a CPU
>> comes up without SPE, this CPU should fail to boot (same as exposing a
>> feature to userspace).
>> 
>> >
>> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> > ---
>> >  arch/arm64/kvm/hyp/debug-sr.c | 33 ++++++++++++++++-----------------
>> >  include/kvm/arm_spe.h         |  6 ++++++
>> >  2 files changed, 22 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
>> > index 12429b212a3a..d8d857067e6d 100644
>> > --- a/arch/arm64/kvm/hyp/debug-sr.c
>> > +++ b/arch/arm64/kvm/hyp/debug-sr.c
>> > @@ -86,18 +86,13 @@
>> >  	}
>> >
>> >  static void __hyp_text
>> > -__debug_save_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> > +__debug_save_spe_context(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> >  {
>> >  	u64 reg;
>> >
>> >  	/* Clear pmscr in case of early return */
>> >  	ctxt->sys_regs[PMSCR_EL1] = 0;
>> >
>> > -	/* SPE present on this CPU? */
>> > -	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
>> > -						  ID_AA64DFR0_PMSVER_SHIFT))
>> > -		return;
>> > -
>> >  	/* Yes; is it owned by higher EL? */
>> >  	reg = read_sysreg_s(SYS_PMBIDR_EL1);
>> >  	if (reg & BIT(SYS_PMBIDR_EL1_P_SHIFT))
>> > @@ -142,7 +137,7 @@ __debug_save_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> >  }
>> >
>> >  static void __hyp_text
>> > -__debug_restore_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> > +__debug_restore_spe_context(struct kvm_cpu_context *ctxt, bool full_ctxt)
>> >  {
>> >  	if (!ctxt->sys_regs[PMSCR_EL1])
>> >  		return;
>> > @@ -210,11 +205,14 @@ void __hyp_text __debug_restore_guest_context(struct kvm_vcpu *vcpu)
>> >  	struct kvm_guest_debug_arch *host_dbg;
>> >  	struct kvm_guest_debug_arch *guest_dbg;
>> >
>> > +	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
>> > +	guest_ctxt = &vcpu->arch.ctxt;
>> > +
>> > +	__debug_restore_spe_context(guest_ctxt, kvm_arm_spe_v1_ready(vcpu));
>> > +
>> >  	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
>> >  		return;
>> >
>> > -	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
>> > -	guest_ctxt = &vcpu->arch.ctxt;
>> >  	host_dbg = &vcpu->arch.host_debug_state.regs;
>> >  	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
>> >
>> > @@ -232,8 +230,7 @@ void __hyp_text __debug_restore_host_context(struct kvm_vcpu *vcpu)
>> >  	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
>> >  	guest_ctxt = &vcpu->arch.ctxt;
>> >
>> > -	if (!has_vhe())
>> > -		__debug_restore_spe_nvhe(host_ctxt, false);
>> > +	__debug_restore_spe_context(host_ctxt, kvm_arm_spe_v1_ready(vcpu));
>> 
>> So you now do an unconditional save/restore on the exit path for VHE 
>> as
>> well? Even if the host isn't using the SPE HW? That's not acceptable
>> as, in most cases, only the host /or/ the guest will use SPE. Here, 
>> you
>> put a measurable overhead on each exit.
>> 
>> If the host is not using SPE, then the restore/save should happen in
>> vcpu_load/vcpu_put. Only if the host is using SPE should you do
>> something in the run loop. Of course, this only applies to VHE and
>> non-VHE must switch eagerly.
>> 
> 
> On VHE where SPE is used in the guest only - we save/restore in 
> vcpu_load/put.

Yes.

> On VHE where SPE is used in the host only - we save/restore in the run 
> loop.

Why? If only the host is using SPE, why should we do *anything at all*?

> On VHE where SPE is used in guest and host - we save/restore in the run 
> loop.
> 
> As the guest can't trace EL2 it doesn't matter if we restore guest SPE 
> early
> in the vcpu_load/put functions. (I assume it doesn't matter that we 
> restore
> an EL0/EL1 profiling buffer address at this point and enable tracing 
> given
> that there is nothing to trace until entering the guest).

As long as you do it after the EL1 sysregs have need restored so that 
the SPE
HW has a valid context, we should be fine. Don't restore it before that 
point
though (you have no idea whether the SPE HW can do speculative memory 
accesses
that would use the wrong page tables).

> However the reason for moving save/restore to vcpu_load/put when the 
> host is
> using SPE is to minimise the host EL2 black-out window.

You should move it to *the run loop* when both host and guest are using 
SPE.

> On nVHE we always save/restore in the run loop. For the SPE 
> guest-use-only
> use-case we can't save/restore in vcpu_load/put - because the guest 
> runs at
> the same ELx level as the host - and thus doing so would result in the 
> guest
> tracing part of the host.

Not only. It would actively corrupt memory in the host by using the 
wrong
page tables.

> Though if we determine that (for nVHE systems) the guest SPE is 
> profiling only
> EL0 - then we could also save/restore in vcpu_load/put where SPE is 
> only being
> used in the guest.

Same as above: wrong MM context, speculation, potential memory 
corruption.

> Does that make sense, are my reasons correct?

Not entirely. I think you should use the following table:

VHE | Host-SPE | Guest-SPE | Switch location
  0  |     0    |     0     | none
  0  |     0    |     1     | run loop
  0  |     1    |     0     | run loop
  0  |     1    |     1     | run loop
  1  |     0    |     0     | none
  1  |     0    |     1     | load/put
  1  |     1    |     0     | none
  1  |     1    |     1     | run loop

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
