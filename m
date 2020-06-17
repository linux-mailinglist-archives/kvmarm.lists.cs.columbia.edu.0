Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6373F1FCDEF
	for <lists+kvmarm@lfdr.de>; Wed, 17 Jun 2020 14:57:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE1794B25B;
	Wed, 17 Jun 2020 08:57:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sK0NjVgQSSUU; Wed, 17 Jun 2020 08:57:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC9384B24D;
	Wed, 17 Jun 2020 08:57:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 61EC64B24C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jun 2020 08:57:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CGgrw70noJFr for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Jun 2020 08:57:48 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C4664B236
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jun 2020 08:57:48 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF301045;
 Wed, 17 Jun 2020 05:57:47 -0700 (PDT)
Received: from [10.37.8.7] (unknown [10.37.8.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62F53F73C;
 Wed, 17 Jun 2020 05:57:44 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] KVM: arm64: Factor out stage 2 page table data
 from struct kvm
To: Marc Zyngier <maz@kernel.org>
References: <20200615132719.1932408-1-maz@kernel.org>
 <20200615132719.1932408-2-maz@kernel.org>
 <17d37bde-2fc8-d165-ee02-7640fc561167@arm.com>
 <9c0044564885d3356f76b55f35426987@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <42103fc0-fc87-960f-a83a-25e555613295@arm.com>
Date: Wed, 17 Jun 2020 13:58:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9c0044564885d3356f76b55f35426987@kernel.org>
Content-Language: en-US
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andre Przywara <andre.przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
 Will Deacon <will@kernel.org>, George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com,
 Dave Martin <Dave.Martin@arm.com>
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

On 6/16/20 5:18 PM, Marc Zyngier wrote:
> Hi Alexandru,
>
> On 2020-06-16 16:59, Alexandru Elisei wrote:
>> Hi,
>>
>> IMO, this patch does two different things: adds a new structure, kvm_s2_mmu, and
>> converts the memory management code to use the 4 level page table API. I realize
>> it's painful to convert the MMU code to use the p4d functions, and then modify
>> everything to use kvm_s2_mmu in a separate patch, but I believe
>> splitting it into
>> 2 would be better in the long run. The resulting patches will be
>> smaller and both
>> will have a better chance of being reviewed by the right people.
>
> I'm not sure how you want me to do this. The whole p4d mess is already in
> mainline (went via akpm directly to Linus), and I can't really revert it.

Silly me, I thought that *this* patch adds the p4d functions, but in fact they
were added in commit e9f6376858b9 ("arm64: add support for folded p4d page
tables"). Sorry for the noise, will pay more attention next time.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
