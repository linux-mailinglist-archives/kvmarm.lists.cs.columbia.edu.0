Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7112A23CE5E
	for <lists+kvmarm@lfdr.de>; Wed,  5 Aug 2020 20:25:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 254B04B47B;
	Wed,  5 Aug 2020 14:25:57 -0400 (EDT)
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
	with ESMTP id wjvIGDlu18FJ; Wed,  5 Aug 2020 14:25:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C374A4B4D3;
	Wed,  5 Aug 2020 14:25:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C74BE4B47B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 14:25:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eX5FBbovXWU9 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Aug 2020 14:25:52 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3D1DA4B431
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 14:25:52 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D19722CA1;
 Wed,  5 Aug 2020 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596651951;
 bh=r2Dto6XkGTFiL/tfKizK8S9fMTFHJyg+njqLkp9sfLE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hA+zMDGXCw0jhnfWI74Wa7Mm9jaaENkt5TreR4WLAhI0b6QXPB+b9sPaxIRfbf3bA
 dhN+lED0yUBnKhXbGikK9/zE7z8c1tbBc9q11FmqFxRgUfuPRQXpFhQIiug1z2FNLJ
 ZXYl8up+eU88Y5OXBiiybcyeXu11Wsq9UNCCmZE4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k3NfF-0004w9-GD; Wed, 05 Aug 2020 18:57:21 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 11/56] KVM: arm64: Remove target_table from exit handlers
Date: Wed,  5 Aug 2020 18:56:15 +0100
Message-Id: <20200805175700.62775-12-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805175700.62775-1-maz@kernel.org>
References: <20200805175700.62775-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, graf@amazon.com,
 alexandru.elisei@arm.com, ascull@google.com, catalin.marinas@arm.com,
 christoffer.dall@arm.com, dbrazdil@google.com, eric.auger@redhat.com,
 gshan@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
 richard.peng@oppo.com, qperret@google.com, will@kernel.org,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Peng Hao <richard.peng@oppo.com>, kernel-team@android.com,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Alexander Graf <graf@amazon.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

From: James Morse <james.morse@arm.com>

Whenever KVM searches for a register (e.g. due to a guest exit), it
works with two tables, as the target table overrides the sys_regs array.

Now that everything is in the sys_regs array, and the target table is
empty, stop doing that.

Remove the second table and its size from all the functions that take
it.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200622113317.20477-5-james.morse@arm.com
---
 arch/arm64/kvm/sys_regs.c | 87 +++++++--------------------------------
 1 file changed, 16 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f8407cfa9032..14333005b476 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2269,9 +2269,7 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
  */
 static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 			    const struct sys_reg_desc *global,
-			    size_t nr_global,
-			    const struct sys_reg_desc *target_specific,
-			    size_t nr_specific)
+			    size_t nr_global)
 {
 	struct sys_reg_params params;
 	u32 hsr = kvm_vcpu_get_hsr(vcpu);
@@ -2298,14 +2296,11 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 	}
 
 	/*
-	 * Try to emulate the coprocessor access using the target
-	 * specific table first, and using the global table afterwards.
-	 * If either of the tables contains a handler, handle the
+	 * If the table contains a handler, handle the
 	 * potential register operation in the case of a read and return
 	 * with success.
 	 */
-	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
-	    !emulate_cp(vcpu, &params, global, nr_global)) {
+	if (!emulate_cp(vcpu, &params, global, nr_global)) {
 		/* Split up the value between registers for the read side */
 		if (!params.is_write) {
 			vcpu_set_reg(vcpu, Rt, lower_32_bits(params.regval));
@@ -2326,9 +2321,7 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
  */
 static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
 			    const struct sys_reg_desc *global,
-			    size_t nr_global,
-			    const struct sys_reg_desc *target_specific,
-			    size_t nr_specific)
+			    size_t nr_global)
 {
 	struct sys_reg_params params;
 	u32 hsr = kvm_vcpu_get_hsr(vcpu);
@@ -2344,8 +2337,7 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
 	params.Op1 = (hsr >> 14) & 0x7;
 	params.Op2 = (hsr >> 17) & 0x7;
 
-	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
-	    !emulate_cp(vcpu, &params, global, nr_global)) {
+	if (!emulate_cp(vcpu, &params, global, nr_global)) {
 		if (!params.is_write)
 			vcpu_set_reg(vcpu, Rt, params.regval);
 		return 1;
@@ -2357,38 +2349,22 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
 
 int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	const struct sys_reg_desc *target_specific;
-	size_t num;
-
-	target_specific = get_target_table(vcpu->arch.target, false, &num);
-	return kvm_handle_cp_64(vcpu,
-				cp15_64_regs, ARRAY_SIZE(cp15_64_regs),
-				target_specific, num);
+	return kvm_handle_cp_64(vcpu, cp15_64_regs, ARRAY_SIZE(cp15_64_regs));
 }
 
 int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	const struct sys_reg_desc *target_specific;
-	size_t num;
-
-	target_specific = get_target_table(vcpu->arch.target, false, &num);
-	return kvm_handle_cp_32(vcpu,
-				cp15_regs, ARRAY_SIZE(cp15_regs),
-				target_specific, num);
+	return kvm_handle_cp_32(vcpu, cp15_regs, ARRAY_SIZE(cp15_regs));
 }
 
 int kvm_handle_cp14_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	return kvm_handle_cp_64(vcpu,
-				cp14_64_regs, ARRAY_SIZE(cp14_64_regs),
-				NULL, 0);
+	return kvm_handle_cp_64(vcpu, cp14_64_regs, ARRAY_SIZE(cp14_64_regs));
 }
 
 int kvm_handle_cp14_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	return kvm_handle_cp_32(vcpu,
-				cp14_regs, ARRAY_SIZE(cp14_regs),
-				NULL, 0);
+	return kvm_handle_cp_32(vcpu, cp14_regs, ARRAY_SIZE(cp14_regs));
 }
 
 static bool is_imp_def_sys_reg(struct sys_reg_params *params)
@@ -2400,15 +2376,9 @@ static bool is_imp_def_sys_reg(struct sys_reg_params *params)
 static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params)
 {
-	size_t num;
-	const struct sys_reg_desc *table, *r;
-
-	table = get_target_table(vcpu->arch.target, true, &num);
+	const struct sys_reg_desc *r;
 
-	/* Search target-specific then generic table. */
-	r = find_reg(params, table, num);
-	if (!r)
-		r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 
 	if (likely(r)) {
 		perform_access(vcpu, params, r);
@@ -2512,8 +2482,7 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
 						    u64 id)
 {
-	size_t num;
-	const struct sys_reg_desc *table, *r;
+	const struct sys_reg_desc *r;
 	struct sys_reg_params params;
 
 	/* We only do sys_reg for now. */
@@ -2523,10 +2492,7 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
 	if (!index_to_params(id, &params))
 		return NULL;
 
-	table = get_target_table(vcpu->arch.target, true, &num);
-	r = find_reg(&params, table, num);
-	if (!r)
-		r = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	r = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 
 	/* Not saved in the sys_reg array and not otherwise accessible? */
 	if (r && !(r->reg || r->get_user))
@@ -2826,38 +2792,17 @@ static int walk_one_sys_reg(const struct kvm_vcpu *vcpu,
 /* Assumed ordered tables, see kvm_sys_reg_table_init. */
 static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
 {
-	const struct sys_reg_desc *i1, *i2, *end1, *end2;
+	const struct sys_reg_desc *i2, *end2;
 	unsigned int total = 0;
-	size_t num;
 	int err;
 
-	/* We check for duplicates here, to allow arch-specific overrides. */
-	i1 = get_target_table(vcpu->arch.target, true, &num);
-	end1 = i1 + num;
 	i2 = sys_reg_descs;
 	end2 = sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
 
-	if (i1 == end1)
-		i1 = NULL;
-
-	BUG_ON(i2 == end2);
-
-	/* Walk carefully, as both tables may refer to the same register. */
-	while (i1 || i2) {
-		int cmp = cmp_sys_reg(i1, i2);
-		/* target-specific overrides generic entry. */
-		if (cmp <= 0)
-			err = walk_one_sys_reg(vcpu, i1, &uind, &total);
-		else
-			err = walk_one_sys_reg(vcpu, i2, &uind, &total);
-
+	while (i2 != end2) {
+		err = walk_one_sys_reg(vcpu, i2++, &uind, &total);
 		if (err)
 			return err;
-
-		if (cmp <= 0 && ++i1 == end1)
-			i1 = NULL;
-		if (cmp >= 0 && ++i2 == end2)
-			i2 = NULL;
 	}
 	return total;
 }
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
