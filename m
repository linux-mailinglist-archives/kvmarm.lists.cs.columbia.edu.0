Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A8E50200AD0
	for <lists+kvmarm@lfdr.de>; Fri, 19 Jun 2020 15:57:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 205BE4B1B0;
	Fri, 19 Jun 2020 09:57:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X1ObjtQ6ODBY; Fri, 19 Jun 2020 09:57:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B9934B199;
	Fri, 19 Jun 2020 09:57:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F4134B0D8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 09:57:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igJKM9ZHf9eE for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Jun 2020 09:57:33 -0400 (EDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7A9DA4B199
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 09:57:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=LAV5/s/2D5B3lhz5CBbE1JjwfKpleg8M/EZQLJv3gY0=; b=JyJL+hT/3UDxfhF0s3aTnfKjXz
 4WDgwcRLMVoKg+qSDE9yLxzSco+H+pQ5Wb81Ou3fMfUQ/D/PUj99vJvG8DVfHMK7Xit5EUflkCXHg
 NVjSoMF1iXJkFyunmO4bT0bhYKqy8plu+KhCaWDYL5rTcS+0HqBZ2l2cO31jrjswYnTHix3XxuIdh
 CLa7YNXieoKzxyNI69zTga5BeVIp2nuN6JUkyNZVDF48paS3Z97GcqjEXS4SbkETaMrcC7oCiPtz7
 ebga12ePId6FrnHzkZ06/ly0HjW7/bElp6nlinv8nqqvH/e7fLXCA9LkJfD50awg4CtQOX9My32fH
 tAIxb96w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jmHW8-0000yl-Di; Fri, 19 Jun 2020 13:57:16 +0000
Date: Fri, 19 Jun 2020 06:57:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jianyong Wu <jianyong.wu@arm.com>
Subject: Re: [PATCH v13 3/9] smccc: Export smccc conduit get helper.
Message-ID: <20200619135716.GA14308@infradead.org>
References: <20200619130120.40556-1-jianyong.wu@arm.com>
 <20200619130120.40556-4-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619130120.40556-4-jianyong.wu@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: maz@kernel.org, justin.he@arm.com, kvm@vger.kernel.org, Wei.Chen@arm.com,
 netdev@vger.kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 sean.j.christopherson@intel.com, steven.price@arm.com, john.stultz@linaro.org,
 yangbo.lu@nxp.com, pbonzini@redhat.com, tglx@linutronix.de, nd@arm.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Fri, Jun 19, 2020 at 09:01:14PM +0800, Jianyong Wu wrote:
> Export arm_smccc_1_1_get_conduit then modules can use smccc helper which
> adopts it.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  drivers/firmware/smccc/smccc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> index 4e80921ee212..b855fe7b5c90 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -24,6 +24,7 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
>  
>  	return smccc_conduit;
>  }
> +EXPORT_SYMBOL(arm_smccc_1_1_get_conduit);

EXPORT_SYMBOL_GPL, please.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
