Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9426461B
	for <lists+kvmarm@lfdr.de>; Thu, 10 Sep 2020 14:35:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 186194B422;
	Thu, 10 Sep 2020 08:35:02 -0400 (EDT)
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
	with ESMTP id LAy0NUPJazBM; Thu, 10 Sep 2020 08:35:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F1C0F4B2F9;
	Thu, 10 Sep 2020 08:35:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AC144B294
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 08:34:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-9hP2LeqTop for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Sep 2020 08:34:58 -0400 (EDT)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7C9094B2F3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 08:34:58 -0400 (EDT)
Received: by mail-wr1-f65.google.com with SMTP id o5so6466099wrn.13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ou9injEFK3ynx6TLorApjrz9C+IV+NUJDgRb4FiGCd0=;
 b=JpErupGX9fulmYZvxtdV0U32w7X1pxyfApvEkhWK8zhYuxW1uI+EqU5Fjv9BaF9H/V
 YurieurqjypG7BJAUBnBCH5arbZ3tVER2qmEt+rAqI4sfn3j4bXg9iz0fRz0pKoPNL3y
 YSW2fRVwWb6wg82ODMDH5pUFWZ0GjjH48pGAH5EmstenSokAdTz7Xt7zn4OgIwRIR4l9
 0fLwBGV8McXKD8aluzhihwYePyApjjulnhMvLjwOH3WO1/cwpNtD7nu9TdVZ4OCMjA8S
 c9CQIJkAS0fQVUjZIlIZtaLGjr0eQHoBc0Ml2c5fY6fYDFZIe4MRDXrAX2YVoKmv1DK0
 bwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ou9injEFK3ynx6TLorApjrz9C+IV+NUJDgRb4FiGCd0=;
 b=OiG1UWU+hFkqcaYQ36aWuNIy3HpZ/BwcKOIAApa6rZmtbgN4wfEBO9XmvgUL0RfiTI
 Q4hqcDxkFCzd3XE/f9OVpL4REIJTBrfbCWd211sxgPjmLJ7Z+vg9cBAqJcxXdr6CT/NY
 hu+3fCJNYBFLj8Kd+ZkeUwDEOkBCFHmojwZseKvQrlucX3+//TRQ1csW7mtsvG4ch3lA
 rQhFNEFAcFqnKYAjZRwRYgQZ1u+BMnqy17PWrvQGp/WYd4dMMxVXECxtkH0DsI0mvDwW
 2P8LdBJ/4tjgjPcDkbUUXUGa8lG4ffQ1CuGTrnI9fylcyJr+kxACR8KC2R1EbgU47nQO
 YulA==
X-Gm-Message-State: AOAM533Cb5nGY7t3uZx2wxEdwVp+MWCx3tUX91/EIku8DbgZyCCP8Uv7
 wA5o/hDmM1aP+czu9mQlpZAXzQ==
X-Google-Smtp-Source: ABdhPJzW0hcZaP/tw8LsHLMPTKiwkkYHFromXeW07uLdryNq4J0OhAM1tb62eb6pB/v/hKExJM8Mhg==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr9066135wru.374.1599741297317; 
 Thu, 10 Sep 2020 05:34:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 by smtp.gmail.com with ESMTPSA id n21sm3532461wmi.21.2020.09.10.05.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 05:34:56 -0700 (PDT)
Date: Thu, 10 Sep 2020 13:34:52 +0100
From: Andrew Scull <ascull@google.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v2 04/10] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200910123452.GD93664@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-5-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903091712.46456-5-dbrazdil@google.com>
Cc: linux-arch@vger.kernel.org, kernel-team@android.com,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Thu, Sep 03, 2020 at 11:17:06AM +0200, 'David Brazdil' via kernel-team wrote:
> The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
> because they always needed to use TPIDR_EL2 for base, while
> adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
> _EL1 based on VHE/nVHE.
> 
> Simplify this now that the nVHE hyp mode case can be handled using the
> __KVM_NVHE_HYPERVISOR__ macro. VHE selects _EL2 with alternatives.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Acked-by: Andrew Scull <ascull@google.com>

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 54d181177656..b392a977efb6 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -218,6 +218,21 @@ lr	.req	x30		// link register
>  	str	\src, [\tmp, :lo12:\sym]
>  	.endm
>  
> +	/*
> +	 * @dst: destination register (32 or 64 bit wide)
> +	 */
> +	.macro	this_cpu_offset, dst
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +	mrs	\dst, tpidr_el2

Another part that might also apply to __KVM_VHE_HYPERVISOR__.

> +#else
> +alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
> +	mrs	\dst, tpidr_el1
> +alternative_else
> +	mrs	\dst, tpidr_el2
> +alternative_endif
> +#endif
> +	.endm


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
