Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B4A56428BA4
	for <lists+kvmarm@lfdr.de>; Mon, 11 Oct 2021 12:57:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21EA94B0B9;
	Mon, 11 Oct 2021 06:57:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0NTPbG9PpYq; Mon, 11 Oct 2021 06:57:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA468407F1;
	Mon, 11 Oct 2021 06:57:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C96014B093
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 06:57:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SRbFotm2tcb9 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 11 Oct 2021 06:57:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D7600407F1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 06:57:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24810ED1;
 Mon, 11 Oct 2021 03:57:14 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1F3D3F66F;
 Mon, 11 Oct 2021 03:57:12 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com,
 drjones@redhat.com
Subject: [PATCH v2 0/3] KVM: arm64: Minor improvements to RAZ register handling
Date: Mon, 11 Oct 2021 11:58:37 +0100
Message-Id: <20211011105840.155815-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
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

What sparked these small patches is the series that fixed the PMU reset
values and their visibility from userspace, more specifically the
discussion around the patch that removed the PMSWINC_EL0 shadow register
[1].

The patches are straightforward cleanups without any changes in
functionality.

Tested on a rockpro64, by running kvm-unit-tests under qemu.

Changes in v2:

* Added patch #3 ("KVM: arm64: Replace get_raz_id_reg() with get_raz_reg()"), as
  suggested by Drew.
* Rebased on top of v5.15-rc5.
* Gathered Reviewed-by, thanks!
* A few small commit message changes to patch #1.

[1] https://www.spinics.net/lists/kvm-arm/msg47976.html

Alexandru Elisei (3):
  KVM: arm64: Return early from read_id_reg() if register is RAZ
  KVM: arm64: Use get_raz_reg() for userspace reads of PMSWINC_EL0
  KVM: arm64: Replace get_raz_id_reg() with get_raz_reg()

 arch/arm64/kvm/sys_regs.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.33.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
