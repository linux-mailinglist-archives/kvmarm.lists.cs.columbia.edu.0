Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5D284E92
	for <lists+kvmarm@lfdr.de>; Tue,  6 Oct 2020 17:04:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A87E54B98C;
	Tue,  6 Oct 2020 11:04:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2R0S539DZe17; Tue,  6 Oct 2020 11:04:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 75A2F4B987;
	Tue,  6 Oct 2020 11:04:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 22D104B949
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Oct 2020 11:04:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ofzzEBrNSjLU for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Oct 2020 11:04:20 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DE5A04B7BE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Oct 2020 11:04:20 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7F3113E;
 Tue,  6 Oct 2020 08:04:15 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.12.66])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69653F71F;
 Tue,  6 Oct 2020 08:04:13 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_spe: Use Inner Shareable DSB when draining the
 buffer
Date: Tue,  6 Oct 2020 16:05:20 +0100
Message-Id: <20201006150520.161985-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
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

From ARM DDI 0487F.b, page D9-2807:

"Although the Statistical Profiling Extension acts as another observer in
the system, for determining the Shareability domain of the DSB
instructions, the writes of sample records are treated as coming from the
PE that is being profiled."

Similarly, on page D9-2801:

"The memory type and attributes that are used for a write by the
Statistical Profiling Extension to the Profiling Buffer is taken from the
translation table entries for the virtual address being written to. That
is:
- The writes are treated as coming from an observer that is coherent with
  all observers in the Shareability domain that is defined by the
  translation tables."

All the PEs are in the Inner Shareable domain, use a DSB ISH to make sure
writes to the profiling buffer have completed.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Found by code inspection.

All the places where the buffer was drained were found by using the command
"grep -r psb_csync".

 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 2 +-
 drivers/perf/arm_spe_pmu.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 91a711aa8382..e05a08c5ad1f 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -43,7 +43,7 @@ static void __debug_save_spe(u64 *pmscr_el1)
 
 	/* Now drain all buffered data to memory */
 	psb_csync();
-	dsb(nsh);
+	dsb(ish);
 }
 
 static void __debug_restore_spe(u64 pmscr_el1)
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index cc00915ad6d1..402892caef34 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -525,7 +525,7 @@ static void arm_spe_pmu_disable_and_drain_local(void)
 
 	/* Drain any buffered data */
 	psb_csync();
-	dsb(nsh);
+	dsb(ish);
 
 	/* Disable the profiling buffer */
 	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
@@ -545,7 +545,7 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 	 * aborts have been resolved.
 	 */
 	psb_csync();
-	dsb(nsh);
+	dsb(ish);
 
 	/* Ensure hardware updates to PMBPTR_EL1 are visible */
 	isb();
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
