Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC75F812B
	for <lists+kvmarm@lfdr.de>; Sat,  8 Oct 2022 01:29:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CA974B17C;
	Fri,  7 Oct 2022 19:29:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sTCDz2DYFSdy; Fri,  7 Oct 2022 19:29:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF7E940E25;
	Fri,  7 Oct 2022 19:29:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C8C7C40B90
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Oct 2022 19:29:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgG4R4B+ETqQ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Oct 2022 19:29:20 -0400 (EDT)
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 72EF840DE6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Oct 2022 19:29:20 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1665185359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jR0mg6F8PD1PCyPLvjPpIf4XFeLVY65l9bZKLjv3zhU=;
 b=HxSTwqdNf+XmR5qSybbUP8Ecxwyc7kP0pm7o5Ek+YMj4MJPcXStljuG4RX1rxw9HlWqgi6
 riIlw0EqXa83Dq8JW7YoP9dul5GB4Yb5W4R63kew8lZfuXtG9zUjVpyuEhYMTavMloU26L
 qTEBMJZlwc7zhGX4j1hovumn4WtPHcg=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v2 08/15] KVM: arm64: Protect stage-2 traversal with RCU
Date: Fri,  7 Oct 2022 23:28:11 +0000
Message-Id: <20221007232818.459650-9-oliver.upton@linux.dev>
In-Reply-To: <20221007232818.459650-1-oliver.upton@linux.dev>
References: <20221007232818.459650-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

The use of RCU is necessary to safely change the stage-2 page tables in
parallel. Acquire and release the RCU read lock when traversing the page
tables.

Use the _raw() flavor of rcu_dereference when changes to the page tables
are otherwise protected from parallel software walkers (e.g. holding the
write lock).

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/kvm_pgtable.h | 34 ++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         |  7 +++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index beb89eac155c..60c37e5e77dd 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -25,6 +25,13 @@ static inline u64 kvm_get_parange(u64 mmfr0)
 
 typedef u64 kvm_pte_t;
 
+/*
+ * RCU cannot be used in a non-kernel context such as the hyp. As such, page
+ * table walkers used in hyp do not call into RCU and instead use other
+ * synchronization mechanisms (such as a spinlock).
+ */
+#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
+
 typedef kvm_pte_t *kvm_pteref_t;
 
 static inline kvm_pte_t *kvm_dereference_pteref(kvm_pteref_t pteref, bool shared)
@@ -32,6 +39,33 @@ static inline kvm_pte_t *kvm_dereference_pteref(kvm_pteref_t pteref, bool shared
 	return pteref;
 }
 
+static inline void kvm_pgtable_walk_begin(void) {}
+static inline void kvm_pgtable_walk_end(void) {}
+
+#else
+
+typedef kvm_pte_t __rcu *kvm_pteref_t;
+
+static inline kvm_pte_t *kvm_dereference_pteref(kvm_pteref_t pteref, bool shared)
+{
+	if (shared)
+		return rcu_dereference(pteref);
+
+	return rcu_dereference_raw(pteref);
+}
+
+static inline void kvm_pgtable_walk_begin(void)
+{
+	rcu_read_lock();
+}
+
+static inline void kvm_pgtable_walk_end(void)
+{
+	rcu_read_unlock();
+}
+
+#endif
+
 #define KVM_PTE_VALID			BIT(0)
 
 #define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 6b6e1ed7ee2f..c2be15850497 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -281,8 +281,13 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.end	= PAGE_ALIGN(walk_data.addr + size),
 		.walker	= walker,
 	};
+	int r;
 
-	return _kvm_pgtable_walk(pgt, &walk_data);
+	kvm_pgtable_walk_begin();
+	r = _kvm_pgtable_walk(pgt, &walk_data);
+	kvm_pgtable_walk_end();
+
+	return r;
 }
 
 struct leaf_walk_data {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
