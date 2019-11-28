Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8F10CE53
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 19:07:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 10F6E4AEBF;
	Thu, 28 Nov 2019 13:07:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGyJN7Nla6FJ; Thu, 28 Nov 2019 13:07:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D47C74AEB3;
	Thu, 28 Nov 2019 13:06:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 12FA14AEAC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 13:06:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZurjpCwidDW for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 13:06:58 -0500 (EST)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 13BB84AEA4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 13:06:58 -0500 (EST)
Received: by mail-ot1-f65.google.com with SMTP id c19so22835573otr.11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MJ/sPAYYo/qIT6Ymk401e7KF1FY+ovzNTYrgqfqtAao=;
 b=ceO8/vrDQ2qOydIvWROnG21GPOQXjsjM2lcssYAr/Un9ibzuSQx2OcRLffVjR3zPzA
 euVSLuH5Lz548pvc9MxMZAkFhKWeWv4h5o/Qdb6InyGjX9x53JeE00vsuWbI1TzId9Bd
 xlFrw5neBnwiXTkXrSzSBveIjG4mJ24IzgNFoxMwc4Ma7gPjF0c5+UuxFCZyFGpBn15Z
 IqthMaHfqKFC15Ac8mS7MIm+UmVOVg3AYRCDKwKk8yFFdn7/44wsPLdVKHshOb3snQir
 4dLhMUOs1e7xN0WDxanGDSIVELGf/bfAW9dlSECX5lLdhb5rZ0GejbmQ5TtGyoMtwSMY
 NLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJ/sPAYYo/qIT6Ymk401e7KF1FY+ovzNTYrgqfqtAao=;
 b=jQtDD4nMrNnvQWkGOEemiPWo4y6yqyHGGov3AWVsrWJ1T5QnSH79L1qmGmr3PkUr5w
 KgQWL+gwKyUjBcW1ja3wM/V94irOSjZJm8b8ryGv0I8PwNKnP+7stN1Xe7F2Rv3cDM36
 ma8WLJ8YZVW/gkADW/6Q3DyyrBEO049hc57YWQDAyJG/RgqCKdUV5lTnqDqgiiFk7qtX
 BR228jQ/4fjUiL/1gxy8pkeTsDmjS4m9LuBd2Y9DWcDp/2PvCJlLQ3S/lJJkIZ72f11z
 Gdhe91rPbm7DzcfQYVGK740Lo0+fyN1IB3Cj3pemWsSuL+n2vzHeUhxBLguGnMAjk5W8
 T5IQ==
X-Gm-Message-State: APjAAAVteVRXV5vq9m3onzgB7olVstXAGKO7MCjIsYKDe2seDLY4OFJW
 +FCb5fk0GsHIXqPp2B5iwVDm3wqAPmccB1wg1AjK2g==
X-Google-Smtp-Source: APXvYqxKt6orc45dUEB80sWtPH3EOZaBWL5mcL78hz6t2FcSeKfkc4eWV9sd8pVJf+Hx1HeefjCsanKuSB6IJOjlkFk=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr8682308otg.232.1574964417343; 
 Thu, 28 Nov 2019 10:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20191128161718.24361-1-maz@kernel.org>
 <20191128161718.24361-4-maz@kernel.org>
 <CAFEAcA_MED0Rtqo1=HNnn7v_zQZGDsoJVsbXAsdhb_sAjvJ40Q@mail.gmail.com>
 <241a27adc76f3f6dcc96c3ef993660f7@www.loen.fr>
In-Reply-To: <241a27adc76f3f6dcc96c3ef993660f7@www.loen.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2019 18:06:46 +0000
Message-ID: <CAFEAcA9yryMgAgNbbST4ThT_ozpBUm=Lj5C33ZBP_Q8OYiV_=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: Marc Zyngier <maz@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
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

On Thu, 28 Nov 2019 at 17:49, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Peter,
>
> Thanks for having a look at this.
>
> On 2019-11-28 16:43, Peter Maydell wrote:
> > On Thu, 28 Nov 2019 at 16:17, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
> >> EL2, and that HCR_EL2.TID0 does the same for reads of FPSID.
> >> In order to handle this, introduce a new TCG helper function that
> >> checks for these control bits before executing the VMRC instruction.
> >>
> >> Tested with a hacked-up version of KVM/arm64 that sets the control
> >> bits for 32bit guests.
> >>
> >> Signed-off-by: Marc Zyngier <maz@kernel.org>

> > Since the syndrome value depends only on these two things,
> > you might as well generate the full syndrome value at
> > translate time rather than doing it at runtime; then
> > you only need to pass one thing through to the helper rather
> > than two.
>
> OK. This means that the register check in check_hcr_el2_trap
> will need to extract the register value from the syndrome.
> Not a big deal, but maybe slightly less readable.

Oops, I hadn't noticed that we were switching on reg.
Yeah, you might as well leave it as is. (We could have
a separate helper for each of TID0 and TID3 but that
seems like overkill.)

> On a vaguely tangential subject, how are conditional instructions
> JIT-ed? I could perfectly imagine a conditional VMRS instruction,
> but none of the code I looked at seem to care about it. Or is
> that done before the access itself is actually emitted?

Arm conditional instructions are handled at a pretty
high level in the decode, because they all work the same way.
In disas_arm_insn() we have:

    if (cond != 0xe) {
        /* if not always execute, we generate a conditional jump to
           next instruction */
        arm_skip_unless(s, cond);
    }

and there's something similar in thumb_tr_translate_insn()
which puts in a branch based on the thumb condexec bits.
The target of the branch is a label whose position is
set either in arm_post_translate_insn() after the code for the
insn is emitted, or in arm_tr_tb_stop() if the insn is
the last in the TB (always true for branch or trap insns).

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
