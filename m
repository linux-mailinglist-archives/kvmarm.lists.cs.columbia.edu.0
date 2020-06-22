Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 20A45203168
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jun 2020 10:07:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA5F24B0C2;
	Mon, 22 Jun 2020 04:07:04 -0400 (EDT)
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
	with ESMTP id 9XNgnQtgd3Hw; Mon, 22 Jun 2020 04:07:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 08D2E4B0A5;
	Mon, 22 Jun 2020 04:06:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 732E24B092
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 04:06:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aphQvN9zJQmD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jun 2020 04:06:54 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5FE284B0A3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 04:06:54 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D60E207C3;
 Mon, 22 Jun 2020 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592813213;
 bh=Ii14i7vMt5G0blEY8jOOtv2hk5ArajPnLztxOTdDv4o=;
 h=From:To:Cc:Subject:Date:From;
 b=tofBpQcybBeOKxwi8eoUa+ScRMUGCbQlt4sgu/nO4mJqbCzrEuGE1DgnIgIYns6VG
 Y+7ifpP6U5+arBiWpI32ti/Y2LlZa6Ve+oiwtHz2lO/zCvssW41I0leGdPqyVobmom
 2SP3RE7P4Ucv/BmtBeQRSRMIN7daLpqlPS2cOpGQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jnHTf-005FG8-Br; Mon, 22 Jun 2020 09:06:51 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 0/5] KVM/arm64: Enable PtrAuth on non-VHE KVM
Date: Mon, 22 Jun 2020 09:06:38 +0100
Message-Id: <20200622080643.171651-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, mark.rutland@arm.com,
 ascull@google.com, Dave.Martin@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Dave Martin <Dave.Martin@arm.com>
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

Not having PtrAuth on non-VHE KVM (for whatever reason VHE is not
enabled on a v8.3 system) has always looked like an oddity. This
trivial series remedies it, and allows a non-VHE KVM to offer PtrAuth
to its guests.

In the tradition of not having separate security between host-EL1 and
EL2, EL2 reuses the keys set up by host-EL1. It is likely that, should
we switch to a mode where EL2 is more distrusting of EL1, we'd have
private keys there.

The last two patches are respectively an optimization when
save/restoring the PtrAuth context, and a cleanup of the alternatives
used by that same save/restore code.

* From v1 [1]:
  - Move the hand-crafted literal load to using a mov_q macro (Andrew, Mark)
  - Added a cleanup of the alternatives on the save/restore path (Mark)

[1] https://lore.kernel.org/kvm/20200615081954.6233-1-maz@kernel.org/

Marc Zyngier (5):
  KVM: arm64: Enable Address Authentication at EL2 if available
  KVM: arm64: Allow ARM64_PTR_AUTH when ARM64_VHE=n
  KVM: arm64: Allow PtrAuth to be enabled from userspace on non-VHE
    systems
  KVM: arm64: Check HCR_EL2 instead of shadow copy to swap PtrAuth
    registers
  KVM: arm64: Simplify PtrAuth alternative patching

 arch/arm64/Kconfig                   |  4 +---
 arch/arm64/include/asm/kvm_ptrauth.h | 30 ++++++++++------------------
 arch/arm64/kvm/hyp-init.S            |  5 +++++
 arch/arm64/kvm/reset.c               | 21 ++++++++++---------
 4 files changed, 27 insertions(+), 33 deletions(-)

-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
