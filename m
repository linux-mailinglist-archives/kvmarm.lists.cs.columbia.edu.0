Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD09162C5C5
	for <lists+kvmarm@lfdr.de>; Wed, 16 Nov 2022 18:04:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51F6B4B8E4;
	Wed, 16 Nov 2022 12:04:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3wAn+fZa1Yi; Wed, 16 Nov 2022 12:03:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 803304B8FA;
	Wed, 16 Nov 2022 12:03:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D0B54B866
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 12:03:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RbIIrzaAHeNR for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Nov 2022 12:03:49 -0500 (EST)
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com
 [209.85.128.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 01FAD4B8F1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 12:03:48 -0500 (EST)
Received: by mail-yw1-f201.google.com with SMTP id
 00721157ae682-373582569edso166015727b3.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=/bRkqjyelCT2BwKXDL2kk3eM+ea/9WF6lbhTPLqyzQs=;
 b=OdTGpYZuNgCXakLh2Jk72rtpCkaN4uXEYVgleL325j12+NmpV15XjX8JS6kVtFnDwK
 PNhAWspY5fLWyh0Xj8g3+lafmWa+eNTSAWQNZ6ONYvy50LpLKB4FdqVaYvmgtJW2AQwQ
 3xyBTOFq4CD0fbhlimpa8mukamYs6e4YSrieqiuW60AY/G/B7EQ2yfIjZd0LkShAI6L6
 AdgQri5c8YZwdv8W2uBFogmXjDGJjZ5thbMVabQnwE3E5hk6ShehMMeEGgcGHCmDZLeW
 itubJ4CVgFw6aN3xSYppKJyDs5NU7h2q0H+C5Jh9Gqse5HdJu4x5tknbHrNbOaZ/CoAS
 +7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/bRkqjyelCT2BwKXDL2kk3eM+ea/9WF6lbhTPLqyzQs=;
 b=zxi023wb6UNoib0ZPYN20NOgv12fPm6QKzXm1nz+kEv9046wNpcavwbvdJOe7lCVD8
 UZODSM+Rsye9uSGCRZCKuItZdQnWbRM2gIHM3cudAb+AkIcAulbELgbUHHBa0/HuzmTk
 6avFx1KSzIH9SQmrDVsMDVI5NnC47IngsOzCOMn1LvXChV/zlL3a2RLtgSz0yKCoc65E
 N0T0QaqIfs3ei1IjVm3Uq9dYEnbbvoGi+DNGr91H8/hKpe+tRnhFpouuqzke7bxy1AKw
 2yCgWU9ef29kKwpkPEiwRbibIfNyxUKVXyDW1KbteGySHRYX91ABUzWzxq0g1GPLsu8b
 mh7A==
X-Gm-Message-State: ACrzQf3H64DOesOT20wiOu3tk8rNq+lLWvsT4VPfNzbLBRA7RedL/xXG
 weTjX98MPJYXe0uOv5k96bh2K5ka4XaU
X-Google-Smtp-Source: AMsMyM6kz2VVfMezIhOWhcHrz/hGAETOYwjma0z07Lmtkc6uNWWu17KZrnMVkVuR1GhaX/Tp0luYpM2CFjFt
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:6902:1206:b0:6c0:2863:c15c with SMTP
 id s6-20020a056902120600b006c02863c15cmr68406659ybu.117.1668618227919; Wed,
 16 Nov 2022 09:03:47 -0800 (PST)
Date: Wed, 16 Nov 2022 17:03:27 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-5-qperret@google.com>
Subject: [PATCH 04/12] KVM: arm64: Probe FF-A version and host/hyp partition
 ID during init
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Oliver Upton <oliver.upton@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Andrew Walbran <qwandor@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

From: Will Deacon <will@kernel.org>

Probe FF-A during pKVM initialisation so that we can detect any
inconsistencies in the version or partition ID early on.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h     |  1 +
 arch/arm64/kvm/arm.c                  |  1 +
 arch/arm64/kvm/hyp/include/nvhe/ffa.h |  1 +
 arch/arm64/kvm/hyp/nvhe/ffa.c         | 30 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c       |  5 +++++
 5 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 63307e7dc9c5..ab5ccf47c05f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -347,6 +347,7 @@ struct kvm_host_data {
 struct kvm_host_psci_config {
 	/* PSCI version used by host. */
 	u32 version;
+	u32 smccc_version;
 
 	/* Function IDs used by host if version is v0.1. */
 	struct psci_0_1_function_ids function_ids_0_1;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1d1a3b93a3de..8b93af23f327 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1780,6 +1780,7 @@ static bool init_psci_relay(void)
 	}
 
 	kvm_host_psci_config.version = psci_ops.get_version();
+	kvm_host_psci_config.smccc_version = arm_smccc_get_version();
 
 	if (kvm_host_psci_config.version == PSCI_VERSION(0, 1)) {
 		kvm_host_psci_config.function_ids_0_1 = get_psci_0_1_function_ids();
diff --git a/arch/arm64/kvm/hyp/include/nvhe/ffa.h b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
index fc09ec671e24..5c9b92430ff3 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/ffa.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
@@ -11,6 +11,7 @@
 #define FFA_MIN_FUNC_NUM 0x60
 #define FFA_MAX_FUNC_NUM 0x7F
 
+int hyp_ffa_init(void);
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt);
 
 #endif /* __KVM_HYP_FFA_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 6ccf935d3b41..969d72390844 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -31,6 +31,12 @@
 #include <nvhe/ffa.h>
 #include <nvhe/trap_handler.h>
 
+/*
+ * "ID value 0 must be returned at the Non-secure physical FF-A instance"
+ * We share this ID with the host.
+ */
+#define HOST_FFA_ID	0
+
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
 	*res = (struct arm_smccc_res) {
@@ -111,3 +117,27 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 	ffa_set_retval(host_ctxt, &res);
 	return true;
 }
+
+int hyp_ffa_init(void)
+{
+	struct arm_smccc_res res;
+
+	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
+		return 0;
+
+	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 == FFA_RET_NOT_SUPPORTED)
+		return 0;
+
+	if (res.a0 != FFA_VERSION_1_0)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != FFA_SUCCESS)
+		return -EOPNOTSUPP;
+
+	if (res.a2 != HOST_FFA_ID)
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 110f04627785..c4ca174a0592 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -11,6 +11,7 @@
 #include <asm/kvm_pkvm.h>
 
 #include <nvhe/early_alloc.h>
+#include <nvhe/ffa.h>
 #include <nvhe/fixed_config.h>
 #include <nvhe/gfp.h>
 #include <nvhe/memory.h>
@@ -314,6 +315,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = hyp_ffa_init();
+	if (ret)
+		goto out;
+
 	pkvm_hyp_vm_table_init(vm_table_base);
 out:
 	/*
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
