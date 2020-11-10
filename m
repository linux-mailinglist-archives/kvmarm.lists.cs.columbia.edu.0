Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCC2AD7AC
	for <lists+kvmarm@lfdr.de>; Tue, 10 Nov 2020 14:36:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D63C94B9A7;
	Tue, 10 Nov 2020 08:36:38 -0500 (EST)
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
	with ESMTP id 4STH8efNuoEq; Tue, 10 Nov 2020 08:36:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32AA64B9D1;
	Tue, 10 Nov 2020 08:36:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 057874B767
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 08:36:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FyqWVo2WasBi for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Nov 2020 08:36:32 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 13E3C4B98C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 08:36:32 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BA7F207E8;
 Tue, 10 Nov 2020 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605015391;
 bh=/vSypgHV3ppGf3VM+3b9Uw3XIcZP+Wgme9h2xxf4rZk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NDde93VzfhcuDPCXjEoxZP05SEo3FPIlXyx3b9VAEUY8JvZBVmUw3v4EEzO+btM/L
 FFgUPsN6CTunS6rp1vQ3netC6hTUm+vYXvIeU4a3vHa9WE/s7YrwJi4rDbEGB7yhwf
 hXNjAfHveMdam/0ViTfhF3wygodO9fACTGTXXdSk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kcToz-009SZy-7p; Tue, 10 Nov 2020 13:36:29 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/9] KVM: arm64: Add AArch32 mapping annotation
Date: Tue, 10 Nov 2020 13:36:13 +0000
Message-Id: <20201110133619.451157-4-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110133619.451157-1-maz@kernel.org>
References: <20201110133619.451157-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
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

In order to deal with the few AArch32 system registers that map to
only a particular half of their AArch64 counterpart (such as DFAR
and IFAR being colocated in FAR_EL1), let's add an optional annotation
to the sysreg descriptor structure, indicating whether a register
maps to the upper or lower 32bits of a register.

Nothing is using these annotation yet.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 5a6fc30f5989..259864c3c76b 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -27,6 +27,12 @@ struct sys_reg_desc {
 	/* Sysreg string for debug */
 	const char *name;
 
+	enum {
+		AA32_ZEROHIGH,
+		AA32_LO,
+		AA32_HI,
+	} aarch32_map;
+
 	/* MRS/MSR instruction which accesses it. */
 	u8	Op0;
 	u8	Op1;
@@ -153,6 +159,7 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 					  const struct sys_reg_desc table[],
 					  unsigned int num);
 
+#define AA32(_x)	.aarch32_map = AA32_##_x
 #define Op0(_x) 	.Op0 = _x
 #define Op1(_x) 	.Op1 = _x
 #define CRn(_x)		.CRn = _x
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
