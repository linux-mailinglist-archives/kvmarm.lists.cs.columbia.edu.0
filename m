Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C6658DAF
	for <lists+kvmarm@lfdr.de>; Thu, 29 Dec 2022 14:54:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FA824B802;
	Thu, 29 Dec 2022 08:54:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mdGBU5XIzYh; Thu, 29 Dec 2022 08:54:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 36B254B7F9;
	Thu, 29 Dec 2022 08:54:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 83B224B643
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Dec 2022 08:54:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3Vzvf3vp1m1 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Dec 2022 08:54:38 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 64F7040796
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Dec 2022 08:54:38 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 86D7061718;
 Thu, 29 Dec 2022 13:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4317C433EF;
 Thu, 29 Dec 2022 13:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672322075;
 bh=cluGXPOR4SegMfJZlmuHjl3pxFZULPPadZDrzZNHRNE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RMzTcEXzWbgoSKBDGd3S9lQJFrTiMblFXZJqChIw/m8KHYqcFgsICC6jbO8/qEGJK
 dg34LF/o2wNt3csRIOaAIlLoElP/E+x4C0o0ZircSujyE8SW5niJ7Qjf0vdxzDPXOJ
 thBa9sCmbsIcTXQ41Ijzr7nClMJ57hr8CdMud6p+6l3ISoSOuwFb4ktdEhbh65hbXh
 zMwP1hJFp/2TWtMpGWpNTqxyWv8SwET29S2JQYmSwTQJx8cTnfesOSHQHjNY3d9h1k
 Cg8vc+rDNFve4Pj/5uqozlVgNVuWW1DnXV7wVkno8BST6c12DDtDAy8PYSjE8g0mAa
 n9AcI3vQlJPvQ==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1pAtMf-00FiN4-Lp;
 Thu, 29 Dec 2022 13:54:33 +0000
Date: Thu, 29 Dec 2022 13:53:15 +0000
Message-ID: <87y1qqe2pg.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH 2/3] KVM: arm64: nv: Emulate ISTATUS when emulated timers
 are fired.
In-Reply-To: <20220824060304.21128-3-gankulkarni@os.amperecomputing.com>
References: <20220824060304.21128-1-gankulkarni@os.amperecomputing.com>
 <20220824060304.21128-3-gankulkarni@os.amperecomputing.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: gankulkarni@os.amperecomputing.com, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 scott@os.amperecomputing.com, keyur@os.amperecomputing.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: scott@os.amperecomputing.com, kvm@vger.kernel.org, catalin.marinas@arm.com,
 keyur@os.amperecomputing.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Wed, 24 Aug 2022 07:03:03 +0100,
Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
> 
> Guest-Hypervisor forwards the timer interrupt to Guest-Guest, if it is
> enabled, unmasked and ISTATUS bit of register CNTV_CTL_EL0 is set for a
> loaded timer.
> 
> For NV2 implementation, the Host-Hypervisor is not emulating the ISTATUS
> bit while forwarding the Emulated Vtimer Interrupt to Guest-Hypervisor.
> This results in the drop of interrupt from Guest-Hypervisor, where as
> Host Hypervisor marked it as an active interrupt and expecting Guest-Guest
> to consume and acknowledge. Due to this, some of the Guest-Guest vCPUs
> are stuck in Idle thread and rcu soft lockups are seen.
> 
> This issue is not seen with NV1 case since the register CNTV_CTL_EL0 read
> trap handler is emulating the ISTATUS bit.
> 
> Adding code to set/emulate the ISTATUS when the emulated timers are fired.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  arch/arm64/kvm/arch_timer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 27a6ec46803a..0b32d943d2d5 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -63,6 +63,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>  			      struct arch_timer_context *timer,
>  			      enum kvm_arch_timer_regs treg);
>  static bool kvm_arch_timer_get_input_level(int vintid);
> +static u64 read_timer_ctl(struct arch_timer_context *timer);
>  
>  static struct irq_ops arch_timer_irq_ops = {
>  	.get_input_level = kvm_arch_timer_get_input_level,
> @@ -356,6 +357,8 @@ static enum hrtimer_restart kvm_hrtimer_expire(struct hrtimer *hrt)
>  		return HRTIMER_RESTART;
>  	}
>  
> +	/* Timer emulated, emulate ISTATUS also */
> +	timer_set_ctl(ctx, read_timer_ctl(ctx));

Why should we do that for non-NV2 configurations?

>  	kvm_timer_update_irq(vcpu, true, ctx);
>  	return HRTIMER_NORESTART;
>  }
> @@ -458,6 +461,8 @@ static void timer_emulate(struct arch_timer_context *ctx)
>  	trace_kvm_timer_emulate(ctx, should_fire);
>  
>  	if (should_fire != ctx->irq.level) {
> +		/* Timer emulated, emulate ISTATUS also */
> +		timer_set_ctl(ctx, read_timer_ctl(ctx));
>  		kvm_timer_update_irq(ctx->vcpu, should_fire, ctx);
>  		return;
>  	}

I'm not overly keen on this. Yes, we can set the status bit there. But
conversely, the bit will not get cleared when the guest reprograms the
timer, and will take a full exit/entry cycle for it to appear.

Ergo, the architecture is buggy as memory (the VNCR page) cannot be
used to emulate something as dynamic as a timer.

It is only with FEAT_ECV that we can solve this correctly by trapping
the counter/timer accesses and emulate them for the guest hypervisor.
I'd rather we add support for that, as I expect all the FEAT_NV2
implementations to have it (and hopefully FEAT_FGT as well).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
