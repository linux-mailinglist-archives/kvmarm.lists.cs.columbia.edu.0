Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4803D2C6F81
	for <lists+kvmarm@lfdr.de>; Sat, 28 Nov 2020 13:47:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E63504EB79;
	Sat, 28 Nov 2020 07:47:11 -0500 (EST)
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
	with ESMTP id k3GdVDFc2md9; Sat, 28 Nov 2020 07:47:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AD894EB81;
	Sat, 28 Nov 2020 07:47:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E10F4EB06
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Nov 2020 07:47:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b39GTKGeQWq2 for <kvmarm@lists.cs.columbia.edu>;
 Sat, 28 Nov 2020 07:47:06 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C896C4EAEA
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Nov 2020 07:47:06 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8ED2422409;
 Sat, 28 Nov 2020 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606567625;
 bh=lnhjrd1BY+4XT/salWuXAQXDGdluOebgvvtHAouCinc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fINe9zgg4BEo7DfBbGMcvdXT8bPDtBIBZgP6f6gxVZpUYSoriqEFshlbY+fjTA0A6
 QsBCMpyTQAtpWVlYOyszH/w67Itf4NHxOXc9OoMTYyOJLehFCg7qOxqG98YkGtV5uy
 NgE5A5J2H092MPpM2lp/0URKigLApTzWr8KgVVZc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kizd1-00EHHF-S1; Sat, 28 Nov 2020 12:47:04 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 1/2] arm64: Make the Meltdown mitigation state available
Date: Sat, 28 Nov 2020 12:46:58 +0000
Message-Id: <20201128124659.669578-2-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201128124659.669578-1-maz@kernel.org>
References: <20201128124659.669578-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, will@kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>
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

Our Meltdown mitigation state isn't exposed outside of cpufeature.c,
contrary to the rest of the Spectre mitigation state. As we are going
to use it in KVM, expose a arm64_get_meltdown_state() helper which
returns the same possible values as arm64_get_spectre_v?_state().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/spectre.h |  2 ++
 arch/arm64/kernel/cpufeature.c   | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index fcdfbce302bd..52e788981f4a 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -29,4 +29,6 @@ bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v4_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
 
+enum mitigation_state arm64_get_meltdown_state(void);
+
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6f36c4f62f69..280b10762f6b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2846,14 +2846,28 @@ static int __init enable_mrs_emulation(void)
 
 core_initcall(enable_mrs_emulation);
 
+enum mitigation_state arm64_get_meltdown_state(void)
+{
+	if (__meltdown_safe)
+		return SPECTRE_UNAFFECTED;
+
+	if (arm64_kernel_unmapped_at_el0())
+		return SPECTRE_MITIGATED;
+
+	return SPECTRE_VULNERABLE;
+}
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	if (__meltdown_safe)
+	switch (arm64_get_meltdown_state()) {
+	case SPECTRE_UNAFFECTED:
 		return sprintf(buf, "Not affected\n");
 
-	if (arm64_kernel_unmapped_at_el0())
+	case SPECTRE_MITIGATED:
 		return sprintf(buf, "Mitigation: PTI\n");
 
-	return sprintf(buf, "Vulnerable\n");
+	default:
+		return sprintf(buf, "Vulnerable\n");
+	}
 }
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
