Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26350ECE8
	for <lists+kvmarm@lfdr.de>; Tue, 26 Apr 2022 01:53:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C80CD4B1AB;
	Mon, 25 Apr 2022 19:53:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P5nx4UDuiD0O; Mon, 25 Apr 2022 19:53:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E91B4B1BD;
	Mon, 25 Apr 2022 19:53:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F2C404B187
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Apr 2022 19:53:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oxuh77NBDgWB for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Apr 2022 19:53:50 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 83A524B0DD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Apr 2022 19:53:50 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 o16-20020a17090ab89000b001d84104fc2cso356103pjr.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Apr 2022 16:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=RSo1O8l0KZ0BjKyBF8w0ZUdatjRfiYLVU+ogq1UksZY=;
 b=PZpyheBdEtEoIHiPU+z+c7WbcPa7baVdZeNrYNSOmGhQxFlBpy/8MzW/5AkrH8ZsgT
 +8rQ757o8mnsqytfFbZSkT4BKc/BT9noHclHo9zhUe0Hr+ICxgN1VwmjjWLTT33tFhvk
 KSWpg71Zy4+Xn4N/FTvUXtc6J6xVJGHHqhH8uxMWeMxopjK1fiinCgk5Cx7QpgHcFQk0
 LvNW4hKTBbq7ZP9uW+khzOaE0D2w96Om99A+p6Ho7AIZqsW+wKHyBHtUVwaZBVZLXGtr
 5/YkNeXsY5gYwGRVtMYaa6lVb/wqy/1ape29jjoeKhgmSFOij5/l1wP5yCuBlQYBjiis
 NwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=RSo1O8l0KZ0BjKyBF8w0ZUdatjRfiYLVU+ogq1UksZY=;
 b=gxYgGphXDQ7O+MlZ7hNdWTq1PSvKbH3ni757z4ZyWubnmDJSt05flKzT2sG1TGHhbI
 JqGL9HK1C15+ZcOTlm4wRWoHw7+mjP/4p1ihVVGwAd+GHwUDEAXjp/P8xEaQm971HsqH
 hR92gxZe5lf3XUHQIDN0Kj7+J8WuUjq2uDTvVxjkh1sT2s0RtNJSwhpzkAbZ+OAiQSBu
 4hVdSJesfJYqYOg7KHO/KvdHzfMVc0w3QszcNhRVtzVeOY28TpB/wePgNrVJMnJdW/G0
 Gy3gFz8ZDOXGioWpWNSSdpy5LOD0xF+mybgOOUVeMfc7XYQNw1JpSnUu9YW5aH+lG9t6
 iOtg==
X-Gm-Message-State: AOAM5316R58cSq1xR2RA4MNcLR45KftxU4xA9V2KlEF2AUZolsYkbNzK
 kJDFz9ULDcfL7WqF1ssTQNZdrBRZxKzEUDOQ/k0UoPmtrPctDmlAE/Do8P7cfUFo4eNdS788aDp
 qxbroZnNsalxQRfS0IgBk7rBJozjHNCAvDIidAWW+fX0sxpGknDmKotvuju0voP+86BNrhQ==
X-Google-Smtp-Source: ABdhPJzZmqXGoZUtGGTEFinr9iJkoUQzeNw8btB349945VEO/tmWZLWv1Z9jsdcVCJlYFRe5dKEYUCEFz5g=
X-Received: from oupton3.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a05:6a00:10cc:b0:506:e0:d6c3 with SMTP id
 d12-20020a056a0010cc00b0050600e0d6c3mr21351782pfu.33.1650930829404; Mon, 25
 Apr 2022 16:53:49 -0700 (PDT)
Date: Mon, 25 Apr 2022 23:53:40 +0000
In-Reply-To: <20220425235342.3210912-1-oupton@google.com>
Message-Id: <20220425235342.3210912-4-oupton@google.com>
Mime-Version: 1.0
References: <20220425235342.3210912-1-oupton@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 3/5] KVM: arm64: Wire up CP15 feature registers to their
 AArch64 equivalents
From: Oliver Upton <oupton@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

KVM currently does not trap ID register accesses from an AArch32 EL1.
This is painful for a couple of reasons. Certain unimplemented features
are visible to AArch32 EL1, as we limit PMU to version 3 and the debug
architecture to v8.0. Additionally, we attempt to paper over
heterogeneous systems by using register values that are safe
system-wide. All this hard work is completely sidestepped because KVM
does not set TID3 for AArch32 guests.

Fix up handling of CP15 feature registers by simply rerouting to their
AArch64 aliases. Punt setting HCR_EL2.TID3 to a later change, as we need
to fix up the oddball CP10 feature registers still.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 86 ++++++++++++++++++++++++++++++++-------
 arch/arm64/kvm/sys_regs.h |  7 ++++
 2 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f0a076e5cc1c..f403ea47b8a3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2344,34 +2344,73 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
+static bool emulate_sys_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *params);
+
+/**
+ * kvm_emulate_cp15_id_reg() - Handles an MRC trap on a guest CP15 access where
+ *			       CRn=0, which corresponds to the AArch32 feature
+ *			       registers.
+ * @vcpu: the vCPU pointer
+ * @params: the system register access parameters.
+ *
+ * Our cp15 system register tables do not enumerate the AArch32 feature
+ * registers. Conveniently, our AArch64 table does, and the AArch32 system
+ * register encoding can be trivially remapped into the AArch64 for the feature
+ * registers: Append op0=3, leaving op1, CRn, CRm, and op2 the same.
+ *
+ * According to DDI0487G.b G7.3.1, paragraph "Behavior of VMSAv8-32 32-bit
+ * System registers with (coproc=0b1111, CRn==c0)", read accesses from this
+ * range are either UNKNOWN or RES0. Rerouting remains architectural as we
+ * treat undefined registers in this range as RAZ.
+ */
+static int kvm_emulate_cp15_id_reg(struct kvm_vcpu *vcpu,
+				   struct sys_reg_params *params)
+{
+	int Rt = kvm_vcpu_sys_get_rt(vcpu);
+
+	/* Treat impossible writes to RO registers as UNDEFINED */
+	if (params->is_write) {
+		unhandled_cp_access(vcpu, params);
+		return 1;
+	}
+
+	params->Op0 = 3;
+
+	/*
+	 * All registers where CRm > 3 are known to be UNKNOWN/RAZ from AArch32.
+	 * Avoid conflicting with future expansion of AArch64 feature registers
+	 * and simply treat them as RAZ here.
+	 */
+	if (params->CRm > 3)
+		params->regval = 0;
+	else if (!emulate_sys_reg(vcpu, params))
+		return 1;
+
+	vcpu_set_reg(vcpu, Rt, params->regval);
+	return 1;
+}
+
 /**
  * kvm_handle_cp_32 -- handles a mrc/mcr trap on a guest CP14/CP15 access
  * @vcpu: The VCPU pointer
  * @run:  The kvm_run struct
  */
 static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
+			    struct sys_reg_params *params,
 			    const struct sys_reg_desc *global,
 			    size_t nr_global)
 {
-	struct sys_reg_params params;
-	u32 esr = kvm_vcpu_get_esr(vcpu);
 	int Rt  = kvm_vcpu_sys_get_rt(vcpu);
 
-	params.CRm = (esr >> 1) & 0xf;
-	params.regval = vcpu_get_reg(vcpu, Rt);
-	params.is_write = ((esr & 1) == 0);
-	params.CRn = (esr >> 10) & 0xf;
-	params.Op0 = 0;
-	params.Op1 = (esr >> 14) & 0x7;
-	params.Op2 = (esr >> 17) & 0x7;
+	params->regval = vcpu_get_reg(vcpu, Rt);
 
-	if (emulate_cp(vcpu, &params, global, nr_global)) {
-		if (!params.is_write)
-			vcpu_set_reg(vcpu, Rt, params.regval);
+	if (emulate_cp(vcpu, params, global, nr_global)) {
+		if (!params->is_write)
+			vcpu_set_reg(vcpu, Rt, params->regval);
 		return 1;
 	}
 
-	unhandled_cp_access(vcpu, &params);
+	unhandled_cp_access(vcpu, params);
 	return 1;
 }
 
@@ -2382,7 +2421,20 @@ int kvm_handle_cp15_64(struct kvm_vcpu *vcpu)
 
 int kvm_handle_cp15_32(struct kvm_vcpu *vcpu)
 {
-	return kvm_handle_cp_32(vcpu, cp15_regs, ARRAY_SIZE(cp15_regs));
+	struct sys_reg_params params;
+
+	params = esr_cp1x_32_to_params(kvm_vcpu_get_esr(vcpu));
+
+	/*
+	 * Certain AArch32 ID registers are handled by rerouting to the AArch64
+	 * system register table. Registers in the ID range where CRm=0 are
+	 * excluded from this scheme as they do not trivially map into AArch64
+	 * system register encodings.
+	 */
+	if (params.Op1 == 0 && params.CRn == 0 && params.CRm)
+		return kvm_emulate_cp15_id_reg(vcpu, &params);
+
+	return kvm_handle_cp_32(vcpu, &params, cp15_regs, ARRAY_SIZE(cp15_regs));
 }
 
 int kvm_handle_cp14_64(struct kvm_vcpu *vcpu)
@@ -2392,7 +2444,11 @@ int kvm_handle_cp14_64(struct kvm_vcpu *vcpu)
 
 int kvm_handle_cp14_32(struct kvm_vcpu *vcpu)
 {
-	return kvm_handle_cp_32(vcpu, cp14_regs, ARRAY_SIZE(cp14_regs));
+	struct sys_reg_params params;
+
+	params = esr_cp1x_32_to_params(kvm_vcpu_get_esr(vcpu));
+
+	return kvm_handle_cp_32(vcpu, &params, cp14_regs, ARRAY_SIZE(cp14_regs));
 }
 
 static bool is_imp_def_sys_reg(struct sys_reg_params *params)
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index cc0cc95a0280..0d31a12b640c 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -35,6 +35,13 @@ struct sys_reg_params {
 				  .Op2 = ((esr) >> 17) & 0x7,                  \
 				  .is_write = !((esr) & 1) })
 
+#define esr_cp1x_32_to_params(esr)						\
+	((struct sys_reg_params){ .Op1 = ((esr) >> 14) & 0x7,			\
+				  .CRn = ((esr) >> 10) & 0xf,			\
+				  .CRm = ((esr) >> 1) & 0xf,			\
+				  .Op2 = ((esr) >> 17) & 0x7,			\
+				  .is_write = !((esr) & 1) })
+
 struct sys_reg_desc {
 	/* Sysreg string for debug */
 	const char *name;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
