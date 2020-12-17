Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 111B02DD2A3
	for <lists+kvmarm@lfdr.de>; Thu, 17 Dec 2020 15:13:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 72BDD4B1FF;
	Thu, 17 Dec 2020 09:13:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id diQY6-x4HMBY; Thu, 17 Dec 2020 09:13:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 676504B1F2;
	Thu, 17 Dec 2020 09:13:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 436BB4B1E8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 09:13:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MYxLou8QRejj for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Dec 2020 09:13:28 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E060D4B1CD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 09:13:27 -0500 (EST)
From: Catalin Marinas <catalin.marinas@arm.com>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Work around broken GCC 4.9 handling of "S"
 constraint
Date: Thu, 17 Dec 2020 14:13:23 +0000
Message-Id: <160821437878.18463.2650889396125044729.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201217111135.1536658-1-maz@kernel.org>
References: <20201217111135.1536658-1-maz@kernel.org>
MIME-Version: 1.0
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
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

On Thu, 17 Dec 2020 11:11:35 +0000, Marc Zyngier wrote:
> GCC 4.9 seems to have a problem with the "S" asm constraint
> when the symbol lives in the same compilation unit, and pretends
> the constraint is impossible:
> 
> $ cat x.c
> void *foo(void)
> {
> 	static int x;
> 	int *addr;
> 	asm("adrp %0, %1" : "=r" (addr) : "S" (&x));
> 	return addr;
> }
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Work around broken GCC 4.9 handling of "S" constraint
      https://git.kernel.org/arm64/c/9fd339a45be5

-- 
Catalin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
