Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 542B94FEFF6
	for <lists+kvmarm@lfdr.de>; Wed, 13 Apr 2022 08:40:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C6B04B24F;
	Wed, 13 Apr 2022 02:40:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GozO+g9GFfPM; Wed, 13 Apr 2022 02:40:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D54134B24A;
	Wed, 13 Apr 2022 02:40:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D6DB4B1C9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Apr 2022 02:40:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id taPgJTOPxMU4 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Apr 2022 02:40:16 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B263A4B19F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Apr 2022 02:40:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649832011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEMyYjdcwVmmyA6t+BqKkr9mQk3hMo2tvFbKJLhnUkE=;
 b=E2j8e9nCnMC4NteH3HyJ1O73NDzCbK45uB3xDLgekNmRcs2KFm2ps1Nw0Hbud7GIRcBc+Q
 1w7l3n3Ih+pGC3DQR4Xf02nMBpnic0SgFv4hR5I3EdG6VNVhmYs7cyD1NVdlr+tdn++mKO
 bGOwgb4ffeBLYuYBZ8sZiCfC98sIYN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-zuFx4MQUODylLbJ8ooxiiQ-1; Wed, 13 Apr 2022 02:40:04 -0400
X-MC-Unique: zuFx4MQUODylLbJ8ooxiiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E68B185A79C;
 Wed, 13 Apr 2022 06:40:04 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE89C9D4C;
 Wed, 13 Apr 2022 06:39:55 +0000 (UTC)
Subject: Re: [PATCH v5 06/10] Docs: KVM: Add doc for the bitmap firmware
 registers
To: Raghavendra Rao Ananta <rananta@google.com>, Marc Zyngier
 <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220407011605.1966778-1-rananta@google.com>
 <20220407011605.1966778-7-rananta@google.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <5dac0a4e-735f-40e3-5073-b548a2ba9855@redhat.com>
Date: Wed, 13 Apr 2022 14:39:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220407011605.1966778-7-rananta@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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

Hi Raghavendra,

On 4/7/22 9:16 AM, Raghavendra Rao Ananta wrote:
> Add the documentation for the bitmap firmware registers in
> hypercalls.rst and api.rst. This includes the details for
> KVM_REG_ARM_STD_BMAP, KVM_REG_ARM_STD_HYP_BMAP, and
> KVM_REG_ARM_VENDOR_HYP_BMAP registers.
> 
> Since the document is growing to carry other hypercall related
> information, make necessary adjustments to present the document
> in a generic sense, rather than being PSCI focused.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   Documentation/virt/kvm/api.rst            | 17 ++++
>   Documentation/virt/kvm/arm/hypercalls.rst | 95 ++++++++++++++++++-----
>   2 files changed, 94 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index d13fa6600467..e0107b157965 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -2542,6 +2542,23 @@ arm64 firmware pseudo-registers have the following bit pattern::
>   
>     0x6030 0000 0014 <regno:16>
>   
> +arm64 bitmap feature firmware pseudo-registers have the following bit pattern::
> +
> +  0x6030 0000 0016 <regno:16>
> +
> +The bitmap feature firmware registers exposes the hypercall services that are
> +available for userspace to configure. The set bits corresponds to the services
> +that are available for the guests to access. By default, KVM sets all the
> +supported bits during VM initialization. The userspace can discover the
> +available services via KVM_GET_ONE_REG, and write-back the bitmap corresponding
> +to the features that it wishes guests to see via KVM_SET_ONE_REG.
> +
> +Note: These registers are immutable once any of the vCPUs of the VM has run at
> +least once. A KVM_SET_ONE_REG in such a scenario will return a -EBUSY to userspace.
> +If there's no change in the value that's being written, 0 (success) is returned.
> +
> +(See Documentation/virt/kvm/arm/hypercalls.rst for more details.)
> +
>   arm64 SVE registers have the following bit patterns::
>   
>     0x6080 0000 0015 00 <n:5> <slice:5>   Zn bits[2048*slice + 2047 : 2048*slice]
> diff --git a/Documentation/virt/kvm/arm/hypercalls.rst b/Documentation/virt/kvm/arm/hypercalls.rst
> index d52c2e83b5b8..ccda9fc2d253 100644
> --- a/Documentation/virt/kvm/arm/hypercalls.rst
> +++ b/Documentation/virt/kvm/arm/hypercalls.rst
> @@ -1,32 +1,32 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -=========================================
> -Power State Coordination Interface (PSCI)
> -=========================================
> +=======================
> +ARM Hypercall Interface
> +=======================
>   
> -KVM implements the PSCI (Power State Coordination Interface)
> -specification in order to provide services such as CPU on/off, reset
> -and power-off to the guest.
> +KVM handles the hypercall services as requested by the guests. New hypercall
> +services are regularly made available by the ARM specification or by KVM (as
> +vendor services) if they make sense from a virtualization point of view.
>   
> -The PSCI specification is regularly updated to provide new features,
> -and KVM implements these updates if they make sense from a virtualization
> -point of view.
> -
> -This means that a guest booted on two different versions of KVM can
> -observe two different "firmware" revisions. This could cause issues if
> -a given guest is tied to a particular PSCI revision (unlikely), or if
> -a migration causes a different PSCI version to be exposed out of the
> -blue to an unsuspecting guest.
> +This means that a guest booted on two different versions of KVM can observe
> +two different "firmware" revisions. This could cause issues if a given guest
> +is tied to a particular version of a hypercall service, or if a migration
> +causes a different version to be exposed out of the blue to an unsuspecting
> +guest.
>   
>   In order to remedy this situation, KVM exposes a set of "firmware
>   pseudo-registers" that can be manipulated using the GET/SET_ONE_REG
>   interface. These registers can be saved/restored by userspace, and set
> -to a convenient value if required.
> +to a convenient value as required.
>   
> -The following register is defined:
> +The following registers are defined:
>   
>   * KVM_REG_ARM_PSCI_VERSION:
>   
> +  KVM implements the PSCI (Power State Coordination Interface)
> +  specification in order to provide services such as CPU on/off, reset
> +  and power-off to the guest.
> +
>     - Only valid if the vcpu has the KVM_ARM_VCPU_PSCI_0_2 feature set
>       (and thus has already been initialized)
>     - Returns the current PSCI version on GET_ONE_REG (defaulting to the
> @@ -74,4 +74,63 @@ The following register is defined:
>       KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
>         The workaround is always active on this vCPU or it is not needed.
>   
> -.. [1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
> +
> +Bitmap Feature Firmware Registers
> +---------------------------------
> +
> +Contrary to the above registers, the following registers exposes the hypercall
> +services in the form of a feature-bitmap to the userspace. This bitmap is
> +translated to the services that are available to the guest. There is a register
> +defined per service call owner and can be accessed via GET/SET_ONE_REG interface.
> +
> +By default, these registers are set with the upper limit of the features that
> +are supported. This way userspace can discover all the electable hypercall services
> +via GET_ONE_REG. The user-space can write-back the desired bitmap back via
> +SET_ONE_REG. The features for the registers that are untouched, probably because
> +userspace isn't aware of them, will be exposed as is to the guest.
> +
> +Note that KVM would't allow the userspace to configure the registers anymore once
> +any of the vCPUs has run at least once. Instead, it will return a -EBUSY. However,
> +if there's no change in the incoming value, it simply returns a success.
> +

It would be better to replace "a success" with "zero", to be consistent
with "-EBUSY". The suggestion may be invalid if the code needs changes
based on Marc's suggestions.

> +The psuedo-firmware bitmap register are as follows:
> +
> +* KVM_REG_ARM_STD_BMAP:
> +    Controls the bitmap of the ARM Standard Secure Service Calls.
> +
> +  The following bits are accepted:
> +
> +    Bit-0: KVM_REG_ARM_STD_BIT_TRNG_V1_0:
> +      The bit represents the services offered under v1.0 of ARM True Random
> +      Number Generator (TRNG) specification, ARM DEN0098.
> +
> +* KVM_REG_ARM_STD_HYP_BMAP:
> +    Controls the bitmap of the ARM Standard Hypervisor Service Calls.
> +
> +  The following bits are accepted:
> +
> +    Bit-0: KVM_REG_ARM_STD_HYP_BIT_PV_TIME:
> +      The bit represents the Paravirtualized Time service as represented by
> +      ARM DEN0057A.
> +
> +* KVM_REG_ARM_VENDOR_HYP_BMAP:
> +    Controls the bitmap of the Vendor specific Hypervisor Service Calls.
> +
> +  The following bits are accepted:
> +
> +    Bit-0: KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT
> +      The bit represents the ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID
> +      function-id
> +
> +    Bit-1: KVM_REG_ARM_VENDOR_HYP_BIT_PTP:
> +      The bit represents the Precision Time Protocol KVM service.
> +
> +Errors:
> +
> +    =======  =============================================================
> +    -ENOENT   Unknown register accessed.
> +    -EBUSY    Attempt a 'write' to the register after the VM has started.
> +    -EINVAL   Invalid bitmap written to the register.
> +    =======  =============================================================
> +
> +.. [1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
> \ No newline at end of file
> 

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
