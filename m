Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E6421375910
	for <lists+kvmarm@lfdr.de>; Thu,  6 May 2021 19:17:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4AE634B5DB;
	Thu,  6 May 2021 13:17:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpKnp4QdGd3N; Thu,  6 May 2021 13:17:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 098794B5C6;
	Thu,  6 May 2021 13:17:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 27A254B562
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 May 2021 13:17:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPhuyMnLpcZ0 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 May 2021 13:17:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E3D654086C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 May 2021 13:17:14 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5C67610A7;
 Thu,  6 May 2021 17:17:13 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lehcd-00BItA-H8; Thu, 06 May 2021 18:17:11 +0100
Date: Thu, 06 May 2021 18:17:10 +0100
Message-ID: <87lf8rrdd5.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 03/11] KVM: arm64: Make kvm_skip_instr() and co private
 to HYP
In-Reply-To: <cef3517b-e66d-4d26-68a9-2d5fb433377c@huawei.com>
References: <20201102164045.264512-1-maz@kernel.org>
 <20201102164045.264512-4-maz@kernel.org>
 <cef3517b-e66d-4d26-68a9-2d5fb433377c@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, kernel-team@android.com,
 will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, ascull@google.com, mark.rutland@arm.com,
 qperret@google.com, dbrazdil@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>,
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

On Wed, 05 May 2021 15:23:02 +0100,
Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
> Hi Marc,
> 
> On 2020/11/3 0:40, Marc Zyngier wrote:
> > In an effort to remove the vcpu PC manipulations from EL1 on nVHE
> > systems, move kvm_skip_instr() to be HYP-specific. EL1's intent
> > to increment PC post emulation is now signalled via a flag in the
> > vcpu structure.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> [...]
> 
> > @@ -133,6 +134,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
> >  	__load_guest_stage2(vcpu->arch.hw_mmu);
> >  	__activate_traps(vcpu);
> >  +	__adjust_pc(vcpu);
> 
> If the INCREMENT_PC flag was set (e.g., for WFx emulation) while we're
> handling PSCI CPU_ON call targetting this VCPU, the *target_pc* (aka
> entry point address, normally provided by the primary VCPU) will be
> unexpectedly incremented here. That's pretty bad, I think.
> 
> This was noticed with a latest guest kernel, at least with commit
> dccc9da22ded ("arm64: Improve parking of stopped CPUs"), which put the
> stopped VCPUs in the WFx loop. The guest kernel shouted at me that
> 
> 	"CPU: CPUs started in inconsistent modes"
> 
> *after* rebooting. The problem is that the secondary entry point was
> corrupted by KVM as explained above. All of the secondary processors
> started from set_cpu_boot_mode_flag(), with w0=0. Oh well...

FWIW, I've pushed out a test branch[1] with two patches that sit on
top of Linus' current tree. I'll rebase and post it as soon as -rc1
appears, but I'd appreciate if you could have a look in the meantime.

Thanks,

	M.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/pc-fixes

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
