Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F11BC30DA65
	for <lists+kvmarm@lfdr.de>; Wed,  3 Feb 2021 13:59:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5E244B1A8;
	Wed,  3 Feb 2021 07:59:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBxLee-AF7SF; Wed,  3 Feb 2021 07:59:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 791E64B1FC;
	Wed,  3 Feb 2021 07:59:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CE434B17C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 07:59:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bb709bNS-HyX for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Feb 2021 07:59:30 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8AA1D4B1FC
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 07:59:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612357170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYb4OGzNQZv0lI1Md7SNJMIqcjDngUeaMmZcgMWB/wI=;
 b=HwUkydXlK2uvF/ulbRIcrcFVJ1hLzBeg2+315vzlgWaM79BY3Cg/jaHpdcM77DVr5EYhoU
 D/iDrRSfloNHdhtbd6if5cl4ZdDeYRdDMwxU9p/PHupYHcLdtSG+VxPh66APj2q+QZX7BS
 wXINYD76EnSWjBTUi8mPt86fatr63Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-KExexx4pO4aqvrcfRpC5Cg-1; Wed, 03 Feb 2021 07:59:23 -0500
X-MC-Unique: KExexx4pO4aqvrcfRpC5Cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BA2DDF8C4;
 Wed,  3 Feb 2021 12:59:19 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24E251E2;
 Wed,  3 Feb 2021 12:59:17 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v3 02/11] lib: arm/arm64: gicv2: Document
 existing barriers when sending IPIs
To: Alexandru Elisei <alexandru.elisei@arm.com>, drjones@redhat.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20210129163647.91564-1-alexandru.elisei@arm.com>
 <20210129163647.91564-3-alexandru.elisei@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d05e1437-aff3-5e6b-a7d8-ac77030adf2f@redhat.com>
Date: Wed, 3 Feb 2021 13:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210129163647.91564-3-alexandru.elisei@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: andre.przywara@arm.com
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

Hi Alexandru,

On 1/29/21 5:36 PM, Alexandru Elisei wrote:
> GICv2 generates IPIs with a MMIO write to the GICD_SGIR register. A common
> pattern for IPI usage is for the IPI receiver to read data written to
> memory by the sender. The armv7 and armv8 architectures implement a
> weakly-ordered memory model, which means that barriers are required to make
> sure that the expected values are observed.
> 
> Because the receiver CPU must observe the write to memory that generated
> the IPI when reading the GICC_IAR MMIO register, we only need to ensure
> ordering of memory accesses, and not completion. The same pattern can be
> observed in the Linux GICv2 irqchip driver (more details in commit
> 8adbf57fc429 ("irqchip: gic: use dmb ishst instead of dsb when raising a
> softirq")).
> 
> However, it turns out that no changes are needed to the way GICv2 sends
> IPIs because of the implicit barriers in the MMIO writel and readl
> functions. Writel executes a wmb() (DST ST) before the MMIO write, and
> readl executes a rmb() (DST LD) after the MMIO read. According to  ARM DDI
> 0406C.d and ARM DDI 0487F.b, the DSB instruction:
> 
> "[..] acts as a stronger barrier than a DMB and all ordering that is
> created by a DMB with specific options is also generated by a DSB with the
> same options."
> 
> which means that the correct memory ordering is enforced.
> 
> It's not immediately obvious that the proper barriers are in place, so add
> a comment explaining that correct memory synchronization is implemented.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  lib/arm/gic-v2.c | 6 ++++++
>  arm/gic.c        | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/lib/arm/gic-v2.c b/lib/arm/gic-v2.c
> index dc6a97c600ec..786d6a4e4c6e 100644
> --- a/lib/arm/gic-v2.c
> +++ b/lib/arm/gic-v2.c
> @@ -45,6 +45,11 @@ void gicv2_ipi_send_single(int irq, int cpu)
>  {
>  	assert(cpu < 8);
>  	assert(irq < 16);
> +	/*
> +	 * The wmb() in writel and rmb() in readl() from gicv2_read_iar() are
> +	 * sufficient for ensuring that stores that happen in program order
> +	 * before the IPI will be visible after the interrupt is acknowledged.
> +	 */
>  	writel(1 << (cpu + 16) | irq, gicv2_dist_base() + GICD_SGIR);
>  }
>  
> @@ -53,5 +58,6 @@ void gicv2_ipi_send_mask(int irq, const cpumask_t *dest)
>  	u8 tlist = (u8)cpumask_bits(dest)[0];
>  
>  	assert(irq < 16);
> +	/* No barriers needed, same situation as gicv2_ipi_send_single() */
>  	writel(tlist << 16 | irq, gicv2_dist_base() + GICD_SGIR);
>  }
> diff --git a/arm/gic.c b/arm/gic.c
> index fee48f9b4ccb..e2e053aeb823 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -260,11 +260,18 @@ static void check_lpi_hits(int *expected, const char *msg)
>  
>  static void gicv2_ipi_send_self(void)
>  {
> +	/*
> +	 * The wmb() in writel and rmb() when acknowledging the interrupt are
> +	 * sufficient for ensuring that writes that happen in program order
> +	 * before the interrupt are observed in the interrupt handler after
> +	 * acknowledging the interrupt.
> +	 */
>  	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
>  }
>  
>  static void gicv2_ipi_send_broadcast(void)
>  {
> +	/* No barriers are needed, same situation as gicv2_ipi_send_self() */
>  	writel(1 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
>  }
>  
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
