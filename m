Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC931C0306
	for <lists+kvmarm@lfdr.de>; Thu, 30 Apr 2020 18:48:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 039074B57A;
	Thu, 30 Apr 2020 12:48:06 -0400 (EDT)
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
	with ESMTP id tv2+x3dcqND0; Thu, 30 Apr 2020 12:48:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB8904B572;
	Thu, 30 Apr 2020 12:48:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A33A94B52E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 12:48:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p219IJ7yue2L for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Apr 2020 12:48:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A34824B52C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 12:48:02 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB7332070B;
 Thu, 30 Apr 2020 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588265281;
 bh=axoYz9ubvidu6Q4qb8tE1iZySwHLJ5aESX8frhVyuiE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ca/g0WoiwN4MNpRo23zI84MuVdc3f57axAaaKLI+X0I8yCH2/jidRQBKHbK8Kj0le
 p0ifJPTxniAeJNPxdDSQ3sL1FcGdRO8dvdmXF6bViBXQY+Fl9+SUzjn0eh/2hXocYc
 SNXgDN/8PRduyw3CCDEyv20e7Bjs+BAm0Et0exUw=
Date: Thu, 30 Apr 2020 17:47:56 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 00/16] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
Message-ID: <20200430164756.GH25258@willie-the-truck>
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
 <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
 <20200429212614.GD8604@willie-the-truck>
 <da15c0f0-f8ec-c2bc-bd5b-907a75119dc1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <da15c0f0-f8ec-c2bc-bd5b-907a75119dc1@arm.com>
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

On Thu, Apr 30, 2020 at 08:29:44AM +0530, Anshuman Khandual wrote:
> On 04/30/2020 02:56 AM, Will Deacon wrote:
> > On Wed, Apr 29, 2020 at 03:07:15PM +0530, Anshuman Khandual wrote:
> >> On 04/14/2020 03:18 PM, Anshuman Khandual wrote:
> >>> Changes in V2:
> >>>
> >>> - Added Suggested-by tag from Mark Rutland for all changes he had proposed
> >>> - Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
> >>> - Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
> >>> - Added ID_DFR1 and ID_MMFR5 system register definitions per Will
> >>> - Added remaining features bits for relevant 64 bit system registers per Will
> >>> - Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
> >>> - Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
> >>> - Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
> >>> - Changed some commit messages
> >>
> >> Just a gentle ping. I am wondering if you had a chance to glance
> >> through this updated series.
> > 
> > Please can you resend based on for-next/cpufeature?
> 
> Sure, will do.

Thanks. I'll keep an eye out for them.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
