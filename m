Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AFE00653575
	for <lists+kvmarm@lfdr.de>; Wed, 21 Dec 2022 18:43:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E062B4B86D;
	Wed, 21 Dec 2022 12:43:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dHmGikGJdd-2; Wed, 21 Dec 2022 12:43:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F4264B8A6;
	Wed, 21 Dec 2022 12:43:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EFCF24B269
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Dec 2022 12:43:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lniI-LyGZtSA for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Dec 2022 12:43:09 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6007E40E76
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Dec 2022 12:43:09 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1CF4DB81B92;
 Wed, 21 Dec 2022 17:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09B9C433D2;
 Wed, 21 Dec 2022 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671644586;
 bh=c6+zdcvnGWSlQMr7XAbCecefyK6/9YWJKEvEz0Wazpo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=r42H7GUfGRymqIfNvm8bPKU/RkBi0QJLX7WcVzLhLCgyLkXlGfAjOSnWKX7GVphW6
 SkVIpg0mFnCh0J+XVDsNKs+Vjvph6bto2t2EfSx08FP1g0YcYnUuB/zwQzBhc2OdxQ
 1WUpY/jYgTiIxtFqD7YY2T7uY3nXnpn+eE9JeDz25aBXqAr7tQg3YLq+sbeICZH0UN
 7NS/9EsxxqUw2KRL4fOvMxg/oXTn2tz+a5G0WEC/ktTHy/8pggyQvZGLk2JQ7r5NUN
 OXVIHXQjAPZ5YGb71uct/nE5mZatfbwjSXg/wsgBmGEdtzt+/4TwXaTZU2kkSCyUk+
 vov6Ko4u/54lw==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1p837Q-00ECbS-Fw;
 Wed, 21 Dec 2022 17:43:04 +0000
Date: Wed, 21 Dec 2022 17:43:03 +0000
Message-ID: <86len0bql4.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH 2/3] KVM: arm64: Handle S1PTW translation with TCR_HA set
 as a write
In-Reply-To: <Y6M4TqvJytAEq2ID@google.com>
References: <20221220200923.1532710-1-maz@kernel.org>
 <20221220200923.1532710-3-maz@kernel.org>
 <Y6M4TqvJytAEq2ID@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ricarkol@google.com, kvmarm@lists.cs.columbia.edu,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
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

Hi Ricardo,

On Wed, 21 Dec 2022 16:46:06 +0000,
Ricardo Koller <ricarkol@google.com> wrote:
> 
> Hello,
> 
> On Tue, Dec 20, 2022 at 08:09:22PM +0000, Marc Zyngier wrote:
> > As a minor optimisation, we can retrofit the "S1PTW is a write
> > even on translation fault" concept *if* the vcpu is using the
> > HW-managed Access Flag, as setting TCR_EL1.HA is guaranteed
> > to result in an update of the PTE.
> > 
> > However, we cannot do the same thing for DB, as it would require
> > us to parse the PTs to find out if the DBM bit is set there.
> > This is not going to happen.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_emulate.h | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index fd6ad8b21f85..4ee467065042 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -374,6 +374,9 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
> >  static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
> >  {
> >  	if (kvm_vcpu_abt_iss1tw(vcpu)) {
> > +		unsigned int afdb;
> > +		u64 mmfr1;
> > +
> >  		/*
> >  		 * Only a permission fault on a S1PTW should be
> >  		 * considered as a write. Otherwise, page tables baked
> > @@ -385,12 +388,27 @@ static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
> >  		 * to map the page containing the PT (read only at
> >  		 * first), then a permission fault to allow the flags
> >  		 * to be set.
> > +		 *
> > +		 * We can improve things if the guest uses AF, as this
> > +		 * is guaranteed to result in a write to the PTE. For
> > +		 * DB, however, we'd need to parse the guest's PTs,
> > +		 * and that's not on. DB is crap anyway.
> >  		 */
> >  		switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
> 
> Nit: fault_status is calculated once when taking the fault, and passed
> around to all users (like user_mem_abort()). Not sure if this is because
> of the extra cycles needed to get it, or just style. Anyway, maybe it
> applies here.

All these things are just fields in ESR_EL2, which we keep looking at
all the time. The compiler actually does a pretty good job at keeping
that around, specially considering that this function is inlined (at
least here, kvm_handle_guest_abort and kvm_user_mem_abort are merged
into a single monster).

So passing the parameter wouldn't change a thing, and I find the above
more readable (I know that all the information in this function are
derived from the same data structure).

> 
> >  		case ESR_ELx_FSC_PERM:
> >  			return true;
> >  		default:
> > -			return false;
> > +			/* Can't introspect TCR_EL1 with pKVM */
> > +			if (kvm_vm_is_protected(vcpu->kvm))
> > +				return false;
> > +
> > +			mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> > +			afdb = cpuid_feature_extract_unsigned_field(mmfr1, ID_AA64MMFR1_EL1_HAFDBS_SHIFT);
> > +
> > +			if (afdb == ID_AA64MMFR1_EL1_HAFDBS_NI)
> > +				return false;
> > +
> > +			return (vcpu_read_sys_reg(vcpu, TCR_EL1) & TCR_HA);
> 
> Also tested this specific case using page_fault_test when the PT page is
> marked for dirty logging with and without AF. In both cases there's a
> single _FSC_FAULT (no PERM_FAUT) as expected, and the PT page is marked dirty
> in the AF case. The RO and UFFD cases also work as expected.

Ah, thanks for checking this.

> 
> Need to send some changes for page_fault_test as many tests assume that
> any S1PTW is always a PT write, and are failing. Also need to add some new
> tests for PTs in RO memslots (as it didn't make much sense before this
> change).

I think this is what I really quite didn't grok in these tests. They
seem to verify the KVM behaviour, which is not what we should check
for.

Instead, we should check for the architectural behaviour, which is
that if HAFDBS is enabled, we can observe updates to the PTs even when
we do not write to them directly.

> 
> >  		}
> >  	}
> >  
> > -- 
> > 2.34.1
> > 
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
> Reviewed-by: Ricardo Koller <ricarkol@google.com>

Thanks!

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
