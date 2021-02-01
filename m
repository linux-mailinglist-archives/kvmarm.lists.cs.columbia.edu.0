Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1357830AFE9
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 20:00:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 994764B3F6;
	Mon,  1 Feb 2021 14:00:19 -0500 (EST)
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
	with ESMTP id E5oS9bs7bsOJ; Mon,  1 Feb 2021 14:00:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76EDE4B3D9;
	Mon,  1 Feb 2021 14:00:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0BE7F4B3D9
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 14:00:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2PpX9Jp6qbF for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 14:00:16 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E36BF4B3B6
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 14:00:15 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6A3064E2E;
 Mon,  1 Feb 2021 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612206014;
 bh=94+bS/EiourB10zg+W1ZE5ZX3BKLOp9sDia13G+JXP8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OCzfA8+UhqzFrSrEujU1gR5id/a6vYbbXk/umvq2WB27VsAHmewXta8psdwQedhCh
 7yhVccKwymFbAQV1IK/YR6wpb9DbUGai+RDj0A3XGQB/K4c7N88EJxYYltNlqdZtxh
 ThEadto04WqggFS11j+KzXW/xTwr1GfeoYQoZX7ZkrfG0pVuL0boqbQb06lVDN8dOu
 OdDNsYH+JuR+MU5UYG6Iuyy4zcpRcrambWoA0vnawTkNpD6Sq95yklASYGILFnzABx
 1ckRUxXjf4txDfoBP0u91sUbIiv75cuA8YITywXLG1RR6KqYJyWvEOwbls0j1P7U+T
 AX5eZZQcSunig==
Date: Mon, 1 Feb 2021 19:00:08 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 10/26] KVM: arm64: Introduce an early Hyp page
 allocator
Message-ID: <20210201190008.GI15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-11-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-11-qperret@google.com>
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

On Fri, Jan 08, 2021 at 12:15:08PM +0000, Quentin Perret wrote:
> diff --git a/arch/arm64/kvm/hyp/nvhe/early_alloc.c b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
> new file mode 100644
> index 000000000000..de4c45662970
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Google LLC
> + * Author: Quentin Perret <qperret@google.com>
> + */
> +
> +#include <asm/kvm_pgtable.h>
> +
> +#include <nvhe/memory.h>
> +
> +struct kvm_pgtable_mm_ops hyp_early_alloc_mm_ops;
> +s64 __ro_after_init hyp_physvirt_offset;
> +
> +static unsigned long base;
> +static unsigned long end;
> +static unsigned long cur;
> +
> +unsigned long hyp_early_alloc_nr_pages(void)
> +{
> +	return (cur - base) >> PAGE_SHIFT;
> +}

nit: but I find this function name confusing (it's returning the number of
_allocated_ pages, not the number of _free_ pages!). How about something
like hyp_early_alloc_size() to match hyp_s1_pgtable_size() which you add
later? [and move the shift out to the caller]?

> +
> +extern void clear_page(void *to);

Stick this in a header?

> +
> +void *hyp_early_alloc_contig(unsigned int nr_pages)

I think order might make more sense, or do you need to allocate
non-power-of-2 batches of pages?

> +{
> +	unsigned long ret = cur, i, p;
> +
> +	if (!nr_pages)
> +		return NULL;
> +
> +	cur += nr_pages << PAGE_SHIFT;
> +	if (cur > end) {

This would mean that concurrent hyp_early_alloc_nr_pages() would transiently
give the wrong answer. Might be worth sticking the locking expectations with
the function prototypes.

That said, maybe it would be better to write this check as:

	if (end - cur < (nr_pages << PAGE_SHIFT))

as that also removes the need to worry about overflow if nr_pages is huge
(which would be a bug in the hypervisor, which we would then catch here).

> +		cur = ret;
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		p = ret + (i << PAGE_SHIFT);
> +		clear_page((void *)(p));
> +	}
> +
> +	return (void *)ret;
> +}
> +
> +void *hyp_early_alloc_page(void *arg)
> +{
> +	return hyp_early_alloc_contig(1);
> +}
> +
> +void hyp_early_alloc_init(unsigned long virt, unsigned long size)
> +{
> +	base = virt;
> +	end = virt + size;
> +	cur = virt;

nit: base = cur = virt;

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
