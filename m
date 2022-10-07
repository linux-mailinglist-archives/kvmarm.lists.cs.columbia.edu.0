Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8209B5F814E
	for <lists+kvmarm@lfdr.de>; Sat,  8 Oct 2022 01:42:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F2ADB4B0B9;
	Fri,  7 Oct 2022 19:42:13 -0400 (EDT)
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
	with ESMTP id Udh4x1k-xwp7; Fri,  7 Oct 2022 19:42:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 26C934A49C;
	Fri,  7 Oct 2022 19:42:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DC334B121
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Oct 2022 19:42:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AlG-lL14jcAv for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Oct 2022 19:42:08 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A4CEE49EC4
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Oct 2022 19:42:08 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1665186128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNR9v+pyT8sFr1ZTIk/kdWwXQQaalAe+phJ9dBDtUZ8=;
 b=pbis3U7feRQowbfrXDCwsu5OCSHoDfMs4pUYh/XGf6iyQUkA0UV8liUKktITLkUG857H2k
 xhRuHPZCA0yI8RPpBiMn01BmpD6qqHZaQli9sss4UVuiMfa656OfLrP7FpLbzrY2XvZaFF
 cjppQjXwrMX6qBA0c79pb4YiBrQko04=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v3 2/2] KVM: arm64: Limit stage2_apply_range() batch size to
 largest block
Date: Fri,  7 Oct 2022 23:41:51 +0000
Message-Id: <20221007234151.461779-3-oliver.upton@linux.dev>
In-Reply-To: <20221007234151.461779-1-oliver.upton@linux.dev>
References: <20221007234151.461779-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 David Matlack <dmatlack@google.com>, kvmarm@lists.cs.columbia.edu,
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

Presently stage2_apply_range() works on a batch of memory addressed by a
stage 2 root table entry for the VM. Depending on the IPA limit of the
VM and PAGE_SIZE of the host, this could address a massive range of
memory. Some examples:

  4 level, 4K paging -> 512 GB batch size

  3 level, 64K paging -> 4TB batch size

Unsurprisingly, working on such a large range of memory can lead to soft
lockups. When running dirty_log_perf_test:

  ./dirty_log_perf_test -m -2 -s anonymous_thp -b 4G -v 48

  watchdog: BUG: soft lockup - CPU#0 stuck for 45s! [dirty_log_perf_:16703]
  Modules linked in: vfat fat cdc_ether usbnet mii xhci_pci xhci_hcd sha3_generic gq(O)
  CPU: 0 PID: 16703 Comm: dirty_log_perf_ Tainted: G           O       6.0.0-smp-DEV #1
  pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : dcache_clean_inval_poc+0x24/0x38
  lr : clean_dcache_guest_page+0x28/0x4c
  sp : ffff800021763990
  pmr_save: 000000e0
  x29: ffff800021763990 x28: 0000000000000005 x27: 0000000000000de0
  x26: 0000000000000001 x25: 00400830b13bc77f x24: ffffad4f91ead9c0
  x23: 0000000000000000 x22: ffff8000082ad9c8 x21: 0000fffafa7bc000
  x20: ffffad4f9066ce50 x19: 0000000000000003 x18: ffffad4f92402000
  x17: 000000000000011b x16: 000000000000011b x15: 0000000000000124
  x14: ffff07ff8301d280 x13: 0000000000000000 x12: 00000000ffffffff
  x11: 0000000000010001 x10: fffffc0000000000 x9 : ffffad4f9069e580
  x8 : 000000000000000c x7 : 0000000000000000 x6 : 000000000000003f
  x5 : ffff07ffa2076980 x4 : 0000000000000001 x3 : 000000000000003f
  x2 : 0000000000000040 x1 : ffff0830313bd000 x0 : ffff0830313bcc40
  Call trace:
   dcache_clean_inval_poc+0x24/0x38
   stage2_unmap_walker+0x138/0x1ec
   __kvm_pgtable_walk+0x130/0x1d4
   __kvm_pgtable_walk+0x170/0x1d4
   __kvm_pgtable_walk+0x170/0x1d4
   __kvm_pgtable_walk+0x170/0x1d4
   kvm_pgtable_stage2_unmap+0xc4/0xf8
   kvm_arch_flush_shadow_memslot+0xa4/0x10c
   kvm_set_memslot+0xb8/0x454
   __kvm_set_memory_region+0x194/0x244
   kvm_vm_ioctl_set_memory_region+0x58/0x7c
   kvm_vm_ioctl+0x49c/0x560
   __arm64_sys_ioctl+0x9c/0xd4
   invoke_syscall+0x4c/0x124
   el0_svc_common+0xc8/0x194
   do_el0_svc+0x38/0xc0
   el0_svc+0x2c/0xa4
   el0t_64_sync_handler+0x84/0xf0
   el0t_64_sync+0x1a0/0x1a4

Use the largest supported block mapping for the configured page size as
the batch granularity. In so doing the walker is guaranteed to visit a
leaf only once.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/stage2_pgtable.h | 20 --------------------
 arch/arm64/kvm/mmu.c                    |  9 ++++++++-
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index fe341a6578c3..c8dca8ae359c 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -10,13 +10,6 @@
 
 #include <linux/pgtable.h>
 
-/*
- * PGDIR_SHIFT determines the size a top-level page table entry can map
- * and depends on the number of levels in the page table. Compute the
- * PGDIR_SHIFT for a given number of levels.
- */
-#define pt_levels_pgdir_shift(lvls)	ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (lvls))
-
 /*
  * The hardware supports concatenation of up to 16 tables at stage2 entry
  * level and we use the feature whenever possible, which means we resolve 4
@@ -30,11 +23,6 @@
 #define stage2_pgtable_levels(ipa)	ARM64_HW_PGTABLE_LEVELS((ipa) - 4)
 #define kvm_stage2_levels(kvm)		VTCR_EL2_LVLS(kvm->arch.vtcr)
 
-/* stage2_pgdir_shift() is the size mapped by top-level stage2 entry for the VM */
-#define stage2_pgdir_shift(kvm)		pt_levels_pgdir_shift(kvm_stage2_levels(kvm))
-#define stage2_pgdir_size(kvm)		(1ULL << stage2_pgdir_shift(kvm))
-#define stage2_pgdir_mask(kvm)		~(stage2_pgdir_size(kvm) - 1)
-
 /*
  * kvm_mmmu_cache_min_pages() is the number of pages required to install
  * a stage-2 translation. We pre-allocate the entry level page table at
@@ -42,12 +30,4 @@
  */
 #define kvm_mmu_cache_min_pages(kvm)	(kvm_stage2_levels(kvm) - 1)
 
-static inline phys_addr_t
-stage2_pgd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
-{
-	phys_addr_t boundary = (addr + stage2_pgdir_size(kvm)) & stage2_pgdir_mask(kvm);
-
-	return (boundary - 1 < end - 1) ? boundary : end;
-}
-
 #endif	/* __ARM64_S2_PGTABLE_H_ */
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c9a13e487187..caf6cfeff35b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -31,6 +31,13 @@ static phys_addr_t hyp_idmap_vector;
 
 static unsigned long io_map_base;
 
+static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
+{
+	phys_addr_t size = kvm_granule_size(KVM_PGTABLE_MIN_BLOCK_LEVEL);
+	phys_addr_t boundary = ALIGN_DOWN(addr + size, size);
+
+	return (boundary - 1 < end - 1) ? boundary : end;
+}
 
 /*
  * Release kvm_mmu_lock periodically if the memory region is large. Otherwise,
@@ -52,7 +59,7 @@ static int stage2_apply_range(struct kvm *kvm, phys_addr_t addr,
 		if (!pgt)
 			return -EINVAL;
 
-		next = stage2_pgd_addr_end(kvm, addr, end);
+		next = stage2_range_addr_end(addr, end);
 		ret = fn(pgt, addr, next - addr);
 		if (ret)
 			break;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
