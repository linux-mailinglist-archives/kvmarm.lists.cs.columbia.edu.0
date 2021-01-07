Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 26E312ECE9C
	for <lists+kvmarm@lfdr.de>; Thu,  7 Jan 2021 12:21:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FC1B4B3BC;
	Thu,  7 Jan 2021 06:21:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id whx26fe3hmdi; Thu,  7 Jan 2021 06:21:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 384734B3D2;
	Thu,  7 Jan 2021 06:21:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 431174B3BD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Jan 2021 06:21:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EQGkaqTE3GZ5 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 Jan 2021 06:21:19 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7C5D84B3BC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Jan 2021 06:21:19 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7FFEE23125;
 Thu,  7 Jan 2021 11:21:18 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kxTLw-005p1o-Nt; Thu, 07 Jan 2021 11:21:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 01/18] KVM: arm64: Don't access PMCR_EL0 when no PMU is
 available
Date: Thu,  7 Jan 2021 11:20:44 +0000
Message-Id: <20210107112101.2297944-2-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107112101.2297944-1-maz@kernel.org>
References: <20210107112101.2297944-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 catalin.marinas@arm.com, dbrazdil@google.com, eric.auger@redhat.com,
 mark.rutland@arm.com, natechancellor@gmail.com, qcai@redhat.com,
 shannon.zhao@linux.alibaba.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org, Qian Cai <qcai@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Shannon Zhao <shannon.zhao@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <natechancellor@gmail.com>, kvmarm@lists.cs.columbia.edu
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

We reset the guest's view of PMCR_EL0 unconditionally, based on
the host's view of this register. It is however legal for an
implementation not to provide any PMU, resulting in an UNDEF.

The obvious fix is to skip the reset of this shadow register
when no PMU is available, sidestepping the issue entirely.
If no PMU is available, the guest is not able to request
a virtual PMU anyway, so not doing nothing is the right thing
to do!

It is unlikely that this bug can hit any HW implementation
though, as they all provide a PMU. It has been found using nested
virt with the host KVM not implementing the PMU itself.

Fixes: ab9468340d2bc ("arm64: KVM: Add access handler for PMCR register")
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201210083059.1277162-1-maz@kernel.org
---
 arch/arm64/kvm/sys_regs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3313dedfa505..d46e7f706cb0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -594,6 +594,10 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	u64 pmcr, val;
 
+	/* No PMU available, PMCR_EL0 may UNDEF... */
+	if (!kvm_arm_support_pmu_v3())
+		return;
+
 	pmcr = read_sysreg(pmcr_el0);
 	/*
 	 * Writable bits of PMCR_EL0 (ARMV8_PMU_PMCR_MASK) are reset to UNKNOWN
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
