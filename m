Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 851FB316B10
	for <lists+kvmarm@lfdr.de>; Wed, 10 Feb 2021 17:23:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B8FC4B3D0;
	Wed, 10 Feb 2021 11:23:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8DV-hmPNYzw8; Wed, 10 Feb 2021 11:23:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D282B4B36F;
	Wed, 10 Feb 2021 11:23:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B45CC4B302
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Feb 2021 11:23:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e+HL16uejI3a for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Feb 2021 11:23:09 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D4CF4B2FE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Feb 2021 11:23:09 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA94E11D4;
 Wed, 10 Feb 2021 08:23:08 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19FC33F73B;
 Wed, 10 Feb 2021 08:23:04 -0800 (PST)
Date: Wed, 10 Feb 2021 16:22:14 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v18 5/7] clocksource: Add clocksource id for arm arch
 counter
Message-ID: <20210210162214.2e68e0da@slackpad.fritz.box>
In-Reply-To: <20210208134029.3269384-6-maz@kernel.org>
References: <20210208134029.3269384-1-maz@kernel.org>
 <20210208134029.3269384-6-maz@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: kernel-team@android.com, lorenzo.pieralisi@arm.com, justin.he@arm.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
 yangbo.lu@nxp.com, sudeep.holla@arm.com, steven.price@arm.com,
 john.stultz@linaro.org, linux-arm-kernel@lists.infradead.org,
 seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
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

On Mon,  8 Feb 2021 13:40:27 +0000
Marc Zyngier <maz@kernel.org> wrote:

> From: Jianyong Wu <jianyong.wu@arm.com>
> 
> Add clocksource id to the ARM generic counter so that it can be easily
> identified from callers such as ptp_kvm.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20201209060932.212364-6-jianyong.wu@arm.com

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/clocksource/arm_arch_timer.c | 2 ++
>  include/linux/clocksource_ids.h      | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index d0177824c518..8f12e223703f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/clockchips.h>
>  #include <linux/clocksource.h>
> +#include <linux/clocksource_ids.h>
>  #include <linux/interrupt.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> @@ -191,6 +192,7 @@ static u64 arch_counter_read_cc(const struct cyclecounter *cc)
>  
>  static struct clocksource clocksource_counter = {
>  	.name	= "arch_sys_counter",
> +	.id	= CSID_ARM_ARCH_COUNTER,
>  	.rating	= 400,
>  	.read	= arch_counter_read,
>  	.mask	= CLOCKSOURCE_MASK(56),
> diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
> index 4d8e19e05328..16775d7d8f8d 100644
> --- a/include/linux/clocksource_ids.h
> +++ b/include/linux/clocksource_ids.h
> @@ -5,6 +5,7 @@
>  /* Enum to give clocksources a unique identifier */
>  enum clocksource_ids {
>  	CSID_GENERIC		= 0,
> +	CSID_ARM_ARCH_COUNTER,
>  	CSID_MAX,
>  };
>  

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
