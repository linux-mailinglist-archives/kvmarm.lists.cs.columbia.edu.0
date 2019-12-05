Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AFD22114690
	for <lists+kvmarm@lfdr.de>; Thu,  5 Dec 2019 19:07:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EB344AEB5;
	Thu,  5 Dec 2019 13:07:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2H+4x33B7gf; Thu,  5 Dec 2019 13:07:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4029C4AEC1;
	Thu,  5 Dec 2019 13:07:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00D984AE9C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Dec 2019 13:07:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AfQGp41I3e7K for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Dec 2019 13:07:02 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DF0AB4AEC1
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Dec 2019 13:07:02 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96BFD11D4;
 Thu,  5 Dec 2019 10:07:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CAEC3F718;
 Thu,  5 Dec 2019 10:07:01 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] kvm/arm64: don't log IMP DEF sysreg traps
Date: Thu,  5 Dec 2019 18:06:52 +0000
Message-Id: <20191205180652.18671-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191205180652.18671-1-mark.rutland@arm.com>
References: <20191205180652.18671-1-mark.rutland@arm.com>
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

We don't intend to support IMPLEMENATION DEFINED system registers, but
have to trap them (and emulate them as UNDEFINED). These traps aren't
interesting to the system administrator or to the KVM developers, so
let's not bother logging when we do so.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/kvm/sys_regs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d128abd38656..61f019104841 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2233,6 +2233,12 @@ int kvm_handle_cp14_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 				NULL, 0);
 }
 
+static bool is_imp_def_sys_reg(struct sys_reg_params *params)
+{
+	// See ARM DDI 0487E.a, section D12.3.2
+	return params->Op0 == 3 && (params->CRn & 0b1011) == 0b1011;
+}
+
 static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params)
 {
@@ -2248,6 +2254,8 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 
 	if (likely(r)) {
 		perform_access(vcpu, params, r);
+	} else if (is_imp_def_sysreg(params)) {
+		kvm_inject_undefined(vcpu);
 	} else {
 		print_sys_reg_msg(params,
 				  "Unsupported guest sys_reg access at: %lx [%08lx]\n",
-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
