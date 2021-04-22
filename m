Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9F294368143
	for <lists+kvmarm@lfdr.de>; Thu, 22 Apr 2021 15:10:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CEAF4B4E4;
	Thu, 22 Apr 2021 09:10:52 -0400 (EDT)
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
	with ESMTP id xCUKGvFT4dIS; Thu, 22 Apr 2021 09:10:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D3654B44A;
	Thu, 22 Apr 2021 09:10:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D26894B3A8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 09:10:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I4V1qgCzQzWv for <kvmarm@lists.cs.columbia.edu>;
 Thu, 22 Apr 2021 09:10:45 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F2E754B3A5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 09:10:44 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7393160FF1;
 Thu, 22 Apr 2021 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619097042;
 bh=w5sXlLF70Z413juhDaKlUm4jbVBoVeustbBPoJbzpnw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NEnwxHigM3F//1ZmOB2dEBv2LJWo3PQSTY979NNCbeGxlAjgb+jigXEkVlEB4mohQ
 FmvJmD7bkq1yVQyimt1VV5JEYZgmPu7KEobQXq2tI/fkT+gJ62ch53uh9YlrO38P2e
 1iFre8BfbVrUzxCTeVRYacD1yVs3bx6VPXJXEv0tvKLqdpRo+a6Vk4AOqWWCz5cUnd
 v5epHz+5aUHOWd6CBDTUB6RViInPPMUU1se+7DxtEJvhv3KTGn3U6Yh+YfHEJ6kf6Q
 QgzKbuC/bTyPc8kVOJJYi8vtX0IGGeEj9lkbb8XAPo9zWKmkO6EpXthZXbLg2JW+TG
 LO98WGmLA6tEg==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 julien.thierry.kdev@gmail.com, Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH kvmtool] arm: Fail early if KVM_CAP_ARM_PMU_V3 is not
 supported
Date: Thu, 22 Apr 2021 14:10:37 +0100
Message-Id: <161909655048.2359255.9892790598815356092.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415131725.105675-1-alexandru.elisei@arm.com>
References: <20210415131725.105675-1-alexandru.elisei@arm.com>
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

On Thu, 15 Apr 2021 14:17:25 +0100, Alexandru Elisei wrote:
> pmu__generate_fdt_nodes() checks if the host has support for PMU in a guest
> and prints a warning if that's not the case. However, this check is too
> late because the function is called after the VCPU has been created, and
> VCPU creation fails if KVM_CAP_ARM_PMU_V3 is not available with a rather
> unhelpful error:
> 
> $ ./vm run -c1 -m64 -f selftest.flat --pmu
>   # lkvm run --firmware selftest.flat -m 64 -c 1 --name guest-1039
>   Info: Placing fdt at 0x80200000 - 0x80210000
>   Fatal: Unable to initialise vcpu
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] arm: Fail early if KVM_CAP_ARM_PMU_V3 is not supported
      https://git.kernel.org/will/kvmtool/c/415f92c33a22

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
