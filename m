Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13431D26B
	for <lists+kvmarm@lfdr.de>; Tue, 16 Feb 2021 23:05:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D62CA4B666;
	Tue, 16 Feb 2021 17:05:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzX4f5Y7mebL; Tue, 16 Feb 2021 17:05:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C58574B65E;
	Tue, 16 Feb 2021 17:05:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EAB094B467
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 17:05:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2wScfMIMamO for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Feb 2021 17:05:48 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 060E54B653
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 17:05:47 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0DF8A64DDA;
 Tue, 16 Feb 2021 22:05:46 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lC8TW-00EVA0-Cw; Tue, 16 Feb 2021 22:05:42 +0000
Date: Tue, 16 Feb 2021 22:05:33 +0000
Message-ID: <87tuqbpt1u.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v3 09/66] KVM: arm64: nv: Support virtual EL2 exceptions
In-Reply-To: <20210129180539.2c508b6e@slackpad.fritz.box>
References: <20201210160002.1407373-1-maz@kernel.org>
 <20201210160002.1407373-10-maz@kernel.org>
 <20210129180539.2c508b6e@slackpad.fritz.box>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, christoffer.dall@arm.com,
 jintack@cs.columbia.edu, alexandru.elisei@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com,
 jintack.lim@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 Jintack Lim <jintack.lim@linaro.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, 29 Jan 2021 18:05:39 +0000,
Andre Przywara <andre.przywara@arm.com> wrote:
> 
> On Thu, 10 Dec 2020 15:59:05 +0000
> Marc Zyngier <maz@kernel.org> wrote:

[...]

> > diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> > index b47df73e98d7..530562eb09fd 100644
> > --- a/arch/arm64/kvm/inject_fault.c
> > +++ b/arch/arm64/kvm/inject_fault.c
> > @@ -14,17 +14,50 @@
> >  #include <asm/kvm_emulate.h>
> >  #include <asm/esr.h>
> >  
> > +static void pend_sync_exception(struct kvm_vcpu *vcpu)
> > +{
> > +	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_ELx_SYNC	|
> > +			     KVM_ARM64_PENDING_EXCEPTION);
> > +
> > +	/* If not nesting, EL1 is the only possible exception target */
> > +	if (likely(!nested_virt_in_use(vcpu))) {
> 
> This breaks compilation for the next 14 patches, because
> nested_virt_in_use() is unknown here. Patch 23/66 fixes this by adding
> kvm_nested.h to kvm_emulate.h.

Indeed, well caught.

> Shall we do this already in this patch here, or pull in kvm_nested.h in
> every C file we use nested_virt_in_use(), like exception.c above?

I've just added kvm_nested.h in the two places that were required at
this stage (and verified that it all bisects correctly now).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
