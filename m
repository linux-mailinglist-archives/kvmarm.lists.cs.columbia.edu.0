Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA3644534
	for <lists+kvmarm@lfdr.de>; Tue,  6 Dec 2022 15:00:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AC4E4B3F9;
	Tue,  6 Dec 2022 09:00:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tt29TibCB5KT; Tue,  6 Dec 2022 09:00:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ABFE54B62A;
	Tue,  6 Dec 2022 09:00:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8987C4B3E8
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Dec 2022 09:00:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3yRV2VsUfHi for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Dec 2022 09:00:10 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EE3AB4B5F1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Dec 2022 09:00:04 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD37D6E;
 Tue,  6 Dec 2022 06:00:11 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com
 [10.1.196.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98973F73D;
 Tue,  6 Dec 2022 06:00:02 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 01/12] arm64/mm: Add FEAT_LPA2 specific
 ID_AA64MMFR0.TGRAN[2]
Date: Tue,  6 Dec 2022 13:59:19 +0000
Message-Id: <20221206135930.3277585-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206135930.3277585-1-ryan.roberts@arm.com>
References: <20221206135930.3277585-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Cc: kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

From: Anshuman Khandual <anshuman.khandual@arm.com>

PAGE_SIZE support is tested against possible minimum and maximum values for
its respective ID_AA64MMFR0.TGRAN field, depending on whether it is signed
or unsigned. But then FEAT_LPA2 implementation needs to be validated for 4K
and 16K page sizes via feature specific ID_AA64MMFR0.TGRAN values. Hence it
adds FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2] values per ARM ARM (0487G.A).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7d301700d1a9..9ad8172eea58 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -673,10 +673,12 @@
 
 /* id_aa64mmfr0 */
 #define ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN	0x0
+#define ID_AA64MMFR0_EL1_TGRAN4_LPA2		ID_AA64MMFR0_EL1_TGRAN4_52_BIT
 #define ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX	0x7
 #define ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN	0x0
 #define ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX	0x7
 #define ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN	0x1
+#define ID_AA64MMFR0_EL1_TGRAN16_LPA2		ID_AA64MMFR0_EL1_TGRAN16_52_BIT
 #define ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX	0xf
 
 #define ARM64_MIN_PARANGE_BITS		32
@@ -684,6 +686,7 @@
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_DEFAULT	0x0
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_NONE		0x1
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_MIN		0x2
+#define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_LPA2		0x3
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_MAX		0x7
 
 #ifdef CONFIG_ARM64_PA_BITS_52
@@ -800,11 +803,13 @@
 
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_EL1_TGRAN_SHIFT		ID_AA64MMFR0_EL1_TGRAN4_SHIFT
+#define ID_AA64MMFR0_EL1_TGRAN_LPA2		ID_AA64MMFR0_EL1_TGRAN4_52_BIT
 #define ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN
 #define ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX
 #define ID_AA64MMFR0_EL1_TGRAN_2_SHIFT		ID_AA64MMFR0_EL1_TGRAN4_2_SHIFT
 #elif defined(CONFIG_ARM64_16K_PAGES)
 #define ID_AA64MMFR0_EL1_TGRAN_SHIFT		ID_AA64MMFR0_EL1_TGRAN16_SHIFT
+#define ID_AA64MMFR0_EL1_TGRAN_LPA2		ID_AA64MMFR0_EL1_TGRAN16_52_BIT
 #define ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN
 #define ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX
 #define ID_AA64MMFR0_EL1_TGRAN_2_SHIFT		ID_AA64MMFR0_EL1_TGRAN16_2_SHIFT
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
