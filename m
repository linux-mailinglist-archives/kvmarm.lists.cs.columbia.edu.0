Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA589605AA6
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 11:07:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 53DC34B8E0;
	Thu, 20 Oct 2022 05:07:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iYKt3drck00L; Thu, 20 Oct 2022 05:07:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C20554B973;
	Thu, 20 Oct 2022 05:07:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A2414B950
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:07:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5NoMKOZbsjz9 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 05:07:41 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CF05C4B955
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:07:40 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D9348B826B6;
 Thu, 20 Oct 2022 09:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28722C43145;
 Thu, 20 Oct 2022 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666256858;
 bh=AJXnFfTHgaOIMDoL81dQKVsT/QCJ6Az/cdXDIO/Qq20=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MMZ25dusFB6tZJVV58+o5S++NtAaPdP5MYayJ/K5Wrz6enFli4winVFR0U38W/7KX
 VaOSPvnXSMWNr4NZH+IPHzAZmIrgYTsnEYP3wYEQiEhx56BwC1j5D0liXRVbnQFskh
 kBmhsxVwO3rNRmKwJcFdbJeq/OVtF9AmC8Q7Ig/rdNGdwN9DPQEomvFwjmjqw/ctCm
 IrCArnYS/EGsswAngYNdEhSyngrGe0hOBkoypAC+x7k7mq/AFZHSB0ep7n65N920RR
 Gw47IwMcpOyvM1jEwFIKRkToMejzJtXE1Ae5TxxHpjMIIunZvoY66vnS2pw8MBkRLP
 gvtziUEdCvZxw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1olRWa-000Buf-4P;
 Thu, 20 Oct 2022 10:07:36 +0100
From: Marc Zyngier <maz@kernel.org>
To: <kvmarm@lists.cs.columbia.edu>, <kvmarm@lists.linux.dev>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/17] arm64: Use CPACR_EL1 format to set CPTR_EL2 when E2H is
 set
Date: Thu, 20 Oct 2022 10:07:16 +0100
Message-Id: <20221020090727.3669908-7-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020090727.3669908-1-maz@kernel.org>
References: <20221020090727.3669908-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 qperret@google.com, will@kernel.org, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>
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

When HCR_EL2.E2H is set, the CPTR_EL2 register takes the CPACR_EL1
format. Yes, this is good fun.

Hack the bits of startup code that assume E2H=0 while setting up
CPTR_EL2 to make them grok the CPTR_EL1 format.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 11 +++++++++--
 arch/arm64/kernel/hyp-stub.S       | 11 +++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index fa1045f709bb..605ff1a482db 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -129,8 +129,15 @@
 .endm
 
 /* Coprocessor traps */
-.macro __init_el2_nvhe_cptr
+.macro __init_el2_cptr
+	mrs	x1, hcr_el2
+	and	x1, x1, #HCR_E2H
+	cbz	x1, .LnVHE_\@
+	mov	x0, #(CPACR_EL1_FPEN_EL1EN | CPACR_EL1_FPEN_EL0EN)
+	b	.Lset_cptr_\@
+.LnVHE_\@:
 	mov	x0, #0x33ff
+.Lset_cptr_\@:
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
 .endm
 
@@ -196,7 +203,7 @@
 	__init_el2_gicv3
 	__init_el2_hstr
 	__init_el2_nvhe_idregs
-	__init_el2_nvhe_cptr
+	__init_el2_cptr
 	__init_el2_fgt
 	__init_el2_nvhe_prepare_eret
 .endm
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 0601cc9592bd..7d2f24ae8c98 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -102,7 +102,18 @@ SYM_CODE_START_LOCAL(__finalise_el2)
 
 .Linit_sve:	/* SVE register access */
 	mrs	x0, cptr_el2			// Disable SVE traps
+
+	mrs	x1, hcr_el2
+	and	x1, x1, #HCR_E2H
+	cbz	x1, .Lcptr_nvhe
+
+	// VHE case
+	orr	x0, x0, #(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
+	b	.Lset_cptr
+
+.Lcptr_nvhe: // nVHE case
 	bic	x0, x0, #CPTR_EL2_TZ
+.Lset_cptr:
 	msr	cptr_el2, x0
 	isb
 	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
