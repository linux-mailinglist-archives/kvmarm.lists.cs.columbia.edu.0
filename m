Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D3B2F13437C
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 14:10:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 646414B08A;
	Wed,  8 Jan 2020 08:10:36 -0500 (EST)
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
	with ESMTP id UkSLDbPQSGJs; Wed,  8 Jan 2020 08:10:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32E1F4B043;
	Wed,  8 Jan 2020 08:10:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00BB34B002
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 08:10:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qT1x8gUf5ZHQ for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 08:10:32 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C06684AFDD
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 08:10:32 -0500 (EST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C341205F4;
 Wed,  8 Jan 2020 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578489031;
 bh=YWAjQGTx7BqSwb3NRHw94BdAJ9TevBImfPuZnNeApRg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vRA4td7eQhe14Dw6kpIUT5AKCpVJ8eThPzcv196v8clU/e8IxC95MhZ6KcIvPoIeX
 qVPjTikfCVOQRgH1/xQ6KhfVPAKUb+1NEa9acZrQpZjUEFj8shK2R3dmC/aeYUOF/Q
 BAC1G1isw5RJkjwuJG3xXL5lg7An+xfY0JjHe77c=
Date: Wed, 8 Jan 2020 13:10:21 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 09/18] arm64: KVM: enable conditional save/restore
 full SPE profiling buffer controls
Message-ID: <20200108131020.GB16658@willie-the-truck>
References: <20191220143025.33853-1-andrew.murray@arm.com>
 <20191220143025.33853-10-andrew.murray@arm.com>
 <20191221141325.5a177343@why>
 <20200107151328.GW42593@e119886-lin.cambridge.arm.com>
 <fc222fef381f4ada37966db0a1ec314a@kernel.org>
 <20200108115816.GB15861@willie-the-truck>
 <745529f7e469b898b74dfc5153e3daf6@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <745529f7e469b898b74dfc5153e3daf6@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Wed, Jan 08, 2020 at 12:36:11PM +0000, Marc Zyngier wrote:
> On 2020-01-08 11:58, Will Deacon wrote:
> > On Wed, Jan 08, 2020 at 11:17:16AM +0000, Marc Zyngier wrote:
> > > On 2020-01-07 15:13, Andrew Murray wrote:
> > > > Looking at the vcpu_load and related code, I don't see a way of saying
> > > > 'don't schedule this VCPU on this CPU' or bailing in any way.
> > > 
> > > That would actually be pretty easy to implement. In vcpu_load(), check
> > > that that the CPU physical has SPE. If not, raise a request for that
> > > vcpu.
> > > In the run loop, check for that request and abort if raised, returning
> > > to userspace.
> > > 
> > > Userspace can always check /sys/devices/arm_spe_0/cpumask and work out
> > > where to run that particular vcpu.
> > 
> > It's also worth considering systems where there are multiple
> > implementations
> > of SPE in play. Assuming we don't want to expose this to a guest, then
> > the
> > right interface here is probably for userspace to pick one SPE
> > implementation and expose that to the guest. That fits with your idea
> > above,
> > where you basically get an immediate exit if we try to schedule a vCPU
> > onto
> > a CPU that isn't part of the SPE mask.
> 
> Then it means that the VM should be configured with a mask indicating
> which CPUs it is intended to run on, and setting such a mask is mandatory
> for SPE.

Yeah, and this could probably all be wrapped up by userspace so you just
pass the SPE PMU name or something and it grabs the corresponding cpumask
for you.

> > > > One solution could be to allow scheduling onto non-SPE VCPUs but wrap
> > > > the
> > > > SPE save/restore code in a macro (much like kvm_arm_spe_v1_ready) that
> > > > reads the non-sanitised feature register. Therefore we don't go bang,
> > > > but
> > > > we also increase the size of any black-holes in SPE capturing. Though
> > > > this
> > > > feels like something that will cause grief down the line.
> > > >
> > > > Is there something else that can be done?
> > > 
> > > How does userspace deal with this? When SPE is only available on
> > > half of
> > > the CPUs, how does perf work in these conditions?
> > 
> > Not sure about userspace, but the kernel driver works by instantiating
> > an
> > SPE PMU instance only for the CPUs that have it and then that instance
> > profiles for only those CPUs. You also need to do something similar if
> > you had two CPU types with SPE, since the SPE configuration is likely to
> > be
> > different between them.
> 
> So that's closer to what Andrew was suggesting above (running a guest on a
> non-SPE CPU creates a profiling black hole). Except that we can't really
> run a SPE-enabled guest on a non-SPE CPU, as the SPE sysregs will UNDEF
> at EL1.

Right. I wouldn't suggest the "black hole" approach for VMs, but it works
for userspace so that's why the driver does it that way.

> Conclusion: we need a mix of a cpumask to indicate which CPUs we want to
> run on (generic, not-SPE related), and a check for SPE-capable CPUs.
> If any of these condition is not satisfied, the vcpu exits for userspace
> to sort out the affinity.
> 
> I hate heterogeneous systems.

They hate you too ;)

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
