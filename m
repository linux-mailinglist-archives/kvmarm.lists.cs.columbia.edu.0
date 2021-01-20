Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 927082FD0F5
	for <lists+kvmarm@lfdr.de>; Wed, 20 Jan 2021 14:01:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 426544B1A3;
	Wed, 20 Jan 2021 08:01:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPxp+7fN+-sz; Wed, 20 Jan 2021 08:01:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C0054B162;
	Wed, 20 Jan 2021 08:01:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B913A4B139
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Jan 2021 08:01:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WNjWw20TryN for <kvmarm@lists.cs.columbia.edu>;
 Wed, 20 Jan 2021 08:01:26 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A3D164B12E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Jan 2021 08:01:26 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 571442336D;
 Wed, 20 Jan 2021 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611147685;
 bh=CQnK8NOEqOn+2lw2WQmrg5m/8Ek+U2xfZNr32QvVLF4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DmkoqN1Qwca0h9LobM+p23TfZWVpO/rGiq3AZ+LGtehnaPaFT+/rMRBveI662sMlh
 Z260mVVqfhO2zNNrNVr3mW/ZRrGu7n7fAUW1yKXftYxinPbr/jbIWd3aGzmUd8ABC/
 F5H4VrC+bDnxAh1LpP9Lj5me7mK/yXPdxZBPTmaG+GguFHob2VpENVZpmQLUaMZMqq
 LOTBFbKErb3S/a+scQszZXySCHrBbboPJ+XXBVLxWHi4xzvAWp4RI2qj13IzlSU7Xk
 xnBOLloHIg9VgIVnjFlfWHjS0XnW1JTFyr0F77LhQ3Xny+u+0bZMyl82EIkyMuxLED
 CNXrBwauj+c6Q==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] arm64: Drop workaround for broken 'S' constraint with GCC
 4.9
Date: Wed, 20 Jan 2021 13:01:07 +0000
Message-Id: <161114468899.213658.2562467743255957589.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210118130129.2875949-1-maz@kernel.org>
References: <20210118130129.2875949-1-maz@kernel.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>
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

On Mon, 18 Jan 2021 13:01:29 +0000, Marc Zyngier wrote:
> Since GCC < 5.1 has been shown to be unsuitable for the arm64 kernel,
> let's drop the workaround for the 'S' asm constraint that GCC 4.9
> doesn't always grok.
> 
> This is effectively a revert of 9fd339a45be5 ("arm64: Work around
> broken GCC 4.9 handling of "S" constraint").

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Drop workaround for broken 'S' constraint with GCC 4.9
      https://git.kernel.org/arm64/c/7001d4af926b

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
