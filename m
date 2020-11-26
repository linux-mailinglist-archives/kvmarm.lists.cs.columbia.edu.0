Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 472072C5AAA
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 18:35:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3F944C08E;
	Thu, 26 Nov 2020 12:35:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ytQdNwpaLJZh; Thu, 26 Nov 2020 12:35:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B66704BF8D;
	Thu, 26 Nov 2020 12:35:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E072A4BB4E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 12:35:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OvfWIaDnHKzv for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 12:35:41 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C65824BB17
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 12:35:41 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B2F331B;
 Thu, 26 Nov 2020 09:35:41 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.234])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5C053F23F;
 Thu, 26 Nov 2020 09:35:37 -0800 (PST)
Date: Thu, 26 Nov 2020 17:35:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 04/23] arm64: Move MAIR_EL1_SET to asm/memory.h
Message-ID: <20201126173534.GE38486@C02TD0UTHF1T.local>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-5-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-5-dbrazdil@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
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

On Thu, Nov 26, 2020 at 03:54:02PM +0000, David Brazdil wrote:
> KVM currently initializes MAIR_EL2 to the value of MAIR_EL1. In
> preparation for initializing MAIR_EL2 before MAIR_EL1, move the constant
> into a shared header file. Since it is used for EL1 and EL2, rename to
> MAIR_ELx_SET.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/memory.h | 13 +++++++++++++
>  arch/arm64/mm/proc.S            | 15 +--------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index cd61239bae8c..54a22cb5b17b 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -152,6 +152,19 @@
>  #define MT_S2_FWB_NORMAL	6
>  #define MT_S2_FWB_DEVICE_nGnRE	1
>  
> +/*
> + * Default MAIR_ELx. MT_NORMAL_TAGGED is initially mapped as Normal memory and
> + * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> + */
> +#define MAIR_ELx_SET							\
> +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))

Patch 7 initializes MAIR_EL2 with this directly rather than copying it
from MAIR_EL1, which means that MT_NORMAL_TAGGED will never be tagged
within the nVHE hyp code.

Is that expected? I suspect it's worth a comment here (introduced in
patch 7), just to make that clear.

Otherwise this looks fine to me.

Thanks,
Mark.


> +
>  #ifdef CONFIG_ARM64_4K_PAGES
>  #define IOREMAP_MAX_ORDER	(PUD_SHIFT)
>  #else
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 23c326a06b2d..e3b9aa372b96 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -45,19 +45,6 @@
>  #define TCR_KASAN_FLAGS 0
>  #endif
>  
> -/*
> - * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
> - * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> - */
> -#define MAIR_EL1_SET							\
> -	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> -	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
> -	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
> -
>  #ifdef CONFIG_CPU_PM
>  /**
>   * cpu_do_suspend - save CPU registers context
> @@ -425,7 +412,7 @@ SYM_FUNC_START(__cpu_setup)
>  	/*
>  	 * Memory region attributes
>  	 */
> -	mov_q	x5, MAIR_EL1_SET
> +	mov_q	x5, MAIR_ELx_SET
>  #ifdef CONFIG_ARM64_MTE
>  	/*
>  	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
