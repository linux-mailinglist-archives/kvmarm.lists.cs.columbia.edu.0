Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9446A4E5
	for <lists+kvmarm@lfdr.de>; Mon,  6 Dec 2021 19:48:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D30434B0B3;
	Mon,  6 Dec 2021 13:48:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7htee6yCoSu4; Mon,  6 Dec 2021 13:48:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55F114B08A;
	Mon,  6 Dec 2021 13:48:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 468E74A3A5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Dec 2021 13:48:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b+2N0WeNqvhX for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Dec 2021 13:48:04 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B6DEE4A1B0
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Dec 2021 13:48:04 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 458F4B811A3;
 Mon,  6 Dec 2021 18:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCF9C341C1;
 Mon,  6 Dec 2021 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638816482;
 bh=6oJVcJI0NTvbhRn5nQbQbKPJF+DP2AeqgEIEpAEqYfo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=H1q64ZLio0VI6XKQk8L0mLJWnQqiDX9W6f3w7c5ykk/qiTSJGDqtF2F+bVuCIcZOE
 dWd8PAXtBHzybXwe5hXd7h/vOl2Pt3Jyu65jEv1psOfkp9I26IfGaXLgcb9N1bLpD1
 RCrm4O4UVwbwe+kPMsnrOdk4nBId6lr5jEPO0c5eiypSABad9xzEvcb9ry28/OUr3f
 br7X8T8wBHtgkck6TFvQwjXrxtjvtGbYlCuklMw5Wm3VRKzsOoPo1Ht6EL6/qSUJZ4
 x1DMheJZeIWJliDLIPgh7MS7st+CpFtHPibw77woti4fRHcBpqA5tgx0h98EwxE43U
 PCzQ2Bp/l/18w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1muJ1s-00AHeO-6B; Mon, 06 Dec 2021 18:48:00 +0000
Date: Mon, 06 Dec 2021 18:47:59 +0000
Message-ID: <87tufl1sf4.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 3/6] KVM: arm64: Allow guest to set the OSLK bit
In-Reply-To: <CAOQ_QshFFOwyK-Uf3HqHoEpuj5Jv9opUspSmcHdTwkr1vNS1vA@mail.gmail.com>
References: <20211123210109.1605642-1-oupton@google.com>
 <20211123210109.1605642-4-oupton@google.com>
 <87sfvfmb8d.wl-maz@kernel.org>
 <CAOQ_QshFFOwyK-Uf3HqHoEpuj5Jv9opUspSmcHdTwkr1vNS1vA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@google.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, james.morse@arm.com, Alexandru.Elisei@arm.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 drjones@redhat.com, pshier@google.com, ricarkol@google.com, reijiw@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Peter Shier <pshier@google.com>,
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

Hi Oliver,

On Mon, 06 Dec 2021 17:39:05 +0000,
Oliver Upton <oupton@google.com> wrote:
> 
> On Mon, Nov 29, 2021 at 5:51 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Tue, 23 Nov 2021 21:01:06 +0000,
> > Oliver Upton <oupton@google.com> wrote:
> > >
> > > Allow writes to OSLAR and forward the OSLK bit to OSLSR. Do nothing with
> > > the value for now.
> > >
> > > Reviewed-by: Reiji Watanabe <reijiw@google.com>
> > > Signed-off-by: Oliver Upton <oupton@google.com>
> > > ---
> > >  arch/arm64/include/asm/sysreg.h |  6 ++++++
> > >  arch/arm64/kvm/sys_regs.c       | 33 ++++++++++++++++++++++++++-------
> > >  2 files changed, 32 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > > index 16b3f1a1d468..9fad61a82047 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -129,7 +129,13 @@
> > >  #define SYS_DBGWCRn_EL1(n)           sys_reg(2, 0, 0, n, 7)
> > >  #define SYS_MDRAR_EL1                        sys_reg(2, 0, 1, 0, 0)
> > >  #define SYS_OSLAR_EL1                        sys_reg(2, 0, 1, 0, 4)
> > > +
> > > +#define SYS_OSLAR_OSLK                       BIT(0)
> > > +
> > >  #define SYS_OSLSR_EL1                        sys_reg(2, 0, 1, 1, 4)
> > > +
> > > +#define SYS_OSLSR_OSLK                       BIT(1)
> > > +
> > >  #define SYS_OSDLR_EL1                        sys_reg(2, 0, 1, 3, 4)
> > >  #define SYS_DBGPRCR_EL1                      sys_reg(2, 0, 1, 4, 4)
> > >  #define SYS_DBGCLAIMSET_EL1          sys_reg(2, 0, 7, 8, 6)
> > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > > index 7bf350b3d9cd..5dbdb45d6d44 100644
> > > --- a/arch/arm64/kvm/sys_regs.c
> > > +++ b/arch/arm64/kvm/sys_regs.c
> > > @@ -44,6 +44,10 @@
> > >   * 64bit interface.
> > >   */
> > >
> > > +static int reg_from_user(u64 *val, const void __user *uaddr, u64 id);
> > > +static int reg_to_user(void __user *uaddr, const u64 *val, u64 id);
> > > +static u64 sys_reg_to_index(const struct sys_reg_desc *reg);
> > > +
> > >  static bool read_from_write_only(struct kvm_vcpu *vcpu,
> > >                                struct sys_reg_params *params,
> > >                                const struct sys_reg_desc *r)
> > > @@ -287,6 +291,24 @@ static bool trap_loregion(struct kvm_vcpu *vcpu,
> > >       return trap_raz_wi(vcpu, p, r);
> > >  }
> > >
> > > +static bool trap_oslar_el1(struct kvm_vcpu *vcpu,
> > > +                        struct sys_reg_params *p,
> > > +                        const struct sys_reg_desc *r)
> > > +{
> > > +     u64 oslsr;
> > > +
> > > +     if (!p->is_write)
> > > +             return read_from_write_only(vcpu, p, r);
> > > +
> > > +     /* Forward the OSLK bit to OSLSR */
> > > +     oslsr = __vcpu_sys_reg(vcpu, OSLSR_EL1) & ~SYS_OSLSR_OSLK;
> > > +     if (p->regval & SYS_OSLAR_OSLK)
> > > +             oslsr |= SYS_OSLSR_OSLK;
> > > +
> > > +     __vcpu_sys_reg(vcpu, OSLSR_EL1) = oslsr;
> > > +     return true;
> > > +}
> > > +
> > >  static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
> > >                          struct sys_reg_params *p,
> > >                          const struct sys_reg_desc *r)
> > > @@ -309,9 +331,10 @@ static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> > >       if (err)
> > >               return err;
> > >
> > > -     if (val != rd->val)
> > > +     if ((val & ~SYS_OSLSR_OSLK) != rd->val)
> > >               return -EINVAL;
> >
> > This looks odd. It means that once I have set the lock from userspace,
> > I can't clear it?
> 
> This does read weird, but I believe it makes sense still. rd->val is
> the value of the register after warm reset, and does not store the
> current value of the actual register. The true value is stashed in
> kvm_cpu_context. Really, what I'm asserting here is that the only RW
> bit is the OSLK bit. If any of the other bits are changed it should
> return an error.

Ah, the beauty of reading code in patches only. Of course, rd->val is
only the reset value. And isn't called that, just to be confusing.

Apologies for the noise.

> I can either add a comment or make a macro for the expected register
> value (or both) to make this more clear.

A macro for the reset value would certainly be beneficial.

But also, why not check the value against the current state and ignore
the reset state altogether, since by the time you can poke at the
vcpu, it has already been reset? It would certainly be more idiomatic.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
