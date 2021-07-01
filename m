Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F63B92D5
	for <lists+kvmarm@lfdr.de>; Thu,  1 Jul 2021 16:06:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA1094A95C;
	Thu,  1 Jul 2021 10:06:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U06DrCR0c89q; Thu,  1 Jul 2021 10:06:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B80824A4A0;
	Thu,  1 Jul 2021 10:06:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E911E4A198
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Jul 2021 10:06:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qnJWMY1-8JYY for <kvmarm@lists.cs.columbia.edu>;
 Thu,  1 Jul 2021 10:06:13 -0400 (EDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F33BB49E57
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Jul 2021 10:06:12 -0400 (EDT)
Received: by mail-oi1-f176.google.com with SMTP id 22so7364614oix.10
 for <kvmarm@lists.cs.columbia.edu>; Thu, 01 Jul 2021 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q/b9vCdaygIeC9vS+9fQyLbUZfa/vZYnTPImcqjbsh8=;
 b=ksCzG/IeP/UoPwvYZdwDBDxKJ8hIaPHWqofvRsIE/wb9CVnBKeR5t5mse57PdaYsAh
 tLI8c8sM949fzJK4Yj1l9X0FcXA+zMSUx596TBcD+5Mah5WOfDLU3C7J/n7FQTDQEP/c
 oxn//xhz3I20ipBBQ8gX5P8H0m7+Qs8W3CTqKAO81/0KsWFHqEeooJq4mMDOp+Jl2dyj
 MtSG3xAq+iBBLyBueeZ7SgX5kNEBiTURDZjLfnYzoSHUyJiK9bVQ1sKP2K60HaGFKaXs
 /T0UOBpMxLoUPlFna11/qxMiasGetBrymjp+cTxFvDHT1Srj1F78sjYvJ+kJ96hsBZfV
 3p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q/b9vCdaygIeC9vS+9fQyLbUZfa/vZYnTPImcqjbsh8=;
 b=IFrpAOwjfYDKCnI3E9nEmhTl3mg+nwpwQkinmn0y57YurUZZ41cZUfnQD3TfgoIdrR
 NokBks7074zOL3yNgqgsifqVULmAmXNP6CTn1L7Z7vWke1rwcO6ayOlWItqsyJB4o6gZ
 VpKv819S5ynVha3PV+8S4bttXmlGLkyoz2up1k6hZEKDtwRO2KF6clt7anHH9y/KRGc0
 qPP8YwN4CsfVhMdsNl5uLvMG9LVBi9KnjVRXS1wyCMCEh+aPgWAcS1vjCvL5b+UFG9l7
 gT/Oz0lfXbPA1vR7OSDp2GO7ngV4kMgQyFk8p82DV0+9b5PRiuGvAPFSdSC+impn/mNC
 wIcw==
X-Gm-Message-State: AOAM5303MumROLxq+XUWCcEOeyGpdO46mXuWiYw1bNk51ErWwlOwuJkl
 MAWtHaywO9rQecdakZBDB3JcXuU0nr/Qy07w6A/TeA==
X-Google-Smtp-Source: ABdhPJzI/BKso2x8AyD9Q/UTkch0ZJ9wgWGbbMKgkUK6Bpyt1APbz443A8LFMEfbhFxJFICJaBq5ODSCKCpVoznMYDE=
X-Received: by 2002:aca:b38a:: with SMTP id c132mr29463575oif.90.1625148372285; 
 Thu, 01 Jul 2021 07:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210615133950.693489-1-tabba@google.com>
 <20210615133950.693489-6-tabba@google.com>
 <20210701131733.GE9757@willie-the-truck>
In-Reply-To: <20210701131733.GE9757@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 1 Jul 2021 15:05:35 +0100
Message-ID: <CA+EHjTw3F6uCTJMVQRn0xXzAH1k4HYJr92jRLyjiFXfueqWDSQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] KVM: arm64: Restore mdcr_el2 from vcpu
To: Will Deacon <will@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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

Hi Will,

On Thu, Jul 1, 2021 at 2:17 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 15, 2021 at 02:39:42PM +0100, Fuad Tabba wrote:
> > On deactivating traps, restore the value of mdcr_el2 from the
> > vcpu context, rather than directly reading the hardware register.
> > Currently, the two values are the same, i.e., the hardware
> > register and the vcpu one. A future patch will be changing the
> > value of mdcr_el2 on activating traps, and this ensures that its
> > value will be restored.
> >
> > No functional change intended.
> >
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/switch.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> > index f7af9688c1f7..430b5bae8761 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > @@ -73,7 +73,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
> >
> >       ___deactivate_traps(vcpu);
> >
> > -     mdcr_el2 = read_sysreg(mdcr_el2);
> > +     mdcr_el2 = vcpu->arch.mdcr_el2;
>
> Do you need to change the VHE code too?

No. The code that would toggle mdcr_el2 only affects nvhe and only in
protected mode.

Cheers,
/fuad

>
> Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
