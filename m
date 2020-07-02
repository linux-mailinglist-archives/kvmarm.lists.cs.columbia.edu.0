Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 243F2211B88
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 07:26:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 929324B527;
	Thu,  2 Jul 2020 01:26:09 -0400 (EDT)
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
	with ESMTP id qzHss3QWmFIk; Thu,  2 Jul 2020 01:26:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6EFCC4B567;
	Thu,  2 Jul 2020 01:26:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 226EB4B567
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 01:26:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4aR7qPUER1Y for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 01:26:06 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 32E054B566
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 01:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593667565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnUTCTY6NdGdbPB6aBT0lOt3P76ysCTotJmS6UnYM1o=;
 b=PDYgSl9tQZ7ISVQRruaK4l09yIPAH9FQd5VDcKZ8qEN5xslarmJILBM1WixVNZCljsHL78
 3TA0B2wzaW6roBa+4wQIczjM/8MgmCvva+gYQ5D2cGatZE096uunf1zqPPgRjzetfJt8ou
 UX8L6x8FfevGcxRxRSqblcsynC2yW2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238--_ef87yQOQayjnuKQTEXnw-1; Thu, 02 Jul 2020 01:26:03 -0400
X-MC-Unique: -_ef87yQOQayjnuKQTEXnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18141800C60;
 Thu,  2 Jul 2020 05:26:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 256F1500DE;
 Thu,  2 Jul 2020 05:25:56 +0000 (UTC)
Date: Thu, 2 Jul 2020 07:25:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/8] arm64: microbench: Use the
 funcions for ipi test as the general functions for gic(ipi/lpi/timer) test
Message-ID: <20200702052554.2be22pr3wa2nximf@kamzik.brq.redhat.com>
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-3-wangjingyi11@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702030132.20252-3-wangjingyi11@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu
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


Hi Jingyi,

This patch has quite a long summary. How about instead of

 arm64: microbench: Use the funcions for ipi test as the general functions for gic(ipi/lpi/timer) test

we use

 arm64: microbench: Generalize ipi test names

and then in the commit message, instead of

 The following patches will use that.

we use

 Later patches will use these functions for gic(ipi/lpi/timer) tests.

Thanks,
drew

On Thu, Jul 02, 2020 at 11:01:26AM +0800, Jingyi Wang wrote:
> The following patches will use that.
> 
> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
> ---
>  arm/micro-bench.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/arm/micro-bench.c b/arm/micro-bench.c
> index 794dfac..fc4d356 100644
> --- a/arm/micro-bench.c
> +++ b/arm/micro-bench.c
> @@ -25,24 +25,24 @@
>  
>  static u32 cntfrq;
>  
> -static volatile bool ipi_ready, ipi_received;
> +static volatile bool irq_ready, irq_received;
>  static void *vgic_dist_base;
>  static void (*write_eoir)(u32 irqstat);
>  
> -static void ipi_irq_handler(struct pt_regs *regs)
> +static void gic_irq_handler(struct pt_regs *regs)
>  {
> -	ipi_ready = false;
> -	ipi_received = true;
> +	irq_ready = false;
> +	irq_received = true;
>  	gic_write_eoir(gic_read_iar());
> -	ipi_ready = true;
> +	irq_ready = true;
>  }
>  
> -static void ipi_secondary_entry(void *data)
> +static void gic_secondary_entry(void *data)
>  {
> -	install_irq_handler(EL1H_IRQ, ipi_irq_handler);
> +	install_irq_handler(EL1H_IRQ, gic_irq_handler);
>  	gic_enable_defaults();
>  	local_irq_enable();
> -	ipi_ready = true;
> +	irq_ready = true;
>  	while (true)
>  		cpu_relax();
>  }
> @@ -72,9 +72,9 @@ static bool test_init(void)
>  		break;
>  	}
>  
> -	ipi_ready = false;
> +	irq_ready = false;
>  	gic_enable_defaults();
> -	on_cpu_async(1, ipi_secondary_entry, NULL);
> +	on_cpu_async(1, gic_secondary_entry, NULL);
>  
>  	cntfrq = get_cntfrq();
>  	printf("Timer Frequency %d Hz (Output in microseconds)\n", cntfrq);
> @@ -82,13 +82,18 @@ static bool test_init(void)
>  	return true;
>  }
>  
> -static void ipi_prep(void)
> +static void gic_prep_common(void)
>  {
>  	unsigned tries = 1 << 28;
>  
> -	while (!ipi_ready && tries--)
> +	while (!irq_ready && tries--)
>  		cpu_relax();
> -	assert(ipi_ready);
> +	assert(irq_ready);
> +}
> +
> +static void ipi_prep(void)
> +{
> +	gic_prep_common();
>  }
>  
>  static void ipi_exec(void)
> @@ -96,17 +101,17 @@ static void ipi_exec(void)
>  	unsigned tries = 1 << 28;
>  	static int received = 0;
>  
> -	ipi_received = false;
> +	irq_received = false;
>  
>  	gic_ipi_send_single(1, 1);
>  
> -	while (!ipi_received && tries--)
> +	while (!irq_received && tries--)
>  		cpu_relax();
>  
> -	if (ipi_received)
> +	if (irq_received)
>  		++received;
>  
> -	assert_msg(ipi_received, "failed to receive IPI in time, but received %d successfully\n", received);
> +	assert_msg(irq_received, "failed to receive IPI in time, but received %d successfully\n", received);
>  }
>  
>  static void hvc_exec(void)
> -- 
> 2.19.1
> 
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
