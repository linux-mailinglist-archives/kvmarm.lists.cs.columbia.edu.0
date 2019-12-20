Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD01275FF
	for <lists+kvmarm@lfdr.de>; Fri, 20 Dec 2019 07:59:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 350E64A97D;
	Fri, 20 Dec 2019 01:59:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDPEdXPJZLLk; Fri, 20 Dec 2019 01:59:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D32554A94D;
	Fri, 20 Dec 2019 01:59:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AEE64A7FE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 01:59:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SiVoTBcvJUpk for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Dec 2019 01:59:22 -0500 (EST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A1E984A535
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 01:59:22 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9298DCC466B9D8C9D7BB;
 Fri, 20 Dec 2019 14:59:16 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Dec 2019
 14:59:09 +0800
Subject: Re: [kvm-unit-tests PATCH 06/16] arm/arm64: ITS: Test BASER
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20191216140235.10751-1-eric.auger@redhat.com>
 <20191216140235.10751-7-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <172f58d7-5a7c-43e0-c647-a7935f5d4b43@huawei.com>
Date: Fri, 20 Dec 2019 14:59:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191216140235.10751-7-eric.auger@redhat.com>
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

On 2019/12/16 22:02, Eric Auger wrote:
> Add helper routines to parse and set up BASER registers.
> Add a new test dedicated to BASER<n> accesses.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   arm/gic.c                | 20 ++++++++++
>   arm/unittests.cfg        |  6 +++
>   lib/arm/asm/gic-v3-its.h | 17 ++++++++
>   lib/arm/gic-v3-its.c     | 84 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 127 insertions(+)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index adeb981..8b56fce 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -536,6 +536,22 @@ static void test_its_introspection(void)
>   			typer->pta ? "Redist basse address" : "PE #");
>   }
>   
> +static void test_its_baser(void)
> +{
> +	struct its_baser *dev_baser, *coll_baser;
> +
> +	if (!gicv3_its_base()) {
> +		report_skip("No ITS, skip ...");
> +		return;
> +	}
> +
> +	dev_baser = its_lookup_baser(GITS_BASER_TYPE_DEVICE);
> +	coll_baser = its_lookup_baser(GITS_BASER_TYPE_COLLECTION);
> +	report(dev_baser && coll_baser, "detect device and collection BASER");
> +	report_info("device baser entry_size = 0x%x", dev_baser->esz);
> +	report_info("collection baser entry_size = 0x%x", dev_baser->esz);

s/dev_baser/coll_baser/

> +}
> +
>   int main(int argc, char **argv)
>   {
>   	if (!gic_init()) {
> @@ -571,6 +587,10 @@ int main(int argc, char **argv)
>   		report_prefix_push(argv[1]);
>   		test_its_introspection();
>   		report_prefix_pop();
> +	} else if (strcmp(argv[1], "its-baser") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_its_baser();
> +		report_prefix_pop();
>   	} else {
>   		report_abort("Unknown subtest '%s'", argv[1]);
>   	}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index bd20460..2234a0f 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -128,6 +128,12 @@ smp = $MAX_SMP
>   extra_params = -machine gic-version=3 -append 'its-introspection'
>   groups = its
>   
> +[its-baser]
> +file = gic.flat
> +smp = $MAX_SMP
> +extra_params = -machine gic-version=3 -append 'its-baser'
> +groups = its
> +
>   # Test PSCI emulation
>   [psci]
>   file = psci.flat
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 2ce483e..0c0178d 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -100,9 +100,23 @@ struct its_typer {
>   	bool virt_lpi;
>   };
>   
> +struct its_baser {
> +	unsigned int index;

We've already maintained an array of GITS_BASERs, so 'index' is
not needed.

> +	int type;
> +	u64 cache;
> +	int shr;
> +	size_t psz;
> +	int nr_pages;
> +	bool indirect;
> +	phys_addr_t table_addr;
> +	bool valid;
> +	int esz;
> +};
> +
>   struct its_data {
>   	void *base;
>   	struct its_typer typer;
> +	struct its_baser baser[GITS_BASER_NR_REGS];
>   };
>   
>   extern struct its_data its_data;
> @@ -111,6 +125,9 @@ extern struct its_data its_data;
>   
>   extern void its_parse_typer(void);
>   extern void its_init(void);
> +extern int its_parse_baser(int i, struct its_baser *baser);
> +extern void its_setup_baser(int i, struct its_baser *baser);
> +extern struct its_baser *its_lookup_baser(int type);
>   
>   #endif /* !__ASSEMBLY__ */
>   #endif /* _ASMARM_GIC_V3_ITS_H_ */
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index 34f4d0e..303022f 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -4,6 +4,7 @@
>    * This work is licensed under the terms of the GNU LGPL, version 2.
>    */
>   #include <asm/gic.h>
> +#include <alloc_page.h>
>   
>   struct its_data its_data;
>   
> @@ -31,11 +32,94 @@ void its_parse_typer(void)
>   	its_data.typer.phys_lpi = typer & GITS_TYPER_PLPIS;
>   }
>   
> +int its_parse_baser(int i, struct its_baser *baser)
> +{
> +	void *reg_addr = gicv3_its_base() + GITS_BASER + i * 8;
> +	u64 val = readq(reg_addr);
> +
> +	if (!val) {
> +		memset(baser, 0, sizeof(*baser));
> +		return -1;
> +	}
> +
> +	baser->valid = val & GITS_BASER_VALID;
> +	baser->indirect = val & GITS_BASER_INDIRECT;
> +	baser->type = GITS_BASER_TYPE(val);
> +	baser->esz = GITS_BASER_ENTRY_SIZE(val);
> +	baser->nr_pages = GITS_BASER_NR_PAGES(val);
> +	baser->table_addr = val & GITS_BASER_PHYS_ADDR_MASK;
> +	baser->cache = (val >> GITS_BASER_INNER_CACHEABILITY_SHIFT) &
> +			GITS_BASER_CACHEABILITY_MASK;
> +	switch (val & GITS_BASER_PAGE_SIZE_MASK) {
> +	case GITS_BASER_PAGE_SIZE_4K:
> +		baser->psz = SZ_4K;
> +		break;
> +	case GITS_BASER_PAGE_SIZE_16K:
> +		baser->psz = SZ_16K;
> +		break;
> +	case GITS_BASER_PAGE_SIZE_64K:
> +		baser->psz = SZ_64K;
> +		break;
> +	default:
> +		baser->psz = SZ_64K;
> +	}
> +	baser->shr = (val >> 10) & 0x3;
> +	return 0;
> +}
> +
> +struct its_baser *its_lookup_baser(int type)
> +{
> +	int i;
> +
> +	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
> +		struct its_baser *baser = &its_data.baser[i];
> +
> +		if (baser->type == type)
> +			return baser;
> +	}
> +	return NULL;
> +}
> +
>   void its_init(void)
>   {
> +	int i;

Please add a blank line here.

>   	if (!its_data.base)
>   		return;
>   
>   	its_parse_typer();
> +	for (i = 0; i < GITS_BASER_NR_REGS; i++)
> +		its_parse_baser(i, &its_data.baser[i]);
> +}
> +
> +void its_setup_baser(int i, struct its_baser *baser)
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
> +		baser->cache						|
> +		baser->shr						|

baser->cache << GITS_BASER_INNER_CACHEABILITY_SHIFT |
baser->shr << 10 (GITS_BASER_SHAREABILITY_SHIFT) ?


Thanks,
Zenghui

> +		(u64)baser->indirect	<< 62				|
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
>   }
>   
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
