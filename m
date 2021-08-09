Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E92903E48B3
	for <lists+kvmarm@lfdr.de>; Mon,  9 Aug 2021 17:25:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B6A34B112;
	Mon,  9 Aug 2021 11:25:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBV8TIfr5bbg; Mon,  9 Aug 2021 11:25:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46D0F4B103;
	Mon,  9 Aug 2021 11:25:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80C2949F6C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 11:25:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VRjrgWi65lEa for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Aug 2021 11:25:20 -0400 (EDT)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1EE0C4A3A3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 11:25:18 -0400 (EDT)
Received: by mail-qk1-f201.google.com with SMTP id
 o6-20020a05620a0546b02903d22e7d9864so1534184qko.16
 for <kvmarm@lists.cs.columbia.edu>; Mon, 09 Aug 2021 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=8jz2lJsOdyZcDtlCHC3Dvx0yZKTs2N3b55wAk/v95ow=;
 b=BDFa2yN6cmKJG3x9zJSFyiSyGXrWwbQI3EkRXEyAoiDsNiZxnCuM7yr8Oa4sS4dxId
 5eKr+FKgGlQq97sho5QfjNNpY4QVEgOwGe4qnto8+PH1sPYKxvsSFFEWd/WmFfbdUvkD
 c3sroI1akznW1wvpagXKal01dux4IP23CQRoyQzKlB2Hq7vZwlRmeuzMiiGUULtM74EO
 vqk/PboQA93VAnMy1vjV9PrMoZNR67MMoGR8eoMC8skkuWKBSfLRX65XrYlx1k9PzQEL
 B4Vu9eiDVi86Co2QUmAnVC43oq9HYU5EMtVUKZQVLmLRE/lJ3PSGixyaFvXfy8rmzq2H
 k/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=8jz2lJsOdyZcDtlCHC3Dvx0yZKTs2N3b55wAk/v95ow=;
 b=HOmKZ0XyRzCKUjvFE70kUNGei6WGvx6gm5ek0+5EDgm+Tcd2lYzKP7j2+QL2qVSX0B
 Y6c7rBy9IgLd46Ylv2//dKa46rCI+Hvtx5/kFlQma2e1hNFZ0TbZGTSkjyPDXLDd3t+V
 vTrNOeYJtss7rMalNKDldutdKFZY0pcZjcdN4prY0Abz5zhDXw7dTmaC9KyiBSYh0V/U
 VxKJ7gtB3w9a35Mune/6q1LvshUz3vInIm3X43aSkmLFnTh1gg4fnRTmJfrzdPERnUaw
 hqaPVBpPq7jcfj+T4vcoXVGoeLeirW1fFDEOtNA6wfraIwBTZbl51DTE3lZHsT5AQOxT
 zw+A==
X-Gm-Message-State: AOAM530Q++TiefMuZtE7Y6mgvC7kbT1dEinhvXJjEqtvWzdu0Qx8XKGX
 bLtyvTZzcsDlvlu9CbzqCaoANCqdLrtX
X-Google-Smtp-Source: ABdhPJz2l1NOBwMrE26TsCA7occvb2o9beTqoSppx2h3dHXwe0dIzSOg5MwgreJKvwJvtlmSCeojgXOCjH28
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr24445444qvs.58.1628522717738; Mon, 09 Aug 2021 08:25:17 -0700 (PDT)
Date: Mon,  9 Aug 2021 16:24:39 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-13-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 12/21] KVM: arm64: Add helpers to tag shared pages in SW
 bits
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, 
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc: qwandor@google.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
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

We will soon start annotating shared pages in page-tables in nVHE
protected mode. Define all the states in which a page can be (owned,
shared and owned, shared and borrowed), and provide helpers allowing to
convert this into SW bits annotations using the matching prot
attributes.

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9c227d87c36d..87b1690c439f 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -12,6 +12,32 @@
 #include <asm/virt.h>
 #include <nvhe/spinlock.h>
 
+/*
+ * SW bits 0-1 are reserved to track the memory ownership state of each page:
+ *   00: The page is owned exclusively by the page-table owner.
+ *   01: The page is owned by the page-table owner, but is shared
+ *       with another entity.
+ *   10: The page is shared with, but not owned by the page-table owner.
+ *   11: Reserved for future use (lending).
+ */
+enum pkvm_page_state {
+	PKVM_PAGE_OWNED			= 0ULL,
+	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
+	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
+};
+
+#define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
+static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
+						 enum pkvm_page_state state)
+{
+	return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
+}
+
+static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
+{
+	return prot & PKVM_PAGE_STATE_PROT_MASK;
+}
+
 struct host_kvm {
 	struct kvm_arch arch;
 	struct kvm_pgtable pgt;
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
