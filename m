Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A03D42AC306
	for <lists+kvmarm@lfdr.de>; Mon,  9 Nov 2020 18:59:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AF484B9A5;
	Mon,  9 Nov 2020 12:59:37 -0500 (EST)
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
	with ESMTP id 0mLgjTNZ-Gh9; Mon,  9 Nov 2020 12:59:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF8214B979;
	Mon,  9 Nov 2020 12:59:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 94A874B905
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Nov 2020 12:59:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4AWFSxBqA3l for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Nov 2020 12:59:31 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D568F4B839
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Nov 2020 12:59:30 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C129D2068D;
 Mon,  9 Nov 2020 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604944769;
 bh=PlmXh+r1X4pO3UYVHErEci+hw9LpEvNvwhS6IdOCN3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FJbXiMxlDC+bMI/qjpViCxFKRw3yOKHOvnZs+t2y9fdEEcaPpk3XIg6HDPYt1vxsz
 7w5QOdxjME20ROoYobdFZ8PnZGmA1Dceq83NgDhDdXDNp9mkwy1yvZaW2Sq7Xu1vWK
 SXnjpVkdFmb9hSoHj/5Al7SUlK7/9MJpRcwBjVYc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kcBRv-009BQs-VE; Mon, 09 Nov 2020 17:59:28 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 1/5] KVM: arm64: Add kimg_hyp_va() helper
Date: Mon,  9 Nov 2020 17:59:19 +0000
Message-Id: <20201109175923.445945-2-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109175923.445945-1-maz@kernel.org>
References: <20201109175923.445945-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, ascull@google.com, will@kernel.org,
 qperret@google.com, ndesaulniers@google.com, dbrazdil@google.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 ndesaulniers@google.com
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

KVM/arm64 is so far unable to deal with function pointers, as the compiler
will generate the kernel's runtime VA, and not the linear mapping address,
meaning that kern_hyp_va() will give the wrong result.

We so far have been able to use PC-relative addressing, but that's not
always easy to use, and prevents the implementation of things like
the mapping of an index to a pointer.

To allow this, provide a new helper that computes the required
translation from the kernel image to the HYP VA space.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_mmu.h | 18 ++++++++++++
 arch/arm64/kvm/va_layout.c       | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 331394306cce..608c3a83e740 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -98,6 +98,24 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 
 #define kern_hyp_va(v) 	((typeof(v))(__kern_hyp_va((unsigned long)(v))))
 
+static __always_inline unsigned long __kimg_hyp_va(unsigned long v)
+{
+	unsigned long offset;
+
+	asm volatile(ALTERNATIVE_CB("movz %0, #0\n"
+				    "movk %0, #0, lsl #16\n"
+				    "movk %0, #0, lsl #32\n"
+				    "movk %0, #0, lsl #48\n",
+				    kvm_update_kimg_phys_offset)
+		     : "=r" (offset));
+
+	return __kern_hyp_va((v - offset) | PAGE_OFFSET);
+}
+
+#define kimg_fn_hyp_va(v) 	((typeof(*v))(__kimg_hyp_va((unsigned long)(v))))
+
+#define kimg_fn_ptr(x)	(typeof(x) **)(x)
+
 /*
  * We currently support using a VM-specified IPA size. For backward
  * compatibility, the default IPA size is fixed to 40bits.
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index e0404bcab019..1d00d2cb93fd 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -11,6 +11,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/kvm_mmu.h>
+#include <asm/memory.h>
 
 /*
  * The LSB of the HYP VA tag
@@ -201,3 +202,52 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
 					   AARCH64_INSN_BRANCH_NOLINK);
 	*updptr++ = cpu_to_le32(insn);
 }
+
+static void generate_mov_q(u64 val, __le32 *origptr, __le32 *updptr, int nr_inst)
+{
+	u32 insn, oinsn, rd;
+
+	BUG_ON(nr_inst != 4);
+
+	/* Compute target register */
+	oinsn = le32_to_cpu(*origptr);
+	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, oinsn);
+
+	/* movz rd, #(val & 0xffff) */
+	insn = aarch64_insn_gen_movewide(rd,
+					 (u16)val,
+					 0,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_ZERO);
+	*updptr++ = cpu_to_le32(insn);
+
+	/* movk rd, #((val >> 16) & 0xffff), lsl #16 */
+	insn = aarch64_insn_gen_movewide(rd,
+					 (u16)(val >> 16),
+					 16,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_KEEP);
+	*updptr++ = cpu_to_le32(insn);
+
+	/* movk rd, #((val >> 32) & 0xffff), lsl #32 */
+	insn = aarch64_insn_gen_movewide(rd,
+					 (u16)(val >> 32),
+					 32,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_KEEP);
+	*updptr++ = cpu_to_le32(insn);
+
+	/* movk rd, #((val >> 48) & 0xffff), lsl #48 */
+	insn = aarch64_insn_gen_movewide(rd,
+					 (u16)(val >> 48),
+					 48,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_KEEP);
+	*updptr++ = cpu_to_le32(insn);
+}
+
+void kvm_update_kimg_phys_offset(struct alt_instr *alt,
+				 __le32 *origptr, __le32 *updptr, int nr_inst)
+{
+	generate_mov_q(kimage_voffset + PHYS_OFFSET, origptr, updptr, nr_inst);
+}
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
