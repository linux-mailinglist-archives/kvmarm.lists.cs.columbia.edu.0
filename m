Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5862C5CC
	for <lists+kvmarm@lfdr.de>; Wed, 16 Nov 2022 18:04:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F5AB4B8F6;
	Wed, 16 Nov 2022 12:04:10 -0500 (EST)
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
	with ESMTP id 13V+WxHSsH7c; Wed, 16 Nov 2022 12:04:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E126A4B904;
	Wed, 16 Nov 2022 12:04:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A9014B8EE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 12:04:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fNyqB8wNJxFD for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Nov 2022 12:04:00 -0500 (EST)
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 748C54B916
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 12:03:56 -0500 (EST)
Received: by mail-ej1-f74.google.com with SMTP id
 ne36-20020a1709077ba400b007aeaf3dcbcaso9698078ejc.6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dKmpRv9oYnAFUmNC2vB3bCF8nzlsd9JVBa/slHAfN6o=;
 b=CLgMgrrcH6xqRvc7dNBg0nJ8Wy/hwMjHvKv0ZdsqRx0VWo1ppcKFPZv2Vl4sa0XbtH
 /P+9e75YOS4CES7toeMWS2XqDGWw2Z3dMQdTpDFU4FAf1tVxHg+cuaMV7tj9ZMu+1OBg
 t03GWHD0qg+0WLX9IUBrp0PplHDIIjODI5JSf1ne+yIq5pX7WNxv/XcfUbmi4uPmiP46
 zo3d9hT6Mmqv4/GR8dFrNTdkA0OhSPHHFc/ja6tobeTaN4+SJDAYgxlvz5BifkAg8D66
 FTLFI4W7VlXvmtTFQVki2oNpx+mfi8yCGf3HOcE4PZfLM7CtWsjWfMS6WfWM2UNLipL4
 BD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKmpRv9oYnAFUmNC2vB3bCF8nzlsd9JVBa/slHAfN6o=;
 b=HSZGpMGZF1oOQ//VaFdsRT+qLSnWSJxt0xfPgvcqFNvUvDA92bNtil3N1bNN+QSrQ/
 +dnU6v/oZ7xwRH3P8GeJ7WIdU8lY7gJDdvCz2l4Xqfzox7wlaV6VFMlGZsiagOdZ+hoW
 446F1mtpeWqMqCm5X2DEXmpiN6iBimbmUp0KyOdLMUboV7Xm4YMU1SWgl3i+myuqut5i
 e38s4FEFjQ1ILBojB565Ukz1xRL+RkmLXNSGkGi8LPXzl8BYo4xn+/OtfauOjtFMdOwD
 X5U2GQfjV8Yk/akCu8Y/0w9Aa8PDV8bW+xACq8690TLuV/PPf4cx98UWelI9tPR/Mz/C
 OrbQ==
X-Gm-Message-State: ANoB5pk9htYT9P0fjabhIwpTPIpuqCXFeuvFhmLQrcovGL4xswRb6nw+
 TOnCnFpEwHRtkBVNzc/GBXv/wztMuFhB
X-Google-Smtp-Source: AA0mqf5Zh1E2Jq1JH4007iv1JNaQg8tonRvU0GAtnvQjndQkafqFq3DeYbzdetpEQAWaQCv6X1dKLc90yop4
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:6402:b61:b0:461:ed40:c2f2 with SMTP id
 cb1-20020a0564020b6100b00461ed40c2f2mr19383579edb.404.1668618235659; Wed, 16
 Nov 2022 09:03:55 -0800 (PST)
Date: Wed, 16 Nov 2022 17:03:30 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-8-qperret@google.com>
Subject: [PATCH 07/12] KVM: arm64: Handle FFA_RXTX_MAP and FFA_RXTX_UNMAP
 calls from the host
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

Handle FFA_RXTX_MAP and FFA_RXTX_UNMAP calls from the host by sharing
the host's mailbox memory with the hypervisor and establishing a
separate pair of mailboxes between the hypervisor and the SPMD at EL3.

Co-developed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 173 ++++++++++++++++++++++++++++++++++
 include/linux/arm_ffa.h       |   8 ++
 2 files changed, 181 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 7cb9095e00ff..8388cc901c97 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -31,6 +31,8 @@
 #include <asm/kvm_pkvm.h>
 
 #include <nvhe/ffa.h>
+#include <nvhe/mem_protect.h>
+#include <nvhe/memory.h>
 #include <nvhe/trap_handler.h>
 #include <nvhe/spinlock.h>
 
@@ -52,6 +54,7 @@ struct kvm_ffa_buffers {
  * client.
  */
 static struct kvm_ffa_buffers hyp_buffers;
+static struct kvm_ffa_buffers host_buffers;
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
@@ -71,6 +74,11 @@ static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
 	}
 }
 
+static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
+{
+	ffa_to_smccc_res_prop(res, ret, 0);
+}
+
 static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 			   struct arm_smccc_res *res)
 {
@@ -88,6 +96,140 @@ static bool is_ffa_call(u64 func_id)
 	       ARM_SMCCC_FUNC_NUM(func_id) <= FFA_MAX_FUNC_NUM;
 }
 
+static int spmd_map_ffa_buffers(u64 ffa_page_count)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_smc(FFA_FN64_RXTX_MAP,
+			  hyp_virt_to_phys(hyp_buffers.tx),
+			  hyp_virt_to_phys(hyp_buffers.rx),
+			  ffa_page_count,
+			  0, 0, 0, 0,
+			  &res);
+
+	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
+}
+
+static int spmd_unmap_ffa_buffers(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_smc(FFA_RXTX_UNMAP,
+			  HOST_FFA_ID,
+			  0, 0, 0, 0, 0, 0,
+			  &res);
+
+	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
+}
+
+static void do_ffa_rxtx_map(struct arm_smccc_res *res,
+			    struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(phys_addr_t, tx, ctxt, 1);
+	DECLARE_REG(phys_addr_t, rx, ctxt, 2);
+	DECLARE_REG(u32, npages, ctxt, 3);
+	int ret = 0;
+	void *rx_virt, *tx_virt;
+
+	if (npages != (KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) / FFA_PAGE_SIZE) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	if (!PAGE_ALIGNED(tx) || !PAGE_ALIGNED(rx)) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	hyp_spin_lock(&host_buffers.lock);
+	if (host_buffers.tx) {
+		ret = FFA_RET_DENIED;
+		goto out_unlock;
+	}
+
+	ret = spmd_map_ffa_buffers(npages);
+	if (ret)
+		goto out_unlock;
+
+	ret = __pkvm_host_share_hyp(hyp_phys_to_pfn(tx));
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unmap;
+	}
+
+	ret = __pkvm_host_share_hyp(hyp_phys_to_pfn(rx));
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unshare_tx;
+	}
+
+	tx_virt = hyp_phys_to_virt(tx);
+	ret = hyp_pin_shared_mem(tx_virt, tx_virt + 1);
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unshare_rx;
+	}
+
+	rx_virt = hyp_phys_to_virt(rx);
+	ret = hyp_pin_shared_mem(rx_virt, rx_virt + 1);
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unpin_tx;
+	}
+
+	host_buffers.tx = tx_virt;
+	host_buffers.rx = rx_virt;
+
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+out:
+	ffa_to_smccc_res(res, ret);
+	return;
+
+err_unpin_tx:
+	hyp_unpin_shared_mem(tx_virt, tx_virt + 1);
+err_unshare_rx:
+	__pkvm_host_unshare_hyp(hyp_phys_to_pfn(rx));
+err_unshare_tx:
+	__pkvm_host_unshare_hyp(hyp_phys_to_pfn(tx));
+err_unmap:
+	spmd_unmap_ffa_buffers();
+	goto out_unlock;
+}
+
+static void do_ffa_rxtx_unmap(struct arm_smccc_res *res,
+			      struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, id, ctxt, 1);
+	int ret = 0;
+
+	if (id != HOST_FFA_ID) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	hyp_spin_lock(&host_buffers.lock);
+	if (!host_buffers.tx) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	hyp_unpin_shared_mem(host_buffers.tx, host_buffers.tx + 1);
+	WARN_ON(__pkvm_host_unshare_hyp(hyp_virt_to_pfn(host_buffers.tx)));
+	host_buffers.tx = NULL;
+
+	hyp_unpin_shared_mem(host_buffers.rx, host_buffers.rx + 1);
+	WARN_ON(__pkvm_host_unshare_hyp(hyp_virt_to_pfn(host_buffers.rx)));
+	host_buffers.rx = NULL;
+
+	spmd_unmap_ffa_buffers();
+
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+out:
+	ffa_to_smccc_res(res, ret);
+}
+
 static bool ffa_call_unsupported(u64 func_id)
 {
 	switch (func_id) {
@@ -159,7 +301,11 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 		goto out_handled;
 	/* Memory management */
 	case FFA_FN64_RXTX_MAP:
+		do_ffa_rxtx_map(&res, host_ctxt);
+		goto out_handled;
 	case FFA_RXTX_UNMAP:
+		do_ffa_rxtx_unmap(&res, host_ctxt);
+		goto out_handled;
 	case FFA_MEM_SHARE:
 	case FFA_FN64_MEM_SHARE:
 	case FFA_MEM_LEND:
@@ -181,6 +327,7 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 int hyp_ffa_init(void *pages)
 {
 	struct arm_smccc_res res;
+	size_t min_rxtx_sz;
 
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
@@ -199,11 +346,37 @@ int hyp_ffa_init(void *pages)
 	if (res.a2 != HOST_FFA_ID)
 		return -EINVAL;
 
+	arm_smccc_1_1_smc(FFA_FEATURES, FFA_FN64_RXTX_MAP,
+			  0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != FFA_SUCCESS)
+		return -EOPNOTSUPP;
+
+	switch (res.a2) {
+	case FFA_FEAT_RXTX_MIN_SZ_4K:
+		min_rxtx_sz = SZ_4K;
+		break;
+	case FFA_FEAT_RXTX_MIN_SZ_16K:
+		min_rxtx_sz = SZ_16K;
+		break;
+	case FFA_FEAT_RXTX_MIN_SZ_64K:
+		min_rxtx_sz = SZ_64K;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (min_rxtx_sz > PAGE_SIZE)
+		return -EOPNOTSUPP;
+
 	hyp_buffers = (struct kvm_ffa_buffers) {
 		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
 		.tx	= pages,
 		.rx	= pages + (KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE),
 	};
 
+	host_buffers = (struct kvm_ffa_buffers) {
+		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
+	};
+
 	return 0;
 }
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index c87aeecaa9b2..b9f81035eb41 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -94,6 +94,14 @@
  */
 #define FFA_PAGE_SIZE		SZ_4K
 
+/*
+ * Minimum buffer size/alignment encodings returned by an FFA_FEATURES
+ * query for FFA_RXTX_MAP.
+ */
+#define FFA_FEAT_RXTX_MIN_SZ_4K		0
+#define FFA_FEAT_RXTX_MIN_SZ_64K	1
+#define FFA_FEAT_RXTX_MIN_SZ_16K	2
+
 /* FFA Bus/Device/Driver related */
 struct ffa_device {
 	int vm_id;
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
