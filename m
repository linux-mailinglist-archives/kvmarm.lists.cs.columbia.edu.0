Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CD74742B0B1
	for <lists+kvmarm@lfdr.de>; Wed, 13 Oct 2021 02:02:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E3E64B0B4;
	Tue, 12 Oct 2021 20:02:57 -0400 (EDT)
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
	with ESMTP id 8wdDRFEjlygz; Tue, 12 Oct 2021 20:02:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CB9C4B0C2;
	Tue, 12 Oct 2021 20:02:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 312694B08F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 20:02:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8A9+AXuf5jX for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Oct 2021 20:02:53 -0400 (EDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 327A14A531
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 20:02:53 -0400 (EDT)
Received: by mail-pl1-f178.google.com with SMTP id w14so615065pll.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=usOJyi3vWJ+B8xCJglaCM/0JQ+BQoeyBpYldNBu2X7A=;
 b=D+7qhklJPAH83AmBCpAMyIvHcu0UZpGBjD3qo/SjZGhh+cbq/euskkcZ1cSTfJQBVn
 /O1iVvf5S1EpmEm3eXdD+Iy1MRk9RXAc3Vsv2OmxsOGZOSZ8rnucKpDfyFfonUYD2tXH
 yPvY1qAKvZm0T1UKwE9E+wGryzPZyFnkHWud+uqljuameF0Hjdgg7MOlmSINGw6Y4Mho
 OzpQK4SqiaZj4+y+/QKrMA8iIIwFough5NTypRJia97qJLAztZNLFYqM+oiQAvKtziEi
 dVg4rQre/vKbe/BJ7N0Yx20BzJbvvVB5pylKWHuw6JAjEndTlIULMwyNwqQ1psdhD2Iz
 KUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=usOJyi3vWJ+B8xCJglaCM/0JQ+BQoeyBpYldNBu2X7A=;
 b=g9oD7mNnPccW71Y94lwUAoZM+p1dySvflyk0YJQtJ+zxF2XKBTPQpk8rOm738Cxqcr
 w6JXxjcHoQ2a1vti6FAZz5l88pBjOvb/+viOO3/Zrn7//rkRX/pNgR1VqokYGBSvSDlT
 2FNGw2h79SjnaqpQS4FAk2GtvTvnnP0aoh6UbiIqQt0N06JzK44FdaAcpqf4CiFk+uP9
 zAgf7MmO/84bm55l/0Bnx8I3JFjVPMpnmgDoOuyy2rz4fyiR8SdO4Ky8n3mbl6vSGCa3
 Wkx8zJvRC4+5sp0vFajbAHXVbRPA6j+UbriCm9Z283LuuI5AH/al5H855TqpoJn2Fv+/
 ew2g==
X-Gm-Message-State: AOAM531SlKmHckpAU3g6wyy+kGo649POnKXf/bDPc7XYt7uSclk2g2om
 II0mT3gzNMKyXFlV2ecVEvvD0g==
X-Google-Smtp-Source: ABdhPJxo7HfGHeKdwK3WniLQ9W70SyBtE5TarYga88X1oCtTWRYloyybpHWXgxggwD5S0ICHu+k1DA==
X-Received: by 2002:a17:90b:17c9:: with SMTP id
 me9mr9626717pjb.197.1634083371829; 
 Tue, 12 Oct 2021 17:02:51 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id b130sm586106pfb.9.2021.10.12.17.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 17:02:51 -0700 (PDT)
Date: Wed, 13 Oct 2021 00:02:47 +0000
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v4 4/4] KVM: mmu: remove over-aggressive warnings
Message-ID: <YWYiJy1Z7VZ0SxAd@google.com>
References: <20210929042908.1313874-1-stevensd@google.com>
 <20210929042908.1313874-5-stevensd@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210929042908.1313874-5-stevensd@google.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

On Wed, Sep 29, 2021, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Remove two warnings that require ref counts for pages to be non-zero, as
> mapped pfns from follow_pfn may not have an initialized ref count.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 7 -------
>  virt/kvm/kvm_main.c    | 2 +-
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5a1adcc9cfbc..3b469df63bcf 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -617,13 +617,6 @@ static int mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
>  
>  	pfn = spte_to_pfn(old_spte);
>  
> -	/*
> -	 * KVM does not hold the refcount of the page used by
> -	 * kvm mmu, before reclaiming the page, we should
> -	 * unmap it from mmu first.
> -	 */
> -	WARN_ON(!kvm_is_reserved_pfn(pfn) && !page_count(pfn_to_page(pfn)));

Have you actually observed false positives with this WARN?  I would expect anything
without a struct page to get filtered out by !kvm_is_reserved_pfn(pfn).

If you have observed false positives, I would strongly prefer we find a way to
keep the page_count() sanity check, it has proven very helpful in the past in
finding/debugging bugs during MMU development.

> -
>  	if (is_accessed_spte(old_spte))
>  		kvm_set_pfn_accessed(pfn);
>  
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
