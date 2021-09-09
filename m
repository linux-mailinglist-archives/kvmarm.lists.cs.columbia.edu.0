Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 85541405B0D
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 18:41:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 124424B105;
	Thu,  9 Sep 2021 12:41:17 -0400 (EDT)
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
	with ESMTP id HAw6laQ5-Ejv; Thu,  9 Sep 2021 12:41:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E9B24B0ED;
	Thu,  9 Sep 2021 12:41:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DEBB405A6
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 12:41:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rtzN8NzIcpWN for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 12:41:13 -0400 (EDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5368340256
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 12:41:13 -0400 (EDT)
Received: by mail-yb1-f169.google.com with SMTP id v10so5127301ybm.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Sep 2021 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rkaCWrw71p3Bwx6Ujv9uVMcrBmBnNtWcMasEZoICUtg=;
 b=dk7XG+iTfUp9mJk61u0tbmxR8do9bhReeJEjxKWTkr7mk6yTeOo7oOAKTzW88D5oFt
 xB3/uaxC9EeaQ6xD311r2INEWMUDkeiAuOB+xS8kTK3BZlL9vZg+qv11MC8fIYro0Y4+
 WfNT0EiCYoxOUvMMnieVkaTDR7VLJRWw+bB15aRVuHemdxOCnanUy2kYvJuB9NIKfh4o
 yda8xdXzMwYTPZic6D+AD0ISZbeH/iymz9UQLkkpW2qaQZb1K7fQEC6ak7TXPknEKug/
 3XeamAAIRYw/SneBt3ifDaLJvdeuAZPpwlrp1gEJMOdbHBkld1bFwMCm5ZjFc+k35XgZ
 1W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rkaCWrw71p3Bwx6Ujv9uVMcrBmBnNtWcMasEZoICUtg=;
 b=uFon/v2XyGn5bCUGg/UHUxUy+iTJ+RJY8doiyN/+sqFO8Bs4NWXUc12fLpWqI1CyJ4
 Iqn/QuMwlFFpXMnPwJMhh2j94KF11AYsZMWqDeQQ6nKFX/qkesumn4CpDh3Cs/BwDa5r
 MCWU+8/U0IZQ+UYzXOTMZvClYA7H/xLeUJgiJWUpkeyG7kMISzzy9y7Mk+SA+0/+gLb0
 pv750QdwTj4q7R7+oxm1YooY14bTJ8NxvAafSNB+5UtvzV4DFjEVsCysN/W1Q3ctMDJN
 tlCamT4fB3tIfqhwJSFUw3mLEBXizHg5KtoSIOSu4OADFXzSOwI2Eod/tvAAXFvFWcYX
 4Fbg==
X-Gm-Message-State: AOAM531Jp0RXdhPkmjxMHoxGhu2Vq4mFjM2Yi82Qw/qqF40440gZ3eN7
 jsqnfpMteScmRIVYMUrgfToghm5BNmV/N780uh8ZbA==
X-Google-Smtp-Source: ABdhPJxOb0z3ulldpbOkQOCns5TrLa7bWBtK5lyZgAwd9CnftUY48Lnurh5DsoueF+EhVX32OlwRpYEDMSkKxKNuJeE=
X-Received: by 2002:a25:8093:: with SMTP id n19mr5184637ybk.414.1631205672615; 
 Thu, 09 Sep 2021 09:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-19-rananta@google.com>
 <YTmdUEcbvf/7mkOw@google.com>
In-Reply-To: <YTmdUEcbvf/7mkOw@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 9 Sep 2021 09:41:00 -0700
Message-ID: <CAJHc60yi8Dk8d67Gd=_UJRz+71vz0LZZC_TrCE5=kqyRTwBKoA@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] KVM: selftests: vgic_init: Pull
 REDIST_REGION_ATTR_ADDR from vgic.h
To: Oliver Upton <oupton@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

On Wed, Sep 8, 2021 at 10:36 PM Oliver Upton <oupton@google.com> wrote:
>
> On Thu, Sep 09, 2021 at 01:38:18AM +0000, Raghavendra Rao Ananta wrote:
> > Pull the definition of REDIST_REGION_ATTR_ADDR from vgic.h.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  tools/testing/selftests/kvm/aarch64/vgic_init.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Just squash this into the commit where you hoist it into vgic.h. It is
> fine to glob it together with the other vgic changes since you're
> dropping it into a completely new header file.
>
Sure, I'll squash it.

Regards,
Raghavendra
> --
> Thanks,
> Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
