Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9221244D
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 15:13:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EF944B602;
	Thu,  2 Jul 2020 09:13:29 -0400 (EDT)
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
	with ESMTP id XLbqCDmYD54k; Thu,  2 Jul 2020 09:13:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C8144B605;
	Thu,  2 Jul 2020 09:13:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7548C4B5F2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:13:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xC2qEHXCkaO for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 09:13:26 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 985DE4B5CC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:13:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593695606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDq3YFC4R5tSKIwncV0+1iQLp6whE45MANKxnMI+EnE=;
 b=OTwyfk0eHvO+ax9j/NbX7kDw81t1nR7ggsWQL1B36FS1V+qMl509F4zVZNMeqG6VM6bvhY
 BK1VwmA/taEqld+7FlCD7EAK1aaAjEtjWXv6/jXsf2Dy5lH3gBGfH81O3uq2tgxGiJNTcU
 s9MS9ch/Wb2D9YmcuOvcO3AkaFNpZZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-xoRsjDBrN_mVNVg8YAEV2w-1; Thu, 02 Jul 2020 09:13:24 -0400
X-MC-Unique: xoRsjDBrN_mVNVg8YAEV2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DDFE1054F8F;
 Thu,  2 Jul 2020 13:13:23 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55EB560CD1;
 Thu,  2 Jul 2020 13:13:21 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 5/8] arm64: microbench: its: Add LPI
 latency test
To: Jingyi Wang <wangjingyi11@huawei.com>, drjones@redhat.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-6-wangjingyi11@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2e682906-8b0b-9f5c-31af-8067139c680d@redhat.com>
Date: Thu, 2 Jul 2020 15:13:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702030132.20252-6-wangjingyi11@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: maz@kernel.org
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
On 7/2/20 5:01 AM, Jingyi Wang wrote:
> Triggers LPIs through the INT command and test the latency.
> Mostly inherited form commit 0ef02cd6cbaa(arm/arm64: ITS: INT
> functional tests).
> 
> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
> ---
>  arm/micro-bench.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arm/micro-bench.c b/arm/micro-bench.c
> index 80d8db3..aeb60a7 100644
> --- a/arm/micro-bench.c
> +++ b/arm/micro-bench.c
> @@ -20,6 +20,7 @@
>   */
>  #include <libcflat.h>
>  #include <asm/gic.h>
> +#include <asm/gic-v3-its.h>
>  
>  #define NTIMES (1U << 16)
>  
> @@ -145,6 +146,48 @@ static void ipi_exec(void)
>  	assert_msg(irq_received, "failed to receive IPI in time, but received %d successfully\n", received);
>  }
>  
> +static bool lpi_prep(void)
> +{
> +	struct its_collection *col1;
> +	struct its_device *dev2;
> +
> +	if (!gicv3_its_base())
> +		return false;
> +
> +	its_enable_defaults();
> +	dev2 = its_create_device(2 /* dev id */, 8 /* nb_ites */);
> +	col1 = its_create_collection(1 /* col id */, 1 /* target PE */);
> +	gicv3_lpi_set_config(8199, LPI_PROP_DEFAULT);
> +
> +	its_send_mapd_nv(dev2, true);
> +	its_send_mapc_nv(col1, true);
> +	its_send_invall_nv(col1);
> +	its_send_mapti_nv(dev2, 8199 /* lpi id */, 20 /* event id */, col1);
> +
> +	gic_prep_common();
> +	return true;
> +}
> +
> +static void lpi_exec(void)
> +{
> +	struct its_device *dev2;
> +	unsigned tries = 1 << 28;
> +	static int received = 0;
> +
> +	irq_received = false;
> +
> +	dev2 = its_get_device(2);
> +	its_send_int_nv(dev2, 20);
> +
> +	while (!irq_received && tries--)
> +		cpu_relax();
> +
> +	if (irq_received)
> +		++received;
> +
> +	assert_msg(irq_received, "failed to receive LPI in time, but received %d successfully\n", received);
> +}
> +
>  static void hvc_exec(void)
>  {
>  	asm volatile("mov w0, #0x4b000000; hvc #0" ::: "w0");
> @@ -190,6 +233,7 @@ static struct exit_test tests[] = {
>  	{"eoi",			NULL,		eoi_exec,		true},
>  	{"ipi",			ipi_prep,	ipi_exec,		true},
>  	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		true},
> +	{"lpi",			lpi_prep,	lpi_exec,		true},
>  };
>  
>  struct ns_time {
> 
Looks good to me (w/wo the lpi_prep returned value change)

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
