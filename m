Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE225F893
	for <lists+kvmarm@lfdr.de>; Mon,  7 Sep 2020 12:38:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A83F34B4C3;
	Mon,  7 Sep 2020 06:38:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p4qI5uuHsI87; Mon,  7 Sep 2020 06:38:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 984144B46B;
	Mon,  7 Sep 2020 06:38:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B5424B444
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 06:38:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wXFXCPuT45Z for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Sep 2020 06:38:43 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 82C2E4B433
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 06:38:43 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5AD0B20738;
 Mon,  7 Sep 2020 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599475122;
 bh=H2zHLW+oJBfNU+V+o/hZ1kbOu3tUvHUQGfWA5z2MjJ4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=2Wie+WkEpBuiVpWC9ofKFwXkMLI1rcFab8jei5mgY8Yr/Jv+gqjznDPaFXNqFqvJX
 NN9RWx6JS1s1QS1/mNPR+sOyd3C25pOYe5FqmpZYTvOVN85/FGQsGqX4kw+REswFky
 Q4ga4b/w9GZd9GFqyiHOVwzdhmfGD7DUN8EOzt2g=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kFEXn-009jtD-Bu; Mon, 07 Sep 2020 11:38:40 +0100
Date: Mon, 07 Sep 2020 11:38:38 +0100
Message-ID: <87zh61lvm9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 04/18] KVM: arm64: Restrict symbol aliasing to outside
 nVHE
In-Reply-To: <20200903135307.251331-5-ascull@google.com>
References: <20200903135307.251331-1-ascull@google.com>
 <20200903135307.251331-5-ascull@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26.3
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ascull@google.com, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
 will@kernel.org, catalin.marinas@arm.com, kernel-team@android.com,
 sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
 dbrazdil@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

Hi Andrew,

On Thu, 03 Sep 2020 14:52:53 +0100,
Andrew Scull <ascull@google.com> wrote:
> 
> nVHE symbols are prefixed but this is sometimes hidden from the host by
> aliasing the non-prefixed symbol to the prefixed version with a macro.
> This runs into problems if nVHE tries to use the symbol as it becomes
> doubly prefixed. Avoid this by omitting the aliasing macro for nVHE.
> 
> Cc: David Brazdil <dbrazdil@google.com>
> Signed-off-by: Andrew Scull <ascull@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 6f98fbd0ac81..6f9c4162a764 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -99,8 +99,11 @@ struct kvm_s2_mmu;
>  
>  DECLARE_KVM_NVHE_SYM(__kvm_hyp_init);
>  DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
> +
> +#ifndef __KVM_NVHE_HYPERVISOR__
>  #define __kvm_hyp_init		CHOOSE_NVHE_SYM(__kvm_hyp_init)
>  #define __kvm_hyp_vector	CHOOSE_HYP_SYM(__kvm_hyp_vector)
> +#endif

Hmmm. Why do we limit this to these two symbols instead of making it a
property of the "CHOOSE_*" implementation?

The use of CHOOSE_HYP_SYM is already forbidden in the EL2 code (see
how any symbol results in __nvhe_undefined_symbol being emitted). Does
anything break if we have:

#define CHOOSE_NVHE_SYM(x)	x

when __KVM_NVHE_HYPERVISOR__ is defined?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
