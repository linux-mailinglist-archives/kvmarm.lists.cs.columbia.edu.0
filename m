Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5149CD81
	for <lists+kvmarm@lfdr.de>; Wed, 26 Jan 2022 16:12:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A11149B08;
	Wed, 26 Jan 2022 10:12:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVHXb+sqB39e; Wed, 26 Jan 2022 10:12:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C8CE240BE6;
	Wed, 26 Jan 2022 10:12:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A231540B75
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 10:12:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YjiUR1GFTCwt for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jan 2022 10:12:45 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 218FD40BE6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 10:12:45 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9537CB81C0F;
 Wed, 26 Jan 2022 15:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F47C340EB;
 Wed, 26 Jan 2022 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643209962;
 bh=dxZojSg+AyGMNDiyUywnEA9WS18lR7uN1j1lZgSyfRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q5daYwqSsSa0kktiYLWV1ZgVs35Drfnt+4dAvCD2Q95wNnGrhkana4nwdBCRh0I/d
 wqRUNZizWGNopH+Oy6ccrXRJU8U+/w9EHKUVeCLac+MC5OpWIcbv7Pyor1rErcSSCb
 1XoJfjqANvcwWVakYjx/gMykuJolKaoCL8iL9E8Uix0vPPJKcZ8t3740FSPeoPqiIi
 1YC8DY2oZM5Rv1EXyookfTW5Y6I2SZWAjjb7XzKWjG/c8N3/Iqx4m/UkF57A2dk7K6
 bSocidQSiFygSfYA3oHPa860ZZOvGzUYIGXqNL/WUXnh7J5NgLEm8+LzCZ8qyVICDU
 ZrUx20UF4SlAQ==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v9 17/40] arm64/sme: Implement traps and syscall handling for
 SME
Date: Wed, 26 Jan 2022 15:10:57 +0000
Message-Id: <20220126151120.3811248-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16748; h=from:subject;
 bh=dxZojSg+AyGMNDiyUywnEA9WS18lR7uN1j1lZgSyfRs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSEruvOzzUQqJA2oxrU5e+/NfW9xtUspy1kBoF0
 M0t/lZmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkhAAKCRAk1otyXVSH0Gz5B/
 9WSj0qiEzTHRD3NzMRZne3+hc7N3IVQ0oR6r6Hmt2NePKBaSwxhUj8Bx294736siXV+EjfCLWhjuPl
 4YiiCrQSdbmX+JddNv8C3CRSSKVPP3ynhGiikhbuFgVZrUYi6IQ6iQzN+yh6chPhgeGdCA7XOEzviE
 MeGn3lGMA+r+qJnQG+AbA5G1prayl0yqDqrfGgIet7ORzrW43P/dQV25ufAAdw4uVabKOTy96/SB6b
 /yBHYwaf1+gXbkqKVKqaCeY+tYFh/uE3kssZA/dDclUFdkZtb3SfWnlOEyoFrQGuZbupyn8YJzjsVK
 KtzkhQpAac71ICF+lqurO36OccuhPI
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

By default all SME operations in userspace will trap.  When this happens
we allocate storage space for the SME register state, set up the SVE
registers and disable traps.  We do not need to initialize ZA since the
architecture guarantees that it will be zeroed when enabled and when we
trap ZA is disabled.

On syscall we exit streaming mode if we were previously in it and ensure
that all but the lower 128 bits of the registers are zeroed while
preserving the state of ZA. This follows the aarch64 PCS for SME, ZA
state is preserved over a function call and streaming mode is exited.
Since the traps for SME do not distinguish between streaming mode SVE
and ZA usage if ZA is in use rather than reenabling traps we instead
zero the parts of the SVE registers not shared with FPSIMD and leave SME
enabled, this simplifies handling SME traps. If ZA is not in use then we
reenable SME traps and fall through to normal handling of SVE.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h       |   1 +
 arch/arm64/include/asm/exception.h |   1 +
 arch/arm64/include/asm/fpsimd.h    |  27 +++++
 arch/arm64/kernel/entry-common.c   |  11 ++
 arch/arm64/kernel/fpsimd.c         | 180 ++++++++++++++++++++++++++---
 arch/arm64/kernel/process.c        |  12 +-
 arch/arm64/kernel/syscall.c        |  34 +++++-
 7 files changed, 242 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 43872e0cfd1e..0467837fd66b 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -76,6 +76,7 @@
 #define ESR_ELx_IL_SHIFT	(25)
 #define ESR_ELx_IL		(UL(1) << ESR_ELx_IL_SHIFT)
 #define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
+#define ESR_ELx_ISS(esr)	((esr) & ESR_ELx_ISS_MASK)
 
 /* ISS field definitions shared by different classes */
 #define ESR_ELx_WNR_SHIFT	(6)
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 339477dca551..2add7f33b7c2 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -64,6 +64,7 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 			struct pt_regs *regs);
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs);
 void do_sve_acc(unsigned int esr, struct pt_regs *regs);
+void do_sme_acc(unsigned int esr, struct pt_regs *regs);
 void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs);
 void do_sysinstr(unsigned int esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index af404e5b8d82..3ca152aaf7c9 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -282,6 +282,16 @@ static inline void sve_setup(void) { }
 
 #ifdef CONFIG_ARM64_SME
 
+static inline void sme_user_disable(void)
+{
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_SMEN_EL0EN, 0);
+}
+
+static inline void sme_user_enable(void)
+{
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_SMEN_EL0EN);
+}
+
 static inline void sme_smstart_sm(void)
 {
 	asm volatile(".inst 0xd503437f");
@@ -309,16 +319,33 @@ static inline int sme_max_virtualisable_vl(void)
 	return vec_max_virtualisable_vl(ARM64_VEC_SME);
 }
 
+extern void sme_alloc(struct task_struct *task);
 extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
 
+/*
+ * Return how many bytes of memory are required to store the full SME
+ * specific state (currently just ZA) for task, given task's currently
+ * configured vector length.
+ */
+static inline size_t za_state_size(struct task_struct const *task)
+{
+	unsigned int vl = task_get_sme_vl(task);
+
+	return ZA_SIG_REGS_SIZE(sve_vq_from_vl(vl));
+}
+
 #else
 
+static inline void sme_user_disable(void) { BUILD_BUG(); }
+static inline void sme_user_enable(void) { BUILD_BUG(); }
+
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
 static inline void sme_smstop(void) { }
 
+static inline void sme_alloc(struct task_struct *task) { }
 static inline void sme_setup(void) { }
 static inline unsigned int sme_get_vl(void) { return 0; }
 static inline int sme_max_vl(void) { return 0; }
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ef7fcefb96bd..b2ad525d6c87 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -524,6 +524,14 @@ static void noinstr el0_sve_acc(struct pt_regs *regs, unsigned long esr)
 	exit_to_user_mode(regs);
 }
 
+static void noinstr el0_sme_acc(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_sme_acc(esr, regs);
+	exit_to_user_mode(regs);
+}
+
 static void noinstr el0_fpsimd_exc(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
@@ -632,6 +640,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_SVE:
 		el0_sve_acc(regs, esr);
 		break;
+	case ESR_ELx_EC_SME:
+		el0_sme_acc(regs, esr);
+		break;
 	case ESR_ELx_EC_FP_EXC64:
 		el0_fpsimd_exc(regs, esr);
 		break;
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c9e8186e69c0..33f80512753d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -209,6 +209,12 @@ static void set_sme_default_vl(int val)
 	set_default_vl(ARM64_VEC_SME, val);
 }
 
+static void sme_free(struct task_struct *);
+
+#else
+
+static inline void sme_free(struct task_struct *t) { }
+
 #endif
 
 DEFINE_PER_CPU(bool, fpsimd_context_busy);
@@ -409,6 +415,21 @@ static void task_fpsimd_load(void)
 			       restore_ffr);
 	else
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+
+	/*
+	 * If we didn't set up any SVE registers but we do have SME
+	 * enabled for userspace then ensure the SVE registers are
+	 * flushed since userspace can switch to streaming mode and
+	 * view the register state without trapping.
+	 */
+	if (system_supports_sme() && test_thread_flag(TIF_SME) &&
+	    !restore_sve_regs) {
+		int sve_vq_minus_one;
+
+		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
+		sve_set_vq(sve_vq_minus_one);
+		sve_flush_live(true, sve_vq_minus_one);
+	}
 }
 
 /*
@@ -812,18 +833,22 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	    thread_sm_enabled(&task->thread))
 		sve_to_fpsimd(task);
 
-	if (system_supports_sme() && type == ARM64_VEC_SME)
+	if (system_supports_sme() && type == ARM64_VEC_SME) {
 		task->thread.svcr &= ~(SYS_SVCR_EL0_SM_MASK |
 				       SYS_SVCR_EL0_ZA_MASK);
+		clear_thread_flag(TIF_SME);
+	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
 
 	/*
-	 * Force reallocation of task SVE state to the correct size
-	 * on next use:
+	 * Force reallocation of task SVE and SME state to the correct
+	 * size on next use:
 	 */
 	sve_free(task);
+	if (system_supports_sme() && type == ARM64_VEC_SME)
+		sme_free(task);
 
 	task_set_vl(task, type, vl);
 
@@ -1158,12 +1183,43 @@ void __init sve_setup(void)
 void fpsimd_release_task(struct task_struct *dead_task)
 {
 	__sve_free(dead_task);
+	sme_free(dead_task);
 }
 
 #endif /* CONFIG_ARM64_SVE */
 
 #ifdef CONFIG_ARM64_SME
 
+/* This will move to uapi/asm/sigcontext.h when signals are implemented */
+#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
+
+/*
+ * Ensure that task->thread.za_state is allocated and sufficiently large.
+ *
+ * This function should be used only in preparation for replacing
+ * task->thread.za_state with new data.  The memory is always zeroed
+ * here to prevent stale data from showing through: this is done in
+ * the interest of testability and predictability, the architecture
+ * guarantees that when ZA is enabled it will be zeroed.
+ */
+void sme_alloc(struct task_struct *task)
+{
+	if (task->thread.za_state) {
+		memset(task->thread.za_state, 0, za_state_size(task));
+		return;
+	}
+
+	/* This could potentially be up to 64K. */
+	task->thread.za_state =
+		kzalloc(za_state_size(task), GFP_KERNEL);
+}
+
+static void sme_free(struct task_struct *task)
+{
+	kfree(task->thread.za_state);
+	task->thread.za_state = NULL;
+}
+
 void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 {
 	/* Set priority for all PEs to architecturally defined minimum */
@@ -1273,6 +1329,29 @@ void __init sme_setup(void)
 
 #endif /* CONFIG_ARM64_SME */
 
+static void sve_init_regs(void)
+{
+	/*
+	 * Convert the FPSIMD state to SVE, zeroing all the state that
+	 * is not shared with FPSIMD. If (as is likely) the current
+	 * state is live in the registers then do this there and
+	 * update our metadata for the current task including
+	 * disabling the trap, otherwise update our in-memory copy.
+	 * We are guaranteed to not be in streaming mode, we can only
+	 * take a SVE trap when not in streaming mode and we can't be
+	 * in streaming mode when taking a SME trap.
+	 */
+	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		unsigned long vq_minus_one =
+			sve_vq_from_vl(task_get_sve_vl(current)) - 1;
+		sve_set_vq(vq_minus_one);
+		sve_flush_live(true, vq_minus_one);
+		fpsimd_bind_task_to_cpu();
+	} else {
+		fpsimd_to_sve(current);
+	}
+}
+
 /*
  * Trapped SVE access
  *
@@ -1304,22 +1383,77 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
 	/*
-	 * Convert the FPSIMD state to SVE, zeroing all the state that
-	 * is not shared with FPSIMD. If (as is likely) the current
-	 * state is live in the registers then do this there and
-	 * update our metadata for the current task including
-	 * disabling the trap, otherwise update our in-memory copy.
+	 * Even if the task can have used streaming mode we can only
+	 * generate SVE access traps in normal SVE mode and
+	 * transitioning out of streaming mode may discard any
+	 * streaming mode state.  Always clear the high bits to avoid
+	 * any potential errors tracking what is properly initialised.
 	 */
+	sve_init_regs();
+
+	put_cpu_fpsimd_context();
+}
+
+/*
+ * Trapped SME access
+ *
+ * Storage is allocated for the full SVE and SME state, the current
+ * FPSIMD register contents are migrated to SVE if SVE is not already
+ * active, and the access trap is disabled.
+ *
+ * TIF_SME should be clear on entry: otherwise, fpsimd_restore_current_state()
+ * would have disabled the SME access trap for userspace during
+ * ret_to_user, making an SVE access trap impossible in that case.
+ */
+void do_sme_acc(unsigned int esr, struct pt_regs *regs)
+{
+	/* Even if we chose not to use SME, the hardware could still trap: */
+	if (unlikely(!system_supports_sme()) || WARN_ON(is_compat_task())) {
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
+		return;
+	}
+
+	/*
+	 * If this not a trap due to SME being disabled then something
+	 * is being used in the wrong mode, report as SIGILL.
+	 */
+	if (ESR_ELx_ISS(esr) != ESR_ELx_SME_ISS_SME_DISABLED) {
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
+		return;
+	}
+
+	sve_alloc(current);
+	sme_alloc(current);
+	if (!current->thread.sve_state || !current->thread.za_state) {
+		force_sig(SIGKILL);
+		return;
+	}
+
+	get_cpu_fpsimd_context();
+
+	/* With TIF_SME userspace shouldn't generate any traps */
+	if (test_and_set_thread_flag(TIF_SME))
+		WARN_ON(1);
+
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		unsigned long vq_minus_one =
-			sve_vq_from_vl(task_get_sve_vl(current)) - 1;
-		sve_set_vq(vq_minus_one);
-		sve_flush_live(true, vq_minus_one);
+			sve_vq_from_vl(task_get_sme_vl(current)) - 1;
+		sme_set_vq(vq_minus_one);
+
 		fpsimd_bind_task_to_cpu();
-	} else {
-		fpsimd_to_sve(current);
 	}
 
+	/*
+	 * If SVE was not already active initialise the SVE registers,
+	 * any non-shared state between the streaming and regular SVE
+	 * registers is architecturally guaranteed to be zeroed when
+	 * we enter streaming mode.  We do not need to initialize ZA
+	 * since ZA must be disabled at this point and enabling ZA is
+	 * architecturally defined to zero ZA.
+	 */
+	if (system_supports_sve() && !test_thread_flag(TIF_SVE))
+		sve_init_regs();
+
 	put_cpu_fpsimd_context();
 }
 
@@ -1436,8 +1570,11 @@ void fpsimd_flush_thread(void)
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}
 
-	if (system_supports_sme())
+	if (system_supports_sme()) {
+		clear_thread_flag(TIF_SME);
+		sme_free(current);
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
+	}
 
 	put_cpu_fpsimd_context();
 }
@@ -1487,15 +1624,24 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->svcr = &current->thread.svcr;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
+	/*
+	 * Toggle SVE and SME trapping for userspace if needed, these
+	 * are serialsied by ret_to_user().
+	 */
+	if (system_supports_sme()) {
+		if (test_thread_flag(TIF_SME))
+			sme_user_enable();
+		else
+			sme_user_disable();
+	}
+
 	if (system_supports_sve()) {
-		/* Toggle SVE trapping for userspace if needed */
 		if (test_thread_flag(TIF_SVE))
 			sve_user_enable();
 		else
 			sve_user_disable();
-
-		/* Serialised by exception return to user */
 	}
+
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f2d32a29641c..f7fcc625ea0e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -299,17 +299,19 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
 
 	/*
-	 * Detach src's sve_state (if any) from dst so that it does not
-	 * get erroneously used or freed prematurely.  dst's sve_state
-	 * will be allocated on demand later on if dst uses SVE.
-	 * For consistency, also clear TIF_SVE here: this could be done
+	 * Detach src's sve/za_state (if any) from dst so that it does not
+	 * get erroneously used or freed prematurely.  dst's copies
+	 * will be allocated on demand later on if dst uses SVE/SME.
+	 * For consistency, also clear TIF_SVE/SME here: this could be done
 	 * later in copy_process(), but to avoid tripping up future
-	 * maintainers it is best not to leave TIF_SVE and sve_state in
+	 * maintainers it is best not to leave TIF flags and buffers in
 	 * an inconsistent state, even temporarily.
 	 */
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
+	dst->thread.za_state = NULL;
+	clear_tsk_thread_flag(dst, TIF_SME);
 	dst->thread.svcr = 0;
 
 	/* clear any pending asynchronous tag fault raised by the parent */
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c938603b3ba0..958b2d926354 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -158,11 +158,41 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	syscall_trace_exit(regs);
 }
 
-static inline void sve_user_discard(void)
+/*
+ * As per the ABI exit SME streaming mode and clear the SVE state not
+ * shared with FPSIMD on syscall entry.
+ */
+static inline void fp_user_discard(void)
 {
+	/*
+	 * If SME is active then exit streaming mode.  If ZA is active
+	 * then flush the SVE registers but leave userspace access to
+	 * both SVE and SME enabled, otherwise disable SME for the
+	 * task and fall through to disabling SVE too.  This means
+	 * that after a syscall we never have any SME register state
+	 * to track, if this changes the KVM code will need updating.
+	 */
+	if (system_supports_sme() && test_thread_flag(TIF_SME)) {
+		u64 svcr = read_sysreg_s(SYS_SVCR_EL0);
+
+		if (svcr & SYS_SVCR_EL0_SM_MASK)
+			sme_smstop_sm();
+
+		if (!(svcr & SYS_SVCR_EL0_ZA_MASK)) {
+			clear_thread_flag(TIF_SME);
+			sme_user_disable();
+		}
+	}
+
+
 	if (!system_supports_sve())
 		return;
 
+	/*
+	 * If SME is not active then disable SVE, the registers will
+	 * be cleared when userspace next attempts to access them and
+	 * we do not need to track the SVE register state until then.
+	 */
 	clear_thread_flag(TIF_SVE);
 
 	/*
@@ -177,7 +207,7 @@ static inline void sve_user_discard(void)
 
 void do_el0_svc(struct pt_regs *regs)
 {
-	sve_user_discard();
+	fp_user_discard();
 	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
 }
 
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
