Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D123CE7B
	for <lists+kvmarm@lfdr.de>; Wed,  5 Aug 2020 20:26:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 815984B4E3;
	Wed,  5 Aug 2020 14:26:48 -0400 (EDT)
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
	with ESMTP id Se42iybO633p; Wed,  5 Aug 2020 14:26:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B92C4B45E;
	Wed,  5 Aug 2020 14:26:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 743194B463
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 14:26:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxwwTEjXy7p0 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Aug 2020 14:26:44 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EF6BB4B4C7
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 14:26:42 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 25F4F22DA7;
 Wed,  5 Aug 2020 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596652002;
 bh=rJU9FpgzL1aaH6n2FLB56Nqg0exe8hF5Av5kI/gOlgI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M9bTlWJmLFI2kNmfy7hIUe20lp7j5g4+MeB6FuINe3ZYDGX2R0MRNNorh2b8oxTld
 q6xXemIDRQJW+c76tlwdtbkg2LcJmvup+Awo20JkLUvGyift8Rr4O3IUWfrRw57IB+
 w93PYHowsxxc//x9tpgN6xRNQ6roQ+Tjl21gYDe0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k3Nfe-0004w9-1l; Wed, 05 Aug 2020 18:57:46 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 27/56] KVM: arm64: Lift instrumentation restrictions on VHE
Date: Wed,  5 Aug 2020 18:56:31 +0100
Message-Id: <20200805175700.62775-28-maz@kernel.org>
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

From: David Brazdil <dbrazdil@google.com>

With VHE and nVHE executable code completely separated, remove build config
that disabled GCOV/KASAN/UBSAN/KCOV instrumentation for VHE as these now
execute under the same memory mappings as the rest of the kernel.

No violations are currently being reported by either KASAN or UBSAN.

Signed-off-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200625131420.71444-16-dbrazdil@google.com
---
 arch/arm64/kvm/hyp/vhe/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
index 090fd1e14be2..461e97c375cc 100644
--- a/arch/arm64/kvm/hyp/vhe/Makefile
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -9,11 +9,3 @@ ccflags-y := -D__KVM_VHE_HYPERVISOR__
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
-
-# KVM code is run at a different exception code with a different map, so
-# compiler instrumentation that inserts callbacks or checks into the code may
-# cause crashes. Just disable it.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
