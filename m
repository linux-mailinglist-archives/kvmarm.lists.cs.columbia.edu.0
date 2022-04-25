Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 969FF50DF24
	for <lists+kvmarm@lfdr.de>; Mon, 25 Apr 2022 13:45:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19BE14B19F;
	Mon, 25 Apr 2022 07:45:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6+p+W13VZ5C; Mon, 25 Apr 2022 07:45:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E6684B131;
	Mon, 25 Apr 2022 07:45:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B2A049EBE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Apr 2022 07:45:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8sdISRZiNP6u for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Apr 2022 07:44:59 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 48E3A49E1E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Apr 2022 07:44:59 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7F1ED1;
 Mon, 25 Apr 2022 04:44:57 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119C13F73B;
 Mon, 25 Apr 2022 04:44:55 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, mark.rutland@arm.com
Subject: [PATCH v3 1/5] arm64: Make ESR_ELx_xVC_IMM_MASK compatible with
 assembly
Date: Mon, 25 Apr 2022 12:44:40 +0100
Message-Id: <20220425114444.368693-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220425114444.368693-1-alexandru.elisei@arm.com>
References: <20220425114444.368693-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

ESR_ELx_xVC_IMM_MASK is used as a mask for the immediate value for the
HVC/SMC instructions. The header file is included by assembly files (like
entry.S) and ESR_ELx_xVC_IMM_MASK is not conditioned on __ASSEMBLY__ being
undefined. Use the UL() macro for defining the constant's size, as that is
compatible with both C code and assembly, whereas the UL suffix only works
for C code.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/esr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index d52a0b269ee8..7356e2f05755 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -136,7 +136,7 @@
 #define ESR_ELx_WFx_ISS_TI	(UL(1) << 0)
 #define ESR_ELx_WFx_ISS_WFI	(UL(0) << 0)
 #define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
-#define ESR_ELx_xVC_IMM_MASK	((1UL << 16) - 1)
+#define ESR_ELx_xVC_IMM_MASK	((UL(1) << 16) - 1)
 
 #define DISR_EL1_IDS		(UL(1) << 24)
 /*
-- 
2.36.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
