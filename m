Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B3304312E57
	for <lists+kvmarm@lfdr.de>; Mon,  8 Feb 2021 11:04:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 681AB4B5D7;
	Mon,  8 Feb 2021 05:04:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWfdnQPCLt1f; Mon,  8 Feb 2021 05:04:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0BFAA4B61F;
	Mon,  8 Feb 2021 05:04:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA4DC4B5F3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 05:04:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N3fZvrFSjv16 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Feb 2021 05:04:21 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9A1CA4B552
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 05:04:21 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A34C864E8C;
 Mon,  8 Feb 2021 10:04:20 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l93Iz-00Ck14-1b; Mon, 08 Feb 2021 09:58:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/23] arm64: Add an aliasing facility for the idreg
 override
Date: Mon,  8 Feb 2021 09:57:25 +0000
Message-Id: <20210208095732.3267263-17-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208095732.3267263-1-maz@kernel.org>
References: <20210208095732.3267263-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org,
 jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org,
 sramana@codeaurora.org, marcan@marcan.st, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Hector Martin <marcan@marcan.st>,
 Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/idreg-override.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2da11bf60195..226bac544e20 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -16,6 +16,8 @@
 
 #define FTR_DESC_NAME_LEN	20
 #define FTR_DESC_FIELD_LEN	10
+#define FTR_ALIAS_NAME_LEN	30
+#define FTR_ALIAS_OPTION_LEN	80
 
 struct ftr_set_desc {
 	char 				name[FTR_DESC_NAME_LEN];
@@ -39,6 +41,12 @@ static const struct ftr_set_desc * const regs[] __initconst = {
 	&mmfr1,
 };
 
+static const struct {
+	char	alias[FTR_ALIAS_NAME_LEN];
+	char	feature[FTR_ALIAS_OPTION_LEN];
+} aliases[] __initconst = {
+};
+
 static int __init find_field(const char *cmdline,
 			     const struct ftr_set_desc *reg, int f, u64 *v)
 {
@@ -81,7 +89,7 @@ static void __init match_options(const char *cmdline)
 	}
 }
 
-static __init void __parse_cmdline(const char *cmdline)
+static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 {
 	do {
 		char buf[256];
@@ -105,6 +113,9 @@ static __init void __parse_cmdline(const char *cmdline)
 
 		match_options(buf);
 
+		for (i = 0; parse_aliases && i < ARRAY_SIZE(aliases); i++)
+			if (parameq(buf, aliases[i].alias))
+				__parse_cmdline(aliases[i].feature, false);
 	} while (1);
 }
 
@@ -127,14 +138,14 @@ static __init void parse_cmdline(void)
 		if (!prop)
 			goto out;
 
-		__parse_cmdline(prop);
+		__parse_cmdline(prop, true);
 
 		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
 			return;
 	}
 
 out:
-	__parse_cmdline(CONFIG_CMDLINE);
+	__parse_cmdline(CONFIG_CMDLINE, true);
 }
 
 /* Keep checkers quiet */
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
