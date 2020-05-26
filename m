Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE21A99D7
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 12:04:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 051094B24C;
	Wed, 15 Apr 2020 06:04:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hL1+sZ7blI6; Wed, 15 Apr 2020 06:04:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D140A4B23C;
	Wed, 15 Apr 2020 06:04:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C2F394B235
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 06:04:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4uB+Tq2zJAUS for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 06:04:25 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 976734B1DC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 06:04:25 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 416D71063;
 Wed, 15 Apr 2020 03:04:25 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6CDD3F68F;
 Wed, 15 Apr 2020 03:04:22 -0700 (PDT)
Subject: Re: [PATCH 2/8] arm64: cpufeature: Spell out register fields for
 ID_ISAR4 and ID_PFR1
To: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-3-will@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <632b7ace-a7db-a961-b9eb-c9c303376fcd@arm.com>
Date: Wed, 15 Apr 2020 11:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-3-will@kernel.org>
Content-Language: en-US
Cc: saiprakash.ranjan@codeaurora.org, anshuman.khandual@arm.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, dianders@chromium.org, catalin.marinas@arm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 04/14/2020 10:31 PM, Will Deacon wrote:
> In preparation for runtime updates to the strictness of some AArch32
> features, spell out the register fields for ID_ISAR4 and ID_PFR1 to make
> things clearer to read. Note that this isn't functionally necessary, as
> the feature arrays themselves are not modified dynamically and remain
> 'const'.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/include/asm/sysreg.h | 17 +++++++++++++++++
>   arch/arm64/kernel/cpufeature.c  | 28 ++++++++++++++++++++++++++--
>   2 files changed, 43 insertions(+), 2 deletions(-)

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
