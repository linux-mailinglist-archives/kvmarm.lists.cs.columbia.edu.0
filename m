Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DA84317A19D
	for <lists+kvmarm@lfdr.de>; Thu,  5 Mar 2020 09:45:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F07E4A541;
	Thu,  5 Mar 2020 03:45:04 -0500 (EST)
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
	with ESMTP id Gbno2SP5DoDu; Thu,  5 Mar 2020 03:45:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7331E4AEB2;
	Thu,  5 Mar 2020 03:45:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F1F54AE9F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Mar 2020 03:45:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAmXLEBwR9zB for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Mar 2020 03:45:01 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C2324A541
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Mar 2020 03:45:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sdxw0YGoXsaIv0ZpropG02ysIrWI8wiKoZ0OhhrAhk=;
 b=WXp7oT71AJ8Z4DP+8ofRKkSC0Uoa6SUNnA7IVOUx3tq/nafWqR4+hlona5TeF2T60UWArB
 gOMmWczXymg9RTXhQz8ko8PhHD7xCGvhNSa6QvSGPDKHdykofakhZ1xYuvNOYc+2CHjdbm
 HeSBMDq6sfRemVKfZeFubaUX7ySYoFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-lHqpbisRPi2TOCAtFQhntg-1; Thu, 05 Mar 2020 03:44:57 -0500
X-MC-Unique: lHqpbisRPi2TOCAtFQhntg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 715FD107B7E7;
 Thu,  5 Mar 2020 08:44:55 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-110.brq.redhat.com
 [10.40.204.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6414691D8C;
 Thu,  5 Mar 2020 08:44:46 +0000 (UTC)
Date: Thu, 5 Mar 2020 09:44:44 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/9] arm: pmu: Let pmu tests take a
 sub-test parameter
Message-ID: <20200305084444.jh5jr4hbuecfae73@kamzik.brq.redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130112510.15154-3-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andre.przywara@arm.com, andrew.murray@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Thu, Jan 30, 2020 at 12:25:03PM +0100, Eric Auger wrote:
> As we intend to introduce more PMU tests, let's add
> a sub-test parameter that will allow to categorize
> them. Existing tests are in the cycle-counter category.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arm/pmu.c         | 24 +++++++++++++++---------
>  arm/unittests.cfg |  7 ++++---
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index d5a03a6..e5e012d 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -287,22 +287,28 @@ int main(int argc, char *argv[])
>  {
>  	int cpi = 0;
>  
> -	if (argc > 1)
> -		cpi = atol(argv[1]);
> -
>  	if (!pmu_probe()) {
>  		printf("No PMU found, test skipped...\n");
>  		return report_summary();
>  	}
>  
> +	if (argc < 2)
> +		report_abort("no test specified");
> +
>  	report_prefix_push("pmu");
>  
> -	report(check_pmcr(), "Control register");
> -	report(check_cycles_increase(),
> -	       "Monotonically increasing cycle count");
> -	report(check_cpi(cpi), "Cycle/instruction ratio");
> -
> -	pmccntr64_test();
> +	if (strcmp(argv[1], "cycle-counter") == 0) {
> +		report_prefix_push(argv[1]);
> +		if (argc > 2)
> +			cpi = atol(argv[2]);
> +		report(check_pmcr(), "Control register");
> +		report(check_cycles_increase(),
> +		       "Monotonically increasing cycle count");
> +		report(check_cpi(cpi), "Cycle/instruction ratio");
> +		pmccntr64_test();

Could put a report_prefix_pop here to balance things.

> +	} else {
> +		report_abort("Unknown sub-test '%s'", argv[1]);
> +	}
>  
>  	return report_summary();
>  }
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index daeb5a0..79f0d7a 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -61,21 +61,22 @@ file = pci-test.flat
>  groups = pci
>  
>  # Test PMU support
> -[pmu]
> +[pmu-cycle-counter]
>  file = pmu.flat
>  groups = pmu
> +extra_params = -append 'cycle-counter 0'
>  
>  # Test PMU support (TCG) with -icount IPC=1
>  #[pmu-tcg-icount-1]
>  #file = pmu.flat
> -#extra_params = -icount 0 -append '1'
> +#extra_params = -icount 0 -append 'cycle-counter 1'
>  #groups = pmu
>  #accel = tcg
>  
>  # Test PMU support (TCG) with -icount IPC=256
>  #[pmu-tcg-icount-256]
>  #file = pmu.flat
> -#extra_params = -icount 8 -append '256'
> +#extra_params = -icount 8 -append 'cycle-counter 256'
>  #groups = pmu
>  #accel = tcg
>  
> -- 
> 2.20.1
> 
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
