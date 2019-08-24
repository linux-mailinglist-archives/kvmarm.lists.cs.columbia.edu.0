Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F36039BD90
	for <lists+kvmarm@lfdr.de>; Sat, 24 Aug 2019 14:13:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 316824A60D;
	Sat, 24 Aug 2019 08:13:07 -0400 (EDT)
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
	with ESMTP id cznFl4BMRzbH; Sat, 24 Aug 2019 08:13:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 479E94A5EB;
	Sat, 24 Aug 2019 08:13:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 77BF84A521
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Aug 2019 08:13:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UE0wGePdxeuA for <kvmarm@lists.cs.columbia.edu>;
 Sat, 24 Aug 2019 08:13:01 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 538E84A479
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Aug 2019 08:13:01 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F0742146E;
 Sat, 24 Aug 2019 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566648780;
 bh=pgQ5Ieucz1re8Y5x9mZNInXpje3w1mq20odaNn+SSIg=;
 h=Date:From:To:Cc:Subject:From;
 b=0sVRhMLveGErFokACfC8K6gIMaNqREenHEwTEMdROoQ9NAr6UvnKr0ys68pi9hVzh
 qG+nnyoD833+wo9ytWfMAkTh1+1dX4+K8eOA5+Z1+4DWvb4PZxlxpy42kX2xf/hzx0
 siwNtoKHGrBEC53KPvI7tHNjUm0OFqXihr0n9wug=
Date: Sat, 24 Aug 2019 13:12:55 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] arm64: Fixes for -rc6
Message-ID: <20190824121255.ojqt7tjlzfp5a3nw@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Linus,

Please pull these two KVM/arm fixes for -rc6. Unusually, we're routing them
via the arm64 tree as per Paolo's request on the list:

  https://lore.kernel.org/kvm/21ae69a2-2546-29d0-bff6-2ea825e3d968@redhat.com/

We don't actually have any other arm64 fixes pending at the moment (touch
wood), so I've pulled from Marc, written a merge commit, tagged the
result and run it through my build/boot/bisect scripts.

Cheers,

Will

--->8

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 087eeea9adcbaef55ae8d68335dcd3820c5b344b:

  Merge tag 'kvmarm-fixes-for-5.3-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm/fixes (2019-08-24 12:46:30 +0100)

----------------------------------------------------------------
arm64 fixes for -rc6

- Two KVM fixes for MMIO emulation and UBSAN

----------------------------------------------------------------
Andre Przywara (1):
      KVM: arm/arm64: VGIC: Properly initialise private IRQ affinity

Andrew Jones (1):
      KVM: arm/arm64: Only skip MMIO insn once

Will Deacon (1):
      Merge tag 'kvmarm-fixes-for-5.3-3' of git://git.kernel.org/.../kvmarm/kvmarm into kvm/fixes

 virt/kvm/arm/mmio.c           |  7 +++++++
 virt/kvm/arm/vgic/vgic-init.c | 30 ++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 10 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
