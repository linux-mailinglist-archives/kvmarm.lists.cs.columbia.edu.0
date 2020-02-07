Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00F1550F4
	for <lists+kvmarm@lfdr.de>; Fri,  7 Feb 2020 04:20:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89BD54A597;
	Thu,  6 Feb 2020 22:20:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AA-UZdidC7gJ; Thu,  6 Feb 2020 22:20:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 639014A531;
	Thu,  6 Feb 2020 22:20:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 85A614A4A0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 22:20:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PsPeEf3iT9OQ for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Feb 2020 22:20:51 -0500 (EST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D58224A49C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 22:20:50 -0500 (EST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4FC83DEDBF9E915389DD;
 Fri,  7 Feb 2020 11:20:46 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 11:20:39 +0800
Subject: Re: [kvm-unit-tests PATCH v3 08/14] arm/arm64: ITS:
 its_enable_defaults
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-9-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <10d0630f-1464-b12a-5ad5-ee617eaa5cca@huawei.com>
Date: Fri, 7 Feb 2020 11:20:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200128103459.19413-9-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: andre.przywara@arm.com, thuth@redhat.com
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

Hi Eric,

On 2020/1/28 18:34, Eric Auger wrote:
> its_enable_defaults() is the top init function that allocates the
> command queue and all the requested tables (device, collection,
> lpi config and pending tables), enable LPIs at distributor level
> and ITS level.
> 
> gicv3_enable_defaults must be called before.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - introduce its_setup_baser in this patch
> - squash "arm/arm64: ITS: Init the command queue" in this patch.
> ---
>   lib/arm/asm/gic-v3-its.h |  8 ++++
>   lib/arm/gic-v3-its.c     | 89 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 97 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 815c515..fe73c04 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -36,6 +36,8 @@ struct its_data {
>   	void *base;
>   	struct its_typer typer;
>   	struct its_baser baser[GITS_BASER_NR_REGS];
> +	struct its_cmd_block *cmd_base;
> +	struct its_cmd_block *cmd_write;
>   };
>   
>   extern struct its_data its_data;
> @@ -88,10 +90,16 @@ extern struct its_data its_data;
>   #define GITS_BASER_TYPE_DEVICE		1
>   #define GITS_BASER_TYPE_COLLECTION	4
>   
> +
> +struct its_cmd_block {
> +	u64 raw_cmd[4];
> +};
> +
>   extern void its_parse_typer(void);
>   extern void its_init(void);
>   extern int its_parse_baser(int i, struct its_baser *baser);
>   extern struct its_baser *its_lookup_baser(int type);
> +extern void its_enable_defaults(void);
>   
>   #else /* __arm__ */
>   
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index 2c0ce13..d1e7e52 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -86,3 +86,92 @@ void its_init(void)
>   		its_parse_baser(i, &its_data.baser[i]);
>   }
>   
> +static void its_setup_baser(int i, struct its_baser *baser)
> +{
> +	unsigned long n = (baser->nr_pages * baser->psz) >> PAGE_SHIFT;
> +	unsigned long order = is_power_of_2(n) ? fls(n) : fls(n) + 1;
> +	u64 val;
> +
> +	baser->table_addr = (u64)virt_to_phys(alloc_pages(order));
> +
> +	val = ((u64)baser->table_addr					|
> +		((u64)baser->type	<< GITS_BASER_TYPE_SHIFT)	|
> +		((u64)(baser->esz - 1)	<< GITS_BASER_ENTRY_SIZE_SHIFT)	|
> +		((baser->nr_pages - 1)	<< GITS_BASER_PAGES_SHIFT)	|
> +		(u64)baser->indirect	<< 62				|

I haven't seen the 'nr_pages' and 'indirect' are programmed anywhere
except in its_parse_baser(). It looks like they're treated as RO (but
they shouldn't) and I now don't think it makes sense to parse them in
its_parse_baser(), in patch#5.

> +		(u64)baser->valid	<< 63);
> +
> +	switch (baser->psz) {
> +	case SZ_4K:
> +		val |= GITS_BASER_PAGE_SIZE_4K;
> +		break;
> +	case SZ_16K:
> +		val |= GITS_BASER_PAGE_SIZE_16K;
> +		break;
> +	case SZ_64K:
> +		val |= GITS_BASER_PAGE_SIZE_64K;
> +		break;
> +	}
> +
> +	writeq(val, gicv3_its_base() + GITS_BASER + i * 8);
> +}
> +
> +/**
> + * init_cmd_queue: Allocate the command queue and initialize
> + * CBASER, CREADR, CWRITER

no 'CREADR'.


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
