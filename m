Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9F1B6FE7
	for <lists+kvmarm@lfdr.de>; Fri, 24 Apr 2020 10:41:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4349A4B270;
	Fri, 24 Apr 2020 04:41:01 -0400 (EDT)
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
	with ESMTP id scYiXg3aC8Qp; Fri, 24 Apr 2020 04:41:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E3394B254;
	Fri, 24 Apr 2020 04:41:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB5414B187
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Apr 2020 04:40:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k0HGdNbpD+ST for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Apr 2020 04:40:57 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D1D774B185
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Apr 2020 04:40:57 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E6F420728;
 Fri, 24 Apr 2020 08:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587717656;
 bh=us+cckoY3UvgSdl2gPr8eg5gI2fu/T9757R6fhdxq84=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vqcjhokd+twfLjU9qHCknuOKxiUaqmabSaahgo6Atxa7Nji9kjc44PpG05phFmJpr
 fljMiTbcMAr42S+2AXhI+ea12pJTBtFMfCHAOm0nEIMSq2Fe48wsC4EVivcVMMfPqK
 ePiv9axjwN/eLot213Q3ouLMM0j3ITrlyk6mplpg=
Date: Fri, 24 Apr 2020 09:40:51 +0100
From: Will Deacon <will@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH kvmtool v4 0/5] Add CFI flash emulation
Message-ID: <20200424084051.GA20801@willie-the-truck>
References: <20200423173844.24220-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200423173844.24220-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Raphael Gault <raphael.gault@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
 kvmarm@lists.cs.columbia.edu
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

On Thu, Apr 23, 2020 at 06:38:39PM +0100, Andre Przywara wrote:
> an update for the CFI flash emulation, addressing Alex' comments and
> adding direct mapping support.
> The actual code changes to the flash emulation are minimal, mostly this
> is about renaming and cleanups.
> This versions now adds some patches. 1/5 is a required fix, the last
> three patches add mapping support as an extension. See below.

Cheers, this mostly looks good to me. I've left a couple of minor comments,
and I'll give Alexandru a chance to have another look, but hopefully we can
merge it soon.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
