Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF54D1509
	for <lists+kvmarm@lfdr.de>; Tue,  8 Mar 2022 11:45:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F05A749EE1;
	Tue,  8 Mar 2022 05:45:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtJp2X19u07z; Tue,  8 Mar 2022 05:45:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFED449EC1;
	Tue,  8 Mar 2022 05:45:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DF4E49EB4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Mar 2022 05:45:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QKAKbv4ykVx for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Mar 2022 05:45:50 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD48749EAA
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Mar 2022 05:45:50 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD5F1FB;
 Tue,  8 Mar 2022 02:45:50 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E71D23FA45;
 Tue,  8 Mar 2022 02:45:48 -0800 (PST)
Date: Tue, 8 Mar 2022 10:46:10 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH kvmtool v8 3/3] Add --no-pvtime command line argument
Message-ID: <Yicz4klF1ecWDu45@monolith.localdoman>
References: <20220307144243.2039409-1-sebastianene@google.com>
 <20220307144243.2039409-4-sebastianene@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220307144243.2039409-4-sebastianene@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, will@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

Hi,

Looks good to me:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,
Alex

On Mon, Mar 07, 2022 at 02:42:44PM +0000, Sebastian Ene wrote:
> The command line argument disables the stolen time functionality when is
> specified.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  builtin-run.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/builtin-run.c b/builtin-run.c
> index 9a1a0c1..7c8be9d 100644
> --- a/builtin-run.c
> +++ b/builtin-run.c
> @@ -128,6 +128,8 @@ void kvm_run_set_wrapper_sandbox(void)
>  			" rootfs"),					\
>  	OPT_STRING('\0', "hugetlbfs", &(cfg)->hugetlbfs_path, "path",	\
>  			"Hugetlbfs path"),				\
> +	OPT_BOOLEAN('\0', "no-pvtime", &(cfg)->no_pvtime, "Disable"	\
> +			" stolen time"),				\
>  									\
>  	OPT_GROUP("Kernel options:"),					\
>  	OPT_STRING('k', "kernel", &(cfg)->kernel_filename, "kernel",	\
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
