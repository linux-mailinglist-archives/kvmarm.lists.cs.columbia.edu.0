Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 029F63378F2
	for <lists+kvmarm@lfdr.de>; Thu, 11 Mar 2021 17:14:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D2814B702;
	Thu, 11 Mar 2021 11:14:55 -0500 (EST)
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
	with ESMTP id aqssZEgfG-pI; Thu, 11 Mar 2021 11:14:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5945D4B6E0;
	Thu, 11 Mar 2021 11:14:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 961D24B5A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 11:14:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7aRxehcK++7z for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Mar 2021 11:14:50 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1EB2D4B59C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 11:14:50 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFD5464F88;
 Thu, 11 Mar 2021 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615479288;
 bh=qYDGWCW64bxyZudXVN5dkVQ3DwMt7Dn8FEVKXvpunG4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i8MnI3+2/a4u7kdasK8yp0GaOhcv8jnkA0X0v12U8iXfzM0yXF00qlOJQJ8BLfxR5
 SnPL1CygmdEkO3n6m167qfRXk7n9zJx/PGswMJN3JnCgolPkglroyEnbPjel4Fq5LP
 1yHs7VglYuyH6+Eh34R9mwABULkfgq9200BQns63jNQjRiJATlopDnbhkoPGNlq66y
 ruNVpmIy/icGq9PgJjCT8YCHy4irUwrh0eyvmpmb0QZt7fz/XlOMiRbrRVgbCud2js
 0MrnSAz1IeSLEuIJbhrD54+im2PZkuBoIndFzApzln30phdH25lNkXlpxqIENZCiCV
 D+iGWJPBqZCCQ==
Date: Thu, 11 Mar 2021 16:14:42 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 12/34] KVM: arm64: Introduce a Hyp buddy page allocator
Message-ID: <20210311161441.GC31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-13-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-13-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: android-kvm@google.com, catalin.marinas@arm.com, mate.toth-pal@arm.com,
 seanjc@google.com, tabba@google.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Wed, Mar 10, 2021 at 05:57:29PM +0000, Quentin Perret wrote:
> When memory protection is enabled, the hyp code will require a basic
> form of memory management in order to allocate and free memory pages at
> EL2. This is needed for various use-cases, including the creation of hyp
> mappings or the allocation of stage 2 page tables.
> 
> To address these use-case, introduce a simple memory allocator in the
> hyp code. The allocator is designed as a conventional 'buddy allocator',
> working with a page granularity. It allows to allocate and free
> physically contiguous pages from memory 'pools', with a guaranteed order
> alignment in the PA space. Each page in a memory pool is associated
> with a struct hyp_page which holds the page's metadata, including its
> refcount, as well as its current order, hence mimicking the kernel's
> buddy system in the GFP infrastructure. The hyp_page metadata are made
> accessible through a hyp_vmemmap, following the concept of
> SPARSE_VMEMMAP in the kernel.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  68 ++++++++
>  arch/arm64/kvm/hyp/include/nvhe/memory.h |  28 ++++
>  arch/arm64/kvm/hyp/nvhe/Makefile         |   2 +-
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 195 +++++++++++++++++++++++
>  4 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/gfp.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/page_alloc.c

Eventually, we can replace the refcount with refcount_t, but for now this
looks pretty good:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
