Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5461B33F67E
	for <lists+kvmarm@lfdr.de>; Wed, 17 Mar 2021 18:20:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD7404B69D;
	Wed, 17 Mar 2021 13:20:19 -0400 (EDT)
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
	with ESMTP id 0XYeLQsJUBIA; Wed, 17 Mar 2021 13:20:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A2314B695;
	Wed, 17 Mar 2021 13:20:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 64D914B686
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 13:20:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9kumYTlNObM7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Mar 2021 13:20:16 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6EC9B4B679
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 13:20:16 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D82C864E0F;
 Wed, 17 Mar 2021 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616001613;
 bh=jHjxIb9xISuowelZ+isObXqoEf9PZ5lTJzVIllP5qAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nLFMglnQaIuWYkZPSMGTbsmf+DeHb0DnHRJhErUh7EASk+XRM9Usqcys1twY/vHzk
 ZVmNKxWXCXRR6EC1WxFWVuLMDj7i1h7K9pbrpsvAbcZisyv0vEk1EHObp2cotk/UQL
 52saNkq78Ud8/R4mwHBJQoFz1ADBSBCyoQmG4UMaSUnUZHRa3DfqGH6Lf7wMlKeTe5
 rtFnn1edg17Yg8hZ+L1WGFBNbQtT1xQj1S9EEeySmlytLYDMcaEeOySd+U3d+04OFt
 LkmxDbetUGZWciAjtQva0LulHdJG6m7zC/WPNNG3ZjR/JC4+qW+/zsKm2RTwpq21nv
 OA5vRw9lTC2Gw==
Date: Wed, 17 Mar 2021 17:20:08 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 07/10] KVM: arm64: Save guest's ZCR_EL1 before saving the
 FPSIMD state
Message-ID: <20210317172008.GB5640@willie-the-truck>
References: <20210316101312.102925-1-maz@kernel.org>
 <20210316101312.102925-8-maz@kernel.org>
 <20210317171738.GA5640@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317171738.GA5640@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, broonie@kernel.org, kernel-team@android.com,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, daniel.kiss@arm.com
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

On Wed, Mar 17, 2021 at 05:17:38PM +0000, Will Deacon wrote:
> On Tue, Mar 16, 2021 at 10:13:09AM +0000, Marc Zyngier wrote:
> > Make sure the guest's ZCR_EL1 is saved before we save/flush the
> > state. This will be useful in later patches.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kvm/fpsimd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> > index 84afca5ed6f2..b5f95abd23f5 100644
> > --- a/arch/arm64/kvm/fpsimd.c
> > +++ b/arch/arm64/kvm/fpsimd.c
> > @@ -121,10 +121,10 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
> >  	local_irq_save(flags);
> >  
> >  	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
> > -		fpsimd_save_and_flush_cpu_state();
> > -
> >  		if (guest_has_sve)
> >  			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
> > +
> > +		fpsimd_save_and_flush_cpu_state();
> 
> I _think_ fpsimd_save_and_flush_cpu_state() contains a RDVL instruction
> to get at the vector length for sve_get_vl(), and this ends up reading from
> ZCR_EL1. So I'm not sure it's save to move it like this.

Duh, we're not changing the register here, but just saving it off. So it's
fine:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
