Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2E4DC4FD
	for <lists+kvmarm@lfdr.de>; Thu, 17 Mar 2022 12:43:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DC1040D01;
	Thu, 17 Mar 2022 07:43:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0tMrYQtq5vJN; Thu, 17 Mar 2022 07:43:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4694F49F2A;
	Thu, 17 Mar 2022 07:43:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D8D2140D01
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Mar 2022 07:43:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AdwM9zfKUW7U for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Mar 2022 07:43:38 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6755140B8D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Mar 2022 07:43:38 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 35B04B81E15;
 Thu, 17 Mar 2022 11:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7427C340E9;
 Thu, 17 Mar 2022 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647517414;
 bh=FGRIOk0v4eRxILLN0EmqViJbiPzs8tFo65NZYK2c6M8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k7jHa6fyKnp18ueUptgaaNar4W0EJHj7RZrOYzOoHcWIQMpX/OiLxyXGcA0lTs/rg
 oMYgpJGfLo96U03BBDNHMrMgOMGYHWZEN6wjmooA5Rda3NT4FzA+y8FenrhXjc+cGG
 wU7W96PBKe8ldlwffOtNJGAkq3IC2RgcK5BeGJLaFftNoJCYxc41XGwPVG6sOvjWiz
 TH2T/co8qejYx2ELVM7+mgqRMQaI7hygQJmAHA4BO9Pl70Ejf3FCDdnrUXV1RQwF1S
 AQywzrzaDZV68bJ25grI8ZyTQks+y3pX5Z+hm8VfM/TVCf583pvEx5g5fgB/snBoKJ
 2pUg/sHAq4Vvg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nUoXT-00FA6r-FP; Thu, 17 Mar 2022 11:43:31 +0000
Date: Thu, 17 Mar 2022 11:43:31 +0000
Message-ID: <87sfrgyfbw.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v1 2/2] KVM: arm64: Add debug tracepoint for vcpu exits
In-Reply-To: <20220317005630.3666572-3-jingzhangos@google.com>
References: <20220317005630.3666572-1-jingzhangos@google.com>
 <20220317005630.3666572-3-jingzhangos@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: jingzhangos@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, will@kernel.org, pbonzini@redhat.com,
 dmatlack@google.com, seanjc@google.com, oupton@google.com, reijiw@google.com,
 ricarkol@google.com, rananta@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: KVM <kvm@vger.kernel.org>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>
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

Hi Jing,

On Thu, 17 Mar 2022 00:56:30 +0000,
Jing Zhang <jingzhangos@google.com> wrote:
> 
> This tracepoint only provides a hook for poking vcpu exits information,
> not exported to tracefs.
> A timestamp is added for the last vcpu exit, which would be useful for
> analysis for vcpu exits.

The trace itself gives you a timestamp. Why do you need an extra one?

> 
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 3 +++
>  arch/arm64/kvm/arm.c              | 2 ++
>  arch/arm64/kvm/trace_arm.h        | 8 ++++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index daa68b053bdc..576f2c18d008 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -415,6 +415,9 @@ struct kvm_vcpu_arch {
>  
>  	/* Arch specific exit reason */
>  	enum arm_exit_reason exit_reason;
> +
> +	/* Timestamp for the last vcpu exit */
> +	u64 last_exit_time;
>  };
>  
>  /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index f49ebdd9c990..98631f79c182 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -783,6 +783,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	ret = 1;
>  	run->exit_reason = KVM_EXIT_UNKNOWN;
>  	while (ret > 0) {
> +		trace_kvm_vcpu_exits(vcpu);

Exit? We haven't entered the guest yet!

>  		/*
>  		 * Check conditions before entering the guest
>  		 */
> @@ -898,6 +899,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		local_irq_enable();
>  
>  		trace_kvm_exit(ret, kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
> +		vcpu->arch.last_exit_time = ktime_to_ns(ktime_get());

Why isn't the above tracepoint sufficient? It gives you the EC, and
comes with a timestamp for free. And why should *everyone* pay the
price of this timestamp update if not tracing?

>  
>  		/* Exit types that need handling before we can be preempted */
>  		handle_exit_early(vcpu, ret);
> diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
> index 33e4e7dd2719..3e7dfd640e23 100644
> --- a/arch/arm64/kvm/trace_arm.h
> +++ b/arch/arm64/kvm/trace_arm.h
> @@ -301,6 +301,14 @@ TRACE_EVENT(kvm_timer_emulate,
>  		  __entry->timer_idx, __entry->should_fire)
>  );
>  
> +/*
> + * Following tracepoints are not exported in tracefs and provide hooking
> + * mechanisms only for testing and debugging purposes.
> + */
> +DECLARE_TRACE(kvm_vcpu_exits,
> +	TP_PROTO(struct kvm_vcpu *vcpu),
> +	TP_ARGS(vcpu));
> +
>  #endif /* _TRACE_ARM_ARM64_KVM_H */
>  
>  #undef TRACE_INCLUDE_PATH

I guess this is the only bit I actually like about this series: a
generic, out of the way mechanism to let people hook whatever they
want and dump the state they need.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
