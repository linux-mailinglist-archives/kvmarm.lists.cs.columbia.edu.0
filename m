Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5E49C36D
	for <lists+kvmarm@lfdr.de>; Wed, 26 Jan 2022 07:04:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 71531411D2;
	Wed, 26 Jan 2022 01:04:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.912
X-Spam-Level: 
X-Spam-Status: No, score=0.912 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_BLOCKED=0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uq9ylATniuXX; Wed, 26 Jan 2022 01:04:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5A5D40E00;
	Wed, 26 Jan 2022 01:04:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DCC8F4017A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 01:04:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vc0XEtw1G9Bp for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jan 2022 01:04:44 -0500 (EST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6092940AEB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 01:04:44 -0500 (EST)
Received: by mail-pf1-f169.google.com with SMTP id d187so488730pfa.10
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Jan 2022 22:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xd7lpBs3fg2+dxWL2E53F45VMmbGE2eht3kadsQcGNA=;
 b=QkS4b1UrnnBPaF6xGkrUHFc5lHaYz+lPJeb2AGnZ0xBTPvmK5pwNVRlpFAG53eXsvb
 eostD9W5CCGqlyUmD8B0Wtem+4LBDpF1b/548CzDG7l4LpgMdlSYx2STJJiN7WfmxHWQ
 5Mlq2bczBtiipGHOWzeEHEStZZpsz3DgZXqTYCUHP1ZFZfeGvrsiLoGn3Sj2oSf+iK5+
 gZ/Ax5KTzKHNekusU9UFqXkQW/ZXR7COe+nzShQEussToFxXCupAExRYWp4LW3o3Av5e
 XY/WcQYH4Vu+oSbIjci8nKLMd7vAjkuGu0QxJ/iX4VJLuAOh1mJjQ15ALTjxBOrx369B
 pzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xd7lpBs3fg2+dxWL2E53F45VMmbGE2eht3kadsQcGNA=;
 b=OYAALljJ6ADqhpLaJhOyAvpQ/rU8/dTh97VvwnXN27NiDvGOrhPHDQjo9iPC5bfnQZ
 PL5ruSULEqaS1iHluvFOhwLwn5LT5Rh8z2yVPF4Jc71z7mFgfEE0RzQUgcTGRXUH84oe
 Bl9xwiZFmlxEdm6pw9FIWcZRjlSQ2KB5md+ud8PFhJlgaLbeICB3dlC3xApzZw0Iz5Eg
 CUI8otc6LIJlmrFk6DPcXWBIjwli+AGb+Vm2OBb3dnMJlEsf5qH47VCfnEisROw8MpO+
 ZLHIo6UuDdgm72G0Q724rcDrLGNXte+N8y0xdidUE+MHsJFcJ3oRnpDVaUfco5r6AJ/V
 07zg==
X-Gm-Message-State: AOAM530TqUErVqNo6L39XvrJ8eY3MRWm16Fg3vkx379fD7PnKs51XIb0
 8WHwY79X/j7JrYaEUsA2D3liz1dWGFAy5z9tT1UFtJMZ0uCz+g==
X-Google-Smtp-Source: ABdhPJzw0M1bslpmvBR8WXUGKxOcMeZd18HsYC5FwjHDxo5uLelw8Cp4WTb6uUKVMpdC8T9RoqW4QSMOunfsFm8/tOQ=
X-Received: by 2002:a05:6a00:ac4:b0:4bd:6555:1746 with SMTP id
 c4-20020a056a000ac400b004bd65551746mr21625175pfl.39.1643177083215; Tue, 25
 Jan 2022 22:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20220106042708.2869332-1-reijiw@google.com>
 <20220106042708.2869332-2-reijiw@google.com>
 <CA+EHjTx+b0ZVw30riW4OUVP4BCPeJZe+gr5_ycHkPbwU=y7sqA@mail.gmail.com>
In-Reply-To: <CA+EHjTx+b0ZVw30riW4OUVP4BCPeJZe+gr5_ycHkPbwU=y7sqA@mail.gmail.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Tue, 25 Jan 2022 22:04:26 -0800
Message-ID: <CAAeT=Fy8AXaM1SGs1wRssTZ9QW9bH-d1d_sCdSrC7EitZLPKBw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 01/26] KVM: arm64: Introduce a validation function
 for an ID register
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

> > +/*
> > + * Override entries in @orig_ftrp with the ones in @new_ftrp when their shift
> > + * fields match.  The last entry of @orig_ftrp and @new_ftrp must be
> > + * ARM64_FTR_END (.width == 0).
> > + */
> > +static void arm64_ftr_reg_bits_overrite(struct arm64_ftr_bits *orig_ftrp,
>
> s/overrite/override

Thank you for catching this. I will fix it.


> > +                                       struct arm64_ftr_bits *new_ftrp)
>
> Should this be const struct arm64_ftr_bits *new_ftrp, which would also
> make it consistent with copy_arm64_ftr_bits()?

Yes, I will make new_ftrp const.

>
> > +{
> > +       struct arm64_ftr_bits *o_ftrp, *n_ftrp;
> > +
> > +       for (n_ftrp = new_ftrp; n_ftrp->width; n_ftrp++) {
> > +               for (o_ftrp = orig_ftrp; o_ftrp->width; o_ftrp++) {
> > +                       if (o_ftrp->shift == n_ftrp->shift) {
> > +                               *o_ftrp = *n_ftrp;
> > +                               break;
> > +                       }
> > +               }
> > +       }
> > +}
> > +
>
> ...
>
> > +/*
> > + * Initialize arm64_ftr_bits_kvm.  Copy arm64_ftr_bits for each ID register
> > + * from arm64_ftr_regs to arm64_ftr_bits_kvm, and then override entries in
> > + * arm64_ftr_bits_kvm with ones in arm64_ftr_bits_kvm_override.
> > + */
> > +static int init_arm64_ftr_bits_kvm(void)
> > +{
> > +       struct arm64_ftr_bits ftr_temp[MAX_FTR_BITS_LEN];
> > +       static struct __ftr_reg_bits_entry *reg_bits_array, *bits, *o_bits;
> > +       int i, j, nent, ret;
> > +
> > +       mutex_lock(&arm64_ftr_bits_kvm_lock);
> > +       if (arm64_ftr_bits_kvm) {
> > +               /* Already initialized */
> > +               ret = 0;
> > +               goto unlock_exit;
> > +       }
> > +
> > +       nent = ARRAY_SIZE(arm64_ftr_regs);
> > +       reg_bits_array = kcalloc(nent, sizeof(struct __ftr_reg_bits_entry),
> > +                                GFP_KERNEL);
> > +       if (!reg_bits_array) {
> > +               ret = ENOMEM;
>
> Should this be -ENOMEM?

Yes, I will fix it.


> > +               goto unlock_exit;
> > +       }
> > +
> > +       /* Copy entries from arm64_ftr_regs to reg_bits_array */
> > +       for (i = 0; i < nent; i++) {
> > +               bits = &reg_bits_array[i];
> > +               bits->sys_id = arm64_ftr_regs[i].sys_id;
> > +               bits->ftr_bits = (struct arm64_ftr_bits *)arm64_ftr_regs[i].reg->ftr_bits;
> > +       };
> > +
> > +       /*
> > +        * Override the entries in reg_bits_array with the ones in
> > +        * arm64_ftr_bits_kvm_override.
> > +        */
> > +       for (i = 0; i < ARRAY_SIZE(arm64_ftr_bits_kvm_override); i++) {
> > +               o_bits = &arm64_ftr_bits_kvm_override[i];
> > +               for (j = 0; j < nent; j++) {
> > +                       bits = &reg_bits_array[j];
> > +                       if (bits->sys_id != o_bits->sys_id)
> > +                               continue;
> > +
> > +                       memset(ftr_temp, 0, sizeof(ftr_temp));
> > +
> > +                       /*
> > +                        * Temporary save all entries in o_bits->ftr_bits
> > +                        * to ftr_temp.
> > +                        */
> > +                       copy_arm64_ftr_bits(ftr_temp, o_bits->ftr_bits);
> > +
> > +                       /*
> > +                        * Copy entries from bits->ftr_bits to o_bits->ftr_bits.
> > +                        */
> > +                       copy_arm64_ftr_bits(o_bits->ftr_bits, bits->ftr_bits);
> > +
> > +                       /*
> > +                        * Override entries in o_bits->ftr_bits with the
> > +                        * saved ones, and update bits->ftr_bits with
> > +                        * o_bits->ftr_bits.
> > +                        */
> > +                       arm64_ftr_reg_bits_overrite(o_bits->ftr_bits, ftr_temp);
> > +                       bits->ftr_bits = o_bits->ftr_bits;
> > +                       break;
> > +               }
> > +       }
>
> Could you please explain using ftr_temp[] and changing the value in
> arm64_ftr_bits_kvm_override, rather than just
> arm64_ftr_reg_bits_overrite(bits->ftr_bits, o_bits->ftr_bits)?

I would like to maintain the order of the entries in the original
ftr_bits so that (future) functions that work for the original ones
also work for the KVM's.
The copy and override is an easy way to do that.  The same thing can
be done without ftr_temp[], but it would look a bit tricky.

If we assume the order shouldn't matter or entries in ftr_bits
are always in descending order, just changing the value in
arm64_ftr_bits_kvm_override would be a much simpler way though.


>
>
> > +static const struct arm64_ftr_bits *get_arm64_ftr_bits_kvm(u32 sys_id)
> > +{
> > +       const struct __ftr_reg_bits_entry *ret;
> > +       int err;
> > +
> > +       if (!arm64_ftr_bits_kvm) {
> > +               /* arm64_ftr_bits_kvm is not initialized yet. */
> > +               err = init_arm64_ftr_bits_kvm();
>
> Rather than doing this check, can we just initialize it earlier, maybe
> (indirectly) via kvm_arch_init_vm() or around the same time?

Thank you for the comment.
I will consider when it should be initialized.
( perhaps even earlier than kvm_arch_init_vm())

>
>
> > +               if (err)
> > +                       return NULL;
> > +       }
> > +
> > +       ret = bsearch((const void *)(unsigned long)sys_id,
> > +                     arm64_ftr_bits_kvm,
> > +                     arm64_ftr_bits_kvm_nentries,
> > +                     sizeof(arm64_ftr_bits_kvm[0]),
> > +                     search_cmp_ftr_reg_bits);
> > +       if (ret)
> > +               return ret->ftr_bits;
> > +
> > +       return NULL;
> > +}
> > +
> > +/*
> > + * Check if features (or levels of features) that are indicated in the ID
> > + * register value @val are also indicated in @limit.
> > + * This function is for KVM to check if features that are indicated in @val,
> > + * which will be used as the ID register value for its guest, are supported
> > + * on the host.
> > + * For AA64MMFR0_EL1.TGranX_2 fields, which don't follow the standard ID
> > + * scheme, the function checks if values of the fields in @val are the same
> > + * as the ones in @limit.
> > + */
> > +int arm64_check_features(u32 sys_reg, u64 val, u64 limit)
> > +{
> > +       const struct arm64_ftr_bits *ftrp = get_arm64_ftr_bits_kvm(sys_reg);
> > +       u64 exposed_mask = 0;
> > +
> > +       if (!ftrp)
> > +               return -ENOENT;
> > +
> > +       for (; ftrp->width; ftrp++) {
> > +               s64 ftr_val = arm64_ftr_value(ftrp, val);
> > +               s64 ftr_lim = arm64_ftr_value(ftrp, limit);
> > +
> > +               exposed_mask |= arm64_ftr_mask(ftrp);
> > +
> > +               if (ftr_val == ftr_lim)
> > +                       continue;
>
> At first I thought that this check isn't necessary, it should be
> covered by the check below (arm64_ftr_safe_value. However, I think
> that it's needed for the FTR_HIGHER_OR_ZERO_SAFE case. If my
> understanding is correct, it might be worth adding a comment, or even
> encapsulating this logic in a arm64_is_safe_value() function for
> clarity.

In my understanding, arm64_ftr_safe_value() provides a safe value
when two values are different, and I think there is nothing special
about the usage of this function (This is actually how the function
is used by update_cpu_ftr_reg()).
Without the check, it won't work for FTR_EXACT, but there might be
more in the future.

Perhaps it might be more straightforward to add the equality check
into arm64_ftr_safe_value() ?

>
> > +
> > +               if (ftr_val != arm64_ftr_safe_value(ftrp, ftr_val, ftr_lim))
> > +                       return -E2BIG;
> > +       }
> > +
> > +       /* Make sure that no unrecognized fields are set in @val. */
> > +       if (val & ~exposed_mask)
> > +               return -E2BIG;
> > +
> > +       return 0;
> > +}

Thanks,
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
