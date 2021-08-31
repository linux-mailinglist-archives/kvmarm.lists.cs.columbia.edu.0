Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C79263FCA86
	for <lists+kvmarm@lfdr.de>; Tue, 31 Aug 2021 17:06:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 338B74B227;
	Tue, 31 Aug 2021 11:06:13 -0400 (EDT)
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
	with ESMTP id c0HeIIJByUeh; Tue, 31 Aug 2021 11:06:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A8E84B1FC;
	Tue, 31 Aug 2021 11:06:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 28FF34B190
 for <kvmarm@lists.cs.columbia.edu>; Tue, 31 Aug 2021 11:06:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P76OuSr9wBHr for <kvmarm@lists.cs.columbia.edu>;
 Tue, 31 Aug 2021 11:06:07 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 081564A126
 for <kvmarm@lists.cs.columbia.edu>; Tue, 31 Aug 2021 11:06:07 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC51860F9E;
 Tue, 31 Aug 2021 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630422365;
 bh=ViEcZriqNGftF6CD6GvE421AsLC+XWVHOYgf9s6bi40=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ucV/l2krKJt53NOLNvrINOu+/Vf0KBjb+f7K+Yg9yirJro99zhofmSGOkgMkGuU9M
 HANpEBMBspd9KoD1rFuzb2rV4cUy2hGFuGRGEOKwkVGXUFI06eC/y2NAUxz+pnA793
 B3LFHqG0VGfB8R0dTjllr9lVv0lylGd0Cy175lRXA9VN74GQzq6SYySYJzTc7yZCie
 Ex8Or2SMqEq3V0SexX605y06M3BVe+ykaf0BGx+Wid/Mpt+za3tArccRz3DQdSS3tW
 7O4IBNlZy45gZ0yIMLKUJISoL5ECmbawIljG/R+p9eYuH3B7QWR7P5CJfOrw1E9UtV
 Dgl2UjBhjhpcA==
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: Re: [PATCH][kvmtool] virtio/pci: Size the MSI-X bar according to the
 number of MSI-X
Date: Tue, 31 Aug 2021 16:05:56 +0100
Message-Id: <163042127389.1911500.12320690511273820628.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210827115405.1981529-1-maz@kernel.org>
References: <20210827115405.1981529-1-maz@kernel.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, Andre Przywara <andre.przywara@arm.com>,
 kernel-team@android.com, Will Deacon <will@kernel.org>
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

On Fri, 27 Aug 2021 12:54:05 +0100, Marc Zyngier wrote:
> Since 45d3b59e8c45 ("kvm tools: Increase amount of possible interrupts
> per PCI device"), the number of MSI-S has gone from 4 to 33.
> 
> However, the corresponding storage hasn't been upgraded, and writing
> to the MSI-X table is a pretty risky business. Now that the Linux
> kernel writes to *all* MSI-X entries before doing anything else
> with the device, kvmtool dies a horrible death.
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] virtio/pci: Size the MSI-X bar according to the number of MSI-X
      https://git.kernel.org/will/kvmtool/c/2e7380db438d

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
