Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A47233AB1C6
	for <lists+kvmarm@lfdr.de>; Thu, 17 Jun 2021 12:58:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54EE54A5A0;
	Thu, 17 Jun 2021 06:58:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DMMOZOrf5RMk; Thu, 17 Jun 2021 06:58:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 59DC649E57;
	Thu, 17 Jun 2021 06:58:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05A5E4083E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 06:58:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TK2vTruEjbsZ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Jun 2021 06:58:47 -0400 (EDT)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0276D40FC7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 06:58:47 -0400 (EDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5Jr41wl1zZj4f;
 Thu, 17 Jun 2021 18:55:48 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:58:30 +0800
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:58:29 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Quentin
 Perret" <qperret@google.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/4] KVM: arm64: Introduce mm_ops member for structure
 stage2_attr_data
Date: Thu, 17 Jun 2021 18:58:22 +0800
Message-ID: <20210617105824.31752-3-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210617105824.31752-1-wangyanan55@huawei.com>
References: <20210617105824.31752-1-wangyanan55@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>
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

Also add a mm_ops member for structure stage2_attr_data, since we
will move I-cache maintenance for guest stage-2 to the permission
path and as a result will need mm_ops for some callbacks.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c37c1dc4feaf..d99789432b05 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -861,10 +861,11 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 }
 
 struct stage2_attr_data {
-	kvm_pte_t	attr_set;
-	kvm_pte_t	attr_clr;
-	kvm_pte_t	pte;
-	u32		level;
+	kvm_pte_t			attr_set;
+	kvm_pte_t			attr_clr;
+	kvm_pte_t			pte;
+	u32				level;
+	struct kvm_pgtable_mm_ops	*mm_ops;
 };
 
 static int stage2_attr_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
@@ -903,6 +904,7 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 	struct stage2_attr_data data = {
 		.attr_set	= attr_set & attr_mask,
 		.attr_clr	= attr_clr & attr_mask,
+		.mm_ops		= pgt->mm_ops,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_attr_walker,
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
