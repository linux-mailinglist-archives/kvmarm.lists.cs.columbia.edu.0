Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFE362EDD
	for <lists+kvmarm@lfdr.de>; Sat, 17 Apr 2021 11:27:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 080ED4B348;
	Sat, 17 Apr 2021 05:27:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MqgRbx6yWD88; Sat, 17 Apr 2021 05:27:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20D0C4B344;
	Sat, 17 Apr 2021 05:27:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DF0384B346
 for <kvmarm@lists.cs.columbia.edu>; Sat, 17 Apr 2021 05:27:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z6nDQbha9d8L for <kvmarm@lists.cs.columbia.edu>;
 Sat, 17 Apr 2021 05:27:25 -0400 (EDT)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AD36A4B30D
 for <kvmarm@lists.cs.columbia.edu>; Sat, 17 Apr 2021 05:27:25 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FMnjW26hXz17Qt9;
 Sat, 17 Apr 2021 17:25:03 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 17 Apr 2021 17:27:13 +0800
Subject: Re: [PATCH v19 4/7] time: Add mechanism to recognize clocksource in
 time_get_snapshot
To: Marc Zyngier <maz@kernel.org>
References: <20210330145430.996981-1-maz@kernel.org>
 <20210330145430.996981-5-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <6e5fb440-156d-2b18-b3cd-89b1a09b0239@huawei.com>
Date: Sat, 17 Apr 2021 17:27:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210330145430.996981-5-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: kernel-team@android.com, lorenzo.pieralisi@arm.com, justin.he@arm.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
 yangbo.lu@nxp.com, sudeep.holla@arm.com, steven.price@arm.com,
 Andre.Przywara@arm.com, john.stultz@linaro.org,
 linux-arm-kernel@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com,
 tglx@linutronix.de, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
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

On 2021/3/30 22:54, Marc Zyngier wrote:
> -	u64		cycles;
> -	ktime_t		real;
> -	ktime_t		raw;
> -	unsigned int	clock_was_set_seq;
> -	u8		cs_was_changed_seq;
> +	u64			cycles;
> +	ktime_t			real;
> +	ktime_t			raw;
> +	enum clocksource_ids	cs_id;

nit: worth adding a description for it (on top of the structure)?

> +	unsigned int		clock_was_set_seq;
> +	u8			cs_was_changed_seq;
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
