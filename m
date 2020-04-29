Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4D1BE9D3
	for <lists+kvmarm@lfdr.de>; Wed, 29 Apr 2020 23:26:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B7884B4B5;
	Wed, 29 Apr 2020 17:26:24 -0400 (EDT)
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
	with ESMTP id abMgvVl+9rzE; Wed, 29 Apr 2020 17:26:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 020884B4B2;
	Wed, 29 Apr 2020 17:26:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 140A94B4A5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Apr 2020 17:26:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIxZmXS24-0Q for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Apr 2020 17:26:20 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BAA454B455
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Apr 2020 17:26:20 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 308092073E;
 Wed, 29 Apr 2020 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588195579;
 bh=MaCkXnxZeesUHYpyP7Lu3SfMr1AsQhB6Xpct+XkQlHs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wg6NBLr2LtkWbzxJYrDsfKqukVBwgLUfEJKVdEL0kjfpwdZ+k4QFReJsRr4NSLlOw
 nUQQq0i8zZ4EMboEDkYuWrzMT30K1TAanS76Bu+dqqte5yH4qxZqvKzwFeP7TN13BG
 3x6WHb1IJb6kCS3Nlc97pghn74qI1UnoR9H8TleE=
Date: Wed, 29 Apr 2020 22:26:15 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 00/16] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
Message-ID: <20200429212614.GD8604@willie-the-truck>
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
 <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, maz@kernel.org,
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

Hi Anshuman,

On Wed, Apr 29, 2020 at 03:07:15PM +0530, Anshuman Khandual wrote:
> On 04/14/2020 03:18 PM, Anshuman Khandual wrote:
> > This series is primarily motivated from an adhoc list from Mark Rutland
> > during our previous ID_ISAR6 discussion [1]. The current proposal also
> > accommodates some more suggestions from Will and Suzuki.
> > 
> > This series adds missing 32 bit system registers (ID_PFR2, ID_DFR1 and
> > ID_MMFR5), adds missing features bits on all existing system registers
> > (32 and 64 bit) and some other miscellaneous changes. While here it also
> > includes a patch which does macro replacement for various open bits shift
> > encodings for various CPU ID registers. There is a slight re-order of the
> > patches here as compared to the previous version (V1).
> > 
> > This series is based on v5.7-rc1. All feature bits enabled here can be
> > referred in ARM DDI 0487F.a specification. Though I have tried to select
> > appropriate values for each new feature being added here, there might be
> > some inconsistencies (or mistakes). In which case, please do let me know
> > if anything needs to change. Thank you.
> > 
> > [1] https://patchwork.kernel.org/patch/11287805/
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com> 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: kvmarm@lists.cs.columbia.edu
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Changes in V2:
> > 
> > - Added Suggested-by tag from Mark Rutland for all changes he had proposed
> > - Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
> > - Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
> > - Added ID_DFR1 and ID_MMFR5 system register definitions per Will
> > - Added remaining features bits for relevant 64 bit system registers per Will
> > - Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
> > - Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
> > - Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
> > - Changed some commit messages
>
> Just a gentle ping. I am wondering if you had a chance to glance
> through this updated series.

Please can you resend based on for-next/cpufeature?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
