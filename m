Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF3C051A
	for <lists+kvmarm@lfdr.de>; Fri, 27 Sep 2019 14:25:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A8C094A75E;
	Fri, 27 Sep 2019 08:25:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4SDnSehhfzT; Fri, 27 Sep 2019 08:25:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A05904A778;
	Fri, 27 Sep 2019 08:25:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05F8A4A771
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 08:25:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 575fqq5d6tPU for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Sep 2019 08:25:45 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1AA744A770
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 08:25:45 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 85D023067319;
 Fri, 27 Sep 2019 12:25:44 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 896D060C44;
 Fri, 27 Sep 2019 12:25:43 +0000 (UTC)
Date: Fri, 27 Sep 2019 14:25:41 +0200
From: Andrew Jones <drjones@redhat.com>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [kvm-unit-tests PATCH 3/6] arm: timer: Split variable output
 data from test name
Message-ID: <20190927122541.gci5duthtetiwjo4@kamzik.brq.redhat.com>
References: <20190927104227.253466-1-andre.przywara@arm.com>
 <20190927104227.253466-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190927104227.253466-4-andre.przywara@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 27 Sep 2019 12:25:44 +0000 (UTC)
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

On Fri, Sep 27, 2019 at 11:42:24AM +0100, Andre Przywara wrote:
> For some tests we mix variable diagnostic output with the test name,
> which leads to variable test line, confusing some higher level
> frameworks.
> 
> Split the output to always use the same test name for a certain test,
> and put diagnostic output on a separate line using the INFO: tag.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/timer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/timer.c b/arm/timer.c
> index f2f6019..0b808d5 100644
> --- a/arm/timer.c
> +++ b/arm/timer.c
> @@ -249,7 +249,8 @@ static void test_timer(struct timer_info *info)
>  	local_irq_enable();
>  	left = info->read_tval();
>  	report("interrupt received after TVAL/WFI", info->irq_received);
> -	report("timer has expired (%d)", left < 0, left);
> +	report("timer has expired", left < 0);
> +	report_info("TVAL is %d ticks", left);
>  }
>  
>  static void test_vtimer(void)
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
