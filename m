Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC458ABFB
	for <lists+kvmarm@lfdr.de>; Fri,  5 Aug 2022 15:58:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 106134E9CA;
	Fri,  5 Aug 2022 09:58:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3vwGEO5oxyH; Fri,  5 Aug 2022 09:58:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D0754EA51;
	Fri,  5 Aug 2022 09:58:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 41A4F4E8BB
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Aug 2022 09:58:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eDARH33SOPEn for <kvmarm@lists.cs.columbia.edu>;
 Fri,  5 Aug 2022 09:58:24 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B1F564E915
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Aug 2022 09:58:23 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A1298B8293E;
 Fri,  5 Aug 2022 13:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BFEC433D6;
 Fri,  5 Aug 2022 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659707901;
 bh=/gxbajhHikXlL++J6cn/R1UVErBI8pNcChVqAATSbRM=;
 h=From:To:Cc:Subject:Date:From;
 b=BDAI6R3LSuRyR1bvTSMhZ3RAkJC27ixmtr0S2FOQ8U2MwiwVe2IjmK7Xk94rwx8Ux
 PM/kQtU4hBgHeiPVpLwFnMDYiW+h+ffd0Vt4wXZe7dx8BEHiK7BCBpjPGWUPa25RD7
 w0153vAqKMdKAYt3rS7jKrYxMRscXKbWtupURK+3Is/CCpCqXAoUVsXnvzdDAPNy7y
 2c86PYmbdb7zT18nfe+m9cmhCNPwF2kO+zvcRTMVXFBBan6YbTzGpH74KhGJT1+YHC
 hvLjgKOVaz8ZomW2yfb5in+sdvDV//lYharVGxa24v3Du8yoU7/qqvyzbOR13ylnc5
 QUqZelAEg9QuQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oJxqE-001AeL-JE;
 Fri, 05 Aug 2022 14:58:19 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 0/9] KVM: arm64: PMU: Fixing chained events,
 and PMUv3p5 support
Date: Fri,  5 Aug 2022 14:58:04 +0100
Message-Id: <20220805135813.2102034-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 ricarkol@google.com, kernel-team@android.com
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

Ricardo recently reported[1] that our PMU emulation was busted when it
comes to chained events, as we cannot expose the overflow on a 32bit
boundary (which the architecture requires).

This series aims at fixing this (by deleting a lot of code), and as a
bonus adds support for PMUv3p5, as this requires us to fix a few more
things.

Tested on A53 (PMUv3) and FVP (PMUv3p5).

[1] https://lore.kernel.org/r/20220805004139.990531-1-ricarkol@google.com

Marc Zyngier (9):
  KVM: arm64: PMU: Align chained counter implementation with
    architecture pseudocode
  KVM: arm64: PMU: Distinguish between 64bit counter and 64bit overflow
  KVM: arm64: PMU: Only narrow counters that are not 64bit wide
  KVM: arm64: PMU: Add counter_index_to_*reg() helpers
  KVM: arm64: PMU: Simplify setting a counter to a specific value
  KVM: arm64: PMU: Move the ID_AA64DFR0_EL1.PMUver limit to VM creation
  KVM: arm64: PMU: Allow ID_AA64DFR0_EL1.PMUver to be set from userspace
  KVM: arm64: PMU: Implement PMUv3p5 long counter support
  KVM: arm64: PMU: Allow PMUv3p5 to be exposed to the guest

 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/kvm/arm.c              |   6 +
 arch/arm64/kvm/pmu-emul.c         | 372 ++++++++++--------------------
 arch/arm64/kvm/sys_regs.c         |  65 +++++-
 include/kvm/arm_pmu.h             |  16 +-
 5 files changed, 208 insertions(+), 252 deletions(-)

-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
