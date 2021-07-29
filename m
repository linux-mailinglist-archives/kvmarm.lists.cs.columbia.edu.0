Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 893413DA976
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 18:52:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 187B740808;
	Thu, 29 Jul 2021 12:52:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8pv2kp3JkfAC; Thu, 29 Jul 2021 12:52:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FEA14086A;
	Thu, 29 Jul 2021 12:52:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EDC440573
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 12:52:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WjACuwxnS5am for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 12:52:53 -0400 (EDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3A4054048A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 12:52:53 -0400 (EDT)
Received: by mail-wr1-f53.google.com with SMTP id q3so7806366wrx.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+D+WQ6dthjR+r0AdBLApfx1B5e7Pkkf4I29v7UyCASI=;
 b=juIc7gELG7oN7gWL10hEXKAxzCKfQ3+sXIXbR8NVbv6H6/8iyg7e5nZinla68omfBb
 pJpFFeqW+7tNmBT3QkjlBbDReKO8n2PbzQz3d77E7PZ0q/OrwNaBD97Aa9ZAvTjI2boz
 wt1J1hBbyiLjD0zz4d+HP27f045C5hKwbqgPpJCj8+eSu5Orkr4Vl1ZAf+4WDVyBXmcJ
 OZJEBITH+AOxbJko2FNW5gO3AMZQ/0O5QbdhFoa4zbUZnMlvy63Cf/GBBX+Gh5o/4Fbc
 r3MUSxUe13D+9pOCExT/UwXJemJzILzsz9i7KJQdbLvRY6qX2Cj9v4tai1maVHI/jTRe
 B0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+D+WQ6dthjR+r0AdBLApfx1B5e7Pkkf4I29v7UyCASI=;
 b=j2bUWrqm6aUMlQ6WkMzyGYI6O4SJlK/1PDgPrn4Dh8j0a5xIwlqZGMtVgLx9+h2mok
 r6x9Ca9k/2f8veyGJ4N7AYhko0LwZQzDKhalNKs4qcqug9kkECLM3uPnSLhWI2Q2NDFa
 GZNBxj5k39A78Yy5f+4pEj8AkPyhNqMjp/7LzzXGaqFmt8alE4zReHR5WfssO1HkVmQX
 eN8Lh1H5w1VEFEA24pLTZitnTqqgSd1KtMoFAlbgHxktbQcv92XNMEyzuUV6gzrPXRm7
 oD/VHClHyhG8Sw3RJcgUrCQ7y5tP3Pfw94q7p/xva0CCKR1jifej94BRSg1m5ii7DA8r
 nqWg==
X-Gm-Message-State: AOAM533qW/XfI/IfU2nKc218L1wSrWW+KpGJmdHd9c6fV+e1pJUu+AHm
 KbMY6Ienj56wtdHSyPXQ16SDqg==
X-Google-Smtp-Source: ABdhPJyuOEXmaCM+TGYzMuW7Y5FKOpp4wnpTdqH3IdxX/TQTz9aynuGEL16s1B6g9wYjmkjo8JDYfA==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr5939815wrv.77.1627577572042;
 Thu, 29 Jul 2021 09:52:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 by smtp.gmail.com with ESMTPSA id j1sm9301709wmo.4.2021.07.29.09.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 09:52:51 -0700 (PDT)
Date: Thu, 29 Jul 2021 17:52:49 +0100
From: Quentin Perret <qperret@google.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Fix off-by-one in range_is_memory
Message-ID: <YQLc4YlDfMRbnRJh@google.com>
References: <20210728153232.1018911-1-dbrazdil@google.com>
 <20210728153232.1018911-2-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210728153232.1018911-2-dbrazdil@google.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Wednesday 28 Jul 2021 at 15:32:31 (+0000), David Brazdil wrote:
> Hyp checks whether an address range only covers RAM by checking the
> start/endpoints against a list of memblock_region structs. However,
> the endpoint here is exclusive but internally is treated as inclusive.
> Fix the off-by-one error that caused valid address ranges to be
> rejected.
> 
> Cc: Quentin Perret <qperret@google.com>
> Fixes: 90134ac9cabb6 ("KVM: arm64: Protect the .hyp sections from the host")
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index d938ce95d3bd..a6ce991b1467 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -193,7 +193,7 @@ static bool range_is_memory(u64 start, u64 end)
>  {
>  	struct kvm_mem_range r1, r2;
>  
> -	if (!find_mem_range(start, &r1) || !find_mem_range(end, &r2))
> +	if (!find_mem_range(start, &r1) || !find_mem_range(end - 1, &r2))
>  		return false;
>  	if (r1.start != r2.start)
>  		return false;

Looks good to me:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
