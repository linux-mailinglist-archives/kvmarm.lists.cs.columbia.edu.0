Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB774DABF6
	for <lists+kvmarm@lfdr.de>; Wed, 16 Mar 2022 08:44:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5676D49F22;
	Wed, 16 Mar 2022 03:44:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpkIexXlQLxK; Wed, 16 Mar 2022 03:44:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03EA849F1F;
	Wed, 16 Mar 2022 03:44:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4B7149F16
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 03:44:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0fmvIPzsW3PY for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Mar 2022 03:44:03 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 891BC408AB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 03:44:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647416643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mam8w85mLQbLuV3GPQ8EDdLw0BD02xApA60diEvmkn4=;
 b=Lp/nsaEeMxaQaHw+Rl5evjNwsXnkPlSIHy52qbUghUPcFlL8RVY5Cynk2W+jjm2CRU1I8z
 JwujbF0V0TtC9ey5jhYJQ6Q2+ErfVAAPmi0wis8eSwtBvA234bS56ReXw2TA9ANRgcl1LU
 OfDx6ggdcoCxcarTUYqjB8PnAJUYrko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-M-i-lkAeOo23JZHWt1wY_Q-1; Wed, 16 Mar 2022 03:43:59 -0400
X-MC-Unique: M-i-lkAeOo23JZHWt1wY_Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 a26-20020a7bc1da000000b003857205ec7cso732477wmj.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 00:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mam8w85mLQbLuV3GPQ8EDdLw0BD02xApA60diEvmkn4=;
 b=lbqoKcmRzs7xoVEqwDao+VfSfAiGKgUaoP8wa5ozYHHErFYTh6C541haE19K3sYdB5
 6l5LM5jojvmCHYYjSK9U3HAEi3Kea9a5Ul67baRc9XRO1GGXn6PmXXNztyHBb1miIUhB
 G37i73MClObWfk8up7/u01F9i3Vk1F+yMqJdm0k3nKSTb2RwnDA3N9riAxwhR9LY8kWz
 S1Zw86iG1cdCbEbrrG+pRTcjdMnGmNjdct17P0VF13LNDD8UUOb22moTuAPiVjddLZUF
 fJx7BHn+JdJO7Qyu/RQgNDZEf2Iqajrft8zGqEQcHIS470FwVaenVDoRjlgZe/XW3L7G
 45Xw==
X-Gm-Message-State: AOAM532/++RPFYwSsUK6Q94OHcCC+HqSRxQ35UE6MvFltUjq6IytjiUG
 l+XTzx6ld75cerXbN0emKzmCiVOzJvhSiyw1yblLnt9Iz7SyNOpHuaON3wf8jDpbRPPLarvm/PR
 KFNWcujHpCZ2U7u25SPY94m9H
X-Received: by 2002:a05:6000:3c3:b0:203:6976:6942 with SMTP id
 b3-20020a05600003c300b0020369766942mr22674968wrg.584.1647416638728; 
 Wed, 16 Mar 2022 00:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiO62Yr0EsUOjjzC1evZxOKsDkUVAOuXWop4OtVqEPPMKVE+73MXHoDL8nCf5FamNh4qQ6+g==
X-Received: by 2002:a05:6000:3c3:b0:203:6976:6942 with SMTP id
 b3-20020a05600003c300b0020369766942mr22674955wrg.584.1647416638514; 
 Wed, 16 Mar 2022 00:43:58 -0700 (PDT)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a5d6da7000000b00203d9d1875bsm984282wrs.73.2022.03.16.00.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 00:43:58 -0700 (PDT)
Date: Wed, 16 Mar 2022 08:43:56 +0100
From: Andrew Jones <drjones@redhat.com>
To: Bill Wendling <morbo@google.com>
Subject: Re: [kvm-unit-tests PATCH] libfdt: use logical "or" instead of
 bitwise "or" with boolean operands
Message-ID: <20220316074356.n7e5lzrmnal2dcgu@gator>
References: <20220316060214.2200695-1-morbo@google.com>
MIME-Version: 1.0
In-Reply-To: <20220316060214.2200695-1-morbo@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, linux-s390@vger.kernel.org, thuth@redhat.com,
 frankja@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com,
 kvm-ppc@vger.kernel.org, Nikos Nikoleris <nikos.nikoleris@arm.com>,
 pbonzini@redhat.com, imbrenda@linux.ibm.com, kvmarm@lists.cs.columbia.edu
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

On Tue, Mar 15, 2022 at 11:02:14PM -0700, Bill Wendling wrote:
> Clang warns about using a bitwise '|' with boolean operands. This seems
> to be due to a small typo.
> 
>   lib/libfdt/fdt_rw.c:438:6: warning: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>           if (can_assume(LIBFDT_ORDER) |
> 
> Using '||' removes this warnings.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  lib/libfdt/fdt_rw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/libfdt/fdt_rw.c b/lib/libfdt/fdt_rw.c
> index 13854253ff86..3320e5559cac 100644
> --- a/lib/libfdt/fdt_rw.c
> +++ b/lib/libfdt/fdt_rw.c
> @@ -435,7 +435,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
>  			return struct_size;
>  	}
>  
> -	if (can_assume(LIBFDT_ORDER) |
> +	if (can_assume(LIBFDT_ORDER) ||
>  	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
>  		/* no further work necessary */
>  		err = fdt_move(fdt, buf, bufsize);
> -- 
> 2.35.1.723.g4982287a31-goog
>

This is fixed in libfdt upstream with commit 7be250b4 ("libfdt:
Correct condition for reordering blocks"), which is in v1.6.1.
We can either take this patch as a backport of 7be250b4 or we
can rebase all of our libfdt to v1.6.1. Based on the number of
fixes in v1.6.1, which appear to be mostly for compiling with
later compilers, I'm in favor of rebasing.

Actually, we can also use this opportunity to [re]visit the
idea of changing libfdt to a git submodule. I'd like to hear
opinions on that.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
