Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB62CF3D6
	for <lists+kvmarm@lfdr.de>; Fri,  4 Dec 2020 19:20:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA2414B200;
	Fri,  4 Dec 2020 13:20:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id itYuzhtXZu2T; Fri,  4 Dec 2020 13:20:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C9C9A4B202;
	Fri,  4 Dec 2020 13:20:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D7584B19D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 13:20:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id edgUPKo8i5-A for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Dec 2020 13:20:02 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 543E44B19E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 13:20:02 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 765C122C9F;
 Fri,  4 Dec 2020 18:20:01 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1klFgV-00G3EZ-Mo; Fri, 04 Dec 2020 18:19:59 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] KVM: arm64: Fix handling of merging tables into a block
 entry
Date: Fri,  4 Dec 2020 18:19:13 +0000
Message-Id: <20201204181914.783445-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201204181914.783445-1-maz@kernel.org>
References: <20201204181914.783445-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, zhukeqian1@huawei.com, will@kernel.org,
 wangyanan55@huawei.com, kernel-team@android.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Yanan Wang <wangyanan55@huawei.com>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

From: Yanan Wang <wangyanan55@huawei.com>

When dirty logging is enabled, we collapse block entries into tables
as necessary. If dirty logging gets canceled, we can end-up merging
tables back into block entries.

When this happens, we must not only free the non-huge page-table
pages but also invalidate all the TLB entries that can potentially
cover the block. Otherwise, we end-up with multiple possible translations
for the same physical page, which can legitimately result in a TLB
conflict.

To address this, replease the bogus invalidation by IPA with a full
VM invalidation. Although this is pretty heavy handed, it happens
very infrequently and saves a bunch of invalidations by IPA.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
[maz: fixup commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20201201201034.116760-3-wangyanan55@huawei.com
---
 arch/arm64/kvm/hyp/pgtable.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 2beba1dc40ec..bdf8e55ed308 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -502,7 +502,13 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 		return 0;
 
 	kvm_set_invalid_pte(ptep);
-	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, 0);
+
+	/*
+	 * Invalidate the whole stage-2, as we may have numerous leaf
+	 * entries below us which would otherwise need invalidating
+	 * individually.
+	 */
+	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
 	data->anchor = ptep;
 	return 0;
 }
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
