Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 933D21530FA
	for <lists+kvmarm@lfdr.de>; Wed,  5 Feb 2020 13:43:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AD024A7E4;
	Wed,  5 Feb 2020 07:43:57 -0500 (EST)
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
	with ESMTP id l9HnkGHRJsbY; Wed,  5 Feb 2020 07:43:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D92724A51E;
	Wed,  5 Feb 2020 07:43:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 25D794A4E5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Feb 2020 07:43:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-CtCjofkGCf for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Feb 2020 07:43:54 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E0B124A49F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Feb 2020 07:43:53 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE8D720674;
 Wed,  5 Feb 2020 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580906632;
 bh=0nhgLoKBd1xmo2Khpi4Cvrfth35BI8Ya1ztqYzurtSM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ICzBZX/JpwWLiHlmX/jL53ordUZGAjB3KgThNSGl7YnfS+Km/wWA9MXDeaLBS9Xta
 gGo1PV4ZFrDtjw6ClU4/t2BIFlGX7Wfm6ErX7tcYlvNUnnFNf5xj3BJOcCBAInbLY+
 tAG0Jvn/abpxb0agK7YlmJQOt1cMwzaNZI+xBo8E=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1izK23-00386f-1b; Wed, 05 Feb 2020 12:43:51 +0000
MIME-Version: 1.0
Date: Wed, 05 Feb 2020 12:43:51 +0000
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 1/5] irqchip/gic-v4.1: Fix programming of
 GICR_VPROPBASER_4_1_SIZE
In-Reply-To: <20200204090940.1225-2-yuzenghui@huawei.com>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
 <20200204090940.1225-2-yuzenghui@huawei.com>
Message-ID: <29e6c483b71dcf28e9b140f4edfe566d@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: jason@lakedaemon.net, linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-02-04 09:09, Zenghui Yu wrote:
> The Size field of GICv4.1 VPROPBASER register indicates number of
> pages minus one and together Page_Size and Size control the vPEID
> width. Let's respect this requirement of the architecture.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index e5a25d97f8db..992bc72cab6f 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2531,7 +2531,7 @@ static int allocate_vpe_l1_table(void)
>  		npg = 1;
>  	}
> 
> -	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg);
> +	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg - 1);
> 
>  	/* Right, that's the number of CPU pages we need for L1 */
>  	np = DIV_ROUND_UP(npg * psz, PAGE_SIZE);

Indeed, nice catch.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
