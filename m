Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 610D450B092
	for <lists+kvmarm@lfdr.de>; Fri, 22 Apr 2022 08:29:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 976F24B26E;
	Fri, 22 Apr 2022 02:29:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7xFVTi5-llH; Fri, 22 Apr 2022 02:29:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 207DC4B268;
	Fri, 22 Apr 2022 02:29:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EDE24A369
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 02:29:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUehlwe8FIlp for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 Apr 2022 02:28:58 -0400 (EDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D96F849F1C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 02:28:58 -0400 (EDT)
Received: by mail-oi1-f173.google.com with SMTP id a10so8025077oif.9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Apr 2022 23:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2YWi9PwvVdEM0HB43jsjfg0IWMgD51LMEFZSeiWndxg=;
 b=TBAtKYXaj7gRac0H6foE+CfRBOC3mqIjG1B9A/V3qWahVD90ScAevLFadpzFIfHWMo
 q3v2UcDl8loMG6SKDmWckEoyfW21mWyNaicMhdQDmQmQXcRAAH4QRXapuXpeWx29o169
 jYLSRV6n5jSJTtsKIT0HI1ZWGqaOVIhxiSNtOa8cycp14GqJuQUo7w6cNcUPBnJxeGBo
 xRK2BNTMCgxw/mtQpHEz5ALhkYO0lr52xW9j+xAxvLaqHrzRIbujq4ZaUD64f/35db7D
 BXxaw/mZ2Y3UO210yW8LSNDO072F3KhYghpw4FN5eqOKYPv/Y+6Pkz/n8eEX0tI3Woyf
 /q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2YWi9PwvVdEM0HB43jsjfg0IWMgD51LMEFZSeiWndxg=;
 b=Ru4h1QL/jtztAyIQNmXuVbHUzS31H8W8IOs22pYUCDH5MrVcW9OUojG2Oxm57Ne7LM
 Zqg+rbvtQe0b/TXA3O+6A06fLtMD/FZEtyJFnAnaQzE/p9TTrfXeY3d2Ppw3q74OAsrY
 PwNdh07WATcma2ou5v0/7bztQVj8E7aCFvGJFY6KIrI/PopTt7bSSN66u2wUKQlGYftL
 23iZnzrsAC/qId5+iGsbfQuH8rL/10zRt1o4Rmp1k3/ZILdLPHoI/bWsBNcUd5wJEy81
 UzUNNLWOTNGX2J7bt86MM8DxcapGe/DwQ7HqXs8tgDH4Q4tqKtRfsvq3pFdDXaUjTJZJ
 hGCg==
X-Gm-Message-State: AOAM530P0XeTpt8be6k3RoTlTXnMOK3ny8dj7S2jr8R0rAJZIFSJP136
 5QlIVOlMubCT+VXNUqI8/Fll1TWoxYe414cKj+Nv1g==
X-Google-Smtp-Source: ABdhPJxR3crf8EBrlb5/vTF5q+PqdAJqznmICkhS1aNRrg57nagdTceYjBKH6EQVCZzkwygdv7G1n0vmZfih0//G1eQ=
X-Received: by 2002:a05:6808:d4c:b0:322:e7de:fffe with SMTP id
 w12-20020a0568080d4c00b00322e7defffemr5003846oik.107.1650608938033; Thu, 21
 Apr 2022 23:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220409184549.1681189-1-oupton@google.com>
 <20220409184549.1681189-8-oupton@google.com>
 <CAAeT=FzURZmYfsLJnWMXufBiaZ6Wypan+xK4WxOSM=p=kEnYxA@mail.gmail.com>
 <CAOQ_Qsg2oNx8Ke7wGy1sU-5Ruq8uCWMKU5VkvTn=co6oRhhXww@mail.gmail.com>
In-Reply-To: <CAOQ_Qsg2oNx8Ke7wGy1sU-5Ruq8uCWMKU5VkvTn=co6oRhhXww@mail.gmail.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Thu, 21 Apr 2022 23:28:42 -0700
Message-ID: <CAAeT=Fx5Nb0EJ+6825fYxAxF9bK5DHOXNmJiSVGP=JVSbWuCrQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] KVM: arm64: Add support for userspace to suspend
 a vCPU
To: Oliver Upton <oupton@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Peter Shier <pshier@google.com>, kvm-riscv@lists.infradead.org,
 Atish Patra <atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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

Hi Oliver,

On Wed, Apr 20, 2022 at 8:24 PM Oliver Upton <oupton@google.com> wrote:
>
> Hi Reiji,
>
> On Wed, Apr 20, 2022 at 8:13 PM Reiji Watanabe <reijiw@google.com> wrote:
> >
> > Hi Oliver,
> >
> > On Sat, Apr 9, 2022 at 11:46 AM Oliver Upton <oupton@google.com> wrote:
> > >
> > > Introduce a new MP state, KVM_MP_STATE_SUSPENDED, which indicates a vCPU
> > > is in a suspended state. In the suspended state the vCPU will block
> > > until a wakeup event (pending interrupt) is recognized.
> > >
> > > Add a new system event type, KVM_SYSTEM_EVENT_WAKEUP, to indicate to
> > > userspace that KVM has recognized one such wakeup event. It is the
> > > responsibility of userspace to then make the vCPU runnable, or leave it
> > > suspended until the next wakeup event.
> > >
> > > Signed-off-by: Oliver Upton <oupton@google.com>
> > > ---
> > >  Documentation/virt/kvm/api.rst    | 37 +++++++++++++++++++++--
> > >  arch/arm64/include/asm/kvm_host.h |  1 +
> > >  arch/arm64/kvm/arm.c              | 49 +++++++++++++++++++++++++++++++
> > >  include/uapi/linux/kvm.h          |  2 ++
> > >  4 files changed, 87 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > index d13fa6600467..d104e34ad703 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -1476,14 +1476,43 @@ Possible values are:
> > >                                   [s390]
> > >     KVM_MP_STATE_LOAD             the vcpu is in a special load/startup state
> > >                                   [s390]
> > > +   KVM_MP_STATE_SUSPENDED        the vcpu is in a suspend state and is waiting
> > > +                                 for a wakeup event [arm64]
> > >     ==========================    ===============================================
> > >
> > >  On x86, this ioctl is only useful after KVM_CREATE_IRQCHIP. Without an
> > >  in-kernel irqchip, the multiprocessing state must be maintained by userspace on
> > >  these architectures.
> > >
> > > -For arm64/riscv:
> > > -^^^^^^^^^^^^^^^^
> > > +For arm64:
> > > +^^^^^^^^^^
> > > +
> > > +If a vCPU is in the KVM_MP_STATE_SUSPENDED state, KVM will emulate the
> > > +architectural execution of a WFI instruction.
> > > +
> > > +If a wakeup event is recognized, KVM will exit to userspace with a
> > > +KVM_SYSTEM_EVENT exit, where the event type is KVM_SYSTEM_EVENT_WAKEUP. If
> > > +userspace wants to honor the wakeup, it must set the vCPU's MP state to
> > > +KVM_MP_STATE_RUNNABLE. If it does not, KVM will continue to await a wakeup
> > > +event in subsequent calls to KVM_RUN.
> > > +
> > > +.. warning::
> > > +
> > > +     If userspace intends to keep the vCPU in a SUSPENDED state, it is
> > > +     strongly recommended that userspace take action to suppress the
> > > +     wakeup event (such as masking an interrupt). Otherwise, subsequent
> > > +     calls to KVM_RUN will immediately exit with a KVM_SYSTEM_EVENT_WAKEUP
> > > +     event and inadvertently waste CPU cycles.
> > > +
> > > +     Additionally, if userspace takes action to suppress a wakeup event,
> > > +     it is strongly recommended that it also restores the vCPU to its
> > > +     original state when the vCPU is made RUNNABLE again. For example,
> > > +     if userspace masked a pending interrupt to suppress the wakeup,
> > > +     the interrupt should be unmasked before returning control to the
> > > +     guest.
> > > +
> > > +For riscv:
> > > +^^^^^^^^^^
> > >
> > >  The only states that are valid are KVM_MP_STATE_STOPPED and
> > >  KVM_MP_STATE_RUNNABLE which reflect if the vcpu is paused or not.
> > > @@ -5985,6 +6014,7 @@ should put the acknowledged interrupt vector into the 'epr' field.
> > >    #define KVM_SYSTEM_EVENT_SHUTDOWN       1
> > >    #define KVM_SYSTEM_EVENT_RESET          2
> > >    #define KVM_SYSTEM_EVENT_CRASH          3
> > > +  #define KVM_SYSTEM_EVENT_WAKEUP         4
> > >                         __u32 type;
> > >                         __u64 flags;
> > >                 } system_event;
> > > @@ -6009,6 +6039,9 @@ Valid values for 'type' are:
> > >     has requested a crash condition maintenance. Userspace can choose
> > >     to ignore the request, or to gather VM memory core dump and/or
> > >     reset/shutdown of the VM.
> > > + - KVM_SYSTEM_EVENT_WAKEUP -- the exiting vCPU is in a suspended state and
> > > +   KVM has recognized a wakeup event. Userspace may honor this event by
> > > +   marking the exiting vCPU as runnable, or deny it and call KVM_RUN again.
> > >
> > >  Valid flags are:
> > >
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index f3f93d48e21a..46027b9b80ca 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -46,6 +46,7 @@
> > >  #define KVM_REQ_RECORD_STEAL   KVM_ARCH_REQ(3)
> > >  #define KVM_REQ_RELOAD_GICv4   KVM_ARCH_REQ(4)
> > >  #define KVM_REQ_RELOAD_PMU     KVM_ARCH_REQ(5)
> > > +#define KVM_REQ_SUSPEND                KVM_ARCH_REQ(6)
> > >
> > >  #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
> > >                                      KVM_DIRTY_LOG_INITIALLY_SET)
> > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > index efe54aba5cce..e9641b86d375 100644
> > > --- a/arch/arm64/kvm/arm.c
> > > +++ b/arch/arm64/kvm/arm.c
> > > @@ -444,6 +444,18 @@ bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu)
> > >         return vcpu->arch.mp_state.mp_state == KVM_MP_STATE_STOPPED;
> > >  }
> > >
> > > +static void kvm_arm_vcpu_suspend(struct kvm_vcpu *vcpu)
> > > +{
> > > +       vcpu->arch.mp_state.mp_state = KVM_MP_STATE_SUSPENDED;
> > > +       kvm_make_request(KVM_REQ_SUSPEND, vcpu);
> > > +       kvm_vcpu_kick(vcpu);
> >
> > > +static void kvm_arm_vcpu_suspend(struct kvm_vcpu *vcpu)
> > > +{
> > > +       vcpu->arch.mp_state.mp_state = KVM_MP_STATE_SUSPENDED;
> > > +       kvm_make_request(KVM_REQ_SUSPEND, vcpu);
> > > +       kvm_vcpu_kick(vcpu);
> >
> > Considering the patch 8 will remove the call to kvm_vcpu_kick()
> > (BTW, I wonder why you wanted to make that change in the patch-8
> > instead of the patch-7),
>
> Squashed the diff into the wrong patch! Marc pointed out this is of
> course cargo-culted as I was following the pattern laid down by
> KVM_REQ_SLEEP :)

I see. Thanks for the clarification !

> > it looks like we could use the mp_state
> > KVM_MP_STATE_SUSPENDED instead of using KVM_REQ_SUSPEND.
> > What is the reason why you prefer to introduce KVM_REQ_SUSPEND
> > rather than simply using KVM_MP_STATE_SUSPENDED ?
>
> I was trying to avoid any heavy refactoring in adding new
> functionality here, as we handle KVM_MP_STATE_STOPPED similarly (make
> a request). ARM is definitely a bit different than x86 in the way that
> we handle the MP states, as x86 doesn't bounce through vCPU requests
> to do it and instead directly checks the mp_state value.

The difference from KVM_MP_STATE_STOPPED is that kvm_arm_vcpu_power_off()
calls kvm_vcpu_kick(), which made me think having KVM_REQ_SLEEP was
reasonable (it appears kvm_vcpu_kick() won't be needed there due to
the same reason as kvm_arm_vcpu_suspend).

> Do you think it's fair to defer on repainting to a later series? We
> probably will need to touch up the main run loop quite a lot along the
> way.

Yes, I'm fine with that :-)

Thanks,
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
