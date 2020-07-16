Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 35517222252
	for <lists+kvmarm@lfdr.de>; Thu, 16 Jul 2020 14:23:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B7CAE4B4A2;
	Thu, 16 Jul 2020 08:23:56 -0400 (EDT)
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
	with ESMTP id RCs-r6pDdpku; Thu, 16 Jul 2020 08:23:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8290E4B499;
	Thu, 16 Jul 2020 08:23:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CD6B4B499
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jul 2020 08:23:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jzEA2Ud8HUXT for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Jul 2020 08:23:53 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9075E4B497
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jul 2020 08:23:53 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8809D2065F;
 Thu, 16 Jul 2020 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594902232;
 bh=+Ghs4LOaDAoadOr3B+4gz1tLJsknayclNEj2KVTuQ3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MFLmdRM94McqLPi9kL70+1Nq2bwhjFuQisNFhs9+SyOQ6tnplhLpRHd5zplqmTdwP
 0/S4c1iyblhcyoTwqM+vMKc+t4AqtTF3/vO9UR3gJvQJZkVl1pBSbIXDWLuIGr7Ms6
 U4AM3cWGoDKqWkAW+M6bFZFFCIrGiHGNDxx3uoWM=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: Use default kernel offset when the image file
 can't be seeked
Date: Thu, 16 Jul 2020 13:23:46 +0100
Message-Id: <159490198219.132431.9609124940381442265.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716120801.2996-1-maz@kernel.org>
References: <20200716120801.2996-1-maz@kernel.org>
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

On Thu, 16 Jul 2020 13:08:01 +0100, Marc Zyngier wrote:
> While introducing new code to extract the kernel offset from the
> image, commit fd0a05b ("arm64: Obtain text offset from kernel image")
> introduced a regression where something such as:
> 
>   ./lkvm run -c 8 -p earlycon <(zcat /boot/vmlinuz-5.8.0-rc5-00172-ga161216e31ba)
> 
> now fails to load the kernel, as the file descriptor cannot be
> seeked.
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] arm64: Use default kernel offset when the image file can't be seeked
      https://git.kernel.org/will/kvmtool/c/c9acdae1d2e7

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
