Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E830A718
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 13:04:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B60A4B3CE;
	Mon,  1 Feb 2021 07:04:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjA-gIJkygmC; Mon,  1 Feb 2021 07:04:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C2ED4B413;
	Mon,  1 Feb 2021 07:04:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 614C54B406
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 07:04:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ct89oUukElsJ for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 07:04:21 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 369174B3C7
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 07:04:21 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3FE5564E9E;
 Mon,  1 Feb 2021 12:04:20 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l6XpJ-00BG09-FC; Mon, 01 Feb 2021 11:57:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/21] arm64: Move "nokaslr" over to the early cpufeature
 infrastructure
Date: Mon,  1 Feb 2021 11:56:34 +0000
Message-Id: <20210201115637.3123740-19-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201115637.3123740-1-maz@kernel.org>
References: <20210201115637.3123740-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org,
 jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org,
 sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ajay Patil <pajay@qti.qualcomm.com>,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

Given that the early cpufeature infrastructure has borrowed quite
a lot of code from the kaslr implementation, let's reimplement
the matching of the "nokaslr" option with it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/idreg-override.c | 15 +++++++++++++
 arch/arm64/kernel/kaslr.c          | 36 ++----------------------------
 2 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 3b55a1d21403..2b492ce73e74 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -37,8 +37,22 @@ static const struct ftr_set_desc mmfr1 __initconst = {
 	},
 };
 
+extern struct arm64_ftr_override kaslr_feature_override;
+
+static const struct ftr_set_desc kaslr __initconst = {
+	.name		= "kaslr",
+#ifdef CONFIG_RANDOMIZE_BASE
+	.override	= &kaslr_feature_override,
+#endif
+	.fields		= {
+		{ "disabled", 0 },
+		{}
+	},
+};
+
 static const struct ftr_set_desc * const regs[] __initconst = {
 	&mmfr1,
+	&kaslr,
 };
 
 static const struct {
@@ -47,6 +61,7 @@ static const struct {
 } aliases[] __initconst = {
 	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
 	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
+	{ "nokaslr",			"kaslr.disabled=1" },
 };
 
 static char *cmdline_contains_option(const char *cmdline, const char *option)
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 5fc86e7d01a1..27f8939deb1b 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -51,39 +51,7 @@ static __init u64 get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-static __init bool cmdline_contains_nokaslr(const u8 *cmdline)
-{
-	const u8 *str;
-
-	str = strstr(cmdline, "nokaslr");
-	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
-}
-
-static __init bool is_kaslr_disabled_cmdline(void *fdt)
-{
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
-		int node;
-		const u8 *prop;
-
-		node = fdt_path_offset(fdt, "/chosen");
-		if (node < 0)
-			goto out;
-
-		prop = fdt_getprop(fdt, node, "bootargs", NULL);
-		if (!prop)
-			goto out;
-
-		if (cmdline_contains_nokaslr(prop))
-			return true;
-
-		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
-			goto out;
-
-		return false;
-	}
-out:
-	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
-}
+struct arm64_ftr_override kaslr_feature_override __initdata;
 
 /*
  * This routine will be executed with the kernel mapped at its default virtual
@@ -126,7 +94,7 @@ u64 __init kaslr_early_init(void)
 	 * Check if 'nokaslr' appears on the command line, and
 	 * return 0 if that is the case.
 	 */
-	if (is_kaslr_disabled_cmdline(fdt)) {
+	if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
 		kaslr_status = KASLR_DISABLED_CMDLINE;
 		return 0;
 	}
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
