Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 41142487F86
	for <lists+kvmarm@lfdr.de>; Sat,  8 Jan 2022 00:43:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A6664B29A;
	Fri,  7 Jan 2022 18:43:25 -0500 (EST)
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
	with ESMTP id faSnFCSpoeLT; Fri,  7 Jan 2022 18:43:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15C0F4B21F;
	Fri,  7 Jan 2022 18:43:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FBD84B161
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 18:43:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 56aQeskF4dlo for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jan 2022 18:43:21 -0500 (EST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 79BC94B150
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 18:43:21 -0500 (EST)
Received: by mail-yb1-f169.google.com with SMTP id v186so11691269ybg.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 07 Jan 2022 15:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NVQO0hqDncW10QtXjDHk2S0GMpXvaQ8aqURw+uPH5wg=;
 b=h9pJpcJm/YMBAmJgf1a/hNcRkR8eituMdmkl0QZEo6aDIhoj9bNGkybBY9tLwABtu5
 T47vLXRIGeeLHeBuPozHHi8Pl/RQ9FhfwS4CsX5VbJEm+o+wzusNHWWSGZ6TJZLlaacs
 hFudIJXMhNvmwU+GrNuWtSqOe6shbDP1H4ZddJx+9I6jJuIazgHC+dfsYqqPX1/1YHJJ
 V6XbJI3aB9kMiqAK2jOUT7R604WZYwEtYUsLXxGIeATyYFqTvRlv+xz5DCzxYDdROZ8d
 GJ29YJCzQ0FTF/sStFeSpJgFrnNnSlnbqv7RAH1xaBsdO/kGKvx5sEJyEQJfFtB47w1k
 IEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NVQO0hqDncW10QtXjDHk2S0GMpXvaQ8aqURw+uPH5wg=;
 b=hZdOWGlkcQNkvK5GtbChdf/NSHy5epSTaDuA1xOTraKy0/lg3PFfJ7C5igcAHU8uRk
 GspRwEbuV7xI7znEHoJzVelEzMJFByLllD0k6l2qU8sL05PTWh4Ee44V+PO+RYJ1BdbE
 BrGqIuU/8xB96zl4VXpJ5/t4Kzih3v5oxicP4CwwyY01OY4b2htPVnkZ77chvEweq/t6
 DJyQtJ1TMeys50fRVeOnqILd9EEvLmTI2Rw5fZfDM752uz4X7OxWlW/zZL5cs5lCsUZW
 t/HrhPBx8/TBB+ehMTWR0A9TJx13cF/KAJ129d8kbxQGIdMSMa9Hq8yo/VTQc25VRGgI
 V2hQ==
X-Gm-Message-State: AOAM532Y3FGq1yhBOIVjCbfMATullI5IgF+my0YHibnCU6ITyHN4WBuP
 WkRFsdElCKl5FwKF1zre2onSujAvrv1/P+z7nvwaLg==
X-Google-Smtp-Source: ABdhPJyZoQctE8XarHYHTzHFEcdEszvQRqEN4nBFLuAThhkJYA2F4ThxIao4CKuearoh3PucipTEnVqNvqht/yFdp+Q=
X-Received: by 2002:a25:c841:: with SMTP id y62mr35443827ybf.196.1641599000772; 
 Fri, 07 Jan 2022 15:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
 <20220104194918.373612-2-rananta@google.com>
 <CAAeT=Fxyct=WLUvfbpROKwB9huyt+QdJnKTaj8c5NKk+UY51WQ@mail.gmail.com>
In-Reply-To: <CAAeT=Fxyct=WLUvfbpROKwB9huyt+QdJnKTaj8c5NKk+UY51WQ@mail.gmail.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Fri, 7 Jan 2022 15:43:08 -0800
Message-ID: <CAJHc60za+E-zEO5v2QeKuifoXznPnt5n--g1dAN5jgsuq+SxrA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] KVM: Capture VM start
To: Reiji Watanabe <reijiw@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Reiji,

On Thu, Jan 6, 2022 at 10:07 PM Reiji Watanabe <reijiw@google.com> wrote:
>
> Hi Raghu,
>
> On Tue, Jan 4, 2022 at 11:49 AM Raghavendra Rao Ananta
> <rananta@google.com> wrote:
> >
> > Capture the start of the KVM VM, which is basically the
> > start of any vCPU run. This state of the VM is helpful
> > in the upcoming patches to prevent user-space from
> > configuring certain VM features after the VM has started
> > running.
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
> >         struct notifier_block pm_notifier;
> >  #endif
> >         char stats_id[KVM_STATS_NAME_SIZE];
> > +       bool vm_started;
>
> Since KVM_RUN on any vCPUs doesn't necessarily mean that the VM
> started yet, the name might be a bit misleading IMHO.  I would
> think 'has_run_once' or 'ran_once' might be more clear (?).
>
I always struggle with the names; but if you feel that 'ran_once'
makes more sense for a reader, I can change it.
>
> >  };
> >
> >  #define kvm_err(fmt, ...) \
> > @@ -1666,6 +1667,8 @@ static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
> >         }
> >  }
> >
> > +#define kvm_vm_has_started(kvm) (kvm->vm_started)
> > +
> >  extern bool kvm_rebooting;
> >
> >  extern unsigned int halt_poll_ns;
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 72c4e6b39389..962b91ac2064 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3686,6 +3686,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >         int r;
> >         struct kvm_fpu *fpu = NULL;
> >         struct kvm_sregs *kvm_sregs = NULL;
> > +       struct kvm *kvm = vcpu->kvm;
> >
> >         if (vcpu->kvm->mm != current->mm || vcpu->kvm->vm_dead)
> >                 return -EIO;
> > @@ -3723,6 +3724,14 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >                         if (oldpid)
> >                                 synchronize_rcu();
> >                         put_pid(oldpid);
> > +
> > +                       /*
> > +                        * Since we land here even on the first vCPU run,
> > +                        * we can mark that the VM has started running.
> > +                        */
>
> It might be nicer to add a comment why the code below gets kvm->lock.
>
I've been going back and forth on this one. Initially I considered
simply going with atomic_t, but the patch 4/11 (KVM: arm64: Setup a
framework for hypercall bitmap firmware registers)
kvm_arm_set_fw_reg_bmap()'s implementation felt like we need a lock to
have the whole 'is the register busy?' operation atomic. But, that's
just one of the applications.
> Anyway, the patch generally looks good to me, and thank you
> for making this change (it works for my purpose as well).
>
> Reviewed-by: Reiji Watanabe <reijiw@google.com>
>
Glad that it's helping you as well and thanks for the review.

Regards,
Raghavendra

> Thanks,
> Reiji
>
>
> > +                       mutex_lock(&kvm->lock);
> > +                       kvm->vm_started = true;
> > +                       mutex_unlock(&kvm->lock);
> >                 }
> >                 r = kvm_arch_vcpu_ioctl_run(vcpu);
> >                 trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
> > --
> > 2.34.1.448.ga2b2bfdf31-goog
> >
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
