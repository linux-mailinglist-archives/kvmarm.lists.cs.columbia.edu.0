Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B4AC061796C
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 10:12:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 063444B71F;
	Thu,  3 Nov 2022 05:12:03 -0400 (EDT)
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
	with ESMTP id yRU6nUfmA6SD; Thu,  3 Nov 2022 05:12:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 990AF4B6E9;
	Thu,  3 Nov 2022 05:12:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 160244B6C5
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 05:12:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yMPvDqqDyeiN for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Nov 2022 05:11:59 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 845524B651
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 05:11:59 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1667466718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O7lVOoCJHdqgecNw0W/tOpkcw0455pwyss33YgSAZlc=;
 b=EpYhXo6Gb2LgQKg7iIFvpcHK+zm2V53KLB8s4+pf09BZj9hCaU8AibNb0C5MdWKUOgw2t1
 ghmkvPEyNXKp4e2VgrxpomSMX9VK74ajrUK22ybhKzk+idJY7N0DY57PBD4Mf+0AHZJrq7
 WZZR4Et21E+xbkhWmnRYSihY6GPYsF8=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 00/14] KVM: arm64: Parallel stage-2 fault handling
Date: Thu,  3 Nov 2022 09:11:26 +0000
Message-Id: <20221103091140.1040433-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Presently KVM only takes a read lock for stage 2 faults if it believes
the fault can be fixed by relaxing permissions on a PTE (write unprotect
for dirty logging). Otherwise, stage 2 faults grab the write lock, which
predictably can pile up all the vCPUs in a sufficiently large VM.

Like the TDP MMU for x86, this series loosens the locking around
manipulations of the stage 2 page tables to allow parallel faults. RCU
and atomics are exploited to safely build/destroy the stage 2 page
tables in light of multiple software observers.

Patches 1-4 clean up the context associated with a page table walk / PTE
visit. This is helpful for:
 - Extending the context passed through for a visit
 - Building page table walkers that operate outside of a kvm_pgtable
   context (e.g. RCU callback)

Patches 5-7 clean up the stage-2 map walkers by calling a helper to tear
down removed tables. There is a small improvement here in that a broken
PTE is replaced more quickly, as page table teardown happens afterwards.

Patch 8 sprinkles in RCU to the page table walkers, punting the
teardown of removed tables to an RCU callback.

Patches 9-13 implement the meat of this series, extending the
'break-before-make' sequence with atomics to realize locking on PTEs.
Effectively a cmpxchg() is used to 'break' a PTE, thereby serializing
changes to a given PTE.

Finally, patch 14 flips the switch on all the new code and starts
grabbing the read side of the MMU lock for stage 2 faults.

Applies to 6.1-rc3. Tested with KVM selftests and kvm-unit-tests.

Branch available at:

  https://github.com/oupton/linux kvm-arm64/parallel_mmu

benchmarked with dirty_log_perf_test, scaling from 1 to 48 vCPUs with
4GB of memory per vCPU backed by THP.

  ./dirty_log_perf_test -s anonymous_thp -m 2 -b 4G -v ${NR_VCPUS}

Time to dirty memory:

        +-------+----------+-------------------+
        | vCPUs | 6.1-rc3  | 6.1-rc3 + series  |
        +-------+----------+-------------------+
        |     1 | 0.87s    | 0.93s             |
        |     2 | 1.11s    | 1.16s             |
        |     4 | 2.39s    | 1.27s             |
        |     8 | 5.01s    | 1.39s             |
        |    16 | 8.89s    | 2.07s             |
        |    32 | 19.90s   | 4.45s             |
        |    48 | 32.10s   | 6.23s             |
        +-------+----------+-------------------+

It is also worth mentioning that the time to populate memory has
improved:

        +-------+----------+-------------------+
        | vCPUs | 6.1-rc3  | 6.1-rc3 + series  |
        +-------+----------+-------------------+
        |     1 | 0.21s    | 0.17s             |
        |     2 | 0.26s    | 0.23s             |
        |     4 | 0.39s    | 0.31s             |
        |     8 | 0.68s    | 0.39s             |
        |    16 | 1.26s    | 0.53s             |
        |    32 | 2.51s    | 1.04s             |
        |    48 | 3.94s    | 1.55s             |
        +-------+----------+-------------------+

v3 -> v4:
 - Fix some type conversion misses caught by sparse (test robot)
 - Squash RCU locking and RCU callback patches together into one (Sean)
 - Commit message nits (Sean)
 - Take a pointer to kvm_s2_mmu in stage2_try_break_pte(), in
   anticipation of eager page splitting (Ricardo)

v3: https://lore.kernel.org/kvmarm/20221027221752.1683510-1-oliver.upton@linux.dev/

Oliver Upton (14):
  KVM: arm64: Combine visitor arguments into a context structure
  KVM: arm64: Stash observed pte value in visitor context
  KVM: arm64: Pass mm_ops through the visitor context
  KVM: arm64: Don't pass kvm_pgtable through kvm_pgtable_walk_data
  KVM: arm64: Add a helper to tear down unlinked stage-2 subtrees
  KVM: arm64: Use an opaque type for pteps
  KVM: arm64: Tear down unlinked stage-2 subtree after break-before-make
  KVM: arm64: Protect stage-2 traversal with RCU
  KVM: arm64: Atomically update stage 2 leaf attributes in parallel
    walks
  KVM: arm64: Split init and set for table PTE
  KVM: arm64: Make block->table PTE changes parallel-aware
  KVM: arm64: Make leaf->leaf PTE changes parallel-aware
  KVM: arm64: Make table->block changes parallel-aware
  KVM: arm64: Handle stage-2 faults in parallel

 arch/arm64/include/asm/kvm_pgtable.h  |  92 +++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  21 +-
 arch/arm64/kvm/hyp/nvhe/setup.c       |  22 +-
 arch/arm64/kvm/hyp/pgtable.c          | 628 ++++++++++++++------------
 arch/arm64/kvm/mmu.c                  |  53 ++-
 5 files changed, 466 insertions(+), 350 deletions(-)


base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
