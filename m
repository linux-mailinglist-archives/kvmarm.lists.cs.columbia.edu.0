Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5242353AD
	for <lists+kvmarm@lfdr.de>; Sat,  1 Aug 2020 19:04:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AAFB4B4DC;
	Sat,  1 Aug 2020 13:04:17 -0400 (EDT)
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
	with ESMTP id kZaJMMUPhCD2; Sat,  1 Aug 2020 13:04:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 000914B433;
	Sat,  1 Aug 2020 13:04:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D81F4B3F6
 for <kvmarm@lists.cs.columbia.edu>; Sat,  1 Aug 2020 13:04:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sJtdEh1oX1no for <kvmarm@lists.cs.columbia.edu>;
 Sat,  1 Aug 2020 13:04:13 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6831A4B2C0
 for <kvmarm@lists.cs.columbia.edu>; Sat,  1 Aug 2020 13:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596301453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QsrjT3m/cS0R8xhUxQWXL9zbvh+KePTUILKh1tbTf+0=;
 b=I/ThzrTdhlqfU5+wslPbpKiPVfMk8ke+hLfZW7/3h+lOjVqckSh0fLqQCPp7kTjGs32JQc
 e/dAeM4ncky8mnXbVeYIbr1rB8x5rWmzrWlz8MMktLXIqROEMf8Zd/h1XX2xygdDaXU0EN
 uN9d/ZnfQTB2KXF0433ABR8gn4Hhwus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-jBrLKcuqNYq0qj08X6G_bQ-1; Sat, 01 Aug 2020 13:04:09 -0400
X-MC-Unique: jBrLKcuqNYq0qj08X6G_bQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85E8F107ACCA;
 Sat,  1 Aug 2020 17:04:07 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98CE287B2C;
 Sat,  1 Aug 2020 17:04:01 +0000 (UTC)
Date: Sat, 1 Aug 2020 19:03:58 +0200
From: Andrew Jones <drjones@redhat.com>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [kvm-unit-tests PATCH v3 09/10] arm64: microbench: Add
 test->post() to further process test results
Message-ID: <20200801170358.lt3ssgmj5455rwt4@kamzik.brq.redhat.com>
References: <20200731074244.20432-1-wangjingyi11@huawei.com>
 <20200731074244.20432-10-wangjingyi11@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200731074244.20432-10-wangjingyi11@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvm@vger.kernel.org, maz@kernel.org, prime.zeng@hisilicon.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Fri, Jul 31, 2020 at 03:42:43PM +0800, Jingyi Wang wrote:
> Under certain circumstances, we need to further process microbench
> test results, so we add test->post() in the microbench framework,
> later patch will use that.
> 
> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
> ---
>  arm/micro-bench.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/arm/micro-bench.c b/arm/micro-bench.c
> index 1e1bde5..4680ba4 100644
> --- a/arm/micro-bench.c
> +++ b/arm/micro-bench.c
> @@ -33,6 +33,12 @@ static int nr_ipi_received;
>  static void *vgic_dist_base;
>  static void (*write_eoir)(u32 irqstat);
>  
> +struct ns_time {
> +	uint64_t ns;
> +	uint64_t ns_frac;
> +};

Missing blank line

> +static void ticks_to_ns_time(uint64_t ticks, struct ns_time *ns_time);

You could have moved the whole function up here.

> +
>  static void gic_irq_handler(struct pt_regs *regs)
>  {
>  	u32 irqstat = gic_read_iar();
> @@ -283,24 +289,20 @@ struct exit_test {
>  	const char *name;
>  	bool (*prep)(void);
>  	void (*exec)(void);
> +	void (*post)(uint64_t, uint64_t, struct ns_time*);
>  	u32 times;
>  	bool run;
>  };
>  
>  static struct exit_test tests[] = {
> -	{"hvc",			NULL,		hvc_exec,		65536,		true},
> -	{"mmio_read_user",	NULL,		mmio_read_user_exec,	65536,		true},
> -	{"mmio_read_vgic",	NULL,		mmio_read_vgic_exec,	65536,		true},
> -	{"eoi",			NULL,		eoi_exec,		65536,		true},
> -	{"ipi",			ipi_prep,	ipi_exec,		65536,		true},
> -	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		65536,		true},
> -	{"lpi",			lpi_prep,	lpi_exec,		65536,		true},
> -	{"timer_10ms",		timer_prep,	timer_exec,		256,		true},
> -};
> -
> -struct ns_time {
> -	uint64_t ns;
> -	uint64_t ns_frac;
> +	{"hvc",			NULL,		hvc_exec,		NULL,		65536,		true},
> +	{"mmio_read_user",	NULL,		mmio_read_user_exec,	NULL,		65536,		true},
> +	{"mmio_read_vgic",	NULL,		mmio_read_vgic_exec,	NULL,		65536,		true},
> +	{"eoi",			NULL,		eoi_exec,		NULL,		65536,		true},
> +	{"ipi",			ipi_prep,	ipi_exec,		NULL,		65536,		true},
> +	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		NULL,		65536,		true},
> +	{"lpi",			lpi_prep,	lpi_exec,		NULL,		65536,		true},
> +	{"timer_10ms",		timer_prep,	timer_exec,		NULL,		256,		true},
>  };
>  
>  #define PS_PER_SEC (1000 * 1000 * 1000 * 1000UL)
> @@ -339,6 +341,9 @@ static void loop_test(struct exit_test *test)
>  		ticks_to_ns_time(total_ticks, &total_ns);
>  	}
>  
> +	if (test->post)
> +		test->post(total_ticks, ntimes, &total_ns);
> +

We can drop the ns_time structure and pass total_ticks by reference.

>  	avg_ns.ns = total_ns.ns / ntimes;
>  	avg_ns.ns_frac = total_ns.ns_frac / ntimes;
>  
> -- 
> 2.19.1
> 
>

I can do these changes myself.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
