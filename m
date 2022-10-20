Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B634E605A95
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 11:07:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 177184B941;
	Thu, 20 Oct 2022 05:07:43 -0400 (EDT)
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
	with ESMTP id rvbHnbxja14K; Thu, 20 Oct 2022 05:07:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 187D64B94D;
	Thu, 20 Oct 2022 05:07:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 872664B955
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:07:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sCxypAp21r63 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 05:07:39 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 346B04B85F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:07:39 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5E07B61A78;
 Thu, 20 Oct 2022 09:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EAAC43141;
 Thu, 20 Oct 2022 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666256857;
 bh=ganBQ4L/dvVMWO5OFk6Mq4WiwjzqiqwYGyYnNy84GgY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PSBgjhG9z5iCoFua1qGliENNg7Tv5zYXf0LRE3jFYF1/165HMX9XCyrMBUZJE1Jko
 iavc13BmIn62XOQ2UfU3Pcw9HlAC1K12pc1/F37aVgRQeJD+3syEqDG5xnu/z6mGkY
 a465yJsKdQlO832qgAMlQsJ1aC/KZLVPb7Ren2d2oyD7myPwoX3psEMhKg54IbvgtF
 44110184sqT1ZgS4eh28xHFAqPSfZK/98b1z7YLdh83uNfYjOWfokYDTAZcj/klXLT
 eevYHKrvBmcURH9ZveBIwDYccdhuwosHiI+mA/ioACoPq0U3wg0zea8GsaT5QgI1/j
 pSVZGjqcY8Dgw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1olRWZ-000Buf-Ag;
 Thu, 20 Oct 2022 10:07:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: <kvmarm@lists.cs.columbia.edu>, <kvmarm@lists.linux.dev>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/17] arm64: Don't enable VHE for the kernel if OVERRIDE_HVHE
 is set
Date: Thu, 20 Oct 2022 10:07:13 +0100
Message-Id: <20221020090727.3669908-4-maz@kernel.org>
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

If the OVERRIDE_HVHE SW override is set (as a precursor of
the KVM_HVHE capability), do not enable VHE for the kernel
and drop to EL1 as if VHE was either disabled or unavailable.

Further changes will enable VHE at EL2 only, with the kernel
still running at EL1.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/hyp-stub.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 2ee18c860f2a..0601cc9592bd 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -157,7 +157,15 @@ SYM_CODE_START_LOCAL(__finalise_el2)
 	tbnz	x1, #0, 1f
 
 	// Needs to be VHE capable, obviously
-	check_override id_aa64mmfr1 ID_AA64MMFR1_EL1_VH_SHIFT 2f 1f
+	check_override id_aa64mmfr1 ID_AA64MMFR1_EL1_VH_SHIFT 0f 1f
+
+0:	// Check whether we only want the hypervisor to run VHE, not the kernel
+	adr_l	x1, arm64_sw_feature_override
+	ldr	x2, [x1, FTR_OVR_VAL_OFFSET]
+	ldr	x1, [x1, FTR_OVR_MASK_OFFSET]
+	and	x2, x2, x1
+	ubfx	x2, x2, #ARM64_SW_FEATURE_OVERRIDE_HVHE, #4
+	cbz	x2, 2f
 
 1:	mov_q	x0, HVC_STUB_ERR
 	eret
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
