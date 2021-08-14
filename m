Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 816D73EC187
	for <lists+kvmarm@lfdr.de>; Sat, 14 Aug 2021 11:10:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DDB204B089;
	Sat, 14 Aug 2021 05:10:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73y5xwlBQ4Ua; Sat, 14 Aug 2021 05:10:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E1B484A7FD;
	Sat, 14 Aug 2021 05:10:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 07E474A126
 for <kvmarm@lists.cs.columbia.edu>; Sat, 14 Aug 2021 05:10:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkJAgeYq6Wua for <kvmarm@lists.cs.columbia.edu>;
 Sat, 14 Aug 2021 05:10:12 -0400 (EDT)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C567F4AC78
 for <kvmarm@lists.cs.columbia.edu>; Sat, 14 Aug 2021 05:10:11 -0400 (EDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gmvg417C3zb1TY;
 Sat, 14 Aug 2021 17:06:24 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 14 Aug 2021 17:10:05 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 14 Aug 2021 17:10:03 +0800
Subject: Re: [PATCH 04/10] KVM: arm64: selftests: Add basic support for
 arch_timers
To: Raghavendra Rao Ananta <rananta@google.com>
References: <20210813211211.2983293-1-rananta@google.com>
 <20210813211211.2983293-5-rananta@google.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <35c06dff-36cf-3836-e469-bedcf3c04a4d@huawei.com>
Date: Sat, 14 Aug 2021 17:10:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210813211211.2983293-5-rananta@google.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2021/8/14 5:12, Raghavendra Rao Ananta wrote:
> Add a minimalistic library support to access the virtual timers,
> that can be used for simple timing functionalities, such as
> introducing delays in the guest.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../kvm/include/aarch64/arch_timer.h          | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/arch_timer.h
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/arch_timer.h b/tools/testing/selftests/kvm/include/aarch64/arch_timer.h
> new file mode 100644
> index 000000000000..e6144ab95348
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/aarch64/arch_timer.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * ARM Generic Interrupt Controller (GIC) specific defines

This isn't GIC specific, but arch timer.

> + */
> +
> +#ifndef SELFTEST_KVM_ARCH_TIMER_H
> +#define SELFTEST_KVM_ARCH_TIMER_H
> +
> +#include <linux/sizes.h>

Do we really need it?

> +
> +#include "processor.h"
> +
> +enum arch_timer {
> +	VIRTUAL,
> +	PHYSICAL,
> +};
> +
> +#define CTL_ENABLE	(1 << 0)
> +#define CTL_ISTATUS	(1 << 2)
> +#define CTL_IMASK	(1 << 1)

nitpick: Move CTL_IMASK before CTL_ISTATUS ?

> +
> +#define msec_to_cycles(msec)	\
> +	(timer_get_cntfrq() * (uint64_t)(msec) / 1000)
> +
> +#define usec_to_cycles(usec)	\
> +	(timer_get_cntfrq() * (uint64_t)(usec) / 1000000)
> +
> +#define cycles_to_usec(cycles) \
> +	((uint64_t)(cycles) * 1000000 / timer_get_cntfrq())
> +
> +static inline uint32_t timer_get_cntfrq(void)
> +{
> +	return read_sysreg(cntfrq_el0);
> +}
> +
> +static inline uint64_t timer_get_cntct(enum arch_timer timer)
> +{
> +	isb();
> +
> +	switch (timer) {
> +	case VIRTUAL:
> +		return read_sysreg(cntvct_el0);
> +	case PHYSICAL:
> +		return read_sysreg(cntpct_el0);
> +	default:
> +		GUEST_ASSERT_1(0, timer);
> +	}
> +
> +	/* We should not reach here */
> +	return 0;
> +}
> +
> +static inline void timer_set_cval(enum arch_timer timer, uint64_t cval)
> +{
> +	switch (timer) {
> +	case VIRTUAL:
> +		return write_sysreg(cntv_cval_el0, cval);
> +	case PHYSICAL:
> +		return write_sysreg(cntp_cval_el0, cval);
> +	default:
> +		GUEST_ASSERT_1(0, timer);
> +	}
> +
> +	isb();

ISB should be performed before 'return'. And the same for
timer_set_{tval,ctl}.

Thanks,
Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
