Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6E340D4E
	for <lists+kvmarm@lfdr.de>; Thu, 18 Mar 2021 19:40:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6D9E4B777;
	Thu, 18 Mar 2021 14:40:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AD2oL6IXKgY4; Thu, 18 Mar 2021 14:40:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C4A24B764;
	Thu, 18 Mar 2021 14:40:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CB0EA4B756
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 14:40:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDXJDxiiEC04 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Mar 2021 14:40:18 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9CAAE4B379
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 14:40:18 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4421D64F30;
 Thu, 18 Mar 2021 18:40:17 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lMxZ9-002St3-20; Thu, 18 Mar 2021 18:40:15 +0000
Date: Thu, 18 Mar 2021 18:40:13 +0000
Message-ID: <87y2ekgvaq.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2 09/11] KVM: arm64: Trap host SVE accesses when the
 FPSIMD state is dirty
In-Reply-To: <20210318122532.505263-10-maz@kernel.org>
References: <20210318122532.505263-1-maz@kernel.org>
 <20210318122532.505263-10-maz@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, dave.martin@arm.com,
 daniel.kiss@arm.com, will@kernel.org, catalin.marinas@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 broonie@kernel.org, ascull@google.com, qperret@google.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 broonie@kernel.org, Will Deacon <will@kernel.org>, dave.martin@arm.com,
 daniel.kiss@arm.com
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

On Thu, 18 Mar 2021 12:25:30 +0000,
Marc Zyngier <maz@kernel.org> wrote:
> 
> ZCR_EL2 controls the upper bound for ZCR_EL1, and is set to
> a potentially lower limit when the guest uses SVE. In order
> to restore the SVE state on the EL1 host, we must first
> reset ZCR_EL2 to its original value.
> 
> To make it as lazy as possible on the EL1 host side, set
> the SVE trapping in place when returning exiting from
> the guest. On the first EL1 access to SVE, ZCR_EL2 will
> be restored to its full glory.
> 
> Suggested-by: Andrew Scull <ascull@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 4 ++++
>  arch/arm64/kvm/hyp/nvhe/switch.c   | 9 +++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index f012f8665ecc..8d04d69edd15 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -177,6 +177,10 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
>  	case ESR_ELx_EC_SMC64:
>  		handle_host_smc(host_ctxt);
>  		break;
> +	case ESR_ELx_EC_SVE:
> +		sve_cond_update_zcr_vq(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +		sysreg_clear_set(cptr_el2, CPTR_EL2_TZ, 0);
> +		break;

It turns out that my last test-run was flawed, as my model was stuck
with VHE, meaning this snippet was never run. If it ran, I would have
noticed that CPTR_EL2.TZ being set results in the ZCR_EL2 access to
trap at EL2, meaning the above explodes very quickly.

I've queued the below patch on top of the existing series, which cures
the issue and let the tests run for real this time.

Thanks to Will for the timely report, and apologies for the lousy
testing...

	M.

From 5b08709313718e95ba06ef49aa82f964a605bd9c Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 18 Mar 2021 18:30:26 +0000
Subject: [PATCH] KVM: arm64: Fix host's ZCR_EL2 restore on nVHE

We re-enter the EL1 host with CPTR_EL2.TZ set in order to
be able to lazily restore ZCR_EL2 when required.

However, the same CPTR_EL2 configuration also leads to trapping
when ZCR_EL2 is accessed from EL2. Duh!

Clear CPTR_EL2.TZ *before* writing to ZCR_EL2.

Fixes: beed09067b42 ("KVM: arm64: Trap host SVE accesses when the FPSIMD state is dirty")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 8d04d69edd15..84a702dc4a92 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -178,8 +178,9 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 		handle_host_smc(host_ctxt);
 		break;
 	case ESR_ELx_EC_SVE:
-		sve_cond_update_zcr_vq(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
 		sysreg_clear_set(cptr_el2, CPTR_EL2_TZ, 0);
+		isb();
+		sve_cond_update_zcr_vq(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
 		break;
 	default:
 		hyp_panic();
-- 
2.29.2


-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
