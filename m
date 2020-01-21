Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F5143C2A
	for <lists+kvmarm@lfdr.de>; Tue, 21 Jan 2020 12:43:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE8934AFFB;
	Tue, 21 Jan 2020 06:43:14 -0500 (EST)
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
	with ESMTP id 9WC-BOUmsd-y; Tue, 21 Jan 2020 06:43:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89B514AFF7;
	Tue, 21 Jan 2020 06:43:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B08204AFEA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 06:43:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id noawND624Zhz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Jan 2020 06:43:11 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9DD0C4AFE9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 06:43:11 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7998720882;
 Tue, 21 Jan 2020 11:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579606990;
 bh=OyaD3KWZFeQnIfDMhLTck+nfHj8nKKYYGTK3HDGxqNw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Mwe5EFKCT8ZriE6DI0uA8MfzhonTA38u6DxTQq78YTtEK/MSrVuPpB9ZwC0hU+rND
 jS3S7d48XTL5IblfT7NzDD/Bq/9RKl6BIzlbE667CHvOrAr2V2CUw+GUPx82yGasQo
 cz5PDo2fq446LbqHbBKeB/6632ESJTNqpFLgJuHY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1itrw4-000USs-PC; Tue, 21 Jan 2020 11:43:08 +0000
MIME-Version: 1.0
Date: Tue, 21 Jan 2020 11:43:08 +0000
From: Marc Zyngier <maz@kernel.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] KVM: arm: Fix build after MMIO cleanup
In-Reply-To: <20200121031007.106259-1-olof@lixom.net>
References: <20200119181116.374-1-maz@kernel.org>
 <20200121031007.106259-1-olof@lixom.net>
Message-ID: <0e4e302783ffecf37eb809553f988625@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: olof@lixom.net, james.morse@arm.com,
 Christoffer.Dall@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 2020-01-21 03:10, Olof Johansson wrote:
> Looks like the mmio_decode field was accidentally left in on 32-bit:
> 
> In file included from /build/include/linux/kvm_host.h:36,
>                  from /build/arch/arm/kernel/asm-offsets.c:15:
> arch/arm/include/asm/kvm_host.h:205:20: error: field 'mmio_decode' has
> incomplete type
> 
> Fixes: 480bfa6478c8 ("KVM: arm/arm64: Cleanup MMIO handling")
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/include/asm/kvm_host.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h 
> b/arch/arm/include/asm/kvm_host.h
> index acf4c87e8321a..bd2233805d995 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -201,9 +201,6 @@ struct kvm_vcpu_arch {
>  	 /* Don't run the guest (internal implementation need) */
>  	bool pause;
> 
> -	/* IO related fields */
> -	struct kvm_decode mmio_decode;
> -
>  	/* Cache some mmu pages needed inside spinlock regions */
>  	struct kvm_mmu_memory_cache mmu_page_cache;

Ouch. Thanks for that. I've squashed the fix in the original patch
(which I didn't really intend to be in -next just yet - not quite
sure what I did here).

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
