Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9733E254AA5
	for <lists+kvmarm@lfdr.de>; Thu, 27 Aug 2020 18:25:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD6ED4BFD9;
	Thu, 27 Aug 2020 12:25:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pg2cCzOrARqw; Thu, 27 Aug 2020 12:25:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 69A084BFCB;
	Thu, 27 Aug 2020 12:25:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AC7754BFBC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Aug 2020 12:25:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id adW99EKVLNJ9 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 Aug 2020 12:25:07 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 457534BFBB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Aug 2020 12:25:07 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE0631B;
 Thu, 27 Aug 2020 09:25:06 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1673F66B;
 Thu, 27 Aug 2020 09:25:05 -0700 (PDT)
Subject: Re: [PATCH v3 00/21] KVM: arm64: Rewrite page-table code and fault
 handling
To: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
References: <20200825093953.26493-1-will@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <2281278d-03fe-d824-2a51-b494417f7c8b@arm.com>
Date: Thu, 27 Aug 2020 17:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825093953.26493-1-will@kernel.org>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>
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

Hi Will,

I've been looking into pinning guest memory for KVM SPE, so I like to think that
the stage 2 page table code is not entirely alien to me. I'll do my best to review
the series, I hope you'll find it useful.

Thanks,

Alex

On 8/25/20 10:39 AM, Will Deacon wrote:
> Hello folks,
>
> This is version three of the KVM page-table rework that I previously posted
> here:
>
>   v1: https://lore.kernel.org/r/20200730153406.25136-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20200818132818.16065-1-will@kernel.org
>
> Changes since v2 include:
>
>   * Rebased onto -rc2, which includes the conflicting OOM blocking fixes
>   * Dropped the patch trying to "fix" the memcache in kvm_phys_addr_ioremap()
>
> Cheers,
>
> Will
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: kernel-team@android.com
> Cc: linux-arm-kernel@lists.infradead.org
>
> --->8
>
> Quentin Perret (4):
>   KVM: arm64: Add support for stage-2 write-protect in generic
>     page-table
>   KVM: arm64: Convert write-protect operation to generic page-table API
>   KVM: arm64: Add support for stage-2 cache flushing in generic
>     page-table
>   KVM: arm64: Convert memslot cache-flushing code to generic page-table
>     API
>
> Will Deacon (17):
>   KVM: arm64: Remove kvm_mmu_free_memory_caches()
>   KVM: arm64: Add stand-alone page-table walker infrastructure
>   KVM: arm64: Add support for creating kernel-agnostic stage-1 page
>     tables
>   KVM: arm64: Use generic allocator for hyp stage-1 page-tables
>   KVM: arm64: Add support for creating kernel-agnostic stage-2 page
>     tables
>   KVM: arm64: Add support for stage-2 map()/unmap() in generic
>     page-table
>   KVM: arm64: Convert kvm_phys_addr_ioremap() to generic page-table API
>   KVM: arm64: Convert kvm_set_spte_hva() to generic page-table API
>   KVM: arm64: Convert unmap_stage2_range() to generic page-table API
>   KVM: arm64: Add support for stage-2 page-aging in generic page-table
>   KVM: arm64: Convert page-aging and access faults to generic page-table
>     API
>   KVM: arm64: Add support for relaxing stage-2 perms in generic
>     page-table code
>   KVM: arm64: Convert user_mem_abort() to generic page-table API
>   KVM: arm64: Check the pgt instead of the pgd when modifying page-table
>   KVM: arm64: Remove unused page-table code
>   KVM: arm64: Remove unused 'pgd' field from 'struct kvm_s2_mmu'
>   KVM: arm64: Don't constrain maximum IPA size based on host
>     configuration
>
>  arch/arm64/include/asm/kvm_host.h       |    2 +-
>  arch/arm64/include/asm/kvm_mmu.h        |  221 +---
>  arch/arm64/include/asm/kvm_pgtable.h    |  279 ++++
>  arch/arm64/include/asm/pgtable-hwdef.h  |   23 -
>  arch/arm64/include/asm/pgtable-prot.h   |   19 -
>  arch/arm64/include/asm/stage2_pgtable.h |  215 ----
>  arch/arm64/kvm/arm.c                    |    2 +-
>  arch/arm64/kvm/hyp/Makefile             |    2 +-
>  arch/arm64/kvm/hyp/pgtable.c            |  860 +++++++++++++
>  arch/arm64/kvm/mmu.c                    | 1566 +++--------------------
>  arch/arm64/kvm/reset.c                  |   38 +-
>  11 files changed, 1326 insertions(+), 1901 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kvm_pgtable.h
>  create mode 100644 arch/arm64/kvm/hyp/pgtable.c
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
