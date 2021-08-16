Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C942A3EDF50
	for <lists+kvmarm@lfdr.de>; Mon, 16 Aug 2021 23:30:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C75E4B100;
	Mon, 16 Aug 2021 17:30:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VEQ2AI44vLHc; Mon, 16 Aug 2021 17:30:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4589D4B115;
	Mon, 16 Aug 2021 17:30:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 427384B091
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Aug 2021 16:01:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ciZ3yJVSiR+e for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Aug 2021 16:01:13 -0400 (EDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2BD844B08A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Aug 2021 16:01:13 -0400 (EDT)
Received: by mail-vs1-f46.google.com with SMTP id f13so3343879vsl.13
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Aug 2021 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/KwqlZeT6sdGRreX5g/ke/YMCXwSEo7rp8jOlCMxsII=;
 b=mwdSDvWVIjvElZeYJ1YVAkD625BhTxrGwgCGPtGfzVVFj5UFz7ScpbHXnydzovM1vP
 BJ+axQl4nEU4wZJrpsSc5OkDPMXIS8f797JO2zCwFnhDH9rVz/PbVoqPggcufln3CPRo
 uC5KIxcBFNbdxVURt2NmdkT+8YaMmGaT1s4I39BmyKCOvPZmCL7iHW1BSbHcb6cnbtUD
 42SM2ypUxKkEl7j/69NEOpyMr624OI4qWWlIjMlJ9yutTN/YO5MG4s+CXb80XJUSIpTE
 2X6qTZIRp1c7Ldk40dyAbgFKkfI3y9YCVF3knkWftif0DugP9qDBWnSAABR+lZaKLCQE
 +rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/KwqlZeT6sdGRreX5g/ke/YMCXwSEo7rp8jOlCMxsII=;
 b=gPCPpUzXVTJnPiqAtFvZViZejr5y5ejsSINUqkMU2GuA3HmANo2/fomvJADbBHfUin
 XBs/RBEHdhhCYssCqE0aaWdX136hFoB5D6u88Dc2id3tGYLu4cS8jN22vjcf3nd0jDeG
 S3HmEmYscEgQtMj5jRIYItA8hRWozNYB2TWKIRYIYew/iSzWo0+kffbzGRn22bfZYWnQ
 1p70G+xsXU//Lvhe/8RokF8r8lK2EV46mkWTpOYVCMwzhpsxkIurcMU2+Pk6GKV/M15+
 BGix6GSaURoTWzw3xt6LeFIMZRwTYC6pr1fgMDK7zpLCtYi5rWcfgfX2tSKyPdU3YlzO
 /1Pw==
X-Gm-Message-State: AOAM532bp3O8X4PJ8cJCMz9Ef33KTUhd3abOnzdNo//bXzvC7T3Rhs+A
 9NYYfyZqfSRKi74QVu+erjk2/UROcmMyaDmcnsxGdA==
X-Google-Smtp-Source: ABdhPJynTv01BWxGnAkTuRLxJ40jk1zjrNBPt6FCIz1AgO0PbibFSIyewQo/9Ua+dYvwQmQ2ZPLZIIOLv9nOWuE2siM=
X-Received: by 2002:a67:ec88:: with SMTP id h8mr8108vsp.47.1629144072541; Mon,
 16 Aug 2021 13:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210813211211.2983293-1-rananta@google.com>
 <20210813211211.2983293-5-rananta@google.com>
 <35c06dff-36cf-3836-e469-bedcf3c04a4d@huawei.com>
In-Reply-To: <35c06dff-36cf-3836-e469-bedcf3c04a4d@huawei.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 16 Aug 2021 13:01:01 -0700
Message-ID: <CAJHc60x2XdRKywRytMG-B95ZYd5fdrybau0mXp1UrHngyWiuDA@mail.gmail.com>
Subject: Re: [PATCH 04/10] KVM: arm64: selftests: Add basic support for
 arch_timers
To: Zenghui Yu <yuzenghui@huawei.com>
X-Mailman-Approved-At: Mon, 16 Aug 2021 17:30:36 -0400
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu
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

Hi Zenghui,

On Sat, Aug 14, 2021 at 2:10 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> On 2021/8/14 5:12, Raghavendra Rao Ananta wrote:
> > Add a minimalistic library support to access the virtual timers,
> > that can be used for simple timing functionalities, such as
> > introducing delays in the guest.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  .../kvm/include/aarch64/arch_timer.h          | 138 ++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/include/aarch64/arch_timer.h
> >
> > diff --git a/tools/testing/selftests/kvm/include/aarch64/arch_timer.h b/tools/testing/selftests/kvm/include/aarch64/arch_timer.h
> > new file mode 100644
> > index 000000000000..e6144ab95348
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/aarch64/arch_timer.h
> > @@ -0,0 +1,138 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * ARM Generic Interrupt Controller (GIC) specific defines
>
> This isn't GIC specific, but arch timer.

You are right. That's my bad.
>
>
> > + */
> > +
> > +#ifndef SELFTEST_KVM_ARCH_TIMER_H
> > +#define SELFTEST_KVM_ARCH_TIMER_H
> > +
> > +#include <linux/sizes.h>
>
> Do we really need it?


I must have left it from some code re-org. We don't need it anymore.
Will remove.
>
>
> > +
> > +#include "processor.h"
> > +
> > +enum arch_timer {
> > +     VIRTUAL,
> > +     PHYSICAL,
> > +};
> > +
> > +#define CTL_ENABLE   (1 << 0)
> > +#define CTL_ISTATUS  (1 << 2)
> > +#define CTL_IMASK    (1 << 1)
>
> nitpick: Move CTL_IMASK before CTL_ISTATUS ?


Sure, that's cleaner!
>
>
> > +
> > +#define msec_to_cycles(msec) \
> > +     (timer_get_cntfrq() * (uint64_t)(msec) / 1000)
> > +
> > +#define usec_to_cycles(usec) \
> > +     (timer_get_cntfrq() * (uint64_t)(usec) / 1000000)
> > +
> > +#define cycles_to_usec(cycles) \
> > +     ((uint64_t)(cycles) * 1000000 / timer_get_cntfrq())
> > +
> > +static inline uint32_t timer_get_cntfrq(void)
> > +{
> > +     return read_sysreg(cntfrq_el0);
> > +}
> > +
> > +static inline uint64_t timer_get_cntct(enum arch_timer timer)
> > +{
> > +     isb();
> > +
> > +     switch (timer) {
> > +     case VIRTUAL:
> > +             return read_sysreg(cntvct_el0);
> > +     case PHYSICAL:
> > +             return read_sysreg(cntpct_el0);
> > +     default:
> > +             GUEST_ASSERT_1(0, timer);
> > +     }
> > +
> > +     /* We should not reach here */
> > +     return 0;
> > +}
> > +
> > +static inline void timer_set_cval(enum arch_timer timer, uint64_t cval)
> > +{
> > +     switch (timer) {
> > +     case VIRTUAL:
> > +             return write_sysreg(cntv_cval_el0, cval);
> > +     case PHYSICAL:
> > +             return write_sysreg(cntp_cval_el0, cval);
> > +     default:
> > +             GUEST_ASSERT_1(0, timer);
> > +     }
> > +
> > +     isb();
>
> ISB should be performed before 'return'. And the same for
> timer_set_{tval,ctl}.


Seems like a copy-paste error on my side. The timer_set_*() functions
shouldn't even have a 'return'. Thanks for catching this! Will fix it.
>
>
> Thanks,
> Zenghui


Regards,
Raghavendra
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
