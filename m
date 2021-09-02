Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D78D93FF449
	for <lists+kvmarm@lfdr.de>; Thu,  2 Sep 2021 21:41:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2636B4B0F3;
	Thu,  2 Sep 2021 15:41:52 -0400 (EDT)
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
	with ESMTP id wMPpGH2fdzOT; Thu,  2 Sep 2021 15:41:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B81964B0A3;
	Thu,  2 Sep 2021 15:41:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 353914B0A3
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Sep 2021 15:41:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WBGD3ZeErnVV for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Sep 2021 15:41:48 -0400 (EDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D86944B0A0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Sep 2021 15:41:47 -0400 (EDT)
Received: by mail-lj1-f177.google.com with SMTP id f2so5681148ljn.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 02 Sep 2021 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ADrMhTmPrgZbNnM++pu1uoBNav1T6vaZhzMfabX6fg8=;
 b=hO5FKzGplclg/n5vIngJvh6FKIQEXfVeBPrT6JowB2p5Ecz0xWFtPqVmDg/wE1QXjt
 xo+GELyqZ0PZgrgCgSvNKjVyo63+tYKZOotWClNQYtoMAOjByiKzcCSMDiYy8w6Yct05
 2C4nGmqs8SM0fk5maL5+R4jbU/DLMCY0c4hI1nYTCjOUnlNfbts5uZtQ3nGzDfBiqRwp
 mkQrSouEqQhavMgpc37b4Z+iBlJWbpRd/oE3b9gbw4T/iK0UWO6W07ErDgbMJA5n5XxW
 9gADtevCBdTeQImZ6PPBxw2lW2sZ3V4xtJHKHuwh28zQ2jlkXwwqjOezg/4UkLnCOy8Q
 DyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ADrMhTmPrgZbNnM++pu1uoBNav1T6vaZhzMfabX6fg8=;
 b=Rh9M2WpOeJNQ7007wyLwMoEzGE8SF0mZtAzcgwAcKUa2htLIfnZXtG1f9odIcj1IYn
 CSQfvfI9f5V760T3f8mAGcbSKvNql8uKMytQRAoYP95YZq49xEJC+6PGKjypeIk8cBfO
 3A2V70uxzpYOTs91cWuuBZoSzlYTFUuQcb/9U+h/9w5rNuR1tlwRzmJ8CgG0ixbgVpW1
 74jqAsKcloSTdHC4+kOezOtRBZnEUN+zM7/8aYbZQ54eTjnHdCbkfWOkeLXjTCh0Xp4j
 7bjkGeBK5T4+Yj4sX1+BfbdLlwEn3y6P9xJpdnWU/LTVS75ORYBOYuhqpG5Be6DXVZWj
 lXUQ==
X-Gm-Message-State: AOAM530kTS0XcS/hftM1T5E+j+kv6rqdgfyxTUH91Oefzxc3aCziWtN8
 xbpEUIh7AAYECoTUDjrlxVkiyTJ9zkaze3mP87Eh8w==
X-Google-Smtp-Source: ABdhPJyPSRz4pY8zwxiiI7e+q4TcAiErfRzU01m5EtpNay3AZ3717xZk6GJsBJZFBVgzI+rrjERJLrroUnk4yHnGBJo=
X-Received: by 2002:a2e:9615:: with SMTP id v21mr3776932ljh.22.1630611705984; 
 Thu, 02 Sep 2021 12:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210816001130.3059564-1-oupton@google.com>
 <20210816001130.3059564-6-oupton@google.com>
 <YTEkRfTFyoh+HQyT@google.com>
In-Reply-To: <YTEkRfTFyoh+HQyT@google.com>
From: Oliver Upton <oupton@google.com>
Date: Thu, 2 Sep 2021 12:41:33 -0700
Message-ID: <CAOQ_QsjP65fq5+Mc0xP-wejpjugYNxCFOhEecwFhKaDdxDGUJw@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] KVM: x86: Refactor tsc synchronization code
To: Sean Christopherson <seanjc@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

On Thu, Sep 2, 2021 at 12:21 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Aug 16, 2021, Oliver Upton wrote:
> > Refactor kvm_synchronize_tsc to make a new function that allows callers
> > to specify TSC parameters (offset, value, nanoseconds, etc.) explicitly
> > for the sake of participating in TSC synchronization.
> >
> > Signed-off-by: Oliver Upton <oupton@google.com>
> > ---
> > +     struct kvm *kvm = vcpu->kvm;
> > +     bool already_matched;
> > +
> > +     lockdep_assert_held(&kvm->arch.tsc_write_lock);
> > +
> > +     already_matched =
> > +            (vcpu->arch.this_tsc_generation == kvm->arch.cur_tsc_generation);
> > +
>
> ...
>
> > +     if (!matched) {
> > +             /*
> > +              * We split periods of matched TSC writes into generations.
> > +              * For each generation, we track the original measured
> > +              * nanosecond time, offset, and write, so if TSCs are in
> > +              * sync, we can match exact offset, and if not, we can match
> > +              * exact software computation in compute_guest_tsc()
> > +              *
> > +              * These values are tracked in kvm->arch.cur_xxx variables.
> > +              */
> > +             kvm->arch.cur_tsc_generation++;
> > +             kvm->arch.cur_tsc_nsec = ns;
> > +             kvm->arch.cur_tsc_write = tsc;
> > +             kvm->arch.cur_tsc_offset = offset;
> > +
> > +             spin_lock(&kvm->arch.pvclock_gtod_sync_lock);
> > +             kvm->arch.nr_vcpus_matched_tsc = 0;
> > +     } else if (!already_matched) {
> > +             spin_lock(&kvm->arch.pvclock_gtod_sync_lock);
> > +             kvm->arch.nr_vcpus_matched_tsc++;
> > +     }
> > +
> > +     kvm_track_tsc_matching(vcpu);
> > +     spin_unlock(&kvm->arch.pvclock_gtod_sync_lock);
>
> This unlock is imbalanced if matched and already_matched are both true.  It's not
> immediately obvious that that _can't_ happen, and if it truly can't happen then
> conditionally locking is pointless (because it's not actually conditional).
>
> The previous code took the lock unconditionally, I don't see a strong argument
> to change that, e.g. holding it for a few extra cycles while kvm->arch.cur_tsc_*
> are updated is unlikely to be noticable.

We may have gone full circle here :-) You had said it was confusing to
hold the lock when updating kvm->arch.cur_tsc_* a while back. I do
still agree with that sentiment, but the conditional locking is odd.

> If you really want to delay taking the locking, you could do
>
>         if (!matched) {
>                 kvm->arch.cur_tsc_generation++;
>                 kvm->arch.cur_tsc_nsec = ns;
>                 kvm->arch.cur_tsc_write = data;
>                 kvm->arch.cur_tsc_offset = offset;
>         }
>
>         spin_lock(&kvm->arch.pvclock_gtod_sync_lock);
>         if (!matched)
>                 kvm->arch.nr_vcpus_matched_tsc = 0;
>         else if (!already_matched)
>                 kvm->arch.nr_vcpus_matched_tsc++;
>         spin_unlock(&kvm->arch.pvclock_gtod_sync_lock);

This seems the most readable, making it clear what is guarded and what
is not. I'll probably go this route.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
