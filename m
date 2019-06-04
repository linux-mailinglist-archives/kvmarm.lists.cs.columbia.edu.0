Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3D348D4
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 15:33:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1EC564A4FE;
	Tue,  4 Jun 2019 09:33:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E+wvRXtWwKoV; Tue,  4 Jun 2019 09:33:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1E6F4A501;
	Tue,  4 Jun 2019 09:33:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 64C3E4A4A3
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 09:33:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ElzH2zr7CGlV for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 09:33:41 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E4A304A4EB
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 09:33:40 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50F20341;
 Tue,  4 Jun 2019 06:33:40 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5F993F690;
 Tue,  4 Jun 2019 06:33:39 -0700 (PDT)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvm@vger.kernel.org
Subject: [PATCH v3 0/4] KVM: Unify mmu_memory_cache functionality across
 architectures
Date: Tue,  4 Jun 2019 15:33:32 +0200
Message-Id: <20190604133336.22226-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
Cc: Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

We currently have duplicated functionality for the mmu_memory_cache used
to pre-allocate memory for the page table manipulation code which cannot
allocate memory while holding spinlocks.  This functionality is
duplicated across x86, arm/arm64, and mips.

There were recently a debate of modifying the arm code to be more in
line with the x86 code and some discussions around changing the page
flags used for allocation.  This series should make it easier to take a
uniform approach across architectures.

While there's not a huge amount of code sharing, we come out with a net
gain.

Only tested on arm/arm64, and only compile-tested on x86 and mips.

Changes since v2:
 - Simplified kalloc flag definitions as per Paolo's review comment.

Changes since v1:
 - Split out rename from initial x86 patch to have separate patches to
   move the logic to common code and to rename.
 - Introduce KVM_ARCH_WANT_MMU_MEMCACHE to avoid compile breakage on
   architectures that don't use this functionality.
 - Rename KVM_NR_MEM_OBJS to KVM_MMU_NR_MEMCACHE_OBJS

Christoffer Dall (4):
  KVM: x86: Move mmu_memory_cache functions to common code
  KVM: x86: Rename mmu_memory_cache to kvm_mmu_memcache
  KVM: arm/arm64: Move to common kvm_mmu_memcache infrastructure
  KVM: mips: Move to common kvm_mmu_memcache infrastructure

 arch/arm/include/asm/kvm_host.h      | 13 +---
 arch/arm/include/asm/kvm_mmu.h       |  2 +-
 arch/arm/include/asm/kvm_types.h     | 11 ++++
 arch/arm64/include/asm/kvm_host.h    | 13 +---
 arch/arm64/include/asm/kvm_mmu.h     |  2 +-
 arch/arm64/include/asm/kvm_types.h   | 12 ++++
 arch/mips/include/asm/kvm_host.h     | 15 +----
 arch/mips/include/asm/kvm_types.h    | 11 ++++
 arch/mips/kvm/mips.c                 |  2 +-
 arch/mips/kvm/mmu.c                  | 54 +++-------------
 arch/powerpc/include/asm/kvm_types.h |  5 ++
 arch/s390/include/asm/kvm_types.h    |  5 ++
 arch/x86/include/asm/kvm_host.h      | 17 +----
 arch/x86/include/asm/kvm_types.h     | 11 ++++
 arch/x86/kvm/mmu.c                   | 97 ++++++----------------------
 arch/x86/kvm/paging_tmpl.h           |  4 +-
 include/linux/kvm_host.h             | 11 ++++
 include/linux/kvm_types.h            | 13 ++++
 virt/kvm/arm/arm.c                   |  2 +-
 virt/kvm/arm/mmu.c                   | 68 +++++--------------
 virt/kvm/kvm_main.c                  | 60 +++++++++++++++++
 21 files changed, 198 insertions(+), 230 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_types.h
 create mode 100644 arch/arm64/include/asm/kvm_types.h
 create mode 100644 arch/mips/include/asm/kvm_types.h
 create mode 100644 arch/powerpc/include/asm/kvm_types.h
 create mode 100644 arch/s390/include/asm/kvm_types.h
 create mode 100644 arch/x86/include/asm/kvm_types.h

-- 
2.18.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
