Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4C12E12
	for <lists+kvmarm@lfdr.de>; Fri,  3 May 2019 14:46:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 07DA64A541;
	Fri,  3 May 2019 08:46:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=ham
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEPtTc8En-do; Fri,  3 May 2019 08:46:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D002B4A4A3;
	Fri,  3 May 2019 08:46:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 65C534A51A
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 May 2019 08:45:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g0eeIAgoFDqN for <kvmarm@lists.cs.columbia.edu>;
 Fri,  3 May 2019 08:45:58 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 152224A50B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 May 2019 08:45:57 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D4DC80D;
 Fri,  3 May 2019 05:45:56 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 661F63F220;
 Fri,  3 May 2019 05:45:53 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 21/56] KVM: arm/arm64: Add hook for arch-specific KVM
 initialisation
Date: Fri,  3 May 2019 13:43:52 +0100
Message-Id: <20190503124427.190206-22-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503124427.190206-1-marc.zyngier@arm.com>
References: <20190503124427.190206-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "zhang . lei" <zhang.lei@jp.fujitsu.com>, Julien Grall <julien.grall@arm.com>,
 kvmarm@lists.cs.columbia.edu, Amit Daniel Kachhap <amit.kachhap@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
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

From: Dave Martin <Dave.Martin@arm.com>

This patch adds a kvm_arm_init_arch_resources() hook to perform
subarch-specific initialisation when starting up KVM.

This will be used in a subsequent patch for global SVE-related
setup on arm64.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: zhang.lei <zhang.lei@jp.fujitsu.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 2 ++
 arch/arm64/include/asm/kvm_host.h | 2 ++
 virt/kvm/arm/arm.c                | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 770d73257ad9..a49ee01242ff 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -53,6 +53,8 @@
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
+static inline int kvm_arm_init_arch_resources(void) { return 0; }
+
 u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
 int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 205438a108f6..3e8950942591 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -58,6 +58,8 @@
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
+static inline int kvm_arm_init_arch_resources(void) { return 0; }
+
 int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
 int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 99c37384ba7b..c69e1370a5dc 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1664,6 +1664,10 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		return err;
 
+	err = kvm_arm_init_arch_resources();
+	if (err)
+		return err;
+
 	if (!in_hyp_mode) {
 		err = init_hyp_mode();
 		if (err)
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
