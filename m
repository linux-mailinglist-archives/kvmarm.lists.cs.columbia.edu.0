Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E9610C4D
	for <lists+kvmarm@lfdr.de>; Fri, 28 Oct 2022 10:35:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA68C40417;
	Fri, 28 Oct 2022 04:35:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CpJMPggp4XW; Fri, 28 Oct 2022 04:35:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1719540FAC;
	Fri, 28 Oct 2022 04:35:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E939401E3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 04:35:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-P1XCoFXn7R for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Oct 2022 04:35:17 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1259F40E06
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 04:35:16 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1666946115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zy0IA436iYEGUIQEIa25JubDREt90ASK4SizzIZvaHA=;
 b=xvKzvfZCa+ZOaJUaCX6iRYJx2EpKfZAD1RGadJ1ClDPQhPC0Sf69kiVIsMs77qnqDoCEcL
 DsAAxdwDncFFgrG9xsvfA2ypWhJ/g2kvoNka+PIZU0Eb2ZM5AcpGbnM8U0mUasBfoAG5Mp
 gn96QrcW2Ds0qFuKVUaI5Rp8wXaaHfA=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH 2/2] KVM: arm64: Redefine pKVM memory transitions in terms of
 source/target
Date: Fri, 28 Oct 2022 08:34:48 +0000
Message-Id: <20221028083448.1998389-3-oliver.upton@linux.dev>
In-Reply-To: <20221028083448.1998389-1-oliver.upton@linux.dev>
References: <20221028083448.1998389-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>,
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

Perhaps it is just me, but the 'initiator' and 'completer' terms are
slightly confusing descriptors for the addresses involved in a memory
transition. Apply a rename to instead describe memory transitions in
terms of a source and target address.

No functional change intended.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 68 +++++++++++++--------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 3636a24e1b34..3ea389a8166f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -391,20 +391,20 @@ struct pkvm_mem_transition {
 
 	struct {
 		enum pkvm_component_id	id;
-		/* Address in the initiator's address space */
+		/* Address in the source's address space */
 		u64			addr;
-	} initiator;
+	} source;
 
 	struct {
 		enum pkvm_component_id	id;
-		/* Address in the completer's address space */
+		/* Address in the target's address space */
 		u64			addr;
-	} completer;
+	} target;
 };
 
 struct pkvm_mem_share {
 	const struct pkvm_mem_transition	tx;
-	const enum kvm_pgtable_prot		completer_prot;
+	const enum kvm_pgtable_prot		target_prot;
 };
 
 struct check_walk_data {
@@ -469,7 +469,7 @@ static int __host_set_page_state_range(u64 addr, u64 size,
 static int host_request_owned_transition(const struct pkvm_mem_transition *tx)
 {
 	u64 size = tx->nr_pages * PAGE_SIZE;
-	u64 addr = tx->initiator.addr;
+	u64 addr = tx->source.addr;
 
 	return __host_check_page_state_range(addr, size, PKVM_PAGE_OWNED);
 }
@@ -477,7 +477,7 @@ static int host_request_owned_transition(const struct pkvm_mem_transition *tx)
 static int host_request_unshare(const struct pkvm_mem_transition *tx)
 {
 	u64 size = tx->nr_pages * PAGE_SIZE;
-	u64 addr = tx->initiator.addr;
+	u64 addr = tx->source.addr;
 
 	return __host_check_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
 }
@@ -485,7 +485,7 @@ static int host_request_unshare(const struct pkvm_mem_transition *tx)
 static int host_initiate_share(const struct pkvm_mem_transition *tx)
 {
 	u64 size = tx->nr_pages * PAGE_SIZE;
-	u64 addr = tx->initiator.addr;
+	u64 addr = tx->source.addr;
 
 	return __host_set_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
 }
@@ -493,7 +493,7 @@ static int host_initiate_share(const struct pkvm_mem_transition *tx)
 static int host_initiate_unshare(const struct pkvm_mem_transition *tx)
 {
 	u64 size = tx->nr_pages * PAGE_SIZE;
-	u64 addr = tx->initiator.addr;
+	u64 addr = tx->source.addr;
 
 	return __host_set_page_state_range(addr, size, PKVM_PAGE_OWNED);
 }
@@ -521,7 +521,7 @@ static int __hyp_check_page_state_range(u64 addr, u64 size,
 static bool __hyp_ack_skip_pgtable_check(const struct pkvm_mem_transition *tx)
 {
 	return !(IS_ENABLED(CONFIG_NVHE_EL2_DEBUG) ||
-		 tx->initiator.id != PKVM_ID_HOST);
+		 tx->source.id != PKVM_ID_HOST);
 }
 
 static int hyp_ack_share(const struct pkvm_mem_transition *tx,
@@ -535,7 +535,7 @@ static int hyp_ack_share(const struct pkvm_mem_transition *tx,
 	if (__hyp_ack_skip_pgtable_check(tx))
 		return 0;
 
-	return __hyp_check_page_state_range(tx->completer.addr, size, PKVM_NOPAGE);
+	return __hyp_check_page_state_range(tx->target.addr, size, PKVM_NOPAGE);
 }
 
 static int hyp_ack_unshare(const struct pkvm_mem_transition *tx)
@@ -545,14 +545,14 @@ static int hyp_ack_unshare(const struct pkvm_mem_transition *tx)
 	if (__hyp_ack_skip_pgtable_check(tx))
 		return 0;
 
-	return __hyp_check_page_state_range(tx->completer.addr, size,
+	return __hyp_check_page_state_range(tx->target.addr, size,
 					    PKVM_PAGE_SHARED_BORROWED);
 }
 
 static int hyp_complete_share(const struct pkvm_mem_transition *tx,
 			      enum kvm_pgtable_prot perms)
 {
-	void *start = (void *)tx->completer.addr;
+	void *start = (void *)tx->target.addr;
 	void *end = start + (tx->nr_pages * PAGE_SIZE);
 	enum kvm_pgtable_prot prot;
 
@@ -563,7 +563,7 @@ static int hyp_complete_share(const struct pkvm_mem_transition *tx,
 static int hyp_complete_unshare(const struct pkvm_mem_transition *tx)
 {
 	u64 size = tx->nr_pages * PAGE_SIZE;
-	int ret = kvm_pgtable_hyp_unmap(&pkvm_pgtable, tx->completer.addr, size);
+	int ret = kvm_pgtable_hyp_unmap(&pkvm_pgtable, tx->target.addr, size);
 
 	return (ret != size) ? -EFAULT : 0;
 }
@@ -573,7 +573,7 @@ static int check_share(struct pkvm_mem_share *share)
 	const struct pkvm_mem_transition *tx = &share->tx;
 	int ret;
 
-	switch (tx->initiator.id) {
+	switch (tx->source.id) {
 	case PKVM_ID_HOST:
 		ret = host_request_owned_transition(tx);
 		break;
@@ -584,9 +584,9 @@ static int check_share(struct pkvm_mem_share *share)
 	if (ret)
 		return ret;
 
-	switch (tx->completer.id) {
+	switch (tx->target.id) {
 	case PKVM_ID_HYP:
-		ret = hyp_ack_share(tx, share->completer_prot);
+		ret = hyp_ack_share(tx, share->target_prot);
 		break;
 	default:
 		ret = -EINVAL;
@@ -600,7 +600,7 @@ static int __do_share(struct pkvm_mem_share *share)
 	const struct pkvm_mem_transition *tx = &share->tx;
 	int ret;
 
-	switch (tx->initiator.id) {
+	switch (tx->source.id) {
 	case PKVM_ID_HOST:
 		ret = host_initiate_share(tx);
 		break;
@@ -611,9 +611,9 @@ static int __do_share(struct pkvm_mem_share *share)
 	if (ret)
 		return ret;
 
-	switch (tx->completer.id) {
+	switch (tx->target.id) {
 	case PKVM_ID_HYP:
-		ret = hyp_complete_share(tx, share->completer_prot);
+		ret = hyp_complete_share(tx, share->target_prot);
 		break;
 	default:
 		ret = -EINVAL;
@@ -628,8 +628,8 @@ static int __do_share(struct pkvm_mem_share *share)
  * The page owner grants access to another component with a given set
  * of permissions.
  *
- * Initiator: OWNED	=> SHARED_OWNED
- * Completer: NOPAGE	=> SHARED_BORROWED
+ * Source: OWNED	=> SHARED_OWNED
+ * Target: NOPAGE	=> SHARED_BORROWED
  */
 static int do_share(struct pkvm_mem_share *share)
 {
@@ -647,7 +647,7 @@ static int check_unshare(struct pkvm_mem_share *share)
 	const struct pkvm_mem_transition *tx = &share->tx;
 	int ret;
 
-	switch (tx->initiator.id) {
+	switch (tx->source.id) {
 	case PKVM_ID_HOST:
 		ret = host_request_unshare(tx);
 		break;
@@ -658,7 +658,7 @@ static int check_unshare(struct pkvm_mem_share *share)
 	if (ret)
 		return ret;
 
-	switch (tx->completer.id) {
+	switch (tx->target.id) {
 	case PKVM_ID_HYP:
 		ret = hyp_ack_unshare(tx);
 		break;
@@ -674,7 +674,7 @@ static int __do_unshare(struct pkvm_mem_share *share)
 	const struct pkvm_mem_transition *tx = &share->tx;
 	int ret;
 
-	switch (tx->initiator.id) {
+	switch (tx->source.id) {
 	case PKVM_ID_HOST:
 		ret = host_initiate_unshare(tx);
 		break;
@@ -685,7 +685,7 @@ static int __do_unshare(struct pkvm_mem_share *share)
 	if (ret)
 		return ret;
 
-	switch (tx->completer.id) {
+	switch (tx->target.id) {
 	case PKVM_ID_HYP:
 		ret = hyp_complete_unshare(tx);
 		break;
@@ -702,8 +702,8 @@ static int __do_unshare(struct pkvm_mem_share *share)
  * The page owner revokes access from another component for a range of
  * pages which were previously shared using do_share().
  *
- * Initiator: SHARED_OWNED	=> OWNED
- * Completer: SHARED_BORROWED	=> NOPAGE
+ * Source: SHARED_OWNED	=> OWNED
+ * Target: SHARED_BORROWED	=> NOPAGE
  */
 static int do_unshare(struct pkvm_mem_share *share)
 {
@@ -724,16 +724,16 @@ int __pkvm_host_share_hyp(u64 pfn)
 	struct pkvm_mem_share share = {
 		.tx	= {
 			.nr_pages	= 1,
-			.initiator	= {
+			.source	= {
 				.id	= PKVM_ID_HOST,
 				.addr	= host_addr,
 			},
-			.completer	= {
+			.target	= {
 				.id	= PKVM_ID_HYP,
 				.addr	= hyp_addr,
 			},
 		},
-		.completer_prot	= PAGE_HYP,
+		.target_prot	= PAGE_HYP,
 	};
 
 	host_lock_component();
@@ -755,16 +755,16 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 	struct pkvm_mem_share share = {
 		.tx	= {
 			.nr_pages	= 1,
-			.initiator	= {
+			.source	= {
 				.id	= PKVM_ID_HOST,
 				.addr	= host_addr,
 			},
-			.completer	= {
+			.target	= {
 				.id	= PKVM_ID_HYP,
 				.addr	= hyp_addr,
 			},
 		},
-		.completer_prot	= PAGE_HYP,
+		.target_prot	= PAGE_HYP,
 	};
 
 	host_lock_component();
-- 
2.38.1.273.g43a17bfeac-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
