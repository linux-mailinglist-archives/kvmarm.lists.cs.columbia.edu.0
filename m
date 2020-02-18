Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB416311D
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 20:59:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 671824AFBE;
	Tue, 18 Feb 2020 14:59:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0mPaMYveHLa; Tue, 18 Feb 2020 14:59:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E85EC4AF9E;
	Tue, 18 Feb 2020 14:59:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 251AA4AED9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 14:59:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E3eHXc2eY52x for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 14:59:32 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DC724AF8F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 14:59:32 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88DEFEC;
 Tue, 18 Feb 2020 11:59:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BF623F68F;
 Tue, 18 Feb 2020 11:59:31 -0800 (PST)
From: Mark Brown <broonie@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 17/18] arm64: vdso: Convert to modern assembler annotations
Date: Tue, 18 Feb 2020 19:58:41 +0000
Message-Id: <20200218195842.34156-18-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218195842.34156-1-broonie@kernel.org>
References: <20200218195842.34156-1-broonie@kernel.org>
MIME-Version: 1.0
Cc: Mark Brown <broonie@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
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

In an effort to clarify and simplify the annotation of assembly
functions new macros have been introduced. These replace ENTRY and
ENDPROC with two different annotations for normal functions and those
with unusual calling conventions. Convert the assembly function in the
arm64 VDSO to the new macros.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/vdso/sigreturn.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/sigreturn.S b/arch/arm64/kernel/vdso/sigreturn.S
index 0723aa398d6e..12324863d5c2 100644
--- a/arch/arm64/kernel/vdso/sigreturn.S
+++ b/arch/arm64/kernel/vdso/sigreturn.S
@@ -14,7 +14,7 @@
 	.text
 
 	nop
-ENTRY(__kernel_rt_sigreturn)
+SYM_FUNC_START(__kernel_rt_sigreturn)
 	.cfi_startproc
 	.cfi_signal_frame
 	.cfi_def_cfa	x29, 0
@@ -23,4 +23,4 @@ ENTRY(__kernel_rt_sigreturn)
 	mov	x8, #__NR_rt_sigreturn
 	svc	#0
 	.cfi_endproc
-ENDPROC(__kernel_rt_sigreturn)
+SYM_FUNC_END(__kernel_rt_sigreturn)
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
