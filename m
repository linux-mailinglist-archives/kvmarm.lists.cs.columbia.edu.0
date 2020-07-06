Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 728CB2150ED
	for <lists+kvmarm@lfdr.de>; Mon,  6 Jul 2020 03:28:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 091814B34D;
	Sun,  5 Jul 2020 21:28:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2lkrxhtVhr37; Sun,  5 Jul 2020 21:28:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CAFC74B340;
	Sun,  5 Jul 2020 21:28:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 93C064B2CD
 for <kvmarm@lists.cs.columbia.edu>; Sun,  5 Jul 2020 21:28:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OfyUY6-aDp0h for <kvmarm@lists.cs.columbia.edu>;
 Sun,  5 Jul 2020 21:28:50 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A3D2C4B272
 for <kvmarm@lists.cs.columbia.edu>; Sun,  5 Jul 2020 21:28:50 -0400 (EDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 67D41B749714BAF7E395;
 Mon,  6 Jul 2020 09:28:47 +0800 (CST)
Received: from [10.174.187.22] (10.174.187.22) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 09:28:40 +0800
Subject: Re: [PATCH v2 0/8] KVM: arm64: Support HW dirty log based on DBM
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
References: <20200702135556.36896-1-zhukeqian1@huawei.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <e120ec04-24d5-f1cb-3aa2-8baf3d6da1db@huawei.com>
Date: Mon, 6 Jul 2020 09:28:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200702135556.36896-1-zhukeqian1@huawei.com>
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

Hi Catalin and Marc,

On 2020/7/2 21:55, Keqian Zhu wrote:
> This patch series add support for dirty log based on HW DBM.
> 
> It works well under some migration test cases, including VM with 4K
> pages or 2M THP. I checked the SHA256 hash digest of all memory and
> they keep same for source VM and destination VM, which means no dirty
> pages is missed under hardware DBM.
> 
> Some key points:
> 
> 1. Only support hardware updates of dirty status for PTEs. PMDs and PUDs
>    are not involved for now.
> 
> 2. About *performance*: In RFC patch, I have mentioned that for every 64GB
>    memory, KVM consumes about 40ms to scan all PTEs to collect dirty log.
>    This patch solves this problem through two ways: HW/SW dynamic switch
>    and Multi-core offload.
> 
>    HW/SW dynamic switch: Give userspace right to enable/disable hw dirty
>    log. This adds a new KVM cap named KVM_CAP_ARM_HW_DIRTY_LOG. We can
>    achieve this by change the kvm->arch.vtcr value and kick vCPUs out to
>    reload this value to VCTR_EL2. Then userspace can enable hw dirty log
>    at the begining and disable it when dirty pages is little and about to
>    stop VM, so VM downtime is not affected.
> 
>    Multi-core offload: Offload the PT scanning workload to multi-core can
>    greatly reduce scanning time. To promise we can complete in time, I use
>    smp_call_fuction to realize this policy, which utilize IPI to dispatch
>    workload to other CPUs. Under 128U Kunpeng 920 platform, it just takes
>    about 5ms to scan PTs of 256 RAM (use mempress and almost all PTs have
>    been established). And We dispatch workload iterately (every CPU just
>    scan PTs of 512M RAM for each iteration), so it won't affect physical
>    CPUs seriously.

What do you think of these two methods to solve high-cost PTs scaning? Maybe
you are waiting for PML like feature on ARM :-) , but for my test, DBM is usable
after these two methods applied.

Thanks,
Keqian
> 
> 3. About correctness: Only add DBM bit when PTE is already writable, so
>    we still have readonly PTE and some mechanisms which rely on readonly
>    PTs are not broken.
> 
> 4. About PTs modification races: There are two kinds of PTs modification.
>    
>    The first is adding or clearing specific bit, such as AF or RW. All
>    these operations have been converted to be atomic, avoid covering
>    dirty status set by hardware.
>    
>    The second is replacement, such as PTEs unmapping or changement. All
>    these operations will invoke kvm_set_pte finally. kvm_set_pte have
>    been converted to be atomic and we save the dirty status to underlying
>    bitmap if dirty status is coverred.
> 
> Change log:
> 
> v2:
>  - Address Steven's comments.
>  - Add support of parallel dirty log sync.
>  - Simplify and merge patches of v1.
> 
> v1:
>  - Address Catalin's comments.
> 
> Keqian Zhu (8):
>   KVM: arm64: Set DBM bit for writable PTEs
>   KVM: arm64: Scan PTEs to sync dirty log
>   KVM: arm64: Modify stage2 young mechanism to support hw DBM
>   KVM: arm64: Save stage2 PTE dirty status if it is covered
>   KVM: arm64: Steply write protect page table by mask bit
>   KVM: arm64: Add KVM_CAP_ARM_HW_DIRTY_LOG capability
>   KVM: arm64: Sync dirty log parallel
>   KVM: Omit dirty log sync in log clear if initially all set
> 
>  arch/arm64/include/asm/kvm_host.h |   5 +
>  arch/arm64/include/asm/kvm_mmu.h  |  43 ++++-
>  arch/arm64/kvm/arm.c              |  45 ++++-
>  arch/arm64/kvm/mmu.c              | 307 ++++++++++++++++++++++++++++--
>  arch/arm64/kvm/reset.c            |   5 +
>  include/uapi/linux/kvm.h          |   1 +
>  tools/include/uapi/linux/kvm.h    |   1 +
>  virt/kvm/kvm_main.c               |   3 +-
>  8 files changed, 389 insertions(+), 21 deletions(-)
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
