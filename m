Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D13E73F2921
	for <lists+kvmarm@lfdr.de>; Fri, 20 Aug 2021 11:30:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 53FD44B10E;
	Fri, 20 Aug 2021 05:30:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrBcv7ZX8tCf; Fri, 20 Aug 2021 05:30:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 466764B0D7;
	Fri, 20 Aug 2021 05:30:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 512284A126
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 05:29:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hEQ3xztYrD2q for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Aug 2021 05:29:56 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3F72849FE6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 05:29:56 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 532976112E;
 Fri, 20 Aug 2021 09:29:55 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mH0qX-0069Z8-8X; Fri, 20 Aug 2021 10:29:53 +0100
Date: Fri, 20 Aug 2021 10:29:52 +0100
Message-ID: <87sfz4qx9r.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH] KVM: arm64: Ratelimit error log during guest debug
 exception
In-Reply-To: <20210819223406.1132426-1-rananta@google.com>
References: <20210819223406.1132426-1-rananta@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rananta@google.com, alexandru.elisei@arm.com,
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
 pshier@google.com, ricarkol@google.com, oupton@google.com, reijiw@google.com,
 jingzhangos@google.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Thu, 19 Aug 2021 23:34:06 +0100,
Raghavendra Rao Ananta <rananta@google.com> wrote:
> 
> Potentially, the guests could trigger a debug exception that's
> outside the exception class range.

How? All the exception classes that lead to this functions are already
handled in the switch/case statement.

> This could lead to an excessive syslog flooding. Hence, ratelimit
> the error message.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  arch/arm64/kvm/handle_exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 04ebab299aa4..c7cec7ffe93c 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -134,7 +134,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu)
>  	case ESR_ELx_EC_BRK64:
>  		break;
>  	default:
> -		kvm_err("%s: un-handled case esr: %#08x\n",
> +		kvm_pr_unimpl("%s: un-handled case esr: %#08x\n",
>  			__func__, (unsigned int) esr);
>  		ret = -1;
>  		break;

My take on this is that this code isn't reachable, and that it could
be better rewritten as:

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 6f48336b1d86..ae7ec086827b 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -119,28 +119,14 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 esr = kvm_vcpu_get_esr(vcpu);
-	int ret = 0;
 
 	run->exit_reason = KVM_EXIT_DEBUG;
 	run->debug.arch.hsr = esr;
 
-	switch (ESR_ELx_EC(esr)) {
-	case ESR_ELx_EC_WATCHPT_LOW:
+	if (ESR_ELx_EC(esr) ==  ESR_ELx_EC_WATCHPT_LOW)
 		run->debug.arch.far = vcpu->arch.fault.far_el2;
-		fallthrough;
-	case ESR_ELx_EC_SOFTSTP_LOW:
-	case ESR_ELx_EC_BREAKPT_LOW:
-	case ESR_ELx_EC_BKPT32:
-	case ESR_ELx_EC_BRK64:
-		break;
-	default:
-		kvm_err("%s: un-handled case esr: %#08x\n",
-			__func__, (unsigned int) esr);
-		ret = -1;
-		break;
-	}
 
-	return ret;
+	return 0;
 }
 
 static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
