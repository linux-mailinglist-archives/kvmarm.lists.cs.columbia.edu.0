Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D8C141A9B90
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 12:58:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 887F74B22B;
	Wed, 15 Apr 2020 06:58:53 -0400 (EDT)
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
	with ESMTP id fhNJoV0MOHLj; Wed, 15 Apr 2020 06:58:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 610A74B1E0;
	Wed, 15 Apr 2020 06:58:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21B9A4B167
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 06:58:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvIrcKKwLANL for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 06:58:50 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 37DA24B163
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 06:58:50 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8202320737;
 Wed, 15 Apr 2020 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586948329;
 bh=CREoP6ow54O+9uP6Nr3jiB5GlPGFSrwpvxq54PH6zc0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1HhYnu9MIHu7uBu8iCaGrYgjMczZnXow3gS6bknWEk7L7PWw+q2APHOMia1+mGGLl
 SeoGP0GOp/cUK6gieqe9hrTGnTwDXpsnQ4vKEuUWPGomRvlRUSVx75sQcfMiG5xmdY
 mIKao2F9HAVTn5ug8w4JpxJQ8EpXIeSKzfpfVzLg=
Date: Wed, 15 Apr 2020 11:58:44 +0100
From: Will Deacon <will@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support
 at EL[0-2]
Message-ID: <20200415105843.GE12621@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-8-will@kernel.org>
 <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: saiprakash.ranjan@codeaurora.org, anshuman.khandual@arm.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, dianders@chromium.org, catalin.marinas@arm.com,
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

On Wed, Apr 15, 2020 at 11:50:58AM +0100, Suzuki K Poulose wrote:
> On 04/14/2020 10:31 PM, Will Deacon wrote:
> > We don't need to be quite as strict about mismatched AArch32 support,
> > which is good because the friendly hardware folks have been busy
> > mismatching this to their hearts' content.
> > 
> >    * We don't care about EL2 or EL3 (there are silly comments concerning
> >      the latter, so remove those)
> > 
> >    * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
> >      gracefully when a mismatch occurs
> > 
> >    * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled
> 
> s/EL1/EL0
> 
> >      gracefully when a mismatch occurs
> > 
> > Relax the AArch32 checks to FTR_NONSTRICT.
> 
> Agreed. We should do something similar for the features exposed by the
> ELF_HWCAP, of course in a separate series.

Hmm, I didn't think we needed to touch the HWCAPs, as they're derived from
the sanitised feature register values. What am I missing?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
