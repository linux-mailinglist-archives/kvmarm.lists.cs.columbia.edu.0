Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EE7841357D1
	for <lists+kvmarm@lfdr.de>; Thu,  9 Jan 2020 12:23:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EE2E4B281;
	Thu,  9 Jan 2020 06:23:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sn7bgPbqbh5X; Thu,  9 Jan 2020 06:23:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCEDC4B294;
	Thu,  9 Jan 2020 06:23:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 678C74B28D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Jan 2020 06:23:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9vkFcJLppJ8K for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Jan 2020 06:23:40 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EABCB4B273
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Jan 2020 06:23:39 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79BF231B;
 Thu,  9 Jan 2020 03:23:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1E513F703;
 Thu,  9 Jan 2020 03:23:38 -0800 (PST)
Date: Thu, 9 Jan 2020 11:23:37 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 09/18] arm64: KVM: enable conditional save/restore
 full SPE profiling buffer controls
Message-ID: <20200109112336.GY42593@e119886-lin.cambridge.arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
 <20191220143025.33853-10-andrew.murray@arm.com>
 <20191221141325.5a177343@why>
 <20200107151328.GW42593@e119886-lin.cambridge.arm.com>
 <fc222fef381f4ada37966db0a1ec314a@kernel.org>
 <20200108115816.GB15861@willie-the-truck>
 <745529f7e469b898b74dfc5153e3daf6@kernel.org>
 <20200108131020.GB16658@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200108131020.GB16658@willie-the-truck>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Sudeep Holla <Sudeep.Holla@arm.com>, kvmarm <kvmarm@lists.cs.columbia.edu>,
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

On Wed, Jan 08, 2020 at 01:10:21PM +0000, Will Deacon wrote:
> On Wed, Jan 08, 2020 at 12:36:11PM +0000, Marc Zyngier wrote:
> > On 2020-01-08 11:58, Will Deacon wrote:
> > > On Wed, Jan 08, 2020 at 11:17:16AM +0000, Marc Zyngier wrote:
> > > > On 2020-01-07 15:13, Andrew Murray wrote:
> > > > > Looking at the vcpu_load and related code, I don't see a way of saying
> > > > > 'don't schedule this VCPU on this CPU' or bailing in any way.
> > > > 
> > > > That would actually be pretty easy to implement. In vcpu_load(), check
> > > > that that the CPU physical has SPE. If not, raise a request for that
> > > > vcpu.
> > > > In the run loop, check for that request and abort if raised, returning
> > > > to userspace.

I hadn't really noticed the kvm_make_request mechanism - however it's now
clear how this could be implemented.

This approach gives responsibility for which CPUs should be used to userspace
and if userspace gets it wrong then the KVM_RUN ioctl won't do very much.


> > > > 
> > > > Userspace can always check /sys/devices/arm_spe_0/cpumask and work out
> > > > where to run that particular vcpu.
> > > 
> > > It's also worth considering systems where there are multiple
> > > implementations
> > > of SPE in play. Assuming we don't want to expose this to a guest, then
> > > the
> > > right interface here is probably for userspace to pick one SPE
> > > implementation and expose that to the guest.

If I understand correctly then this implies the following:

 - If the host userspace indicates it wants support for SPE in the guest (via 
   KVM_SET_DEVICE_ATTR at start of day) - then we should check in vcpu_load that
   the minimum version of SPE is present on the current CPU. 'minimum' because
   we don't know why userspace has selected the given cpumask.

 - Userspace can get it wrong, i.e. it can create a CPU mask with CPUs that
   have SPE with differing versions. If it does, and all CPUs have some form of
   SPE then errors may occur in the guest. Perhaps this is OK and userspace
   shouldn't get it wrong?


> > >  That fits with your idea
> > > above,
> > > where you basically get an immediate exit if we try to schedule a vCPU
> > > onto
> > > a CPU that isn't part of the SPE mask.
> > 
> > Then it means that the VM should be configured with a mask indicating
> > which CPUs it is intended to run on, and setting such a mask is mandatory
> > for SPE.
> 
> Yeah, and this could probably all be wrapped up by userspace so you just
> pass the SPE PMU name or something and it grabs the corresponding cpumask
> for you.
> 
> > > > > One solution could be to allow scheduling onto non-SPE VCPUs but wrap
> > > > > the
> > > > > SPE save/restore code in a macro (much like kvm_arm_spe_v1_ready) that
> > > > > reads the non-sanitised feature register. Therefore we don't go bang,
> > > > > but
> > > > > we also increase the size of any black-holes in SPE capturing. Though
> > > > > this
> > > > > feels like something that will cause grief down the line.
> > > > >
> > > > > Is there something else that can be done?
> > > > 
> > > > How does userspace deal with this? When SPE is only available on
> > > > half of
> > > > the CPUs, how does perf work in these conditions?
> > > 
> > > Not sure about userspace, but the kernel driver works by instantiating
> > > an
> > > SPE PMU instance only for the CPUs that have it and then that instance
> > > profiles for only those CPUs. You also need to do something similar if
> > > you had two CPU types with SPE, since the SPE configuration is likely to
> > > be
> > > different between them.
> > 
> > So that's closer to what Andrew was suggesting above (running a guest on a
> > non-SPE CPU creates a profiling black hole). Except that we can't really
> > run a SPE-enabled guest on a non-SPE CPU, as the SPE sysregs will UNDEF
> > at EL1.
> 
> Right. I wouldn't suggest the "black hole" approach for VMs, but it works
> for userspace so that's why the driver does it that way.
> 
> > Conclusion: we need a mix of a cpumask to indicate which CPUs we want to
> > run on (generic, not-SPE related), 

If I understand correctly this mask isn't exposed to KVM (in the kernel) and
KVM (in the kernel) is unware of how the CPUs that have KVM_RUN called are
selected.

Thus this implies the cpumask is a feature of KVM tool or QEMU that would
need to be added there. (E.g. kvm_cmd_run_work would set some affinity when
creating pthreads - based on a CPU mask triggered by setting the --spe flag)?

Thanks,

Andrew Murray

> and a check for SPE-capable CPUs.
> > If any of these condition is not satisfied, the vcpu exits for userspace
> > to sort out the affinity.
> > 
> > I hate heterogeneous systems.
> 
> They hate you too ;)
> 
> Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
