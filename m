Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 401A149CE73
	for <lists+kvmarm@lfdr.de>; Wed, 26 Jan 2022 16:32:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C85234B08E;
	Wed, 26 Jan 2022 10:32:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4AeAiQq3nUO; Wed, 26 Jan 2022 10:32:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5B194B08B;
	Wed, 26 Jan 2022 10:32:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0283E49EF6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 10:32:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b+bzgIvx7W3y for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jan 2022 10:32:16 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 027DD49F37
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jan 2022 10:32:16 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB76618D9;
 Wed, 26 Jan 2022 15:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABE2C340E8;
 Wed, 26 Jan 2022 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643211135;
 bh=P2l5Y5PDPDJcPc6k74icHUD6sRurj6ctKkCgiE7n3uE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nWC/L5i/D5iFb/6kEZXcRwLr7zqVFNzLcWuLfUUqsBVOFcqtAgkWK5H/RGfGDY5oO
 uMPg3jKe+qbl5EdurKRM8Hz2/y9mf2g8gMKzEPTIKw4hW7sDJhEwoIfpvYuBFf2ptb
 nMbRdlHJNHDll0T/j89yMrD+2l5frc7alvcGAtp6lSD0aC4vyEVdxOMz7N9+vk5pch
 1lA3Uov72lSVgnSlaqzUZtv4mXGLxfNyDctQDo+6XWCr1EA0q6Vy1VbHFIsCrhIcmp
 nb5YW3LDxceVsUZCjhvIAt1J58UlbcJj2EOa6nwMBa4Arfj9LDRXfv7TPtQPdHeurF
 7eCmLHs/EsL4A==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v10 29/39] kselftest/arm64: sme: Add streaming SME support to
 vlset
Date: Wed, 26 Jan 2022 15:27:39 +0000
Message-Id: <20220126152749.233712-30-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; h=from:subject;
 bh=P2l5Y5PDPDJcPc6k74icHUD6sRurj6ctKkCgiE7n3uE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhsOiCWCuqdEhEwDeB0fuhFIzO/DqyGIULZWFjy
 SmyMmrCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFobAAKCRAk1otyXVSH0O2bCA
 CE6jVSrd5K/sMgscM/3S8eZti5dB+TBfE/ojyx0/k8Bbge2TtVqrB6q0rPAMRdtym480XNqbI0r8qu
 G/PtifEbazSwmcMlbDkLsYqWMzJN5poW2Wfs+FhP8UuXEz1WiOMMcvEHBEJ9zTEntZiT3Dx1UhwYLU
 r9lD7p6T7YIR/Q23unE9VHvtZWO1u+GKzKTtcXA863VHyGfElE6sfIm4FqQbGhFbe41oS9P5PeWKA9
 aKHIc9+MR7w5XS5UcGDacYXCFlepSLuavgHLYhKHvTOpGMK+yU9ApdOx1QxqgFg4OBC7PywlUvWAsV
 CGg3fiKebMJJ1wttEpEgHPf2DVs9i4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

The Scalable Matrix Extenions (SME) introduces additional register state
with configurable vector lengths, similar to SVE but configured separately.
Extend vlset to support configuring this state with a --sme or -s command
line option.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vlset.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/vlset.c b/tools/testing/selftests/arm64/fp/vlset.c
index 308d27a68226..76912a581a95 100644
--- a/tools/testing/selftests/arm64/fp/vlset.c
+++ b/tools/testing/selftests/arm64/fp/vlset.c
@@ -22,12 +22,15 @@ static int inherit = 0;
 static int no_inherit = 0;
 static int force = 0;
 static unsigned long vl;
+static int set_ctl = PR_SVE_SET_VL;
+static int get_ctl = PR_SVE_GET_VL;
 
 static const struct option options[] = {
 	{ "force",	no_argument, NULL, 'f' },
 	{ "inherit",	no_argument, NULL, 'i' },
 	{ "max",	no_argument, NULL, 'M' },
 	{ "no-inherit",	no_argument, &no_inherit, 1 },
+	{ "sme",	no_argument, NULL, 's' },
 	{ "help",	no_argument, NULL, '?' },
 	{}
 };
@@ -50,6 +53,9 @@ static int parse_options(int argc, char **argv)
 		case 'M':	vl = SVE_VL_MAX; break;
 		case 'f':	force = 1; break;
 		case 'i':	inherit = 1; break;
+		case 's':	set_ctl = PR_SME_SET_VL;
+				get_ctl = PR_SME_GET_VL;
+				break;
 		case 0:		break;
 		default:	goto error;
 		}
@@ -125,14 +131,14 @@ int main(int argc, char **argv)
 	if (inherit)
 		flags |= PR_SVE_VL_INHERIT;
 
-	t = prctl(PR_SVE_SET_VL, vl | flags);
+	t = prctl(set_ctl, vl | flags);
 	if (t < 0) {
 		fprintf(stderr, "%s: PR_SVE_SET_VL: %s\n",
 			program_name, strerror(errno));
 		goto error;
 	}
 
-	t = prctl(PR_SVE_GET_VL);
+	t = prctl(get_ctl);
 	if (t == -1) {
 		fprintf(stderr, "%s: PR_SVE_GET_VL: %s\n",
 			program_name, strerror(errno));
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
