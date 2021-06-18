Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 105E63AC6AC
	for <lists+kvmarm@lfdr.de>; Fri, 18 Jun 2021 10:59:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 960B149F82;
	Fri, 18 Jun 2021 04:59:49 -0400 (EDT)
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
	with ESMTP id aE4Sy3LZg5C0; Fri, 18 Jun 2021 04:59:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 71B1D4A522;
	Fri, 18 Jun 2021 04:59:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F74340FC7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 04:59:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aMQokLA26lQg for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Jun 2021 04:59:45 -0400 (EDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D7D8B40825
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 04:59:45 -0400 (EDT)
Received: by mail-ot1-f53.google.com with SMTP id
 i12-20020a05683033ecb02903346fa0f74dso8996643otu.10
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kxWq/w4pUVc8HOlAC++EsNgPCdWz4WRSzn6eNlOcpd8=;
 b=bhaMQb0WGrbDqa+aKHcQIksSIM+zTHdcqFfPBr5BV5rr/Wi8UST4PtBaFBBmWA70/c
 JeE4Hu4BbtwFqF0c80sjfACvvB1nesUeK9TieyU/oqhdgOex7UgfdkqRux0UxZ5/TcHT
 DLHvuKVExIhZtgV1fPhYLr/Md+zpFpFjNVpAPjGlXCP+m9MsUwKdcLN7akLZFoz7RcTk
 238s+sJ/BuekxpTMYI4dcJE/HjWwxIUM3JYIJt/VdYH2Zb8cmBY3gzekVcESfoAgP54o
 bIIHlFX/dEToFLWW+5NXkS2fXPFEuRa4egZ9ULCaZiOK2z8px8znd93Nlh17ZN0KkdrP
 Dwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kxWq/w4pUVc8HOlAC++EsNgPCdWz4WRSzn6eNlOcpd8=;
 b=dO701+lIbC4ZDkNnGB6stF7z02hNdTlIJo2KjhINkD9IB5FA7TGIj2mg78jVdmT3BW
 orogY4dMoENzrf97+N5kYXfYxEcpRDRcfxChB94OvRVGiZaMELKNpBpv4CeK3RaSGdTy
 zkS3Eanu1N8hWaff+BnpIZvScSTKZX5FQMt4oq32/LWo61hTsu1/Zc0eQkphxm5zan3c
 m0s9UMUNR6dywsLUyKRYzeJkapkA+5TdM9Pg7EO7mnjXuXkwDPFwZ8603GyCm08j5MrO
 6s+QrsTHn54fKTP8mSIPy1qpXBmT+oACKDIW1FDuhmLcQU0ezsDQPbw2IOdGRZCfZTOx
 v8+g==
X-Gm-Message-State: AOAM5315rYNcoco3i2X/41rZTHb2WG4cx1J/g57d693EfVTcaHa4gXU8
 RYGXeiE/t82ZS/1GddJChDqkGBRxBw55/6kwYhaRwA==
X-Google-Smtp-Source: ABdhPJwzc7DiWjyKPp58Q0od7P57f5+tDcapLIkUHFsPNVK62ZAuAwBi+XcIKklM8bb9dajJNv9sTtXhTaAbgYqG490=
X-Received: by 2002:a05:6830:1598:: with SMTP id
 i24mr8497546otr.52.1624006785056; 
 Fri, 18 Jun 2021 01:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210617105824.31752-1-wangyanan55@huawei.com>
 <20210617105824.31752-2-wangyanan55@huawei.com>
 <20210617123837.GA24457@willie-the-truck>
 <87eed0d13p.wl-maz@kernel.org>
 <2c1b9376-3997-aa7b-d5f3-b04da985c260@huawei.com>
In-Reply-To: <2c1b9376-3997-aa7b-d5f3-b04da985c260@huawei.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 18 Jun 2021 09:59:09 +0100
Message-ID: <CA+EHjTyW+LP=UmwDP+egbPzpz2vxFpbOMgXi=dOt15j8wfLxWg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] KVM: arm64: Introduce two cache maintenance
 callbacks
To: "wangyanan (Y)" <wangyanan55@huawei.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Hi,

On Fri, Jun 18, 2021 at 2:52 AM wangyanan (Y) <wangyanan55@huawei.com> wrote:
>
>
>
> On 2021/6/17 22:20, Marc Zyngier wrote:
> > On Thu, 17 Jun 2021 13:38:37 +0100,
> > Will Deacon <will@kernel.org> wrote:
> >> On Thu, Jun 17, 2021 at 06:58:21PM +0800, Yanan Wang wrote:
> >>> To prepare for performing CMOs for guest stage-2 in the fault handlers
> >>> in pgtable.c, here introduce two cache maintenance callbacks in struct
> >>> kvm_pgtable_mm_ops. We also adjust the comment alignment for the
> >>> existing part but make no real content change at all.
> >>>
> >>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> >>> ---
> >>>   arch/arm64/include/asm/kvm_pgtable.h | 42 +++++++++++++++++-----------
> >>>   1 file changed, 25 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> >>> index c3674c47d48c..b6ce34aa44bb 100644
> >>> --- a/arch/arm64/include/asm/kvm_pgtable.h
> >>> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> >>> @@ -27,23 +27,29 @@ typedef u64 kvm_pte_t;
> >>>
> >>>   /**
> >>>    * struct kvm_pgtable_mm_ops - Memory management callbacks.
> >>> - * @zalloc_page:   Allocate a single zeroed memory page. The @arg parameter
> >>> - *                 can be used by the walker to pass a memcache. The
> >>> - *                 initial refcount of the page is 1.
> >>> - * @zalloc_pages_exact:    Allocate an exact number of zeroed memory pages. The
> >>> - *                 @size parameter is in bytes, and is rounded-up to the
> >>> - *                 next page boundary. The resulting allocation is
> >>> - *                 physically contiguous.
> >>> - * @free_pages_exact:      Free an exact number of memory pages previously
> >>> - *                 allocated by zalloc_pages_exact.
> >>> - * @get_page:              Increment the refcount on a page.
> >>> - * @put_page:              Decrement the refcount on a page. When the refcount
> >>> - *                 reaches 0 the page is automatically freed.
> >>> - * @page_count:            Return the refcount of a page.
> >>> - * @phys_to_virt:  Convert a physical address into a virtual address mapped
> >>> - *                 in the current context.
> >>> - * @virt_to_phys:  Convert a virtual address mapped in the current context
> >>> - *                 into a physical address.
> >>> + * @zalloc_page:           Allocate a single zeroed memory page.
> >>> + *                         The @arg parameter can be used by the walker
> >>> + *                         to pass a memcache. The initial refcount of
> >>> + *                         the page is 1.
> >>> + * @zalloc_pages_exact:            Allocate an exact number of zeroed memory pages.
> >>> + *                         The @size parameter is in bytes, and is rounded
> >>> + *                         up to the next page boundary. The resulting
> >>> + *                         allocation is physically contiguous.
> >>> + * @free_pages_exact:              Free an exact number of memory pages previously
> >>> + *                         allocated by zalloc_pages_exact.
> >>> + * @get_page:                      Increment the refcount on a page.
> >>> + * @put_page:                      Decrement the refcount on a page. When the
> >>> + *                         refcount reaches 0 the page is automatically
> >>> + *                         freed.
> >>> + * @page_count:                    Return the refcount of a page.
> >>> + * @phys_to_virt:          Convert a physical address into a virtual address
> >>> + *                         mapped in the current context.
> >>> + * @virt_to_phys:          Convert a virtual address mapped in the current
> >>> + *                         context into a physical address.
> >>> + * @clean_invalidate_dcache:       Clean and invalidate the data cache for the
> >>> + *                         specified memory address range.
> >> This should probably be explicit about whether this to the PoU/PoC/PoP.
> > Indeed. I can fix that locally if there is nothing else that requires
> > adjusting.
> Will be grateful !

Sorry, I missed the v7 update. One comment here is that the naming
used in the patch series I mentioned shortens invalidate to inval (if
you want it to be less of a mouthful):
https://lore.kernel.org/linux-arm-kernel/20210524083001.2586635-19-tabba@google.com/

Otherwise:
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks!
/fuad



>
> Thanks,
> Yanan
> .
> >
> >       M.
> >
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
