Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B6DEF258F22
	for <lists+kvmarm@lfdr.de>; Tue,  1 Sep 2020 15:33:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 38B884B299;
	Tue,  1 Sep 2020 09:33:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XW5mugCPh+pE; Tue,  1 Sep 2020 09:33:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1EEB94B297;
	Tue,  1 Sep 2020 09:33:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC7514B217
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 09:33:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WxaqqOGtWz7j for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Sep 2020 09:33:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D18444B090
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 09:33:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48CE71063;
 Tue,  1 Sep 2020 06:33:00 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F17E3F66F;
 Tue,  1 Sep 2020 06:32:59 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/2] KVM: arm64: user_mem_abort() improvements
Date: Tue,  1 Sep 2020 14:33:55 +0100
Message-Id: <20200901133357.52640-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: maz@kernel.org
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

The first patch is a fix for a bug that I found by code inspection.

The second patch is an enhancement for the way user_mem_abort() handles
hugetlbfs backed VM memory.

Tested on a rockpro64 with 4K pages and hugetlbfs hugepagesz=1G (PUD sized
block mappings).  First test, guest RAM starts at 0x8100 0000
(memslot->base_gfn not aligned to 1GB); second test, guest RAM starts at
0x8000 0000, but is only 512 MB.  In both cases using PUD mappings is not
possible because either the memslot base address is not aligned, or the
mapping would extend beyond the memslot.

Without the changes, user_mem_abort() uses 4K pages to map the guest IPA.
With the patches, user_mem_abort() uses PMD block mappings (2MB) to map the
guest RAM, which means less TLB pressure and fewer stage 2 aborts.

Alexandru Elisei (2):
  KVM: arm64: Update page shift if stage 2 block mapping not supported
  KVM: arm64: Try PMD block mappings if PUD mappings are not supported

 arch/arm64/kvm/mmu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
