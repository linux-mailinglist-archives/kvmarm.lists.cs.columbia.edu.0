Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CF32A2698A8
	for <lists+kvmarm@lfdr.de>; Tue, 15 Sep 2020 00:13:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 66F6E4B25F;
	Mon, 14 Sep 2020 18:13:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Do9UmNnyOz1M; Mon, 14 Sep 2020 18:13:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5FD884B206;
	Mon, 14 Sep 2020 18:13:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 227BB4B1E8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 18:13:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWpwjwualwDG for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Sep 2020 18:13:17 -0400 (EDT)
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 37F244B1E1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 18:13:17 -0400 (EDT)
Received: by mail-pj1-f68.google.com with SMTP id v14so650290pjd.4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XKHeWnZTmr+44PA1uk+tmIoZZMZNVyaEbUZsmkorfxM=;
 b=FLfu5qkpDm7o5/xP0ilZmNxVe+jdmcJEkTL/4DGLQ5xUBs9smNtW0pRVX074Wodffb
 QUGa2sH5fudwFrwS49G9uXA9hzulhM+YqeS3JvomF2XSTDvvz161Ko8MHkn/a5Vkn26o
 2wUHbRjJ9JT+dslYXV4aBJuwNU5aQBs5Tz/Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XKHeWnZTmr+44PA1uk+tmIoZZMZNVyaEbUZsmkorfxM=;
 b=JQ07eQ3PwF372LBM5pI9yiN/kwODzsllyCn5U4NGRfMtA+I1I0SDYF0whoEsQqAIfK
 vYFGvCNnix4/sDwwn8jW1RmjFpTUEwyy4SquQ3yEaObJHwkWVOzMd8n2fXJjXw8kpR1n
 YoOiPXh1Sngtheb+eK9D2MztOOs/6gycd9jAdbP++eahJI+08RlNCFZVaPDEUYLy3WZG
 h+Ow0iXQLmcYQL1KPNlHmEOLz4o9Av+iQCXBUixc1dnf/g01eCe3NYTDqz89tn39xg1+
 SZ5ndOe4y5sEuUn7urpOfSibr9P0W6C9Ysx9tPz/oBg4ED6yG23AOTgc0KdcVAbPH/3N
 XMsQ==
X-Gm-Message-State: AOAM5321Fkirs244C7vWthDCm2+zxtJxqXGSwLLDWsI14cBhZ9KgdTC/
 PA1nIq4OnIiGOABSj53E3OcE8g==
X-Google-Smtp-Source: ABdhPJyn8NpGqIRjrEpOsVjRNLYYQTqkknDqHNXZZiqb/DFr4jKhXnJkQxxoYZIMjCxQkiwbcgTD4Q==
X-Received: by 2002:a17:90b:3505:: with SMTP id
 ls5mr1284670pjb.105.1600121596214; 
 Mon, 14 Sep 2020 15:13:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id i187sm9130990pgd.82.2020.09.14.15.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 15:13:15 -0700 (PDT)
Date: Mon, 14 Sep 2020 15:13:14 -0700
From: Kees Cook <keescook@chromium.org>
To: George-Aurelian Popescu <georgepope@google.com>
Subject: Re: [PATCH 06/14] Fix CFLAGS for UBSAN_BOUNDS on Clang
Message-ID: <202009141509.CDDC8C8@keescook>
References: <20200914172750.852684-1-georgepope@google.com>
 <20200914172750.852684-7-georgepope@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914172750.852684-7-georgepope@google.com>
Cc: tglx@linutronix.de, catalin.marinas@arm.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, maskray@google.com, maz@kernel.org,
 masahiroy@kernel.org, clang-built-linux@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, elver@google.com, arnd@arndb.de,
 linux-kbuild@vger.kernel.org, broonie@kernel.org, natechancellor@gmail.com,
 dvyukov@google.com, michal.lkml@markovi.net, ndesaulniers@google.com,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
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

On Mon, Sep 14, 2020 at 05:27:42PM +0000, George-Aurelian Popescu wrote:
> From: George Popescu <georgepope@google.com>
> 
> When the kernel is compiled with Clang, UBSAN_BOUNDS inserts a brk after
> the handler call, preventing it from printing any information processed
> inside the buffer.
> For Clang -fsanitize=bounds expands to -fsanitize=array-bounds and
> -fsanitize=local-bounds, and the latter adds a brk after the handler
> call

That sounds like a compiler bug?

> Signed-off-by: George Popescu <georgepope@google.com>
> ---
>  scripts/Makefile.ubsan | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 27348029b2b8..3d15ac346c97 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -4,7 +4,14 @@ ifdef CONFIG_UBSAN_ALIGNMENT
>  endif
>  
>  ifdef CONFIG_UBSAN_BOUNDS
> -      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> +      # For Clang -fsanitize=bounds translates to -fsanitize=array-bounds and
> +      # -fsanitize=local-bounds; the latter adds a brk right after the
> +      # handler is called.
> +      ifdef CONFIG_CC_IS_CLANG
> +            CFLAGS_UBSAN += $(call cc-option, -fsanitize=array-bounds)

This would mean losing the local-bounds coverage? Isn't that for locally
defined arrays on the stack?

> +      else
> +            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> +      endif
>  endif
>  
>  ifdef CONFIG_UBSAN_MISC
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 
Kees Cook
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
