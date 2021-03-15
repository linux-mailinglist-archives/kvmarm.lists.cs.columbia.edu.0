Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4F33B12D
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 12:31:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B42D24B4FC;
	Mon, 15 Mar 2021 07:31:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.592
X-Spam-Level: 
X-Spam-Status: No, score=-1.592 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	SORTED_RECIPS=2.499, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zpp4at9onEve; Mon, 15 Mar 2021 07:31:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 848394B555;
	Mon, 15 Mar 2021 07:31:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0635F4B515
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:31:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 93DEy8yIZfo7 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 07:31:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EB0A74B462
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:31:11 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B9F364E61;
 Mon, 15 Mar 2021 11:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1615807871;
 bh=+2xMWo+2W9gHdyJ7hBxIUlcrPtH53aYMF/D4GkeJTxo=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=AojJkVR4J4KjWAeAl25zqEhMz6KoGsNMCNGcJ959mR1cIi+yvjNUm71kiamn9UmEU
 BwkHuwAhmkchNqRoli1+BiB1xvii5eGhvUYLZBuYBkkHfuIIJy47p/Kvdk/LXmZ8Uh
 U/DNhRisAYprbq16HP+UAFRHDPDBMFD5uzePlnGk=
Subject: Patch "KVM: arm64: Fix exclusive limit for IPA size" has been added
 to the 4.19-stable tree
To: drjones@redhat.com, eric.auger@redhat.com, gregkh@linuxfoundation.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu, maz@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Mar 2021 12:31:08 +0100
In-Reply-To: <20210315110833.4135927-1-maz@kernel.org>
Message-ID: <161580786826222@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    KVM: arm64: Fix exclusive limit for IPA size

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kvm-arm64-fix-exclusive-limit-for-ipa-size.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Mon Mar 15 12:28:26 PM CET 2021
From: Marc Zyngier <maz@kernel.org>
Date: Mon, 15 Mar 2021 11:08:33 +0000
Subject: KVM: arm64: Fix exclusive limit for IPA size
To: gregkh@linuxfoundation.org
Cc: kvmarm@lists.cs.columbia.edu, kernel-team@android.com, Eric Auger <eric.auger@redhat.com>, stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>
Message-ID: <20210315110833.4135927-1-maz@kernel.org>

From: Marc Zyngier <maz@kernel.org>

Commit 262b003d059c6671601a19057e9fe1a5e7f23722 upstream.

When registering a memslot, we check the size and location of that
memslot against the IPA size to ensure that we can provide guest
access to the whole of the memory.

Unfortunately, this check rejects memslot that end-up at the exact
limit of the addressing capability for a given IPA size. For example,
it refuses the creation of a 2GB memslot at 0x8000000 with a 32bit
IPA space.

Fix it by relaxing the check to accept a memslot reaching the
limit of the IPA space.

Fixes: c3058d5da222 ("arm/arm64: KVM: Ensure memslots are within KVM_PHYS_SIZE")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org # 4.4, 4.9, 4.14, 4.19
Reviewed-by: Andrew Jones <drjones@redhat.com>
Link: https://lore.kernel.org/r/20210311100016.3830038-3-maz@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/arm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2080,7 +2080,7 @@ int kvm_arch_prepare_memory_region(struc
 	 * Prevent userspace from creating a memory region outside of the IPA
 	 * space addressable by the KVM guest IPA space.
 	 */
-	if (memslot->base_gfn + memslot->npages >=
+	if (memslot->base_gfn + memslot->npages >
 	    (KVM_PHYS_SIZE >> PAGE_SHIFT))
 		return -EFAULT;
 


Patches currently in stable-queue which might be from maz@kernel.org are

queue-4.19/kvm-arm64-fix-exclusive-limit-for-ipa-size.patch
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
