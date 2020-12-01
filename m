Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86A562CA85B
	for <lists+kvmarm@lfdr.de>; Tue,  1 Dec 2020 17:37:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D6B34C29D;
	Tue,  1 Dec 2020 11:37:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tLQ3+0OcI7e3; Tue,  1 Dec 2020 11:37:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1704A4C2A2;
	Tue,  1 Dec 2020 11:37:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 52B6F4C280
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Dec 2020 11:37:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ul86TbPwBe+T for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Dec 2020 11:37:28 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 501A24C26F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Dec 2020 11:37:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606840648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpBs9mPfQY/Y6YG1SnjzpoLm9H2ON4qVGVd4AW6Gr+8=;
 b=R9ydyykoqFg+KwO+jKB67I71+IecevK9HC/kPM0u1QQPQs0OG0OxQ7pAuXC328w2S8YIv6
 6UuuzxdTWyDwsXia/L/2cW/bZ7u4YJDGSgUmGRGXZ0GA0gZHKJ/U/FI6uOPPKWJKOw+/jP
 Bx8qHtzD/9h2EHcvts0abGW6/Cg7evU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-1aC_QL5uMQKCycas9M2fJw-1; Tue, 01 Dec 2020 11:37:24 -0500
X-MC-Unique: 1aC_QL5uMQKCycas9M2fJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0171D8030CD;
 Tue,  1 Dec 2020 16:37:23 +0000 (UTC)
Received: from [10.36.112.89] (ovpn-112-89.ams2.redhat.com [10.36.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB5C713470;
 Tue,  1 Dec 2020 16:37:21 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 01/10] lib: arm/arm64: gicv3: Add missing
 barrier when sending IPIs
To: Alexandru Elisei <alexandru.elisei@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, drjones@redhat.com
References: <20201125155113.192079-1-alexandru.elisei@arm.com>
 <20201125155113.192079-2-alexandru.elisei@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c92e0793-d204-0a84-2f6e-8cbd6c455da2@redhat.com>
Date: Tue, 1 Dec 2020 17:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201125155113.192079-2-alexandru.elisei@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On 11/25/20 4:51 PM, Alexandru Elisei wrote:
> One common usage for IPIs is for one CPU to write to a shared memory
> location, send the IPI to kick another CPU, and the receiver to read from
> the same location. Proper synchronization is needed to make sure that the
> IPI receiver reads the most recent value and not stale data (for example,
> the write from the sender CPU might still be in a store buffer).
> 
> For GICv3, IPIs are generated with a write to the ICC_SGI1R_EL1 register.
> To make sure the memory stores are observable by other CPUs, we need a
> wmb() barrier (DSB ST), which waits for stores to complete.
> 
> From the definition of DSB from ARM DDI 0487F.b, page B2-139:
> 
> "In addition, no instruction that appears in program order after the DSB
> instruction can alter any state of the system or perform any part of its
> functionality until the DSB completes other than:
> 
> - Being fetched from memory and decoded.
> - Reading the general-purpose, SIMD and floating-point, Special-purpose, or
> System registers that are directly or indirectly read without causing
> side-effects."
> 
> Similar definition for armv7 (ARM DDI 0406C.d, page A3-150).
> 
> The DSB instruction is enough to prevent reordering of the GIC register
> write which comes in program order after the memory access.
> 
> This also matches what the Linux GICv3 irqchip driver does (commit
> 21ec30c0ef52 ("irqchip/gic-v3: Use wmb() instead of smb_wmb() in
> gic_raise_softirq()")).
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

> ---
>  lib/arm/gic-v3.c | 3 +++
>  arm/gic.c        | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
> index a7e2cb819746..a6afa42d5fbe 100644
> --- a/lib/arm/gic-v3.c
> +++ b/lib/arm/gic-v3.c
> @@ -77,6 +77,9 @@ void gicv3_ipi_send_mask(int irq, const cpumask_t *dest)
>  
>  	assert(irq < 16);
>  
> +	/* Ensure stores are visible to other CPUs before sending the IPI */
nit: stores to normal memory ...
> +	wmb();
> +
>  	/*
>  	 * For each cpu in the mask collect its peers, which are also in
>  	 * the mask, in order to form target lists.
> diff --git a/arm/gic.c b/arm/gic.c
> index acb060585fae..512c83636a2e 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -275,6 +275,8 @@ static void gicv3_ipi_send_self(void)
>  
>  static void gicv3_ipi_send_broadcast(void)
>  {
> +	/* Ensure stores are visible to other CPUs before sending the IPI */
same
> +	wmb();
>  	gicv3_write_sgi1r(1ULL << 40 | IPI_IRQ << 24);
>  	isb();
>  }
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
