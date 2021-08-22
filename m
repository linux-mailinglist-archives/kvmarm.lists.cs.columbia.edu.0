Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 302413F4046
	for <lists+kvmarm@lfdr.de>; Sun, 22 Aug 2021 17:25:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCE3E4B1EF;
	Sun, 22 Aug 2021 11:25:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zFQsshFgenAr; Sun, 22 Aug 2021 11:25:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 285074B209;
	Sun, 22 Aug 2021 11:25:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F8B84B1B6
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 11:25:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hirAhkr4rlq6 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 22 Aug 2021 11:25:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7C5294B166
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 11:25:36 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 77BF86126A;
 Sun, 22 Aug 2021 15:25:35 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mHpLp-006VTo-GG; Sun, 22 Aug 2021 16:25:33 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 0/3] kvmtool: Limit IPA space to what is actually required
Date: Sun, 22 Aug 2021 16:25:23 +0100
Message-Id: <20210822152526.1291918-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, andre.przywara@arm.com,
 alexandru.elisei@arm.com, will@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andre Przywara <andre.przywara@arm.com>, kernel-team@android.com,
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

KVM hacking on the Apple M1 SoC has shown that kvmtool (and other
VMMs) make pretty poor use of the IPA space parameter (read: do not
use it and just pass 0). This results in a guest that cannot boot
(recent kernels will just send the VMM packing), and in general means
we don't benefit from smaller page tables at stage-2.

This series does three things:
- It switches kvmtool away from the default 40bit, allowing large VMs
  to be created (I have booted a 4TB VM)
- It reduces the requested IPA space to be as small as possible
- It tells the user why the VM cannot boot when the IPA space required
  exceeds that of the HW

With these changes, kvmtool is able to spawn a VM on IPA-challenged
systems such the Apple M1.

* From v1:
  - Use KVM_VM_TYPE_ARM_IPA_SIZE()
  - Rebased on a recent HEAD

Marc Zyngier (3):
  kvmtool: Abstract KVM_VM_TYPE into a weak function
  kvmtool: arm64: Use the maximum supported IPA size when creating the
    VM
  kvmtool: arm64: Configure VM with the minimal required IPA space

 arm/aarch64/include/kvm/kvm-arch.h | 19 ++++++++++++++---
 arm/aarch64/kvm.c                  | 33 ++++++++++++++++++++++++++++++
 include/kvm/kvm.h                  |  1 +
 kvm.c                              |  7 ++++++-
 4 files changed, 56 insertions(+), 4 deletions(-)

-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
