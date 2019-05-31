Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CC32D31347
	for <lists+kvmarm@lfdr.de>; Fri, 31 May 2019 19:03:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F06D4A4E8;
	Fri, 31 May 2019 13:03:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gS60EK-kqZRq; Fri, 31 May 2019 13:03:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EC7B4A4E5;
	Fri, 31 May 2019 13:03:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 065284A3BB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:03:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 264YqQEEDbr0 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 May 2019 13:03:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 946B14A3A3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:03:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB004A78;
 Fri, 31 May 2019 10:03:00 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BC933F59C;
 Fri, 31 May 2019 10:02:58 -0700 (PDT)
Date: Fri, 31 May 2019 18:02:53 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH kvmtool v3 1/9] update_headers.sh: Add missing shell
 quoting
Message-ID: <20190531180253.1ca3f7f6@donnerap.cambridge.arm.com>
In-Reply-To: <1559229194-3036-2-git-send-email-Dave.Martin@arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
 <1559229194-3036-2-git-send-email-Dave.Martin@arm.com>
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

On Thu, 30 May 2019 16:13:06 +0100
Dave Martin <Dave.Martin@arm.com> wrote:

> update_headers.sh can break if the current working directory has a
> funny name or if something odd is passed for LINUX_ROOT.

Do you actually have spaces in your Linux path? ;-)
 
> In the interest of cleanliness, quote where appropriate.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Looks alright to me:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
>  util/update_headers.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/util/update_headers.sh b/util/update_headers.sh
> index 2d93646..4ba1b9f 100755
> --- a/util/update_headers.sh
> +++ b/util/update_headers.sh
> @@ -11,17 +11,17 @@ if [ "$#" -ge 1 ]
>  then
>  	LINUX_ROOT="$1"
>  else
> -	LINUX_ROOT=/lib/modules/$(uname -r)/source
> +	LINUX_ROOT="/lib/modules/$(uname -r)/source"
>  fi
>  
> -if [ ! -d $LINUX_ROOT/include/uapi/linux ]
> +if [ ! -d "$LINUX_ROOT/include/uapi/linux" ]
>  then
>  	echo "$LINUX_ROOT does not seem to be valid Linux source tree."
>  	echo "usage: $0 [path-to-Linux-source-tree]"
>  	exit 1
>  fi
>  
> -cp $LINUX_ROOT/include/uapi/linux/kvm.h include/linux
> +cp -- "$LINUX_ROOT/include/uapi/linux/kvm.h" include/linux
>  
>  for arch in arm arm64 mips powerpc x86
>  do
> @@ -30,6 +30,6 @@ do
>  		arm64) KVMTOOL_PATH=arm/aarch64 ;;
>  		*) KVMTOOL_PATH=$arch ;;
>  	esac
> -	cp $LINUX_ROOT/arch/$arch/include/uapi/asm/kvm.h \
> -		$KVMTOOL_PATH/include/asm
> +	cp -- "$LINUX_ROOT/arch/$arch/include/uapi/asm/kvm.h" \
> +		"$KVMTOOL_PATH/include/asm"
>  done

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
