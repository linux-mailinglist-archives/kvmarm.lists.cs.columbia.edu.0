Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 969352035C0
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jun 2020 13:33:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F05A04B0E9;
	Mon, 22 Jun 2020 07:33:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z65wuoOB8taF; Mon, 22 Jun 2020 07:33:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 942854B0DC;
	Mon, 22 Jun 2020 07:33:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6AD644B0D7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 07:33:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dO4fFJBUtGhU for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jun 2020 07:33:36 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4995D4B087
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 07:33:36 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A201FB;
 Mon, 22 Jun 2020 04:33:35 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05573F71E;
 Mon, 22 Jun 2020 04:33:34 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] KVM: arm64: Remove the target table
Date: Mon, 22 Jun 2020 11:33:12 +0000
Message-Id: <20200622113317.20477-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>
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

Hi guys,

KVM's target_table indirection is a relic from 32bit where different
CPUs had different reset values for ACTLR. All 64bit CPUs have the
same behaviour here, but we support different targets, that all map
to the same behaviour.

This series removes the indirection and the fiddly handling of two
tables.

We still need to offer user-space the preferred target, and check
it selects a supported target, but we no longer do anything with
the information.

This series based on v5.8-rc1, and can be retrieved from:
git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git kvm-arm64/kill_target_table/v1


Thanks,

James Morse (5):
  KVM: arm64: Drop the target_table[] indirection
  KVM: arm64: Tolerate an empty target_table list
  KVM: arm64: Move ACTLR_EL1 emulation to the sys_reg_descs array
  KVM: arm64: Remove target_table from exit handlers
  KVM: arm64: Remove the target table

 arch/arm64/include/asm/kvm_coproc.h  |   8 --
 arch/arm64/kvm/Makefile              |   2 +-
 arch/arm64/kvm/sys_regs.c            | 177 +++++++++------------------
 arch/arm64/kvm/sys_regs_generic_v8.c |  96 ---------------
 4 files changed, 56 insertions(+), 227 deletions(-)
 delete mode 100644 arch/arm64/kvm/sys_regs_generic_v8.c

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
