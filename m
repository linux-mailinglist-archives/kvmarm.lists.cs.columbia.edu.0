Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C7D3C23CE8A
	for <lists+kvmarm@lfdr.de>; Wed,  5 Aug 2020 20:27:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B5864B642;
	Wed,  5 Aug 2020 14:27:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QB8T7kJrpAZ2; Wed,  5 Aug 2020 14:27:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5AEA4B66F;
	Wed,  5 Aug 2020 14:27:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D9A004B480
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 14:27:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fxub3DL+2yTT for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Aug 2020 14:27:08 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 38D844B616
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 14:27:05 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 673B322E03;
 Wed,  5 Aug 2020 18:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596652024;
 bh=eQ276HpROXTZRcJ8dzk/lIWxDUagJcK2wT54NS6BYfw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mDGokrIvFXdLwvG4Hy+22RxZcpnYY1HPGdMlBctI91EvpCWbkbkzD/kupSbGMHGct
 QR7FCbd9FiDYO+KkQjvzR3ADI6dBFW7AgIb2jXFuNuMfHnBsFiu4VvdT15QxkcA27l
 HZdXJK5Cpl3ADP4lXsLxctFMPPMxiNe3GtHimnhA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k3NfS-0004w9-St; Wed, 05 Aug 2020 18:57:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 19/56] KVM: arm64: Move hyp-init.S to nVHE
Date: Wed,  5 Aug 2020 18:56:23 +0100
Message-Id: <20200805175700.62775-20-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805175700.62775-1-maz@kernel.org>
References: <20200805175700.62775-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, graf@amazon.com,
 alexandru.elisei@arm.com, ascull@google.com, catalin.marinas@arm.com,
 christoffer.dall@arm.com, dbrazdil@google.com, eric.auger@redhat.com,
 gshan@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
 richard.peng@oppo.com, qperret@google.com, will@kernel.org,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Peng Hao <richard.peng@oppo.com>, kernel-team@android.com,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Alexander Graf <graf@amazon.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

From: Andrew Scull <ascull@google.com>

hyp-init.S contains the identity mapped initialisation code for the
non-VHE code that runs at EL2. It is only used for non-VHE.

Adjust code that calls into this to use the prefixed symbol name.

Signed-off-by: Andrew Scull <ascull@google.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200625131420.71444-8-dbrazdil@google.com
---
 arch/arm64/include/asm/kvm_asm.h         | 5 ++---
 arch/arm64/kernel/image-vars.h           | 9 ++++++---
 arch/arm64/kvm/Makefile                  | 2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile         | 2 +-
 arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S | 0
 5 files changed, 10 insertions(+), 8 deletions(-)
 rename arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S (100%)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6026cbd204ae..3476abb046e3 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -78,10 +78,9 @@
 struct kvm;
 struct kvm_vcpu;
 
-extern char __kvm_hyp_init[];
-extern char __kvm_hyp_init_end[];
-
+DECLARE_KVM_NVHE_SYM(__kvm_hyp_init);
 DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
+#define __kvm_hyp_init		CHOOSE_NVHE_SYM(__kvm_hyp_init)
 #define __kvm_hyp_vector	CHOOSE_HYP_SYM(__kvm_hyp_vector)
 
 #ifdef CONFIG_KVM_INDIRECT_VECTORS
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index f28da486b75a..63186c91b614 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -71,9 +71,6 @@ KVM_NVHE_ALIAS(__guest_exit);
 KVM_NVHE_ALIAS(abort_guest_exit_end);
 KVM_NVHE_ALIAS(abort_guest_exit_start);
 
-/* Symbols defined in hyp-init.S (not yet compiled with nVHE build rules). */
-KVM_NVHE_ALIAS(__kvm_handle_stub_hvc);
-
 /* Symbols defined in switch.c (not yet compiled with nVHE build rules). */
 KVM_NVHE_ALIAS(__kvm_vcpu_run_nvhe);
 KVM_NVHE_ALIAS(hyp_panic);
@@ -113,6 +110,12 @@ KVM_NVHE_ALIAS(kimage_voffset);
 /* Kernel symbols used to call panic() from nVHE hyp code (via ERET). */
 KVM_NVHE_ALIAS(panic);
 
+/* Vectors installed by hyp-init on reset HVC. */
+KVM_NVHE_ALIAS(__hyp_stub_vectors);
+
+/* IDMAP TCR_EL1.T0SZ as computed by the EL1 init code */
+KVM_NVHE_ALIAS(idmap_t0sz);
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 8d3d9513cbfe..152d8845a1a2 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_KVM) += hyp/
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o \
 	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
-	 inject_fault.o regmap.o va_layout.o hyp.o hyp-init.o handle_exit.o \
+	 inject_fault.o regmap.o va_layout.o hyp.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o sys_regs_generic_v8.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
 	 aarch32.o arch_timer.o \
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 79eb8eed96a1..bf2d8dea5400 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,7 +6,7 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
-obj-y := ../hyp-entry.o
+obj-y := hyp-init.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
similarity index 100%
rename from arch/arm64/kvm/hyp-init.S
rename to arch/arm64/kvm/hyp/nvhe/hyp-init.S
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
