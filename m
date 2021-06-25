Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E9CFD3B4131
	for <lists+kvmarm@lfdr.de>; Fri, 25 Jun 2021 12:11:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F43C4B121;
	Fri, 25 Jun 2021 06:11:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YgkaaFNKnC7N; Fri, 25 Jun 2021 06:11:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 122934B17D;
	Fri, 25 Jun 2021 06:11:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C6CD74B16F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Jun 2021 20:20:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rirnuZYmAOz8 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Jun 2021 20:20:38 -0400 (EDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7CE784B13A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Jun 2021 20:20:38 -0400 (EDT)
Received: by mail-pf1-f173.google.com with SMTP id c8so6631850pfp.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Jun 2021 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=QS1Ns1WqNL5is+0vi/ZTUFuxlVcqVbsqm8g6SHrti5w=;
 b=esFkhH15NMc8wS4V/cwcupYK/DM+pO31de2/rn7330Vbdh9CSH9nvb+7DxAuWpBq5q
 I7HhRjIAf3sfraAsSUg5Y3qXSa9eVE9+YVQ00KJALtXy9kkDyH52E89nrtf01dGKriH8
 b00IMLN+V/HOLpi8TtU0LZ1hk9cAx0kkRlMaPdbbDzt+jClVFu+NXDMdkVwZY7xsN+Pb
 tP4yZoVaJBNxRaG8tctEZTIYWsIItqZBewSg9WSZ8LdCnbR+ioG4SZD7hACLKDcVik91
 hFNd/jFL7BVxEVmattHQ7LktCFlqiNNlX/MEUpDQB/QeQIQwm0YNoc++AkYkd7w7Rqkx
 Ypjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=QS1Ns1WqNL5is+0vi/ZTUFuxlVcqVbsqm8g6SHrti5w=;
 b=I7iuQbj2AV+V8qCfBDfxziAU56Rt6n7N0BLhvQKGFexaVY43gsPwBMibOtohCZQbbO
 NHTrMn8A2hD6PrYG6D0zGaFLL2ObhedCZe31l5oqMBmua18wvuKGC5vawVtplcBcEecn
 /BtJd+D46vEyA7E5iNgVumbIpSwRsGNtJNL30rtZfDZauTju7+Jn+5qkilXVGuL5F5gj
 REzwje6ql+ulhhK1WmhTybEK+faK3qbZ2UXF8FhfUscn6uBWTh22Jugerix/NdN3MZ9q
 VsK4Fq8ZiqcqKOfPdfgIZRcqSfsyUsdah9QI3Y64XJjfr9ukWLkgvMhwBbl3vi0uPtoC
 MacQ==
X-Gm-Message-State: AOAM530flPsljUzVhnHDwI+bhiX9SWbE9xQK5MgnKs2RAE+d1k8u5j6T
 nhcWvmP0n+dmEn8CWlXCXcg=
X-Google-Smtp-Source: ABdhPJxQU7+bPuGhEylfTnovn9GkVLr4KlmlOjHYTX0Un3AOHd4dWxP2gfr/obThDIjB30qffkhRJQ==
X-Received: by 2002:a62:2fc1:0:b029:305:fd1e:e3f4 with SMTP id
 v184-20020a622fc10000b0290305fd1ee3f4mr4774381pfv.17.1624580437511; 
 Thu, 24 Jun 2021 17:20:37 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id z18sm3630623pfe.214.2021.06.24.17.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 17:20:37 -0700 (PDT)
Date: Fri, 25 Jun 2021 10:20:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/6] KVM: Remove uses of struct page from x86 and arm64 MMU
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, Marc Zyngier <maz@kernel.org>, Paul Mackerras
 <paulus@ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>, David Stevens
 <stevensd@chromium.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang
 <zhi.a.wang@intel.com>
References: <20210624035749.4054934-1-stevensd@google.com>
 <1624530624.8jff1f4u11.astroid@bobo.none>
 <1624534759.nj0ylor2eh.astroid@bobo.none>
 <0d3a699a-15eb-9f1b-0735-79d14736f38c@redhat.com>
 <1624539354.6zggpdrdbw.astroid@bobo.none>
 <81d99029-ec40-19c5-5647-20607d78dab0@redhat.com>
In-Reply-To: <81d99029-ec40-19c5-5647-20607d78dab0@redhat.com>
MIME-Version: 1.0
Message-Id: <1624580015.hf7udh0vc3.astroid@bobo.none>
X-Mailman-Approved-At: Fri, 25 Jun 2021 06:11:50 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Stevens <stevensd@google.com>, intel-gfx@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvmarm@lists.cs.columbia.edu,
 Will Deacon <will@kernel.org>, kvm-ppc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linux-mips@vger.kernel.org,
 intel-gvt-dev@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>,
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

Excerpts from Paolo Bonzini's message of June 25, 2021 1:35 am:
> On 24/06/21 14:57, Nicholas Piggin wrote:
>> KVM: Fix page ref underflow for regions with valid but non-refcounted pages
> 
> It doesn't really fix the underflow, it disallows mapping them in the 
> first place.  Since in principle things can break, I'd rather be 
> explicit, so let's go with "KVM: do not allow mapping valid but 
> non-reference-counted pages".
> 
>> It's possible to create a region which maps valid but non-refcounted
>> pages (e.g., tail pages of non-compound higher order allocations). These
>> host pages can then be returned by gfn_to_page, gfn_to_pfn, etc., family
>> of APIs, which take a reference to the page, which takes it from 0 to 1.
>> When the reference is dropped, this will free the page incorrectly.
>> 
>> Fix this by only taking a reference on the page if it was non-zero,
> 
> s/on the page/on valid pages/ (makes clear that invalid pages are fine 
> without refcounting).

That seems okay, you can adjust the title or changelog as you like.

> Thank you *so* much, I'm awful at Linux mm.

Glad to help. Easy to see why you were taking this approach because the 
API really does need to be improved and even a pretty intwined with mm 
subsystem like KVM shouldn't _really_ be doing this kind of trick (and
it should go away when old API is removed).

Thanks,
Nick
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
