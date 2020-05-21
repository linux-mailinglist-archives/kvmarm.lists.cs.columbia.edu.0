Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 861DE1DCED4
	for <lists+kvmarm@lfdr.de>; Thu, 21 May 2020 16:01:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0319B4B121;
	Thu, 21 May 2020 10:01:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id asAmx4pgSB2n; Thu, 21 May 2020 10:01:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DEFB34B170;
	Thu, 21 May 2020 10:01:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 516C24B165
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 May 2020 10:01:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amy944gNHa6t for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 May 2020 10:01:06 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D5CE04B121
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 May 2020 10:01:05 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B5FDEB054420817EE0C8;
 Thu, 21 May 2020 22:01:02 +0800 (CST)
Received: from [10.173.222.27] (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 22:00:54 +0800
Subject: Re: [kvm-unit-tests PATCH 1/6] arm64: microbench: get correct ipi
 recieved num
To: Jingyi Wang <wangjingyi11@huawei.com>, <drjones@redhat.com>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
References: <20200517100900.30792-1-wangjingyi11@huawei.com>
 <20200517100900.30792-2-wangjingyi11@huawei.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8e011659-4e4d-7312-4466-5ed3ea54cc9b@huawei.com>
Date: Thu, 21 May 2020 22:00:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200517100900.30792-2-wangjingyi11@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020/5/17 18:08, Jingyi Wang wrote:
> If ipi_exec() fails because of timeout, we shouldn't increase
> the number of ipi received.
> 
> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
> ---
>   arm/micro-bench.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/micro-bench.c b/arm/micro-bench.c
> index 4612f41..ca022d9 100644
> --- a/arm/micro-bench.c
> +++ b/arm/micro-bench.c
> @@ -103,7 +103,9 @@ static void ipi_exec(void)
>   	while (!ipi_received && tries--)
>   		cpu_relax();
>   
> -	++received;
> +	if (ipi_recieved)

I think you may want *ipi_received* ;-) Otherwise it can not even
compile!

> +		++received;
> +
>   	assert_msg(ipi_received, "failed to receive IPI in time, but received %d successfully\n", received);
>   }

With this fixed, this looks good to me,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
