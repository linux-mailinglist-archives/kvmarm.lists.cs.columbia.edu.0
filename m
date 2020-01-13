Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3D803139661
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jan 2020 17:31:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CB9D4AEF1;
	Mon, 13 Jan 2020 11:31:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jeRcj3uFFAoy; Mon, 13 Jan 2020 11:31:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CD294AEF0;
	Mon, 13 Jan 2020 11:31:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B7DD4AED4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 11:31:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FuQg4XZotszF for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jan 2020 11:31:41 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDD534AECC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 11:31:41 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EC1011B3;
 Mon, 13 Jan 2020 08:31:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69683F534;
 Mon, 13 Jan 2020 08:31:40 -0800 (PST)
Date: Mon, 13 Jan 2020 16:31:38 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 10/18] arm64: KVM/debug: use EL1&0 stage 1 translation
 regime
Message-ID: <20200113163138.GP42593@e119886-lin.cambridge.arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
 <20191220143025.33853-11-andrew.murray@arm.com>
 <86d0cgir74.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86d0cgir74.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Sun, Dec 22, 2019 at 10:34:55AM +0000, Marc Zyngier wrote:
> On Fri, 20 Dec 2019 14:30:17 +0000,
> Andrew Murray <andrew.murray@arm.com> wrote:
> > 
> > From: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > Now that we have all the save/restore mechanism in place, lets enable
> > the translation regime used by buffer from EL2 stage 1 to EL1 stage 1
> > on VHE systems.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > [ Reword commit, don't trap to EL2 ]
> 
> Not trapping to EL2 for the case where we don't allow SPE in the
> guest is not acceptable.
> 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/kvm/hyp/switch.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index 67b7c160f65b..6c153b79829b 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -100,6 +100,7 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
> >  
> >  	write_sysreg(val, cpacr_el1);
> >  
> > +	write_sysreg(vcpu->arch.mdcr_el2 | 3 << MDCR_EL2_E2PB_SHIFT, mdcr_el2);
> >  	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
> >  }
> >  NOKPROBE_SYMBOL(activate_traps_vhe);
> > @@ -117,6 +118,7 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
> >  		__activate_traps_fpsimd32(vcpu);
> >  	}
> >  
> > +	write_sysreg(vcpu->arch.mdcr_el2 | 3 << MDCR_EL2_E2PB_SHIFT, mdcr_el2);
> 
> There is a _MASK macro that can replace this '3', and is in keeping
> with the rest of the code.
> 
> It still remains that it looks like the wrong place to do this, and
> vcpu_load seems much better. Why should you write to mdcr_el2 on each
> entry to the guest, since you know whether it has SPE enabled at the
> point where it gets scheduled?

For nVHE, the only reason we'd want to change E2PB on entry/exit of guest
would be if the host is also using SPE. If the host is using SPE whilst
the vcpu is 'loaded' but we're not in the guest, then host SPE could raise
an interrupt - we need the E2PB bits to allow access from EL1 (host).

Thanks,

Andrew Murray

> 
> 	M.
> 
> -- 
> Jazz is not dead, it just smells funny.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
