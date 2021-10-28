Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 874B643DFDA
	for <lists+kvmarm@lfdr.de>; Thu, 28 Oct 2021 13:16:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 35A584B1CB;
	Thu, 28 Oct 2021 07:16:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0LRjgmYruMxC; Thu, 28 Oct 2021 07:16:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4029D4B1E0;
	Thu, 28 Oct 2021 07:16:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 809E44B1AB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Oct 2021 07:16:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gAgoc4iiHznj for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Oct 2021 07:16:49 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4EA524B1BA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Oct 2021 07:16:49 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1089E6112E;
 Thu, 28 Oct 2021 11:16:47 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mg3On-002BtD-6b; Thu, 28 Oct 2021 12:16:45 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] arm64/fpsimd: Document the use of TIF_FOREIGN_FPSTATE
 by KVM
Date: Thu, 28 Oct 2021 12:16:40 +0100
Message-Id: <20211028111640.3663631-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211028111640.3663631-1-maz@kernel.org>
References: <20211028111640.3663631-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, qperret@google.com,
 will@kernel.org, broonie@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>, broonie@kernel.org
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

The bit of documentation that talks about TIF_FOREIGN_FPSTATE
does not mention the ungodly tricks that KVM plays with this flag.

Try and document this for the posterity.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ff4962750b3d..1fbd6ba7dbac 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -78,7 +78,11 @@
  * indicate whether or not the userland FPSIMD state of the current task is
  * present in the registers. The flag is set unless the FPSIMD registers of this
  * CPU currently contain the most recent userland FPSIMD state of the current
- * task.
+ * task. If the task is behaving as a VMM, then this is will be managed by
+ * KVM which will clear it to indicate that the vcpu FPSIMD state is currently
+ * loaded on the CPU, allowing the state to be saved if a FPSIMD-aware
+ * softirq kicks in. Upon vcpu_put(), KVM will save the vcpu FP state and
+ * flag the register state as invalid.
  *
  * In order to allow softirq handlers to use FPSIMD, kernel_neon_begin() may
  * save the task's FPSIMD context back to task_struct from softirq context.
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
