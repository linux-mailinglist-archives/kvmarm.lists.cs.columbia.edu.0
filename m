Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 860963E5F0A
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 17:00:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EC925406E7;
	Tue, 10 Aug 2021 11:00:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qlzS3xE0AXz; Tue, 10 Aug 2021 11:00:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 702E64A3A5;
	Tue, 10 Aug 2021 11:00:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BFCB6406E0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 11:00:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLqnFjTQ-WBE for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Aug 2021 11:00:16 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B608A4A2E5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 11:00:16 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D818F1FB;
 Tue, 10 Aug 2021 08:00:15 -0700 (PDT)
Received: from [10.163.67.89] (unknown [10.163.67.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4943F718;
 Tue, 10 Aug 2021 08:00:12 -0700 (PDT)
Subject: Re: [PATCH] arm64/perf: Replace '0xf' instances with
 ID_AA64DFR0_PMUVER_IMP_DEF
To: Will Deacon <will@kernel.org>
References: <1628571998-13634-1-git-send-email-anshuman.khandual@arm.com>
 <20210810133101.GD2946@willie-the-truck>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <995fce58-d1fa-9f0f-b8bd-05e689330482@arm.com>
Date: Tue, 10 Aug 2021 20:31:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810133101.GD2946@willie-the-truck>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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



On 8/10/21 7:01 PM, Will Deacon wrote:
> On Tue, Aug 10, 2021 at 10:36:38AM +0530, Anshuman Khandual wrote:
>> ID_AA64DFR0_PMUVER_IMP_DEF which indicate implementation defined PMU, never
>> actually gets used although there are '0xf' instances scattered all around.
>> Just do the macro replacement to improve readability.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v5.14-rc5
>>
>>  arch/arm64/include/asm/cpufeature.h | 2 +-
>>  arch/arm64/kernel/perf_event.c      | 2 +-
>>  arch/arm64/kvm/perf.c               | 2 +-
>>  arch/arm64/kvm/pmu-emul.c           | 6 +++---
>>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> Please can you split this with the KVM parts in their own patch?

Sure, will do.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
