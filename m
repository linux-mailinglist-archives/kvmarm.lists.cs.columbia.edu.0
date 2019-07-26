Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 826F076B4E
	for <lists+kvmarm@lfdr.de>; Fri, 26 Jul 2019 16:17:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 748A64A549;
	Fri, 26 Jul 2019 10:17:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "To"
	occurs 3 times
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
	with ESMTP id 0VYD-PWGUJD2; Fri, 26 Jul 2019 10:17:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BF1F4A52B;
	Fri, 26 Jul 2019 10:17:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B2E64A4F9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Jul 2019 10:17:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "To"
 occurs 3 times
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ru-ioZnKCez9 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 26 Jul 2019 10:17:18 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 288AC4A4F6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Jul 2019 10:17:18 -0400 (EDT)
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC75E229F9;
 Fri, 26 Jul 2019 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564150637;
 bh=7vvR0BPXIOyC4A1NG2CnAxtG+FxJl2p9/zLtQ0tDJjg=;
 h=Date:From:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
 b=Q1RDkCJU70Z/xZBGobrvvAdrIS+2oiiAuLkUCcDFE60oBdiXbjbfmzT+y6IVzb/3y
 w+4GiyLDpAI9q40n2jReHXlX1dyW0aQMU0wqMxT7yJSvhXb82rykozXdoTr1NIDnqy
 VA7y7l79oD4JUHoRkTB8IhjOeX8F7LX8Ln4AnpbQ=
Date: Fri, 26 Jul 2019 14:17:16 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
To: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH 1/2] arm64: KVM: regmap: Mark expected switch fall-through
In-Reply-To: <20190726112705.19000-1-anders.roxell@linaro.org>
References: <20190726112705.19000-1-anders.roxell@linaro.org>
Message-Id: <20190726141716.CC75E229F9@mail.kernel.org>
Cc: , stable@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: a892819560c4 KVM: arm64: Prepare to handle deferred save/restore of 32-bit registers.

The bot has tested the following trees: v5.2.2, v5.1.19, v4.19.60.

v5.2.2: Failed to apply! Possible dependencies:
    fdec2a9ef853 ("KVM: arm64: Migrate _elx sysreg accessors to msr_s/mrs_s")

v5.1.19: Failed to apply! Possible dependencies:
    73433762fcae ("KVM: arm64/sve: System register context switch and access support")
    be604c616ca7 ("arm64: sysreg: Make mrs_s and msr_s macros work with Clang and LTO")
    fdec2a9ef853 ("KVM: arm64: Migrate _elx sysreg accessors to msr_s/mrs_s")

v4.19.60: Failed to apply! Possible dependencies:
    84135d3d18da ("KVM: arm/arm64: consolidate arch timer trap handlers")
    8a411b060f82 ("KVM: arm/arm64: Remove arch timer workqueue")
    9e01dc76be6a ("KVM: arm/arm64: arch_timer: Assign the phys timer on VHE systems")
    accb99bcd0ca ("KVM: arm/arm64: Simplify bg_timer programming")
    bd7d95cafb49 ("arm64: KVM: Consistently advance singlestep when emulating instructions")
    e604dd5d45c7 ("KVM: arm/arm64: timer: Rework data structures for multiple timers")
    fdec2a9ef853 ("KVM: arm64: Migrate _elx sysreg accessors to msr_s/mrs_s")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
