Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F20B5264638
	for <lists+kvmarm@lfdr.de>; Thu, 10 Sep 2020 14:42:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D3304B408;
	Thu, 10 Sep 2020 08:42:13 -0400 (EDT)
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
	with ESMTP id 1JPlTDu36vuE; Thu, 10 Sep 2020 08:42:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BDCE4B406;
	Thu, 10 Sep 2020 08:42:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 66EA34B3B4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 08:42:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IDTflAu1IsgC for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Sep 2020 08:42:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8D4954B3A9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 08:42:10 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D005D208FE;
 Thu, 10 Sep 2020 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599741729;
 bh=s/ImfSj4GtOVqobSLRCwmo2Y6eUw8cRqEt3SO+ax0WM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tl9mouv28NgKI/NwlPeWBC4meBdVR8Fp4ha/h5PQN7m4PRxUqg+/MYeMM7XgELOt4
 FYE7p7QFlx7KmFWYbaDtV84yUcKLkMcLJ+76n48PgYBLTO38TRWZkexS0P3e6DWgbZ
 n5glcN+0OSaCyCaw3Ay9Pr0isis7uSBoSNDkaZkE=
Date: Thu, 10 Sep 2020 13:42:04 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 10/21] KVM: arm64: Add support for stage-2 page-aging
 in generic page-table
Message-ID: <20200910124204.GC18100@willie-the-truck>
References: <20200907152344.12978-1-will@kernel.org>
 <20200907152344.12978-11-will@kernel.org>
 <080cd3d9-4979-1d72-0c5a-188334b5a26a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <080cd3d9-4979-1d72-0c5a-188334b5a26a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Tue, Sep 08, 2020 at 04:30:15PM +0100, Alexandru Elisei wrote:
> On 9/7/20 4:23 PM, Will Deacon wrote:
> > +kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
> > +{
> > +	kvm_pte_t pte = 0;
> > +	stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
> > +				 &pte);
> > +	dsb(ishst);
> 
> I am curious about the DSB above. We don't do it when we clear the AF bit, because
> in the clear_flush_young() mmu notifier, kvm_age_hva() is followed by
> kvm_flush_remote_tlbs() -> kvm_flush_remote_tlbs(), which does a DSB ISHST.
> 
> When AF is zero, the entry is not allowed to be stored in a TLB, and that's why we
> don't need to issue a TLBI instruction. Do we do the DSB here to make sure all PEs
> in the inner shareability domain see the updated translation tables? Or there's
> another reason I'm not seeing?

You're right: the DSB is to ensure that the updated PTE is visible to the
page-table walker, as I'm not sure how well we'll handle the spurious access
fault in this case (particularly as is_young() would return true).

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
