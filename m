Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5FF1F365D
	for <lists+kvmarm@lfdr.de>; Tue,  9 Jun 2020 10:49:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E0BD34B3AF;
	Tue,  9 Jun 2020 04:49:46 -0400 (EDT)
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
	with ESMTP id tEXe+k9d8283; Tue,  9 Jun 2020 04:49:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B20D14B3C8;
	Tue,  9 Jun 2020 04:49:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B971F4B3AF
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jun 2020 04:49:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i7vY-rpPWpxv for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Jun 2020 04:49:42 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6CB914B3B1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jun 2020 04:49:42 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B054207C3;
 Tue,  9 Jun 2020 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591692581;
 bh=DTLwx+4FGcD1qdI1v5kAz9K25967wcxylJEAbdulMwk=;
 h=From:To:Cc:Subject:Date:From;
 b=ytgOPaxFBmwQdjr6FKBkwvu6yN10vCR0Bl4hXjVrLMhediqGY6bm+xtmxvKssX6yG
 vgYgCLA1k/s5X94SWV05hls/Gwxob2+qr0O8bTxRogYBzetvlxU54RihVoy56OoEoF
 1KLUpYDyXrc3KCdw6rwhEh5rFK9RbnH4RWcCzOAc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jiZwx-001PEa-J5; Tue, 09 Jun 2020 09:49:39 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] KVM: arm64: Additional 32bit fixes
Date: Tue,  9 Jun 2020 09:49:19 +0100
Message-Id: <20200609084921.1448445-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

Here's a couple of patches that address the issues that James
mentionned in [1], affecting 32bit guests.

I lack a BE-capable host to properly test the first patch, but it is
obviously correct (ha! ;-).

[1] https://lore.kernel.org/r/20200526161834.29165-1-james.morse@arm.com

Marc Zyngier (2):
  KVM: arm64: Make vcpu_cp1x() work on Big Endian hosts
  KVM: arm64: Synchronize sysreg state on injecting an AArch32 exception

 arch/arm64/include/asm/kvm_host.h | 10 ++++++++--
 arch/arm64/kvm/aarch32.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
