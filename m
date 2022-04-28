Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 294ED513156
	for <lists+kvmarm@lfdr.de>; Thu, 28 Apr 2022 12:34:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 482BE4B298;
	Thu, 28 Apr 2022 06:34:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y8d9TKAk8BoE; Thu, 28 Apr 2022 06:34:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 171FA4B290;
	Thu, 28 Apr 2022 06:34:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 306F24B275
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Apr 2022 06:34:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HJa7h2HradTB for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Apr 2022 06:34:17 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A7034B263
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Apr 2022 06:34:16 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E91B1474;
 Thu, 28 Apr 2022 03:34:16 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C5BD3F774;
 Thu, 28 Apr 2022 03:34:15 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 0/2] KVM/arm64: sys_reg_table_init() small improvements
Date: Thu, 28 Apr 2022 11:34:03 +0100
Message-Id: <20220428103405.70884-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.0
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

These are two small improvements to how KVM handles an out-of-order
sys_reg_desc table. These should only affect KVM developers, as the end
user should never see an error caused by an unsorted sys_reg_desc table.

Changes in v2:

* Tweaked how the error is detected and propagated in kvm_arch_init().
* Use %pS to print the table name and entry offset (Marc).
* Tweaked the error message to spell out that magic number refers to the
  offending entry.

Alexandru Elisei (2):
  KVM/arm64: Don't BUG_ON() if emulated register table is unsorted
  KVM/arm64: Print emulated register table name when it is unsorted

 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/arm.c              |  8 +++++--
 arch/arm64/kvm/sys_regs.c         | 35 ++++++++++++++++++-------------
 3 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.36.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
