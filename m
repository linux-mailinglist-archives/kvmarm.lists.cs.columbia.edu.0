Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB224663FD
	for <lists+kvmarm@lfdr.de>; Thu,  2 Dec 2021 13:51:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 48A294B1A3;
	Thu,  2 Dec 2021 07:51:39 -0500 (EST)
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
	with ESMTP id GJi4FnVhtF-3; Thu,  2 Dec 2021 07:51:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFD594B19D;
	Thu,  2 Dec 2021 07:51:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EBD84B187
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Dec 2021 07:51:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VNyw7nrieWKL for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Dec 2021 07:51:31 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FE8B4B174
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Dec 2021 07:51:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638449491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deqfuKvFlU9prDfs0QlbobyXt/WvDKmo8HiTDuibat4=;
 b=DJEmwYz9ler18y/dlZdtthqBqZqmKfIXU7e71kG+DyL3ycxtsklMZG0Pz5F4M8PIlAjRWr
 uloThU6GbV791Nj3c/iyLzgKE1w1R37Y7t9zr1KY/RbhUghm3ogco/3QMfeilwLjp1uDep
 l+nmSZ4dR1KhfKJr/+kMVbDjiRUDR9w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43--HRo2SX9NhuSdavmscL8dQ-1; Thu, 02 Dec 2021 07:51:28 -0500
X-MC-Unique: -HRo2SX9NhuSdavmscL8dQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 201-20020a1c04d2000000b003335bf8075fso13974481wme.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 02 Dec 2021 04:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=deqfuKvFlU9prDfs0QlbobyXt/WvDKmo8HiTDuibat4=;
 b=O0qNgJKXmJnoMRlMJJnfV/5+6vc6U3pjKJRK9Gx0pK+iHSPbOXpiJlSOUByeT5aCfc
 h5KOVnOOPURO1Inf75N6haHhOeikqxIAVCL65q9/mJD+/NJMo1DD2T1aMpMiZtvQtfLk
 9VOwTD8kh82i4wi+cE3dlgp1jhvjVCsWSbJoVIUbeMWhdMd/SV5FwGYaazl61zl7qeNe
 3N+AHnHa2xjB6P6Oq2Uanip8YGRk448ddR9oALivaE1s8G2xcer+KcgdWD/t33ZHC4gD
 Cdm7Qa3EuqXoQsnIs3RWSyn9n0qQNBR8WpWb0aO46juo+bxQpmOXm2e3xke+sqvGXmhk
 x4wA==
X-Gm-Message-State: AOAM5303jvBxluAkpicBnR8pZu1Q4sZv28KZvKWd5A2lV1fhRhohbv1X
 jLT8/VKyOXJAGrP/E0q7Zr0rEoXjiBVielWV4YiW0CWBY1/TkKRskngq77MBOJ2YeMi9XV+fD4l
 kdENk182IigAaI0BCejF7uMg6
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr14240051wrw.57.1638449486995; 
 Thu, 02 Dec 2021 04:51:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQ4L4RACt5bxDAh35D/Rf+GaYVbUyzp4mc9eCtgosGSFiC+k8s5hy2mnjiEMXjE86duU5msA==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr14240024wrw.57.1638449486677; 
 Thu, 02 Dec 2021 04:51:26 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id g18sm2622717wmq.4.2021.12.02.04.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Dec 2021 04:51:26 -0800 (PST)
Subject: Re: [RFC PATCH v3 03/29] KVM: arm64: Introduce struct id_reg_info
To: Reiji Watanabe <reijiw@google.com>
References: <20211117064359.2362060-1-reijiw@google.com>
 <20211117064359.2362060-4-reijiw@google.com>
 <57519386-0a30-40a6-b46f-d20595df0b86@redhat.com>
 <CAAeT=Fx8Z_W0ePxb+5O4OO4myJOr5SRLAFY38FrJJVtXXTxJQw@mail.gmail.com>
From: Eric Auger <eauger@redhat.com>
Message-ID: <7bfd6fb8-40af-1da0-6336-8289c417d175@redhat.com>
Date: Thu, 2 Dec 2021 13:51:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAAeT=Fx8Z_W0ePxb+5O4OO4myJOr5SRLAFY38FrJJVtXXTxJQw@mail.gmail.com>
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



On 11/25/21 7:40 AM, Reiji Watanabe wrote:
> Hi Eric,
> 
> On Wed, Nov 24, 2021 at 1:07 PM Eric Auger <eauger@redhat.com> wrote:
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
>> nit: -EINVAL may be better because depending on the check type this may
>> not mean too big.
> 
> Yes, that is correct.
> 
> This error case means that userspace tried to configure features
> or a higher level of features that were not supported on the host.
> In that sense, I chose -E2BIG.
> 
> I wanted to use an error code specific to this particular case, which
> I think makes debugging userspace issue easier when KVM_SET_ONE_REG
> fails, and I couldn't find other error codes that fit this case better.
> So, I'm trying to avoid using -EINVAL, which is used for other failure
> cases.
> 
> If you have any other suggested error code for this,
> that would be very helpful:)

OK faire enought, that's a nit anyway

Eric
> 
> Thanks,
> Reiji
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
