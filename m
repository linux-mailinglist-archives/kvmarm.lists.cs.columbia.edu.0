Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87B194C367E
	for <lists+kvmarm@lfdr.de>; Thu, 24 Feb 2022 21:06:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E78774BD0C;
	Thu, 24 Feb 2022 15:06:08 -0500 (EST)
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
	with ESMTP id IrMevUIJ2Cju; Thu, 24 Feb 2022 15:06:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44C724BCF2;
	Thu, 24 Feb 2022 15:06:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E7DC44BC14
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 15:06:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WrbeQp7QmDKe for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Feb 2022 15:06:04 -0500 (EST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
 [209.85.166.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 32B494BC13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 15:06:04 -0500 (EST)
Received: by mail-io1-f53.google.com with SMTP id c18so4097331ioc.6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=10pic/8N15/Do27SwiUwyg5fYmTr9ZTD6kzw5c8Ejrk=;
 b=pMF1Orh3Op1sOTDg8YygXlm7ifJmDSBZCmInaIbpcmi9MFWACMRCQmgZTNOrfGY8o8
 NFsj9QcPaKuI9R+2jKHck3A0nlvrw09lEvtdm9jshPJi+2X9nNhC50LdUJSlMxYlBHZZ
 c2fSEh4G5SbBI++nrkLBuQHtB7KmbBL17hC4RzXpsECx1PcdBzPpkiAj1W0CQFtTQWNN
 nXDjlZa4vtNfjoncMeHQDsRGrgs0PewEQhVXiZ5xqF0MEGC9Yu69OMXD/uuk1qwMpDiN
 C6Sxvv8khGy4jfMyIF/DZRdsSRuVJa3GdNJHoU3bN82tNVmJUNb0Fc6QT2yjjiO6kmmC
 eFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=10pic/8N15/Do27SwiUwyg5fYmTr9ZTD6kzw5c8Ejrk=;
 b=Ql7ZOd+ngh86zCGPzDELbCPFDXp2S4zaPjD6lANFRjrPMBw4FFSWQxBLFjOQlEBPzZ
 r1X6AWczcnjw4RBGHNavCj42ofTC7Vj89k7M1ndAr34OzaDQ/hHgb4PR993GGDXgeD9q
 b8YaFs5anrjHqB5u6hx7mxdIlPJLJouA6OYrWrUfdZWdJ6t323fUNiLG1IksKkvhrNwT
 aELfCri3zSF/+YUStUzXqwIF1MDOWcxj8ACJ/YCz4/vQ61Z5z/k1KA0ynGFMGfwyuP4y
 T0GuXUhqAk0P1WJ38Y0zKL1hGGQ20pwycLtuFVA1hXGstOTgl9LpvgfiHFaxv4U0q1AQ
 BLqA==
X-Gm-Message-State: AOAM533F3HCfuzWic+4Fbx8/7Kd0WDwwc8lFAcHn7ctMGx1Rg+QPVKWv
 VK4JOZJuMEibhI5AEhpKB3JKzQ==
X-Google-Smtp-Source: ABdhPJzkg/lXwNUyL7LiqJMwzCDd03jpImD1xRZOJzG6tBmRlCW+DAPs7fUZNRrCEAzZ70Uq9ujeZw==
X-Received: by 2002:a05:6638:3491:b0:313:ec43:1751 with SMTP id
 t17-20020a056638349100b00313ec431751mr3357887jal.241.1645733163012; 
 Thu, 24 Feb 2022 12:06:03 -0800 (PST)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194]) by smtp.gmail.com with ESMTPSA id
 b24-20020a6b6718000000b006412400e2c2sm436379ioc.1.2022.02.24.12.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Feb 2022 12:06:02 -0800 (PST)
Date: Thu, 24 Feb 2022 20:05:59 +0000
From: Oliver Upton <oupton@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 13/19] KVM: arm64: Add support
 KVM_SYSTEM_EVENT_SUSPEND to PSCI SYSTEM_SUSPEND
Message-ID: <YhflJ74nF2N+u1i4@google.com>
References: <20220223041844.3984439-1-oupton@google.com>
 <20220223041844.3984439-14-oupton@google.com>
 <87sfs82rz4.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sfs82rz4.wl-maz@kernel.org>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@atishpatra.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

On Thu, Feb 24, 2022 at 03:40:15PM +0000, Marc Zyngier wrote:
> On Wed, 23 Feb 2022 04:18:38 +0000,
> Oliver Upton <oupton@google.com> wrote:
> > 
> > Add a new system event type, KVM_SYSTEM_EVENT_SUSPEND, which indicates
> > to userspace that the guest has requested the VM be suspended. Userspace
> > can decide whether or not it wants to honor the guest's request by
> > changing the MP state of the vCPU. If it does not, userspace is
> > responsible for configuring the vCPU to return an error to the guest.
> > Document these expectations in the KVM API documentation.
> > 
> > To preserve ABI, this new exit requires explicit opt-in from userspace.
> > Add KVM_CAP_ARM_SYSTEM_SUSPEND which grants userspace the ability to
> > opt-in to these exits on a per-VM basis.
> > 
> > Signed-off-by: Oliver Upton <oupton@google.com>
> > ---
> >  Documentation/virt/kvm/api.rst    | 39 +++++++++++++++++++++++++++++++
> >  arch/arm64/include/asm/kvm_host.h |  3 +++
> >  arch/arm64/kvm/arm.c              |  5 ++++
> >  arch/arm64/kvm/psci.c             |  5 ++++
> >  include/uapi/linux/kvm.h          |  2 ++
> >  5 files changed, 54 insertions(+)
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 2b4bdbc2dcc0..1e207bbc01f5 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -5930,6 +5930,7 @@ should put the acknowledged interrupt vector into the 'epr' field.
> >    #define KVM_SYSTEM_EVENT_RESET          2
> >    #define KVM_SYSTEM_EVENT_CRASH          3
> >    #define KVM_SYSTEM_EVENT_WAKEUP         4
> > +  #define KVM_SYSTEM_EVENT_SUSPENDED      5
> >  			__u32 type;
> >  			__u64 flags;
> >  		} system_event;
> > @@ -5957,6 +5958,34 @@ Valid values for 'type' are:
> >   - KVM_SYSTEM_EVENT_WAKEUP -- the guest is in a suspended state and KVM
> >     has recognized a wakeup event. Userspace may honor this event by marking
> >     the exiting vCPU as runnable, or deny it and call KVM_RUN again.
> > + - KVM_SYSTEM_EVENT_SUSPENDED -- the guest has requested a suspension of
> > +   the VM.
> > +
> > +For arm/arm64:
> > +^^^^^^^^^^^^^^
> > +
> > +   KVM_SYSTEM_EVENT_SUSPENDED exits are enabled with the
> > +   KVM_CAP_ARM_SYSTEM_SUSPEND VM capability. If a guest successfully
> > +   invokes the PSCI SYSTEM_SUSPEND function, KVM will exit to userspace
> > +   with this event type.
> > +
> > +   The guest's x2 register contains the 'entry_address' where execution
> 
> x1?
> 
> > +   should resume when the VM is brought out of suspend. The guest's x3
> 
> x2?
> 
> > +   register contains the 'context_id' corresponding to the request. When
> > +   the guest resumes execution at 'entry_address', x0 should contain the
> > +   'context_id'. For more details on the SYSTEM_SUSPEND PSCI call, see
> > +   ARM DEN0022D.b 5.19 "SYSTEM_SUSPEND".
> 
> I'd refrain from paraphrasing too much of the spec, and direct the
> user to it. It will also avoid introducing bugs... ;-)
> 
> Overall, "the guest" is super ambiguous, and echoes the questions I
> had earlier about what this means for an SMP system. Only one vcpu can
> restart the system, but which one?
> 
> > +
> > +   Userspace is _required_ to take action for such an exit. It must
> > +   either:
> > +
> > +    - Honor the guest request to suspend the VM. Userspace must reset
> > +      the calling vCPU, then set PC to 'entry_address' and x0 to
> > +      'context_id'. Userspace may request in-kernel emulation of the
> > +      suspension by setting the vCPU's state to KVM_MP_STATE_SUSPENDED.
> 
> So here, you are actively saying that the calling vcpu should be the
> one being resumed. If that's the case (and assuming that this is a
> behaviour intended by the spec), something should prevent the other
> vcpus from being started.
> 
> > +
> > +    - Deny the guest request to suspend the VM. Userspace must set
> > +      registers x1-x3 to 0 and set x0 to PSCI_RET_INTERNAL_ERROR (-6).
> 
> Do you have any sort of userspace code that demonstrates this? It'd be
> super useful to see how that works on any publicly available VMM
> (qemu, kvmtool, or any of the ferric oxide based monsters).
> 
> >
> >  ::
> >  
> > @@ -7580,3 +7609,13 @@ The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
> >  of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
> >  the hypercalls whose corresponding bit is in the argument, and return
> >  ENOSYS for the others.
> > +
> > +8.35 KVM_CAP_ARM_SYSTEM_SUSPEND
> > +-------------------------------
> > +
> > +:Capability: KVM_CAP_ARM_SYSTEM_SUSPEND
> > +:Architectures: arm64
> > +:Type: vm
> > +
> > +When enabled, KVM will exit to userspace with KVM_EXIT_SYSTEM_EVENT of
> > +type KVM_SYSTEM_EVENT_SUSPEND to process the guest suspend request.
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index d32cab0c9752..e1c2ec18d1aa 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -146,6 +146,9 @@ struct kvm_arch {
> >  
> >  	/* Memory Tagging Extension enabled for the guest */
> >  	bool mte_enabled;
> > +
> > +	/* System Suspend Event exits enabled for the VM */
> > +	bool system_suspend_exits;
> 
> Gah... More of these. Please pick this patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=kvm-arm64/mmu/guest-MMIO-guard&id=7dd0a13a4217b870f2e83cdc6045e5ce482a5340
> 
> >  };
> >  
> >  struct kvm_vcpu_fault_info {
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index d2b190f32651..ce3f14a77a49 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -101,6 +101,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> >  		}
> >  		mutex_unlock(&kvm->lock);
> >  		break;
> > +	case KVM_CAP_ARM_SYSTEM_SUSPEND:
> > +		r = 0;
> > +		kvm->arch.system_suspend_exits = true;
> > +		break;
> >  	default:
> >  		r = -EINVAL;
> >  		break;
> > @@ -209,6 +213,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  	case KVM_CAP_SET_GUEST_DEBUG:
> >  	case KVM_CAP_VCPU_ATTRIBUTES:
> >  	case KVM_CAP_PTP_KVM:
> > +	case KVM_CAP_ARM_SYSTEM_SUSPEND:
> >  		r = 1;
> >  		break;
> >  	case KVM_CAP_SET_GUEST_DEBUG2:
> > diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> > index 2bb8d047cde4..a7de84cec2e4 100644
> > --- a/arch/arm64/kvm/psci.c
> > +++ b/arch/arm64/kvm/psci.c
> > @@ -245,6 +245,11 @@ static int kvm_psci_system_suspend(struct kvm_vcpu *vcpu)
> >  		return 1;
> >  	}
> >  
> > +	if (kvm->arch.system_suspend_exits) {
> > +		kvm_vcpu_set_system_event_exit(vcpu, KVM_SYSTEM_EVENT_SUSPEND);
> > +		return 0;
> > +	}
> > +
> 
> So there really is a difference in behaviour here. Userspace sees the
> WFI behaviour before reset (it implements it), while when not using
> the SUSPEND event, reset occurs before anything else.
> 
> They really should behave in a similar way (WFI first, reset next).

I mentioned this on the other patch, but I think the conversation should
continue here as UAPI context is in this one.

If SUSPEND exits are disabled and SYSTEM_SUSPEND is implemented in the
kernel, userspace cannot observe any intermediate state. I think it is
necessary for migration, otherwise if userspace were to save the vCPU
post-WFI, pre-reset the pending reset would get lost along the way.

As far as userspace is concerned, I think the WFI+reset operation is
atomic. SUSPEND exits just allow userspace to intervene before said
atomic operation.

Perhaps I'm missing something: assuming SUSPEND exits are disabled, what
value is provided to userspace if it can see WFI behavior before the
reset?

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
