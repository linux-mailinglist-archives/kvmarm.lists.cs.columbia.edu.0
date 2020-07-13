Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1762B21D34F
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jul 2020 12:01:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A42EB4B318;
	Mon, 13 Jul 2020 06:01:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3ByhifFMbsn; Mon, 13 Jul 2020 06:01:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD5124B324;
	Mon, 13 Jul 2020 06:01:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 82DB24B318
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jul 2020 06:01:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qqkyZEiYvgmM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jul 2020 06:01:20 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B9624B275
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jul 2020 06:01:20 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D231FB;
 Mon, 13 Jul 2020 03:01:19 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D94793F7D8;
 Mon, 13 Jul 2020 03:01:17 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] MTE support for KVM guest
Date: Mon, 13 Jul 2020 11:01:00 +0100
Message-Id: <20200713100102.53664-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

These patches add support to KVM to enable MTE within a guest. They are
based on Catalin's v6 MTE user-space support series[1]. Changes since
the previous RFC posting[2]:

* Correctly read/write TFSR_EL1 using {read,write}_sysreg_el1()
* Set SCTLR_EL2.ITFSB bit for non-VHE
* Minor updates to deal with rebasing

[1] https://lore.kernel.org/r/20200703153718.16973-1-catalin.marinas@arm.com
[2] https://lore.kernel.org/r/20200617123844.29960-1-steven.price@arm.com

Steven Price (2):
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Introduce MTE VCPU feature

 arch/arm64/include/asm/kvm_emulate.h |  3 +++
 arch/arm64/include/asm/kvm_host.h    |  9 ++++++++-
 arch/arm64/include/asm/sysreg.h      |  3 ++-
 arch/arm64/include/uapi/asm/kvm.h    |  1 +
 arch/arm64/kvm/hyp/sysreg-sr.c       | 14 ++++++++++++++
 arch/arm64/kvm/mmu.c                 | 15 +++++++++++++++
 arch/arm64/kvm/reset.c               |  8 ++++++++
 arch/arm64/kvm/sys_regs.c            |  8 ++++++++
 8 files changed, 59 insertions(+), 2 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
