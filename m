Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 60EBEF90C4
	for <lists+kvmarm@lfdr.de>; Tue, 12 Nov 2019 14:36:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5BB44B1BD;
	Tue, 12 Nov 2019 08:36:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbKUFGW5vW7h; Tue, 12 Nov 2019 08:36:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B202F4B1BC;
	Tue, 12 Nov 2019 08:36:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 769B64B192
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Nov 2019 08:36:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zk1icfSrCjEx for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Nov 2019 08:36:29 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6032C4B16C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Nov 2019 08:36:29 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B7B30E;
 Tue, 12 Nov 2019 05:36:28 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69393F6C4;
 Tue, 12 Nov 2019 05:36:27 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH 05/17] arm: gic: Prepare IRQ handler for
 handling SPIs
To: Andre Przywara <andre.przywara@arm.com>, Andrew Jones
 <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20191108144240.204202-1-andre.przywara@arm.com>
 <20191108144240.204202-6-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <2e0e6ee6-20ba-4143-a80c-62333b24bdc9@arm.com>
Date: Tue, 12 Nov 2019 13:36:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191108144240.204202-6-andre.przywara@arm.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
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

Hi,

On 11/8/19 2:42 PM, Andre Przywara wrote:
> So far our IRQ handler routine checks that the received IRQ is actually
> the one SGI (IPI) that we are using for our testing.
>
> To make the IRQ testing routine more versatile, also allow the IRQ to be
> one test SPI (shared interrupt).
> We use the penultimate IRQ of the first SPI group for that purpose.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/gic.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arm/gic.c b/arm/gic.c
> index eca9188..c909668 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -23,6 +23,7 @@
>  
>  #define IPI_SENDER	1
>  #define IPI_IRQ		1
> +#define SPI_IRQ		(GIC_FIRST_SPI + 30)
>  
>  struct gic {
>  	struct {
> @@ -162,8 +163,12 @@ static void irq_handler(struct pt_regs *regs __unused)
>  
>  	smp_rmb(); /* pairs with wmb in stats_reset */
>  	++acked[smp_processor_id()];
> -	check_ipi_sender(irqstat);
> -	check_irqnr(irqnr, IPI_IRQ);
> +	if (irqnr < GIC_NR_PRIVATE_IRQS) {
> +		check_ipi_sender(irqstat);
> +		check_irqnr(irqnr, IPI_IRQ);
> +	} else {
> +		check_irqnr(irqnr, SPI_IRQ);
> +	}
>  	smp_wmb(); /* pairs with rmb in check_acked */
>  }
>  

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
