Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1026E160591
	for <lists+kvmarm@lfdr.de>; Sun, 16 Feb 2020 19:53:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B81BF4AF1F;
	Sun, 16 Feb 2020 13:53:45 -0500 (EST)
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
	with ESMTP id YsOmaL6sT+PI; Sun, 16 Feb 2020 13:53:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE29F4AF31;
	Sun, 16 Feb 2020 13:53:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EE104AF18
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Feb 2020 13:53:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8P7bws+ZRlED for <kvmarm@lists.cs.columbia.edu>;
 Sun, 16 Feb 2020 13:53:41 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9D8D54AF1B
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Feb 2020 13:53:41 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C62B522522;
 Sun, 16 Feb 2020 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581879220;
 bh=h8Q7AtQVzmQQIR2f94c+ic8PYd9dsaAo6eI6biKkE0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PAaV4yNPdtB97Yr6J92OyDUgth9fPR+izVYUFK6bhaKUOxkAq/IBwhgSP7ZMs8Pbj
 DlwVxMT3KAAp4bQ3s1C43Ekf+DWLBwL5moZ47VM3BrCqu/il0mLwsxqxX61osfrVFE
 3Jfbqbp2KoXGVE582184Oeazi8eGsSz2Xf0CXmCQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j3P2x-005iWD-57; Sun, 16 Feb 2020 18:53:39 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 3/5] kvm: arm64: Limit PMU version to ARMv8.1
Date: Sun, 16 Feb 2020 18:53:22 +0000
Message-Id: <20200216185324.32596-4-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216185324.32596-1-maz@kernel.org>
References: <20200216185324.32596-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, peter.maydell@linaro.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

Our PMU code is only implementing the ARMv8.1 features, so let's
stick to this when reporting the feature set to the guest.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 682fedd7700f..06b2d0dc6c73 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1093,6 +1093,11 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 				 FEATURE(ID_AA64ISAR1_GPA) |
 				 FEATURE(ID_AA64ISAR1_GPI));
 		break;
+	case SYS_ID_AA64DFR0_EL1:
+		/* Limit PMU to ARMv8.1 */
+		val &= ~FEATURE(ID_AA64DFR0_PMUVER);
+		val |= FIELD_PREP(FEATURE(ID_AA64DFR0_PMUVER), 4);
+		break;
 	}
 
 	return val;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
