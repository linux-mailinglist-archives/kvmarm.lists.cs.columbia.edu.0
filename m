Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1C30F513
	for <lists+kvmarm@lfdr.de>; Thu,  4 Feb 2021 15:36:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8EE24B260;
	Thu,  4 Feb 2021 09:36:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D3RzyLMPqEUt; Thu,  4 Feb 2021 09:36:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 196474B238;
	Thu,  4 Feb 2021 09:36:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 113474B22F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Feb 2021 09:36:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P7GwTvUPqbDt for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Feb 2021 09:36:26 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2A6934B1A9
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Feb 2021 09:36:26 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7490864F5E;
 Thu,  4 Feb 2021 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612449385;
 bh=q+Q5OcQ6akzkt/aKtlVLcbW3FULf1J4eGOwrszsVCug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rTmic4TMup6IFFAFKWQx3xr963WJyxq5iq7OlxQrCxnv+5bTzGvamdKhsPYWYiAel
 Q1+7Gz821B0byhtUOHN+nyWHIHJdvJVh6hgjatpUO3UWjbwV+vzppDXMNokGZDJaq6
 OGiBFaBMHIjRKRQPKbks6XQQpvM86D+PpgnmeKddLybIn5TYJDK3qYLPouOt9iSYBN
 ZPJt0EsmandHOY1E4gWEPJJTQIqCfDK/gxBfBpt6vx+bWwTOKNkLd6jBWA8pWutj/2
 SKHhmaVDyEQaaKBdiwI3vkRVxAMyZOeeAgETPxMweukOqAFYQzYwMU8Xcdq0Wjk1vi
 2fs8AS0XL5X0w==
Date: Thu, 4 Feb 2021 14:36:19 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 24/26] KVM: arm64: Make memcache anonymous in
 pgtable allocator
Message-ID: <20210204143618.GA20815@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-25-qperret@google.com>
 <20210203155944.GH18974@willie-the-truck>
 <YBwDrBH8p0aEpKKC@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YBwDrBH8p0aEpKKC@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Thu, Feb 04, 2021 at 02:24:44PM +0000, Quentin Perret wrote:
> On Wednesday 03 Feb 2021 at 15:59:44 (+0000), Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 12:15:22PM +0000, Quentin Perret wrote:
> > > The current stage2 page-table allocator uses a memcache to get
> > > pre-allocated pages when it needs any. To allow re-using this code at
> > > EL2 which uses a concept of memory pools, make the memcache argument to
> > > kvm_pgtable_stage2_map() anonymous. and let the mm_ops zalloc_page()
> > > callbacks use it the way they need to.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
> > >  arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > > index 8e8f1d2c5e0e..d846bc3d3b77 100644
> > > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > > @@ -176,8 +176,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
> > >   * @size:	Size of the mapping.
> > >   * @phys:	Physical address of the memory to map.
> > >   * @prot:	Permissions and attributes for the mapping.
> > > - * @mc:		Cache of pre-allocated GFP_PGTABLE_USER memory from which to
> > > - *		allocate page-table pages.
> > > + * @mc:		Cache of pre-allocated memory from which to allocate page-table
> > > + *		pages.
> > 
> > We should probably mention that this memory must be zeroed, since I don't
> > think the page-table code takes care of that.
> 
> OK, though I think this is unrelated to this change -- this is already
> true today I believe. Anyhow, I'll pile a change on top.

It is, but GFP_PGTABLE_USER implies __GFP_ZERO, so the existing comment
captures that.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
