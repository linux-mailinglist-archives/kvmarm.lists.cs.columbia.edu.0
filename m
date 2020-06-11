Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B81F6450
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jun 2020 11:10:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B56E4B1C5;
	Thu, 11 Jun 2020 05:10:16 -0400 (EDT)
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
	with ESMTP id htxfs2NPenUl; Thu, 11 Jun 2020 05:10:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E84754B196;
	Thu, 11 Jun 2020 05:10:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 587B14B1A1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jun 2020 05:10:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2phGnlNRtfiZ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jun 2020 05:10:11 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 496EB4B197
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jun 2020 05:10:11 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 77CE2207ED;
 Thu, 11 Jun 2020 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591866610;
 bh=Em4/jIjhjqpTahQChLRnGzJ5UpaAk8Yvip8fJLBOHrg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hBWfe1Szo0ax7lAYon9w3gkQkV0g14c+k9O8LW4Lr2k6UWdQZwWpELgLNO8KzGE8i
 eQBRUF+JFHuHTPuMpTMPmCNNr0rabNBpqle5cR3eA1TKehix7ltQeyS3mL5ehEi5/c
 PmTLd7l1D7NcCA0ZA2M7AiIsxtDgBeQkKy8sWISo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jjJDt-0022ZT-2G; Thu, 11 Jun 2020 10:10:09 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 03/11] KVM: arm64: Add emulation for 32bit guests accessing
 ACTLR2
Date: Thu, 11 Jun 2020 10:09:48 +0100
Message-Id: <20200611090956.1537104-4-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611090956.1537104-1-maz@kernel.org>
References: <20200611090956.1537104-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 ascull@google.com, james.morse@arm.com, mark.rutland@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

From: James Morse <james.morse@arm.com>

ACTLR_EL1 is a 64bit register while the 32bit ACTLR is obviously 32bit.
For 32bit software, the extra bits are accessible via ACTLR2... which
KVM doesn't emulate.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200529150656.7339-3-james.morse@arm.com
---
 arch/arm64/kvm/sys_regs_generic_v8.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
index 9cb6b4c8355a..aa9d356451eb 100644
--- a/arch/arm64/kvm/sys_regs_generic_v8.c
+++ b/arch/arm64/kvm/sys_regs_generic_v8.c
@@ -27,6 +27,14 @@ static bool access_actlr(struct kvm_vcpu *vcpu,
 		return ignore_write(vcpu, p);
 
 	p->regval = vcpu_read_sys_reg(vcpu, ACTLR_EL1);
+
+	if (p->is_aarch32) {
+		if (r->Op2 & 2)
+			p->regval = upper_32_bits(p->regval);
+		else
+			p->regval = lower_32_bits(p->regval);
+	}
+
 	return true;
 }
 
@@ -47,6 +55,8 @@ static const struct sys_reg_desc genericv8_cp15_regs[] = {
 	/* ACTLR */
 	{ Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b001),
 	  access_actlr },
+	{ Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b011),
+	  access_actlr },
 };
 
 static struct kvm_sys_reg_target_table genericv8_target_table = {
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
