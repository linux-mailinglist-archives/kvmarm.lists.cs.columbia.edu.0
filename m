Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1C883FCA87
	for <lists+kvmarm@lfdr.de>; Tue, 31 Aug 2021 17:06:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4ED8B4B1FC;
	Tue, 31 Aug 2021 11:06:19 -0400 (EDT)
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
	with ESMTP id syp2IPMN6HEe; Tue, 31 Aug 2021 11:06:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D8134B208;
	Tue, 31 Aug 2021 11:06:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C6774B1E3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 31 Aug 2021 11:06:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mOaWuoGRL+xb for <kvmarm@lists.cs.columbia.edu>;
 Tue, 31 Aug 2021 11:06:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 23F1E4B1B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 31 Aug 2021 11:06:09 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BA296103D;
 Tue, 31 Aug 2021 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630422368;
 bh=XHbZCyXFKS91ozVBaBZ4Jze0qsTAeA3U1lrYt7pcprE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wcao7jEch1QMjoymMxc0kQhOjIocx/ouNX/Jj2K9NBuHZLdv76se7MDt2i+NL1LCu
 ym9eaHWyc9D+KChXr+JqQtDtMdzN+coULGXNaQKlWgGoAkXUUiMUk0usNsTY+8sbw/
 1d2QKdmt7YUlrC7tTV83fJ6VILFGYg9yDdB8EVbt8CbO9T/5wcH0xMXddNLM2JwllC
 NHVlieHPYYdWnxl+H58rXF7M6OeZPzMCoXrHdRZiAgH1Gf2ttxgpNuUE5VEKo4mwMb
 TXXE+uFOKudiM1KasYI0hmubflb0enyKzKLCHeABsfUJKyMSuSb2KdCqCXLoR8+cJp
 oX7X1MYCO5CWw==
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2 0/3] kvmtool: Limit IPA space to what is actually
 required
Date: Tue, 31 Aug 2021 16:05:57 +0100
Message-Id: <163042121770.1911365.5609247685320419649.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210822152526.1291918-1-maz@kernel.org>
References: <20210822152526.1291918-1-maz@kernel.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Andre Przywara <andre.przywara@arm.com>
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

On Sun, 22 Aug 2021 16:25:23 +0100, Marc Zyngier wrote:
> KVM hacking on the Apple M1 SoC has shown that kvmtool (and other
> VMMs) make pretty poor use of the IPA space parameter (read: do not
> use it and just pass 0). This results in a guest that cannot boot
> (recent kernels will just send the VMM packing), and in general means
> we don't benefit from smaller page tables at stage-2.
> 
> This series does three things:
> - It switches kvmtool away from the default 40bit, allowing large VMs
>   to be created (I have booted a 4TB VM)
> - It reduces the requested IPA space to be as small as possible
> - It tells the user why the VM cannot boot when the IPA space required
>   exceeds that of the HW
> 
> [...]

Applied to kvmtool (master), thanks!

[1/3] kvmtool: Abstract KVM_VM_TYPE into a weak function
      https://git.kernel.org/will/kvmtool/c/4250819de93b
[2/3] kvmtool: arm64: Use the maximum supported IPA size when creating the VM
      https://git.kernel.org/will/kvmtool/c/066b5c06c4e3
[3/3] kvmtool: arm64: Configure VM with the minimal required IPA space
      https://git.kernel.org/will/kvmtool/c/bdb86d0c0c95

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
