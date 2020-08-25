Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A152425158C
	for <lists+kvmarm@lfdr.de>; Tue, 25 Aug 2020 11:40:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 185654C04E;
	Tue, 25 Aug 2020 05:40:08 -0400 (EDT)
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
	with ESMTP id TMqqTLLuBmpD; Tue, 25 Aug 2020 05:40:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B28474C019;
	Tue, 25 Aug 2020 05:40:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A99814BE82
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BYN3vwJk0pVA for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Aug 2020 05:40:03 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7D1684BE45
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:03 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B19782075B;
 Tue, 25 Aug 2020 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598348402;
 bh=DarpS0fmBDiEq7Q5dXJMMvw3XvnjQeF94nVnn3lLR/M=;
 h=From:To:Cc:Subject:Date:From;
 b=XSD6Fv4S3lRk4CSEpIfcmY+OLFxhXXJCdQPLfu1DKPWKd4WDh1tb66S02Oq1qaqKN
 wG9+zVIw7vUtOLOOhaC0J7kGfamlCnnM+9MRKbg4daN127C3iqwCMVHBQCPmBhZWDO
 luKtSyDXW0pE9FH1lDtMQBjrszls3msoKYRpy450=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 00/21] KVM: arm64: Rewrite page-table code and fault
 handling
Date: Tue, 25 Aug 2020 10:39:32 +0100
Message-Id: <20200825093953.26493-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

Hello folks,

This is version three of the KVM page-table rework that I previously posted
here:

  v1: https://lore.kernel.org/r/20200730153406.25136-1-will@kernel.org
  v2: https://lore.kernel.org/r/20200818132818.16065-1-will@kernel.org

Changes since v2 include:

  * Rebased onto -rc2, which includes the conflicting OOM blocking fixes
  * Dropped the patch trying to "fix" the memcache in kvm_phys_addr_ioremap()

Cheers,

Will

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: kernel-team@android.com
Cc: linux-arm-kernel@lists.infradead.org

--->8

Quentin Perret (4):
  KVM: arm64: Add support for stage-2 write-protect in generic
    page-table
  KVM: arm64: Convert write-protect operation to generic page-table API
  KVM: arm64: Add support for stage-2 cache flushing in generic
    page-table
  KVM: arm64: Convert memslot cache-flushing code to generic page-table
    API

Will Deacon (17):
  KVM: arm64: Remove kvm_mmu_free_memory_caches()
  KVM: arm64: Add stand-alone page-table walker infrastructure
  KVM: arm64: Add support for creating kernel-agnostic stage-1 page
    tables
  KVM: arm64: Use generic allocator for hyp stage-1 page-tables
  KVM: arm64: Add support for creating kernel-agnostic stage-2 page
    tables
  KVM: arm64: Add support for stage-2 map()/unmap() in generic
    page-table
  KVM: arm64: Convert kvm_phys_addr_ioremap() to generic page-table API
  KVM: arm64: Convert kvm_set_spte_hva() to generic page-table API
  KVM: arm64: Convert unmap_stage2_range() to generic page-table API
  KVM: arm64: Add support for stage-2 page-aging in generic page-table
  KVM: arm64: Convert page-aging and access faults to generic page-table
    API
  KVM: arm64: Add support for relaxing stage-2 perms in generic
    page-table code
  KVM: arm64: Convert user_mem_abort() to generic page-table API
  KVM: arm64: Check the pgt instead of the pgd when modifying page-table
  KVM: arm64: Remove unused page-table code
  KVM: arm64: Remove unused 'pgd' field from 'struct kvm_s2_mmu'
  KVM: arm64: Don't constrain maximum IPA size based on host
    configuration

 arch/arm64/include/asm/kvm_host.h       |    2 +-
 arch/arm64/include/asm/kvm_mmu.h        |  221 +---
 arch/arm64/include/asm/kvm_pgtable.h    |  279 ++++
 arch/arm64/include/asm/pgtable-hwdef.h  |   23 -
 arch/arm64/include/asm/pgtable-prot.h   |   19 -
 arch/arm64/include/asm/stage2_pgtable.h |  215 ----
 arch/arm64/kvm/arm.c                    |    2 +-
 arch/arm64/kvm/hyp/Makefile             |    2 +-
 arch/arm64/kvm/hyp/pgtable.c            |  860 +++++++++++++
 arch/arm64/kvm/mmu.c                    | 1566 +++--------------------
 arch/arm64/kvm/reset.c                  |   38 +-
 11 files changed, 1326 insertions(+), 1901 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_pgtable.h
 create mode 100644 arch/arm64/kvm/hyp/pgtable.c

-- 
2.28.0.297.g1956fa8f8d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
