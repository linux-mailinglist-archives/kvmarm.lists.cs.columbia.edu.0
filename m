Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 61D56266823
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 20:16:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C75434B353;
	Fri, 11 Sep 2020 14:16:42 -0400 (EDT)
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
	with ESMTP id OTaFIW4D7rrY; Fri, 11 Sep 2020 14:16:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A21914B33C;
	Fri, 11 Sep 2020 14:16:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DC5B4B32D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 14:16:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTfn+BYYjQOD for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 14:16:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 340884B2FC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 14:16:39 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0781D208E4;
 Fri, 11 Sep 2020 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599848198;
 bh=xiLwwQKdB3rqjy0HJkWYD2shDrqi+EEsJk9/W6rgFxw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NNZ4a05LYG5iuNBlkO3+vlk+9N0qcdLQQTSjhR+3vvMeqZtQicsUt3bmClS7jT4EV
 ynYUIBXPwmjU0ql1sFDEsbWG6k6Kt0PPuLUHGiwfTLNyJSIjCPfr4LoJ0VSdaAmju3
 0Nd0LkrFaUdAFRtnixDIR2gOJZs7SopFZz4WLB1k=
From: Will Deacon <will@kernel.org>
To: Pingfan Liu <kernelfans@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 1/2] arm64/relocate_kernel: remove redundant code
Date: Fri, 11 Sep 2020 19:16:31 +0100
Message-Id: <159984758595.3563738.8721956376933355883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1598621998-20563-1-git-send-email-kernelfans@gmail.com>
References: <1598621998-20563-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will@kernel.org>, Geoff Levand <geoff@infradead.org>,
 catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
 Mark Brown <broonie@kernel.org>,
 Remi Denis-Courmont <remi.denis.courmont@huawei.com>, kernel-team@android.com,
 Ard Biesheuvel <ardb@kernel.org>
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

On Fri, 28 Aug 2020 21:39:57 +0800, Pingfan Liu wrote:
> Kernel startup entry point requires disabling MMU and D-cache.
> 
> As for kexec-reboot, taking a close look at "msr sctlr_el1, x12" in
> __cpu_soft_restart as the following:
> 
> -1. booted at EL1
> The instruction is enough to disable MMU and I/D cache for
> EL1 regime.
> 
> [...]

Applied to arm64 (for-next/boot), thanks!

[1/1] arm64/relocate_kernel: remove redundant code
      https://git.kernel.org/arm64/c/72789a4a6a91

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
