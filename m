Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9026A35B
	for <lists+kvmarm@lfdr.de>; Tue, 15 Sep 2020 12:42:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E17F4B329;
	Tue, 15 Sep 2020 06:42:46 -0400 (EDT)
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
	with ESMTP id D+u02gNKu5t3; Tue, 15 Sep 2020 06:42:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20C394B327;
	Tue, 15 Sep 2020 06:42:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 987DB4B30B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Sep 2020 06:42:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qeXvJMmRKjxz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 15 Sep 2020 06:42:42 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 74E154B302
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Sep 2020 06:42:42 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5163720735;
 Tue, 15 Sep 2020 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600166561;
 bh=+f+XJhOhIVIVtwBYBolA4BBiPSB/0HpuyUUu4Y/SScw=;
 h=From:To:Cc:Subject:Date:From;
 b=OhQNwqQjsQqHgf+XtrZADhkQ8kIaELoQHZIkKRxF/yTjNoFhYellzfFrT7KdU/cVH
 g3SV4OLUKvTnoR9MRA3SymLaLC1wz4qhd5QNkf5jSJZ6ABi2rnhXEazzR0rFMeBSqi
 XegQfYfquryYLFgl1cEq67QW7a/CQ1R66jKqwpeA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kI8Q3-00ByDU-Ci; Tue, 15 Sep 2020 11:42:39 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] KVM: arm64: Fix handling of S1PTW
Date: Tue, 15 Sep 2020 11:42:16 +0100
Message-Id: <20200915104218.1284701-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com, will@kernel.org
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

I recently managed to trigger an interesting failure mode, where a
guest would be stuck on an instruction abort due to a permission
fault. Interestingly enough, this IABT had S1PTW set in the ESR,
indicating that it was trying to *write* to the PT. We fix it by
adding the execute permission (it's an IABT, after all...), and going
nowhere fast.

Note that it can only happen on a system that can perform automatic
updates of the page table flags.

This small series fixes the issue by revamping the S1PTW handling in
the context of execution faults. The first patch fixes the bug, and is
definitely a stable candidate. The second patch is merely a cleanup,
which can wait.

Tested on an A55-based board.

* From v1:
  - Rename kvm_vcpu_dabt_iss1tw() to kvm_vcpu_abt_iss1tw()
  - Don't overload kvm_vcpu_trap_is_iabt()
  - Introduce kvm_vcpu_trap_is_exec_fault()

Marc Zyngier (2):
  KVM: arm64: Assume write fault on S1PTW permission fault on
    instruction fetch
  KVM: arm64: Remove S1PTW check from kvm_vcpu_dabt_iswrite()

 arch/arm64/include/asm/kvm_emulate.h    | 14 +++++++++++---
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/mmu.c                    |  4 ++--
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
