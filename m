Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF723602DA
	for <lists+kvmarm@lfdr.de>; Thu, 15 Apr 2021 08:59:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5FE34B3B4;
	Thu, 15 Apr 2021 02:59:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgjqW3hyjsz8; Thu, 15 Apr 2021 02:59:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3F114B3D2;
	Thu, 15 Apr 2021 02:59:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 78E0B4B375
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 02:59:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qqes8KVHaGYi for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Apr 2021 02:59:32 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AC58E4A19F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 02:59:32 -0400 (EDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FLVXK11HGzjYhv;
 Thu, 15 Apr 2021 14:57:37 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 14:59:26 +0800
Subject: Re: [PATCH 1/5] KVM: arm64: Divorce the perf code from oprofile
 helpers
To: Marc Zyngier <maz@kernel.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>
References: <20210414134409.1266357-1-maz@kernel.org>
 <20210414134409.1266357-2-maz@kernel.org>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <baa268cf-c92d-6b97-da4c-e7da2a9ccb7a@huawei.com>
Date: Thu, 15 Apr 2021 14:59:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210414134409.1266357-2-maz@kernel.org>
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Peter Zijlstra <peterz@infradead.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Heiko Carstens <hca@linux.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, nathan@kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, Will Deacon <will@kernel.org>,
 kernel-team@android.com
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

Hi Marc,

On 2021/4/14 21:44, Marc Zyngier wrote:
> KVM/arm64 is the sole user of perf_num_counters(), and really
> could do without it. Stop using the obsolete API by relying on
> the existing probing code.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/perf.c     | 7 +------
>  arch/arm64/kvm/pmu-emul.c | 2 +-
>  include/kvm/arm_pmu.h     | 4 ++++
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
> index 739164324afe..b8b398670ef2 100644
> --- a/arch/arm64/kvm/perf.c
> +++ b/arch/arm64/kvm/perf.c
> @@ -50,12 +50,7 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
>  
>  int kvm_perf_init(void)
>  {
> -	/*
> -	 * Check if HW_PERF_EVENTS are supported by checking the number of
> -	 * hardware performance counters. This could ensure the presence of
> -	 * a physical PMU and CONFIG_PERF_EVENT is selected.
> -	 */
> -	if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
> +	if (kvm_pmu_probe_pmuver() != 0xf)
The probe() function may be called many times (kvm_arm_pmu_v3_set_attr also calls it).
I don't know whether the first calling is enough. If so, can we use a static variable
in it, so the following calling can return the result right away?

Thanks,
Keqian
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
