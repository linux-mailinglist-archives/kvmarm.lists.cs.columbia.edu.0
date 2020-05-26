Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE001D7FB7
	for <lists+kvmarm@lfdr.de>; Mon, 18 May 2020 19:09:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 28AA74B177;
	Mon, 18 May 2020 13:09:44 -0400 (EDT)
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
	with ESMTP id wMsLcaYXoZSN; Mon, 18 May 2020 13:09:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D94814B172;
	Mon, 18 May 2020 13:09:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7104E4B16C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 13:09:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lvTwMWhrA90l for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 May 2020 13:09:40 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C0854B15E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 13:09:40 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 09D96207E8;
 Mon, 18 May 2020 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589821779;
 bh=n3Jpm9TY854YSFMuLHwI+o4mk5x9P1AZ1cqMTatvLiQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V8L67bWuzL7d4qlbk48Otx7KYfhX0YF5j+C/FGzKYy7zntJaLwj/00MxWZCRYu2aR
 XIPzulnbJQY2ZCLWNImokFU8DgFzTt/RrzaMWPM28+kKmeRqyQ7uUlq5ynve8p7Hxt
 jU5kYqCUHm6B0xu6x5HEnbPzhPAVedwMsH5HctNs=
Date: Mon, 18 May 2020 18:09:34 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2] arm64/cpufeature: Drop open encodings while
 extracting parange
Message-ID: <20200518170934.GT32394@willie-the-truck>
References: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
 <20200518165958.GS32394@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200518165958.GS32394@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Mon, May 18, 2020 at 05:59:59PM +0100, Will Deacon wrote:
> On Wed, May 13, 2020 at 02:33:34PM +0530, Anshuman Khandual wrote:
> > Currently there are multiple instances of parange feature width mask open
> > encodings while fetching it's value. Even the width mask value (0x7) itself
> > is not accurate. It should be (0xf) per ID_AA64MMFR0_EL1.PARange[3:0] as in
> > ARM ARM (0487F.a). Replace them with cpuid_feature_extract_unsigned_field()
> > which can extract given standard feature (4 bits width i.e 0xf mask) field.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: kvmarm@lists.cs.columbia.edu
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Changes in V2:
> > 
> > - Used cpuid_feature_extract_unsigned_field() per Mark
> > 
> > Changes in V1: (https://patchwork.kernel.org/patch/11541913/)
> > 
> >  arch/arm64/kernel/cpufeature.c |  3 ++-
> >  arch/arm64/kvm/reset.c         | 11 ++++++++---
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I'm assuming Marc will take this, but let me know if it should go via arm64
> instead (where we have a bunch of other cpufeature stuff queued).

Hmm, but having just spotted [1], it looks like we might need a bit of
co-ordination here. Marc?

Will

[1] https://lore.kernel.org/r/1589248647-22925-1-git-send-email-anshuman.khandual@arm.com
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
