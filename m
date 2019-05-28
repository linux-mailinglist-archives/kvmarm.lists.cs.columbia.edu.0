Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7F2C50A
	for <lists+kvmarm@lfdr.de>; Tue, 28 May 2019 13:01:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A0354A4F3;
	Tue, 28 May 2019 07:01:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLgzUtJ3NQ9V; Tue, 28 May 2019 07:01:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E9A084A4E9;
	Tue, 28 May 2019 07:01:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C1FDA4A3A3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 May 2019 07:01:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7gTlZIogc1VQ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 May 2019 07:01:55 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EC664A331
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 May 2019 07:01:55 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B11341;
 Tue, 28 May 2019 04:01:54 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDB133F59C;
 Tue, 28 May 2019 04:01:53 -0700 (PDT)
Date: Tue, 28 May 2019 13:01:52 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH] KVM: arm/arm64: fix emulated ptimer irq injection
Message-ID: <20190528110152.GA6775@e113682-lin.lund.arm.com>
References: <20190527114619.16252-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190527114619.16252-1-drjones@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu
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

On Mon, May 27, 2019 at 01:46:19PM +0200, Andrew Jones wrote:
> The emulated ptimer needs to track the level changes, otherwise the
> the interrupt will never get deasserted, resulting in the guest getting
> stuck in an interrupt storm if it enables ptimer interrupts. This was
> found with kvm-unit-tests; the ptimer tests hung as soon as interrupts
> were enabled. Typical Linux guests don't have a problem as they prefer
> using the virtual timer.
> 
> Fixes: bee038a674875 ("KVM: arm/arm64: Rework the timer code to use a timer_map")
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  virt/kvm/arm/arch_timer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 7fc272ecae16..9f5d8cc8b5e5 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -324,10 +324,15 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
>  static void timer_emulate(struct arch_timer_context *ctx)
>  {
>  	bool should_fire = kvm_timer_should_fire(ctx);
> +	struct timer_map map;
> +
> +	get_timer_map(ctx->vcpu, &map);
>  
>  	trace_kvm_timer_emulate(ctx, should_fire);
>  
> -	if (should_fire) {
> +	if (ctx == map.emul_ptimer && should_fire != ctx->irq.level) {
> +		kvm_timer_update_irq(ctx->vcpu, !ctx->irq.level, ctx);
> +	} else if (should_fire) {
>  		kvm_timer_update_irq(ctx->vcpu, true, ctx);
>  		return;
>  	}

Hmm, this doesn't feel completely right.

Lowering the line of an emulated timer should only ever happen when the
guest (or user space) writes to one of the system registers for that
timer, which should be trapped and that should cause an update of the
line.

Are we missing a call to kvm_timer_update_irq() from
kvm_arm_timer_set_reg() ?


Thanks,

    Christoffer
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
