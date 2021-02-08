Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86796312E5D
	for <lists+kvmarm@lfdr.de>; Mon,  8 Feb 2021 11:04:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AAE44B67B;
	Mon,  8 Feb 2021 05:04:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XVlz92Psdt-R; Mon,  8 Feb 2021 05:04:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D11DC4B63D;
	Mon,  8 Feb 2021 05:04:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 920D74B552
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 05:04:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M8bH9gxj+v7A for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Feb 2021 05:04:35 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 233F54B3A3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 05:04:33 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2422364E99;
 Mon,  8 Feb 2021 10:04:32 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l93J9-00Ck14-CY; Mon, 08 Feb 2021 09:58:15 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 21/23] arm64: Defer enabling pointer authentication on boot
 core
Date: Mon,  8 Feb 2021 09:57:30 +0000
Message-Id: <20210208095732.3267263-22-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208095732.3267263-1-maz@kernel.org>
References: <20210208095732.3267263-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org,
 jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org,
 sramana@codeaurora.org, marcan@marcan.st, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Hector Martin <marcan@marcan.st>,
 Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
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

From: Srinivas Ramana <sramana@codeaurora.org>

Defer enabling pointer authentication on boot core until
after its required to be enabled by cpufeature framework.
This will help in controlling the feature dynamically
with a boot parameter.

Signed-off-by: Ajay Patil <pajay@qti.qualcomm.com>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1610152163-16554-2-git-send-email-sramana@codeaurora.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/pointer_auth.h   | 10 ++++++++++
 arch/arm64/include/asm/stackprotector.h |  1 +
 arch/arm64/kernel/head.S                |  4 ----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index c6b4f0603024..b112a11e9302 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -76,6 +76,15 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 	return ptrauth_clear_pac(ptr);
 }
 
+static __always_inline void ptrauth_enable(void)
+{
+	if (!system_supports_address_auth())
+		return;
+	sysreg_clear_set(sctlr_el1, 0, (SCTLR_ELx_ENIA | SCTLR_ELx_ENIB |
+					SCTLR_ELx_ENDA | SCTLR_ELx_ENDB));
+	isb();
+}
+
 #define ptrauth_thread_init_user(tsk)					\
 	ptrauth_keys_init_user(&(tsk)->thread.keys_user)
 #define ptrauth_thread_init_kernel(tsk)					\
@@ -84,6 +93,7 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 	ptrauth_keys_switch_kernel(&(tsk)->thread.keys_kernel)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
+#define ptrauth_enable()
 #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
 #define ptrauth_strip_insn_pac(lr)	(lr)
 #define ptrauth_thread_init_user(tsk)
diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
index 7263e0bac680..33f1bb453150 100644
--- a/arch/arm64/include/asm/stackprotector.h
+++ b/arch/arm64/include/asm/stackprotector.h
@@ -41,6 +41,7 @@ static __always_inline void boot_init_stack_canary(void)
 #endif
 	ptrauth_thread_init_kernel(current);
 	ptrauth_thread_switch_kernel(current);
+	ptrauth_enable();
 }
 
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3243e3ae9bd8..2e116ef255e1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -404,10 +404,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	adr_l	x5, init_task
 	msr	sp_el0, x5			// Save thread_info
 
-#ifdef CONFIG_ARM64_PTR_AUTH
-	__ptrauth_keys_init_cpu	x5, x6, x7, x8
-#endif
-
 	adr_l	x8, vectors			// load VBAR_EL1 with virtual
 	msr	vbar_el1, x8			// vector table address
 	isb
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
