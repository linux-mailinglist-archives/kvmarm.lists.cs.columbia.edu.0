Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 465103ECBFD
	for <lists+kvmarm@lfdr.de>; Mon, 16 Aug 2021 02:12:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DEF934B0B6;
	Sun, 15 Aug 2021 20:12:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7CuRCnSYdKyq; Sun, 15 Aug 2021 20:12:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14D4F4B130;
	Sun, 15 Aug 2021 20:12:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DA82B4B0EC
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Aug 2021 20:12:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRnegQBzA-Hu for <kvmarm@lists.cs.columbia.edu>;
 Sun, 15 Aug 2021 20:12:35 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C81414B0E0
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Aug 2021 20:12:28 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 d69-20020a25e6480000b02904f4a117bd74so15043388ybh.17
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Aug 2021 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=10Jw6wv5f8g0YFvtptDq44Mn28B+Ho/XFC6x/+px8Jk=;
 b=gRF2kZWPiNTNBF8rdEwFW/mIlkRiajRYjn/LV7U4oGIMEj2P6ZR+kLbq6lKxHr/tPB
 NqZgYJQILBazx5IH9eSTClPREQffNoKr35iKG/toTL+NHJRLjt7lijMDiFXf0Napejm/
 FEpzlWloHyCxhD47vxS9bfsOdtWxWShkds+RGn+WvBXuvyXlcUDzqnv76KHfenqvYNDX
 hOY2oqNHopp8fGC/+P2FNBBz4AGv3I8dR/QyXLxtu22JWqGKi0U7G6+dAcjqTwD+e0m1
 kv1qKyHInhYHJSQ+4kb7nnnTVQeTn8Pv1aLlipxmOlzEXEiGgOnQpeBf+26/5lu/lW4b
 K6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=10Jw6wv5f8g0YFvtptDq44Mn28B+Ho/XFC6x/+px8Jk=;
 b=RQm1A2otPTJbjUu8S9FkG0St+OQ2acmRzjINq33cfJ/Ei8gXH69ubDN15MePbsvfYz
 dnbT/qwRtHVMni/BfnsOUEP6G6OYWsjR3b+s1Cw47wPZYr4ltuBwRSQ3ACUA495XJDSr
 DcXCPgOFXqL9aZ1wsovCNe76gF63QGkoUmucIwDYWKxQLv+6PEnXQSR6FTbwe99wvfnJ
 EA3udi4EGA3IqikmF4EPjQ2i3Wo5k2weeNLch0BaTU47rBqrSQaCFz1bkEnFIaiMzKqD
 pHWmYg9HuTuM2HP/x43mChWSNYT2OvqujEjW0HzRfk6K6hEhGDYioEIS1WaxZuhcC36W
 lZ+w==
X-Gm-Message-State: AOAM532pHFOJzwEabrWXPxyL/E0pE5AItOt+Kbo16yJvEYkfeWKdfH1N
 u2M/bZBOQPocVtl7ubl2ogUPO883CKw=
X-Google-Smtp-Source: ABdhPJztz5C253+NtWzjQSwoelAaDfRRtU7/I5kt15U8RETLbtxIiOZ6HZ/kktZIo5RBhkz+6dG8DZtVEe4=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a25:4091:: with SMTP id
 n139mr17460918yba.425.1629072748385; 
 Sun, 15 Aug 2021 17:12:28 -0700 (PDT)
Date: Mon, 16 Aug 2021 00:12:17 +0000
In-Reply-To: <20210816001217.3063400-1-oupton@google.com>
Message-Id: <20210816001217.3063400-8-oupton@google.com>
Mime-Version: 1.0
References: <20210816001217.3063400-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v7 7/7] KVM: arm64: Emulate physical counter offsetting on
 non-ECV systems
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

Unfortunately, ECV hasn't yet arrived in any tangible hardware. At the
same time, controlling the guest view of the physical counter-timer is
useful. Support guest counter-timer offsetting on non-ECV systems by
trapping guest accesses to the physical counter-timer. Emulate reads of
the physical counter in the fast exit path.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm64/include/asm/sysreg.h         |  2 ++
 arch/arm64/kvm/arch_timer.c             | 47 +++++++++++++------------
 arch/arm64/kvm/hyp/include/hyp/switch.h | 32 +++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c      | 11 ++++--
 include/kvm/arm_arch_timer.h            |  3 ++
 5 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e02b7cd574e6..b468acf7add0 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -505,6 +505,8 @@
 #define SYS_AMEVCNTR0_MEM_STALL		SYS_AMEVCNTR0_EL0(3)
 
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
+#define SYS_CNTPCT_EL0			sys_reg(3, 3, 14, 0, 1)
+#define SYS_CNTPCTSS_EL0		sys_reg(3, 3, 14, 0, 5)
 
 #define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)
 #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 1689c2e20cd3..625762c4234f 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -51,7 +51,7 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
 static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
 			      struct arch_timer_context *timer,
 			      enum kvm_arch_timer_regs treg);
-static void kvm_timer_enable_traps_vhe(void);
+static void kvm_timer_enable_traps_vhe(struct kvm_vcpu *vcpu);
 
 u32 timer_get_ctl(struct arch_timer_context *ctxt)
 {
@@ -179,8 +179,13 @@ static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
 {
 	if (has_vhe()) {
 		map->direct_vtimer = vcpu_vtimer(vcpu);
-		map->direct_ptimer = vcpu_ptimer(vcpu);
-		map->emul_ptimer = NULL;
+		if (!ptimer_emulation_required(vcpu)) {
+			map->direct_ptimer = vcpu_ptimer(vcpu);
+			map->emul_ptimer = NULL;
+		} else {
+			map->direct_ptimer = NULL;
+			map->emul_ptimer = vcpu_ptimer(vcpu);
+		}
 	} else {
 		map->direct_vtimer = vcpu_vtimer(vcpu);
 		map->direct_ptimer = NULL;
@@ -666,7 +671,7 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
 		timer_emulate(map.emul_ptimer);
 
 	if (has_vhe())
-		kvm_timer_enable_traps_vhe();
+		kvm_timer_enable_traps_vhe(vcpu);
 }
 
 bool kvm_timer_should_notify_user(struct kvm_vcpu *vcpu)
@@ -1364,22 +1369,29 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
  * The host kernel runs at EL2 with HCR_EL2.TGE == 1,
  * and this makes those bits have no effect for the host kernel execution.
  */
-static void kvm_timer_enable_traps_vhe(void)
+static void kvm_timer_enable_traps_vhe(struct kvm_vcpu *vcpu)
 {
 	/* When HCR_EL2.E2H ==1, EL1PCEN and EL1PCTEN are shifted by 10 */
 	u32 cnthctl_shift = 10;
-	u64 val;
+	u64 val, mask;
+
+	mask = CNTHCTL_EL1PCEN << cnthctl_shift;
+	mask |= CNTHCTL_EL1PCTEN << cnthctl_shift;
 
-	/*
-	 * VHE systems allow the guest direct access to the EL1 physical
-	 * timer/counter.
-	 */
 	val = read_sysreg(cnthctl_el2);
-	val |= (CNTHCTL_EL1PCEN << cnthctl_shift);
-	val |= (CNTHCTL_EL1PCTEN << cnthctl_shift);
 
 	if (cpus_have_final_cap(ARM64_HAS_ECV2))
 		val |= CNTHCTL_ECV;
+
+	/*
+	 * VHE systems allow the guest direct access to the EL1 physical
+	 * timer/counter if offsetting isn't requested on a non-ECV system.
+	 */
+	if (ptimer_emulation_required(vcpu))
+		val &= ~mask;
+	else
+		val |= mask;
+
 	write_sysreg(val, cnthctl_el2);
 }
 
@@ -1434,9 +1446,6 @@ static int kvm_arm_timer_set_attr_offset(struct kvm_vcpu *vcpu,
 	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
 	u64 offset;
 
-	if (!cpus_have_final_cap(ARM64_HAS_ECV2))
-		return -ENXIO;
-
 	if (get_user(offset, uaddr))
 		return -EFAULT;
 
@@ -1485,9 +1494,6 @@ static int kvm_arm_timer_get_attr_offset(struct kvm_vcpu *vcpu,
 	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
 	u64 offset;
 
-	if (!cpus_have_final_cap(ARM64_HAS_ECV2))
-		return -ENXIO;
-
 	offset = timer_get_offset(vcpu_ptimer(vcpu));
 	return put_user(offset, uaddr);
 }
@@ -1511,11 +1517,8 @@ int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	switch (attr->attr) {
 	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
 	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
-		return 0;
 	case KVM_ARM_VCPU_TIMER_PHYS_OFFSET:
-		if (cpus_have_final_cap(ARM64_HAS_ECV2))
-			return 0;
-		break;
+		return 0;
 	}
 
 	return -ENXIO;
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index e4a2f295a394..71dd613438c2 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -15,6 +15,7 @@
 #include <linux/jump_label.h>
 #include <uapi/linux/psci.h>
 
+#include <kvm/arm_arch_timer.h>
 #include <kvm/arm_psci.h>
 
 #include <asm/barrier.h>
@@ -405,6 +406,34 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static inline u64 __timer_read_cntpct(struct kvm_vcpu *vcpu)
+{
+	return __arch_counter_get_cntpct() - vcpu_ptimer(vcpu)->host_offset;
+}
+
+static inline bool __hyp_handle_counter(struct kvm_vcpu *vcpu)
+{
+	u32 sysreg;
+	int rt;
+	u64 rv;
+
+	if (cpus_have_final_cap(ARM64_HAS_ECV2))
+		return false;
+
+	if (kvm_vcpu_trap_get_class(vcpu) != ESR_ELx_EC_SYS64)
+		return false;
+
+	sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
+	if (sysreg != SYS_CNTPCT_EL0 && sysreg != SYS_CNTPCTSS_EL0)
+		return false;
+
+	rt = kvm_vcpu_sys_get_rt(vcpu);
+	rv = __timer_read_cntpct(vcpu);
+	vcpu_set_reg(vcpu, rt, rv);
+	__kvm_skip_instr(vcpu);
+	return true;
+}
+
 /*
  * Return true when we were able to fixup the guest exit and should return to
  * the guest, false when we should restore the host state and return to the
@@ -439,6 +468,9 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (*exit_code != ARM_EXCEPTION_TRAP)
 		goto exit;
 
+	if (__hyp_handle_counter(vcpu))
+		goto guest;
+
 	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
 	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SYS64 &&
 	    handle_tx2_tvm(vcpu))
diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
index e98a949f5227..8c19cd42d445 100644
--- a/arch/arm64/kvm/hyp/nvhe/timer-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
@@ -46,12 +46,19 @@ void __timer_enable_traps(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Disallow physical timer access for the guest
-	 * Physical counter access is allowed
 	 */
 	val = read_sysreg(cnthctl_el2);
 	if (cpus_have_final_cap(ARM64_HAS_ECV2))
 		val |= CNTHCTL_ECV;
 	val &= ~CNTHCTL_EL1PCEN;
-	val |= CNTHCTL_EL1PCTEN;
+
+	/*
+	 * Disallow physical counter access for the guest if offsetting is
+	 * requested on a non-ECV system.
+	 */
+	if (ptimer_emulation_required(vcpu))
+		val &= ~CNTHCTL_EL1PCTEN;
+	else
+		val |= CNTHCTL_EL1PCTEN;
 	write_sysreg(val, cnthctl_el2);
 }
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 254653b42da0..13b72b5ba169 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -96,6 +96,9 @@ bool kvm_arch_timer_get_input_level(int vintid);
 
 #define arch_timer_ctx_index(ctx)	((ctx) - vcpu_timer((ctx)->vcpu)->timers)
 
+#define ptimer_emulation_required(v)	\
+	(!cpus_have_final_cap(ARM64_HAS_ECV2) && vcpu_ptimer(v)->host_offset)
+
 u64 kvm_arm_timer_read_sysreg(struct kvm_vcpu *vcpu,
 			      enum kvm_arch_timers tmr,
 			      enum kvm_arch_timer_regs treg);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
