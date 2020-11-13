Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 032312B23B7
	for <lists+kvmarm@lfdr.de>; Fri, 13 Nov 2020 19:26:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AAC874B932;
	Fri, 13 Nov 2020 13:26:26 -0500 (EST)
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
	with ESMTP id OVcBa8x43hJP; Fri, 13 Nov 2020 13:26:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14E7E4BA10;
	Fri, 13 Nov 2020 13:26:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 043AB4B84D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 13:26:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5HPSjqpQKgS for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Nov 2020 13:26:21 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2F1224B5DB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 13:26:21 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 40AA721D79;
 Fri, 13 Nov 2020 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605291980;
 bh=2mthOzpjq31upPcsVjKgfwAMzV+9ZWOKIZkykqjh+Qo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D2XSOQ7f1x7U74iQlApXK1571hyWMuapDNvFxn5Ox+7RceCDa2ij23mvfxg6Jv0Lz
 eQrMY7tfBQG+kgCrt9zyX1TKPgqy2s8bQUUBZ0M/Ib893jAi89FcSwDRC4sTuNmt8f
 Uq4SzhZmoXIbHouMW9V7dRCJmI3qeDFFeaWkglYo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kddm6-00APrY-FI; Fri, 13 Nov 2020 18:26:18 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 6/8] KVM: arm64: Remove dead PMU sysreg decoding code
Date: Fri, 13 Nov 2020 18:26:00 +0000
Message-Id: <20201113182602.471776-7-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113182602.471776-1-maz@kernel.org>
References: <20201113182602.471776-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, eric.auger@redhat.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

The handling of traps in access_pmu_evcntr() has a couple of
omminous "else return false;" statements that don't make any sense:
the decoding tree coverse all the registers that trap to this handler,
and returning false implies that we change PC, which we don't.

Get rid of what is evidently dead code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3bd4cc40536b..f878d71484d8 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -733,8 +733,6 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 				return false;
 
 			idx = ARMV8_PMU_CYCLE_IDX;
-		} else {
-			return false;
 		}
 	} else if (r->CRn == 0 && r->CRm == 9) {
 		/* PMCCNTR */
@@ -748,8 +746,6 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 			return false;
 
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
-	} else {
-		return false;
 	}
 
 	if (!pmu_counter_idx_valid(vcpu, idx))
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
