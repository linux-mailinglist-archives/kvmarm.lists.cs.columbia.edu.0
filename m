Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EC33921399D
	for <lists+kvmarm@lfdr.de>; Fri,  3 Jul 2020 13:54:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 182C34B178;
	Fri,  3 Jul 2020 07:54:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6OqHM+qg8Tsh; Fri,  3 Jul 2020 07:54:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3DA74B0F5;
	Fri,  3 Jul 2020 07:54:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F6274B0BE
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Jul 2020 07:54:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-VGSz2KjYRA for <kvmarm@lists.cs.columbia.edu>;
 Fri,  3 Jul 2020 07:54:40 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E0D3E4B153
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Jul 2020 07:54:40 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DEDB2F;
 Fri,  3 Jul 2020 04:54:40 -0700 (PDT)
Received: from [10.163.85.168] (unknown [10.163.85.168])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64ED53F68F;
 Fri,  3 Jul 2020 04:54:37 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1590548619-3441-1-git-send-email-anshuman.khandual@arm.com>
 <20200702173403.GI22241@gaia>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5a66d9a0-7ada-d0b0-f768-9901494175e4@arm.com>
Date: Fri, 3 Jul 2020 17:24:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200702173403.GI22241@gaia>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu



On 07/02/2020 11:04 PM, Catalin Marinas wrote:
> On Wed, May 27, 2020 at 08:33:35AM +0530, Anshuman Khandual wrote:
>> These are remaining patches from V4 series which had some pending reviews
>> from Suzuki (https://patchwork.kernel.org/cover/11557333/). Also dropped
>> [PATCH 15/17] as that will need some more investigation and rework.
>>
>> This series applies on arm64/for-next/cpufeature.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com> 
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
> 
> Thanks Suzuki for review.
> 
> Anshuman, could you please rebase this series on top of 5.8-rc3? It no
> longer applies cleanly.

Already posted here.

https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=312281
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
