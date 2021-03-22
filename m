Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9733448A5
	for <lists+kvmarm@lfdr.de>; Mon, 22 Mar 2021 16:06:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC3864B385;
	Mon, 22 Mar 2021 11:06:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fEvKqXpcGZ7M; Mon, 22 Mar 2021 11:06:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C88FA4B39A;
	Mon, 22 Mar 2021 11:06:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 70B174B2A1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 11:06:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6rGrs6hGWbJ for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Mar 2021 11:06:20 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 278C74B232
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 11:06:20 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97F91042;
 Mon, 22 Mar 2021 08:06:19 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73293F719;
 Mon, 22 Mar 2021 08:06:18 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH v2 0/6] Misc assembly fixes and cleanups
Date: Mon, 22 Mar 2021 15:06:35 +0000
Message-Id: <20210322150641.58878-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Cc: andre.przywara@arm.com
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

This series is mostly fixes and cleanups for things I found when playing
with EFI support. Most of them I hope are fairly self-explanatory.

What is clearly aimed at running on baremetal is patch #2 ("arm/arm64:
Remove dcache_line_size global variable"), which is needed because the
startup environment is different for EFI apps and we're going to need to do
cache maintenance before setup() is run.

Patch #4 ("lib: arm64: Consolidate register definitions to sysreg.h") is
there to make importing register definitions and other header files from
Linux (like el2_setup.h) easier by switching to the same layout. And arm
is already using sysreg.h for SCTLR fields.

Changes in v2:
* Gathered Reviewed-by tags, thank you!
* For patch #2 ("arm/arm64: Remove dcache_line_size global variable"), I've
  modified the commit message to mention the change in parameters for
  dcache_by_line_op, I've added the proper header guards to
  lib/arm/asm/assembler.h and I've changed raw_dcache_line_size to use ubfx
  instead of ubfm.

Alexandru Elisei (6):
  arm64: Remove unnecessary ISB when writing to SPSel
  arm/arm64: Remove dcache_line_size global variable
  arm/arm64: Remove unnecessary ISB when doing dcache maintenance
  lib: arm64: Consolidate register definitions to sysreg.h
  arm64: Configure SCTLR_EL1 at boot
  arm64: Disable TTBR1_EL1 translation table walks

 lib/arm/asm/assembler.h       | 53 ++++++++++++++++++++++++++++++++++
 lib/arm/asm/processor.h       |  7 -----
 lib/arm64/asm/arch_gicv3.h    |  6 ----
 lib/arm64/asm/assembler.h     | 54 +++++++++++++++++++++++++++++++++++
 lib/arm64/asm/pgtable-hwdef.h |  1 +
 lib/arm64/asm/processor.h     | 17 -----------
 lib/arm64/asm/sysreg.h        | 24 ++++++++++++++++
 lib/arm/setup.c               |  7 -----
 arm/cstart.S                  | 19 ++----------
 arm/cstart64.S                | 28 +++++++-----------
 10 files changed, 145 insertions(+), 71 deletions(-)
 create mode 100644 lib/arm/asm/assembler.h
 create mode 100644 lib/arm64/asm/assembler.h

-- 
2.31.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
