Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B2AEA74F42
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jul 2019 15:25:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 285334A5C6;
	Thu, 25 Jul 2019 09:25:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmzCo5QWV65c; Thu, 25 Jul 2019 09:25:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 123464A5B1;
	Thu, 25 Jul 2019 09:25:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8520A4A596
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 09:25:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MLHfGvWvXhsB for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jul 2019 09:25:11 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 796514A58B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 09:25:11 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFFF730805C4;
 Thu, 25 Jul 2019 13:25:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AFDB60BEC;
 Thu, 25 Jul 2019 13:25:08 +0000 (UTC)
Date: Thu, 25 Jul 2019 15:25:06 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH kvm-unit-tests v4] arm: Add PL031 test
Message-ID: <20190725132506.2m4gkrsfcl422ztz@kamzik.brq.redhat.com>
References: <20190725130949.27436-1-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190725130949.27436-1-graf@amazon.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 25 Jul 2019 13:25:10 +0000 (UTC)
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu
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

On Thu, Jul 25, 2019 at 03:09:49PM +0200, Alexander Graf wrote:
> This patch adds a unit test for the PL031 RTC that is used in the virt machine.
> It just pokes basic functionality. I've mostly written it to familiarize myself
> with the device, but I suppose having the test around does not hurt, as it also
> exercises the GIC SPI interrupt path.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - Use FDT to find base, irq and existence
>   - Put isb after timer read
>   - Use dist_base for gicv3
> 
> v2 -> v3
> 
>   - Enable compilation on 32bit ARM target
>   - Use ioremap
> 
> v3 -> v4:
> 
>   - Use dt_pbus_translate_node()
>   - Make irq_triggered volatile
> ---
>  arm/Makefile.common |   1 +
>  arm/pl031.c         | 260 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/arm/asm/gic.h   |   1 +
>  3 files changed, 262 insertions(+)
>  create mode 100644 arm/pl031.c

Thanks for the new version. I have a new nit (below), but my r-b stands
with or without making another change.

[...]

> +static int rtc_fdt_init(void)
> +{
> +	const struct fdt_property *prop;
> +	const void *fdt = dt_fdt();
> +	struct dt_pbus_reg base;
> +	int node, len;
> +	u32 *data;
> +
> +	node = fdt_node_offset_by_compatible(fdt, -1, "arm,pl031");
> +	if (node < 0)
> +		return -1;
> +
> +	prop = fdt_get_property(fdt, node, "interrupts", &len);
> +	assert(prop && len == (3 * sizeof(u32)));
> +	data = (u32 *)prop->data;
> +	assert(data[0] == 0); /* SPI */
> +	pl031_irq = SPI(fdt32_to_cpu(data[1]));
> +
> +	assert(!dt_pbus_translate_node(node, 0, &base));

We prefer to do something like

 ret = dt_pbus_translate_node(node, 0, &base);
 assert(!ret);

than the above, just in case we ever compiled with assert() defined as a
no-op. But the probability of doing that is pretty close to zero.

> +	pl031 = ioremap(base.addr, base.size);
> +
> +	return 0;
> +}

Thanks,
drew
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
