Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94E1557F6
	for <lists+kvmarm@lfdr.de>; Fri,  7 Feb 2020 13:52:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 830294A7FD;
	Fri,  7 Feb 2020 07:52:00 -0500 (EST)
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
	with ESMTP id LedcrkpXtaRl; Fri,  7 Feb 2020 07:52:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43E614A650;
	Fri,  7 Feb 2020 07:51:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6BE8A4A389
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Feb 2020 07:51:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HtywxBc7Mgk3 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Feb 2020 07:51:55 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E8004A3A5
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Feb 2020 07:51:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581079915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QfifAdtZgyLKfSMjV381OxKtjAbgvAPmh0ViyL9F8LE=;
 b=UYOxR9Hhyko8Nshx9Pjkow+o9kMAdpyNOPSokbxYSFk5BOzdd2jlAP4Ev4RcDsdjZ1pAFl
 QPWfme4sAkoG5oPbzljig+JdURHP47eRaUvxAq8Mvs6ziZr5TuFxG3Llf3wcPRuvm0gbWn
 v3SnVdLHDFEd+M8+ZCWLJpI8w6EsHl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-w6w7WfAfN2-uYclU7SUvdA-1; Fri, 07 Feb 2020 07:51:51 -0500
X-MC-Unique: w6w7WfAfN2-uYclU7SUvdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAFF9140A;
 Fri,  7 Feb 2020 12:51:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADD4A60C05;
 Fri,  7 Feb 2020 12:51:43 +0000 (UTC)
Date: Fri, 7 Feb 2020 13:51:40 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 09/14] arm/arm64: ITS: Device and
 collection Initialization
Message-ID: <20200207125140.656ctxlmk3d4au7g@kamzik.brq.redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200128103459.19413-10-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: thuth@redhat.com, kvm@vger.kernel.org, maz@kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, andre.przywara@arm.com,
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

On Tue, Jan 28, 2020 at 11:34:54AM +0100, Eric Auger wrote:
> Introduce an helper functions to register
> - a new device, characterized by its device id and the
>   max number of event IDs that dimension its ITT (Interrupt
>   Translation Table).  The function allocates the ITT.
> 
> - a new collection, characterized by its ID and the
>   target processing engine (PE).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - s/report_abort/assert
> 
> v1 -> v2:
> - s/nb_/nr_
> ---
>  lib/arm/asm/gic-v3-its.h | 20 +++++++++++++++++-
>  lib/arm/gic-v3-its.c     | 44 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index fe73c04..acd97a9 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -31,6 +31,19 @@ struct its_baser {
>  };
>  
>  #define GITS_BASER_NR_REGS              8
> +#define GITS_MAX_DEVICES		8
> +#define GITS_MAX_COLLECTIONS		8
> +
> +struct its_device {
> +	u32 device_id;	/* device ID */
> +	u32 nr_ites;	/* Max Interrupt Translation Entries */
> +	void *itt;	/* Interrupt Translation Table GPA */
> +};
> +
> +struct its_collection {
> +	u64 target_address;
> +	u16 col_id;
> +};
>  
>  struct its_data {
>  	void *base;
> @@ -38,6 +51,10 @@ struct its_data {
>  	struct its_baser baser[GITS_BASER_NR_REGS];
>  	struct its_cmd_block *cmd_base;
>  	struct its_cmd_block *cmd_write;
> +	struct its_device devices[GITS_MAX_DEVICES];
> +	u32 nr_devices;		/* Allocated Devices */
> +	struct its_collection collections[GITS_MAX_COLLECTIONS];
> +	u32 nr_collections;	/* Allocated Collections */
>  };
>  
>  extern struct its_data its_data;
> @@ -90,7 +107,6 @@ extern struct its_data its_data;
>  #define GITS_BASER_TYPE_DEVICE		1
>  #define GITS_BASER_TYPE_COLLECTION	4
>  
> -
>  struct its_cmd_block {
>  	u64 raw_cmd[4];
>  };
> @@ -100,6 +116,8 @@ extern void its_init(void);
>  extern int its_parse_baser(int i, struct its_baser *baser);
>  extern struct its_baser *its_lookup_baser(int type);
>  extern void its_enable_defaults(void);
> +extern struct its_device *its_create_device(u32 dev_id, int nr_ites);
> +extern struct its_collection *its_create_collection(u32 col_id, u32 target_pe);
>  
>  #else /* __arm__ */
>  
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index d1e7e52..c2dcd01 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -175,3 +175,47 @@ void its_enable_defaults(void)
>  
>  	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
>  }
> +
> +struct its_device *its_create_device(u32 device_id, int nr_ites)
> +{
> +	struct its_baser *baser;
> +	struct its_device *new;
> +	unsigned long n, order;
> +
> +	assert(its_data.nr_devices < GITS_MAX_DEVICES);
> +
> +	baser = its_lookup_baser(GITS_BASER_TYPE_DEVICE);
> +	if (!baser)
> +		return NULL;

Should we assert here if we can't find a GITS_BASER_TYPE_DEVICE ?
It seems none of the callers of its_create_device are checking
for null.

> +
> +	new = &its_data.devices[its_data.nr_devices];
> +
> +	new->device_id = device_id;
> +	new->nr_ites = nr_ites;
> +
> +	n = (its_data.typer.ite_size * nr_ites) >> PAGE_SHIFT;
> +	order = is_power_of_2(n) ? fls(n) : fls(n) + 1;

I've seen this calculation several times now, so I think an
arch-neutral order calculator is in order:

 int get_order(size_t size);

> +	new->itt = (void *)virt_to_phys(alloc_pages(order));

If this is a physical address then shouldn't itt be phys_addr_t ?

> +
> +	its_data.nr_devices++;
> +	return new;
> +}
> +
> +struct its_collection *its_create_collection(u32 col_id, u32 pe)
> +{
> +	struct its_collection *new;
> +
> +	assert(its_data.nr_collections < GITS_MAX_COLLECTIONS);
> +
> +	new = &its_data.collections[its_data.nr_collections];
> +
> +	new->col_id = col_id;
> +
> +	if (its_data.typer.pta)
> +		new->target_address = (u64)gicv3_data.redist_base[pe];
> +	else
> +		new->target_address = pe << 16;
> +
> +	its_data.nr_collections++;
> +	return new;
> +}
> -- 
> 2.20.1
>

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
