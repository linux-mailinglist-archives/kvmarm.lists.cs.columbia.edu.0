Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 611743C5E21
	for <lists+kvmarm@lfdr.de>; Mon, 12 Jul 2021 16:16:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D3C3049F83;
	Mon, 12 Jul 2021 10:16:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4QKsvCjy8x9O; Mon, 12 Jul 2021 10:16:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0ECD4086F;
	Mon, 12 Jul 2021 10:16:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 18AC040821
 for <kvmarm@lists.cs.columbia.edu>; Mon, 12 Jul 2021 10:16:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxSKBRSSU1m5 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 12 Jul 2021 10:16:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E40E6407ED
 for <kvmarm@lists.cs.columbia.edu>; Mon, 12 Jul 2021 10:16:14 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1603610CB;
 Mon, 12 Jul 2021 14:16:13 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m2wjD-00Cqee-Qq; Mon, 12 Jul 2021 15:16:11 +0100
MIME-Version: 1.0
Date: Mon, 12 Jul 2021 15:16:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: John Gong <johngong0791@163.com>
Subject: Re: [PATCH] KVM/ARM: vgic: Delete the redundant lines of code
In-Reply-To: <20210712124933.1153992-1-johngong0791@163.com>
References: <20210712124933.1153992-1-johngong0791@163.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a97545a9e80c6799507a9f9d93817625@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: johngong0791@163.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu
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

On 2021-07-12 13:49, John Gong wrote:
> delete redundant lines of code
> 
> Signed-off-by: John Gong <johngong0791@163.com>
> ---
>  arch/arm64/kvm/vgic/vgic-mmio.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c 
> b/arch/arm64/kvm/vgic/vgic-mmio.c
> index 48c6067fc5ec..19cf661c451e 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio.c
> @@ -1004,8 +1004,6 @@ static int dispatch_mmio_read(struct kvm_vcpu
> *vcpu, struct kvm_io_device *dev,
> 
>  	switch (iodev->iodev_type) {
>  	case IODEV_CPUIF:
> -		data = region->read(vcpu, addr, len);
> -		break;
>  	case IODEV_DIST:
>  		data = region->read(vcpu, addr, len);
>  		break;

I'm not overly keen on this. Why isn't the write path treated the same 
way?

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
