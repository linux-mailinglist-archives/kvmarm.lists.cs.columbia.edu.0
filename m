Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 644912CF42B
	for <lists+kvmarm@lfdr.de>; Fri,  4 Dec 2020 19:37:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F35634B126;
	Fri,  4 Dec 2020 13:37:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fd-VSd7VuCA7; Fri,  4 Dec 2020 13:37:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 400D34B18B;
	Fri,  4 Dec 2020 13:37:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AF104B193
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 13:37:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G6thYPrfyA7P for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Dec 2020 13:37:47 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9B7154B188
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 13:37:47 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6B3FE22AAB;
 Fri,  4 Dec 2020 18:37:46 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1klFxg-00G3Uh-30; Fri, 04 Dec 2020 18:37:44 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: arm64: Expose CSV3 to guests on running on
 Meltdown-safe HW
Date: Fri,  4 Dec 2020 18:37:07 +0000
Message-Id: <20201204183709.784533-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, will@kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 dbarzdil@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, David Brazdil <dbarzdil@google.com>,
 kernel-team@android.com
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

Will recently pointed out that when running on big-little systems that
are known not to be vulnerable to Metldown, guests are not presented
with the CSV3 property if the physical HW include a core that doesn't
have CSV3, despite being known to be safe (it is on the kpti_safe_list).

Since this is valuable information that can be cheaply given to the
guest, let's just do that. The scheme is the same as what we do for
CSV2, allowing userspace to change the default setting if this doesn't
advertise a safer setting than what the kernel thinks it is.

* From v1:
  - Fix the clearing of ID_AA64PFR0_EL1.CSV3 on update from userspace
  - Actually store the userspace value

Marc Zyngier (2):
  arm64: Make the Meltdown mitigation state available
  KVM: arm64: Advertise ID_AA64PFR0_EL1.CSV3=1 if the CPUs are
    Meltdown-safe

 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/spectre.h  |  2 ++
 arch/arm64/kernel/cpufeature.c    | 20 +++++++++++++++++---
 arch/arm64/kvm/arm.c              |  6 ++++--
 arch/arm64/kvm/sys_regs.c         | 16 +++++++++++++---
 5 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
