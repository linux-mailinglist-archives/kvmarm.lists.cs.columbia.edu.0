Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02C14487363
	for <lists+kvmarm@lfdr.de>; Fri,  7 Jan 2022 08:12:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CF9F4B0EF;
	Fri,  7 Jan 2022 02:12:50 -0500 (EST)
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
	with ESMTP id IF+f2V1RDjD5; Fri,  7 Jan 2022 02:12:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF0A44B0C0;
	Fri,  7 Jan 2022 02:12:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 26CB24B0A3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 02:12:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sObdJ6CJRsYP for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jan 2022 02:12:46 -0500 (EST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AE1984B08E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 02:12:46 -0500 (EST)
Received: by mail-pj1-f47.google.com with SMTP id
 d10-20020a17090a498a00b001b33bc40d01so2302197pjh.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 06 Jan 2022 23:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kbcPDOVFWP/YoljnZK4KEPygQkk4mWtbYx8io3Et7Vw=;
 b=hFNJ/2vCxmPB/RyLp/aeRUeCE51MnM2jcfBxGMSoPxuIDBqa32Sg6r9wK0/psKQLBq
 MWlyyH4od+uM79+M9jXCj2vbmpcORUdzEpEPzKFjjOH88vORYKcAEFu2Qk5G/2z8SlV1
 bzl/vunozjdqCeU/Y1v5iSAuZuYp+sVMfMSTEy8+x3p6TG44ufPq//gPx3Ul4HQ3zZd7
 RJbH+rDaW5T9cJ+bJW9ARC0geiawneZGfAm+fY31v1SWGu8yGBtmTxQMUP0Shlj6wlFF
 wDArec0wtOxMpBZVCbw87X1Xz7QVbymLWm3vZ/i1MBzoDQ5JbOTqL42+e2Ital80uazp
 IIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kbcPDOVFWP/YoljnZK4KEPygQkk4mWtbYx8io3Et7Vw=;
 b=EngEbnMtNXlYoJbEjkUCPumLuzzy+lmr4rvKZC4NG9cNsufCoSGB7R8to7Ng71rBzL
 xp7++baBoYALAeGuL4R/A6tsAna5S/Y1qsSiGSyviSmFpk61/aqj+0iasH2oOW+o2wy0
 dVY5nrU6cUye5JYVhsl9VgZdzN2oxUzA6/K89hGIQAokOoRzUs/ZnUdinORjAy0qKDUA
 3ogFvhyukgEO6tHSg0Xf5QjwkIVYqeQJRxgXRs9eH8Xhok7IwurgiGfrjezfDQeXg0e0
 HL3Llh7YqLdZwbmT+StrlW9DIYJt+Pdvv0Ahv4a7QK85jKxrSyYyYLE3WRl8AHfnG6QJ
 16fw==
X-Gm-Message-State: AOAM531B5qpo5/UOQcdLSsvybbueLd6pGk450BBwT+s7Rbg4ZqXf7IQs
 MsZZNtzEiakYr5RFScQaJIauN/vvSP8+9rud4WIZVDgbVW5yeA==
X-Google-Smtp-Source: ABdhPJwsb0Gv9vEPitDKlPfU9K/EV4+Ot0zzw1eukA8w2Pg2+Clqhc1BGKuyNR4H91D/xqtTAKv0lkEB9Mfong3YTkc=
X-Received: by 2002:a17:90b:3b49:: with SMTP id
 ot9mr14404416pjb.110.1641539565579; 
 Thu, 06 Jan 2022 23:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20220106042708.2869332-1-reijiw@google.com>
 <20220106042708.2869332-2-reijiw@google.com>
In-Reply-To: <20220106042708.2869332-2-reijiw@google.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Thu, 6 Jan 2022 23:12:28 -0800
Message-ID: <CAAeT=FxEr4N4j7tJQKpUANM1dSrpZrgDLaYEOVLRhmXWPn52NA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 01/26] KVM: arm64: Introduce a validation function
 for an ID register
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Wed, Jan 5, 2022 at 8:28 PM Reiji Watanabe <reijiw@google.com> wrote:
>
> Introduce arm64_check_features(), which does a basic validity checking
> of an ID register value against the register's limit value, which is
> generally the host's sanitized value.
>
> This function will be used by the following patches to check if an ID
> register value that userspace tries to set for a guest can be supported
> on the host.
>
> The validation is done using arm64_ftr_bits_kvm, which is created from
> arm64_ftr_regs, with some entries overwritten by entries from
> arm64_ftr_bits_kvm_override.
>
> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |   1 +
>  arch/arm64/kernel/cpufeature.c      | 228 ++++++++++++++++++++++++++++
>  2 files changed, 229 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ef6be92b1921..eda7ddbed8cf 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -631,6 +631,7 @@ void check_local_cpu_capabilities(void);
>
>  u64 read_sanitised_ftr_reg(u32 id);
>  u64 __read_sysreg_by_encoding(u32 sys_id);
> +int arm64_check_features(u32 sys_reg, u64 val, u64 limit);
>
>  static inline bool cpu_supports_mixed_endian_el0(void)
>  {
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6f3e677d88f1..48dff8b101d9 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3140,3 +3140,231 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
>                 return sprintf(buf, "Vulnerable\n");
>         }
>  }
> +
> +#ifdef CONFIG_KVM
> +/*
> + * arm64_ftr_bits_kvm[] is used for KVM to check if features that are
> + * indicated in an ID register value for the guest are available on the host.
> + * arm64_ftr_bits_kvm[] is created based on arm64_ftr_regs[].  But, for
> + * registers for which arm64_ftr_bits_kvm_override[] has a corresponding
> + * entry, replace arm64_ftr_bits entries in arm64_ftr_bits_kvm[] with the
> + * ones in arm64_ftr_bits_kvm_override[].
> + */
> +static struct __ftr_reg_bits_entry *arm64_ftr_bits_kvm;
> +static size_t arm64_ftr_bits_kvm_nentries;
> +static DEFINE_MUTEX(arm64_ftr_bits_kvm_lock);
> +
> +/*
> + * Number of arm64_ftr_bits entries for each register.
> + * (Number of 4 bits fields in 64 bit register + 1 entry for ARM64_FTR_END)
> + */
> +#define        MAX_FTR_BITS_LEN        17
> +
> +/* Use FTR_LOWER_SAFE for AA64DFR0_EL1.PMUVER and AA64DFR0_EL1.DEBUGVER. */
> +static struct arm64_ftr_bits ftr_id_aa64dfr0_kvm[MAX_FTR_BITS_LEN] = {
> +       S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
> +       ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
> +       ARM64_FTR_END,
> +};
> +
> +#define        ARM64_FTR_REG_BITS(id, table)   {       \
> +       .sys_id = id,                           \
> +       .ftr_bits = &((table)[0]),              \
> +}
> +
> +struct __ftr_reg_bits_entry {
> +       u32     sys_id;
> +       struct arm64_ftr_bits   *ftr_bits;
> +};
> +
> +/*
> + * All entries in arm64_ftr_bits_kvm_override[] are used to override
> + * the corresponding entries in arm64_ftr_bits_kvm[].
> + */
> +static struct __ftr_reg_bits_entry arm64_ftr_bits_kvm_override[] = {
> +       ARM64_FTR_REG_BITS(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0_kvm),
> +};
> +
> +/*
> + * Override entries in @orig_ftrp with the ones in @new_ftrp when their shift
> + * fields match.  The last entry of @orig_ftrp and @new_ftrp must be
> + * ARM64_FTR_END (.width == 0).
> + */
> +static void arm64_ftr_reg_bits_overrite(struct arm64_ftr_bits *orig_ftrp,
> +                                       struct arm64_ftr_bits *new_ftrp)
> +{
> +       struct arm64_ftr_bits *o_ftrp, *n_ftrp;
> +
> +       for (n_ftrp = new_ftrp; n_ftrp->width; n_ftrp++) {
> +               for (o_ftrp = orig_ftrp; o_ftrp->width; o_ftrp++) {
> +                       if (o_ftrp->shift == n_ftrp->shift) {
> +                               *o_ftrp = *n_ftrp;
> +                               break;
> +                       }
> +               }
> +       }
> +}
> +
> +/*
> + * Copy arm64_ftr_bits entries from @src_ftrp to @dst_ftrp.  The last entries
> + * of @dst_ftrp and @src_ftrp must be ARM64_FTR_END (.width == 0).
> + */
> +static void copy_arm64_ftr_bits(struct arm64_ftr_bits *dst_ftrp,
> +                               const struct arm64_ftr_bits *src_ftrp)
> +{
> +       int i = 0;
> +
> +       for (; src_ftrp[i].width; i++) {
> +               if (WARN_ON_ONCE(i >= (MAX_FTR_BITS_LEN - 1)))
> +                       break;
> +
> +               dst_ftrp[i] = src_ftrp[i];
> +       }
> +
> +       dst_ftrp[i].width = 0;
> +}
> +
> +/*
> + * Initialize arm64_ftr_bits_kvm.  Copy arm64_ftr_bits for each ID register
> + * from arm64_ftr_regs to arm64_ftr_bits_kvm, and then override entries in
> + * arm64_ftr_bits_kvm with ones in arm64_ftr_bits_kvm_override.
> + */
> +static int init_arm64_ftr_bits_kvm(void)
> +{
> +       struct arm64_ftr_bits ftr_temp[MAX_FTR_BITS_LEN];
> +       static struct __ftr_reg_bits_entry *reg_bits_array, *bits, *o_bits;
> +       int i, j, nent, ret;
> +
> +       mutex_lock(&arm64_ftr_bits_kvm_lock);
> +       if (arm64_ftr_bits_kvm) {
> +               /* Already initialized */
> +               ret = 0;
> +               goto unlock_exit;
> +       }
> +
> +       nent = ARRAY_SIZE(arm64_ftr_regs);
> +       reg_bits_array = kcalloc(nent, sizeof(struct __ftr_reg_bits_entry),
> +                                GFP_KERNEL);
> +       if (!reg_bits_array) {
> +               ret = ENOMEM;
> +               goto unlock_exit;
> +       }
> +
> +       /* Copy entries from arm64_ftr_regs to reg_bits_array */
> +       for (i = 0; i < nent; i++) {
> +               bits = &reg_bits_array[i];
> +               bits->sys_id = arm64_ftr_regs[i].sys_id;
> +               bits->ftr_bits = (struct arm64_ftr_bits *)arm64_ftr_regs[i].reg->ftr_bits;
> +       };
> +
> +       /*
> +        * Override the entries in reg_bits_array with the ones in
> +        * arm64_ftr_bits_kvm_override.
> +        */
> +       for (i = 0; i < ARRAY_SIZE(arm64_ftr_bits_kvm_override); i++) {
> +               o_bits = &arm64_ftr_bits_kvm_override[i];
> +               for (j = 0; j < nent; j++) {
> +                       bits = &reg_bits_array[j];
> +                       if (bits->sys_id != o_bits->sys_id)
> +                               continue;
> +
> +                       memset(ftr_temp, 0, sizeof(ftr_temp));
> +
> +                       /*
> +                        * Temporary save all entries in o_bits->ftr_bits
> +                        * to ftr_temp.
> +                        */
> +                       copy_arm64_ftr_bits(ftr_temp, o_bits->ftr_bits);
> +
> +                       /*
> +                        * Copy entries from bits->ftr_bits to o_bits->ftr_bits.
> +                        */
> +                       copy_arm64_ftr_bits(o_bits->ftr_bits, bits->ftr_bits);
> +
> +                       /*
> +                        * Override entries in o_bits->ftr_bits with the
> +                        * saved ones, and update bits->ftr_bits with
> +                        * o_bits->ftr_bits.
> +                        */
> +                       arm64_ftr_reg_bits_overrite(o_bits->ftr_bits, ftr_temp);
> +                       bits->ftr_bits = o_bits->ftr_bits;
> +                       break;
> +               }
> +       }
> +
> +       arm64_ftr_bits_kvm_nentries = nent;
> +       arm64_ftr_bits_kvm = reg_bits_array;

I've just noticed that the patch has a problem in terms of memory ordering.
I'm thinking of fixing the code above as follows in the v5 patch.
---
        <...>
        arm64_ftr_bits_kvm_nentries = nent;

        /*
         * Make sure any data written earlier in this function are visible
         * from other CPUs before setting arm64_ftr_bits_kvm.
         */
        smp_wmb();

        WRITE_ONCE(arm64_ftr_bits_kvm, reg_bits_array);
        <...>
---

Also, I will fix the reader side code of those data in
get_arm64_ftr_bits_kvm().

Thanks,
Reiji


> +       ret = 0;
> +
> +unlock_exit:
> +       mutex_unlock(&arm64_ftr_bits_kvm_lock);
> +       return ret;
> +}
> +
> +static int search_cmp_ftr_reg_bits(const void *id, const void *regp)
> +{
> +       return ((int)(unsigned long)id -
> +               (int)((const struct __ftr_reg_bits_entry *)regp)->sys_id);
> +}
> +
> +static const struct arm64_ftr_bits *get_arm64_ftr_bits_kvm(u32 sys_id)
> +{
> +       const struct __ftr_reg_bits_entry *ret;
> +       int err;
> +
> +       if (!arm64_ftr_bits_kvm) {
> +               /* arm64_ftr_bits_kvm is not initialized yet. */
> +               err = init_arm64_ftr_bits_kvm();
> +               if (err)
> +                       return NULL;
> +       }
> +
> +       ret = bsearch((const void *)(unsigned long)sys_id,
> +                     arm64_ftr_bits_kvm,
> +                     arm64_ftr_bits_kvm_nentries,
> +                     sizeof(arm64_ftr_bits_kvm[0]),
> +                     search_cmp_ftr_reg_bits);
> +       if (ret)
> +               return ret->ftr_bits;
> +
> +       return NULL;
> +}
> +
> +/*
> + * Check if features (or levels of features) that are indicated in the ID
> + * register value @val are also indicated in @limit.
> + * This function is for KVM to check if features that are indicated in @val,
> + * which will be used as the ID register value for its guest, are supported
> + * on the host.
> + * For AA64MMFR0_EL1.TGranX_2 fields, which don't follow the standard ID
> + * scheme, the function checks if values of the fields in @val are the same
> + * as the ones in @limit.
> + */
> +int arm64_check_features(u32 sys_reg, u64 val, u64 limit)
> +{
> +       const struct arm64_ftr_bits *ftrp = get_arm64_ftr_bits_kvm(sys_reg);
> +       u64 exposed_mask = 0;
> +
> +       if (!ftrp)
> +               return -ENOENT;
> +
> +       for (; ftrp->width; ftrp++) {
> +               s64 ftr_val = arm64_ftr_value(ftrp, val);
> +               s64 ftr_lim = arm64_ftr_value(ftrp, limit);
> +
> +               exposed_mask |= arm64_ftr_mask(ftrp);
> +
> +               if (ftr_val == ftr_lim)
> +                       continue;
> +
> +               if (ftr_val != arm64_ftr_safe_value(ftrp, ftr_val, ftr_lim))
> +                       return -E2BIG;
> +       }
> +
> +       /* Make sure that no unrecognized fields are set in @val. */
> +       if (val & ~exposed_mask)
> +               return -E2BIG;
> +
> +       return 0;
> +}
> +#endif /* CONFIG_KVM */
> --
> 2.34.1.448.ga2b2bfdf31-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
