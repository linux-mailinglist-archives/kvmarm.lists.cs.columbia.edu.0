Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5E46B480907
	for <lists+kvmarm@lfdr.de>; Tue, 28 Dec 2021 13:14:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9937649F33;
	Tue, 28 Dec 2021 07:14:24 -0500 (EST)
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
	with ESMTP id SYmodLF65U9P; Tue, 28 Dec 2021 07:14:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 69EC049F29;
	Tue, 28 Dec 2021 07:14:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEA5149F1F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Dec 2021 07:14:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Cz+yCyVahku for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 Dec 2021 07:14:20 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BD1CF49F1D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Dec 2021 07:14:20 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 17C7961161;
 Tue, 28 Dec 2021 12:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE1C36AE7;
 Tue, 28 Dec 2021 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640693659;
 bh=dC2K7UYn0C5HLYz6aHEjkd2hSiUU/BCOy54X/ouxHuo=;
 h=From:To:Cc:Subject:Date:From;
 b=B16JMu0f3re31lMirqT1+cqjEjfuGoNeME9f3UL12m23z41aEmxIpXQHZzG8Ypl+K
 +7DKSXuGbwzGWWUnT3LdK1NgFnbAx4CkItXJBya/O7ufLwnhj3GAqanQG4n6/TYSLN
 8CRoWszCov3DTtcO9Xy76nDEFegzY0dNai4ggbUsdiUi4piy0EiZf5Pw8m+ZiKZIVm
 wBA3oDEHMYl6iFKXpEJKgXpQjhE34Q7G1e+8BeUF9hD7VYfbITA+i9zNy7/3PaLdMJ
 nhLWK14KBJpp8baWrq2T3nwZ7XcA3F+fSGSQBOD44fDFzvEs9vcJQhrPwLAz3pHu/q
 DevKrEjdmy/7w==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1n2BMv-00EiLp-Gj; Tue, 28 Dec 2021 12:14:17 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: selftests: get-reg-list: Add pauth configuration
Date: Tue, 28 Dec 2021 12:14:14 +0000
Message-Id: <20211228121414.1013250-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 drjones@redhat.com, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, kernel-team@android.com
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

The get-reg-list test ignores the Pointer Authentication features,
which is a shame now that we have relatively common HW with this feature.

Define two new configurations (with and without PMU) that exercise the
KVM capabilities.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index cc898181faab..f769fc6cd927 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -1014,6 +1014,22 @@ static __u64 sve_rejects_set[] = {
 	KVM_REG_ARM64_SVE_VLS,
 };
 
+static __u64 pauth_addr_regs[] = {
+	ARM64_SYS_REG(3, 0, 2, 1, 0),	/* APIAKEYLO_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 1, 1),	/* APIAKEYHI_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 1, 2),	/* APIBKEYLO_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 1, 3),	/* APIBKEYHI_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 2, 0),	/* APDAKEYLO_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 2, 1),	/* APDAKEYHI_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 2, 2),	/* APDBKEYLO_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 2, 3)	/* APDBKEYHI_EL1 */
+};
+
+static __u64 pauth_generic_regs[] = {
+	ARM64_SYS_REG(3, 0, 2, 3, 0),	/* APGAKEYLO_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 3, 1),	/* APGAKEYHI_EL1 */
+};
+
 #define BASE_SUBLIST \
 	{ "base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), }
 #define VREGS_SUBLIST \
@@ -1025,6 +1041,21 @@ static __u64 sve_rejects_set[] = {
 	{ "sve", .capability = KVM_CAP_ARM_SVE, .feature = KVM_ARM_VCPU_SVE, .finalize = true, \
 	  .regs = sve_regs, .regs_n = ARRAY_SIZE(sve_regs), \
 	  .rejects_set = sve_rejects_set, .rejects_set_n = ARRAY_SIZE(sve_rejects_set), }
+#define PAUTH_SUBLIST							\
+	{								\
+		.name 		= "pauth_address",			\
+		.capability	= KVM_CAP_ARM_PTRAUTH_ADDRESS,		\
+		.feature	= KVM_ARM_VCPU_PTRAUTH_ADDRESS,		\
+		.regs		= pauth_addr_regs,			\
+		.regs_n		= ARRAY_SIZE(pauth_addr_regs),		\
+	},								\
+	{								\
+		.name 		= "pauth_generic",			\
+		.capability	= KVM_CAP_ARM_PTRAUTH_GENERIC,		\
+		.feature	= KVM_ARM_VCPU_PTRAUTH_GENERIC,		\
+		.regs		= pauth_generic_regs,			\
+		.regs_n		= ARRAY_SIZE(pauth_generic_regs),	\
+	}
 
 static struct vcpu_config vregs_config = {
 	.sublists = {
@@ -1056,11 +1087,30 @@ static struct vcpu_config sve_pmu_config = {
 	{0},
 	},
 };
+static struct vcpu_config pauth_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	VREGS_SUBLIST,
+	PAUTH_SUBLIST,
+	{0},
+	},
+};
+static struct vcpu_config pauth_pmu_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	VREGS_SUBLIST,
+	PAUTH_SUBLIST,
+	PMU_SUBLIST,
+	{0},
+	},
+};
 
 static struct vcpu_config *vcpu_configs[] = {
 	&vregs_config,
 	&vregs_pmu_config,
 	&sve_config,
 	&sve_pmu_config,
+	&pauth_config,
+	&pauth_pmu_config,
 };
 static int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
