Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F450F246
	for <lists+kvmarm@lfdr.de>; Tue, 26 Apr 2022 09:24:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EDF54B1D2;
	Tue, 26 Apr 2022 03:24:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.781
X-Spam-Level: 
X-Spam-Status: No, score=-1.781 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, UPPERCASE_50_75=0.008,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZFmEKMfPOD9; Tue, 26 Apr 2022 03:24:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89EB149E43;
	Tue, 26 Apr 2022 03:24:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0DDC41174
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 03:24:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9pzNR0rqhRC for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Apr 2022 03:24:38 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7384D410F3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 03:24:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650957878;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wq0cX5f/tSHQNq0CGIDaJqE3zMD36/mEnx1ziP9dP9M=;
 b=MoFjMM5TNxN2DPSNlbh1q84IaIcn5INctVtvOZKxunG3Jod1V2dFZp22d2xBDMUczIQPPM
 P9n0mR0xtE/3hFcsETL/D6hqKN1r8JSRMp6Geukd9oOb0ZeKknXUmyIyRrGnCQmBaqU3xB
 t/fQzMMuVwuaBmEMcH1Oyi/2QUT53Oc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-u9WXaItiN1Ctt2Q916m_Gw-1; Tue, 26 Apr 2022 03:24:32 -0400
X-MC-Unique: u9WXaItiN1Ctt2Q916m_Gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9A7B811E76;
 Tue, 26 Apr 2022 07:24:31 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDE42145BA44;
 Tue, 26 Apr 2022 07:24:24 +0000 (UTC)
Subject: Re: [PATCH v6 7/9] tools: Import ARM SMCCC definitions
To: Raghavendra Rao Ananta <rananta@google.com>, Marc Zyngier
 <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220423000328.2103733-1-rananta@google.com>
 <20220423000328.2103733-8-rananta@google.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <867b0aeb-97f4-8fc0-b37a-42946a1e65ad@redhat.com>
Date: Tue, 26 Apr 2022 15:24:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220423000328.2103733-8-rananta@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 4/23/22 8:03 AM, Raghavendra Rao Ananta wrote:
> Import the standard SMCCC definitions from include/linux/arm-smccc.h.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   tools/include/linux/arm-smccc.h | 193 ++++++++++++++++++++++++++++++++
>   1 file changed, 193 insertions(+)
>   create mode 100644 tools/include/linux/arm-smccc.h
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/tools/include/linux/arm-smccc.h b/tools/include/linux/arm-smccc.h
> new file mode 100644
> index 000000000000..63ce9bebccd3
> --- /dev/null
> +++ b/tools/include/linux/arm-smccc.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2015, Linaro Limited
> + */
> +#ifndef __LINUX_ARM_SMCCC_H
> +#define __LINUX_ARM_SMCCC_H
> +
> +#include <linux/const.h>
> +
> +/*
> + * This file provides common defines for ARM SMC Calling Convention as
> + * specified in
> + * https://developer.arm.com/docs/den0028/latest
> + *
> + * This code is up-to-date with version DEN 0028 C
> + */
> +
> +#define ARM_SMCCC_STD_CALL	        _AC(0,U)
> +#define ARM_SMCCC_FAST_CALL	        _AC(1,U)
> +#define ARM_SMCCC_TYPE_SHIFT		31
> +
> +#define ARM_SMCCC_SMC_32		0
> +#define ARM_SMCCC_SMC_64		1
> +#define ARM_SMCCC_CALL_CONV_SHIFT	30
> +
> +#define ARM_SMCCC_OWNER_MASK		0x3F
> +#define ARM_SMCCC_OWNER_SHIFT		24
> +
> +#define ARM_SMCCC_FUNC_MASK		0xFFFF
> +
> +#define ARM_SMCCC_IS_FAST_CALL(smc_val)	\
> +	((smc_val) & (ARM_SMCCC_FAST_CALL << ARM_SMCCC_TYPE_SHIFT))
> +#define ARM_SMCCC_IS_64(smc_val) \
> +	((smc_val) & (ARM_SMCCC_SMC_64 << ARM_SMCCC_CALL_CONV_SHIFT))
> +#define ARM_SMCCC_FUNC_NUM(smc_val)	((smc_val) & ARM_SMCCC_FUNC_MASK)
> +#define ARM_SMCCC_OWNER_NUM(smc_val) \
> +	(((smc_val) >> ARM_SMCCC_OWNER_SHIFT) & ARM_SMCCC_OWNER_MASK)
> +
> +#define ARM_SMCCC_CALL_VAL(type, calling_convention, owner, func_num) \
> +	(((type) << ARM_SMCCC_TYPE_SHIFT) | \
> +	((calling_convention) << ARM_SMCCC_CALL_CONV_SHIFT) | \
> +	(((owner) & ARM_SMCCC_OWNER_MASK) << ARM_SMCCC_OWNER_SHIFT) | \
> +	((func_num) & ARM_SMCCC_FUNC_MASK))
> +
> +#define ARM_SMCCC_OWNER_ARCH		0
> +#define ARM_SMCCC_OWNER_CPU		1
> +#define ARM_SMCCC_OWNER_SIP		2
> +#define ARM_SMCCC_OWNER_OEM		3
> +#define ARM_SMCCC_OWNER_STANDARD	4
> +#define ARM_SMCCC_OWNER_STANDARD_HYP	5
> +#define ARM_SMCCC_OWNER_VENDOR_HYP	6
> +#define ARM_SMCCC_OWNER_TRUSTED_APP	48
> +#define ARM_SMCCC_OWNER_TRUSTED_APP_END	49
> +#define ARM_SMCCC_OWNER_TRUSTED_OS	50
> +#define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
> +
> +#define ARM_SMCCC_FUNC_QUERY_CALL_UID  0xff01
> +
> +#define ARM_SMCCC_QUIRK_NONE		0
> +#define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
> +
> +#define ARM_SMCCC_VERSION_1_0		0x10000
> +#define ARM_SMCCC_VERSION_1_1		0x10001
> +#define ARM_SMCCC_VERSION_1_2		0x10002
> +#define ARM_SMCCC_VERSION_1_3		0x10003
> +
> +#define ARM_SMCCC_1_3_SVE_HINT		0x10000
> +
> +#define ARM_SMCCC_VERSION_FUNC_ID					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   0, 0)
> +
> +#define ARM_SMCCC_ARCH_FEATURES_FUNC_ID					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   0, 1)
> +
> +#define ARM_SMCCC_ARCH_SOC_ID						\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   0, 2)
> +
> +#define ARM_SMCCC_ARCH_WORKAROUND_1					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   0, 0x8000)
> +
> +#define ARM_SMCCC_ARCH_WORKAROUND_2					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   0, 0x7fff)
> +
> +#define ARM_SMCCC_ARCH_WORKAROUND_3					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   0, 0x3fff)
> +
> +#define ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID				\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
> +			   ARM_SMCCC_FUNC_QUERY_CALL_UID)
> +
> +/* KVM UID value: 28b46fb6-2ec5-11e9-a9ca-4b564d003a74 */
> +#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0	0xb66fb428U
> +#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1	0xe911c52eU
> +#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2	0x564bcaa9U
> +#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3	0x743a004dU
> +
> +/* KVM "vendor specific" services */
> +#define ARM_SMCCC_KVM_FUNC_FEATURES		0
> +#define ARM_SMCCC_KVM_FUNC_PTP			1
> +#define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
> +#define ARM_SMCCC_KVM_NUM_FUNCS			128
> +
> +#define ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID			\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
> +			   ARM_SMCCC_KVM_FUNC_FEATURES)
> +
> +#define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
> +
> +/*
> + * ptp_kvm is a feature used for time sync between vm and host.
> + * ptp_kvm module in guest kernel will get service from host using
> + * this hypercall ID.
> + */
> +#define ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID				\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
> +			   ARM_SMCCC_KVM_FUNC_PTP)
> +
> +/* ptp_kvm counter type ID */
> +#define KVM_PTP_VIRT_COUNTER			0
> +#define KVM_PTP_PHYS_COUNTER			1
> +
> +/* Paravirtualised time calls (defined by ARM DEN0057A) */
> +#define ARM_SMCCC_HV_PV_TIME_FEATURES				\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_64,			\
> +			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
> +			   0x20)
> +
> +#define ARM_SMCCC_HV_PV_TIME_ST					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_64,			\
> +			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
> +			   0x21)
> +
> +/* TRNG entropy source calls (defined by ARM DEN0098) */
> +#define ARM_SMCCC_TRNG_VERSION					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_32,			\
> +			   ARM_SMCCC_OWNER_STANDARD,		\
> +			   0x50)
> +
> +#define ARM_SMCCC_TRNG_FEATURES					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_32,			\
> +			   ARM_SMCCC_OWNER_STANDARD,		\
> +			   0x51)
> +
> +#define ARM_SMCCC_TRNG_GET_UUID					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_32,			\
> +			   ARM_SMCCC_OWNER_STANDARD,		\
> +			   0x52)
> +
> +#define ARM_SMCCC_TRNG_RND32					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_32,			\
> +			   ARM_SMCCC_OWNER_STANDARD,		\
> +			   0x53)
> +
> +#define ARM_SMCCC_TRNG_RND64					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_64,			\
> +			   ARM_SMCCC_OWNER_STANDARD,		\
> +			   0x53)
> +
> +/*
> + * Return codes defined in ARM DEN 0070A
> + * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028 C
> + */
> +#define SMCCC_RET_SUCCESS			0
> +#define SMCCC_RET_NOT_SUPPORTED			-1
> +#define SMCCC_RET_NOT_REQUIRED			-2
> +#define SMCCC_RET_INVALID_PARAMETER		-3
> +
> +#endif /*__LINUX_ARM_SMCCC_H*/
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
