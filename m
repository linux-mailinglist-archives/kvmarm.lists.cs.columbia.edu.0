Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4533CA354
	for <lists+kvmarm@lfdr.de>; Thu, 15 Jul 2021 18:54:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 313E14B09C;
	Thu, 15 Jul 2021 12:54:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tY8642CmxwPX; Thu, 15 Jul 2021 12:54:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 17A734B09B;
	Thu, 15 Jul 2021 12:54:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E1CF4B090
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 12:54:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HUCJt-NSzl4U for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Jul 2021 12:54:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 737B14AEDC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 12:54:02 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A312F6128D;
 Thu, 15 Jul 2021 16:54:01 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m44Hc-00DYjr-3c; Thu, 15 Jul 2021 17:32:20 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] arm64: Register earlycon fixmap with the MMIO guard
Date: Thu, 15 Jul 2021 17:31:59 +0100
Message-Id: <20210715163159.1480168-17-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715163159.1480168-1-maz@kernel.org>
References: <20210715163159.1480168-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org, qperret@google.com,
 dbrazdil@google.com, vatsa@codeaurora.org, sdonthineni@nvidia.com,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
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

On initialising the MMIO guard infrastructure, register the
earlycon mapping if present.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/mm/ioremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index d82b63bcc554..a27b58e03c93 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -32,6 +32,18 @@ static int __init ioremap_guard_setup(char *str)
 }
 early_param("ioremap_guard", ioremap_guard_setup);
 
+static void fixup_fixmap(void)
+{
+	unsigned long addr = __fix_to_virt(FIX_EARLYCON_MEM_BASE);
+	pte_t *ptep = __get_fixmap_pte(FIX_EARLYCON_MEM_BASE);
+
+	if (!ptep)
+		return;
+
+	ioremap_page_range_hook(addr, addr + PAGE_SIZE, __pte_to_phys(*ptep),
+				__pgprot(pte_val(*ptep) & PTE_ATTRINDX_MASK));
+}
+
 void kvm_init_ioremap_services(void)
 {
 	struct arm_smccc_res res;
@@ -55,6 +67,7 @@ void kvm_init_ioremap_services(void)
 			     &res);
 	if (res.a0 == SMCCC_RET_SUCCESS) {
 		static_branch_enable(&ioremap_guard_key);
+		fixup_fixmap();
 		pr_info("Using KVM MMIO guard for ioremap\n");
 	} else {
 		pr_warn("KVM MMIO guard registration failed (%ld)\n", res.a0);
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
