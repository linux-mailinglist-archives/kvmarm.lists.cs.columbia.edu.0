Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1A1626D8
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 14:10:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 768F84AF39;
	Tue, 18 Feb 2020 08:10:02 -0500 (EST)
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
	with ESMTP id JUTScTDWj9EO; Tue, 18 Feb 2020 08:10:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54ED54AEF6;
	Tue, 18 Feb 2020 08:10:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4385A4AED8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 08:10:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0uwGSRBy7qv for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 08:09:59 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 312B64AEBF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 08:09:59 -0500 (EST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BFC6E22B48;
 Tue, 18 Feb 2020 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582031398;
 bh=iZo3lTLBwRcWtzxFLrZ/PPJnn8uh6OcUqPq9jjsb7JA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q4yfUNd2ekp8WaDMi4EHhuP7kkTy6FeIq4j9nZhBSiGeI8FgwgthCX44opkrJF105
 r4fwPJMIXRjX5aWMGOZ97P6mKlv1dh92/HCk5v15p/vsOio01JKmrqIBfjC29HV/3n
 D217w48s1M8X0uDmhykbLBtSmKpfLN6cAy+gur7U=
Date: Tue, 18 Feb 2020 13:09:53 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: kvm: Modernize annotation for __bp_harden_hyp_vecs
Message-ID: <20200218130953.GD20212@willie-the-truck>
References: <20200218124456.10615-1-broonie@kernel.org>
 <49f7de5f1d86e7edcc34edb55d5011be@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49f7de5f1d86e7edcc34edb55d5011be@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
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

On Tue, Feb 18, 2020 at 12:56:52PM +0000, Marc Zyngier wrote:
> I'd really appreciate it if you could send these as a series, instead of
> an isolated patch every other day.

Same for the non-KVM parts, please :)

I *think* the current ones to track are:

[PATCH v2] arm64: sdei: Annotate SDEI entry points using new style annotat
[PATCH 1/2] arm64: crypto: Modernize some extra assembly annotations
[PATCH 2/2] arm64: crypto: Modernize names for AES function macros
[PATCH] arm64: entry: Annotate ret_from_fork as code
[PATCH] arm64: head: Annotate stext and preserve_boot_args as code
[PATCH 1/3] arm64: entry-ftrace.S: Convert to modern annotations for assem
[PATCH 2/3] arm64: ftrace: Correct annotation of ftrace_caller assembly
[PATCH 3/3] arm64: ftrace: Modernise annotation of return_to_handler
[PATCH] arm64: vdso: Convert to modern assembler annotations
[PATCH] arm64: vdso32: Convert to modern assembler annotations
[PATCH] arm64: entry: Annotate vector table and handlers as code
[PATCH] arm64: head.S: Convert to modern annotations for assembly function
[PATCH] arm64: kernel: Convert to modern annotations for assembly data
[PATCH] arm64: kernel: Convert to modern annotations for assembly function
[PATCH] arm64: entry: Additional annotation conversions for entry.S
[PATCH v2] arm64: kvm: Annotate assembly using modern annoations
[PATCH v6 00/11] arm64: Branch Target Identification support
[PATCH] arm64: kvm: Modernize annotation for __bp_harden_hyp_vecs

but it's a bit much to follow, especially as there are three trees
involved in the above!

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
