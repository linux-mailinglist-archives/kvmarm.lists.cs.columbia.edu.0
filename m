Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1BAC11468D
	for <lists+kvmarm@lfdr.de>; Thu,  5 Dec 2019 19:07:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E10E4AEC5;
	Thu,  5 Dec 2019 13:07:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBlgqq8-y3Ag; Thu,  5 Dec 2019 13:07:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 065104AEB5;
	Thu,  5 Dec 2019 13:07:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A898C4AE9C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Dec 2019 13:07:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQowhr1BP+Eo for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Dec 2019 13:06:59 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80F644A7F1
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Dec 2019 13:06:59 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09A7131B;
 Thu,  5 Dec 2019 10:06:59 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8A193F718;
 Thu,  5 Dec 2019 10:06:57 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] kvm/arm64: unimplemented sysreg improvements
Date: Thu,  5 Dec 2019 18:06:50 +0000
Message-Id: <20191205180652.18671-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

While testing some other patches, I realised that KVM's logging of
trapped sysreg accesses can log inconsistent information, and this is
arguably unnecessary for IMPLEMENTATION DEFINED system registers.

This patches fix that up, ensureing that logged information is
consistent, and avoiding logging for IMPLEMENTATION DEFINED registers.

Mark.

Mark Rutland (2):
  kvm/arm64: sanely ratelimit sysreg messages
  kvm/arm64: don't log IMP DEF sysreg traps

 arch/arm64/kvm/sys_regs.c | 20 ++++++++++++++------
 arch/arm64/kvm/sys_regs.h | 17 +++++++++++++++--
 2 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
