Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 26410506A04
	for <lists+kvmarm@lfdr.de>; Tue, 19 Apr 2022 13:24:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA99F4B0F4;
	Tue, 19 Apr 2022 07:24:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bm0n4790KFO6; Tue, 19 Apr 2022 07:24:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 632244B20D;
	Tue, 19 Apr 2022 07:24:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B88943C96
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 07:24:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7WaSJb75ZKrF for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 Apr 2022 07:24:48 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EDE744B1D0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 07:24:47 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 29FBBB81846;
 Tue, 19 Apr 2022 11:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F96CC385B1;
 Tue, 19 Apr 2022 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650367485;
 bh=vsrFSW1m77Xo6Mbo/DN2WmG93WAioTHIs0aQovVgREo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q1q2+8QtCOmpafcGLx4G9SYgKAYtXOAlvoPwnfeqjnbPt+yixTDDZtN8BcZgWfCbx
 2ptKY9FjOldMLeDkH1UXSAMf5SPT/NqDunqdj7T8bRqPBbOT9T67wpZg6EJm4+Hkrw
 QlXDvID7IS1aTsXbPwauFGLh+9ShOLixxG+LbDCjXF16pDAVzPq2k6LKVKLrElASUy
 7k82yqlp60QMvl/kZFAxNn2yVkanvAJgVCgRQD5uMsf7c3DSI187sldCVRdT/B+mAt
 IEBpJkn38LZSqjGHnafyUARCmr5YYtyu+1ogi17RPo08nm/e4sNLISBd9RDnQ3ZSzF
 CmkJNaVwB9A2A==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v14 19/39] arm64/sme: Implement ZA signal handling
Date: Tue, 19 Apr 2022 12:22:27 +0100
Message-Id: <20220419112247.711548-20-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8960; h=from:subject;
 bh=vsrFSW1m77Xo6Mbo/DN2WmG93WAioTHIs0aQovVgREo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpt2UV+61QZA6Q0r4+ixEbDBhLBAz0HxEplmTqJE
 3kwsIWyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bdgAKCRAk1otyXVSH0JvkB/
 980duOLMGbl4hORQm5wX57kGWeOcClRjhxoK/S6iWvPtcse16ZGBRuFJGs+b+k26GsDrkAGWrWS+32
 fXWQ80zT0781gNaGeyDDibCerlNsKrwjUhEz9FQad0ICiNuKw36TLlyGwO9CQqi/EJ8JMxbhkzMQ0v
 LkDPrwzxsQd9f8xZ4MLNjg+ymA9HI82xFULAXmNpFVK+GNDwIVhe6hjGGVLRhnxcyfQEnbS5c4XmCx
 C0DOimpqgDk0eXMi4EilARTmQvXJM5jXmr17XxppZ2MnKMdC/SBkZOhuFlzSZE4by9E1KGLhVPw74c
 bDz9Kg0Bf+lCT0q97xfV7uxfFUw/Fd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>,
 Luca Salabrino <luca.scalabrino@arm.com>
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

Implement support for ZA in signal handling in a very similar way to how
we implement support for SVE registers, using a signal context structure
with optional register state after it. Where present this register state
stores the ZA matrix as a series of horizontal vectors numbered from 0 to
VL/8 in the endinanness independent format used for vectors.

As with SVE we do not allow changes in the vector length during signal
return but we do allow ZA to be enabled or disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  41 +++++++
 arch/arm64/kernel/fpsimd.c               |   3 -
 arch/arm64/kernel/signal.c               | 139 +++++++++++++++++++++++
 3 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 57e9f8c3ee9e..4aaf31e3bf16 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -140,6 +140,14 @@ struct sve_context {
 
 #define SVE_SIG_FLAG_SM	0x1	/* Context describes streaming mode */
 
+#define ZA_MAGIC	0x54366345
+
+struct za_context {
+	struct _aarch64_ctx head;
+	__u16 vl;
+	__u16 __reserved[3];
+};
+
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/sve_context.h>
@@ -259,4 +267,37 @@ struct sve_context {
 #define SVE_SIG_CONTEXT_SIZE(vq) \
 		(SVE_SIG_REGS_OFFSET + SVE_SIG_REGS_SIZE(vq))
 
+/*
+ * If the ZA register is enabled for the thread at signal delivery then,
+ * za_context.head.size >= ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za_context.vl))
+ * and the register data may be accessed using the ZA_SIG_*() macros.
+ *
+ * If za_context.head.size < ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za_context.vl))
+ * then ZA was not enabled and no register data was included in which case
+ * ZA register was not enabled for the thread and no register data
+ * the ZA_SIG_*() macros should not be used except for this check.
+ *
+ * The same convention applies when returning from a signal: a caller
+ * will need to remove or resize the za_context block if it wants to
+ * enable the ZA register when it was previously non-live or vice-versa.
+ * This may require the caller to allocate fresh memory and/or move other
+ * context blocks in the signal frame.
+ *
+ * Changing the vector length during signal return is not permitted:
+ * za_context.vl must equal the thread's current SME vector length when
+ * doing a sigreturn.
+ */
+
+#define ZA_SIG_REGS_OFFSET					\
+	((sizeof(struct za_context) + (__SVE_VQ_BYTES - 1))	\
+		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
+
+#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
+
+#define ZA_SIG_ZAV_OFFSET(vq, n) (ZA_SIG_REGS_OFFSET + \
+				  (SVE_SIG_ZREG_SIZE(vq) * n))
+
+#define ZA_SIG_CONTEXT_SIZE(vq) \
+		(ZA_SIG_REGS_OFFSET + ZA_SIG_REGS_SIZE(vq))
+
 #endif /* _UAPI__ASM_SIGCONTEXT_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 00a0cbd01ce5..80f7ca12f855 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1181,9 +1181,6 @@ void fpsimd_release_task(struct task_struct *dead_task)
 
 #ifdef CONFIG_ARM64_SME
 
-/* This will move to uapi/asm/sigcontext.h when signals are implemented */
-#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
-
 /*
  * Ensure that task->thread.za_state is allocated and sufficiently large.
  *
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0ddce6afd2a3..2295948d97fd 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -56,6 +56,7 @@ struct rt_sigframe_user_layout {
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
 	unsigned long sve_offset;
+	unsigned long za_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
 };
@@ -218,6 +219,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
 	struct sve_context __user *sve;
+	struct za_context __user *za;
 };
 
 #ifdef CONFIG_ARM64_SVE
@@ -346,6 +348,101 @@ extern int restore_sve_fpsimd_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+static int preserve_za_context(struct za_context __user *ctx)
+{
+	int err = 0;
+	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
+	unsigned int vl = task_get_sme_vl(current);
+	unsigned int vq;
+
+	if (thread_za_enabled(&current->thread))
+		vq = sve_vq_from_vl(vl);
+	else
+		vq = 0;
+
+	memset(reserved, 0, sizeof(reserved));
+
+	__put_user_error(ZA_MAGIC, &ctx->head.magic, err);
+	__put_user_error(round_up(ZA_SIG_CONTEXT_SIZE(vq), 16),
+			 &ctx->head.size, err);
+	__put_user_error(vl, &ctx->vl, err);
+	BUILD_BUG_ON(sizeof(ctx->__reserved) != sizeof(reserved));
+	err |= __copy_to_user(&ctx->__reserved, reserved, sizeof(reserved));
+
+	if (vq) {
+		/*
+		 * This assumes that the ZA state has already been saved to
+		 * the task struct by calling the function
+		 * fpsimd_signal_preserve_current_state().
+		 */
+		err |= __copy_to_user((char __user *)ctx + ZA_SIG_REGS_OFFSET,
+				      current->thread.za_state,
+				      ZA_SIG_REGS_SIZE(vq));
+	}
+
+	return err ? -EFAULT : 0;
+}
+
+static int restore_za_context(struct user_ctxs __user *user)
+{
+	int err;
+	unsigned int vq;
+	struct za_context za;
+
+	if (__copy_from_user(&za, user->za, sizeof(za)))
+		return -EFAULT;
+
+	if (za.vl != task_get_sme_vl(current))
+		return -EINVAL;
+
+	if (za.head.size <= sizeof(*user->za)) {
+		current->thread.svcr &= ~SYS_SVCR_EL0_ZA_MASK;
+		return 0;
+	}
+
+	vq = sve_vq_from_vl(za.vl);
+
+	if (za.head.size < ZA_SIG_CONTEXT_SIZE(vq))
+		return -EINVAL;
+
+	/*
+	 * Careful: we are about __copy_from_user() directly into
+	 * thread.za_state with preemption enabled, so protection is
+	 * needed to prevent a racing context switch from writing stale
+	 * registers back over the new data.
+	 */
+
+	fpsimd_flush_task_state(current);
+	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
+
+	sme_alloc(current);
+	if (!current->thread.za_state) {
+		current->thread.svcr &= ~SYS_SVCR_EL0_ZA_MASK;
+		clear_thread_flag(TIF_SME);
+		return -ENOMEM;
+	}
+
+	err = __copy_from_user(current->thread.za_state,
+			       (char __user const *)user->za +
+					ZA_SIG_REGS_OFFSET,
+			       ZA_SIG_REGS_SIZE(vq));
+	if (err)
+		return -EFAULT;
+
+	set_thread_flag(TIF_SME);
+	current->thread.svcr |= SYS_SVCR_EL0_ZA_MASK;
+
+	return 0;
+}
+#else /* ! CONFIG_ARM64_SME */
+
+/* Turn any non-optimised out attempts to use these into a link error: */
+extern int preserve_za_context(void __user *ctx);
+extern int restore_za_context(struct user_ctxs *user);
+
+#endif /* ! CONFIG_ARM64_SME */
 
 static int parse_user_sigframe(struct user_ctxs *user,
 			       struct rt_sigframe __user *sf)
@@ -360,6 +457,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 
 	user->fpsimd = NULL;
 	user->sve = NULL;
+	user->za = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -425,6 +523,19 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->sve = (struct sve_context __user *)head;
 			break;
 
+		case ZA_MAGIC:
+			if (!system_supports_sme())
+				goto invalid;
+
+			if (user->za)
+				goto invalid;
+
+			if (size < sizeof(*user->za))
+				goto invalid;
+
+			user->za = (struct za_context __user *)head;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -548,6 +659,9 @@ static int restore_sigframe(struct pt_regs *regs,
 		}
 	}
 
+	if (err == 0 && system_supports_sme() && user.za)
+		err = restore_za_context(&user);
+
 	return err;
 }
 
@@ -630,6 +744,24 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+	if (system_supports_sme()) {
+		unsigned int vl;
+		unsigned int vq = 0;
+
+		if (add_all)
+			vl = sme_max_vl();
+		else
+			vl = task_get_sme_vl(current);
+
+		if (thread_za_enabled(&current->thread))
+			vq = sve_vq_from_vl(vl);
+
+		err = sigframe_alloc(user, &user->za_offset,
+				     ZA_SIG_CONTEXT_SIZE(vq));
+		if (err)
+			return err;
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -678,6 +810,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_sve_context(sve_ctx);
 	}
 
+	/* ZA state if present */
+	if (system_supports_sme() && err == 0 && user->za_offset) {
+		struct za_context __user *za_ctx =
+			apply_user_offset(user, user->za_offset);
+		err |= preserve_za_context(za_ctx);
+	}
+
 	if (err == 0 && user->extra_offset) {
 		char __user *sfp = (char __user *)user->sigframe;
 		char __user *userp =
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
