Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9A5F64F2
	for <lists+kvmarm@lfdr.de>; Thu,  6 Oct 2022 13:11:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D94D49F38;
	Thu,  6 Oct 2022 07:11:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gefA67lgMdgR; Thu,  6 Oct 2022 07:11:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EADAA40B8D;
	Thu,  6 Oct 2022 07:11:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 63DD3410DA
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Oct 2022 07:11:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cVI6Zawowefr for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Oct 2022 07:11:51 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1337C40B8D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Oct 2022 07:11:51 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA75E1BF7;
 Thu,  6 Oct 2022 04:11:56 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740023F73B;
 Thu,  6 Oct 2022 04:11:49 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: pbonzini@redhat.com, thuth@redhat.com, andrew.jones@linux.dev,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH 0/3] arm/arm64: mmu cleanups and fixes
Date: Thu,  6 Oct 2022 12:12:38 +0100
Message-Id: <20221006111241.15083-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

I was writing a quick test when I noticed that arm's implementation of
__virt_to_phys(), which ends up calling virt_to_pte_phys(), doesn't handle
block mappings and returns a bogus value.

When fixing that, I realized that lib/vmalloc confuses the return value for
virt_to_pte_phys(), which is harmless, but still wrong.

I also got confused about mmu_get_pte() and get_pte(), so I (hopefully)
improved that by renaming mmu_get_pte() to follow_pte().

Tested on rockpro64: arm64, 4k and 64k pages, with qemu and kvmtool; arm,
with qemu and kvmtool. And on an odroid-c4: arm64, 4k, 16k and 64k pages
with qemu and kvmtool; arm, with qemu and kvmtool.

Alexandru Elisei (3):
  lib/vmalloc: Treat virt_to_pte_phys() as returning a physical address
  arm/arm64: mmu: Teach virt_to_pte_phys() about block descriptors
  arm/arm64: mmu: Rename mmu_get_pte() -> follow_pte()

 lib/arm/asm/mmu-api.h |  2 +-
 lib/arm/mmu.c         | 88 +++++++++++++++++++++++++------------------
 lib/vmalloc.c         |  4 +-
 3 files changed, 55 insertions(+), 39 deletions(-)

-- 
2.37.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
