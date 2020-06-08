Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A41F1C39
	for <lists+kvmarm@lfdr.de>; Mon,  8 Jun 2020 17:38:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A96D4B1CB;
	Mon,  8 Jun 2020 11:38:09 -0400 (EDT)
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
	with ESMTP id ulLkg24SL20C; Mon,  8 Jun 2020 11:38:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A7334B1C5;
	Mon,  8 Jun 2020 11:38:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E57FE4B19D
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 11:38:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWvIzWVUKSOp for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Jun 2020 11:38:06 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E33894B0DD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 11:38:05 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A1165206C3;
 Mon,  8 Jun 2020 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591630684;
 bh=wFRnuIEcclQwBa7O4RGpg1H6x7+WtZkc5wB88I2CllE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T0kC3ul1geumHYA0d8rlEz0QMlEBH2as3k8vCKZOPbwufUi5TKFPid1fPeAc+i7Zq
 Zt8cz0JOJyE0e+xR6f+ZEaUjFtnhcH63PWQ2oFda5bGrSJhfslBLFWbF2Og+MLuH1h
 dBouAg2X5TT9Osqc58zTM1qvEdycFz3n1XGAahRE=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Obtain text offset from kernel image
Date: Mon,  8 Jun 2020 16:37:59 +0100
Message-Id: <159163026468.66082.18224938042662826432.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608152801.1415902-1-maz@kernel.org>
References: <20200608152801.1415902-1-maz@kernel.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
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

On Mon, 8 Jun 2020 16:28:01 +0100, Marc Zyngier wrote:
> Recent changes made to Linux 5.8 have outlined that kvmtool
> hardcodes the text offset instead of reading it from the arm64
> image itself.
> 
> To address this, import the image header structure into kvmtool
> and do the right thing. 32bit guests are still loaded to their
> usual locations.
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] arm64: Obtain text offset from kernel image
      https://git.kernel.org/will/kvmtool/c/fd0a05bd27dd

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
