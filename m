Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 990A4DD7C9
	for <lists+kvmarm@lfdr.de>; Sat, 19 Oct 2019 11:55:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F1764AA78;
	Sat, 19 Oct 2019 05:55:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pt9UznVPYBCY; Sat, 19 Oct 2019 05:55:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 04B654AA76;
	Sat, 19 Oct 2019 05:55:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 54AA64A896
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 05:55:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cqRnkvM7RPf for <kvmarm@lists.cs.columbia.edu>;
 Sat, 19 Oct 2019 05:55:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 687734A948
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 05:55:36 -0400 (EDT)
Received: from big-swifty.lan (78.163-31-62.static.virginmediabusiness.co.uk
 [62.31.163.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 81BBB222CD;
 Sat, 19 Oct 2019 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571478935;
 bh=cBYrKAV4O8BFISadDqGvhB8cGTVx7az9VNh8naTENqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lB6du6o6np7KyZJ0ZdiVBJc9kjZJUsnjLjB4gnszQ5jtgdvg4uPUNibAa435nV8C6
 KDnpGhbrgtbAEJK+OctIrIqOFV4ZYqWzVEsy/Ajq711lB2n0rwkpZXYhVwP80gz3F+
 XzLTPv/DtGRO6bZVOEfDeofgYow+VVY8bnoDAHjA=
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: KVM: Disable EL1 PTW when invalidating S2 TLBs
Date: Sat, 19 Oct 2019 10:55:19 +0100
Message-Id: <20191019095521.31722-4-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191019095521.31722-1-maz@kernel.org>
References: <20191019095521.31722-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

When erratum 1319367 is being worked around, special care must
be taken not to allow the page table walker to populate TLBs
while we have the stage-2 translation enabled (which would otherwise
result in a bizare mix of the host S1 and the guest S2).

We enforce this by setting TCR_EL1.EPD{0,1} before restoring the S2
configuration, and clear the same bits after having disabled S2.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/tlb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index eb0efc5557f3..c2bc17ca6430 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -63,6 +63,22 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
 						  struct tlb_inv_context *cxt)
 {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+		u64 val;
+
+		/*
+		 * For CPUs that are affected by ARM 1319367, we need to
+		 * avoid a host Stage-1 walk while we have the guest's
+		 * VMID set in the VTTBR in order to invalidate TLBs.
+		 * We're guaranteed that the S1 MMU is enabled, so we can
+		 * simply set the EPD bits to avoid any further TLB fill.
+		 */
+		val = cxt->tcr = read_sysreg_el1(SYS_TCR);
+		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
+		write_sysreg_el1(val, SYS_TCR);
+		isb();
+	}
+
 	__load_guest_stage2(kvm);
 	isb();
 }
@@ -100,6 +116,13 @@ static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
 						 struct tlb_inv_context *cxt)
 {
 	write_sysreg(0, vttbr_el2);
+
+	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+		/* Ensure write of the host VMID */
+		isb();
+		/* Restore the host's TCR_EL1 */
+		write_sysreg_el1(cxt->tcr, SYS_TCR);
+	}
 }
 
 static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
