Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 000765B82F7
	for <lists+kvmarm@lfdr.de>; Wed, 14 Sep 2022 10:35:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 72D364BC47;
	Wed, 14 Sep 2022 04:35:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRabho-2WxKo; Wed, 14 Sep 2022 04:35:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3FD64BC4E;
	Wed, 14 Sep 2022 04:35:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B6B214BBF3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Sep 2022 04:35:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcZSz5KCjgzK for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Sep 2022 04:35:29 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9FAB44BC4E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Sep 2022 04:35:29 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8341EB81670;
 Wed, 14 Sep 2022 08:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A9C43141;
 Wed, 14 Sep 2022 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663144527;
 bh=hni7qmDVdiWe9/1hltYBsDJQpVG/9qbl3hZoP6XaW60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KpYQNpRy30Tu9Nm/dQzz8zAbBn1F8J82VCI2yApIz2onE8DcKz7qDB1jtYFq7SIWs
 zNmZA3ols2nUwKkBTVmAC/Zl1At+KyJuX1xmaoHRAamQa/YM66o+JqHoaVi4XvyRjQ
 m1Lf+UzYh8TEcHe0TVEHZBCKCK3r8SQWPIJjm3ObMapg4EAnB3t6jD3tsYDwD/YHm/
 27H0AqNEUaPHPoHFKN3Uj24nMrk8MEvBmL9f+A6Gfmz+2CMqVwMyumaZmJ3tjbUDId
 H5O3bpMQlziJWA/xeywQuRFj4BnW7EOsueRzUxY7PIaLrjGBPVgVm8WQFtsqXN/mYM
 z0c9Ec2DVRKCA==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 05/25] KVM: arm64: Unify identifiers used to distinguish
 host and hypervisor
Date: Wed, 14 Sep 2022 09:34:40 +0100
Message-Id: <20220914083500.5118-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220914083500.5118-1-will@kernel.org>
References: <20220914083500.5118-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Will Deacon <will@kernel.org>,
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

The 'pkvm_component_id' enum type provides constants to refer to the
host and the hypervisor, yet this information is duplicated by the
'pkvm_hyp_id' constant.

Remove the definition of 'pkvm_hyp_id' and move the 'pkvm_component_id'
type definition to 'mem_protect.h' so that it can be used outside of
the memory protection code, for example when initialising the owner for
hypervisor-owned pages.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 6 +++++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 8 --------
 arch/arm64/kvm/hyp/nvhe/setup.c               | 2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 80e99836eac7..f5705a1e972f 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -51,7 +51,11 @@ struct host_kvm {
 };
 extern struct host_kvm host_kvm;
 
-extern const u8 pkvm_hyp_id;
+/* This corresponds to page-table locking order */
+enum pkvm_component_id {
+	PKVM_ID_HOST,
+	PKVM_ID_HYP,
+};
 
 int __pkvm_prot_finalize(void);
 int __pkvm_host_share_hyp(u64 pfn);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 1e78acf9662e..ff86f5bd230f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -26,8 +26,6 @@ struct host_kvm host_kvm;
 
 static struct hyp_pool host_s2_pool;
 
-const u8 pkvm_hyp_id = 1;
-
 static void host_lock_component(void)
 {
 	hyp_spin_lock(&host_kvm.lock);
@@ -380,12 +378,6 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 	BUG_ON(ret && ret != -EAGAIN);
 }
 
-/* This corresponds to locking order */
-enum pkvm_component_id {
-	PKVM_ID_HOST,
-	PKVM_ID_HYP,
-};
-
 struct pkvm_mem_transition {
 	u64				nr_pages;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 8f2726d7e201..0312c9c74a5a 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -212,7 +212,7 @@ static int fix_host_ownership_walker(u64 addr, u64 end, u32 level,
 	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(pte));
 	switch (state) {
 	case PKVM_PAGE_OWNED:
-		return host_stage2_set_owner_locked(phys, PAGE_SIZE, pkvm_hyp_id);
+		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
 	case PKVM_PAGE_SHARED_OWNED:
 		prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_BORROWED);
 		break;
-- 
2.37.2.789.g6183377224-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
