Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 30E434691A9
	for <lists+kvmarm@lfdr.de>; Mon,  6 Dec 2021 09:41:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9083F4B0D0;
	Mon,  6 Dec 2021 03:41:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55eEYWFTRBNW; Mon,  6 Dec 2021 03:41:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7145E4B09C;
	Mon,  6 Dec 2021 03:41:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 611EC4B08E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Dec 2021 03:41:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxjR9-AEbXIO for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Dec 2021 03:41:39 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 822DF40C88
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Dec 2021 03:41:39 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4FACB611A6;
 Mon,  6 Dec 2021 08:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3C3C341C4;
 Mon,  6 Dec 2021 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638780097;
 bh=N7MFclF8OkmzxofuXcBa7l2alQne5gxGS+q9vaudIRE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LpGgLdZuafzoB+AS9eU985bLrCSPY32gO3ZUD+fZUhWHz+41eimkq2avP2DZYkWb3
 6lpMkMoZRzIynwzVYdBFsO/UKMflp8bj4Q2l6/E8b4sZ324aZfiM6s11Bm8vMFd+62
 kiuZ7OpS21h32ENxxPdo6vDve2AOPXoMNEmPIKaoStW4cV8E+KnNTlZPaFEQ9I9yHv
 V4KrthYU7yj/PYkaLVj3MXAjdLTTbQGZlyhJVzInK+zg3cfhT/0OtCVtEzQh5YyzT2
 pSgqifG4Wy0gMkXi0b0mG8s5fOYT7wAb51zgpEyXPAM0uSZuTTri8ZVmyf5XCmRXRh
 GXcLofdS5kKYg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mu9Z1-00A7wB-Jw; Mon, 06 Dec 2021 08:41:35 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>,
	kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 0/3] KVM: arm64: Keep hyp and host headers separate where
 possible
Date: Mon,  6 Dec 2021 08:41:31 +0000
Message-Id: <163878008391.1389659.11356018636519306544.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211202171048.26924-1-will@kernel.org>
References: <20211202171048.26924-1-will@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-arm-kernel@lists.infradead.org
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

On Thu, 2 Dec 2021 17:10:45 +0000, Will Deacon wrote:
> This series tidies up the header file usage for the nvhe hyp object so
> that header files under arch/arm64/kvm/hyp/include are not included by
> host code running at EL1.
> 
> For definitions that are shared between the host and hypervisor, these
> are either moved to headers under arch/arm64/include/asm/ or are
> generated by kbuild along similar lines to asm-offsets.h. For now, this
> allows us to tidy up some of the pKVM reserved memory handling, but in
> future this will also allow the pKVM EL2 data structures to avoid
> polluting the host namespace.
> 
> [...]

Applied to next, thanks!

[1/3] arm64: Add missing include of asm/cpufeature.h to asm/mmu.h
      commit: 7e04f05984dd03edad7daaa4fa97958b7133c62a
[2/3] KVM: arm64: Generate hyp_constants.h for the host
      commit: ed4ed15d571065eb66ea718d7f6050553586417d
[3/3] KVM: arm64: Move host EL1 code out of hyp/ directory
      commit: 9429f4b0412d05243237c7695c59d0a7b1174492

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
