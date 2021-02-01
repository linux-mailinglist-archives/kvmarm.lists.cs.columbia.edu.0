Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4661330AF95
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 19:39:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C66FF4B3D9;
	Mon,  1 Feb 2021 13:39:50 -0500 (EST)
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
	with ESMTP id O8XUb7puGxXH; Mon,  1 Feb 2021 13:39:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 809184B3C1;
	Mon,  1 Feb 2021 13:39:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A541B4B3B5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 13:39:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r6KjmKWXEHlM for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 13:39:47 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 938284B3B4
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 13:39:47 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE4B64EA2;
 Mon,  1 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612204786;
 bh=RWCEVvMfMr07Mj0Dm990NJYMdt/tnBLc1r3RkW1LOpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sv7mWTQjdOhFcDIMCbW1iFI0zjx5NhutKWWEwARZFwdSFhjVgHc9Uom5VsUoIPSbv
 bbsxnuSIKgBN1r5PdCf0vCJDRfzwhL89aJH52aldgfb3hZjzPRWkZ8XSif8y25PBLn
 OMrHbjZNJSHYSr7y8V3yg6VYCfSgtZSGUtCDFOohMW1atWBUdSRHmjlVw/zDPjdllJ
 S/Iv5U4ieWYllL8w/npt5/62CWCqdJZMDNdtRLuPjdlD47xFGt0PXJR6oBoi6dPegC
 Ox9HxzXwXkB506lhN2unGnFjmaoQhkXP8X5+IGSaS7Yvs3mI8o7KYXXNw9zYFCyREZ
 YeC5KviL9q0gA==
Date: Mon, 1 Feb 2021 18:39:40 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 06/26] KVM: arm64: Factor memory allocation out of
 pgtable.c
Message-ID: <20210201183940.GF15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-7-qperret@google.com>
 <20210201181607.GD15632@willie-the-truck>
 <YBhJVPz124QRAYFf@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YBhJVPz124QRAYFf@google.com>
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

On Mon, Feb 01, 2021 at 06:32:52PM +0000, Quentin Perret wrote:
> On Monday 01 Feb 2021 at 18:16:08 (+0000), Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 12:15:04PM +0000, Quentin Perret wrote:
> > > +static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
> > > +	.zalloc_page		= stage2_memcache_alloc_page,
> > > +	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
> > > +	.free_pages_exact	= free_pages_exact,
> > > +	.get_page		= kvm_host_get_page,
> > > +	.put_page		= kvm_host_put_page,
> > > +	.page_count		= kvm_host_page_count,
> > > +	.phys_to_virt		= kvm_host_va,
> > > +	.virt_to_phys		= kvm_host_pa,
> > > +};
> > 
> > Idle thought, but I wonder whether it would be better to have these
> > implementations as the default and make the mm_ops structure parameter
> > to kvm_pgtable_stage2_init() optional? I guess you don't gain an awful
> > lot though, so feel free to ignore me.
> 
> No strong opinion really, but I suppose I could do something as simple
> as having static inline wrappers which provide kvm_s2_mm_ops to the
> pgtable API for me. I'll probably want to make sure these are not
> defined when compiling EL2 code, though, to avoid confusion.
> 
> Or maybe you had something else in mind?

No, just food for thought. If we can reduce the changes for normal KVM then
it's probably worth considering if it doesn't add divergent code paths. But
I'm also fine with the proposal you have here, so if it doesn't work then
don't get hung up on it.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
