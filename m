Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EBC171A0CDC
	for <lists+kvmarm@lfdr.de>; Tue,  7 Apr 2020 13:31:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D8A14B18D;
	Tue,  7 Apr 2020 07:31:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, HTML_MESSAGE=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mWaFa0Hj1Khv; Tue,  7 Apr 2020 07:31:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B07F4B14A;
	Tue,  7 Apr 2020 07:31:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BF71B4B0FD
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Apr 2020 07:31:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1umTDHH+kKi for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Apr 2020 07:31:21 -0400 (EDT)
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 065724B0FB
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Apr 2020 07:31:21 -0400 (EDT)
Received: by mail-io1-f67.google.com with SMTP id o3so2995278ioh.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 07 Apr 2020 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rIEdh/DAd6NbjanhhI+rIjqTmDzgvXvSY5PTF8Wyo3o=;
 b=wy/8nNwP5tB1Vuv4Us1W1tY+i6iKOE+/GVsI0mdiein2Pjg8BXLlyWOJMWxsE+zTyv
 uXHQL5v3ehL8Y6qf6gXDSG0nmGljA28SFqHX/I+9KqwuQ5XihefipSgnErIzzDSvii5h
 I6Isz5RvsAddeNWN1MnM29SA7SRfVlNv1aYlNuvLbb1bOKu5AVZmHSa1v/WXahlweDIg
 MrcG+wC+OO8rrZVGI44sUBMIcIBdtQghORbKVg0qE81fCq0pNsxUOBmlSuFU/YL3Mkvq
 +yUBdFb3ORxuv8nnu2y3Qf2/x+wmqu9U0LQrA1PA16iSOzfFmksh56do9Yy/FCD7UxfB
 8PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rIEdh/DAd6NbjanhhI+rIjqTmDzgvXvSY5PTF8Wyo3o=;
 b=l/NBNOEQbJx1SuO8Sh5Ieq+l1nbTwhd7wm9DskYo6HEvLAv3Vg60QTA8/NCBcgF34l
 te++U7zOEp1ZL+DId/VUxmq9aKhwJzEB06ZAKUfhaQyPZnL9U1SIpeG56LGqSGMd8f6H
 bN+PPR5E1rjlXw/qMv/Q1q3nSU4oFX+2KvSHL7HLEsdbkhIFwAkW/lz1bkkC3S6YtP0p
 eqgCzQSK6Q4x7HmkgvDCPdqNTEqSUMH/sPMJx8+CnVYJIDJqtd7PAGmLvdbOvyl3NsFC
 +jfahhTYprVjlWSXSky11Vh9yagjHj7Efwqj/cJLjDXxKbndXtIYC2u+W/wpv47vo6oZ
 NzSw==
X-Gm-Message-State: AGi0Puadqf5Um5tVz0Q069W6/l/qBGeKTqgCCdFAr23N5dNIH7vPMZup
 yn71U5YsKWWGzK+ix1X0oNQut0cFOglAqUWBbkdpUg==
X-Google-Smtp-Source: APiQypJPlhe8viCt0w4M7jWn3ZDa4o/oya5uNTT3+JGHSdRBcX/AGaeIsaF/W/ZTMy00nFgZcix4QfOw5EHSnMHpoYU=
X-Received: by 2002:a02:2944:: with SMTP id p65mr1423350jap.89.1586259080137; 
 Tue, 07 Apr 2020 04:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-3-beata.michalska@linaro.org>
 <20200403084435.zvfewiivn7orsnll@kamzik.brq.redhat.com>
In-Reply-To: <20200403084435.zvfewiivn7orsnll@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 7 Apr 2020 12:31:09 +0100
Message-ID: <CADSWDzuVZscP6sMctrc28vhuLmWC7urW+PzdP+ncD5OdHhjvWg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm: kvm: Handle potential issue with dabt
 injection
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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
Content-Type: multipart/mixed; boundary="===============1446791611208538366=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

--===============1446791611208538366==
Content-Type: multipart/alternative; boundary="000000000000fe667305a2b1b8c6"

--000000000000fe667305a2b1b8c6
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Apr 2020 at 09:44, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:32:27AM +0000, Beata Michalska wrote:
> > Injecting external data abort through KVM might trigger
> > an issue on kernels that do not get updated to include the KVM fix.
> > For those and aarch32 guests, the injected abort gets misconfigured
> > to be an implementation defined exception. This leads to the guest
> > repeatedly re-running the faulting instruction.
> >
> > Add support for handling that case.
> > [
> >   Fixed-by: 018f22f95e8a
> >       ('KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests')
> >   Fixed-by: 21aecdbd7f3a
> >       ('KVM: arm: Make inject_abt32() inject an external abort instead')
> > ]
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >  target/arm/cpu.h     |  1 +
> >  target/arm/kvm.c     | 30 +++++++++++++++++++++++++++++-
> >  target/arm/kvm32.c   | 25 +++++++++++++++++++++++++
> >  target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
> >  target/arm/kvm_arm.h | 10 ++++++++++
> >  5 files changed, 99 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 4f834c1..868afc6 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -561,6 +561,7 @@ typedef struct CPUARMState {
> >      } serror;
> >
> >      uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> > +    uint8_t ext_dabt_raised; /* Tracking/verifying injection of ext
DABT */
> >
> >      /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
> >      uint32_t irq_line_state;
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index c088589..58ad734 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -721,7 +721,12 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
> >      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
> >      if (ret) {
> >          error_report("failed to put vcpu events");
> > -    } else {
> > +    } else if (env->ext_dabt_pending) {
> > +        /*
> > +         * Mark that the external DABT has been injected,
> > +         * if one has been requested
> > +         */
> > +        env->ext_dabt_raised = env->ext_dabt_pending;
> >          /* Clear instantly if the call was successful */
> >          env->ext_dabt_pending = 0;
> >      }
> > @@ -755,6 +760,29 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
> >
> >  void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
> >  {
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +    CPUARMState *env = &cpu->env;
> > +
> > +    if (unlikely(env->ext_dabt_raised)) {
> > +        /*
> > +         * Verifying that the ext DABT has been properly injected,
> > +         * otherwise risking indefinitely re-running the faulting
instruction
> > +         * Covering a very narrow case for kernels 5.5..5.5.4
> > +         * when injected abort was misconfigured to be
> > +         * an IMPLEMENTATION DEFINED exception (for 32-bit EL1)
> > +         */
> > +        if (!arm_feature(env, ARM_FEATURE_AARCH64) &&
> > +            unlikely(!kvm_arm_verify_ext_dabt_pending(cs))) {
> > +
> > +            error_report("Data abort exception with no valid ISS
generated by "
> > +                   "guest memory access. KVM unable to emulate
faulting "
> > +                   "instruction. Failed to inject an external data
abort "
> > +                   "into the guest.");
> > +            abort();
> > +       }
> > +       /* Clear the status */
> > +       env->ext_dabt_raised = 0;
> > +    }
> >  }
> >
> >  MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
> > diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> > index f271181..86c4fe7 100644
> > --- a/target/arm/kvm32.c
> > +++ b/target/arm/kvm32.c
> > @@ -564,3 +564,28 @@ void kvm_arm_pmu_init(CPUState *cs)
> >  {
> >      qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
> >  }
> > +
> > +#define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
> > +#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
> > +
> > +#define DFSR_FSC(v)   (((v) >> 6 | (v)) & 0x1F)
> > +#define DFSC_EXTABT(lpae) (lpae) ? 0x10 : 0x08
>
> We should put () around the whole ?: expression when it's in a macro
>
> > +
> > +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
> > +{
> > +    uint32_t dfsr_val;
> > +
> > +    if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &dfsr_val)) {
> > +        ARMCPU *cpu = ARM_CPU(cs);
> > +        CPUARMState *env = &cpu->env;
> > +        uint32_t ttbcr;
> > +        int lpae = 0;
> > +
> > +        if (!kvm_get_one_reg(cs, ARM_REG_TTBCR, &ttbcr)) {
> > +            lpae = arm_feature(env, ARM_FEATURE_LPAE) && (ttbcr &
TTBCR_EAE);
> > +        }
> > +        return !(DFSR_FSC(dfsr_val) != DFSC_EXTABT(lpae));
>
>  !(a != b) is a convoluted way to write a == b
>
> > +    }
> > +    return false;
> > +}
> > +
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index be5b31c..18594e9 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -1430,3 +1430,37 @@ bool kvm_arm_handle_debug(CPUState *cs, struct
kvm_debug_exit_arch *debug_exit)
> >
> >      return false;
> >  }
> > +
> > +#define ARM64_REG_ESR_EL1 ARM64_SYS_REG(3, 0, 5, 2, 0)
> > +#define ARM64_REG_TCR_EL1 ARM64_SYS_REG(3, 0, 2, 0, 2)
> > +
> > +#define ESR_DFSC(aarch64, v)    \
> > +    ((aarch64) ? ((v) & 0x3F)   \
> > +               : (((v) >> 6 | (v)) & 0x1F))
> > +
> > +#define ESR_DFSC_EXTABT(aarch64, lpae) \
> > +    ((aarch64) ? 0x10 : (lpae) ? 0x10 : 0x8)
> > +
> > +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
> > +{
> > +    uint64_t dfsr_val;
> > +
> > +    if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
> > +        ARMCPU *cpu = ARM_CPU(cs);
> > +        CPUARMState *env = &cpu->env;
> > +        int aarch64_mode = arm_feature(env, ARM_FEATURE_AARCH64);
> > +        int lpae = 0;
> > +
> > +        if (!aarch64_mode) {
> > +            uint64_t ttbcr;
> > +
> > +            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
> > +                lpae = arm_feature(env, ARM_FEATURE_LPAE)
> > +                        && (ttbcr & TTBCR_EAE);
> > +            }
> > +        }
> > +        return !(ESR_DFSC(aarch64_mode, dfsr_val) !=
> > +                ESR_DFSC_EXTABT(aarch64_mode, lpae));
>
> a == b, please
>
> > +    }
> > +    return false;
> > +}
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index 39472d5..f2dc6a2 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -461,6 +461,16 @@ void kvm_arm_copy_hw_debug_data(struct
kvm_guest_debug_arch *ptr);
> >  int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> >                               uint64_t fault_ipa);
> >  /**
> > + * kvm_arm_verify_ext_dabt_pending:
> > + * @cs: CPUState
> > + *
> > + * Verify the fault status code wrt the Ext DABT injection
> > + *
> > + * Returns: true if the fault status code is as expected, false
otherwise
> > + */
> > +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);
> > +
> > +/**
> >   * its_class_name:
> >   *
> >   * Return the ITS class name to use depending on whether KVM
acceleration
> > --
> > 2.7.4
> >
> >
>
> I'll leave the decision to take this KVM bug workaround patch at all to
Peter,
> and I didn't actually review whether or not
kvm_arm_verify_ext_dabt_pending
> is doing what it claims it's doing, so I'm reluctant to give an r-b on
> this patch. But, as far as the code goes, besides the comments above, it
> looks fine to me.
>
Thanks for the feedback.
Will apply the changes for the next version.

BR
Beata
> Thanks,
> drew
>

--000000000000fe667305a2b1b8c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br>
<br>
On Fri, 3 Apr 2020 at 09:44, Andrew Jones &lt;<a href=3D"mailto:drjones@red=
hat.com" target=3D"_blank">drjones@redhat.com</a>&gt; wrote:<br>
&gt;<br></div><div>
&gt; On Mon, Mar 23, 2020 at 11:32:27AM +0000, Beata Michalska wrote:<br>
&gt; &gt; Injecting external data abort through KVM might trigger<br>
&gt; &gt; an issue on kernels that do not get updated to include the KVM fi=
x.<br>
&gt; &gt; For those and aarch32 guests, the injected abort gets misconfigur=
ed<br>
&gt; &gt; to be an implementation defined exception. This leads to the gues=
t<br>
&gt; &gt; repeatedly re-running the faulting instruction.<br>
&gt; &gt;<br>
&gt; &gt; Add support for handling that case.<br>
&gt; &gt; [<br>
&gt; &gt;=C2=A0 =C2=A0Fixed-by: 018f22f95e8a<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;KVM: arm: Fix DFSR setting for no=
n-LPAE aarch32 guests&#39;)<br>
&gt; &gt;=C2=A0 =C2=A0Fixed-by: 21aecdbd7f3a<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;KVM: arm: Make inject_abt32() inj=
ect an external abort instead&#39;)<br>
&gt; &gt; ]<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Beata Michalska &lt;<a href=3D"mailto:beata.michal=
ska@linaro.org" target=3D"_blank">beata.michalska@linaro.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt; &gt;=C2=A0 target/arm/kvm.c=C2=A0 =C2=A0 =C2=A0| 30 ++++++++++++++++++=
+++++++++++-<br>
&gt; &gt;=C2=A0 target/arm/kvm32.c=C2=A0 =C2=A0| 25 +++++++++++++++++++++++=
++<br>
&gt; &gt;=C2=A0 target/arm/kvm64.c=C2=A0 =C2=A0| 34 +++++++++++++++++++++++=
+++++++++++<br>
&gt; &gt;=C2=A0 target/arm/kvm_arm.h | 10 ++++++++++<br>
&gt; &gt;=C2=A0 5 files changed, 99 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/target/arm/cpu.h b/target/arm/cpu.h<br>
&gt; &gt; index 4f834c1..868afc6 100644<br>
&gt; &gt; --- a/target/arm/cpu.h<br>
&gt; &gt; +++ b/target/arm/cpu.h<br>
&gt; &gt; @@ -561,6 +561,7 @@ typedef struct CPUARMState {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } serror;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint8_t ext_dabt_pending; /* Request for inje=
cting ext DABT */<br>
&gt; &gt; +=C2=A0 =C2=A0 uint8_t ext_dabt_raised; /* Tracking/verifying inj=
ection of ext DABT */<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* State of our input IRQ/FIQ/VIRQ/VFIQ lines=
 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t irq_line_state;<br>
&gt; &gt; diff --git a/target/arm/kvm.c b/target/arm/kvm.c<br>
&gt; &gt; index c088589..58ad734 100644<br>
&gt; &gt; --- a/target/arm/kvm.c<br>
&gt; &gt; +++ b/target/arm/kvm.c<br>
&gt; &gt; @@ -721,7 +721,12 @@ int kvm_put_vcpu_events(ARMCPU *cpu)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU=
_EVENTS, &amp;events);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;failed to pu=
t vcpu events&quot;);<br>
&gt; &gt; -=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 } else if (env-&gt;ext_dabt_pending) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Mark that the external DABT =
has been injected,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if one has been requested<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;ext_dabt_raised =3D env-&gt;=
ext_dabt_pending;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear instantly if the call =
was successful */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;ext_dabt_pending =3D 0;=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; @@ -755,6 +760,29 @@ int kvm_get_vcpu_events(ARMCPU *cpu)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)<br=
>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (unlikely(env-&gt;ext_dabt_raised)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Verifying that the ext DABT =
has been properly injected,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* otherwise risking indefinite=
ly re-running the faulting instruction<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Covering a very narrow case =
for kernels 5.5..5.5.4<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* when injected abort was misc=
onfigured to be<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* an IMPLEMENTATION DEFINED ex=
ception (for 32-bit EL1)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!arm_feature(env, ARM_FEATURE_AA=
RCH64) &amp;&amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlikely(!kvm_arm_veri=
fy_ext_dabt_pending(cs))) {<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Dat=
a abort exception with no valid ISS generated by &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;guest memory access. KVM unable to emulate faulting &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;instruction. Failed to inject an external data abort &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;into the guest.&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear the status */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;ext_dabt_raised =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *=
run)<br>
&gt; &gt; diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c<br>
&gt; &gt; index f271181..86c4fe7 100644<br>
&gt; &gt; --- a/target/arm/kvm32.c<br>
&gt; &gt; +++ b/target/arm/kvm32.c<br>
&gt; &gt; @@ -564,3 +564,28 @@ void kvm_arm_pmu_init(CPUState *cs)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: not implem=
ented\n&quot;, __func__);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +#define ARM_REG_DFSR=C2=A0 ARM_CP15_REG32(0, 5, 0, 0)<br>
&gt; &gt; +#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)<br>
&gt; &gt; +<br>
&gt; &gt; +#define DFSR_FSC(v)=C2=A0 =C2=A0(((v) &gt;&gt; 6 | (v)) &amp; 0x=
1F)<br>
&gt; &gt; +#define DFSC_EXTABT(lpae) (lpae) ? 0x10 : 0x08<br>
&gt;<br>
&gt; We should put () around the whole ?: expression when it&#39;s in a mac=
ro<br>
&gt;<br>
&gt; &gt; +<br>
&gt; &gt; +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t dfsr_val;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &amp;dfsr_v=
al)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;en=
v;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ttbcr;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int lpae =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!kvm_get_one_reg(cs, ARM_REG_TTB=
CR, &amp;ttbcr)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lpae =3D arm_feature(e=
nv, ARM_FEATURE_LPAE) &amp;&amp; (ttbcr &amp; TTBCR_EAE);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return !(DFSR_FSC(dfsr_val) !=3D DFS=
C_EXTABT(lpae));<br>
&gt;<br>
&gt;=C2=A0 !(a !=3D b) is a convoluted way to write a =3D=3D b<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 return false;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c<br>
&gt; &gt; index be5b31c..18594e9 100644<br>
&gt; &gt; --- a/target/arm/kvm64.c<br>
&gt; &gt; +++ b/target/arm/kvm64.c<br>
&gt; &gt; @@ -1430,3 +1430,37 @@ bool kvm_arm_handle_debug(CPUState *cs, st=
ruct kvm_debug_exit_arch *debug_exit)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +#define ARM64_REG_ESR_EL1 ARM64_SYS_REG(3, 0, 5, 2, 0)<br>
&gt; &gt; +#define ARM64_REG_TCR_EL1 ARM64_SYS_REG(3, 0, 2, 0, 2)<br>
&gt; &gt; +<br>
&gt; &gt; +#define ESR_DFSC(aarch64, v)=C2=A0 =C2=A0 \<br>
&gt; &gt; +=C2=A0 =C2=A0 ((aarch64) ? ((v) &amp; 0x3F)=C2=A0 =C2=A0\<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: (((v) &=
gt;&gt; 6 | (v)) &amp; 0x1F))<br>
&gt; &gt; +<br>
&gt; &gt; +#define ESR_DFSC_EXTABT(aarch64, lpae) \<br>
&gt; &gt; +=C2=A0 =C2=A0 ((aarch64) ? 0x10 : (lpae) ? 0x10 : 0x8)<br>
&gt; &gt; +<br>
&gt; &gt; +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t dfsr_val;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &amp;d=
fsr_val)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;en=
v;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int aarch64_mode =3D arm_feature(env=
, ARM_FEATURE_AARCH64);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int lpae =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!aarch64_mode) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t ttbcr;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!kvm_get_one_reg(c=
s, ARM64_REG_TCR_EL1, &amp;ttbcr)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lpae =3D=
 arm_feature(env, ARM_FEATURE_LPAE)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;&amp; (ttbcr &amp; TTBCR_EAE);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return !(ESR_DFSC(aarch64_mode, dfsr=
_val) !=3D<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ESR_DFSC=
_EXTABT(aarch64_mode, lpae));<br>
&gt;<br>
&gt; a =3D=3D b, please<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 return false;<br>
&gt; &gt; +}<br>
&gt; &gt; diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h<br>
&gt; &gt; index 39472d5..f2dc6a2 100644<br>
&gt; &gt; --- a/target/arm/kvm_arm.h<br>
&gt; &gt; +++ b/target/arm/kvm_arm.h<br>
&gt; &gt; @@ -461,6 +461,16 @@ void kvm_arm_copy_hw_debug_data(struct kvm_g=
uest_debug_arch *ptr);<br>
&gt; &gt;=C2=A0 int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss=
,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t fault_ipa);<br>
&gt; &gt;=C2=A0 /**<br>
&gt; &gt; + * kvm_arm_verify_ext_dabt_pending:<br>
&gt; &gt; + * @cs: CPUState<br>
&gt; &gt; + *<br>
&gt; &gt; + * Verify the fault status code wrt the Ext DABT injection<br>
&gt; &gt; + *<br>
&gt; &gt; + * Returns: true if the fault status code is as expected, false =
otherwise<br>
&gt; &gt; + */<br>
&gt; &gt; +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);<br>
&gt; &gt; +<br>
&gt; &gt; +/**<br>
&gt; &gt;=C2=A0 =C2=A0* its_class_name:<br>
&gt; &gt;=C2=A0 =C2=A0*<br>
&gt; &gt;=C2=A0 =C2=A0* Return the ITS class name to use depending on wheth=
er KVM acceleration<br>
&gt; &gt; --<br>
&gt; &gt; 2.7.4<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; I&#39;ll leave the decision to take this KVM bug workaround patch at a=
ll to Peter,<br>
&gt; and I didn&#39;t actually review whether or not kvm_arm_verify_ext_dab=
t_pending<br>
&gt; is doing what it claims it&#39;s doing, so I&#39;m reluctant to give a=
n r-b on<br>
&gt; this patch. But, as far as the code goes, besides the comments above, =
it<br>
&gt; looks fine to me.<br>
&gt;<br></div><div>
Thanks for the feedback.<br>
Will apply the changes for the next version.<br>
<br>
BR<br>
Beata<br>
&gt; Thanks,<br>
&gt; drew<br>
&gt;<br>
</div>

--000000000000fe667305a2b1b8c6--

--===============1446791611208538366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============1446791611208538366==--
