Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0DBF3AC
	for <lists+kvmarm@lfdr.de>; Thu, 26 Sep 2019 15:06:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C26724A716;
	Thu, 26 Sep 2019 09:06:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKGes3E0JUaJ; Thu, 26 Sep 2019 09:06:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 862944A6F4;
	Thu, 26 Sep 2019 09:06:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A79C4A6BC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Sep 2019 09:06:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0nFukDtnEu5 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Sep 2019 09:06:17 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 268A24A5A3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Sep 2019 09:06:17 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58226142F;
 Thu, 26 Sep 2019 06:06:16 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B6E63F763;
 Thu, 26 Sep 2019 06:06:14 -0700 (PDT)
Subject: Re: [RFC PATCH v4 2/5] ptp: Reorganize ptp_kvm modules to make it
 arch-independent.
To: Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
 yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
 pbonzini@redhat.com, sean.j.christopherson@intel.com, maz@kernel.org,
 richardcochran@gmail.com, Mark.Rutland@arm.com, Will.Deacon@arm.com
References: <20190926114212.5322-1-jianyong.wu@arm.com>
 <20190926114212.5322-3-jianyong.wu@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2f338b57-b0b2-e439-6089-72e5f5e4f017@arm.com>
Date: Thu, 26 Sep 2019 14:06:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190926114212.5322-3-jianyong.wu@arm.com>
Content-Language: en-US
Cc: justin.he@arm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 nd@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Jianyong,

On 26/09/2019 12:42, Jianyong Wu wrote:
> Currently, ptp_kvm modules implementation is only for x86 which includs
> large part of arch-specific code.  This patch move all of those code
> into new arch related file in the same directory.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>   drivers/ptp/Makefile                 |  1 +
>   drivers/ptp/{ptp_kvm.c => kvm_ptp.c} | 77 ++++++------------------
>   drivers/ptp/ptp_kvm_x86.c            | 87 ++++++++++++++++++++++++++++
>   include/asm-generic/ptp_kvm.h        | 12 ++++
>   4 files changed, 118 insertions(+), 59 deletions(-)
>   rename drivers/ptp/{ptp_kvm.c => kvm_ptp.c} (63%)

minor nit: Could we not skip renaming the file ? Given
you are following the ptp_kvm_* for the arch specific
files and the header files, wouldn't it be good to
keep ptp_kvm.c ?

Rest looks fine.

Cheers
Suzuki
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
