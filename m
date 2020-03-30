Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87F01197B79
	for <lists+kvmarm@lfdr.de>; Mon, 30 Mar 2020 14:06:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6A3D4B22A;
	Mon, 30 Mar 2020 08:06:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sgiof8tsssee; Mon, 30 Mar 2020 08:06:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A8F754B1E5;
	Mon, 30 Mar 2020 08:06:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E70614B1C7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 08:06:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0p5Eo1cmEEDh for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Mar 2020 08:06:50 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4DB934B0A5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 08:06:50 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9F0A01416568A269222E;
 Mon, 30 Mar 2020 20:06:44 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 20:06:36 +0800
Subject: Re: [kvm-unit-tests PATCH v7 13/13] arm/arm64: ITS: pending table
 migration test
To: Eric Auger <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-14-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <296c574b-810c-9c90-a613-df732a9ac193@huawei.com>
Date: Mon, 30 Mar 2020 20:06:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200320092428.20880-14-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andre.przywara@arm.com, thuth@redhat.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Eric,

On 2020/3/20 17:24, Eric Auger wrote:
> Add two new migration tests. One testing the migration of
> a topology where collection were unmapped. The second test
> checks the migration of the pending table.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> @@ -659,6 +678,15 @@ static int its_prerequisites(int nb_cpus)
>   	return 0;
>   }
>   
> +static void set_lpi(struct its_device *dev, u32 eventid, u32 physid,
> +		    struct its_collection *col)
> +{
> +	assert(dev && col);
> +
> +	its_send_mapti(dev, physid, eventid, col);
> +	gicv3_lpi_set_config(physid, LPI_PROP_DEFAULT);
> +}

I'd say we can just drop this helper and open-code it anywhere
necessarily. The name 'set_lpi' doesn't tell me too much about
what has been implemented inside the helper.

> +
>   /*
>    * Setup the configuration for those mappings:
>    * dev_id=2 event=20 -> vcpu 3, intid=8195
> @@ -790,6 +818,108 @@ static void test_its_migration(void)
>   	its_send_int(dev7, 255);
>   	check_lpi_stats("dev7/eventid=255 triggers LPI 8196 on PE #2 after migration");
>   }
> +
> +static void test_migrate_unmapped_collection(void)
> +{
> +	struct its_collection *col;
> +	struct its_device *dev2, *dev7;
> +	int pe0 = 0;
> +	u8 config;
> +
> +	if (its_setup1())
> +		return;
> +
> +	col = its_create_collection(pe0, pe0);
> +	dev2 = its_get_device(2);
> +	dev7 = its_get_device(7);
> +
> +	/* MAPTI with the collection unmapped */
> +	set_lpi(dev2, 0, 8192, col);

... and it's only invoked here.

> +
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report_info("Migration complete");
> +
> +	/* on the destination, map the collection */
> +	its_send_mapc(col, true);
> +	its_send_invall(col);
> +
> +	lpi_stats_expect(2, 8196);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats("dev7/eventid= 255 triggered LPI 8196 on PE #2");
> +
> +	config = gicv3_lpi_get_config(8192);
> +	report(config == LPI_PROP_DEFAULT,
> +	       "Config of LPI 8192 was properly migrated");
> +
> +	lpi_stats_expect(pe0, 8192);
> +	its_send_int(dev2, 0);
> +	check_lpi_stats("dev2/eventid = 0 triggered LPI 8192 on PE0");
> +}
> +
> +static void test_its_pending_migration(void)
> +{
> +	struct its_device *dev;
> +	struct its_collection *collection[2];
> +	int *expected = malloc(nr_cpus * sizeof(int));
> +	int pe0 = nr_cpus - 1, pe1 = nr_cpus - 2;
> +	u64 pendbaser;
> +	void *ptr;
> +	int i;
> +
> +	if (its_prerequisites(4))
> +		return;
> +
> +	dev = its_create_device(2 /* dev id */, 8 /* nb_ites */);
> +	its_send_mapd(dev, true);
> +
> +	collection[0] = its_create_collection(pe0, pe0);
> +	collection[1] = its_create_collection(pe1, pe1);
> +	its_send_mapc(collection[0], true);
> +	its_send_mapc(collection[1], true);
> +
> +	/* disable lpi at redist level */
> +	gicv3_lpi_rdist_disable(pe0);
> +	gicv3_lpi_rdist_disable(pe1);
> +
> +	/* lpis are interleaved inbetween the 2 PEs */
> +	for (i = 0; i < 256; i++) {
> +		struct its_collection *col = i % 2 ? collection[0] :
> +						     collection[1];
> +		int vcpu = col->target_address >> 16;
> +
> +		its_send_mapti(dev, LPI(i), i, col);
> +		gicv3_lpi_set_config(LPI(i), LPI_PROP_DEFAULT);
> +		gicv3_lpi_set_clr_pending(vcpu, LPI(i), true);
> +	}
> +	its_send_invall(collection[0]);
> +	its_send_invall(collection[1]);
> +
> +	/* Clear the PTZ bit on each pendbaser */
> +
> +	expected[pe0] = 128;
> +	expected[pe1] = 128;

Do we need to initialize expected[] for other PEs? Or it has always
been zeroed by the kvm-unit-tests implementation of malloc()?

> +
> +	ptr = gicv3_data.redist_base[pe0] + GICR_PENDBASER;
> +	pendbaser = readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
> +
> +	ptr = gicv3_data.redist_base[pe1] + GICR_PENDBASER;
> +	pendbaser = readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
> +
> +	gicv3_lpi_rdist_enable(pe0);
> +	gicv3_lpi_rdist_enable(pe1);

I don't know how the migration gets implemented in kvm-unit-tests.
But is there any guarantee that the LPIs will only be triggered on the
destination side? As once the EnableLPIs bit becomes 1, VGIC will start
reading the pending bit in guest memory and potentially injecting LPIs
into the target vcpu (in the source side).

> +
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report_info("Migration complete");
> +
> +	/* let's wait for the 256 LPIs to be handled */
> +	mdelay(1000);
> +
> +	check_lpi_hits(expected, "128 LPIs on both PE0 and PE1 after migration");
> +}


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
