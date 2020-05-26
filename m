Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 316C91E26B1
	for <lists+kvmarm@lfdr.de>; Tue, 26 May 2020 18:18:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B99AF4B108;
	Tue, 26 May 2020 12:18:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xeANhRyVn7Dq; Tue, 26 May 2020 12:18:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CA384B125;
	Tue, 26 May 2020 12:18:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C5B594B111
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 12:18:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g5EHzuMyMGSK for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 May 2020 12:18:54 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 83E894B108
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 12:18:54 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0540530E;
 Tue, 26 May 2020 09:18:54 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18D0B3F52E;
 Tue, 26 May 2020 09:18:52 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] KVM: arm64: aarch32 ACTLR accesses
Date: Tue, 26 May 2020 16:18:31 +0000
Message-Id: <20200526161834.29165-1-james.morse@arm.com>
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

Patch 1 fixes an issue where the 32bit and 64bit indexes into copro[]
and sys_regs[] are muddled.

Patch 3 adds support for aarch32 accessing the top 32bits of ACTLR_EL1
via ACTLR2. Support for this register is advertised in ID_MMFR4.AC2, which
doesn't get removed by cpufeature. The register is mandatory from v8.2, but
imp-def before then.

Patch 2 stops the sys_regs[] value we use for emulation being save/restored.
This simplifies patch 3 as the aarch32 helper can rely on the in-memory copy.

I think Patch 1 is stable material, I'm not sure about 2&3.


Bonus cans of worms!:

1. How does this copro[] thing work with a big-endian host?
The cp15_regs emulation look fine as nothing uses vcpu_cp15() to read the
register, but wouldn't prepare_fault32() read the wrong end of the register
when using vcpu_cp15()?

2. How does the 32bit fault injection code work with VHE?
vcpu_cp15() modifies the in-memory copy, surely a vcpu_put() will clobber
everything it did, or fail to restore it when entering the guest.


Thanks,

James Morse (3):
  KVM: arm64: Stop writing aarch32's CSSELR into ACTLR
  KVM: arm64: Stop save/restoring ACTLR_EL1
  KVM: arm64: Add emulation for 32bit guests accessing ACTLR2

 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/kvm/hyp/sysreg-sr.c       |  2 --
 arch/arm64/kvm/sys_regs.c            |  8 +++-----
 arch/arm64/kvm/sys_regs_generic_v8.c | 16 +++++++++++++++-
 4 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
