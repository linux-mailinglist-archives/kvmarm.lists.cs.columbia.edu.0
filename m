Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9B59631A
	for <lists+kvmarm@lfdr.de>; Tue, 16 Aug 2022 21:26:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF7A84D448;
	Tue, 16 Aug 2022 15:26:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ao6GN1KJaQyA; Tue, 16 Aug 2022 15:26:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B010E4D460;
	Tue, 16 Aug 2022 15:26:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8D314D40A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Aug 2022 15:26:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C2XC6D3opiDJ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Aug 2022 15:26:12 -0400 (EDT)
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4C2DE4D3F1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Aug 2022 15:26:12 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1660677971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbmuTT8Thj364aSLa00nQtqazgzBtF2v2Kx6kyYzOBw=;
 b=eMn54RAAvkr0YCsvIpdRpSLcn+maa4IEHzWJUjIwTdgcquAOb0mdQWHBGp9huUm7b1oVCE
 rUYt4IMzNO4cnmX8xv6qb4SSPP9db/EjVCvpVpwtDwD94SVCAMWk/JDrwIn5cMIr1IilIA
 jehNVFVcYTyPhw2+7WcTfRkbkGlXQPw=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 2/2] KVM: arm64: Reject 32bit user PSTATE on asymmetric
 systems
Date: Tue, 16 Aug 2022 19:25:54 +0000
Message-Id: <20220816192554.1455559-3-oliver.upton@linux.dev>
In-Reply-To: <20220816192554.1455559-1-oliver.upton@linux.dev>
References: <20220816192554.1455559-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: kvm@vger.kernel.org, maz@kernel.org, will@kernel.org,
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

KVM does not support AArch32 EL0 on asymmetric systems. To that end,
prevent userspace from configuring a vCPU in such a state through
setting PSTATE.

It is already ABI that KVM rejects such a write on a system where
AArch32 EL0 is unsupported. Though the kernel's definition of a 32bit
system changed in commit 2122a833316f ("arm64: Allow mismatched
32-bit EL0 support"), KVM's did not.

Fixes: 2122a833316f ("arm64: Allow mismatched 32-bit EL0 support")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 8c607199cad1..f802a3b3f8db 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -242,7 +242,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		u64 mode = (*(u64 *)valp) & PSR_AA32_MODE_MASK;
 		switch (mode) {
 		case PSR_AA32_MODE_USR:
-			if (!system_supports_32bit_el0())
+			if (!kvm_supports_32bit_el0())
 				return -EINVAL;
 			break;
 		case PSR_AA32_MODE_FIQ:
-- 
2.37.1.595.g718a3a8f04-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
