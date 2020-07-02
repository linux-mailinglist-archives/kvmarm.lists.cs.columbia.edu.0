Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0D708211BAE
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 07:49:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 917934B5A9;
	Thu,  2 Jul 2020 01:49:14 -0400 (EDT)
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
	with ESMTP id 60nVfI85c61E; Thu,  2 Jul 2020 01:49:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 811264B5A8;
	Thu,  2 Jul 2020 01:49:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CAE9D4B5A1
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 01:49:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E2JcgitIApvM for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 01:49:11 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DA604B585
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 01:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593668950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GZAg2Io3Q7SYAgResIvDsfg0aFeRm2F9NAfnTUY5zeY=;
 b=B2sAk4HhkWpM8X48XqzxUY+vrLUnk0TIOabGLgyMMcz8Ikeg2XxPYX8D3gR46M/iPY8t6Q
 e3EeWr8REDnzJ2kOq0PR8i5WVbmQfyWMs/Z0MIfeXa/VWaJa+gIPOQ/4Js0moO67DL0Q4C
 bxwtRhmsi+r4VJRyKe2R/KDtPOKcf0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-FpB1nrgqPoSUbIwQrHZ44Q-1; Thu, 02 Jul 2020 01:49:07 -0400
X-MC-Unique: FpB1nrgqPoSUbIwQrHZ44Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3B791902EA1;
 Thu,  2 Jul 2020 05:49:05 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43AAA60CD3;
 Thu,  2 Jul 2020 05:49:00 +0000 (UTC)
Date: Thu, 2 Jul 2020 07:48:57 +0200
From: Andrew Jones <drjones@redhat.com>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [kvm-unit-tests PATCH v2 7/8] arm64: microbench: Add time limit
 for each individual test
Message-ID: <20200702054857.qcmaaproewgzzljf@kamzik.brq.redhat.com>
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-8-wangjingyi11@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702030132.20252-8-wangjingyi11@huawei.com>
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

On Thu, Jul 02, 2020 at 11:01:31AM +0800, Jingyi Wang wrote:
> Besides using separate running times parameter, we add time limit
> for loop_test to make sure each test should be done in a certain
> time(5 sec here).
> 
> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
> ---
>  arm/micro-bench.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arm/micro-bench.c b/arm/micro-bench.c
> index 506d2f9..4c962b7 100644
> --- a/arm/micro-bench.c
> +++ b/arm/micro-bench.c
> @@ -23,6 +23,7 @@
>  #include <asm/gic-v3-its.h>
>  
>  #define NTIMES (1U << 16)
> +#define MAX_NS (5 * 1000 * 1000 * 1000UL)

How about naming this something like "NS_5_SECONDS"?

>  
>  static u32 cntfrq;
>  
> @@ -258,22 +259,26 @@ static void loop_test(struct exit_test *test)
>  	uint64_t start, end, total_ticks, ntimes = 0;
>  	struct ns_time total_ns, avg_ns;
>  
> +	total_ticks = 0;
>  	if (test->prep) {
>  		if(!test->prep()) {
>  			printf("%s test skipped\n", test->name);
>  			return;
>  		}
>  	}
> -	isb();
> -	start = read_sysreg(cntpct_el0);
> -	while (ntimes < test->times) {
> +
> +	while (ntimes < test->times && total_ns.ns < MAX_NS) {
> +		isb();
> +		start = read_sysreg(cntpct_el0);
>  		test->exec();
> +		isb();
> +		end = read_sysreg(cntpct_el0);
> +
>  		ntimes++;
> +		total_ticks += (end - start);
> +		ticks_to_ns_time(total_ticks, &total_ns);
>  	}
> -	isb();
> -	end = read_sysreg(cntpct_el0);
>  
> -	total_ticks = end - start;
>  	ticks_to_ns_time(total_ticks, &total_ns);
>  	avg_ns.ns = total_ns.ns / ntimes;
>  	avg_ns.ns_frac = total_ns.ns_frac / ntimes;
> -- 
> 2.19.1
> 
>

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
