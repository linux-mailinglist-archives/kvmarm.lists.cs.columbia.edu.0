Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB8A49C3D3
	for <lists+kvmarm@lfdr.de>; Wed, 26 Jan 2022 07:47:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE0B849AF9;
	Wed, 26 Jan 2022 01:47:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zfPPiknFUFuw; Wed, 26 Jan 2022 01:47:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E60AD411D2;
	Wed, 26 Jan 2022 01:47:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 605FF40E00
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 01:47:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ad8+G8LXeAxZ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jan 2022 01:46:59 -0500 (EST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B155840D01
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 01:46:59 -0500 (EST)
Received: by mail-pf1-f170.google.com with SMTP id i17so4339685pfq.13
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Jan 2022 22:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f6dqKO3PgHhM5UGW6xjEBcU4yLBPsWVi3UnvT/m/hMk=;
 b=g2aCOg/LlupJRhA/l2FmKs7CuxPP3PtKnl2qS2zVufVk3lRV2LITAXnsbGAPtX6lim
 SNtbyHMN2xGnwwcvfATaXa8kQWkhpYU26iCIW5mqe27D/KTjaN3kln0dj9h1ODh/5GHz
 hP1yhIVWCNGVUonoiePmzibVVA/h8Qk1LdBpz9opDa/51KsT/fbnt7igWV1GdORewy2b
 X9KPGVhfw52ycC4rFvSjDuTkWYghSBTMSlTUSGMVCt9dW8CCeAZMmLbBoVIZRWqXcZSQ
 h+tunb9n4hROYXxVuT1azIJEhdu1RATVWsmAcbchVqptRUN3aD1+7s+h3Rf5H4EtmUsD
 2I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f6dqKO3PgHhM5UGW6xjEBcU4yLBPsWVi3UnvT/m/hMk=;
 b=K6R2JOZvC0YXbtVBnfdEZcHyjH06lkNTg4QSYaTcSllqa6NGpfkp1gCBzRm2GL2p6T
 Ylsd+pfi0GaKzdecgu74pZEf6NntvR7a5eaL3MHr/89wVD6Fa/2PMJ/V6QVAGG8Xou0D
 uoqEBB2eCMvRm9GZWYJXKQgHDJvXiynwRptipEYewj6UWr+RXFhr4MkgnG9w6oQCAsRU
 /lB8gErPABzAKM12QvYu52SV5jgLH8TajDzMIq+4F5dBHHu6/nZF3a5qMF3vPY6b8dC3
 4SRXyus8pKvEnjdiaBq9GauEXHYhTSFv6Jv9vuwOscDLCM9iMrA68Cf+W+BNGy0sBWgA
 0nTQ==
X-Gm-Message-State: AOAM533sXOyChs8+wsw8d+uxu87PDeT8leI92ZD/7LQlPtdsVGh82tW4
 jJuoVqHkBElLrI8ocdp2TRdAOz6dOpms1V37iE9YAw==
X-Google-Smtp-Source: ABdhPJwmgx6XOgb1UQ4LVSEw9TwdAJnLyMJQrCO8m6VIemGGIMB/Bri57M4ZZ09DR9gTLJ9XvF2fjgD50entNDDxexM=
X-Received: by 2002:a63:7c03:: with SMTP id x3mr17700535pgc.433.1643179618429; 
 Tue, 25 Jan 2022 22:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20220106042708.2869332-1-reijiw@google.com>
 <20220106042708.2869332-4-reijiw@google.com>
 <CA+EHjTx65scqNVvHci6fge7C5qQ=fiqqHKGwOvOKySQwsCy8Jg@mail.gmail.com>
In-Reply-To: <CA+EHjTx65scqNVvHci6fge7C5qQ=fiqqHKGwOvOKySQwsCy8Jg@mail.gmail.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Tue, 25 Jan 2022 22:46:42 -0800
Message-ID: <CAAeT=Fzi2JSuVGijM0x7_w8osRWMFUupz3r10NduO6r5hN+HKw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 03/26] KVM: arm64: Introduce struct id_reg_info
To: Fuad Tabba <tabba@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Hi Fuad,

On Mon, Jan 24, 2022 at 8:29 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Reiji,
>
> On Thu, Jan 6, 2022 at 4:28 AM Reiji Watanabe <reijiw@google.com> wrote:
> >
> > This patch lays the groundwork to make ID registers writable.
> >
> > Introduce struct id_reg_info for an ID register to manage the
> > register specific control of its value for the guest, and provide set
> > of functions commonly used for ID registers to make them writable.
> >
> > The id_reg_info is used to do register specific initialization,
> > validation of the ID register and etc.  Not all ID registers must
> > have the id_reg_info. ID registers that don't have the id_reg_info
> > are handled in a common way that is applied to all ID registers.
> >
> > At present, changing an ID register from userspace is allowed only
> > if the ID register has the id_reg_info, but that will be changed
> > by the following patches.
> >
> > No ID register has the structure yet and the following patches
> > will add the id_reg_info for some ID registers.
> >
> > Signed-off-by: Reiji Watanabe <reijiw@google.com>
> > ---
> >  arch/arm64/kvm/sys_regs.c | 243 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 230 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 80dc62f98ef0..971018288bee 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -265,6 +265,101 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
> >                 return read_zero(vcpu, p);
> >  }
> >
> > +struct id_reg_info {
> > +       u32     sys_reg;        /* Register ID */
>
> Nit: Why not have the comment above, as for the other fields of this struct?

Yes, I will fix that.
(I placed the comment there just because the comment was short
 enough to place it on the right side)

>
> > +
> > +       /*
> > +        * Limit value of the register for a vcpu. The value is the sanitized
> > +        * system value with bits cleared for unsupported features for the
> > +        * guest.
> > +        */
>
> I think that rather than saying "with bits cleared for unsupported
> features", it might be better to rephrase along the lines of "with
> bits indicating" or "set/cleared to indicate", so that it applies to
> signed fields as well.

Thank you for the suggestion ! I will fix the comment.

>
> > +       u64     vcpu_limit_val;
> > +
> > +       /* Fields that we don't to validate by arm64_check_features. */
>
> Nit: Remove "to".

I will fix it.

>
> > +       u64     ignore_mask;
> > +
> > +       /* Initialization function of the id_reg_info */
> > +       void (*init)(struct id_reg_info *id_reg);
> > +       /*
> > +        * This is an optional ID register specific validation function.
> > +        * When userspace tries to set the ID register, arm64_check_features()
> > +        * will check if the requested value indicates any features that cannot
> > +        * be supported by KVM on the host.  But, some ID register fields need
> > +        * a special checking, and this function can be used for such fields.
> > +        * e.g. When SVE is configured for a vCPU by KVM_ARM_VCPU_INIT,
> > +        * ID_AA64PFR0_EL1.SVE shouldn't be set to 0 for the vCPU.
> > +        * The validation function for ID_AA64PFR0_EL1 could be used to check
> > +        * the field is consistent with SVE configuration.
> > +        */
> > +       int (*validate)(struct kvm_vcpu *vcpu, const struct id_reg_info *id_reg,
> > +                       u64 val);
> > +
> > +       /*
> > +        * Return a bitmask of the vCPU's ID register fields that are not
> > +        * synced with saved (per VM) ID register value, which usually
> > +        * indicates opt-in CPU features that is not configured for the vCPU.
>
> Nit: s/is/are

I will fix it.

>
>
> > +        * ID registers are saved per VM, but some opt-in CPU features can
> > +        * be configured per vCPU.  The saved (per VM) values for such
> > +        * features are for vCPUs with the features (and zero for
> > +        * vCPUs without the features).
> > +        * Return value of this function is used to handle such fields
> > +        * for per vCPU ID register read/write request with saved per VM
> > +        * ID register.  See the __write_id_reg's comment for more detail.
> > +        */
> > +       u64 (*vcpu_mask)(const struct kvm_vcpu *vcpu,
> > +                        const struct id_reg_info *id_reg);
> > +};
> > +
> > +static void id_reg_info_init(struct id_reg_info *id_reg)
> > +{
> > +       id_reg->vcpu_limit_val = read_sanitised_ftr_reg(id_reg->sys_reg);
> > +       if (id_reg->init)
>
> If there is an id_reg then the init function is necessary, isn't it?
> Otherwise it doesn't seem to add more than the default handling. If
> that's right, should we instead ensure that init is always set?

The init function is optional (maybe I should comment that).

>
> > +               id_reg->init(id_reg);
> > +}
> > +
> > +/*
> > + * An ID register that needs special handling to control the value for the
> > + * guest must have its own id_reg_info in id_reg_info_table.
> > + * (i.e. the reset value is different from the host's sanitized value,
> > + * the value is affected by opt-in features, some fields need specific
> > + * validation, etc.)
> > + */
> > +#define        GET_ID_REG_INFO(id)     (id_reg_info_table[IDREG_IDX(id)])
> > +static struct id_reg_info *id_reg_info_table[KVM_ARM_ID_REG_MAX_NUM] = {};
> > +
> > +static int validate_id_reg(struct kvm_vcpu *vcpu, u32 id, u64 val)
> > +{
> > +       const struct id_reg_info *id_reg = GET_ID_REG_INFO(id);
> > +       u64 limit, tmp_val;
> > +       int err;
> > +
> > +       if (id_reg) {
> > +               limit = id_reg->vcpu_limit_val;
> > +               /*
> > +                * Replace the fields that are indicated in ignore_mask with
> > +                * the value in the limit to not have arm64_check_features()
> > +                * check the field in @val.
> > +                */
> > +               tmp_val = val & ~id_reg->ignore_mask;
> > +               tmp_val |= (limit & id_reg->ignore_mask);
> > +       } else {
> > +               limit = read_sanitised_ftr_reg(id);
> > +               tmp_val = val;
> > +       }
> > +
> > +       /* Check if the value indicates any feature that is not in the limit. */
> > +       err = arm64_check_features(id, tmp_val, limit);
> > +       if (err)
> > +               return err;
> > +
> > +       if (id_reg && id_reg->validate)
> > +               /* Run the ID register specific validity check. */
> > +               err = id_reg->validate(vcpu, id_reg, val);
> > +
> > +       return err;
> > +}
> > +
> >  /*
> >   * ARMv8.1 mandates at least a trivial LORegion implementation, where all the
> >   * RW registers are RES0 (which we can implement as RAZ/WI). On an ARMv8.0
> > @@ -1061,9 +1156,81 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
> >         return true;
> >  }
> >
> > +static u64 read_kvm_id_reg(struct kvm *kvm, u32 id)
> > +{
> > +       return kvm->arch.id_regs[IDREG_IDX(id)];
> > +}
> > +
> > +static int modify_kvm_id_reg(struct kvm *kvm, u32 id, u64 val,
> > +                            u64 preserve_mask)
> > +{
> > +       u64 old, new;
> > +
> > +       mutex_lock(&kvm->lock);
> > +
> > +       old = kvm->arch.id_regs[IDREG_IDX(id)];
> > +
> > +       /* Preserve the value at the bit position set in preserve_mask */
> > +       new = old & preserve_mask;
> > +       new |= (val & ~preserve_mask);
> > +
> > +       /* Don't allow to modify ID register value after KVM_RUN on any vCPUs */
> > +       if (kvm_vm_has_started(kvm) && new != old)
> > +               return -EBUSY;
>
> This path doesn't release the lock. I see that it gets fixed in a
> future patch, but it might be good to fix it here...

Thank you for catching it ! Yes, I will fix this.

>
> > +
> > +       WRITE_ONCE(kvm->arch.id_regs[IDREG_IDX(id)], new);
> > +       mutex_unlock(&kvm->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int write_kvm_id_reg(struct kvm *kvm, u32 id, u64 val)
> > +{
> > +       return modify_kvm_id_reg(kvm, id, val, 0);
> > +}
> > +
> > +
> > +/*
> > + * KVM basically forces all vCPUs of the guest to have a uniform value for
> > + * each ID register (, which means KVM_SET_ONE_REG for a vCPU affects all
> > + * the vCPUs of the guest), and the id_regs[] of kvm_arch holds values
> > + * of ID registers for the guest.  However, there is an exception for
> > + * ID register fields corresponding to CPU features that can be
> > + * configured per vCPU by KVM_ARM_VCPU_INIT, or etc (e.g. PMUv3, SVE, etc).
> > + * For such fields, all vCPUs that have the feature will have a non-zero
> > + * uniform value (, which can be updated by userspace), but the vCPUs that
>
> Nit: uneven nesting of parentheses and commas :)

I will fix it.


> > + * don't have the feature will have zero for the fields.
> > + * Values that @id_regs holds are for vCPUs that have such features.  So,
> > + * to get the ID register value for a vCPU that doesn't have those features,
> > + * the corresponding fields in id_regs[] needs to be cleared.
> > + * A bitmask of the fields are provided by id_reg_info's vcpu_mask(), and
> > + * __write_id_reg() and __read_id_reg() take care of those fields using
> > + * the bitmask.
> > + */
> > +static int __write_id_reg(struct kvm_vcpu *vcpu, u32 id, u64 val)
> > +{
> > +       const struct id_reg_info *id_reg = GET_ID_REG_INFO(id);
> > +       u64 mask = 0;
> > +
> > +       if (id_reg && id_reg->vcpu_mask)
> > +               mask = id_reg->vcpu_mask(vcpu, id_reg);
> > +
> > +       /*
> > +        * Update the ID register for the guest with @val, except for fields
> > +        * that are set in the mask, which indicates fields for opt-in
> > +        * features that are not configured for the vCPU.
> > +        */
> > +       return modify_kvm_id_reg(vcpu->kvm, id, val, mask);
> > +}
> > +
> >  static u64 __read_id_reg(const struct kvm_vcpu *vcpu, u32 id)
> >  {
> > -       u64 val = vcpu->kvm->arch.id_regs[IDREG_IDX(id)];
> > +       const struct id_reg_info *id_reg = GET_ID_REG_INFO(id);
> > +       u64 val = read_kvm_id_reg(vcpu->kvm, id);
> > +
> > +       if (id_reg && id_reg->vcpu_mask)
> > +               /* Clear fields for opt-in features that are not configured. */
> > +               val &= ~(id_reg->vcpu_mask(vcpu, id_reg));
> >         switch (id) {
> >         case SYS_ID_AA64PFR0_EL1:
> > @@ -1222,12 +1389,7 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
> >         return 0;
> >  }
> >
> > -/*
> > - * cpufeature ID register user accessors
> > - *
> > - * For now, these registers are immutable for userspace, so for set_id_reg()
> > - * we don't allow the effective value to be changed.
> > - */
> > +/* cpufeature ID register user accessors */
> >  static int __get_id_reg(const struct kvm_vcpu *vcpu,
> >                         const struct sys_reg_desc *rd, void __user *uaddr,
> >                         bool raz)
> > @@ -1238,11 +1400,31 @@ static int __get_id_reg(const struct kvm_vcpu *vcpu,
> >         return reg_to_user(uaddr, &val, id);
> >  }
> >
> > +/*
> > + * Check if the given id indicates AArch32 ID register encoding.
> > + */
> > +static bool is_aarch32_id_reg(u32 id)
> > +{
> > +       u32 crm, op2;
> > +
> > +       if (!is_id_reg(id))
> > +               return false;
> > +
> > +       crm = sys_reg_CRm(id);
> > +       op2 = sys_reg_Op2(id);
> > +       if (crm == 1 || crm == 2 || (crm == 3 && (op2 != 3 && op2 != 7)))
>
> Consistent with the Arm ARM "Table D12-2 System instruction encodings
> for non-Debug System register accesses"
>
> > +               /* AArch32 ID register */
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  static int __set_id_reg(struct kvm_vcpu *vcpu,
> >                         const struct sys_reg_desc *rd, void __user *uaddr,
> >                         bool raz)
> >  {
> >         const u64 id = sys_reg_to_index(rd);
> > +       u32 encoding = reg_to_encoding(rd);
> >         int err;
> >         u64 val;
> >
> > @@ -1250,11 +1432,28 @@ static int __set_id_reg(struct kvm_vcpu *vcpu,
> >         if (err)
> >                 return err;
> >
> > -       /* This is what we mean by invariant: you can't change it. */
> > -       if (val != read_id_reg(vcpu, rd, raz))
> > +       if (val == read_id_reg(vcpu, rd, raz))
> > +               /* The value is same as the current value. Nothing to do. */
> > +               return 0;
> > +
> > +       /*
> > +        * Don't allow to modify the register's value if the register is raz,
> > +        * or the reg doesn't have the id_reg_info.
> > +        */
> > +       if (raz || !GET_ID_REG_INFO(encoding))
> >                 return -EINVAL;
> >
> > -       return 0;
> > +       /*
> > +        * Skip the validation of AArch32 ID registers if the system doesn't
> > +        * 32bit EL0 (their value are UNKNOWN).
> > +        */
> > +       if (system_supports_32bit_el0() || !is_aarch32_id_reg(encoding)) {
> > +               err = validate_id_reg(vcpu, encoding, val);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       return __write_id_reg(vcpu, encoding, val);
> >  }
> >
> >  static int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> > @@ -2816,6 +3015,20 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> >         return write_demux_regids(uindices);
> >  }
> >
> > +static void id_reg_info_init_all(void)
> > +{
> > +       int i;
> > +       struct id_reg_info *id_reg;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(id_reg_info_table); i++) {
> > +               id_reg = (struct id_reg_info *)id_reg_info_table[i];
> > +               if (!id_reg)
> > +                       continue;
> > +
> > +               id_reg_info_init(id_reg);
> > +       }
> > +}
> > +
> >  void kvm_sys_reg_table_init(void)
> >  {
> >         unsigned int i;
> > @@ -2850,6 +3063,8 @@ void kvm_sys_reg_table_init(void)
> >                         break;
> >         /* Clear all higher bits. */
> >         cache_levels &= (1 << (i*3))-1;
> > +
> > +       id_reg_info_init_all();
> >  }
> >
> >  /*
> > @@ -2862,11 +3077,12 @@ void set_default_id_regs(struct kvm *kvm)
> >         u32 id;
> >         const struct sys_reg_desc *rd;
> >         u64 val;
> > +       struct id_reg_info *idr;
> >
> >         for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
> >                 rd = &sys_reg_descs[i];
> >                 if (rd->access != access_id_reg)
> > -                       /* Not ID register, or hidden/reserved ID register */
> > +                       /* Not ID register or hidden/reserved ID register */
> >                         continue;
> >
> >                 id = reg_to_encoding(rd);
> > @@ -2874,7 +3090,8 @@ void set_default_id_regs(struct kvm *kvm)
> >                         /* Shouldn't happen */
> >                         continue;
> >
> > -               val = read_sanitised_ftr_reg(id);
> > -               kvm->arch.id_regs[IDREG_IDX(id)] = val;
> > +               idr = GET_ID_REG_INFO(id);
> > +               val = idr ? idr->vcpu_limit_val : read_sanitised_ftr_reg(id);
> > +               (void)write_kvm_id_reg(kvm, id, val);
>
> Rather than ignoring the return value of write_kvm_id_reg(), wouldn't
> it be better if set_default_id_regs were to propagate it back to
> kvm_arch_init_vm in case there's a problem?

Since write_kvm_id_reg() should never return an error for this
case, returning an error to kvm_arch_init_vm() adds a practically
unnecessary error handling, which I would like to avoid.
So, how about putting WARN_ON_ONCE on its return value ?

Thanks,
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
