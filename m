Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6271C100A
	for <lists+kvmarm@lfdr.de>; Fri,  1 May 2020 10:51:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 04F394B5A9;
	Fri,  1 May 2020 04:51:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3WQpaKdcXLIl; Fri,  1 May 2020 04:51:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD57A4B542;
	Fri,  1 May 2020 04:51:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B3684B542
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 May 2020 04:51:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id voSxyS46-LWn for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 May 2020 04:51:22 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 43AAF4B2B1
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 May 2020 04:51:22 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6BF41FB;
 Fri,  1 May 2020 01:51:21 -0700 (PDT)
Received: from [10.37.12.139] (unknown [10.37.12.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3373F305;
 Fri,  1 May 2020 01:51:19 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] KVM: arm64: Update help text
To: tabba@google.com, maz@kernel.org, catalin.marinas@arm.com,
 julien.thierry.kdev@gmail.com, kvmarm@lists.cs.columbia.edu
References: <20200421131734.141766-1-tabba@google.com>
 <20200421131734.141766-3-tabba@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <170ec871-be60-a150-5c3e-2dc9a3366f36@arm.com>
Date: Fri, 1 May 2020 09:56:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200421131734.141766-3-tabba@google.com>
Content-Language: en-US
Cc: will@kernel.org
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

On 04/21/2020 02:17 PM, Fuad Tabba wrote:
> From: Will Deacon <will@kernel.org>
> 
> arm64 KVM supports 16k pages since 02e0b7600f83
> ("arm64: kvm: Add support for 16K pages"), so update the Kconfig help
> text accordingly.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>   arch/arm64/kvm/Kconfig | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index ce724e526689..d2cf4f099454 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -44,8 +44,6 @@ config KVM
>   	select TASK_DELAY_ACCT
>   	---help---
>   	  Support hosting virtualized guest machines.
> -	  We don't support KVM with 16K page tables yet, due to the multiple
> -	  levels of fake page tables.
>   
>   	  If unsure, say N.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
