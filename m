Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 67D933310FE
	for <lists+kvmarm@lfdr.de>; Mon,  8 Mar 2021 15:38:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C43F74B6CA;
	Mon,  8 Mar 2021 09:38:27 -0500 (EST)
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
	with ESMTP id T2BOA2pC18XU; Mon,  8 Mar 2021 09:38:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 65C674B601;
	Mon,  8 Mar 2021 09:38:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E7AC4B594
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Mar 2021 09:38:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jw0+HvwApyzm for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Mar 2021 09:38:23 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5072F4B56E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Mar 2021 09:38:23 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 491A8651AF;
 Mon,  8 Mar 2021 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615214301;
 bh=xUkap4mngTV+pjAfYLVmPPAgPzqiFl5Y3b7clSrqxNE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XUr1kAp/wcltPWZPPgh2hrzzLDbeNBzkAFUiiuZsh/5zguAdt6kf8MSe4fcNFmvgK
 +XLarVPYeHlifjSe5begeeW9jdu/30EhNo2T9GqbPI2yjAtTazUx10V4+dzskWpuIC
 V+C/tRMR569C0AjCG7WLPYMNrcvJYWgdJ+8cf/PGqf9cBmnj+P2RmTB96Ccz5eOvA7
 QnV4MKJJbxXhqOPRI7vphwkS4VgvYdRJRdGgnQONlA4U05PYSz5b/FKZqXt4QRJO57
 YjFzBG5uxUPtKvXEXnRUdeMa1JWj/nasuf3pLLCvXyRMHwOaFszsaC11bmn4Yx4SOo
 m4IX4KbXm60gQ==
Date: Mon, 8 Mar 2021 14:38:16 +0000
From: Will Deacon <will@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] KVM: arm64: Don't use cbz/adr with external symbols
Message-ID: <20210308143815.GA26312@willie-the-truck>
References: <20210305202124.3768527-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210305202124.3768527-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, Nathan Chancellor <nathan@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>
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

On Fri, Mar 05, 2021 at 12:21:24PM -0800, Sami Tolvanen wrote:
> allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
> linker errors:
> 
>   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
>   relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
>   [-1048576, 1048575]; references hyp_panic
>   >>> defined in vmlinux.o
> 
>   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
>   relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
>   [-1048576, 1048575]; references hyp_panic
>   >>> defined in vmlinux.o
> 
> This is because with LTO, the compiler ends up placing hyp_panic()
> more than 1MB away from __guest_enter(). Use an unconditional branch
> and adr_l instead to fix the issue.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1317
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kvm/hyp/entry.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
