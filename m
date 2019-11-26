Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5D109F2E
	for <lists+kvmarm@lfdr.de>; Tue, 26 Nov 2019 14:20:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F0464ACC4;
	Tue, 26 Nov 2019 08:20:09 -0500 (EST)
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
	with ESMTP id D6Yv+t-DLnJa; Tue, 26 Nov 2019 08:20:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 568664AC77;
	Tue, 26 Nov 2019 08:20:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 272DF4A8E8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Nov 2019 08:20:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DKcWdx8IAL8w for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Nov 2019 08:20:06 -0500 (EST)
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 343EB4A578
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Nov 2019 08:20:06 -0500 (EST)
Received: by mail-oi1-f195.google.com with SMTP id n14so16535654oie.13
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Nov 2019 05:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FmLdze7rjZ7eUQLNaj/JqouP8Z3PE4LkshvPw0U7Xmk=;
 b=Rb2FJlEr5v765PTffoOINl1/JdqTH3GRaQboSArUxvPz2AQAtoN80vo1PzO2q3BrUJ
 IjwYGTLWeiCsyOHbvyqXuntxegbsaTYVP00/WmFNLEf0AuFg1Bh/8Bu5NwIOAofVk453
 rM5F5AsfZ/IBnM6RObjdUS4uYmA5tcK6LxVQgS0myypuzog9wt+qwnJ+NEiP6ZbcQBP0
 xpLrTDQ3SLTKoxm5S2VFPExdE15yvg0rwythf+ct8M3v++wBjaELgSY8009LGnd1Y80c
 KPUWqfb3r/EpEFvCPbaRa4DlP9Y241zCfzkCFZz/yWd/DkMXXIikj8pEPLC4DFT2AOyf
 yhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FmLdze7rjZ7eUQLNaj/JqouP8Z3PE4LkshvPw0U7Xmk=;
 b=PzmffeX21V3fEB6OCRcuD/enoyVjKcaxeWjp46N3asjnD1r0Ljo7Csa91wZ+Gp7ICo
 e2Q2Xq6b1nghRq8YYPW3CQSkFCevwe83yGRFUNQ3j34QveolA03q/m1ECaFdPt9aH1M8
 NXuJ9LxVHDViYSbKa2TeAL9fHIyFqLUO4OMSOnY3GonIRGZHyXbIcQdsTzk8Ro5mD8Yd
 RUHGO6dAlq1X9SFvs73lq1C4O5yjQPKeHQNFkEuKxo8gWE0NT2pcA8Abfv6HGX/hA3sK
 ctPCMkdgJdyj8kWCJQhLxchLJYQ6hdiXPqiRV4IXvYuBK81tbu2LXqOoQb2qkH9iq4bA
 meNw==
X-Gm-Message-State: APjAAAWCvb8f++s7xnQu2L1gLMOmBism2oS4tsvQTjMZcHR56BXRtIQN
 0NFhDokyOkLFuSfJnGMKeTyTVA3LyeKBRWpJzCV5YA==
X-Google-Smtp-Source: APXvYqwAsUV5d4EQeOYGEEE0nq0UKrxnuMO/LdK4L37drDmsPvsJnlRMz0KwnwoxY5/QR+hy3ZBWRFuMReSfrT2ND0U=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr1740810oij.163.1574774405542; 
 Tue, 26 Nov 2019 05:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20191123115618.29230-1-maz@kernel.org>
 <8f112583-c29c-11e2-c023-f4eb13831894@linaro.org>
In-Reply-To: <8f112583-c29c-11e2-c023-f4eb13831894@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 13:19:54 +0000
Message-ID: <CAFEAcA8LzPyvav_Ycsq_wRv6Joemt881XBB7rUEu4Sw97WUNGg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Honor HCR_EL2.TID3 trapping requirements
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
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

On Tue, 26 Nov 2019 at 10:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/23/19 11:56 AM, Marc Zyngier wrote:
> > +static CPAccessResult access_aa64idreg(CPUARMState *env, const ARMCPRegInfo *ri,
> > +                                       bool isread)
> > +{
> > +    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
> > +        return CP_ACCESS_TRAP_EL2;
> > +    }
> > +
> > +    return CP_ACCESS_OK;
> > +}
> > +
>
> The only thing I would suggest is to call this access_aa64_tid3, because
> tid{0,1,2} also need to be handled in a similar way, and we'll need little
> helper functions for those too.

Good idea, I will make that change also.

-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
