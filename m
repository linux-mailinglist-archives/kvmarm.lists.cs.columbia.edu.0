Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD61A3536
	for <lists+kvmarm@lfdr.de>; Thu,  9 Apr 2020 15:55:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 141574B0CF;
	Thu,  9 Apr 2020 09:55:09 -0400 (EDT)
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
	with ESMTP id Z5tpbmO1Pe8c; Thu,  9 Apr 2020 09:55:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 132A74B12E;
	Thu,  9 Apr 2020 09:55:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 62EAF4B101
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Apr 2020 09:55:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4nCoRpehMAw for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Apr 2020 09:55:05 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 38ACE4B0CF
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Apr 2020 09:55:05 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 54ECF2078E;
 Thu,  9 Apr 2020 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586440503;
 bh=u95OMMVK9eb6dy/F0/3kmGSdhzJH2nqJgLn1FqXaxQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rf3pFoVhhdKX/hXOeijUgQVrWVz4G3hKTA3l5nXuRmQ9y+RgzAQK9k6qzp7fx4Ilm
 L2MJPZEKVshUGP0k4B9iJxlsjg9aGzAhUSNhdFI+b8fT5YxCbv1ulqu6fLkVps7q0U
 WclVAw4tK230taCd9rWndmoFPxmWctKbKHKwQrY0=
Date: Thu, 9 Apr 2020 14:54:58 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
Message-ID: <20200409135458.GE13078@willie-the-truck>
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <20200406170911.GA7446@willie-the-truck>
 <05f6eb1e-a82c-bd02-1871-e44ea00683d8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05f6eb1e-a82c-bd02-1871-e44ea00683d8@arm.com>
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

On Tue, Apr 07, 2020 at 02:20:20PM +0530, Anshuman Khandual wrote:
> 
> 
> On 04/06/2020 10:39 PM, Will Deacon wrote:
> > On Tue, Jan 28, 2020 at 06:09:03PM +0530, Anshuman Khandual wrote:
> >> This series is primarily motivated from an adhoc list from Mark Rutland
> >> during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
> >> which does macro replacement for various open bits shift encodings in
> >> various CPU ID registers. This series is based on linux-next 20200124.
> >>
> >> [1] https://patchwork.kernel.org/patch/11287805/
> >>
> >> Is there anything else apart from these changes which can be accommodated
> >> in this series, please do let me know. Thank you.
> > 
> > The latest Arm ARM also talks about DFR1 and MMFR5. Please can you include
> 
> Sure, will do.
> 
> > those too? Might also be worth checking to see if anything is missing on
> > the 64-bit side as well (I didn't look).
> 
> Yeah. Now there some missing ones, will add those as well.

Thanks. Just as a heads up that I've also got a handful of changes in
this area, but we can resolve the conflicts at -rc1.

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=sanity-checks

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
