Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 219E348A38C
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jan 2022 00:24:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 88E044B13A;
	Mon, 10 Jan 2022 18:24:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UuiA7kns3kCx; Mon, 10 Jan 2022 18:24:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2ECD24B139;
	Mon, 10 Jan 2022 18:24:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8FB14B0B9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 18:23:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sIDqv6I5LSbO for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Jan 2022 18:23:58 -0500 (EST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 801904B133
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 18:23:58 -0500 (EST)
Received: by mail-yb1-f182.google.com with SMTP id 127so26210403ybb.4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 15:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2g1hbad4Ezo/DEI6dD8aLA+EdL+7wxXqyuFafbp6z7Q=;
 b=oM55QpMEWMcvOqaoBxInuJtySCBl6PW7f7mAJVErZF/Edaw25Fs3NnxBEJGutKpThM
 NaMCG+wYGHuROiIcWOSChJyZdCvgXhoIPl01LYbl3tcfPCyVLadaFRSVb3VoxGMW80D/
 ZITS7pnXfImw/rEfW1PwvZMzxk43Vw9o6paseMqNBSYkkV0CrHC9eOmg8mdCrZ1ulUQm
 hDge8Dig10AO1msI2UMUwgnnmnRU1I83ydBHfrFYy7asvInQuDd+xUhLhqYQg4u0W4Vm
 rScD8sdocOnCM923CAOopu0+gVHJ2fr9/sFxjd/vmInLMWavXstJvLkA7DsctY0vjSxz
 hKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2g1hbad4Ezo/DEI6dD8aLA+EdL+7wxXqyuFafbp6z7Q=;
 b=4QdvWpT89t5u7LSVcR0WFht6y0rR4LSRgF4tpPtHeuR2Z3wke/JbAefqKj3cCOXaXD
 Q/ljX2Pri5UEJLZttnGXU/K5CkzxdArAMHkTMzkrkCmYnDrkgn9I81tmFZGFsKHWGdG/
 4H1Hhs0i+56lWEOg1zectWFyL72nzkWKlJ6Rf8YeTYzAyukDDQITV4LDhv4iHYHuXASt
 rOgGt7bURmjuYr0I2CBzW4gsakjAbbJ4RGMBeBHf9YZnd6aV0zwPhWvNRF869+NN8cCL
 +7PeYYyGyxoNB/NNvrckMz3H9tyhH2+w5DdcXSB2tVXC29kzhQDd1rcqCbC88ntoO4p+
 Bcew==
X-Gm-Message-State: AOAM533O7xaKzt89SfcozGpRRJ11aOyDlG+/bWkIkAcc9waPG7/j8BGh
 V4Ar55DdxUS4DEioaIM5HNP0lLLehN66r9Rhuo1SFQ==
X-Google-Smtp-Source: ABdhPJz5so6Chi1+nIiR5l3idPgrT/QBMsfnjZlAPbMETIEUAr95xu0h9jTnoe2QCZEdnEG9W/LLTv4gt3Ndz+8iVXU=
X-Received: by 2002:a25:7e83:: with SMTP id z125mr2770391ybc.446.1641857037793; 
 Mon, 10 Jan 2022 15:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
 <20220104194918.373612-2-rananta@google.com>
 <Ydjje8qBOP3zDOZi@google.com>
In-Reply-To: <Ydjje8qBOP3zDOZi@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 10 Jan 2022 15:23:46 -0800
Message-ID: <CAJHc60ziKv6P4ZmpLXrv+s4DrrDtOwuQRAc4bKcrbR3aNAK5mQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] KVM: Capture VM start
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
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

On Fri, Jan 7, 2022 at 5:06 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jan 04, 2022, Raghavendra Rao Ananta wrote:
> > Capture the start of the KVM VM, which is basically the
>
> Please wrap at ~75 chars.
>
> > start of any vCPU run. This state of the VM is helpful
> > in the upcoming patches to prevent user-space from
> > configuring certain VM features after the VM has started
> > running.
>
> Please provide context of how the flag will be used.  I glanced at the future
> patches, and knowing very little about arm, I was unable to glean useful info
> about exactly who is being prevented from doing what.
>
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  include/linux/kvm_host.h | 3 +++
> >  virt/kvm/kvm_main.c      | 9 +++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index c310648cc8f1..d0bd8f7a026c 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -623,6 +623,7 @@ struct kvm {
> >       struct notifier_block pm_notifier;
> >  #endif
> >       char stats_id[KVM_STATS_NAME_SIZE];
> > +     bool vm_started;
> >  };
> >
> >  #define kvm_err(fmt, ...) \
> > @@ -1666,6 +1667,8 @@ static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
> >       }
> >  }
> >
> > +#define kvm_vm_has_started(kvm) (kvm->vm_started)
>
> Needs parantheses around (kvm), but why bother with a macro?  This is the same
> header that defines struct kvm.
>
No specific reason for creating a macro as such. I can remove it if it
feels noisy.
> > +
> >  extern bool kvm_rebooting;
> >
> >  extern unsigned int halt_poll_ns;
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 72c4e6b39389..962b91ac2064 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3686,6 +3686,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >       int r;
> >       struct kvm_fpu *fpu = NULL;
> >       struct kvm_sregs *kvm_sregs = NULL;
> > +     struct kvm *kvm = vcpu->kvm;
>
> If you're going to bother grabbing kvm, replace the instances below that also do
> vcpu->kvm.
>
> >
> >       if (vcpu->kvm->mm != current->mm || vcpu->kvm->vm_dead)
> >               return -EIO;
> > @@ -3723,6 +3724,14 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >                       if (oldpid)
> >                               synchronize_rcu();
> >                       put_pid(oldpid);
> > +
> > +                     /*
> > +                      * Since we land here even on the first vCPU run,
> > +                      * we can mark that the VM has started running.
>
> Please avoid "we", "us", etc..
>
> "vm_started" is also ambiguous.  If we end up with a flag, then I would prefer a
> much more literal name, a la created_vcpus, e.g. ran_vcpus or something.
>
> > +                      */
> > +                     mutex_lock(&kvm->lock);
>
> This adds unnecessary lock contention when running vCPUs.  The naive solution
> would be:
>                         if (!kvm->vm_started) {
>                                 ...
>                         }
>
Not sure if I understood the solution..

> > +                     kvm->vm_started = true;
> > +                     mutex_unlock(&kvm->lock);
>
> Lastly, why is this in generic KVM?
>
The v1 of the series originally had it in the arm specific code.
However, I was suggested to move it to the generic code since the book
keeping is not arch specific and could be helpful to others too [1].

Thanks for the review. I'll add your other comments as well.

Regards,
Raghavendra

[1]: https://lore.kernel.org/kvmarm/YYMKphExkqttn2w0@google.com/

> >               }
> >               r = kvm_arch_vcpu_ioctl_run(vcpu);
> >               trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
> > --
> > 2.34.1.448.ga2b2bfdf31-goog
> >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
