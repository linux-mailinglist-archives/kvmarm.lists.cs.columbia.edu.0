Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9345DD81
	for <lists+kvmarm@lfdr.de>; Thu, 25 Nov 2021 16:32:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C8F344B1A4;
	Thu, 25 Nov 2021 10:32:03 -0500 (EST)
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
	with ESMTP id zkMWvIY6zqNI; Thu, 25 Nov 2021 10:32:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05E6F4B186;
	Thu, 25 Nov 2021 10:32:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB3B04B0F5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Nov 2021 10:32:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6tloVnJVfuE for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Nov 2021 10:31:59 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 959F24B0EC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Nov 2021 10:31:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637854319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnVCzP5Ph3HfcaXljAj+4m7ThxDrMRTU+FYGU/FtLpo=;
 b=HaMh7jlF89n98oof/uxkf0o1w1YjjwM6Mz19GCIO9uHNa33ggaeb5qDihkpE4SzlaZguUB
 c3jfVSGfv+nD9WRxEs/VCKx8OYzQHiz5S/wldcVY62XPhcTw4z8HFiQitI7xxbgtOtjwnk
 fVNK9BCK8rPnnyCcjrpRQ+bwiOa8VuA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49--NFMc5dvOXeFkKGLI2h8YQ-1; Thu, 25 Nov 2021 10:31:58 -0500
X-MC-Unique: -NFMc5dvOXeFkKGLI2h8YQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 138-20020a1c0090000000b00338bb803204so3418410wma.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Nov 2021 07:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cnVCzP5Ph3HfcaXljAj+4m7ThxDrMRTU+FYGU/FtLpo=;
 b=49/yHsDA0V54MINJ1MKSIX6ORnfchvYoHfq2k5am9ZM+CgEwK8jLUw86uvxe8I30+l
 QCTE5pQNv8HOm0hqfnwvPzO/arNE4crhqNOmAGj6+LPjSK814n+ghL5kKE/EYAraWg5M
 VEGUvnZlpi19wh9YaB7ZFQTsTI4g8Ap3FZybQW7axIdKkHwBFshOrW1UJ0G7zypvi2XT
 EwBWqPsIXx6f2pYTDITQXG3ODL2g3NFYshlpXsFBXBJMCZq+qo32P8n06DZeggOdI6Sl
 Np72qCNzLqpPg3OwJ3CkoIbYQ3GwwlHhJLLelxVkWBDBDWF0SBYNQWuL4QNERcfC+cPI
 QNSQ==
X-Gm-Message-State: AOAM530VnBcm3iNJ5YazArmQhWtejJWs87wPU1YWYymK8m6Zq+mbXXny
 +KHgyC7s97jCR+S0qCIkIYoG8ao5HZKsFyPdM8N6OFuA2FDtBLGpfwPPEQKw0cMbKBRt2IHl3sD
 iwl2hN0H66bn2zwnCawqjObBe
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr8153043wmb.174.1637854316719; 
 Thu, 25 Nov 2021 07:31:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwemXoFmNVjJcaWjKBX8bFRZCHriCtd5cmiBgm8uZbMA6g/Y4cpCrDzQpBcKt3wIs6WdTxneQ==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr8153007wmb.174.1637854316436; 
 Thu, 25 Nov 2021 07:31:56 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id j17sm4677748wmq.41.2021.11.25.07.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Nov 2021 07:31:55 -0800 (PST)
Subject: Re: [RFC PATCH v3 08/29] KVM: arm64: Make ID_AA64MMFR0_EL1 writable
To: Reiji Watanabe <reijiw@google.com>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu
References: <20211117064359.2362060-1-reijiw@google.com>
 <20211117064359.2362060-9-reijiw@google.com>
From: Eric Auger <eauger@redhat.com>
Message-ID: <cef4fecc-b2c0-6f1b-b61d-68b830ae0bcd@redhat.com>
Date: Thu, 25 Nov 2021 16:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211117064359.2362060-9-reijiw@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eauger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Peter Shier <pshier@google.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
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



On 11/17/21 7:43 AM, Reiji Watanabe wrote:
> This patch adds id_reg_info for ID_AA64MMFR0_EL1 to make it
> writable by userspace.
> 
> Since ID_AA64MMFR0_EL1 stage 2 granule size fields don't follow the
> standard ID scheme, we need a special handling to validate those fields.
> 
> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 118 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5812e39602fe..772e3d3067b2 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -519,6 +519,113 @@ static int validate_id_aa64isar1_el1(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
>  
> +/*
> + * Check if the requested stage2 translation granule size indicated in
> + * @mmfr0 is also indicated in @mmfr0_lim.  This function assumes that
> + * the stage1 granule size indicated in @mmfr0 has been validated already.
I would suggest: relies on the fact TGranX fields are validated before
through the arm64_check_features lookup
> + */
> +static int aa64mmfr0_tgran2_check(int field, u64 mmfr0, u64 mmfr0_lim)
> +{
> +	s64 tgran2, lim_tgran2, rtgran1;
> +	int f1;
> +	bool is_signed = true;
> +
> +	tgran2 = cpuid_feature_extract_unsigned_field(mmfr0, field);
> +	lim_tgran2 = cpuid_feature_extract_unsigned_field(mmfr0_lim, field);
> +	if (tgran2 == lim_tgran2)
> +		return 0;
> +
> +	if (tgran2 && lim_tgran2)
> +		return (tgran2 > lim_tgran2) ? -E2BIG : 0;
> +
> +	/*
> +	 * Either tgran2 or lim_tgran2 is zero.
> +	 * Need stage1 granule size to validate tgran2.
> +	 */
> +	switch (field) {
> +	case ID_AA64MMFR0_TGRAN4_2_SHIFT:
> +		f1 = ID_AA64MMFR0_TGRAN4_SHIFT;
> +		break;
> +	case ID_AA64MMFR0_TGRAN64_2_SHIFT:
> +		f1 = ID_AA64MMFR0_TGRAN64_SHIFT;
> +		break;
> +	case ID_AA64MMFR0_TGRAN16_2_SHIFT:
> +		f1 = ID_AA64MMFR0_TGRAN16_SHIFT;
> +		is_signed = false;
I don't get the is_signed setting. Don't the TGRAN_x have the same
format? Beside you can get the shift by substracting 12 to @field.

can't you directly compute if the granule is supported

> +		break;
> +	default:
> +		/* Should never happen */
> +		WARN_ONCE(1, "Unexpected stage2 granule field (%d)\n", field);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If tgran2 == 0 (&& lim_tgran2 != 0), the requested stage2 granule
> +	 * size is indicated in the stage1 granule size field of @mmfr0.
> +	 * So, validate the stage1 granule size against the stage2 limit
> +	 * granule size.
> +	 * If lim_tgran2 == 0 (&& tgran2 != 0), the stage2 limit granule size
> +	 * is indicated in the stage1 granule size field of @mmfr0_lim.
> +	 * So, validate the requested stage2 granule size against the stage1
> +	 * limit granule size.
> +	 */
> +
> +	 /* Get the relevant stage1 granule size to validate tgran2 */
> +	if (tgran2 == 0)
> +		/* The requested stage1 granule size */
> +		rtgran1 = cpuid_feature_extract_field(mmfr0, f1, is_signed);
> +	else /* lim_tgran2 == 0 */
> +		/* The stage1 limit granule size */
> +		rtgran1 = cpuid_feature_extract_field(mmfr0_lim, f1, is_signed);
> +
> +	/*
> +	 * Adjust the value of rtgran1 to compare with stage2 granule size,
> +	 * which indicates: 1: Not supported, 2: Supported, etc.
> +	 */
> +	if (is_signed)
> +		/* For signed, -1: Not supported, 0: Supported, etc. */
> +		rtgran1 += 0x2;
> +	else
> +		/* For unsigned, 0: Not supported, 1: Supported, etc. */
> +		rtgran1 += 0x1;
> +
> +	if ((tgran2 == 0) && (rtgran1 > lim_tgran2))
> +		/*
> +		 * The requested stage1 granule size (== the requested stage2
> +		 * granule size) is larger than the stage2 limit granule size.
> +		 */
> +		return -E2BIG;
> +	else if ((lim_tgran2 == 0) && (tgran2 > rtgran1))
> +		/*
> +		 * The requested stage2 granule size is larger than the stage1
> +		 * limit granulze size (== the stage2 limit granule size).
> +		 */
> +		return -E2BIG;
> +
> +	return 0;
> +}
> +
> +static int validate_id_aa64mmfr0_el1(struct kvm_vcpu *vcpu,
> +				     const struct id_reg_info *id_reg, u64 val)
> +{
> +	u64 limit = id_reg->vcpu_limit_val;
> +	int ret;

shouldn't you forbid reserved values for TGran4, 64?
> +
> +	ret = aa64mmfr0_tgran2_check(ID_AA64MMFR0_TGRAN4_2_SHIFT, val, limit);
> +	if (ret)
> +		return ret;
> +
> +	ret = aa64mmfr0_tgran2_check(ID_AA64MMFR0_TGRAN64_2_SHIFT, val, limit);
> +	if (ret)
> +		return ret;
> +
> +	ret = aa64mmfr0_tgran2_check(ID_AA64MMFR0_TGRAN16_2_SHIFT, val, limit);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static void init_id_aa64pfr0_el1_info(struct id_reg_info *id_reg)
>  {
>  	u64 limit = id_reg->vcpu_limit_val;
> @@ -625,6 +732,16 @@ static struct id_reg_info id_aa64isar1_el1_info = {
>  	.get_reset_val = get_reset_id_aa64isar1_el1,
>  };
>  
> +static struct id_reg_info id_aa64mmfr0_el1_info = {
> +	.sys_reg = SYS_ID_AA64MMFR0_EL1,
> +	.ftr_check_types = S_FCT(ID_AA64MMFR0_TGRAN4_SHIFT, FCT_LOWER_SAFE) |
> +			   S_FCT(ID_AA64MMFR0_TGRAN64_SHIFT, FCT_LOWER_SAFE) |
the default?
> +			   U_FCT(ID_AA64MMFR0_TGRAN4_2_SHIFT, FCT_IGNORE) |
> +			   U_FCT(ID_AA64MMFR0_TGRAN64_2_SHIFT, FCT_IGNORE) |
> +			   U_FCT(ID_AA64MMFR0_TGRAN16_2_SHIFT, FCT_IGNORE),
maybe add comment telling the actual check is handled in the validate cb
> +	.validate = validate_id_aa64mmfr0_el1,
> +};
> +
>  /*
>   * An ID register that needs special handling to control the value for the
>   * guest must have its own id_reg_info in id_reg_info_table.
> @@ -638,6 +755,7 @@ static struct id_reg_info *id_reg_info_table[KVM_ARM_ID_REG_MAX_NUM] = {
>  	[IDREG_IDX(SYS_ID_AA64PFR1_EL1)] = &id_aa64pfr1_el1_info,
>  	[IDREG_IDX(SYS_ID_AA64ISAR0_EL1)] = &id_aa64isar0_el1_info,
>  	[IDREG_IDX(SYS_ID_AA64ISAR1_EL1)] = &id_aa64isar1_el1_info,
> +	[IDREG_IDX(SYS_ID_AA64MMFR0_EL1)] = &id_aa64mmfr0_el1_info,
>  };
>  
>  static int validate_id_reg(struct kvm_vcpu *vcpu,
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
