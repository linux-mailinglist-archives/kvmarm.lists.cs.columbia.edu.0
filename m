Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64811362F35
	for <lists+kvmarm@lfdr.de>; Sat, 17 Apr 2021 12:25:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB8884B366;
	Sat, 17 Apr 2021 06:25:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id piQiLp09Ck5N; Sat, 17 Apr 2021 06:25:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AF734B35A;
	Sat, 17 Apr 2021 06:25:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E98F54B319
 for <kvmarm@lists.cs.columbia.edu>; Sat, 17 Apr 2021 06:25:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s-MqYs514xcg for <kvmarm@lists.cs.columbia.edu>;
 Sat, 17 Apr 2021 06:25:10 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B10904B30F
 for <kvmarm@lists.cs.columbia.edu>; Sat, 17 Apr 2021 06:25:10 -0400 (EDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FMpzP41D7zPr3L;
 Sat, 17 Apr 2021 18:22:09 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Sat, 17 Apr 2021 18:24:55 +0800
Subject: Re: [PATCH v19 6/7] KVM: arm64: Add support for the KVM PTP service
To: Marc Zyngier <maz@kernel.org>
References: <20210330145430.996981-1-maz@kernel.org>
 <20210330145430.996981-7-maz@kernel.org>
 <5aadf0b4-b9e5-8521-db60-52a0f319cf28@huawei.com>
 <87v98ls2co.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e4130244-10a6-3251-227b-6f99c3c5899b@huawei.com>
Date: Sat, 17 Apr 2021 18:24:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87v98ls2co.wl-maz@kernel.org>
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

On 2021/4/17 17:10, Marc Zyngier wrote:
> On Sat, 17 Apr 2021 09:59:39 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> On 2021/3/30 22:54, Marc Zyngier wrote:
>>> +PTP_KVM support for arm/arm64
>>> +=============================
>>> +
>>> +PTP_KVM is used for high precision time sync between host and guests.
>>> +It relies on transferring the wall clock and counter value from the
>>> +host to the guest using a KVM-specific hypercall.
>>> +
>>> +* ARM_SMCCC_HYP_KVM_PTP_FUNC_ID: 0x86000001
>>
>> Per include/linux/arm-smccc.h, this should be
>> ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID.
> 
> Well spotted. Care to send a patch on top of my kvm-arm64/ptp branch?

Okay. I'll have a patch for that.


Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
