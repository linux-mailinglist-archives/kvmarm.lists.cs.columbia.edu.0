Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6F707159247
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 15:51:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF5EB4A5C6;
	Tue, 11 Feb 2020 09:51:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i1EfaP0En+oM; Tue, 11 Feb 2020 09:51:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DDEF34AEB2;
	Tue, 11 Feb 2020 09:51:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F40A4AE9E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 09:51:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZtOk0MpylK0g for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 09:51:15 -0500 (EST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 67EF04A5C6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 09:51:14 -0500 (EST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6146C161BFF83916527A;
 Tue, 11 Feb 2020 22:51:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 22:50:59 +0800
Subject: Re: [PATCH kvm-unit-tests v2] arm64: timer: Speed up gic-timer-state
 check
To: Andrew Jones <drjones@redhat.com>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>
References: <20200211133705.1398-1-drjones@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <60c6c4c7-1d6b-5b64-adc1-8e96f45332c6@huawei.com>
Date: Tue, 11 Feb 2020 22:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200211133705.1398-1-drjones@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
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

Hi Drew,

On 2020/2/11 21:37, Andrew Jones wrote:
> Let's bail out of the wait loop if we see the expected state
> to save over six seconds of run time. Make sure we wait a bit
> before reading the registers and double check again after,
> though, to somewhat mitigate the chance of seeing the expected
> state by accident.
> 
> We also take this opportunity to push more IRQ state code to
> the library.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>

[...]

> +
> +enum gic_irq_state gic_irq_state(int irq)

This is a *generic* name while this function only deals with PPI.
Maybe we can use something like gic_ppi_state() instead?  Or you
will have to take all interrupt types into account in a single
function, which is not a easy job I think.

> +{
> +	enum gic_irq_state state;
> +	bool pending = false, active = false;
> +	void *base;
> +
> +	assert(gic_common_ops);
> +
> +	switch (gic_version()) {
> +	case 2:
> +		base = gicv2_dist_base();
> +		pending = readl(base + GICD_ISPENDR) & (1 << PPI(irq));
> +		active = readl(base + GICD_ISACTIVER) & (1 << PPI(irq));
> +		break;
> +	case 3:
> +		base = gicv3_sgi_base();
> +		pending = readl(base + GICR_ISPENDR0) & (1 << PPI(irq));
> +		active = readl(base + GICR_ISACTIVER0) & (1 << PPI(irq));

And you may also want to ensure that the 'irq' is valid for PPI().
Or personally, I'd just use a real PPI number (PPI(info->irq)) as
the input parameter of this function.

> +		break;
> +	}
> +
> +	if (!active && !pending)
> +		state = GIC_IRQ_STATE_INACTIVE;
> +	if (pending)
> +		state = GIC_IRQ_STATE_PENDING;
> +	if (active)
> +		state = GIC_IRQ_STATE_ACTIVE;
> +	if (active && pending)
> +		state = GIC_IRQ_STATE_ACTIVE_PENDING;
> +
> +	return state;
> +}
> 

Otherwise,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Tested-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
