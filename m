Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8D236107506
	for <lists+kvmarm@lfdr.de>; Fri, 22 Nov 2019 16:38:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 211C04AED3;
	Fri, 22 Nov 2019 10:38:46 -0500 (EST)
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
	with ESMTP id EX4oxaClTvRp; Fri, 22 Nov 2019 10:38:46 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3A8A4AEC7;
	Fri, 22 Nov 2019 10:38:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B2354AEC1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Nov 2019 10:38:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VlQQkGAgAmQx for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 Nov 2019 10:38:42 -0500 (EST)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 196914AEBD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Nov 2019 10:38:42 -0500 (EST)
Received: by mail-wm1-f67.google.com with SMTP id t26so6591548wmi.0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Nov 2019 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2bXdv451uXtHSKP2mFUlRRcnaTmxXQD2UXLdESeqDYQ=;
 b=K4+ZfWyCelA/4gucez16m+FoaIk5SAyV4dEBlLeZrYV2Fcx2ZuN1RnnDTU+v1NQxk/
 KShVhuHqA2e7tdi6hlnAeQvYF+V6uxLsUdYhP6qxGl+IRmHLG7GFMW2K9O454pscCuhW
 SOtgnyfpbqm5bYW9xQ0DayvbhIZKVF0asKljlThCDSzd0hdvWP/cSlvgiz0EupNBYz9W
 J+k7U21fb5PXj8UIY0qKU+gmI/yAwNHiodLtHpDygZCeHQELU751kbbjU7I1SZoo+tAX
 LAaV2b4Oo9MkHAJ8JjMNfDebWdr5rzvwlppw7UehseKtw0x8DdO0TDEeklZJEyH3AuYN
 5n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2bXdv451uXtHSKP2mFUlRRcnaTmxXQD2UXLdESeqDYQ=;
 b=N5OrCuAYIlAxBX9j1OX3uJYrfhACY4j9pnrMk/D9AmwZNyeTdg/7+X7wyWZuVNIyez
 jRsJ8RtP4i+TuOe8pTDnWDwL1euXkhCH+8NsWM7BTQ285sSSW4qE5rdYojYQLcroaHGr
 1F2ZNy8Fl75cVJdpzvkjS/GBu2cl4+efHbMxZREiPgcxzkboIviYlcDdY3aHIX3Xlcli
 Fnk/B0FSnT/D9cE0eG28J6xg5fQIxVUBYUMUVYeJesLo40FD8SU88PP4z/SUKiQXdOue
 5VHt567Am0XHXwjkNDaKNzXgKBjdPCJlyZ1rYDVSEQ87IsIulRE9tNJI3ph7wxzzsaWG
 yvEw==
X-Gm-Message-State: APjAAAWlxX9SZX34jvM7L5ChTL0AMc+dzoZ4zFxlW03llm3POxfae+qF
 yjKIOrNCyoK0fzx/k9szqUhOAA==
X-Google-Smtp-Source: APXvYqxt4TgJV1dS5Bjno9tHw1KVHIZBIvkkQpeod6YkQ3wdPI4vcJ6Tlj3WAb1Og+1pOLvFbZ0HZQ==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr18046942wmc.113.1574437120711; 
 Fri, 22 Nov 2019 07:38:40 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
 by smtp.gmail.com with ESMTPSA id k4sm4123806wmk.26.2019.11.22.07.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 07:38:40 -0800 (PST)
Date: Fri, 22 Nov 2019 15:38:36 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] target/arm: Fix ISR_EL1 tracking when executing at EL2
Message-ID: <20191122153836.GA222628@google.com>
References: <20191122135833.28953-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191122135833.28953-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will@kernel.org>, qemu-devel@nongnu.org,
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

On Friday 22 Nov 2019 at 13:58:33 (+0000), Marc Zyngier wrote:
> The ARMv8 ARM states when executing at EL2, EL3 or Secure EL1,
> ISR_EL1 shows the pending status of the physical IRQ, FIQ, or
> SError interrupts.
> 
> Unfortunately, QEMU's implementation only considers the HCR_EL2
> bits, and ignores the current exception level. This means a hypervisor
> trying to look at its own interrupt state actually sees the guest
> state, which is unexpected and breaks KVM as of Linux 5.3.
> 
> Instead, check for the running EL and return the physical bits
> if not running in a virtualized context.
> 
> Fixes: 636540e9c40b
> Reported-by: Quentin Perret <qperret@google.com>

And FWIW, Tested-by: Quentin Perret <qperret@google.com>

Thanks Marc :)
Quentin

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a089fb5a69..027fffbff6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1934,8 +1934,11 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      CPUState *cs = env_cpu(env);
>      uint64_t hcr_el2 = arm_hcr_el2_eff(env);
>      uint64_t ret = 0;
> +    bool allow_virt = (arm_current_el(env) == 1 &&
> +                       (!arm_is_secure_below_el3(env) ||
> +                        (env->cp15.scr_el3 & SCR_EEL2)));
>  
> -    if (hcr_el2 & HCR_IMO) {
> +    if (allow_virt && (hcr_el2 & HCR_IMO)) {
>          if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
>              ret |= CPSR_I;
>          }
> @@ -1945,7 +1948,7 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>          }
>      }
>  
> -    if (hcr_el2 & HCR_FMO) {
> +    if (allow_virt && (hcr_el2 & HCR_FMO)) {
>          if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
>              ret |= CPSR_F;
>          }
> -- 
> 2.17.1
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
