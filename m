Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB4051E8134
	for <lists+kvmarm@lfdr.de>; Fri, 29 May 2020 17:07:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3808E4B26C;
	Fri, 29 May 2020 11:07:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7ko7ucuUwax; Fri, 29 May 2020 11:07:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 249F94B266;
	Fri, 29 May 2020 11:07:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00D7A4B25B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 11:07:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8yD2tKnl6tDl for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 May 2020 11:07:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D03D04B16F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 11:07:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B5CA1045;
 Fri, 29 May 2020 08:07:04 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89BE03F718;
 Fri, 29 May 2020 08:07:03 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] KVM: arm64: aarch32 ACTLR accesses
Date: Fri, 29 May 2020 15:06:53 +0000
Message-Id: <20200529150656.7339-1-james.morse@arm.com>
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

Hello!

Changes since v1:
 * Patches 2 & 3 have been swapped.
 * Copy access_vm_reg() to swizzle 32bit offets back to 64bit
 * Peek at the encoding to tell ACTLR and ACTLR2 apart...

I didn't pick up the suggestion to remove the ACTLR_EL1 storage from
sys_regs[] as this turns out to break migration. Fixing it would require
a get_user() helper, which has a different prototype to access_actlr(),
would be noisier overall.

~

Patch 1 fixes an issue where the 32bit and 64bit indexes into copro[]
and sys_regs[] are muddled.

Patch 2 adds support for aarch32 accessing the top 32bits of ACTLR_EL1
via ACTLR2. Support for this register is advertised in ID_MMFR4.AC2, which
doesn't get removed by cpufeature. The register is mandatory from v8.2, but
imp-def before then.

Patch 3 stops the sys_regs[] value we use for emulation being save/restored.

I think Patch 1 is stable material, I'm not sure about 2&3.


Thanks,

James Morse (3):
  KVM: arm64: Stop writing aarch32's CSSELR into ACTLR
  KVM: arm64: Add emulation for 32bit guests accessing ACTLR2
  KVM: arm64: Stop save/restoring ACTLR_EL1

 arch/arm64/kvm/hyp/sysreg-sr.c       |  2 --
 arch/arm64/kvm/sys_regs.c            | 12 ++++++++----
 arch/arm64/kvm/sys_regs_generic_v8.c | 10 ++++++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
