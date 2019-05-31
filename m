Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 80DCB3134D
	for <lists+kvmarm@lfdr.de>; Fri, 31 May 2019 19:03:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D14B4A4F6;
	Fri, 31 May 2019 13:03:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibNLt73Nwnxu; Fri, 31 May 2019 13:03:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C080A4A4E8;
	Fri, 31 May 2019 13:03:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ED65F4A4A9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:03:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xkPmVMDcZVf0 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 May 2019 13:03:15 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 92E3A4A3BB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:03:15 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17ACAA78;
 Fri, 31 May 2019 10:03:15 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB863F59C;
 Fri, 31 May 2019 10:03:13 -0700 (PDT)
Date: Fri, 31 May 2019 18:03:10 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH kvmtool v3 2/9] update_headers.sh: Cleanly report
 failure on error
Message-ID: <20190531180310.2305008c@donnerap.cambridge.arm.com>
In-Reply-To: <1559229194-3036-3-git-send-email-Dave.Martin@arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
 <1559229194-3036-3-git-send-email-Dave.Martin@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Thu, 30 May 2019 16:13:07 +0100
Dave Martin <Dave.Martin@arm.com> wrote:

> If in intermediate step fails, update_headers.sh blindly continues
> and may return success status.
> 
> To avoid errors going unnoticed when driving this script, exit and
> report failure status as soon as something goes wrong.  For good
> measure, also fail on expansion of undefined shell variables to aid
> future maintainers.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Both "u" and "e" seem to be standard and work in dash and ash, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre.

> ---
>  util/update_headers.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/util/update_headers.sh b/util/update_headers.sh
> index 4ba1b9f..a7e21b8 100755
> --- a/util/update_headers.sh
> +++ b/util/update_headers.sh
> @@ -7,6 +7,8 @@
>  # using the lib/modules/`uname -r`/source link.
>  ########################################################################
>  
> +set -ue
> +
>  if [ "$#" -ge 1 ]
>  then
>  	LINUX_ROOT="$1"

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
