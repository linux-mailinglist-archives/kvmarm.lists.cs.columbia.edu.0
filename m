Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A8B9B5069F0
	for <lists+kvmarm@lfdr.de>; Tue, 19 Apr 2022 13:23:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20F9C4B1E9;
	Tue, 19 Apr 2022 07:23:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISny2licDqtK; Tue, 19 Apr 2022 07:23:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D93874B1AF;
	Tue, 19 Apr 2022 07:23:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 60D4B49E08
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 07:23:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lDPmUF1oJRWN for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 Apr 2022 07:23:33 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3286E40C1F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 07:23:33 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ACBE661377;
 Tue, 19 Apr 2022 11:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F02C385AF;
 Tue, 19 Apr 2022 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650367411;
 bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A1cpewV+oNMgwj4e/36Yr8stpv3evTelc+ya2uLnlq+mVoMUbVTuac3469woDEaDo
 Zjrj7xmcXczAqsAcarHyNnOUT+XufO743aidLXhVfGtdxYnXRvfP0VUsufHKNN31F9
 ZofbyWHNtdM4ns4loS+v/pv76R23SS20WXg7k2gDXPlu0iuCsHviCsR2CBDwRD4maj
 XdUUzchf2ZsaIM+/PgzSRkvpQZGSUTB7SN3gmRKleY1jI3eZhiqKA0t18IMtW1jWjW
 EDn4yb4eh31u2s+SExN9YhKmiOPDz0sgPFgGbHkthHZsXYj72h5ftY6uwF+J1ADpA0
 ApyD6FEuoTL1w==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v14 01/39] kselftest/arm64: Fix comment for
 ptrace_sve_get_fpsimd_data()
Date: Tue, 19 Apr 2022 12:22:09 +0100
Message-Id: <20220419112247.711548-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; h=from:subject;
 bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXptoO+w0M52wR5OGcu7Rb9aMmx7Vhd+DLVQSaszX
 8TQxkxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6baAAKCRAk1otyXVSH0BAMB/
 9Zbg/QaH4zFOnbKbqqF4TxRo3xxajvi1zZ3l70LsVaLZ34hFhGiT6p+D8ydj+E7KjcGZnI1YBo9oWi
 hBLeZzdkmBKYLSCQTur/xQYW11HrdWQUqAqNl2zltvs9idg3FpW01DwfB3XJ4MLItvTJsPQXXQWdRn
 hUPNTSFLTucef0BnH/kOF45Vne7233JFMXCXAWo/H/V/FOgXiSNBhY27IkFvjbLkwFTAIY/jomwLrW
 wCgnr21J2QJtGMvlt6FOeBPdsKmWgbWXlS3WKg+8nrEUsIi37aJMyHWjGobEXxgGhEhxPAwEjif+FO
 1Ekh7M/KMh5EM9C5eCwicRBli6nhAZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>,
 Luca Salabrino <luca.scalabrino@arm.com>
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

The comment for ptrace_sve_get_fpsimd_data() doesn't describe what the test
does at all, fix that.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 4c418b2021e0..7682798adbba 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -395,7 +395,7 @@ static void ptrace_set_sve_get_sve_data(pid_t child,
 	free(write_buf);
 }
 
-/* Validate attempting to set SVE data and read SVE data */
+/* Validate attempting to set SVE data and read it via the FPSIMD regset */
 static void ptrace_set_sve_get_fpsimd_data(pid_t child,
 					   const struct vec_type *type,
 					   unsigned int vl)
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
