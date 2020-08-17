Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A959524651B
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 13:08:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E8EA4C078;
	Mon, 17 Aug 2020 07:08:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FkYIalqPYyFO; Mon, 17 Aug 2020 07:08:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 16DD34C065;
	Mon, 17 Aug 2020 07:08:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ACCE4C014
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 07:08:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ydvRWVculaFP for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 07:08:06 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 023464BF88
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 07:08:05 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E80D389EC9CBD5A5F5F1;
 Mon, 17 Aug 2020 19:08:00 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.22) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 19:07:51 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [PATCH v2 2/2] KVM: arm64: Use kvm_write_guest_lock when init stolen
 time
Date: Mon, 17 Aug 2020 19:07:28 +0800
Message-ID: <20200817110728.12196-3-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20200817110728.12196-1-zhukeqian1@huawei.com>
References: <20200817110728.12196-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

There is a lock version kvm_write_guest. Use it to simplify code.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kvm/pvtime.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index f7b52ce..2b24e7f 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -55,7 +55,6 @@ gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu)
 	struct pvclock_vcpu_stolen_time init_values = {};
 	struct kvm *kvm = vcpu->kvm;
 	u64 base = vcpu->arch.steal.base;
-	int idx;
 
 	if (base == GPA_INVALID)
 		return base;
@@ -66,10 +65,7 @@ gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.steal.steal = 0;
 	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
-
-	idx = srcu_read_lock(&kvm->srcu);
-	kvm_write_guest(kvm, base, &init_values, sizeof(init_values));
-	srcu_read_unlock(&kvm->srcu, idx);
+	kvm_write_guest_lock(kvm, base, &init_values, sizeof(init_values));
 
 	return base;
 }
-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
