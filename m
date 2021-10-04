Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B74215AF
	for <lists+kvmarm@lfdr.de>; Mon,  4 Oct 2021 19:56:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02EA14B26B;
	Mon,  4 Oct 2021 13:56:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7h8959VJZzS; Mon,  4 Oct 2021 13:56:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2E5F4B2A1;
	Mon,  4 Oct 2021 13:56:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 380774B2A5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Oct 2021 13:56:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZYdHDIECxdN8 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Oct 2021 13:56:53 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4E3D24B268
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Oct 2021 13:56:53 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2DCF6115C;
 Mon,  4 Oct 2021 17:56:52 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mXS5H-00EhBv-45; Mon, 04 Oct 2021 18:49:03 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/16] firmware/smccc: Call arch-specific hook on
 discovering KVM services
Date: Mon,  4 Oct 2021 18:48:44 +0100
Message-Id: <20211004174849.2831548-12-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004174849.2831548-1-maz@kernel.org>
References: <20211004174849.2831548-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org, qperret@google.com,
 dbrazdil@google.com, steven.price@arm.com, drjones@redhat.com,
 tabba@google.com, vatsa@codeaurora.org, sdonthineni@nvidia.com,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
 Steven Price <steven.price@arm.com>,
 Shanker R Donthineni <sdonthineni@nvidia.com>, will@kernel.org
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

arm64 will soon require its own callback to initialise services
that are only availably on this architecture. Introduce a hook
that can be overloaded by the architecture.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/hypervisor.h   | 1 +
 arch/arm64/include/asm/hypervisor.h | 1 +
 drivers/firmware/smccc/kvm_guest.c  | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/hypervisor.h b/arch/arm/include/asm/hypervisor.h
index bd61502b9715..8133c8c81a35 100644
--- a/arch/arm/include/asm/hypervisor.h
+++ b/arch/arm/include/asm/hypervisor.h
@@ -6,5 +6,6 @@
 
 void kvm_init_hyp_services(void);
 bool kvm_arm_hyp_service_available(u32 func_id);
+void kvm_arm_init_hyp_services(void);
 
 #endif
diff --git a/arch/arm64/include/asm/hypervisor.h b/arch/arm64/include/asm/hypervisor.h
index 0ae427f352c8..8e77f411903f 100644
--- a/arch/arm64/include/asm/hypervisor.h
+++ b/arch/arm64/include/asm/hypervisor.h
@@ -6,5 +6,6 @@
 
 void kvm_init_hyp_services(void);
 bool kvm_arm_hyp_service_available(u32 func_id);
+void kvm_arm_init_hyp_services(void);
 
 #endif
diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
index 2d3e866decaa..56169e73252a 100644
--- a/drivers/firmware/smccc/kvm_guest.c
+++ b/drivers/firmware/smccc/kvm_guest.c
@@ -9,6 +9,8 @@
 
 #include <asm/hypervisor.h>
 
+void __weak kvm_arm_init_hyp_services(void) {}
+
 static DECLARE_BITMAP(__kvm_arm_hyp_services, ARM_SMCCC_KVM_NUM_FUNCS) __ro_after_init = { };
 
 void __init kvm_init_hyp_services(void)
@@ -38,6 +40,8 @@ void __init kvm_init_hyp_services(void)
 
 	pr_info("hypervisor services detected (0x%08lx 0x%08lx 0x%08lx 0x%08lx)\n",
 		 res.a3, res.a2, res.a1, res.a0);
+
+	kvm_arm_init_hyp_services();
 }
 
 bool kvm_arm_hyp_service_available(u32 func_id)
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
