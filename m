Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1347149CE71
	for <lists+kvmarm@lfdr.de>; Wed, 26 Jan 2022 16:32:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B37CA49F22;
	Wed, 26 Jan 2022 10:32:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LdD3TBEqB2Bi; Wed, 26 Jan 2022 10:32:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 885894B089;
	Wed, 26 Jan 2022 10:32:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7775749EF6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 10:32:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jd-Ub8pBriTH for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jan 2022 10:32:12 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2DA7D49EC1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 10:32:12 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B79BB618DF;
 Wed, 26 Jan 2022 15:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C546BC340EB;
 Wed, 26 Jan 2022 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643211131;
 bh=QxDCYADgLO7Ate8OqAbdluQUXHUE34NK/8kXtjiy66A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ruhfDAiptp/l4WSXtZ/9zaH3eE7/YKsRBj6nR9cwIjzxOkdmqrcFwKhk08RTCshHE
 Jt6NbkkYBlDc6tKqgiU8vtiiS91gaebuGrHjPsa19vf3QY1sEof12rVbaEkW3UOLVV
 GGrfoI2XiE+fWx8Yj62msmbe9pEwc0c8tKdL0EjzAUAmCJICYpSbRollHQfozQTeSn
 DUxsAfLAiX1hpNl4D0oJUz8XIsE0EHbJi9AEvxUZI13j+kKAMhU6RZJRfSU7uyIdmM
 yV9ZdXgQOMV/aPcqtV8KF0EK7t0AhDSatE+LR5ZJiXsn5p1wbWkguvQn/lT4BkD748
 2YplrXajXx6gA==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v10 28/39] arm64/sme: Provide Kconfig for SME
Date: Wed, 26 Jan 2022 15:27:38 +0000
Message-Id: <20220126152749.233712-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject;
 bh=QxDCYADgLO7Ate8OqAbdluQUXHUE34NK/8kXtjiy66A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhrO5EXNCblah8mNd3crJRe3Ue7ZJ3oWFjj+/Wo
 dCuJNvuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoawAKCRAk1otyXVSH0N3kB/
 9w+4ocZurSxUgsZ5hQu6vXtEsVAEoTvfbppnFj3oBcLsPtkLmVKebnorzoL2Mth3mEF50y0127LNZ8
 vSeQZSJ1lG3NIb1ersSEVrwZvZWNAZrJt//5yLeDemEuUk6UIiTPQH58t7C7jw0MlvzOFKYVXVWFVQ
 +HFqN9Y5AU8AWZDmJbwUHz9lU0S38cup/6MgRKbwApgE1TaC8h7sSWW8x5Dz2jBZJ3b7MULpY4hK2H
 nhvCtLEql30g3jqbgNRQeiBGvBHyyv6xqnn0PJ18L28MfKyFoZ/CvrNTYxLcCkWECJxN6ykzuFmRgP
 jxHsdKr1v8+Mbu78e8s7559jzRB6jT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

Now that basline support for the Scalable Matrix Extension (SME) is present
introduce the Kconfig option allowing it to be built. While the feature
registers don't impose a strong requirement for a system with SME to
support SVE at runtime the support for streaming mode SVE is mostly
shared with normal SVE so depend on SVE.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6978140edfa4..f60f3b04ddf5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1839,6 +1839,17 @@ config ARM64_SVE
 	  booting the kernel.  If unsure and you are not observing these
 	  symptoms, you should assume that it is safe to say Y.
 
+config ARM64_SME
+	bool "ARM Scalable Matrix Extension support"
+	default y
+	depends on ARM64_SVE
+	help
+	  The Scalable Matrix Extension (SME) is an extension to the AArch64
+	  execution state which utilises a substantial subset of the SVE
+	  instruction set, together with the addition of new architectural
+	  register state capable of holding two dimensional matrix tiles to
+	  enable various matrix operations.
+
 config ARM64_MODULE_PLTS
 	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	depends on MODULES
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
