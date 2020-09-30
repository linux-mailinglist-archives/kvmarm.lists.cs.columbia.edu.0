Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC227E684
	for <lists+kvmarm@lfdr.de>; Wed, 30 Sep 2020 12:24:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D1234B333;
	Wed, 30 Sep 2020 06:24:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vo5bU9yw43cb; Wed, 30 Sep 2020 06:24:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F4264B411;
	Wed, 30 Sep 2020 06:24:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F38CE4B22E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 06:24:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vTruEVWTNyif for <kvmarm@lists.cs.columbia.edu>;
 Wed, 30 Sep 2020 06:24:50 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F14164B209
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 06:24:49 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 41BC02075F;
 Wed, 30 Sep 2020 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601461488;
 bh=Z1wOpUil727ienmdbsN3AftC5M0MMwSBeTANFnRQjoc=;
 h=From:To:Cc:Subject:Date:From;
 b=BmVzYg8+P7SP2rGynBhWphrz2IQiCShHKVU8tl2MhQyogogI55y4VEThJ8wK5YRvA
 A21dODhghc18TKn53u54z1/TJKmvpEVjxZeLd8bYOvEpaGwLXdejKsgRdjeegOW6fN
 pIgEzyxrxu4N4Y2OdDqwKmvhjPoV1nAT+H9cRbqs=
From: Will Deacon <will@kernel.org>
To: maz@kernel.org
Subject: [PATCH] KVM: arm64: Ensure user_mem_abort() return value is
 initialised
Date: Wed, 30 Sep 2020 11:24:42 +0100
Message-Id: <20200930102442.16142-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kernel test robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
 Will Deacon <willdeacon@google.com>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, Dan Carpenter <dan.carpenter@oracle.com>
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

From: Will Deacon <willdeacon@google.com>

If a change in the MMU notifier sequence number forces user_mem_abort()
to return early when attempting to handle a stage-2 fault, we return
uninitialised stack to kvm_handle_guest_abort(), which could potentially
result in the injection of an external abort into the guest or a spurious
return to userspace. Neither or these are what we want to do.

Initialise 'ret' to 0 in user_mem_abort() so that bailing due to a
change in the MMU notrifier sequence number is treated as though the
fault was handled.

Cc: Gavin Shan <gshan@redhat.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

Applies on top of kvmarm/next.

 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c5c26a9cb85b..a816cb8e619b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -742,7 +742,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
 {
-	int ret;
+	int ret = 0;
 	bool write_fault, writable, force_pte = false;
 	bool exec_fault;
 	bool device = false;
-- 
2.28.0.709.gb0816b6eb0-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
