Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9E388FEB
	for <lists+kvmarm@lfdr.de>; Wed, 19 May 2021 16:07:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 520F04B53D;
	Wed, 19 May 2021 10:07:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rmmdlICvlITO; Wed, 19 May 2021 10:07:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E44684B4FE;
	Wed, 19 May 2021 10:07:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 30F4C4B53D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 10:07:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qlf82djF+Glh for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 May 2021 10:07:49 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 118F14B857
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 10:07:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621433268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VetHpOvSuMU3AdKm021OKbp+xK/DKJ2+j6hSKQ3/iF4=;
 b=VWwP5mR4uv4PMYqfQ5j0T6ZWvvJsReLjpYjBzf2jTguNZ8vVQvKStZEMQljAuXxCboLFYH
 fr0W/SHl9qRUJX+dNMKTOpiTXgm07Pt+aHilZNPwv3hag3PgknhrVoQlVgCdANeXKyU253
 T6fVO3daLgLZuyUybbqBXg0+5nBCfh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-gxnZUfH5PjmZ1jK3oq6IaA-1; Wed, 19 May 2021 10:07:47 -0400
X-MC-Unique: gxnZUfH5PjmZ1jK3oq6IaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39750107ACC7;
 Wed, 19 May 2021 14:07:46 +0000 (UTC)
Received: from gator.redhat.com (unknown [10.40.192.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 722E010013C1;
 Wed, 19 May 2021 14:07:44 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 5/5] KVM: arm64: selftests: get-reg-list: Split base and
 pmu registers
Date: Wed, 19 May 2021 16:07:26 +0200
Message-Id: <20210519140726.892632-6-drjones@redhat.com>
In-Reply-To: <20210519140726.892632-1-drjones@redhat.com>
References: <20210519140726.892632-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: maz@kernel.org, pbonzini@redhat.com
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

Since KVM commit 11663111cd49 ("KVM: arm64: Hide PMU registers from
userspace when not available") the get-reg-list* tests have been
failing with

  ...
  ... There are 74 missing registers.
  The following lines are missing registers:
  ...

where the 74 missing registers are all PMU registers. This isn't a
bug in KVM that the selftest found, even though it's true that a
KVM userspace that wasn't setting the KVM_ARM_VCPU_PMU_V3 VCPU
flag, but still expecting the PMU registers to be in the reg-list,
would suddenly no longer have their expectations met. In that case,
the expectations were wrong, though, so that KVM userspace needs to
be fixed, and so does this selftest. The fix for this selftest is to
pull the PMU registers out of the base register sublist into their
own sublist and then create new, pmu-enabled vcpu configs which can
be tested.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 46 +++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index dc06a28bfb74..78d8949bddbd 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -47,6 +47,7 @@ struct reg_sublist {
 struct vcpu_config {
 	const char *name;
 	bool sve;
+	bool pmu;
 	struct reg_sublist sublists[];
 };
 
@@ -328,6 +329,8 @@ static void prepare_vcpu_init(struct vcpu_config *c, struct kvm_vcpu_init *init)
 {
 	if (c->sve)
 		init->features[0] |= 1 << KVM_ARM_VCPU_SVE;
+	if (c->pmu)
+		init->features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
 }
 
 static void finalize_vcpu(struct kvm_vm *vm, uint32_t vcpuid, struct vcpu_config *c)
@@ -346,6 +349,10 @@ static void check_supported(struct vcpu_config *c)
 		fprintf(stderr, "%s: SVE not available, skipping tests\n", c->name);
 		exit(KSFT_SKIP);
 	}
+	if (c->pmu && !kvm_check_cap(KVM_CAP_ARM_PMU_V3)) {
+		fprintf(stderr, "%s: PMU not available, skipping tests\n", c->name);
+		exit(KSFT_SKIP);
+	}
 }
 
 static bool print_list;
@@ -588,7 +595,7 @@ int main(int ac, char **av)
  * The current blessed list was primed with the output of kernel version
  * v4.15 with --core-reg-fixup and then later updated with new registers.
  *
- * The blessed list is up to date with kernel version v5.10-rc5
+ * The blessed list is up to date with kernel version 5.13.0-rc2
  */
 static __u64 base_regs[] = {
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(regs.regs[0]),
@@ -780,8 +787,6 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 5, 2, 0),	/* ESR_EL1 */
 	ARM64_SYS_REG(3, 0, 6, 0, 0),	/* FAR_EL1 */
 	ARM64_SYS_REG(3, 0, 7, 4, 0),	/* PAR_EL1 */
-	ARM64_SYS_REG(3, 0, 9, 14, 1),	/* PMINTENSET_EL1 */
-	ARM64_SYS_REG(3, 0, 9, 14, 2),	/* PMINTENCLR_EL1 */
 	ARM64_SYS_REG(3, 0, 10, 2, 0),	/* MAIR_EL1 */
 	ARM64_SYS_REG(3, 0, 10, 3, 0),	/* AMAIR_EL1 */
 	ARM64_SYS_REG(3, 0, 12, 0, 0),	/* VBAR_EL1 */
@@ -790,6 +795,16 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
 	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
+	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
+	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */
+	ARM64_SYS_REG(3, 4, 3, 0, 0),	/* DACR32_EL2 */
+	ARM64_SYS_REG(3, 4, 5, 0, 1),	/* IFSR32_EL2 */
+	ARM64_SYS_REG(3, 4, 5, 3, 0),	/* FPEXC32_EL2 */
+};
+
+static __u64 pmu_regs[] = {
+	ARM64_SYS_REG(3, 0, 9, 14, 1),	/* PMINTENSET_EL1 */
+	ARM64_SYS_REG(3, 0, 9, 14, 2),	/* PMINTENCLR_EL1 */
 	ARM64_SYS_REG(3, 3, 9, 12, 0),	/* PMCR_EL0 */
 	ARM64_SYS_REG(3, 3, 9, 12, 1),	/* PMCNTENSET_EL0 */
 	ARM64_SYS_REG(3, 3, 9, 12, 2),	/* PMCNTENCLR_EL0 */
@@ -799,8 +814,6 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 3, 9, 13, 0),	/* PMCCNTR_EL0 */
 	ARM64_SYS_REG(3, 3, 9, 14, 0),	/* PMUSERENR_EL0 */
 	ARM64_SYS_REG(3, 3, 9, 14, 3),	/* PMOVSSET_EL0 */
-	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
-	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 8, 0),
 	ARM64_SYS_REG(3, 3, 14, 8, 1),
 	ARM64_SYS_REG(3, 3, 14, 8, 2),
@@ -864,9 +877,6 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 3, 14, 15, 5),
 	ARM64_SYS_REG(3, 3, 14, 15, 6),
 	ARM64_SYS_REG(3, 3, 14, 15, 7),	/* PMCCFILTR_EL0 */
-	ARM64_SYS_REG(3, 4, 3, 0, 0),	/* DACR32_EL2 */
-	ARM64_SYS_REG(3, 4, 5, 0, 1),	/* IFSR32_EL2 */
-	ARM64_SYS_REG(3, 4, 5, 3, 0),	/* FPEXC32_EL2 */
 };
 
 static __u64 vregs[] = {
@@ -970,6 +980,15 @@ static struct vcpu_config vregs_config = {
 	{0},
 	},
 };
+static struct vcpu_config vregs_pmu_config = {
+	"vregs+pmu", .pmu = true,
+	.sublists = {
+	{ base_regs,	ARRAY_SIZE(base_regs), },
+	{ vregs,	ARRAY_SIZE(vregs), },
+	{ pmu_regs,	ARRAY_SIZE(pmu_regs), },
+	{0},
+	},
+};
 static struct vcpu_config sve_config = {
 	"sve", .sve = true,
 	.sublists = {
@@ -978,9 +997,20 @@ static struct vcpu_config sve_config = {
 	{0},
 	},
 };
+static struct vcpu_config sve_pmu_config = {
+	"sve+pmu", .sve = true, .pmu = true,
+	.sublists = {
+	{ base_regs,	ARRAY_SIZE(base_regs), },
+	{ sve_regs,	ARRAY_SIZE(sve_regs),	sve_rejects_set,	ARRAY_SIZE(sve_rejects_set), },
+	{ pmu_regs,	ARRAY_SIZE(pmu_regs), },
+	{0},
+	},
+};
 
 static struct vcpu_config *vcpu_configs[] = {
 	&vregs_config,
+	&vregs_pmu_config,
 	&sve_config,
+	&sve_pmu_config,
 };
 static int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
