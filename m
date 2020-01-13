Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3E1397FA
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jan 2020 18:45:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 94FC24AF24;
	Mon, 13 Jan 2020 12:45:21 -0500 (EST)
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
	with ESMTP id b7WurjaRX+g6; Mon, 13 Jan 2020 12:45:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 768944AF22;
	Mon, 13 Jan 2020 12:45:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DE9A4AF1E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 12:45:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eactxp6R1IyP for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jan 2020 12:45:18 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 69A9B4AF1D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 12:45:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578937518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjupOVr34zDecwnMFqtNXPvApC4Q2OCWXOaNuSUosdM=;
 b=XZVEAag03/tiqHDFVndvaz9+whL6gJBJTatYbgEfGpQH/qCEVgoc4xwZCjnN53zqVO1q1E
 ak4esKf9/u83JwkGIut/0V6JjGKcruq1oRTJMczgOlzOfMg0fqgKjeOiV7wb7sIJaLgoIP
 UpRhdCAC8cDYQne+ojZzDwLhTxtsyFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-EQyERcpHO2KS3VKae6uwbg-1; Mon, 13 Jan 2020 12:45:14 -0500
X-MC-Unique: EQyERcpHO2KS3VKae6uwbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43FE018B9FC1;
 Mon, 13 Jan 2020 17:45:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB418886A;
 Mon, 13 Jan 2020 17:44:59 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:44:57 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 09/16] arm/arm64: ITS: Enable/Disable
 LPIs at re-distributor level
Message-ID: <20200113174457.gg35yyeaftbadqki@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-10-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On Fri, Jan 10, 2020 at 03:54:05PM +0100, Eric Auger wrote:
> This helper function enables or disables the signaling of LPIs
> at redistributor level.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  lib/arm/asm/gic-v3-its.h |  1 +
>  lib/arm/gic-v3-its.c     | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 93814f7..d2db292 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -99,6 +99,7 @@ extern struct its_baser *its_lookup_baser(int type);
>  extern void set_lpi_config(int n, u8 val);
>  extern u8 get_lpi_config(int n);
>  extern void set_pending_table_bit(int rdist, int n, bool set);
> +extern void gicv3_rdist_ctrl_lpi(u32 redist, bool set);
>  
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASMARM_GIC_V3_ITS_H_ */
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index 3037c84..c7c6f80 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -199,3 +199,21 @@ void init_cmd_queue(void)
>  	its_data.cmd_write = its_data.cmd_base;
>  	writeq(0, its_data.base + GITS_CWRITER);
>  }
> +
> +void gicv3_rdist_ctrl_lpi(u32 redist, bool set)
> +{
> +	void *ptr;
> +	u64 val;
> +
> +	if (redist >= nr_cpus)
> +		report_abort("%s redist=%d >= cpu_count=%d\n",
> +			     __func__, redist, nr_cpus);

I'd use {} here because of the multiline call. But, we don't
use the report API in common code. Well, apparently s390 has
report calls in lib/s390x/interrupt.c, but I don't really
agree with that. IMO, common code failures should always
be unexpected and just assert/assert_msg.

> +
> +	ptr = gicv3_data.redist_base[redist];
> +	val = readl(ptr + GICR_CTLR);
> +	if (set)
> +		val |= GICR_CTLR_ENABLE_LPIS;
> +	else
> +		val &= ~GICR_CTLR_ENABLE_LPIS;
> +	writel(val,  ptr + GICR_CTLR);
> +}
> -- 
> 2.20.1
> 

Also, you can squash this patch into whatever is going to make use
of this new helper.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
