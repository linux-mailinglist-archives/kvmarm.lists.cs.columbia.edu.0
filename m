Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 50DAA475CFC
	for <lists+kvmarm@lfdr.de>; Wed, 15 Dec 2021 17:13:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F131B4B201;
	Wed, 15 Dec 2021 11:13:00 -0500 (EST)
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
	with ESMTP id mPvTkriJ859W; Wed, 15 Dec 2021 11:13:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D4D44B1E3;
	Wed, 15 Dec 2021 11:12:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 33D384B119
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Dec 2021 11:12:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hV0qnWaPxtsW for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Dec 2021 11:12:57 -0500 (EST)
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B528C4B1E3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Dec 2021 11:12:57 -0500 (EST)
Received: by mail-wr1-f74.google.com with SMTP id
 x20-20020adfbb54000000b001a0d044e20fso1752140wrg.11
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Dec 2021 08:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ynF5lWvyiEFeIgUvxnlGN+fY90UCVaWVJ6r5LvF4TWY=;
 b=Z2bHKM6wBp9WnHm2RC+jSBb+1SB32iP9QhizIbhIErFB2+qCbRnYlbIotlBafMopur
 hac0wkBDsatfSzXXy8pdAx6rMwgY/jfNU8CHvQTFegTor4Qe3PBHLff7Wy2+Ivr8ZuDv
 zJ0FH+ethDYoeeJwxDEex5obvhi9i88xDwkOiQwKsVwrl28RQkhpkyTlt+rCLDAAIrAd
 AMttVGcClfOjioeT0j3Nr1ssCaL+wsx8QzYcfPyx86j16O36ZCpMNHZb12ABFjNobxZK
 n3Iiyvai6haQIoQOIFpmRG5gvvBtUjGn/05wqjE0Wk50DukCvN5/XLN/zEgEGfx+dXah
 U7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ynF5lWvyiEFeIgUvxnlGN+fY90UCVaWVJ6r5LvF4TWY=;
 b=oz2pX9Ebb+IQWg/Qb/Xq4y8x8z9SHbLaRusUvsDYzIemNamixqsclFhEA2p1XfQ0sf
 zE5FGbg3TbL1YfutxrHDc4b8c7tX+Fk0N4rpYkSzNWT5amJ/Hh6/NAeQebRKGNPbOe1s
 ch/Ej+7WTbN7ldJwY5Q6TjAV4H4g4DOBaRWvcZGI1wWQhIwGf80P4C79ICD8lzJ8LQEe
 oTyfmxWMF0DVqtemYF4oTMuqdRSl89O2xsbuFqAtwWJjJh7//Msc/7M9KAckoVIl2MFO
 6Lr3XPNu7Pj+W1k+jHdojIyak1XIa2TbbtnesagBchLlCbMKLANdvDvakyWmMvigpPs9
 U45Q==
X-Gm-Message-State: AOAM530nfQ9vcJfbEmI/cbKzj9Zd/FbpFsJe09qe6u8KQyss2ckWrFYu
 U1l9opmjnj3fDzcLlfHrMaO16lfUvOu1
X-Google-Smtp-Source: ABdhPJwQrmB63I33rYFWRbLk36OUKQ48YQKkPHhLj3/UyrM3DSZUyiBypkgiW3maONiY0gjgeTRYUoMH96Mt
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:adf:fc88:: with SMTP id
 g8mr5002042wrr.334.1639584776847; Wed, 15 Dec 2021 08:12:56 -0800 (PST)
Date: Wed, 15 Dec 2021 16:12:22 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-6-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 05/14] KVM: arm64: Implement kvm_pgtable_hyp_unmap() at EL2
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: qwandor@google.com, linux-kernel@vger.kernel.org, kernel-team@android.com,
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

From: Will Deacon <will@kernel.org>

Implement kvm_pgtable_hyp_unmap() which can be used to remove hypervisor
stage-1 mappings at EL2.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 21 ++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 63 ++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 027783829584..9d076f36401d 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -251,6 +251,27 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt);
 int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 			enum kvm_pgtable_prot prot);
 
+/**
+ * kvm_pgtable_hyp_unmap() - Remove a mapping from a hypervisor stage-1 page-table.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_hyp_init().
+ * @addr:	Virtual address from which to remove the mapping.
+ * @size:	Size of the mapping.
+ *
+ * The offset of @addr within a page is ignored, @size is rounded-up to
+ * the next page boundary and @phys is rounded-down to the previous page
+ * boundary.
+ *
+ * TLB invalidation is performed for each page-table entry cleared during the
+ * unmapping operation and the reference count for the page-table page
+ * containing the cleared entry is decremented, with unreferenced pages being
+ * freed. The unmapping operation will stop early if it encounters either an
+ * invalid page-table entry or a valid block mapping which maps beyond the range
+ * being unmapped.
+ *
+ * Return: Number of bytes unmapped, which may be 0.
+ */
+u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
+
 /**
  * kvm_get_vtcr() - Helper to construct VTCR_EL2
  * @mmfr0:	Sanitized value of SYS_ID_AA64MMFR0_EL1 register.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index e50e9158fc56..adc73f8cd24f 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -451,6 +451,69 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 	return ret;
 }
 
+struct hyp_unmap_data {
+	u64				unmapped;
+	struct kvm_pgtable_mm_ops	*mm_ops;
+};
+
+static int hyp_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+			    enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	kvm_pte_t pte = *ptep, *childp = NULL;
+	u64 granule = kvm_granule_size(level);
+	struct hyp_unmap_data *data = arg;
+	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
+
+	if (!kvm_pte_valid(pte))
+		return -EINVAL;
+
+	if (kvm_pte_table(pte, level)) {
+		childp = kvm_pte_follow(pte, mm_ops);
+
+		if (mm_ops->page_count(childp) != 1)
+			return 0;
+
+		kvm_clear_pte(ptep);
+		dsb(ishst);
+		__tlbi_level(vae2is, __TLBI_VADDR(addr, 0), level);
+	} else {
+		if (end - addr < granule)
+			return -EINVAL;
+
+		kvm_clear_pte(ptep);
+		dsb(ishst);
+		__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), level);
+		data->unmapped += granule;
+	}
+
+	dsb(ish);
+	isb();
+	mm_ops->put_page(ptep);
+
+	if (childp)
+		mm_ops->put_page(childp);
+
+	return 0;
+}
+
+u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	struct hyp_unmap_data unmap_data = {
+		.mm_ops	= pgt->mm_ops,
+	};
+	struct kvm_pgtable_walker walker = {
+		.cb	= hyp_unmap_walker,
+		.arg	= &unmap_data,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+	};
+
+	if (!pgt->mm_ops->page_count)
+		return 0;
+
+	kvm_pgtable_walk(pgt, addr, size, &walker);
+	return unmap_data.unmapped;
+}
+
 int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
 			 struct kvm_pgtable_mm_ops *mm_ops)
 {
-- 
2.34.1.173.g76aa8bc2d0-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
