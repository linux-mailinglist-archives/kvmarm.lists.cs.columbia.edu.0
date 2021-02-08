Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 99E553130A1
	for <lists+kvmarm@lfdr.de>; Mon,  8 Feb 2021 12:23:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14DE24B39F;
	Mon,  8 Feb 2021 06:23:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FkMTSbJlkRvn; Mon,  8 Feb 2021 06:23:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 09BC34B473;
	Mon,  8 Feb 2021 06:23:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D4FE34B442
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 06:23:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUPjSbM2olul for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Feb 2021 06:23:05 -0500 (EST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 725844B39F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 06:23:05 -0500 (EST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DZ3Wj6PCFzjJyB;
 Mon,  8 Feb 2021 19:21:53 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Feb 2021 19:22:54 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>,
 "Julien Thierry" <julien.thierry.kdev@gmail.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Gavin Shan <gshan@redhat.com>, Quentin Perret
 <qperret@google.com>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/4] KVM: arm64: Add an independent API for coalescing
 tables
Date: Mon, 8 Feb 2021 19:22:48 +0800
Message-ID: <20210208112250.163568-3-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210208112250.163568-1-wangyanan55@huawei.com>
References: <20210208112250.163568-1-wangyanan55@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
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

Process of coalescing page mappings back to a block mapping is different
from normal map path, such as TLB invalidation and CMOs, so here add an
independent API for this case.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 2f4f87021980..78a560446f80 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -525,6 +525,24 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	return 0;
 }
 
+static void stage2_coalesce_tables_into_block(u64 addr, u32 level,
+					      kvm_pte_t *ptep,
+					      struct stage2_map_data *data)
+{
+	u64 granule = kvm_granule_size(level), phys = data->phys;
+	kvm_pte_t new = kvm_init_valid_leaf_pte(phys, data->attr, level);
+
+	kvm_set_invalid_pte(ptep);
+
+	/*
+	 * Invalidate the whole stage-2, as we may have numerous leaf entries
+	 * below us which would otherwise need invalidating individually.
+	 */
+	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
+	smp_store_release(ptep, new);
+	data->phys += granule;
+}
+
 static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 				     kvm_pte_t *ptep,
 				     struct stage2_map_data *data)
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
