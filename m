Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64B2C56BC
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 15:13:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B748C4C0D2;
	Thu, 26 Nov 2020 09:13:51 -0500 (EST)
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
	with ESMTP id oJb2kD9m8BcD; Thu, 26 Nov 2020 09:13:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F0784C0A5;
	Thu, 26 Nov 2020 09:13:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F0C94C09B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 09:13:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M3ZXgtCDJNrV for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 09:13:48 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 236284BAC3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 09:13:48 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA7D82053B;
 Thu, 26 Nov 2020 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606400026;
 bh=Nwf0LWOIlSxDboie5BRpCyT4HH+0qOYQLcXu5QovH7Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oYwMx6zrGmCrB+7GRYf+F0vDRHi9tDEldFtLwYFsX55AhxxED5Mby5AKpjXiJTcFR
 C0rYYdk3DyNunHQpOEomBg/MFi/2XGBuJHNFpXo153otiaGAGPpJPWcuRCw/0kAVwR
 T3Ednq1q53U7JpJXdBEmIGM86sfnuLUFGT0A05fM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kiI1o-00DpFw-LG; Thu, 26 Nov 2020 14:13:44 +0000
MIME-Version: 1.0
Date: Thu, 26 Nov 2020 14:13:44 +0000
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 1/2] KVM: arm64: CSSELR_EL1 max is 13
In-Reply-To: <20201126134641.35231-2-drjones@redhat.com>
References: <20201126134641.35231-1-drjones@redhat.com>
 <20201126134641.35231-2-drjones@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <163d00024402dbb518a6f8d669579bfa@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: drjones@redhat.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On 2020-11-26 13:46, Andrew Jones wrote:
> Not counting TnD, which KVM doesn't currently consider, CSSELR_EL1
> can have a maximum value of 0b1101 (13), which corresponds to an
> instruction cache at level 7. With CSSELR_MAX set to 12 we can
> only select up to cache level 6. Change it to 14.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index c1fac9836af1..ef453f7827fa 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -169,7 +169,7 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64
> val, int reg)
>  static u32 cache_levels;
> 
>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
> -#define CSSELR_MAX 12
> +#define CSSELR_MAX 14
> 
>  /* Which cache CCSIDR represents depends on CSSELR value. */
>  static u32 get_ccsidr(u32 csselr)

Huh, nice catch. Do we need a CC: stable tag for this?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
