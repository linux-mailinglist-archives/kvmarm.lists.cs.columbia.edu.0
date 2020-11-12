Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDA2B04B3
	for <lists+kvmarm@lfdr.de>; Thu, 12 Nov 2020 13:06:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 496D64B6FB;
	Thu, 12 Nov 2020 07:06:01 -0500 (EST)
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
	with ESMTP id yWP3HCWD2j-l; Thu, 12 Nov 2020 07:06:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CFCD4BB6F;
	Thu, 12 Nov 2020 07:06:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 56BFA4B6FE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Nov 2020 07:05:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gRF1zNVJZpio for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Nov 2020 07:05:58 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4480D4B6C7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Nov 2020 07:05:58 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8BDA20872;
 Thu, 12 Nov 2020 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605182757;
 bh=1RokxnXIiW86Rir7wgIsfBgOao08NkyOKziz2ij1Yo0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=wqtvX1dnCD8BtAilPJmUU9ejt6zeu1B5enHIqjRDLk9Dr4yP5ICltZytHgsR78X/+
 tBHG4v/nfyHizjsQbAx8pHK1p27uCLoRAQEZ6Cx8zgeEchxLtkdY0iT6/MNRmXFCle
 hjfEIIaZoijl83jay9d+EtC3CE3MzSTRjJILqN/s=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kdBMQ-00A1ws-LF; Thu, 12 Nov 2020 12:05:54 +0000
MIME-Version: 1.0
Date: Thu, 12 Nov 2020 12:05:54 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 7/9] KVM: arm64: Allocate hyp vectors statically
In-Reply-To: <20201109214726.15276-8-will@kernel.org>
References: <20201109214726.15276-1-will@kernel.org>
 <20201109214726.15276-8-will@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <02b35eecdc794886509be67d02c8bcea@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, kvmarm@lists.cs.columbia.edu,
 catalin.marinas@arm.com, kernel-team@android.com, qperret@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, kernel-team@android.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-11-09 21:47, Will Deacon wrote:
> The EL2 vectors installed when a guest is running point at one of the
> following configurations for a given CPU:
> 
>   - Straight at __kvm_hyp_vector
>   - A trampoline containing an SMC sequence to mitigate Spectre-v2 and
>     then a direct branch to __kvm_hyp_vector
>   - A dynamically-allocated trampoline which has an indirect branch to
>     __kvm_hyp_vector
>   - A dynamically-allocated trampoline containing an SMC sequence to
>     mitigate Spectre-v2 and then an indirect branch to __kvm_hyp_vector
> 
> The indirect branches mean that VA randomization at EL2 isn't trivially
> bypassable using Spectre-v3a (where the vector base is readable by the
> guest).
> 
> Rather than populate these vectors dynamically, configure everything
> statically and use an enumerated type to identify the vector "slot"
> corresponding to one of the configurations above. This both simplifies
> the code, but also makes it much easier to implement at EL2 later on.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

[...]

>  SYM_CODE_START(__bp_harden_hyp_vecs)
> -	.rept BP_HARDEN_EL2_SLOTS
> -	generate_vectors
> -	.endr
> +	generate_vectors indirect = 0, spectrev2 = 0 // HYP_VECTOR_DIRECT
> +	generate_vectors indirect = 0, spectrev2 = 1 // 
> HYP_VECTOR_SPECTRE_DIRECT
> +	generate_vectors indirect = 1, spectrev2 = 0 // HYP_VECTOR_INDIRECT
> +	generate_vectors indirect = 1, spectrev2 = 1 // 
> HYP_VECTOR_SPECTRE_INDIRECT

Another nit (though I'm not sure if it it's a regression or not):
Why do we generate a set of hardened vectors for HYP_VECTOR_DIRECT?
The code in kvm_init_vector_slots() directly points the per-CPU VBAR
to __kvm_hyp_vector, which is the right thing to do. I don't think we
ever use slot 0 in __bp_harden_hyp_vecs, wasting 2kB of text.

Did I miss something?

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
