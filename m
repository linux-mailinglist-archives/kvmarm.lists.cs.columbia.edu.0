Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 227712DE246
	for <lists+kvmarm@lfdr.de>; Fri, 18 Dec 2020 13:04:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC0BF4B0FB;
	Fri, 18 Dec 2020 07:04:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjXmlhtr1pkE; Fri, 18 Dec 2020 07:04:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 99CCE4B0F5;
	Fri, 18 Dec 2020 07:04:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0A784B0E8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Dec 2020 07:04:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mMH+AtbZQMcm for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Dec 2020 07:04:27 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C21A44B0DD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Dec 2020 07:04:27 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78AAD101E;
 Fri, 18 Dec 2020 04:04:27 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0A1E3F66E;
 Fri, 18 Dec 2020 04:04:26 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH v2 03/12] arm/arm64: gic: Remove SMP
 synchronization from ipi_clear_active_handler()
To: Alexandru Elisei <alexandru.elisei@arm.com>, drjones@redhat.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20201217141400.106137-1-alexandru.elisei@arm.com>
 <20201217141400.106137-4-alexandru.elisei@arm.com>
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <b928a9ea-4104-b867-d140-3fe80816128e@arm.com>
Date: Fri, 18 Dec 2020 12:04:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201217141400.106137-4-alexandru.elisei@arm.com>
Content-Language: en-GB
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

On 17/12/2020 14:13, Alexandru Elisei wrote:
> The gicv{2,3}-active test sends an IPI from the boot CPU to itself, then
> checks that the interrupt has been received as expected. There is no need
> to use inter-processor memory synchronization primitives on code that runs
> on the same CPU, so remove the unneeded memory barriers.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

I am not fully convinced this is a wise move. Indeed the existing
barriers look wrong, and *currently* we just use
ipi_clear_active_handler() for a single CPU test only, but the handler
function itself is not restricted to that use case, if I am not mistaken.
But I think for now this fix is fine, and the comment should point out
the limitation well enough, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


> ---
>  arm/gic.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index ca61dba2986c..1c9f4a01b6e4 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -364,6 +364,7 @@ static struct gic gicv3 = {
>  	},
>  };
>  
> +/* Runs on the same CPU as the sender, no need for memory synchronization */
>  static void ipi_clear_active_handler(struct pt_regs *regs __unused)
>  {
>  	u32 irqstat = gic_read_iar();
> @@ -380,13 +381,10 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
>  
>  		writel(val, base + GICD_ICACTIVER);
>  
> -		smp_rmb(); /* pairs with wmb in stats_reset */
>  		++acked[smp_processor_id()];
>  		check_irqnr(irqnr);
> -		smp_wmb(); /* pairs with rmb in check_acked */
>  	} else {
>  		++spurious[smp_processor_id()];
> -		smp_wmb();
>  	}
>  }
>  
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
