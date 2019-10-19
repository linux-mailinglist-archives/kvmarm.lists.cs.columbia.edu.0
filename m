Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C930DD7CB
	for <lists+kvmarm@lfdr.de>; Sat, 19 Oct 2019 11:55:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 323154AA93;
	Sat, 19 Oct 2019 05:55:45 -0400 (EDT)
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
	with ESMTP id 8OZXSFp2P1oK; Sat, 19 Oct 2019 05:55:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44DFA4AAA3;
	Sat, 19 Oct 2019 05:55:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 603624AA76
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 05:55:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7w8-3gzSEjzd for <kvmarm@lists.cs.columbia.edu>;
 Sat, 19 Oct 2019 05:55:42 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5E1E24AA5F
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 05:55:42 -0400 (EDT)
Received: from big-swifty.lan (78.163-31-62.static.virginmediabusiness.co.uk
 [62.31.163.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4010F222C2;
 Sat, 19 Oct 2019 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571478941;
 bh=NIhQTmaSfZdOFxlsYacZmWRGnEWsqvAAqOXU5n1fBjc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2Ke1oSPhBBMSE/PKuHl0F96K39z/y/L2tu7iwYUo/hIR0eOS9mV/NP7807EKmNR7j
 hcCy70w0ARPX++VLoxQv+SMqs5Gk/oECK0KwHPRMSI3SZ2C+hhJGJZXimwyPPR86tS
 yGoynaIh12/EeSYLwt8Nzb6h2ZD/8fku07bANjmA=
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: Enable and document ARM errata 1319367 and
 1319537
Date: Sat, 19 Oct 2019 10:55:21 +0100
Message-Id: <20191019095521.31722-6-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191019095521.31722-1-maz@kernel.org>
References: <20191019095521.31722-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

Now that everything is in place, let's get the ball rolling
by allowing the corresponding config option to be selected.
Also add the required information to silicon_errata.rst.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  4 ++++
 arch/arm64/Kconfig                     | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 17ea3fecddaa..0808be134fce 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -70,8 +70,12 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A57      | #1319537        | ARM64_ERRATUM_1319367       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A72      | #853709         | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A72      | #1319367        | ARM64_ERRATUM_1319367       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 950a56b71ff0..b2877ed09307 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -538,6 +538,16 @@ config ARM64_ERRATUM_1286807
 	  invalidated has been observed by other observers. The
 	  workaround repeats the TLBI+DSB operation.
 
+config ARM64_ERRATUM_1319367
+	bool "Cortex-A57/A72: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
+	default y
+	help
+	  This option adds work arounds for ARM Cortex-A57 erratum 1319537
+	  and A72 erratum 1319367
+
+	  Cortex-A57 and A72 cores could end-up with corrupted TLBs by
+	  speculating an AT instruction during a guest context switch.
+
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_1463225
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
