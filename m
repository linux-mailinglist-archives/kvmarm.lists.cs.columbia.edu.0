Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DEE621F534A
	for <lists+kvmarm@lfdr.de>; Wed, 10 Jun 2020 13:34:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A4094B276;
	Wed, 10 Jun 2020 07:34:20 -0400 (EDT)
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
	with ESMTP id LIb4TwBZyS6Q; Wed, 10 Jun 2020 07:34:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3A104B149;
	Wed, 10 Jun 2020 07:34:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E817A4B17B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 07:34:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uAOjhsDkvxPF for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Jun 2020 07:34:16 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C769C4B149
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 07:34:16 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B0BCA20734;
 Wed, 10 Jun 2020 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591788855;
 bh=9N6nffWe0REroh98cZzvRnmfrffUIT7lJJ7yMkeQ6uI=;
 h=From:To:Cc:Subject:Date:From;
 b=Ksvks8e29KLnHD9le872+c+3SUvatPHr3scAMz190kRFvyApeml9YWHh8o+yITFcD
 Mj8bsnfTJ1Vtcu0R5MHp396KaIIEEQ11lRB+vXVJj0rIdF/qd77dIO2NIfDLl5PFao
 YoBbsMa+nMUOr7bfYEkscw/tyWNN//u47xzi+XXM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jiyzm-001lrp-8M; Wed, 10 Jun 2020 12:34:14 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] kvm: arm64: Pointer Authentication handling fixes
Date: Wed, 10 Jun 2020 12:34:02 +0100
Message-Id: <20200610113406.1493170-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com, ascull@google.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
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

I recently discovered that the Pointer Authentication (PtrAuth)
handling code in KVM is busted, and has been for a while. The main
issue is that the we save the host's keys from a preemptible
context. Things will go wrong at some point.

In order to address this, the first patch move the saving of the
host's keys to vcpu_load(). It is done eagerly, which is a bore, but
is at least safe. This is definitely stable material.

The following patch is adding an optimisatioe: we handle key saving
and HCR massaging as a fixup, much like the FPSIMD code.

Subsequent patch cleans up our HYP per-CPU accessor and make it sparse
friendly, asthe last patch makes heavy use of it by killing the
per-vcpu backpointer to the physical CPU context, avoiding the first
bug altogether.

This has been very lightly tested on a model. Unless someone shouts, I
plan to send this as part of the pending set of fixes.

* From v1:
  - Dropped the misbehaving guest handling patch
  - Added the two cleanup patches to the series (previously posted separately)

Marc Zyngier (4):
  KVM: arm64: Save the host's PtrAuth keys in non-preemptible context
  KVM: arm64: Handle PtrAuth traps early
  KVM: arm64: Stop sparse from moaning at __hyp_this_cpu_ptr
  KVM: arm64: Remove host_cpu_context member from vcpu structure

 arch/arm64/include/asm/kvm_asm.h     | 13 ++++--
 arch/arm64/include/asm/kvm_emulate.h |  6 ---
 arch/arm64/include/asm/kvm_host.h    |  3 --
 arch/arm64/kvm/arm.c                 |  6 +--
 arch/arm64/kvm/handle_exit.c         | 32 ++------------
 arch/arm64/kvm/hyp/debug-sr.c        |  4 +-
 arch/arm64/kvm/hyp/switch.c          | 65 +++++++++++++++++++++++++++-
 arch/arm64/kvm/hyp/sysreg-sr.c       |  6 ++-
 arch/arm64/kvm/pmu.c                 |  8 +---
 arch/arm64/kvm/sys_regs.c            | 13 +++---
 10 files changed, 91 insertions(+), 65 deletions(-)

-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
