Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22D2E3651
	for <lists+kvmarm@lfdr.de>; Mon, 28 Dec 2020 12:20:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 94F994B1AF;
	Mon, 28 Dec 2020 06:19:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CwXrdKkhZHPN; Mon, 28 Dec 2020 06:19:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83EBD4B1F2;
	Mon, 28 Dec 2020 06:19:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 31C644B18D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 06:19:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oE9jqONRQlgj for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Dec 2020 06:19:56 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1A7474B0EB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 06:19:56 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E951022583;
 Mon, 28 Dec 2020 11:19:54 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1ktq6N-0048wX-1q; Mon, 28 Dec 2020 10:50:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 14/17] arm64: Add an aliasing facility for the idreg override
Date: Mon, 28 Dec 2020 10:49:55 +0000
Message-Id: <20201228104958.1848833-15-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228104958.1848833-1-maz@kernel.org>
References: <20201228104958.1848833-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com,
 ardb@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
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

In order to map the override of idregs to options that a user
can easily understand, let's introduce yet another option
array, which maps an option to the corresponding idreg options.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/arm64/kernel/idreg-override.c            | 20 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec19cd00..e88e17bf5557 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2257,6 +2257,9 @@
 	kvm-arm.mode=
 			[KVM,ARM] Select one of KVM/arm64's modes of operation.
 
+			nvhe: Standard nVHE-based mode, without support for
+			      protected guests.
+
 			protected: nVHE-based mode with support for guests whose
 				   state is kept private from the host.
 				   Not valid if the kernel is running in EL2.
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 76f3d481535d..8f64100e0b1b 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -37,6 +37,12 @@ static const struct reg_desc * const regs[] __initdata = {
 	&mmfr1,
 };
 
+static const struct {
+	const char * const	alias;
+	const char * const	feature;
+} aliases[] __initdata = {
+};
+
 static int __init find_field(const char *cmdline, const struct reg_desc *reg,
 			     int f, u64 *v)
 {
@@ -77,6 +83,18 @@ static void __init match_options(const char *cmdline)
 	}
 }
 
+static __init void match_aliases(const char *cmdline)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(aliases); i++) {
+		char *str = strstr(cmdline, aliases[i].alias);
+
+		if ((str == cmdline || (str > cmdline && *(str - 1) == ' ')))
+			match_options(aliases[i].feature);
+	}
+}
+
 static __init void parse_cmdline(void)
 {
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
@@ -97,6 +115,7 @@ static __init void parse_cmdline(void)
 			goto out;
 
 		match_options(prop);
+		match_aliases(prop);
 
 		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
 			return;
@@ -104,6 +123,7 @@ static __init void parse_cmdline(void)
 
 out:
 	match_options(CONFIG_CMDLINE);
+	match_aliases(CONFIG_CMDLINE);
 }
 
 void __init init_shadow_regs(void)
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
