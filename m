Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A51A9C51
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 13:32:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 31E9E4B17F;
	Wed, 15 Apr 2020 07:32:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kmwHQ56tVZdx; Wed, 15 Apr 2020 07:32:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FF904B11D;
	Wed, 15 Apr 2020 07:32:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 353D64B0FD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 07:32:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AKLWpBuFVNEa for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 07:32:46 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 165364B0FA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 07:32:46 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8470B1063;
 Wed, 15 Apr 2020 04:32:45 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCAB13F68F;
 Wed, 15 Apr 2020 04:32:42 -0700 (PDT)
Subject: Re: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support
 at EL[0-2]
To: will@kernel.org
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-8-will@kernel.org>
 <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
 <20200415105843.GE12621@willie-the-truck>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d1f538ec-e956-c136-d0f8-54e7351a28a9@arm.com>
Date: Wed, 15 Apr 2020 12:37:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200415105843.GE12621@willie-the-truck>
Content-Language: en-US
Cc: saiprakash.ranjan@codeaurora.org, anshuman.khandual@arm.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, dianders@chromium.org, catalin.marinas@arm.com,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On 04/15/2020 11:58 AM, Will Deacon wrote:
> On Wed, Apr 15, 2020 at 11:50:58AM +0100, Suzuki K Poulose wrote:
>> On 04/14/2020 10:31 PM, Will Deacon wrote:
>>> We don't need to be quite as strict about mismatched AArch32 support,
>>> which is good because the friendly hardware folks have been busy
>>> mismatching this to their hearts' content.
>>>
>>>     * We don't care about EL2 or EL3 (there are silly comments concerning
>>>       the latter, so remove those)
>>>
>>>     * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
>>>       gracefully when a mismatch occurs
>>>
>>>     * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled
>>
>> s/EL1/EL0
>>
>>>       gracefully when a mismatch occurs
>>>
>>> Relax the AArch32 checks to FTR_NONSTRICT.
>>
>> Agreed. We should do something similar for the features exposed by the
>> ELF_HWCAP, of course in a separate series.
> 
> Hmm, I didn't think we needed to touch the HWCAPs, as they're derived from
> the sanitised feature register values. What am I missing?

sorry, that was cryptic. I was suggesting to relax the ftr fields to
NONSTRICT for the fields covered by ELF HWCAPs (and other CPU hwcaps).

Suzuki
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
