Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CAA494C4C3C
	for <lists+kvmarm@lfdr.de>; Fri, 25 Feb 2022 18:34:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 75C724B816;
	Fri, 25 Feb 2022 12:34:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0GTOX8lnmfR; Fri, 25 Feb 2022 12:34:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 212144B8BF;
	Fri, 25 Feb 2022 12:34:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E9974B90F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:34:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DvygDFAniYA for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Feb 2022 12:34:47 -0500 (EST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9F3184B8B2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:34:47 -0500 (EST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-2d79394434dso41364157b3.5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sKDGRVrx3ECjs9tzSu+MgNx/MKkwTYJHbTI9lvl1n+Y=;
 b=VlR18ULWoCstYA5gIkmz7l0HXQ0IElHdp2JeAon7+pj6WLH3SwpPLYZuRks8+Tvh1e
 xeqQHhvQEZEcHLXqFNtG20gkkSFZAPLJvbvXF+VjAYp9Mi17F/Z4z5NIENj+tkwDjfq1
 Rmp/NtBhANiDVSt8GwDM7PrCPVzrHoI5qzcSt42UhaAxudfydDqlDSwfC/dcXzxcI3TA
 aN0x8KXBNWwe2wt8Y3dDUVpVdCoRQefND8+pNOAkzQadkVR8FL7u/7yDYFH7Kcl7dHTA
 2IcR+udnS6P2FHOUKUy/CYx7IijEJWvRHghLRRX858kxHxzshs6AU1ZAqxpjFLD83+Im
 aVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sKDGRVrx3ECjs9tzSu+MgNx/MKkwTYJHbTI9lvl1n+Y=;
 b=OWl5y2d04LNBFQlW8XrTDUagAMvzk0QNhqobrFNCF0HskkTs4Fln3i70YaJ0C0GZ/e
 Q9bVkqdRX8EHISpRMD3rmznSnHg4r5v3YRDPNO1p4qyzkDyV552hZgLN2pmB4QkvGt+h
 6yRI4ccGdTYLCSCb1VCFv5bFH/ESi5SHJMPRMG5FveJXIMTOW0lW8QlmlXOM6uuNXSec
 +uRYPgZS+amyEcB2tpItihVzUDyDMzfZYdYa7+VDZ6QHOVNkY7IjisRPSgKFES317Qx2
 +loEpKN2ioejkbJGJMQyhCI6/nun6Y4Un76CmgBHLa715AAYOPtF72/VbJp9MYz2XWvy
 TfNA==
X-Gm-Message-State: AOAM533yqRs2XTrRTbmIqAcYIpT3+8iu9eYO0SWw/LBa05NxbIHoOK4p
 IFkAAa4iwYzU3U61mQfNDTTslzJ0TT3Ok1t25WtSyw==
X-Google-Smtp-Source: ABdhPJye1+jWLWYoAs1WFm4EV8J6YW+JtTjjp5xP5N0+HWl2W3ELbu5vri1w6kd9PYaGXz//CQicOFM3sFJHXMQzG7s=
X-Received: by 2002:a81:6307:0:b0:2d6:6aee:dc75 with SMTP id
 x7-20020a816307000000b002d66aeedc75mr8638606ywb.249.1645810486799; Fri, 25
 Feb 2022 09:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com>
 <20220224172559.4170192-3-rananta@google.com>
 <Yhh6cI4P5VEMitkg@google.com>
In-Reply-To: <Yhh6cI4P5VEMitkg@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Fri, 25 Feb 2022 09:34:35 -0800
Message-ID: <CAJHc60zn0df4e-TXaeKEgkej4G34VzbFdQUpX_6ii_XwTNY2tg@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] KVM: arm64: Introduce KVM_CAP_ARM_REG_SCOPE
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

Hey Oliver,

On Thu, Feb 24, 2022 at 10:43 PM Oliver Upton <oupton@google.com> wrote:
>
> On Thu, Feb 24, 2022 at 05:25:48PM +0000, Raghavendra Rao Ananta wrote:
> > KVM_[GET|SET]_ONE_REG act on per-vCPU basis. Currently certain
> > ARM64 registers, such as KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_[1|2],
> > are accessed via this interface even though the effect that
> > they have are really per-VM. As a result, userspace could just
> > waste cycles to read/write the same information for every vCPU
> > that it spawns, only to realize that there's absolutely no change
> > in the VM's state. The problem gets worse in proportion to the
> > number of vCPUs created.
> >
> > As a result, to avoid this redundancy, introduce the capability
> > KVM_CAP_ARM_REG_SCOPE. If enabled, KVM_GET_REG_LIST will advertise
> > the registers that are VM-scoped by dynamically modifying the
> > register encoding. KVM_REG_ARM_SCOPE_* helper macros are introduced
> > to decode the same. By learning this, userspace can access such
> > registers only once.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  Documentation/virt/kvm/api.rst    | 16 ++++++++++++++++
> >  arch/arm64/include/asm/kvm_host.h |  3 +++
> >  arch/arm64/include/uapi/asm/kvm.h |  6 ++++++
> >  arch/arm64/kvm/arm.c              | 13 +++++++------
> >  include/uapi/linux/kvm.h          |  1 +
> >  5 files changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index a4267104db50..7e7b3439f540 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -7561,3 +7561,19 @@ The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
> >  of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
> >  the hypercalls whose corresponding bit is in the argument, and return
> >  ENOSYS for the others.
> > +
> > +8.34 KVM_CAP_ARM_REG_SCOPE
> > +--------------------------
> > +
> > +:Architectures: arm64
> > +
> > +The capability, if enabled, amends the existing register encoding
> > +with additional information to the userspace if a particular register
> > +is scoped per-vCPU or per-VM via KVM_GET_REG_LIST. KVM provides
> > +KVM_REG_ARM_SCOPE_* helper macros to decode the same. Userspace can
> > +use this information from the register encoding to access a VM-scopped
> > +regiser only once, as opposed to accessing it for every vCPU for the
> > +same effect.
> > +
>
> Could you describe the encoding changes in 4.68 'KVM_SET_ONE_REG', along
> with the other ARM encoding details?
>
> > +On the other hand, if the capability is disabled, all the registers
> > +remain vCPU-scopped by default, retaining backward compatibility.
>
> typo: vCPU-scoped
>
> That said, I don't believe we need to document behavior if the CAP is
> disabled, as the implicated ioctls should continue to work the same.
>
Sure, I'll address the above two Doc comments.
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 5bc01e62c08a..8132de6bd718 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -136,6 +136,9 @@ struct kvm_arch {
> >
> >       /* Memory Tagging Extension enabled for the guest */
> >       bool mte_enabled;
> > +
> > +     /* Register scoping enabled for KVM registers */
> > +     bool reg_scope_enabled;
> >  };
> >
> >  struct kvm_vcpu_fault_info {
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index b3edde68bc3e..c35447cc0e0c 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -199,6 +199,12 @@ struct kvm_arm_copy_mte_tags {
> >  #define KVM_REG_ARM_COPROC_MASK              0x000000000FFF0000
> >  #define KVM_REG_ARM_COPROC_SHIFT     16
> >
> > +/* Defines if a KVM register is one per-vCPU or one per-VM */
> > +#define KVM_REG_ARM_SCOPE_MASK               0x0000000010000000
> > +#define KVM_REG_ARM_SCOPE_SHIFT              28
>
> Thinking about the advertisement of VM- and vCPU-scoped registers, this
> could be generally useful. Might it make sense to add such an encoding
> to the arch-generic register definitions?
>
> If that is the case, we may want to snap up a few more bits (a nybble)
> for future expansion.
>
That's a great idea! But I wonder if we'll get a push-back since there
are no users of it in other arch(s) yet. Not sure if there was any
need/discussion regarding the same, but I'm happy to share a patch for
the same if you sense that there's a strong potential for the patch.

> > +#define KVM_REG_ARM_SCOPE_VCPU               0
> > +#define KVM_REG_ARM_SCOPE_VM         1
> > +
> >  /* Normal registers are mapped as coprocessor 16. */
> >  #define KVM_REG_ARM_CORE             (0x0010 << KVM_REG_ARM_COPROC_SHIFT)
> >  #define KVM_REG_ARM_CORE_REG(name)   (offsetof(struct kvm_regs, name) / sizeof(__u32))
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index ecc5958e27fe..107977c82c6c 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -81,26 +81,26 @@ int kvm_arch_check_processor_compat(void *opaque)
> >  int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> >                           struct kvm_enable_cap *cap)
> >  {
> > -     int r;
> > +     int r = 0;
> >
> >       if (cap->flags)
> >               return -EINVAL;
> >
> >       switch (cap->cap) {
> >       case KVM_CAP_ARM_NISV_TO_USER:
> > -             r = 0;
> >               kvm->arch.return_nisv_io_abort_to_user = true;
> >               break;
> >       case KVM_CAP_ARM_MTE:
> >               mutex_lock(&kvm->lock);
> > -             if (!system_supports_mte() || kvm->created_vcpus) {
> > +             if (!system_supports_mte() || kvm->created_vcpus)
> >                       r = -EINVAL;
> > -             } else {
> > -                     r = 0;
> > +             else
> >                       kvm->arch.mte_enabled = true;
> > -             }
> >               mutex_unlock(&kvm->lock);
> >               break;
>
> Hmm.. these all look like cleanups. If you want to propose these, could
> you do it in a separate patch?
>
Ahh, I thought I could squeeze it in. But sure, I can separate it out.
> > +     case KVM_CAP_ARM_REG_SCOPE:
> > +             WRITE_ONCE(kvm->arch.reg_scope_enabled, true);
> > +             break;
> >       default:
> >               r = -EINVAL;
> >               break;
> > @@ -209,6 +209,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >       case KVM_CAP_SET_GUEST_DEBUG:
> >       case KVM_CAP_VCPU_ATTRIBUTES:
> >       case KVM_CAP_PTP_KVM:
> > +     case KVM_CAP_ARM_REG_SCOPE:
>
> It is a bit odd to advertise a capability (and allow userspace to enable
> it), despite the fact that the feature itself hasn't yet been
> implemented.
>
> Is it possible to fold the feature in to the patch that exposes it to
> userspace? Otherwise, you could punt advertisement of the CAP until it
> is actually implemented in kernel.
>
Well, I didn't want to complicate the patch, but technically the
feature is available with this patch, including all the CAP and macro
definitions. Userspace can still decode the scope information, only
that no registers are added yet, which is done in the next patch. So,
the userspace can still remain the same between this and the next
patch.

Thank you.
Raghavendra
> --
> Oliver
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
