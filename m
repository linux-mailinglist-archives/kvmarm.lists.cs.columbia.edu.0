Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3B4E424
	for <lists+kvmarm@lfdr.de>; Fri, 21 Jun 2019 11:40:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 269174A52F;
	Fri, 21 Jun 2019 05:40:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wiFijdLE-aYz; Fri, 21 Jun 2019 05:40:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D88844A55B;
	Fri, 21 Jun 2019 05:40:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B22B4A1FA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Jun 2019 05:40:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLKQwZnR8rY4 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Jun 2019 05:40:27 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 83E924A55C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Jun 2019 05:40:26 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 406811478;
 Fri, 21 Jun 2019 02:40:26 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0F293F246;
 Fri, 21 Jun 2019 02:40:24 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 47/59] KVM: arm64: nv: Propagate CNTVOFF_EL2 to the virtual
 EL1 timer
Date: Fri, 21 Jun 2019 10:38:31 +0100
Message-Id: <20190621093843.220980-48-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621093843.220980-1-marc.zyngier@arm.com>
References: <20190621093843.220980-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>
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

We need to allow a guest hypervisor to virtualize the virtual timer.
FOr that, let's propagate CNTVOFF_EL2 to the guest's view of that
timer.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/sys_regs.c         |  8 ++++++--
 include/kvm/arm_arch_timer.h      |  1 +
 virt/kvm/arm/arch_timer.c         | 12 ++++++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b7c44adcdbf3..e0fe9acb46bf 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -252,7 +252,6 @@ enum vcpu_sysreg {
 	RMR_EL2,	/* Reset Management Register */
 	CONTEXTIDR_EL2,	/* Context ID Register (EL2) */
 	TPIDR_EL2,	/* EL2 Software Thread ID Register */
-	CNTVOFF_EL2,	/* Counter-timer Virtual Offset register */
 	CNTHCTL_EL2,	/* Counter-timer Hypervisor Control register */
 	SP_EL2,		/* EL2 Stack Pointer */
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1b8016330a19..2031a59fcf49 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -150,7 +150,6 @@ struct el2_sysreg_map {
 	PURE_EL2_SYSREG( RVBAR_EL2 ),
 	PURE_EL2_SYSREG( RMR_EL2 ),
 	PURE_EL2_SYSREG( TPIDR_EL2 ),
-	PURE_EL2_SYSREG( CNTVOFF_EL2 ),
 	PURE_EL2_SYSREG( CNTHCTL_EL2 ),
 	PURE_EL2_SYSREG( HPFAR_EL2 ),
 	EL2_SYSREG(      SCTLR_EL2,  SCTLR_EL1,      translate_sctlr ),
@@ -1351,6 +1350,11 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
 		tmr = TIMER_PTIMER;
 		treg = TIMER_REG_CVAL;
 		break;
+	case SYS_CNTVOFF_EL2:
+		tmr = TIMER_VTIMER;
+		treg = TIMER_REG_VOFF;
+		break;
+
 	default:
 		BUG();
 	}
@@ -2122,7 +2126,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CONTEXTIDR_EL2), access_rw, reset_val, CONTEXTIDR_EL2, 0 },
 	{ SYS_DESC(SYS_TPIDR_EL2), access_rw, reset_val, TPIDR_EL2, 0 },
 
-	{ SYS_DESC(SYS_CNTVOFF_EL2), access_rw, reset_val, CNTVOFF_EL2, 0 },
+	{ SYS_DESC(SYS_CNTVOFF_EL2), access_arch_timer },
 	{ SYS_DESC(SYS_CNTHCTL_EL2), access_rw, reset_val, CNTHCTL_EL2, 0 },
 
 	{ SYS_DESC(SYS_CNTHP_TVAL_EL2), access_arch_timer },
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 3a5d9255120e..3389606f3029 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -23,6 +23,7 @@ enum kvm_arch_timer_regs {
 	TIMER_REG_CVAL,
 	TIMER_REG_TVAL,
 	TIMER_REG_CTL,
+	TIMER_REG_VOFF,
 };
 
 struct arch_timer_context {
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 3d84c240071d..1d53352c7d97 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -913,6 +913,10 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
 		val = kvm_phys_timer_read() - timer->cntvoff;
 		break;
 
+	case TIMER_REG_VOFF:
+		val = timer->cntvoff;
+		break;
+
 	default:
 		BUG();
 	}
@@ -955,6 +959,10 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
 		timer->cnt_cval = val;
 		break;
 
+	case TIMER_REG_VOFF:
+		timer->cntvoff = val;
+		break;
+
 	default:
 		BUG();
 	}
@@ -1166,6 +1174,10 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	}
 
+	/* Nested virtualization requires zero offset for virtual EL2 */
+	if (nested_virt_in_use(vcpu))
+		vcpu_vtimer(vcpu)->cntvoff = 0;
+
 	get_timer_map(vcpu, &map);
 
 	ret = kvm_vgic_map_phys_irq(vcpu,
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
