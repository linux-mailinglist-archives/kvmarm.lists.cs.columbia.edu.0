Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ADC265FA5A
	for <lists+kvmarm@lfdr.de>; Thu,  4 Jul 2019 16:57:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 37FA84A4CD;
	Thu,  4 Jul 2019 10:57:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ov33WYFtevsc; Thu,  4 Jul 2019 10:57:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 115674A4E1;
	Thu,  4 Jul 2019 10:57:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DB1E4A445
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jul 2019 10:56:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4BAMHdx1f9rf for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Jul 2019 10:56:57 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CCEE540217
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jul 2019 10:56:57 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E6428;
 Thu,  4 Jul 2019 07:56:57 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880B03F738;
 Thu,  4 Jul 2019 07:56:53 -0700 (PDT)
Subject: Re: [RFC v2 11/14] arm64: Move the ASID allocator code in a separate
 file
To: Julien Grall <julien.grall@arm.com>
References: <20190620130608.17230-1-julien.grall@arm.com>
 <20190620130608.17230-12-julien.grall@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <3e6c6636-8522-ab4a-0183-ae0198a7a047@arm.com>
Date: Thu, 4 Jul 2019 15:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620130608.17230-12-julien.grall@arm.com>
Content-Language: en-GB
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

Hi Julien,

On 20/06/2019 14:06, Julien Grall wrote:
> We will want to re-use the ASID allocator in a separate context (e.g
> allocating VMID). So move the code in a new file.
> 
> The function asid_check_context has been moved in the header as a static
> inline function because we want to avoid add a branch when checking if the
> ASID is still valid.

> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 3df63a28856c..b745cf356fe1 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -23,46 +23,21 @@

> -#define ASID_FIRST_VERSION(info)	NUM_ASIDS(info)

> diff --git a/arch/arm64/lib/asid.c b/arch/arm64/lib/asid.c
> new file mode 100644
> index 000000000000..7252e4fdd5e9
> --- /dev/null
> +++ b/arch/arm64/lib/asid.c
> @@ -0,0 +1,185 @@

> +#define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))

(oops!)


> @@ -344,7 +115,7 @@ static int asids_init(void)
>  	if (!asid_allocator_init(&asid_info, bits, ASID_PER_CONTEXT,
>  				 asid_flush_cpu_ctxt))
>  		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
> -		      1UL << bits);
> +		      NUM_ASIDS(&asid_info));

Could this go in the patch that adds NUM_ASIDS()?


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
