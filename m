Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D1A1256
	for <lists+kvmarm@lfdr.de>; Thu, 29 Aug 2019 09:10:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C81F4A585;
	Thu, 29 Aug 2019 03:10:20 -0400 (EDT)
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
	with ESMTP id Aq7r9IKr8TUP; Thu, 29 Aug 2019 03:10:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B9254A559;
	Thu, 29 Aug 2019 03:10:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AABED4A53B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 13:45:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aNtMAjLprUnJ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 13:45:08 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C8AC44A4E8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 13:45:08 -0400 (EDT)
Subject: Re: [GIT PULL] arm64: Fixes for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567014307;
 bh=hc0bjImHvnq/IxCT5s4NZI7gpFd6msv+Pulf0AYrCR4=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Oe2zFU4HpEJT04R+CubK1ZvFncH0jBu+Vkbguy2huLOriKL/CTUcTaDPCYgaKJKei
 XVVJ3CUe00SyErsxbyAewrvodXJBzCciVlNo6Q9/Q8x3yallMOeG/uPT2Uo9GHA5NK
 qqSIR8ONUMBj7/2inMxN8JMfs5yti7gQAUwK25iE=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
References: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 82e40f558de566fdee214bec68096bbd5e64a6a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cf6b756cdf2cd38b8b0dac2567f7c6daf5e79d5
Message-Id: <156701430762.19174.2439398136739791001.pr-tracker-bot@kernel.org>
Date: Wed, 28 Aug 2019 17:45:07 +0000
To: Will Deacon <will@kernel.org>
X-Mailman-Approved-At: Thu, 29 Aug 2019 03:10:17 -0400
Cc: kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 torvalds@linux-foundation.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

The pull request you sent on Wed, 28 Aug 2019 18:32:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cf6b756cdf2cd38b8b0dac2567f7c6daf5e79d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
