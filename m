Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAD31354
	for <lists+kvmarm@lfdr.de>; Fri, 31 May 2019 19:03:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A08A4A4F4;
	Fri, 31 May 2019 13:03:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kvUAefq7JdT; Fri, 31 May 2019 13:03:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14F204A369;
	Fri, 31 May 2019 13:03:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E40FC4A369
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:03:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QeLrOUfv+cDP for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 May 2019 13:03:45 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A91ED4A331
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:03:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CC5515AD;
 Fri, 31 May 2019 10:03:45 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91A723F59C;
 Fri, 31 May 2019 10:03:43 -0700 (PDT)
Date: Fri, 31 May 2019 18:03:40 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH kvmtool v3 3/9] update_headers.sh: arm64: Copy
 sve_context.h if available
Message-ID: <20190531180340.047189da@donnerap.cambridge.arm.com>
In-Reply-To: <1559229194-3036-4-git-send-email-Dave.Martin@arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
 <1559229194-3036-4-git-send-email-Dave.Martin@arm.com>
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

On Thu, 30 May 2019 16:13:08 +0100
Dave Martin <Dave.Martin@arm.com> wrote:

> The SVE KVM support for arm64 includes the additional backend
> header <asm/sve_context.h> from <asm/kvm.h>.
> 
> So update this header if it is available.
> 
> To avoid creating a sudden dependency on a specific minimum kernel
> version, ignore the header if the source kernel tree doesn't have
> it.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  util/update_headers.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/util/update_headers.sh b/util/update_headers.sh
> index a7e21b8..90d3ead 100755
> --- a/util/update_headers.sh
> +++ b/util/update_headers.sh
> @@ -25,11 +25,22 @@ fi
>  
>  cp -- "$LINUX_ROOT/include/uapi/linux/kvm.h" include/linux
>  
> +unset KVMTOOL_PATH
> +
> +copy_arm64 () {
> +	local src=$LINUX_ROOT/arch/$arch/include/uapi/asm/sve_context.h

To go with your previous patches, aren't you missing the quotes here?

> +
> +	if [ -e "$src" ]
> +	then
> +		cp -- "$src" "$KVMTOOL_PATH/include/asm"
> +	fi
> +}
> +

Maybe we can make this slightly more generic?
copy_optional_arch() {
	local src="$LINUX_ROOT/arch/$arch/include/uapi/$1"
	[ -r "$src" ] && cp -- "$src" "$KVMTOOL_PATH/include/asm"
}
...
	arm64) KVMTOOL_PATH=arm/aarch64
	       copy_optional_arch asm/sve_context.h
	       ;;

Cheers,
Andre.


>  for arch in arm arm64 mips powerpc x86
>  do
>  	case "$arch" in
>  		arm) KVMTOOL_PATH=arm/aarch32 ;;
> -		arm64) KVMTOOL_PATH=arm/aarch64 ;;
> +		arm64) KVMTOOL_PATH=arm/aarch64; copy_arm64 ;;
>  		*) KVMTOOL_PATH=$arch ;;
>  	esac
>  	cp -- "$LINUX_ROOT/arch/$arch/include/uapi/asm/kvm.h" \

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
