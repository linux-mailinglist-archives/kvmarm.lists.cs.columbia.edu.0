Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC99350161
	for <lists+kvmarm@lfdr.de>; Wed, 31 Mar 2021 15:39:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D00DB4B41F;
	Wed, 31 Mar 2021 09:39:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ni5uKxA15yrv; Wed, 31 Mar 2021 09:39:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6B004B410;
	Wed, 31 Mar 2021 09:39:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD2894B3CA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 09:39:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWqgWZtV-zYw for <kvmarm@lists.cs.columbia.edu>;
 Wed, 31 Mar 2021 09:39:05 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 863D34B3D9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 09:39:05 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13C4DD6E;
 Wed, 31 Mar 2021 06:39:05 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1DCF3F694;
 Wed, 31 Mar 2021 06:39:03 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: Elect Alexandru as a replacement for Julien
 as a reviewer
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210331131620.4005931-1-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <4a55b56b-5a47-9ccd-566c-f75961a85970@arm.com>
Date: Wed, 31 Mar 2021 14:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331131620.4005931-1-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com
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

On 3/31/21 2:16 PM, Marc Zyngier wrote:
> Julien's bandwidth for KVM reviewing has been pretty low lately,
> and Alexandru has accepted to step in and help with the reviewing.
>
> Many thanks to both!

Happy to help!

Acked-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa84121c5611..803bd0551512 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9765,7 +9765,7 @@ F:	virt/kvm/*
>  KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
>  M:	Marc Zyngier <maz@kernel.org>
>  R:	James Morse <james.morse@arm.com>
> -R:	Julien Thierry <julien.thierry.kdev@gmail.com>
> +R:	Alexandru Elisei <alexandru.elisei@arm.com>
>  R:	Suzuki K Poulose <suzuki.poulose@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	kvmarm@lists.cs.columbia.edu
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
