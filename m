Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD09339A632
	for <lists+kvmarm@lfdr.de>; Thu,  3 Jun 2021 18:48:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 148084B11D;
	Thu,  3 Jun 2021 12:48:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oMbwl4VC9orV; Thu,  3 Jun 2021 12:48:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E016A4B10F;
	Thu,  3 Jun 2021 12:48:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C64124B0C5
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 12:48:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MHP5qFQ2pLty for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Jun 2021 12:48:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5922B49F83
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 12:48:12 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B2D161026;
 Thu,  3 Jun 2021 16:48:08 +0000 (UTC)
Date: Thu, 3 Jun 2021 17:48:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v13 5/8] KVM: arm64: Save/restore MTE registers
Message-ID: <20210603164805.GF20338@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-6-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210524104513.13258-6-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On Mon, May 24, 2021 at 11:45:10AM +0100, Steven Price wrote:
> diff --git a/arch/arm64/include/asm/kvm_mte.h b/arch/arm64/include/asm/kvm_mte.h
> new file mode 100644
> index 000000000000..eae4bce9e269
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_mte.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 ARM Ltd.

You may want to update some of the years.

> + */
> +#ifndef __ASM_KVM_MTE_H
> +#define __ASM_KVM_MTE_H
> +
> +#ifdef __ASSEMBLY__
> +
> +#include <asm/sysreg.h>
> +
> +#ifdef CONFIG_ARM64_MTE
> +
> +.macro mte_switch_to_guest g_ctxt, h_ctxt, reg1
> +alternative_if_not ARM64_MTE
> +	b	.L__skip_switch\@
> +alternative_else_nop_endif
> +	mrs	\reg1, hcr_el2
> +	and	\reg1, \reg1, #(HCR_ATA)
> +	cbz	\reg1, .L__skip_switch\@

Nitpick: TBZ would be shorter, though you need the bit number.

The patch looks fine (as per my understanding of the KVM context
switching code):

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
