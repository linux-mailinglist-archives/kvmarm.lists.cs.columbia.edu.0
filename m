Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1625688
	for <lists+kvmarm@lfdr.de>; Tue, 21 May 2019 19:22:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF0DC4A525;
	Tue, 21 May 2019 13:22:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sthC6OrUiPMY; Tue, 21 May 2019 13:22:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF9E44A521;
	Tue, 21 May 2019 13:22:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 19AFE4A47A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 13:22:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26vX8FJ0LhQk for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 May 2019 13:22:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 012404A503
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 13:22:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78D7E15AB;
 Tue, 21 May 2019 10:22:00 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1873F718;
 Tue, 21 May 2019 10:21:57 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Tue, 21 May 2019 18:21:39 +0100
Message-Id: <20190521172139.21277-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190521172139.21277-1-julien.grall@arm.com>
References: <20190521172139.21277-1-julien.grall@arm.com>
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, Julien Grall <julien.grall@arm.com>,
 Dave Martin <dave.martin@arm.com>
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

When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
the kernel may be able to use FPSIMD/SVE. This is for instance the case
for crypto code.

Any use of FPSIMD/SVE in the kernel are clearly marked by using the
function kernel_neon_{begin, end}. Furthermore, this can only be used
when may_use_simd() returns true.

The current implementation of may_use_simd() allows softirq to use
FPSIMD/SVE unless it is currently in use (i.e kernel_neon_busy is true).
When in use, softirqs usually fall back to a software method.

At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
when touching the FPSIMD/SVE context. This has the drawback to disable
all softirqs even if they are not using FPSIMD/SVE.

Since a softirq is supposed to check may_use_simd() anyway before
attempting to use FPSIMD/SVE, there is limited reason to keep softirq
disabled when touching the FPSIMD/SVE context. Instead, we can simply
disable preemption and mark the FPSIMD/SVE context as in use by setting
CPU's fpsimd_context_busy flag.

Two new helpers {get, put}_cpu_fpsimd_context are introduced to mark
the area using FPSIMD/SVE context and they are used to replace
local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
also re-implemented to use the new helpers.

Additionally, double-underscored versions of the helpers are provided to
called when preemption is already disabled. These are only relevant on
paths where irqs are disabled anyway, so they are not needed for
correctness in the current code. Let's use them anyway though: this
marks critical sections clearly and will help to avoid mistakes during
future maintenance.

The change has been benchmarked on Linux 5.1-rc4 with defconfig.

On Juno2:
    * hackbench 100 process 1000 (10 times)
    * .7% quicker

On ThunderX 2:
    * hackbench 1000 process 1000 (20 times)
    * 3.4% quicker

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>

---
    Changes in v5:
        - Update commit message
        - Add Dave's reviewed-by

    Changes in v4:
        - Clarify the comment on top of get_cpu_fpsimd_context()
        - Use double-underscore version in fpsimd_save_and_flush_cpu_state()

    Changes in v3:
        - Fix typoes in the commit message
        - Rework a bit the commit message
        - Use imperative mood
        - Rename kernel_neon_busy to fpsimd_context_busy
        - Remove debug code
        - Update comments
        - Don't require preemption when calling fpsimd_save_and_flush_cpu_state()

    Changes in v2:
        - Remove spurious call to kernel_neon_enable in kernel_neon_begin.
        - Rename kernel_neon_{enable, disable} to {get, put}_cpu_fpsimd_context
        - Introduce a double-underscore version of the helpers for case
        where preemption is already disabled
        - Introduce have_cpu_fpsimd_context() and use it in WARN_ON(...)
        - Surround more places in the code with the new helpers
        - Rework the comments
        - Update the commit message with the benchmark result
---
 arch/arm64/include/asm/simd.h |  10 ++--
 arch/arm64/kernel/fpsimd.c    | 124 ++++++++++++++++++++++++++++--------------
 2 files changed, 89 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 6495cc51246f..a6307e43b8c2 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -15,9 +15,9 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_KERNEL_MODE_NEON
+DECLARE_PER_CPU(bool, fpsimd_context_busy);
 
-DECLARE_PER_CPU(bool, kernel_neon_busy);
+#ifdef CONFIG_KERNEL_MODE_NEON
 
 /*
  * may_use_simd - whether it is allowable at this time to issue SIMD
@@ -29,15 +29,15 @@ DECLARE_PER_CPU(bool, kernel_neon_busy);
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * kernel_neon_busy is only set while preemption is disabled,
+	 * fpsimd_context_busy is only set while preemption is disabled,
 	 * and is clear whenever preemption is enabled. Since
-	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
+	 * this_cpu_read() is atomic w.r.t. preemption, fpsimd_context_busy
 	 * cannot change under our feet -- if it's set we cannot be
 	 * migrated, and if it's clear we cannot be migrated to a CPU
 	 * where it is set.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!this_cpu_read(kernel_neon_busy);
+		!this_cpu_read(fpsimd_context_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 6448921a2f59..c7c454df2779 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -92,7 +92,8 @@
  * To prevent this from racing with the manipulation of the task's FPSIMD state
  * from task context and thereby corrupting the state, it is necessary to
  * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
- * flag with local_bh_disable() unless softirqs are already masked.
+ * flag with {, __}get_cpu_fpsimd_context(). This will still allow softirqs to
+ * run but prevent them to use FPSIMD.
  *
  * For a certain task, the sequence may look something like this:
  * - the task gets scheduled in; if both the task's fpsimd_cpu field
@@ -155,6 +156,56 @@ extern void __percpu *efi_sve_state;
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+DEFINE_PER_CPU(bool, fpsimd_context_busy);
+EXPORT_PER_CPU_SYMBOL(fpsimd_context_busy);
+
+static void __get_cpu_fpsimd_context(void)
+{
+	bool busy = __this_cpu_xchg(fpsimd_context_busy, true);
+
+	WARN_ON(busy);
+}
+
+/*
+ * Claim ownership of the CPU FPSIMD context for use by the calling context.
+ *
+ * The caller may freely manipulate the FPSIMD context metadata until
+ * put_cpu_fpsimd_context() is called.
+ *
+ * The double-underscore version must only be called if you know the task
+ * can't be preempted.
+ */
+static void get_cpu_fpsimd_context(void)
+{
+	preempt_disable();
+	__get_cpu_fpsimd_context();
+}
+
+static void __put_cpu_fpsimd_context(void)
+{
+	bool busy = __this_cpu_xchg(fpsimd_context_busy, false);
+
+	WARN_ON(!busy); /* No matching get_cpu_fpsimd_context()? */
+}
+
+/*
+ * Release the CPU FPSIMD context.
+ *
+ * Must be called from a context in which get_cpu_fpsimd_context() was
+ * previously called, with no call to put_cpu_fpsimd_context() in the
+ * meantime.
+ */
+static void put_cpu_fpsimd_context(void)
+{
+	__put_cpu_fpsimd_context();
+	preempt_enable();
+}
+
+static bool have_cpu_fpsimd_context(void)
+{
+	return !preemptible() && __this_cpu_read(fpsimd_context_busy);
+}
+
 /*
  * Call __sve_free() directly only if you know task can't be scheduled
  * or preempted.
@@ -225,12 +276,10 @@ static void sve_free(struct task_struct *task)
  * This function should be called only when the FPSIMD/SVE state in
  * thread_struct is known to be up to date, when preparing to enter
  * userspace.
- *
- * Softirqs (and preemption) must be disabled.
  */
 static void task_fpsimd_load(void)
 {
-	WARN_ON(!in_softirq() && !irqs_disabled());
+	WARN_ON(!have_cpu_fpsimd_context());
 
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
 		sve_load_state(sve_pffr(&current->thread),
@@ -243,8 +292,6 @@ static void task_fpsimd_load(void)
 /*
  * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
  * date with respect to the CPU registers.
- *
- * Softirqs (and preemption) must be disabled.
  */
 static void fpsimd_save(void)
 {
@@ -252,7 +299,7 @@ static void fpsimd_save(void)
 		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
 
-	WARN_ON(!in_softirq() && !irqs_disabled());
+	WARN_ON(!have_cpu_fpsimd_context());
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
@@ -357,7 +404,8 @@ static int __init sve_sysctl_init(void) { return 0; }
  * task->thread.sve_state.
  *
  * Task can be a non-runnable task, or current.  In the latter case,
- * softirqs (and preemption) must be disabled.
+ * the caller must have ownership of the cpu FPSIMD context before calling
+ * this function.
  * task->thread.sve_state must point to at least sve_state_size(task)
  * bytes of allocated kernel memory.
  * task->thread.uw.fpsimd_state must be up to date before calling this
@@ -384,7 +432,8 @@ static void fpsimd_to_sve(struct task_struct *task)
  * task->thread.uw.fpsimd_state.
  *
  * Task can be a non-runnable task, or current.  In the latter case,
- * softirqs (and preemption) must be disabled.
+ * the caller must have ownership of the cpu FPSIMD context before calling
+ * this function.
  * task->thread.sve_state must point to at least sve_state_size(task)
  * bytes of allocated kernel memory.
  * task->thread.sve_state must be up to date before calling this function.
@@ -544,7 +593,7 @@ int sve_set_vector_length(struct task_struct *task,
 	 * non-SVE thread.
 	 */
 	if (task == current) {
-		local_bh_disable();
+		get_cpu_fpsimd_context();
 
 		fpsimd_save();
 	}
@@ -554,7 +603,7 @@ int sve_set_vector_length(struct task_struct *task,
 		sve_to_fpsimd(task);
 
 	if (task == current)
-		local_bh_enable();
+		put_cpu_fpsimd_context();
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -867,7 +916,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 
 	sve_alloc(current);
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	fpsimd_save();
 
@@ -878,7 +927,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -922,6 +971,8 @@ void fpsimd_thread_switch(struct task_struct *next)
 	if (!system_supports_fpsimd())
 		return;
 
+	__get_cpu_fpsimd_context();
+
 	/* Save unsaved fpsimd state, if any: */
 	fpsimd_save();
 
@@ -936,6 +987,8 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
 			       wrong_task || wrong_cpu);
+
+	__put_cpu_fpsimd_context();
 }
 
 void fpsimd_flush_thread(void)
@@ -945,7 +998,7 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	fpsimd_flush_task_state(current);
 	memset(&current->thread.uw.fpsimd_state, 0,
@@ -986,7 +1039,7 @@ void fpsimd_flush_thread(void)
 			current->thread.sve_vl_onexec = 0;
 	}
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -998,9 +1051,9 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 	fpsimd_save();
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -1017,7 +1070,8 @@ void fpsimd_signal_preserve_current_state(void)
 
 /*
  * Associate current's FPSIMD context with this cpu
- * Preemption must be disabled when calling this function.
+ * The caller must have ownership of the cpu FPSIMD context before calling
+ * this function.
  */
 void fpsimd_bind_task_to_cpu(void)
 {
@@ -1063,14 +1117,14 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_task_to_cpu();
 	}
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -1083,7 +1137,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	current->thread.uw.fpsimd_state = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1094,7 +1148,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 
 	clear_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -1120,7 +1174,8 @@ void fpsimd_flush_task_state(struct task_struct *t)
 
 /*
  * Invalidate any task's FPSIMD state that is present on this cpu.
- * This function must be called with softirqs disabled.
+ * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
+ * before calling this function.
  */
 static void fpsimd_flush_cpu_state(void)
 {
@@ -1130,19 +1185,19 @@ static void fpsimd_flush_cpu_state(void)
 
 /*
  * Save the FPSIMD state to memory and invalidate cpu view.
- * This function must be called with softirqs (and preemption) disabled.
+ * This function must be called with preemption disabled.
  */
 void fpsimd_save_and_flush_cpu_state(void)
 {
+	WARN_ON(preemptible());
+	__get_cpu_fpsimd_context();
 	fpsimd_save();
 	fpsimd_flush_cpu_state();
+	__put_cpu_fpsimd_context();
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
-DEFINE_PER_CPU(bool, kernel_neon_busy);
-EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
-
 /*
  * Kernel-side NEON support functions
  */
@@ -1167,19 +1222,13 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
-	local_bh_disable();
-
-	__this_cpu_write(kernel_neon_busy, true);
+	get_cpu_fpsimd_context();
 
 	/* Save unsaved fpsimd state, if any: */
 	fpsimd_save();
 
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
-
-	preempt_disable();
-
-	local_bh_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
@@ -1194,15 +1243,10 @@ EXPORT_SYMBOL(kernel_neon_begin);
  */
 void kernel_neon_end(void)
 {
-	bool busy;
-
 	if (!system_supports_fpsimd())
 		return;
 
-	busy = __this_cpu_xchg(kernel_neon_busy, false);
-	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
-
-	preempt_enable();
+	put_cpu_fpsimd_context();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
