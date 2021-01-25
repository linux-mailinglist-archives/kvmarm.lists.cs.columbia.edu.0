Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD93023F1
	for <lists+kvmarm@lfdr.de>; Mon, 25 Jan 2021 11:54:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A3294B5B0;
	Mon, 25 Jan 2021 05:54:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AAOn5276ZwRd; Mon, 25 Jan 2021 05:54:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DD1F4B5AF;
	Mon, 25 Jan 2021 05:54:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B06104B5CF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 05:54:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DM2++8Au88Cr for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Jan 2021 05:54:13 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9B5184B601
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 05:54:13 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 904A622AAC;
 Mon, 25 Jan 2021 10:54:12 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l3zSA-009rDe-0b; Mon, 25 Jan 2021 10:50:39 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/21] arm64: Make kvm-arm.mode={nvhe,
 protected} an alias of id_aa64mmfr1.vh=0
Date: Mon, 25 Jan 2021 10:50:14 +0000
Message-Id: <20210125105019.2946057-17-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125105019.2946057-1-maz@kernel.org>
References: <20210125105019.2946057-1-maz@kernel.org>
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

Admitedly, passing id_aa64mmfr1.vh=0 on the command-line isn't
that easy to understand, and it is likely that users would much
prefer write "kvm-arm.mode=nvhe", or "...=protected".

So here you go. This has the added advantage that we can now
always honor the "kvm-arm.mode=protected" option, even when
booting on a VHE system.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 arch/arm64/kvm/arm.c                            | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e3cdb271d06..2786fd39a047 100644
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
index 4fad3fc4d104..cbb8eaa48742 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -39,6 +39,8 @@ static const struct {
 	const char	*alias;
 	const char	*feature;
 } aliases[] __initdata = {
+	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
+	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
 };
 
 static char *cmdline_contains_option(const char *cmdline, const char *option)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 04c44853b103..597565a65ca2 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1966,6 +1966,9 @@ static int __init early_kvm_mode_cfg(char *arg)
 		return 0;
 	}
 
+	if (strcmp(arg, "nvhe") == 0 && !WARN_ON(is_kernel_in_hyp_mode()))
+		return 0;
+
 	return -EINVAL;
 }
 early_param("kvm-arm.mode", early_kvm_mode_cfg);
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
