Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 28B201341D3
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 13:36:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 879CD4B09F;
	Wed,  8 Jan 2020 07:36:18 -0500 (EST)
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
	with ESMTP id mUfNuR7TS0KZ; Wed,  8 Jan 2020 07:36:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05E594B067;
	Wed,  8 Jan 2020 07:36:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F192F4B055
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 07:36:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 594yWjsyQ5aY for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 07:36:14 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9C4BB4B03B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 07:36:14 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82663206DB;
 Wed,  8 Jan 2020 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578486973;
 bh=W9JwVSVRItNpDbcbGietn6Cp2AuPDABok0YRBfrkW4M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=e0vTgUF32Xj1bwsEWm9WFcVNStkTjl+ziOyel/OT6B8tDK/z5F405fD4Ox6as1YfH
 RKSYtzikLXF8huxpv5OUfo1yeU/zAp5SkKwvdjJHCfzDWR7dEObk8T+1S8z0Kauc7n
 efXlO69a6orB+g69QYcdpbV9P9QTs91UyFlKgP8g=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ipAZH-0008LF-Ob; Wed, 08 Jan 2020 12:36:11 +0000
MIME-Version: 1.0
Date: Wed, 08 Jan 2020 12:36:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 09/18] arm64: KVM: enable conditional save/restore full
 SPE profiling buffer controls
In-Reply-To: <20200108115816.GB15861@willie-the-truck>
References: <20191220143025.33853-1-andrew.murray@arm.com>
 <20191220143025.33853-10-andrew.murray@arm.com>
 <20191221141325.5a177343@why>
 <20200107151328.GW42593@e119886-lin.cambridge.arm.com>
 <fc222fef381f4ada37966db0a1ec314a@kernel.org>
 <20200108115816.GB15861@willie-the-truck>
Message-ID: <745529f7e469b898b74dfc5153e3daf6@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, andrew.murray@arm.com,
 Catalin.Marinas@arm.com, Mark.Rutland@arm.com, Sudeep.Holla@arm.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
 linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
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

On 2020-01-08 11:58, Will Deacon wrote:
> On Wed, Jan 08, 2020 at 11:17:16AM +0000, Marc Zyngier wrote:
>> On 2020-01-07 15:13, Andrew Murray wrote:
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
>> > > systems do not get SPE.
>> >
>> > At present these patches only offer the SPE feature to VCPU's where the
>> > sanitised AA64DFR0 register indicates that all CPUs have this support
>> > (kvm_arm_support_spe_v1) at the time of setting the attribute
>> > (KVM_SET_DEVICE_ATTR).
>> >
>> > Therefore if a new CPU comes online without SPE support, and an
>> > existing VCPU is scheduled onto it, then bad things happen - which I
>> > guess
>> > must have been the intention behind this patch.
>> 
>> I guess that was the intent.
>> 
>> > > If SPE has been enabled on a guest and a CPU
>> > > comes up without SPE, this CPU should fail to boot (same as exposing a
>> > > feature to userspace).
>> >
>> > I'm unclear as how to prevent this. We can set the FTR_STRICT flag on
>> > the sanitised register - thus tainting the kernel if such a non-SPE CPU
>> > comes online - thought that doesn't prevent KVM from blowing up. Though
>> > I don't believe we can prevent a CPU coming up. At the moment this is
>> > my preferred approach.
>> 
>> I'd be OK with this as a stop-gap measure. Do we know of any existing
>> design where only half of the CPUs have SPE?
> 
> No, but given how few CPUs implement SPE I'd say that this 
> configuration
> is inevitable. I certainly went out of my way to support it in the 
> driver.
> 
>> > Looking at the vcpu_load and related code, I don't see a way of saying
>> > 'don't schedule this VCPU on this CPU' or bailing in any way.
>> 
>> That would actually be pretty easy to implement. In vcpu_load(), check
>> that that the CPU physical has SPE. If not, raise a request for that 
>> vcpu.
>> In the run loop, check for that request and abort if raised, returning
>> to userspace.
>> 
>> Userspace can always check /sys/devices/arm_spe_0/cpumask and work out
>> where to run that particular vcpu.
> 
> It's also worth considering systems where there are multiple 
> implementations
> of SPE in play. Assuming we don't want to expose this to a guest, then 
> the
> right interface here is probably for userspace to pick one SPE
> implementation and expose that to the guest. That fits with your idea 
> above,
> where you basically get an immediate exit if we try to schedule a vCPU 
> onto
> a CPU that isn't part of the SPE mask.

Then it means that the VM should be configured with a mask indicating
which CPUs it is intended to run on, and setting such a mask is 
mandatory
for SPE.

> 
>> > One solution could be to allow scheduling onto non-SPE VCPUs but wrap
>> > the
>> > SPE save/restore code in a macro (much like kvm_arm_spe_v1_ready) that
>> > reads the non-sanitised feature register. Therefore we don't go bang,
>> > but
>> > we also increase the size of any black-holes in SPE capturing. Though
>> > this
>> > feels like something that will cause grief down the line.
>> >
>> > Is there something else that can be done?
>> 
>> How does userspace deal with this? When SPE is only available on half 
>> of
>> the CPUs, how does perf work in these conditions?
> 
> Not sure about userspace, but the kernel driver works by instantiating 
> an
> SPE PMU instance only for the CPUs that have it and then that instance
> profiles for only those CPUs. You also need to do something similar if
> you had two CPU types with SPE, since the SPE configuration is likely 
> to be
> different between them.

So that's closer to what Andrew was suggesting above (running a guest on 
a
non-SPE CPU creates a profiling black hole). Except that we can't really
run a SPE-enabled guest on a non-SPE CPU, as the SPE sysregs will UNDEF
at EL1.

Conclusion: we need a mix of a cpumask to indicate which CPUs we want to
run on (generic, not-SPE related), and a check for SPE-capable CPUs.
If any of these condition is not satisfied, the vcpu exits for userspace
to sort out the affinity.

I hate heterogeneous systems.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
