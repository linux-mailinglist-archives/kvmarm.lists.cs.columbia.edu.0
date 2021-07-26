Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE963D5697
	for <lists+kvmarm@lfdr.de>; Mon, 26 Jul 2021 11:29:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE6B94ACC9;
	Mon, 26 Jul 2021 05:29:46 -0400 (EDT)
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
	with ESMTP id So502VKkXqZK; Mon, 26 Jul 2021 05:29:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 435C34A1FA;
	Mon, 26 Jul 2021 05:29:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 58A2C4A551
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 05:29:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WEAeWk2ZpE0h for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Jul 2021 05:29:43 -0400 (EDT)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D897C4A522
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 05:29:42 -0400 (EDT)
Received: by mail-qt1-f201.google.com with SMTP id
 15-20020ac84e8f0000b029024e8c2383c1so4051141qtp.5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=6dY3W9X/AGxD9r1RRTSS9yD4t5RoHsE1QSE3BCqo+aE=;
 b=Ww9dZYatKjMjIjIW2ylBqljvFXMjm0aQtmZZd32Hr/KhiQqtTftNNfU69HEOr0lDbm
 zKee/K1VB/L+wtlEDRN5rVkSG/delJAR7PejN/gdK8Jfu8lQAw3AbAugd/GC3GoKPdRM
 kLKaIWP/+D4QBdboQQ3q/eARC/T+BaNDzFr77y3qvaXSJzgq2aV2CNkWnUuT5eK7E1vI
 iPbtNmIcBPgzr/nU52DfK1/CvEFwtQ0pEtbAe48HgEUDcRebZvoACysb+/jnYB2DPFmN
 wGmU9dDogUx6Isrlkg+YCz3jySICBEXb7IY5wYtN7RAnqe7ILDgtZZJ2mLrbRgZcpEVn
 WuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=6dY3W9X/AGxD9r1RRTSS9yD4t5RoHsE1QSE3BCqo+aE=;
 b=Y+7fqyGM+reGSeAF4jl5tzFkwoopOk4h16osDYdh96U8/1lS5RcUtQcklRyLlPwZcZ
 VRLtIy0v5H4TFsuDuwKZwWbmrfbbMJwgtiCoMF27RIwpYUO/SWuKHuV4+SoF/1lyMRzw
 9gpCJ1xFRBigGBQ9ydx/UItUJn8lhsj3MPDNdY7bRNEd4eTS8lcQEGpgNU0vWwRSrg7D
 7DCxMIIzbi+G6z/ohQaK7osBwY+Ft7GUZ5r4BaGYA91Aw5xVwrfoHok437AsYU9kDYFg
 d5KKWtS+Ay7yi9B37WYbGHx0E0xB8LjgwcoivEr5mq7CKaBGVn/Ae11P0/iDORMbvDf5
 LHGg==
X-Gm-Message-State: AOAM533pl39feMBIGAlV98f0R2T4sU/DCzCJJLS7LuqxhlGkEHD9ErsA
 DWJLxD7sZCHFIghZNruqFo96vVYAF6zG
X-Google-Smtp-Source: ABdhPJxja1z3cl1S4eHZsbLWfOgzNw9V3DmMjl7MkdDjMfOUrn37i6l0Vcan0CxmYEphVI3A4P6qPR4TuQL7
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:e83:: with SMTP id
 hf3mr17024207qvb.19.1627291782528; Mon, 26 Jul 2021 02:29:42 -0700 (PDT)
Date: Mon, 26 Jul 2021 10:29:03 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-15-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 14/16] KVM: arm64: Refactor protected nVHE stage-1 locking
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

Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
a new pkvm_create_mappings_locked() function. This will be used in later
patches to allow walking and changing the hypervisor stage-1 without
releasing the lock.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mm.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 8ec3a5a7744b..c76d7136ed9b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -23,6 +23,7 @@ int hyp_map_vectors(void);
 int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
 int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
 int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
 int __pkvm_create_mappings(unsigned long start, unsigned long size,
 			   unsigned long phys, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index a8efdf0f9003..256cbe5c0dca 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -67,7 +67,8 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 	return addr;
 }
 
-int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+/* Must be called with the pkvm_pgd_lock held */
+int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
 {
 	unsigned long start = (unsigned long)from;
 	unsigned long end = (unsigned long)to;
@@ -81,7 +82,8 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 		int err;
 
 		phys = hyp_virt_to_phys((void *)virt_addr);
-		err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
+		err = kvm_pgtable_hyp_map(&pkvm_pgtable, virt_addr, PAGE_SIZE,
+					  phys, prot);
 		if (err)
 			return err;
 	}
@@ -89,6 +91,17 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
+int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+{
+	int ret;
+
+	hyp_spin_lock(&pkvm_pgd_lock);
+	ret = pkvm_create_mappings_locked(from, to, prot);
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return ret;
+}
+
 int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back)
 {
 	unsigned long start, end;
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
