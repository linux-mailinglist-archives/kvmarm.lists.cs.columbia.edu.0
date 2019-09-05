Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 13384AA9CC
	for <lists+kvmarm@lfdr.de>; Thu,  5 Sep 2019 19:15:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FAEE4A529;
	Thu,  5 Sep 2019 13:15:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6U2R0IqaLN8; Thu,  5 Sep 2019 13:15:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 475FC4A536;
	Thu,  5 Sep 2019 13:15:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF2684A4F6
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Sep 2019 13:15:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bVBtpz+xIOC0 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Sep 2019 13:15:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 17F584A479
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Sep 2019 13:15:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80B43337;
 Thu,  5 Sep 2019 10:15:10 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986843F718;
 Thu,  5 Sep 2019 10:15:09 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: [PATCH kvm-unit-tests] arm: prevent compiler from using unaligned
 accesses
Date: Thu,  5 Sep 2019 18:15:02 +0100
Message-Id: <20190905171502.215183-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

The ARM architecture requires all accesses to device memory to be
naturally aligned[1][2]. Normal memory does not have this strict
requirement, and in fact many systems do ignore unaligned accesses
(by the means of clearing the A bit in SCTLR and accessing normal
memory). So the default behaviour of GCC assumes that unaligned accesses
are fine, at least if happening on the stack.

Now kvm-unit-tests runs some C code with the MMU off, which degrades the
whole system memory to device memory. Now every unaligned access will
fault, regardless of the A bit.
In fact there is at least one place in lib/printf.c where GCC merges
two consecutive char* accesses into one "strh" instruction, writing to
a potentially unaligned address.
This can be reproduced by configuring kvm-unit-tests for kvmtool, but
running it on QEMU, which triggers an early printf that exercises this
particular code path.

Add the -mstrict-align compiler option to the arm64 CFLAGS to fix this
problem. Also add the respective -mno-unaligned-access flag for arm.

Thanks to Alexandru for helping debugging this.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

[1] ARMv8 ARM DDI 0487E.a, B2.5.2
[2] ARMv7 ARM DDI 0406C.d, A3.2.1
---
 arm/Makefile.arm   | 1 +
 arm/Makefile.arm64 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arm/Makefile.arm b/arm/Makefile.arm
index a625267..43b4be1 100644
--- a/arm/Makefile.arm
+++ b/arm/Makefile.arm
@@ -12,6 +12,7 @@ KEEP_FRAME_POINTER := y
 
 CFLAGS += $(machine)
 CFLAGS += -mcpu=$(PROCESSOR)
+CFLAGS += -mno-unaligned-access
 
 arch_LDFLAGS = -Ttext=40010000
 
diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index 02c24e8..35de5ea 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -7,6 +7,7 @@ bits = 64
 ldarch = elf64-littleaarch64
 
 arch_LDFLAGS = -pie -n
+CFLAGS += -mstrict-align
 
 define arch_elf_check =
 	$(if $(shell ! $(OBJDUMP) -R $(1) >&/dev/null && echo "nok"),
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
