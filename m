Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B1A924C4DB5
	for <lists+kvmarm@lfdr.de>; Fri, 25 Feb 2022 19:26:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 06CE74B997;
	Fri, 25 Feb 2022 13:26:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id joues-tbjvQk; Fri, 25 Feb 2022 13:26:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 18E284B921;
	Fri, 25 Feb 2022 13:26:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 106534B816
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 13:26:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GynFifP8IxeN for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Feb 2022 13:26:40 -0500 (EST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
 [209.85.166.41])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 057224B62F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 13:26:39 -0500 (EST)
Received: by mail-io1-f41.google.com with SMTP id m185so7456190iof.10
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lhaPCIklGNBt+HFcY/TDFDGZTzHyNeIgqwSxFpBlycU=;
 b=poIB4WM1RurVJo+HnWdyo+pTCPcE9q0ZRAvizLzpmb8LwHDXtwIY6fUoCRjauPNgaO
 Qta1Ujw5L5yYSuxt1081ltEn0LQ3eRA9dNWYrkdMacB522mgoQsX95DgdbdWOkt/Muq5
 3WjbKKW1nr5mShBMbuiT0AoY3TFi5Zkv7rFjnLIbkxWVgGhwTDpunDu9CskQwM1Xrdjm
 g48yw47EVNDPfXjI1bnavlZagcvZBD+2FcRR5xr2aejD8hkdaycMxzPXfnDceYz6QOBY
 QIS812iF2eIfQE+mJ7fc2l1zwH8pprA9reY4lKlbXL8QtUnA0Cigm57NeBBwLZMowKMs
 XFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lhaPCIklGNBt+HFcY/TDFDGZTzHyNeIgqwSxFpBlycU=;
 b=ykD9EFt0wVOPlhnpoXmi6qNLKFpEfWMGWXl2tCpS3zr3z2giI83ZSvVWvSElVuYMSn
 +HhpoqWg8PS/qJvHJuN2wfK3Tl0C02rke+DDNBCELGsYpNAqvE0hbO2ZGNOIfZeTGsi+
 qx2KAUKg9j1Wq1uYZEfqHWRoK04Em8VyJyty83mJK6w9TbRuyuYfoTdc1KyLIkBYBOJn
 FmoNFuBbtB68mbfjGrlpgdUTUiMMfctl+HnB/Nmvc288TcczE+Nl7SGKukVCLkiLL1iY
 HRcqIeFhQesrORNRaIZ4RPoZzB+q+zkL+auOz/HS8j0Xn8Zrdp+KozeEizE5xzmWArzB
 rlTg==
X-Gm-Message-State: AOAM5302sYsKLIppzjV3kAdNzfR0Kk+r8qerDZAYvNMRbmCdZjocMjpL
 RKPxuiBA03MSeEmBmiXv560KjA==
X-Google-Smtp-Source: ABdhPJyS7qbjcUh63IYySyylwKVNhTylW6WI9czxUTmRsJLZf0fPbQVrOgOFX8AqeTH4BpQNMD+oBw==
X-Received: by 2002:a02:3f1a:0:b0:309:b9f3:1098 with SMTP id
 d26-20020a023f1a000000b00309b9f31098mr6873612jaa.46.1645813598988; 
 Fri, 25 Feb 2022 10:26:38 -0800 (PST)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194]) by smtp.gmail.com with ESMTPSA id
 a13-20020a056e02180d00b002c25b51d5ecsm2014992ilv.55.2022.02.25.10.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 10:26:38 -0800 (PST)
Date: Fri, 25 Feb 2022 18:26:35 +0000
From: Oliver Upton <oupton@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v4 02/13] KVM: arm64: Introduce KVM_CAP_ARM_REG_SCOPE
Message-ID: <YhkfW76Rit6DYs9T@google.com>
References: <20220224172559.4170192-1-rananta@google.com>
 <20220224172559.4170192-3-rananta@google.com>
 <Yhh6cI4P5VEMitkg@google.com>
 <CAJHc60zn0df4e-TXaeKEgkej4G34VzbFdQUpX_6ii_XwTNY2tg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJHc60zn0df4e-TXaeKEgkej4G34VzbFdQUpX_6ii_XwTNY2tg@mail.gmail.com>
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

On Fri, Feb 25, 2022 at 09:34:35AM -0800, Raghavendra Rao Ananta wrote:
> Hey Oliver,
> 
> On Thu, Feb 24, 2022 at 10:43 PM Oliver Upton <oupton@google.com> wrote:
> >
> > On Thu, Feb 24, 2022 at 05:25:48PM +0000, Raghavendra Rao Ananta wrote:
> > > KVM_[GET|SET]_ONE_REG act on per-vCPU basis. Currently certain
> > > ARM64 registers, such as KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_[1|2],
> > > are accessed via this interface even though the effect that
> > > they have are really per-VM. As a result, userspace could just
> > > waste cycles to read/write the same information for every vCPU
> > > that it spawns, only to realize that there's absolutely no change
> > > in the VM's state. The problem gets worse in proportion to the
> > > number of vCPUs created.
> > >
> > > As a result, to avoid this redundancy, introduce the capability
> > > KVM_CAP_ARM_REG_SCOPE. If enabled, KVM_GET_REG_LIST will advertise
> > > the registers that are VM-scoped by dynamically modifying the
> > > register encoding. KVM_REG_ARM_SCOPE_* helper macros are introduced
> > > to decode the same. By learning this, userspace can access such
> > > registers only once.
> > >
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > ---
> > >  Documentation/virt/kvm/api.rst    | 16 ++++++++++++++++
> > >  arch/arm64/include/asm/kvm_host.h |  3 +++
> > >  arch/arm64/include/uapi/asm/kvm.h |  6 ++++++
> > >  arch/arm64/kvm/arm.c              | 13 +++++++------
> > >  include/uapi/linux/kvm.h          |  1 +
> > >  5 files changed, 33 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > index a4267104db50..7e7b3439f540 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -7561,3 +7561,19 @@ The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
> > >  of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
> > >  the hypercalls whose corresponding bit is in the argument, and return
> > >  ENOSYS for the others.
> > > +
> > > +8.34 KVM_CAP_ARM_REG_SCOPE
> > > +--------------------------
> > > +
> > > +:Architectures: arm64
> > > +
> > > +The capability, if enabled, amends the existing register encoding
> > > +with additional information to the userspace if a particular register
> > > +is scoped per-vCPU or per-VM via KVM_GET_REG_LIST. KVM provides
> > > +KVM_REG_ARM_SCOPE_* helper macros to decode the same. Userspace can
> > > +use this information from the register encoding to access a VM-scopped
> > > +regiser only once, as opposed to accessing it for every vCPU for the
> > > +same effect.
> > > +
> >
> > Could you describe the encoding changes in 4.68 'KVM_SET_ONE_REG', along
> > with the other ARM encoding details?
> >
> > > +On the other hand, if the capability is disabled, all the registers
> > > +remain vCPU-scopped by default, retaining backward compatibility.
> >
> > typo: vCPU-scoped
> >
> > That said, I don't believe we need to document behavior if the CAP is
> > disabled, as the implicated ioctls should continue to work the same.
> >
> Sure, I'll address the above two Doc comments.
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index 5bc01e62c08a..8132de6bd718 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -136,6 +136,9 @@ struct kvm_arch {
> > >
> > >       /* Memory Tagging Extension enabled for the guest */
> > >       bool mte_enabled;
> > > +
> > > +     /* Register scoping enabled for KVM registers */
> > > +     bool reg_scope_enabled;
> > >  };
> > >
> > >  struct kvm_vcpu_fault_info {
> > > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > > index b3edde68bc3e..c35447cc0e0c 100644
> > > --- a/arch/arm64/include/uapi/asm/kvm.h
> > > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > > @@ -199,6 +199,12 @@ struct kvm_arm_copy_mte_tags {
> > >  #define KVM_REG_ARM_COPROC_MASK              0x000000000FFF0000
> > >  #define KVM_REG_ARM_COPROC_SHIFT     16
> > >
> > > +/* Defines if a KVM register is one per-vCPU or one per-VM */
> > > +#define KVM_REG_ARM_SCOPE_MASK               0x0000000010000000
> > > +#define KVM_REG_ARM_SCOPE_SHIFT              28
> >
> > Thinking about the advertisement of VM- and vCPU-scoped registers, this
> > could be generally useful. Might it make sense to add such an encoding
> > to the arch-generic register definitions?
> >
> > If that is the case, we may want to snap up a few more bits (a nybble)
> > for future expansion.
> >
> That's a great idea! But I wonder if we'll get a push-back since there
> are no users of it in other arch(s) yet. Not sure if there was any
> need/discussion regarding the same, but I'm happy to share a patch for
> the same if you sense that there's a strong potential for the patch.
> 

I'm unsure if this is actually of interest to other architectures, it
just doesn't seem ARM-specific so we should probably raise the question
so we only grab these bits once.

> > > +#define KVM_REG_ARM_SCOPE_VCPU               0
> > > +#define KVM_REG_ARM_SCOPE_VM         1
> > > +
> > >  /* Normal registers are mapped as coprocessor 16. */
> > >  #define KVM_REG_ARM_CORE             (0x0010 << KVM_REG_ARM_COPROC_SHIFT)
> > >  #define KVM_REG_ARM_CORE_REG(name)   (offsetof(struct kvm_regs, name) / sizeof(__u32))
> > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > index ecc5958e27fe..107977c82c6c 100644
> > > --- a/arch/arm64/kvm/arm.c
> > > +++ b/arch/arm64/kvm/arm.c
> > > @@ -81,26 +81,26 @@ int kvm_arch_check_processor_compat(void *opaque)
> > >  int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> > >                           struct kvm_enable_cap *cap)
> > >  {
> > > -     int r;
> > > +     int r = 0;
> > >
> > >       if (cap->flags)
> > >               return -EINVAL;
> > >
> > >       switch (cap->cap) {
> > >       case KVM_CAP_ARM_NISV_TO_USER:
> > > -             r = 0;
> > >               kvm->arch.return_nisv_io_abort_to_user = true;
> > >               break;
> > >       case KVM_CAP_ARM_MTE:
> > >               mutex_lock(&kvm->lock);
> > > -             if (!system_supports_mte() || kvm->created_vcpus) {
> > > +             if (!system_supports_mte() || kvm->created_vcpus)
> > >                       r = -EINVAL;
> > > -             } else {
> > > -                     r = 0;
> > > +             else
> > >                       kvm->arch.mte_enabled = true;
> > > -             }
> > >               mutex_unlock(&kvm->lock);
> > >               break;
> >
> > Hmm.. these all look like cleanups. If you want to propose these, could
> > you do it in a separate patch?
> >
> Ahh, I thought I could squeeze it in. But sure, I can separate it out.
> > > +     case KVM_CAP_ARM_REG_SCOPE:
> > > +             WRITE_ONCE(kvm->arch.reg_scope_enabled, true);
> > > +             break;
> > >       default:
> > >               r = -EINVAL;
> > >               break;
> > > @@ -209,6 +209,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> > >       case KVM_CAP_SET_GUEST_DEBUG:
> > >       case KVM_CAP_VCPU_ATTRIBUTES:
> > >       case KVM_CAP_PTP_KVM:
> > > +     case KVM_CAP_ARM_REG_SCOPE:
> >
> > It is a bit odd to advertise a capability (and allow userspace to enable
> > it), despite the fact that the feature itself hasn't yet been
> > implemented.
> >
> > Is it possible to fold the feature in to the patch that exposes it to
> > userspace? Otherwise, you could punt advertisement of the CAP until it
> > is actually implemented in kernel.
> >
> Well, I didn't want to complicate the patch, but technically the
> feature is available with this patch, including all the CAP and macro
> definitions. Userspace can still decode the scope information, only
> that no registers are added yet, which is done in the next patch. So,
> the userspace can still remain the same between this and the next
> patch.

But the series isn't cleanly bisectable. There will exist commits in
history that report KVM_CAP_ARM_REG_SCOPE as implemented even though
that is not actually the case. You should really only advertise support
to userspace when the feature is implemented.

Defining kvm->arch.reg_scope_enabled can be done earlier so you have a
bit to test and guard all of the new code, and only expose the CAP in
the last patch of the series.

Also, as an FYI Marc has a patch that I'll be picking up in my own
series which uses bits instead of bools to keep track of certain
VM-wide features:

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=kvm-arm64/mmu/guest-MMIO-guard&id=7dd0a13a4217b870f2e83cdc6045e5ce482a5340

Marc, if neither of our series land in 5.18 could you at least submit
this patch in preparation? Should keep conflicts minimal that way.

Thanks!

--
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
