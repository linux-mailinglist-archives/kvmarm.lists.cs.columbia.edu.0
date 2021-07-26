Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EF8613D5696
	for <lists+kvmarm@lfdr.de>; Mon, 26 Jul 2021 11:29:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2A564B087;
	Mon, 26 Jul 2021 05:29:44 -0400 (EDT)
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
	with ESMTP id ynK5qZ7PrwVE; Mon, 26 Jul 2021 05:29:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FAA14B085;
	Mon, 26 Jul 2021 05:29:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B997A406E0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 05:29:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFY3oNu0Eu8z for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Jul 2021 05:29:40 -0400 (EDT)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B60F84B081
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 05:29:40 -0400 (EDT)
Received: by mail-qk1-f202.google.com with SMTP id
 p123-20020a378d810000b02903ad5730c883so8414110qkd.22
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=tkKuELagekwMv5lJ5KC16O2ECB7SNyEmk6kFSF/fHxM=;
 b=nk3MJc1TvlrOLzzIkiMf4rqf5hlIGKplrBy0rbLmw27uz1W6VBHL3ebA0vXPU5hqe/
 QoJ1dpPFJWYNA881TkoFyPstgtGjtstMfCXCBrv86MDx6OrlwzOGtjIAWJB+y8Ts/OF/
 uzElj+Fi5baAI3+Gd7/gAYFnufyRr/kcef4dno05tPLzPDrZFvZW5Zw4E6oA8mNnAsqz
 kmK+rxP55y6Q7IRGVH0DsjQTrpuBlDwMkGE8Q0sdJ2BOb5c9+MDQuNfFTrhqhDtnWWJT
 8Dkhb+jqs5SFv774P+xFvG/36uFaxoBLVLa+7H3VSPMzcE0DjbMAeNFWU0F9g6VrRrc8
 SSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=tkKuELagekwMv5lJ5KC16O2ECB7SNyEmk6kFSF/fHxM=;
 b=Tn8Tf1vErAsNXnvC7u+4n1Q7RM+k2mvhrS8uFTJ0ycNqCeO1lLc6cMPbeKTG/C4v9g
 jmQyfvlAfzKcabjjd+0QuhK72fmrrcQaO4OBJ3y50rHGSpQzit8kmaV+FjTmPIWttCWy
 g3uXz//rnLSN6ce5DerKOJeg+pf06lzVuua3L4yiBMlgrwFJGS+zyUlhPA9HLGR9GTdz
 nNHD1CAQhNJh5brriuXkQiaW/Etnr4Wn7K7bAmtzLfPk+6akRzbkoOVJedkLcEOdY+d3
 jCtmjhJ26fxE9vOpWC+ZUdP3AIdRFzXglxv6aeH4ZEsdpoBgR30jmNhOmxc6E7AV9zF4
 96DQ==
X-Gm-Message-State: AOAM532toaJvPd7Zyduv0lme5kVvbLLYJPFzvXsRh+JLC8f2mkTItS+9
 IlFToX8PgcbFOg3FVduqki4t67BQBYZf
X-Google-Smtp-Source: ABdhPJw/Ly763xE6/tFkoek1tqopFddG61YOXzM273sCNQ1M4TAjeeg9umQGIef8D0FMW2bam9q3NSXPHFid
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:188c:: with SMTP id
 cx12mr16903787qvb.7.1627291780379; Mon, 26 Jul 2021 02:29:40 -0700 (PDT)
Date: Mon, 26 Jul 2021 10:29:02 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-14-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 13/16] KVM: arm64: Enable retrieving protections attributes
 of PTEs
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

Introduce helper functions in the KVM stage-2 and stage-1 page-table
manipulation library allowing to retrieve the enum kvm_pgtable_prot of a
PTE. This will be useful to implement custom walkers outside of
pgtable.c.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 20 +++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 37 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 0be9f83974ad..f253fb5bcee2 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -492,4 +492,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  */
 int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
 			 kvm_pte_t *ptep, u32 *level);
+
+/**
+ * kvm_pgtable_stage2_pte_prot() - Retrieve the protection attributes of a
+ *				   stage-2 Page-Table Entry.
+ * @pte:	Page-table entry
+ *
+ * Return: protection attributes of the page-table entry in the enum
+ *	   kvm_pgtable_prot format.
+ */
+enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
+
+/**
+ * kvm_pgtable_hyp_pte_prot() - Retrieve the protection attributes of a stage-1
+ *				Page-Table Entry.
+ * @pte:	Page-table entry
+ *
+ * Return: protection attributes of the page-table entry in the enum
+ *	   kvm_pgtable_prot format.
+ */
+enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bd409d524dea..fb80d3019cff 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -376,6 +376,26 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	return 0;
 }
 
+enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
+{
+	enum kvm_pgtable_prot prot = pte & KVM_PTE_LEAF_ATTR_HI_SW;
+	u32 ap;
+
+	if (!kvm_pte_valid(pte))
+		return prot;
+
+	if (!(pte & KVM_PTE_LEAF_ATTR_HI_S1_XN))
+		prot |= KVM_PGTABLE_PROT_X;
+
+	ap = FIELD_GET(KVM_PTE_LEAF_ATTR_LO_S1_AP, pte);
+	if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RO)
+		prot |= KVM_PGTABLE_PROT_R;
+	else if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RW)
+		prot |= KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
+
+	return prot;
+}
+
 static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
 {
 	/*
@@ -578,6 +598,23 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 	return 0;
 }
 
+enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte)
+{
+	enum kvm_pgtable_prot prot = pte & KVM_PTE_LEAF_ATTR_HI_SW;
+
+	if (!kvm_pte_valid(pte))
+		return prot;
+
+	if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R)
+		prot |= KVM_PGTABLE_PROT_R;
+	if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W)
+		prot |= KVM_PGTABLE_PROT_W;
+	if (!(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN))
+		prot |= KVM_PGTABLE_PROT_X;
+
+	return prot;
+}
+
 static bool stage2_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
 {
 	if (!kvm_pte_valid(old) || !kvm_pte_valid(new))
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
