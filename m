Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA22EA985
	for <lists+kvmarm@lfdr.de>; Tue,  5 Jan 2021 12:09:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64E904B323;
	Tue,  5 Jan 2021 06:09:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHvQYZgTHbhw; Tue,  5 Jan 2021 06:09:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 412E24B32E;
	Tue,  5 Jan 2021 06:09:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 119464B323
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 06:09:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jwgndeSxsUbw for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Jan 2021 06:09:00 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CD2BF4B321
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 06:09:00 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB131FB;
 Tue,  5 Jan 2021 03:09:00 -0800 (PST)
Received: from [10.163.89.46] (unknown [10.163.89.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4C113F70D;
 Tue,  5 Jan 2021 03:08:55 -0800 (PST)
Subject: Re: [PATCH] arm64/smp: Remove unused variable irq in
 arch_show_interrupts()
To: Catalin Marinas <catalin.marinas@arm.com>,
 Keqian Zhu <zhukeqian1@huawei.com>
References: <20210105092221.15144-1-zhukeqian1@huawei.com>
 <20210105100847.GB11802@gaia>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8deed54d-d184-69b8-fce9-d87128a7d880@arm.com>
Date: Tue, 5 Jan 2021 16:39:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105100847.GB11802@gaia>
Content-Language: en-US
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Robin Murphy <robin.murphy@arm.com>
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



On 1/5/21 3:38 PM, Catalin Marinas wrote:
> On Tue, Jan 05, 2021 at 05:22:21PM +0800, Keqian Zhu wrote:
>> The local variable irq is added in commit a26388152531 ("arm64:
>> Remove custom IRQ stat accounting"), but forget to remove in
>> commit 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in
>> arch_show_interrupts()"). Just remove it.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> 
> I already queued a similar fix in arm64 for-next/fixes (it should appear
> in linux-next at some point)

I too sent this fix yesterday as well :) as it was preventing a clean
build on v5.11-rc2. Missed to check this on arm64 for-next/fixes though
I did check on linux-next.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
