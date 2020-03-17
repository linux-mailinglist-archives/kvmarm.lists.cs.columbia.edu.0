Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FA1891D6
	for <lists+kvmarm@lfdr.de>; Wed, 18 Mar 2020 00:14:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C93FF4B09A;
	Tue, 17 Mar 2020 19:14:40 -0400 (EDT)
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
	with ESMTP id 4g4HaE9BUelz; Tue, 17 Mar 2020 19:14:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 876324B088;
	Tue, 17 Mar 2020 19:14:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 134704A523
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Mar 2020 19:14:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDaFGMffsYYy for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Mar 2020 19:14:37 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F10674A4A3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Mar 2020 19:14:36 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9B9C20674;
 Tue, 17 Mar 2020 23:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584486875;
 bh=yHw9wmkRZUD7U6vWzsX9I+2UeHaJ6WKcTXK2YgtM0NQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ov90TkG86ZpHEydQCgM2v70whf8E34aREle1LDBQm45qWSKt4pgMmyL45WA2SFHqb
 c3Idzds5Q8YJAOZQ6xu3CxFUGgOYLHNfjBYDnRjA0If0vdQiWtYt6/LXTAtbz255sw
 da7d9RusApuvu6yQnM3l5rGMhGI66/k1Iz7Oo3rA=
Date: Tue, 17 Mar 2020 23:14:31 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv6 0/3] arm64: perf: Add support for ARMv8.5-PMU 64-bit
 counters
Message-ID: <20200317231431.GM20788@willie-the-truck>
References: <20200302181752.14251-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200302181752.14251-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: catalin.marinas@arm.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, maz@kernel.org
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

On Mon, Mar 02, 2020 at 06:17:49PM +0000, Mark Rutland wrote:
> This is a respin of Andrew Murray's series to enable support for 64-bit
> counters as introduced in ARMv8.5.
> 
> I've given this a spin on (ARMv8.2) hardware, to test that there are no
> regressions, but I have not had the chance to test in an ARMv8.5 model (which I
> beleive Andrew had previously tested).
> 
> Since v5 [1]:
> * Don't treat perfmon ID fields as signed
> * Fix up ID field names
> * Explicitly compare ARMV8.5 PMU value

I'm betting on your issue being a model bug, so I've queued this on top of
Robin's enable/disable rework. Please take a look at for-next/perf [1] in
case I screwed it up.

Thanks,

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-next/perf
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
