Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E47295782CB
	for <lists+kvmarm@lfdr.de>; Mon, 18 Jul 2022 14:53:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 162204D600;
	Mon, 18 Jul 2022 08:53:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armlinux.org.uk
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZQoNv+EbddU5; Mon, 18 Jul 2022 08:53:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 024E54D5FC;
	Mon, 18 Jul 2022 08:53:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA6754D5F9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jul 2022 08:53:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9oWh2VYU-XX for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Jul 2022 08:53:19 -0400 (EDT)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 97F094D5E2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jul 2022 08:53:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOhHuQGYl/HbD1EaECNnPA8SFVj/aItRPkxImSp2vxs=; b=skx8Y607MSicrPfoOZieBbOGrM
 6D1Q/Ws8nyelPIqjE5TAlhvWKbombf/asVNcU4WXD0/Q3GtF1l0Fu6qXl/B7K9NizI/jhQEMsrK48
 NL8rCSvcAqVPdkuxuewTEVOXbk5ZAv8AFAJ+wX5VltVi/WECw5bsuC4DsCp0IOmRS8KlQ0gFGLjjH
 re7BeOpo6kJrYhKVTBJzmy9MupX1nk2oaUZtXpajtRW6r1/fAEjAjHb/KNnVLW29+t4jv1cdUCKW9
 vBrcqyxZoBpZ7M2VW1r4UYWLFRsLbugpyT+2pzEGqXugJY5IhLx8ZRLhtjG3FBESR83E5ioXc/HPm
 4+thAACw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33406)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1oDQF5-0001ZE-0Y; Mon, 18 Jul 2022 13:52:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1oDQF0-0001yX-Ic; Mon, 18 Jul 2022 13:52:50 +0100
Date: Mon, 18 Jul 2022 13:52:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v4 01/18] arm64: stacktrace: Add shared header for common
 stack unwinding code
Message-ID: <YtVXokYGdlq1maQu@shell.armlinux.org.uk>
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-2-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220715061027.1612149-2-kaleshsingh@google.com>
Cc: wangkefeng.wang@huawei.com, catalin.marinas@arm.com, elver@google.com,
 vincenzo.frascino@arm.com, will@kernel.org, android-mm@google.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, madvenka@linux.microsoft.com,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 drjones@redhat.com, ast@kernel.org, broonie@kernel.org, andreyknvl@gmail.com,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org
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

Hi,

Can you please explain why you are targetting my @oracle.com email
address with this patch set?

This causes me problems as I use Outlook's Web interface for that
which doesn't appear to cope with the threading, and most certainly
is only capable of top-reply only which is against Linux kernel email
standards.

Thanks.

On Thu, Jul 14, 2022 at 11:10:10PM -0700, Kalesh Singh wrote:
> In order to reuse the arm64 stack unwinding logic for the nVHE
> hypervisor stack, move the common code to a shared header
> (arch/arm64/include/asm/stacktrace/common.h).
> 
> The nVHE hypervisor cannot safely link against kernel code, so we
> make use of the shared header to avoid duplicated logic later in
> this series.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/include/asm/stacktrace.h        |  35 +------
>  arch/arm64/include/asm/stacktrace/common.h | 105 +++++++++++++++++++++
>  arch/arm64/kernel/stacktrace.c             |  57 -----------
>  3 files changed, 106 insertions(+), 91 deletions(-)
>  create mode 100644 arch/arm64/include/asm/stacktrace/common.h
> 
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index aec9315bf156..79f455b37c84 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -8,52 +8,19 @@
>  #include <linux/percpu.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
> -#include <linux/types.h>
>  #include <linux/llist.h>
>  
>  #include <asm/memory.h>
>  #include <asm/ptrace.h>
>  #include <asm/sdei.h>
>  
> -enum stack_type {
> -	STACK_TYPE_UNKNOWN,
> -	STACK_TYPE_TASK,
> -	STACK_TYPE_IRQ,
> -	STACK_TYPE_OVERFLOW,
> -	STACK_TYPE_SDEI_NORMAL,
> -	STACK_TYPE_SDEI_CRITICAL,
> -	__NR_STACK_TYPES
> -};
> -
> -struct stack_info {
> -	unsigned long low;
> -	unsigned long high;
> -	enum stack_type type;
> -};
> +#include <asm/stacktrace/common.h>
>  
>  extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  			   const char *loglvl);
>  
>  DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
>  
> -static inline bool on_stack(unsigned long sp, unsigned long size,
> -			    unsigned long low, unsigned long high,
> -			    enum stack_type type, struct stack_info *info)
> -{
> -	if (!low)
> -		return false;
> -
> -	if (sp < low || sp + size < sp || sp + size > high)
> -		return false;
> -
> -	if (info) {
> -		info->low = low;
> -		info->high = high;
> -		info->type = type;
> -	}
> -	return true;
> -}
> -
>  static inline bool on_irq_stack(unsigned long sp, unsigned long size,
>  				struct stack_info *info)
>  {
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> new file mode 100644
> index 000000000000..64ae4f6b06fe
> --- /dev/null
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Common arm64 stack unwinder code.
> + *
> + * Copyright (C) 2012 ARM Ltd.
> + */
> +#ifndef __ASM_STACKTRACE_COMMON_H
> +#define __ASM_STACKTRACE_COMMON_H
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +
> +enum stack_type {
> +	STACK_TYPE_UNKNOWN,
> +	STACK_TYPE_TASK,
> +	STACK_TYPE_IRQ,
> +	STACK_TYPE_OVERFLOW,
> +	STACK_TYPE_SDEI_NORMAL,
> +	STACK_TYPE_SDEI_CRITICAL,
> +	__NR_STACK_TYPES
> +};
> +
> +struct stack_info {
> +	unsigned long low;
> +	unsigned long high;
> +	enum stack_type type;
> +};
> +
> +/*
> + * A snapshot of a frame record or fp/lr register values, along with some
> + * accounting information necessary for robust unwinding.
> + *
> + * @fp:          The fp value in the frame record (or the real fp)
> + * @pc:          The lr value in the frame record (or the real lr)
> + *
> + * @stacks_done: Stacks which have been entirely unwound, for which it is no
> + *               longer valid to unwind to.
> + *
> + * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
> + *               of 0. This is used to ensure that within a stack, each
> + *               subsequent frame record is at an increasing address.
> + * @prev_type:   The type of stack this frame record was on, or a synthetic
> + *               value of STACK_TYPE_UNKNOWN. This is used to detect a
> + *               transition from one stack to another.
> + *
> + * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
> + *               associated with the most recently encountered replacement lr
> + *               value.
> + *
> + * @task:        The task being unwound.
> + */
> +struct unwind_state {
> +	unsigned long fp;
> +	unsigned long pc;
> +	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
> +	unsigned long prev_fp;
> +	enum stack_type prev_type;
> +#ifdef CONFIG_KRETPROBES
> +	struct llist_node *kr_cur;
> +#endif
> +	struct task_struct *task;
> +};
> +
> +static inline bool on_stack(unsigned long sp, unsigned long size,
> +			    unsigned long low, unsigned long high,
> +			    enum stack_type type, struct stack_info *info)
> +{
> +	if (!low)
> +		return false;
> +
> +	if (sp < low || sp + size < sp || sp + size > high)
> +		return false;
> +
> +	if (info) {
> +		info->low = low;
> +		info->high = high;
> +		info->type = type;
> +	}
> +	return true;
> +}
> +
> +static inline void unwind_init_common(struct unwind_state *state,
> +				      struct task_struct *task)
> +{
> +	state->task = task;
> +#ifdef CONFIG_KRETPROBES
> +	state->kr_cur = NULL;
> +#endif
> +
> +	/*
> +	 * Prime the first unwind.
> +	 *
> +	 * In unwind_next() we'll check that the FP points to a valid stack,
> +	 * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
> +	 * treated as a transition to whichever stack that happens to be. The
> +	 * prev_fp value won't be used, but we set it to 0 such that it is
> +	 * definitely not an accessible stack address.
> +	 */
> +	bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
> +	state->prev_fp = 0;
> +	state->prev_type = STACK_TYPE_UNKNOWN;
> +}
> +
> +#endif	/* __ASM_STACKTRACE_COMMON_H */
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index fcaa151b81f1..94a5dd2ab8fd 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -18,63 +18,6 @@
>  #include <asm/stack_pointer.h>
>  #include <asm/stacktrace.h>
>  
> -/*
> - * A snapshot of a frame record or fp/lr register values, along with some
> - * accounting information necessary for robust unwinding.
> - *
> - * @fp:          The fp value in the frame record (or the real fp)
> - * @pc:          The lr value in the frame record (or the real lr)
> - *
> - * @stacks_done: Stacks which have been entirely unwound, for which it is no
> - *               longer valid to unwind to.
> - *
> - * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
> - *               of 0. This is used to ensure that within a stack, each
> - *               subsequent frame record is at an increasing address.
> - * @prev_type:   The type of stack this frame record was on, or a synthetic
> - *               value of STACK_TYPE_UNKNOWN. This is used to detect a
> - *               transition from one stack to another.
> - *
> - * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
> - *               associated with the most recently encountered replacement lr
> - *               value.
> - *
> - * @task:        The task being unwound.
> - */
> -struct unwind_state {
> -	unsigned long fp;
> -	unsigned long pc;
> -	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
> -	unsigned long prev_fp;
> -	enum stack_type prev_type;
> -#ifdef CONFIG_KRETPROBES
> -	struct llist_node *kr_cur;
> -#endif
> -	struct task_struct *task;
> -};
> -
> -static void unwind_init_common(struct unwind_state *state,
> -			       struct task_struct *task)
> -{
> -	state->task = task;
> -#ifdef CONFIG_KRETPROBES
> -	state->kr_cur = NULL;
> -#endif
> -
> -	/*
> -	 * Prime the first unwind.
> -	 *
> -	 * In unwind_next() we'll check that the FP points to a valid stack,
> -	 * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
> -	 * treated as a transition to whichever stack that happens to be. The
> -	 * prev_fp value won't be used, but we set it to 0 such that it is
> -	 * definitely not an accessible stack address.
> -	 */
> -	bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
> -	state->prev_fp = 0;
> -	state->prev_type = STACK_TYPE_UNKNOWN;
> -}
> -
>  /*
>   * Start an unwind from a pt_regs.
>   *
> -- 
> 2.37.0.170.g444d1eabd0-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
