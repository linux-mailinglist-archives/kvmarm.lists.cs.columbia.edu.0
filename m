Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC4456958
	for <lists+kvmarm@lfdr.de>; Fri, 19 Nov 2021 05:48:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8789C4B154;
	Thu, 18 Nov 2021 23:48:15 -0500 (EST)
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
	with ESMTP id Sk0ob4S1tdHl; Thu, 18 Nov 2021 23:48:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F2BC24B11B;
	Thu, 18 Nov 2021 23:48:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B39AB4B10C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Nov 2021 23:48:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1BoBnbQEoiLe for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Nov 2021 23:48:11 -0500 (EST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0F8B84B108
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Nov 2021 23:48:11 -0500 (EST)
Received: by mail-pj1-f48.google.com with SMTP id
 gx15-20020a17090b124f00b001a695f3734aso7859709pjb.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Nov 2021 20:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QoHMt8LQUTb/w8rEtIXtkstD7X6Wu7UF3Mkd4lNy0LM=;
 b=f6mE+4ldYjvX5BJjmShvzZEMh3rnrUBTxlm+JT423a5ncMdZ/VrE6xWERj1wVvZnJg
 3Dfv0OYWvbNcdNKK/07mp7loX0QW0l6uNlZQ2zbPRIg39ZIzpo6j1nciS5cIaLwP/mvq
 2S+8fUbR1sU8bLfFd8BDRuwdNc1Oorz1g64qaS1ZyhaHIt50GgGG3amMgonK7S4A98yH
 5+fd22zdHRWrceTvR+mA2diDl5QuPtJJuYDmMkohPdNGKcsN53vP8w+ukpPuvel2Ps7J
 qB5HM/E5a16x+LEjZrc+by6RwXaQFsw9/aOfvXzHkSuNI2TAyIy4I2J0Ca+BZKSFOfQ7
 CNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QoHMt8LQUTb/w8rEtIXtkstD7X6Wu7UF3Mkd4lNy0LM=;
 b=O27b+YmxLI5MjZVsOxvdwqQPWucQW74kIpRDctBOOuCjIp5dRIjtRbzXvDV/g8FeJl
 41Shq/jrGxoVBC1k1NIep2YQN+dbUuQjwVJh/qYW9H9RFZwhamOAdDmsVykYstJSxKLj
 F4/U9YB9gGIhj2uvTvfwwottiiH1V+3x92xweMbY2A9FUJKbvYkIUjKb1t/ayObVTnh6
 8FY9AbwFaZp/btFse0MZwk7H3txn7ue/jq6TU7wxsDrAnYvi126GnBXemSXOFyPEKK5T
 jG+7/QoYANghDr2iRV0c4iLjLMB5T+NqSuHQ90JB4cImieVQgxBzzrOE3RjWtY2U6/Ed
 EZUA==
X-Gm-Message-State: AOAM533LwErn0uKPscCcBYacJFUi4BZkCrbbhxeJpANyizCALT42tNsF
 Oj+vgZ3mOtDjl3Uc+NVeI1X8mqoDPkR2dKD/vpXv8Q==
X-Google-Smtp-Source: ABdhPJycAlRxaIvHJJXbqCGSK0+HzBRgJ+ZDhfwoA9cw6lmE0XvsRNi8m9y30tvBRIhyXpjjclu41pp0XPEkOGMUgRU=
X-Received: by 2002:a17:902:d703:b0:144:e012:d550 with SMTP id
 w3-20020a170902d70300b00144e012d550mr7302851ply.38.1637297289775; Thu, 18 Nov
 2021 20:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20211117064359.2362060-1-reijiw@google.com>
 <20211117064359.2362060-4-reijiw@google.com>
 <d3fd9d6c-c96c-d7a0-b78d-af36430dbf3f@redhat.com>
In-Reply-To: <d3fd9d6c-c96c-d7a0-b78d-af36430dbf3f@redhat.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Thu, 18 Nov 2021 20:47:53 -0800
Message-ID: <CAAeT=FyzvGaksi+-WidHObrGYcqs4vR73ChCGpo8AFuin6UbYw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 03/29] KVM: arm64: Introduce struct id_reg_info
To: Eric Auger <eauger@redhat.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Hi Eric,

On Thu, Nov 18, 2021 at 12:36 PM Eric Auger <eauger@redhat.com> wrote:
>
> Hi Reiji,
>
> On 11/17/21 7:43 AM, Reiji Watanabe wrote:
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
> >  arch/arm64/include/asm/sysreg.h |   1 +
> >  arch/arm64/kvm/sys_regs.c       | 226 ++++++++++++++++++++++++++++++--
> >  2 files changed, 218 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 16b3f1a1d468..597609f26331 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -1197,6 +1197,7 @@
> >  #define ICH_VTR_TDS_MASK     (1 << ICH_VTR_TDS_SHIFT)
> >
> >  #define ARM64_FEATURE_FIELD_BITS     4
> > +#define ARM64_FEATURE_FIELD_MASK     ((1ull << ARM64_FEATURE_FIELD_BITS) - 1)
> >
> >  /* Create a mask for the feature bits of the specified feature. */
> >  #define ARM64_FEATURE_MASK(x)        (GENMASK_ULL(x##_SHIFT + ARM64_FEATURE_FIELD_BITS - 1, x##_SHIFT))
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 5608d3410660..1552cd5581b7 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -265,6 +265,181 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
> >               return read_zero(vcpu, p);
> >  }
> >
> > +/*
> > + * A value for FCT_LOWER_SAFE must be zero and changing that will affect
> > + * ftr_check_types of id_reg_info.
> > + */
> > +enum feature_check_type {
> > +     FCT_LOWER_SAFE = 0,
> > +     FCT_HIGHER_SAFE,
> > +     FCT_HIGHER_OR_ZERO_SAFE,
> > +     FCT_EXACT,
> > +     FCT_EXACT_OR_ZERO_SAFE,
> > +     FCT_IGNORE,     /* Don't check (any value is fine) */
> Maybe you can remove the _SAFE suffix (EXACT does not have it).

I am inclined to keep 'SAFE' (otherwise, I am likely to forget
if lower is safe or not).

> s/EXACT/EQUAL ?

I will fix that FCT_EXACT to FCT_EQUAL_SAFE.

> > +};
> > +
> > +static int arm64_check_feature_one(enum feature_check_type type, int val,
> > +                                int limit)
> > +{
> > +     bool is_safe = false;
> > +
> > +     if (val == limit)
> > +             return 0;
> even if the type is unexpected?

I will remove it.

> > +
> > +     switch (type) {
> > +     case FCT_LOWER_SAFE:
> > +             is_safe = (val <= limit);
> > +             break;
> > +     case FCT_HIGHER_OR_ZERO_SAFE:
> > +             if (val == 0) {
> > +                     is_safe = true;
> > +                     break;
> > +             }
> > +             fallthrough;
> > +     case FCT_HIGHER_SAFE:
> > +             is_safe = (val >= limit);
> > +             break;
> > +     case FCT_EXACT:
> > +             break;
> > +     case FCT_EXACT_OR_ZERO_SAFE:
> > +             is_safe = (val == 0);
> > +             break;
> > +     case FCT_IGNORE:
> > +             is_safe = true;
> > +             break;
> > +     default:
> > +             WARN_ONCE(1, "Unexpected feature_check_type (%d)\n", type);
> > +             break;
> > +     }
> > +
> > +     return is_safe ? 0 : -1;
> > +}
> > +
> > +#define      FCT_TYPE_MASK           0x7
> > +#define      FCT_TYPE_SHIFT          1
> > +#define      FCT_SIGN_MASK           0x1
> > +#define      FCT_SIGN_SHIFT          0
> > +#define      FCT_TYPE(val)   ((val >> FCT_TYPE_SHIFT) & FCT_TYPE_MASK)
> > +#define      FCT_SIGN(val)   ((val >> FCT_SIGN_SHIFT) & FCT_SIGN_MASK)
> > +
> > +#define      MAKE_FCT(shift, type, sign)                             \
> > +     ((u64)((((type) & FCT_TYPE_MASK) << FCT_TYPE_SHIFT) |   \
> > +            (((sign) & FCT_SIGN_MASK) << FCT_SIGN_SHIFT)) << (shift))
> > +
> > +/* For signed field */
> > +#define      S_FCT(shift, type)      MAKE_FCT(shift, type, 1)
> > +/* For unigned field */
> > +#define      U_FCT(shift, type)      MAKE_FCT(shift, type, 0)
> > +
> > +/*
> > + * @val and @lim are both a value of the ID register. The function checks
> > + * if all features indicated in @val can be supported for guests on the host,
> > + * which supports features indicated in @lim. @check_types indicates how> + * features in the ID register needs to be checked.
> > + * See comments for id_reg_info's ftr_check_types field for more detail.
> What about RES0 fields which may exist? add a comment to reassure about
> the fact they are properly handled if there are?

Any fields including RES0 should be checked based on check_types.
I will explicitly state that in the comment.

> > + */
> > +static int arm64_check_features(u64 check_types, u64 val, u64 lim)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < 64; i += ARM64_FEATURE_FIELD_BITS) {
> > +             u8 ftr_check = (check_types >> i) & ARM64_FEATURE_FIELD_MASK;
> > +             bool is_sign = FCT_SIGN(ftr_check);
> > +             enum feature_check_type fctype = FCT_TYPE(ftr_check);
> > +             int fval, flim, ret;
> > +
> > +             fval = cpuid_feature_extract_field(val, i, is_sign);
> > +             flim = cpuid_feature_extract_field(lim, i, is_sign);
> > +
> > +             ret = arm64_check_feature_one(fctype, fval, flim);
> > +             if (ret)
> > +                     return -E2BIG;
> > +     }
> > +     return 0;
> > +}
> > +
> > +struct id_reg_info {
> > +     u32     sys_reg;        /* Register ID */
> use struct kernel-doc comments instead?
> > +
> > +     /*
> > +      * Limit value of the register for a vcpu. The value is the sanitized
> > +      * system value with bits cleared for unsupported features for the
> > +      * guest.
> > +      */
> > +     u64     vcpu_limit_val;
> > +
> > +     /*
> > +      * The ftr_check_types is comprised of a set of 4 bits fields.
> nit: s/bits field/bit field here and below

I will fix them.

> > +      * Each 4 bits field is for a feature indicated by the same bits
> > +      * field of the ID register and indicates how the feature support
> > +      * for guests needs to be checked.
> > +      * The bit 0 indicates that the corresponding ID register field
> > +      * is signed(1) or unsigned(0).
> > +      * The bits [3:1] hold feature_check_type for the field.
> > +      * If all zero, all features in the ID register are treated as unsigned
> > +      * fields and checked based on Principles of the ID scheme for fields
> > +      * in ID registers (FCT_LOWER_SAFE of feature_check_type).
> values set by the guest are checked against host ID field values
> according to FCT_LOWER_SAFE test? You do not actually explicitly explain
> what the check is about although this may be obvious for you?

How about this ?

        /*
         * The ftr_check_types is comprised of a set of 4 bit fields.
         * Each 4 bit field is for a feature indicated by the same bit field
         * of the ID register and indicates how the field needs to be checked
         * (by arm64_check_feature_one) against the host's ID field when
         * userspace tries to set the register.
         * The bit 0 indicates that the corresponding ID register field is
         * signed(1) or unsigned(0). The bits [3:1] hold feature_check_type
         * for the field (FCT_LOWER_SAFE == 0, etc).
         * e.g. for ID_AA64PFR0_EL1.SVE(bits [35:32]), bits[35:32] of
         * ftr_check_types for the register should be 0. It means the SVE
         * field is treated as an unsigned field, and userspace can set the
         * field to a equal or lower value than the host's ID field value.
         */

> > +      */
> > +     u64     ftr_check_types;
> > +
> > +     /* Initialization function of the id_reg_info */
> > +     void (*init)(struct id_reg_info *id_reg);
> > +
> > +     /* Register specific validation function */
> validation callback? it does not register anything. We have check
> customization means already in ftr_check_types so it is difficult to
> guess at that point why this cb is needed, all the more so it applies
> after the ftr_checks.

I am going to add the following comment. Does it look clear enough for you ?

        /*
         * This is an optional ID register specific validation function.
         * When userspace tries to set the ID register, arm64_check_features()
         * will check if the requested value indicates any features that cannot
         * be supported by KVM on the host.  But, some ID register fields need
         * a special checking and this function can be used for such fields.
         * e.g. KVM_CREATE_DEVICE must be used to configure GICv3 for a guest.
         * ID_AA64PFR0_EL1.GIC shouldn't be set to 1 unless GICv3 is configured.
         * The validation function for ID_AA64PFR0_EL1 could be used to check
         * the field is consistent with GICv3 configuration.
         */

> > +     int (*validate)(struct kvm_vcpu *vcpu, const struct id_reg_info *id_reg,
> > +                     u64 val);
> > +
> > +     /* Return the reset value of the register for the vCPU */
> > +     u64 (*get_reset_val)(struct kvm_vcpu *vcpu,
> > +                          const struct id_reg_info *id_reg);
> > +};
> > +
> > +static void id_reg_info_init(struct id_reg_info *id_reg)
> > +{
> > +     id_reg->vcpu_limit_val = read_sanitised_ftr_reg(id_reg->sys_reg);
> > +     if (id_reg->init)
> > +             id_reg->init(id_reg);
> > +}
> > +
> > +/*
> > + * An ID register that needs special handling to control the value for the
> > + * guest must have its own id_reg_info in id_reg_info_table.
> > + * (i.e. the reset value is different from the host's sanitized value,
> > + * the value is affected by opt-in features, some fields needs specific
> s/needs/need

I will fix it.

Thank you for your review !

Regards
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
