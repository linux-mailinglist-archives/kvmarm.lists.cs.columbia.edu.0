Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3897046B78D
	for <lists+kvmarm@lfdr.de>; Tue,  7 Dec 2021 10:36:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1E0E4B093;
	Tue,  7 Dec 2021 04:36:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h-Zbs0K1mdUa; Tue,  7 Dec 2021 04:36:49 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BBBB4B0AC;
	Tue,  7 Dec 2021 04:36:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D7A44B092
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Dec 2021 04:36:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KI8CC+5Pir3R for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Dec 2021 04:36:46 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3881C49E5F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Dec 2021 04:36:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638869806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijgqpfyHt35TGYrbOtYkibhBprxiz/I8qi2c5VR34I4=;
 b=cuSL8v2Ldy9Mq8aEVgjDiEthGqHZDfJ7IteS5TiTE2ZKT+g/Tyk3SYKgGbWSqpGqg5f/pW
 rg9LxmSqdStGyygJZcQzIVzSm8XKdUJRLEDwOtBBoxmQES3bo3WOkQWpwbQlW+YR7nveR+
 xJnjEXrh9GTirJ0gZb9L1iQx0jX/PMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-gzPPIbcPNv68sixbAZNHnw-1; Tue, 07 Dec 2021 04:36:44 -0500
X-MC-Unique: gzPPIbcPNv68sixbAZNHnw-1
Received: by mail-wm1-f70.google.com with SMTP id
 n16-20020a05600c3b9000b003331973fdbbso1141389wms.0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 07 Dec 2021 01:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ijgqpfyHt35TGYrbOtYkibhBprxiz/I8qi2c5VR34I4=;
 b=veRkNMM5xXc1oU+xl+sX9HCyaAWbnVNRHpXacK/Yf8gwp0U4ioXkmlFK7Hy5QOoNBn
 xGF5lMfCeDDrH9qdG1Uv44ozbZGM89ZTzgzNKBkO9DawhUS4m40OBeNjdVjL4F8woqph
 1/loPA97Z2XjmK9Yg+uiZNVkEwYOGrmtZi/kuSIIjGlTEiSS+Nc9lfar0yZfdEEbkgG8
 inef4bNlPKPaehpeMSDp1Zyv+axkRAdnxdvTvBcAaqSlrDL7aR0AKZb2Nh9lHs2L2O1U
 b3+H2thKf4irlt67QcEx33CwwBg9A5v4ipwB3j/65m1Yp6+WXW1NkOO8FOlqdLT5L0Qa
 JhVg==
X-Gm-Message-State: AOAM531Ext08P4ARHPtuPPuj5s/O0DQO0btS1MS260I3wTLSodYl8ifQ
 1MJtAO8Uqz99KaodNgKZZ5qcXPteQQjt7+ns8UjWpxBqolsj8b28yTR5R1pqmBFVYnUNkwukIU7
 YjXNZ4PjpocJeDOaXMtbcqy+E
X-Received: by 2002:a05:6000:1a48:: with SMTP id
 t8mr49835698wry.66.1638869803593; 
 Tue, 07 Dec 2021 01:36:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzD+r+EjbrTy0aSj8ViSJ3RBTKqCJIGicEprYFeQHXXq/EL555oJ1YYHHAZUwuwck2MSmMatw==
X-Received: by 2002:a05:6000:1a48:: with SMTP id
 t8mr49835663wry.66.1638869803288; 
 Tue, 07 Dec 2021 01:36:43 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id c6sm2524509wmq.46.2021.12.07.01.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Dec 2021 01:36:42 -0800 (PST)
Subject: Re: [RFC PATCH v3 03/29] KVM: arm64: Introduce struct id_reg_info
To: Reiji Watanabe <reijiw@google.com>
References: <20211117064359.2362060-1-reijiw@google.com>
 <20211117064359.2362060-4-reijiw@google.com>
 <e480d851-2d88-6f79-daf4-22c4841f88a4@redhat.com>
 <CAAeT=FwEbJrK5afynLFfgFU199iHd093UvbkWRzxJ_j6fssB2g@mail.gmail.com>
From: Eric Auger <eauger@redhat.com>
Message-ID: <987541fb-2282-556f-bdfd-247559638280@redhat.com>
Date: Tue, 7 Dec 2021 10:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAAeT=FwEbJrK5afynLFfgFU199iHd093UvbkWRzxJ_j6fssB2g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eauger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

Hi Reiji,

On 12/4/21 5:35 AM, Reiji Watanabe wrote:
> Hi Eric,
> 
> On Thu, Dec 2, 2021 at 4:51 AM Eric Auger <eauger@redhat.com> wrote:
>>
>> Hi Reiji,
>>
>> On 11/17/21 7:43 AM, Reiji Watanabe wrote:
>>> This patch lays the groundwork to make ID registers writable.
>>>
>>> Introduce struct id_reg_info for an ID register to manage the
>>> register specific control of its value for the guest, and provide set
>>> of functions commonly used for ID registers to make them writable.
>>>
>>> The id_reg_info is used to do register specific initialization,
>>> validation of the ID register and etc.  Not all ID registers must
>>> have the id_reg_info. ID registers that don't have the id_reg_info
>>> are handled in a common way that is applied to all ID registers.
>>>
>>> At present, changing an ID register from userspace is allowed only
>>> if the ID register has the id_reg_info, but that will be changed
>>> by the following patches.
>>>
>>> No ID register has the structure yet and the following patches
>>> will add the id_reg_info for some ID registers.
>>>
>>> Signed-off-by: Reiji Watanabe <reijiw@google.com>
>>> ---
>>>  arch/arm64/include/asm/sysreg.h |   1 +
>>>  arch/arm64/kvm/sys_regs.c       | 226 ++++++++++++++++++++++++++++++--
>>>  2 files changed, 218 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>> index 16b3f1a1d468..597609f26331 100644
>>> --- a/arch/arm64/include/asm/sysreg.h
>>> +++ b/arch/arm64/include/asm/sysreg.h
>>> @@ -1197,6 +1197,7 @@
>>>  #define ICH_VTR_TDS_MASK     (1 << ICH_VTR_TDS_SHIFT)
>>>
>>>  #define ARM64_FEATURE_FIELD_BITS     4
>>> +#define ARM64_FEATURE_FIELD_MASK     ((1ull << ARM64_FEATURE_FIELD_BITS) - 1)
>>>
>>>  /* Create a mask for the feature bits of the specified feature. */
>>>  #define ARM64_FEATURE_MASK(x)        (GENMASK_ULL(x##_SHIFT + ARM64_FEATURE_FIELD_BITS - 1, x##_SHIFT))
>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> index 5608d3410660..1552cd5581b7 100644
>>> --- a/arch/arm64/kvm/sys_regs.c
>>> +++ b/arch/arm64/kvm/sys_regs.c
>>> @@ -265,6 +265,181 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
>>>               return read_zero(vcpu, p);
>>>  }
>>>
>>> +/*
>>> + * A value for FCT_LOWER_SAFE must be zero and changing that will affect
>>> + * ftr_check_types of id_reg_info.
>>> + */
>>> +enum feature_check_type {
>>> +     FCT_LOWER_SAFE = 0,
>>> +     FCT_HIGHER_SAFE,
>>> +     FCT_HIGHER_OR_ZERO_SAFE,
>>> +     FCT_EXACT,
>>> +     FCT_EXACT_OR_ZERO_SAFE,
>>> +     FCT_IGNORE,     /* Don't check (any value is fine) */
>>> +};
>>> +
>>> +static int arm64_check_feature_one(enum feature_check_type type, int val,
>>> +                                int limit)
>>> +{
>>> +     bool is_safe = false;
>>> +
>>> +     if (val == limit)
>>> +             return 0;
>>> +
>>> +     switch (type) {
>>> +     case FCT_LOWER_SAFE:
>>> +             is_safe = (val <= limit);
>>> +             break;
>>> +     case FCT_HIGHER_OR_ZERO_SAFE:
>>> +             if (val == 0) {
>>> +                     is_safe = true;
>>> +                     break;
>>> +             }
>>> +             fallthrough;
>>> +     case FCT_HIGHER_SAFE:
>>> +             is_safe = (val >= limit);
>>> +             break;
>>> +     case FCT_EXACT:
>>> +             break;
>>> +     case FCT_EXACT_OR_ZERO_SAFE:
>>> +             is_safe = (val == 0);
>>> +             break;
>>> +     case FCT_IGNORE:
>>> +             is_safe = true;
>>> +             break;
>>> +     default:
>>> +             WARN_ONCE(1, "Unexpected feature_check_type (%d)\n", type);
>>> +             break;
>>> +     }
>>> +
>>> +     return is_safe ? 0 : -1;
>>> +}
>>> +
>>> +#define      FCT_TYPE_MASK           0x7
>>> +#define      FCT_TYPE_SHIFT          1
>>> +#define      FCT_SIGN_MASK           0x1
>>> +#define      FCT_SIGN_SHIFT          0
>>> +#define      FCT_TYPE(val)   ((val >> FCT_TYPE_SHIFT) & FCT_TYPE_MASK)
>>> +#define      FCT_SIGN(val)   ((val >> FCT_SIGN_SHIFT) & FCT_SIGN_MASK)
>>> +
>>> +#define      MAKE_FCT(shift, type, sign)                             \
>>> +     ((u64)((((type) & FCT_TYPE_MASK) << FCT_TYPE_SHIFT) |   \
>>> +            (((sign) & FCT_SIGN_MASK) << FCT_SIGN_SHIFT)) << (shift))
>>> +
>>> +/* For signed field */
>>> +#define      S_FCT(shift, type)      MAKE_FCT(shift, type, 1)
>>> +/* For unigned field */
>>> +#define      U_FCT(shift, type)      MAKE_FCT(shift, type, 0)
>>> +
>>> +/*
>>> + * @val and @lim are both a value of the ID register. The function checks
>>> + * if all features indicated in @val can be supported for guests on the host,
>>> + * which supports features indicated in @lim. @check_types indicates how
>>> + * features in the ID register needs to be checked.
>>> + * See comments for id_reg_info's ftr_check_types field for more detail.
>>> + */
>>> +static int arm64_check_features(u64 check_types, u64 val, u64 lim)
>>> +{
>>> +     int i;
>>> +
>>> +     for (i = 0; i < 64; i += ARM64_FEATURE_FIELD_BITS) {
>>> +             u8 ftr_check = (check_types >> i) & ARM64_FEATURE_FIELD_MASK;
>>> +             bool is_sign = FCT_SIGN(ftr_check);
>>> +             enum feature_check_type fctype = FCT_TYPE(ftr_check);
>>> +             int fval, flim, ret;
>>> +
>>> +             fval = cpuid_feature_extract_field(val, i, is_sign);
>>> +             flim = cpuid_feature_extract_field(lim, i, is_sign);
>>> +
>>> +             ret = arm64_check_feature_one(fctype, fval, flim);
>>> +             if (ret)
>>> +                     return -E2BIG;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +struct id_reg_info {
>>> +     u32     sys_reg;        /* Register ID */
>>> +
>>> +     /*
>>> +      * Limit value of the register for a vcpu. The value is the sanitized
>>> +      * system value with bits cleared for unsupported features for the
>>> +      * guest.
>>> +      */
>>> +     u64     vcpu_limit_val;
>>> +
>>> +     /*
>>> +      * The ftr_check_types is comprised of a set of 4 bits fields.
>>> +      * Each 4 bits field is for a feature indicated by the same bits
>>> +      * field of the ID register and indicates how the feature support
>>> +      * for guests needs to be checked.
>>> +      * The bit 0 indicates that the corresponding ID register field
>>> +      * is signed(1) or unsigned(0).
>>> +      * The bits [3:1] hold feature_check_type for the field.
>>> +      * If all zero, all features in the ID register are treated as unsigned
>>> +      * fields and checked based on Principles of the ID scheme for fields
>>> +      * in ID registers (FCT_LOWER_SAFE of feature_check_type).
>>> +      */
>>> +     u64     ftr_check_types;
>>> +
>>> +     /* Initialization function of the id_reg_info */
>>> +     void (*init)(struct id_reg_info *id_reg);
>>> +
>>> +     /* Register specific validation function */
>>> +     int (*validate)(struct kvm_vcpu *vcpu, const struct id_reg_info *id_reg,
>>> +                     u64 val);
>>> +
>>> +     /* Return the reset value of the register for the vCPU */
>>> +     u64 (*get_reset_val)(struct kvm_vcpu *vcpu,
>>> +                          const struct id_reg_info *id_reg);
>> It is unclear to me why we need 2 different callbacks, ie. init and
>> get_reset_val. ID_REGS can only be accessed from user space after the
>> vcpu reset, right? So couldn't we have a single cb instead of this
>> overwrite mechanism?
> 
> Thank you for the comment.
> 
> What the init() does needs to be done just once.
> It initializes the id_reg_info itself (not for the ID register of vCPU).
> And the data initialized by the init() is used not just for the
> overwrite mechanism at the vcpu reset but for other purposes as well.
> 
> What the get_reset_val does needs to be done for every initial vCPU reset.
> It provides the initial value for the vCPU, which depends on its feature
> configuration that is configured by KVM_ARM_VCPU_INIT (or other APIs).
> 
> Of course there are other ways to achieve the same, and it's entirely
> possible to have a single function though.  I just chose to use a
> separate function for each of those two different purposes.

OK fair enough. Was thinking that maybe it would simplify the code if we
had a single 'reset" cb but up to you.

Thanks

Eric
> 
> Thanks,
> Reiji
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
