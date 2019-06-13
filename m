Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7966943578
	for <lists+kvmarm@lfdr.de>; Thu, 13 Jun 2019 13:23:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E17BC4A4A3;
	Thu, 13 Jun 2019 07:23:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAcApXSdH2u9; Thu, 13 Jun 2019 07:23:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C93A44A504;
	Thu, 13 Jun 2019 07:23:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BC0E64A4A3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jun 2019 07:23:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VeRWGO3prHb8 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Jun 2019 07:23:28 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2D7D64A409
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jun 2019 07:23:28 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A7DBEF7C1BDB2B979504;
 Thu, 13 Jun 2019 19:23:24 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 19:23:16 +0800
Subject: Re: [PATCH v1 1/5] KVM: arm/arm64: Remove kvm_mmio_emulate tracepoint
To: James Morse <james.morse@arm.com>
References: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
 <1560330526-15468-2-git-send-email-yuzenghui@huawei.com>
 <e915c19a-51df-be88-ea3a-7c9a211f4518@arm.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5885c607-1314-ff53-38f1-9f48b1c16de4@huawei.com>
Date: Thu, 13 Jun 2019 19:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <e915c19a-51df-be88-ea3a-7c9a211f4518@arm.com>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: acme@redhat.com, kvm@vger.kernel.org, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
 peterz@infradead.org, alexander.shishkin@linux.intel.com, mingo@redhat.com,
 xiexiangyou@huawei.com, ganapatrao.kulkarni@cavium.com, namhyung@kernel.org,
 jolsa@redhat.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi James,

On 2019/6/12 20:48, James Morse wrote:
> Hi,
> 
> On 12/06/2019 10:08, Zenghui Yu wrote:
>> In current KVM/ARM code, no one will invoke trace_kvm_mmio_emulate().
>> Remove this TRACE_EVENT definition.
> 
> Oooer. We can't just go removing these things, they are visible to user-space.
> 
> I recall an article on this: https://lwn.net/Articles/737530/
> "Another attempt to address the tracepoint ABI problem"
> 
> I agree this is orphaned, it was added by commit 45e96ea6b369 ("KVM: ARM: Handle I/O
> aborts"), but there never was a caller.
> 
> The problem with removing it is /sys/kernel/debug/tracing/events/kvm/kvm_mmio_emulate
> disappears. Any program relying on that being present (but useless) is now broken.
Thanks for the reminder.

It turned out that I knew little about the tracepoint ABI :( .
I'm OK to just drop this patch in next version.


Thanks,
zenghui


.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
