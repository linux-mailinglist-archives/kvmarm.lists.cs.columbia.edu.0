Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6310D2A4C75
	for <lists+kvmarm@lfdr.de>; Tue,  3 Nov 2020 18:14:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D88004B463;
	Tue,  3 Nov 2020 12:14:58 -0500 (EST)
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
	with ESMTP id LuacT3su8GK5; Tue,  3 Nov 2020 12:14:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE4904B41C;
	Tue,  3 Nov 2020 12:14:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 92AFE4B414
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 12:14:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ytTH8Pt+Is2L for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Nov 2020 12:14:53 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BA6EB4B2B9
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 12:14:53 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4FA8C20E65;
 Tue,  3 Nov 2020 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604423692;
 bh=6+qWLb2RuYMP6Lh4W5V8A6bsv6YMBX9ny8ju+VAAdW0=;
 h=From:To:Cc:Subject:Date:From;
 b=c6PdVPRRjCGBWTLYuOFAf1qeWgIZ2ltAw/wGAgbd4g0BbkiOImKrkusWHZw8fFk7a
 4LJ9vA+G/dU29gHYkLy0oL/KLttVC9huKkE5mBtOFfpajFY92HGKCnvbRZm2kipzjq
 vFzRxMgMlwEQJA3PWPB22JZBPxaiACJFr1gFv7AA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kZztS-007CyW-4V; Tue, 03 Nov 2020 17:14:50 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] KVM: arm64: Another set of CSV2-related fixes
Date: Tue,  3 Nov 2020 17:14:42 +0000
Message-Id: <20201103171445.271195-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, liangpeng10@huawei.com, will@kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com
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

This small series addresses a couple of Spectre-v2 related issues:

- Fix a live migration regression introduced with the setting of CSV2
  on systems that are not affected by Spectre-v2, but that don't
  directly expose it in ID_AA64PFR0_EL1

- Inject an UNDEF exception if the guest tries to access any of
  SCXTNUM_ELx, as we don't advertise it to guests.

Patches on top of 5.10-rc2.

Marc Zyngier (3):
  KVM: arm64: Allow setting of ID_AA64PFR0_EL1.CSV2 from userspace
  KVM: arm64: Rename access_amu() to undef_access()
  KVM: arm64: Handle SCXTNUM_ELx traps

 arch/arm64/include/asm/kvm_host.h |  2 +
 arch/arm64/include/asm/sysreg.h   |  4 ++
 arch/arm64/kvm/arm.c              | 16 +++++++
 arch/arm64/kvm/sys_regs.c         | 70 +++++++++++++++++++++++--------
 4 files changed, 74 insertions(+), 18 deletions(-)

-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
