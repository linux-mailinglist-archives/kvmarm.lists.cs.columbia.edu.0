Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF43ED3E7
	for <lists+kvmarm@lfdr.de>; Mon, 16 Aug 2021 14:26:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A5724B0D0;
	Mon, 16 Aug 2021 08:26:48 -0400 (EDT)
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
	with ESMTP id PiyKwxjyRLuA; Mon, 16 Aug 2021 08:26:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7A334B0D4;
	Mon, 16 Aug 2021 08:26:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D27C74B0AD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Aug 2021 08:26:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xcMGDi6Ubdt for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Aug 2021 08:26:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DC3314B0AC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Aug 2021 08:26:37 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E14C661C19;
 Mon, 16 Aug 2021 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629116796;
 bh=oKGepH+V+CuRpZMZ1SznskgkAaw7iXR+hlH95oGa2O8=;
 h=From:To:Cc:Subject:Date:From;
 b=RilaEPxyYfwaa78F2JInfDC366AkDMXVuYmme2b614jAkTLbko12psRUTDlW2ps7s
 8ZcKxbQjkgJUPFCRnkxEG6a/9T9bKWwRvL+JIi2IdWYERfb+mwAEthxwWbjeVRpCGy
 nDwgxxWC933fwe+2cVj0YDuOGC+Vi3gVxta8vs5IK5Q4DGC3JgAiOnepvSF/AKv9n7
 oDHfe74RCLgHJ2q5iF+vjJVEIvSetNADYJrWFYyf+M2RXFUMrtW/hb0kgCvsdAGPio
 9bs5z+bUf/sljHxaa0YUN2HaKLSUkexZvF9UvdmznPF4oaKNE6qMPLM6Xp10UuTS92
 lYRzzL2c745pg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5] memblock: make memblock_find_in_range method private
Date: Mon, 16 Aug 2021 15:26:22 +0300
Message-Id: <20210816122622.30279-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: "Kirill A . Shutemov" <kirill.shtuemov@linux.intel.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, Will Deacon <will@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nick Kossifidis <mick@ics.forth.gr>,
 linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 linux-acpi@vger.kernel.org, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Mike Rapoport <rppt@kernel.org>
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

From: Mike Rapoport <rppt@linux.ibm.com>

There are a lot of uses of memblock_find_in_range() along with
memblock_reserve() from the times memblock allocation APIs did not exist.

memblock_find_in_range() is the very core of memblock allocations, so any
future changes to its internal behaviour would mandate updates of all the
users outside memblock.

Replace the calls to memblock_find_in_range() with an equivalent calls to
memblock_phys_alloc() and memblock_phys_alloc_range() and make
memblock_find_in_range() private method of memblock.

This simplifies the callers, ensures that (unlikely) errors in
memblock_reserve() are handled and improves maintainability of
memblock_find_in_range().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Kirill A. Shutemov <kirill.shtuemov@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>	# ACPI
Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Acked-by: Nick Kossifidis <mick@ics.forth.gr>			# riscv
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>		# arm64
---
v5:
* restore the original behaviour on x86 with addition of more elaborate
  comment; I will address the issue in memory_map_top_down() in a separate
  series.

v4: https://lore.kernel.org/lkml/20210812065907.20046-1-rppt@kernel.org
* Add patch that prevents the crashes reported by Guenter Roeck on x86/i386
  on QEMU with 256M or 512M of memory and EFI boot enabled.
* Add Acked-by and Reviewed-by, thanks everybidy!

v3: https://lore.kernel.org/lkml/20210803064218.6611-1-rppt@kernel.org
* simplify check for exact crash kerenl allocation on arm, per Rob
* make crash_max unsigned long long on arm64, per Rob

v2: https://lore.kernel.org/lkml/20210802063737.22733-1-rppt@kernel.org
* don't change error message in arm::reserve_crashkernel(), per Russell

v1: https://lore.kernel.org/lkml/20210730104039.7047-1-rppt@kernel.org


 arch/arm/kernel/setup.c           | 20 +++++---------
 arch/arm64/kvm/hyp/reserved_mem.c |  9 +++----
 arch/arm64/mm/init.c              | 36 ++++++++-----------------
 arch/mips/kernel/setup.c          | 14 +++++-----
 arch/riscv/mm/init.c              | 44 ++++++++++---------------------
 arch/s390/kernel/setup.c          | 10 ++++---
 arch/x86/kernel/aperture_64.c     |  5 ++--
 arch/x86/mm/init.c                | 23 ++++++++++------
 arch/x86/mm/numa.c                |  5 ++--
 arch/x86/mm/numa_emulation.c      |  5 ++--
 arch/x86/realmode/init.c          |  2 +-
 drivers/acpi/tables.c             |  5 ++--
 drivers/base/arch_numa.c          |  5 +---
 drivers/of/of_reserved_mem.c      | 12 ++++++---
 include/linux/memblock.h          |  2 --
 mm/memblock.c                     |  2 +-
 16 files changed, 81 insertions(+), 118 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f97eb2371672..284a80c0b6e1 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1012,31 +1012,25 @@ static void __init reserve_crashkernel(void)
 		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
 		if (crash_max > lowmem_max)
 			crash_max = lowmem_max;
-		crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
-						    crash_size, CRASH_ALIGN);
+
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+						       CRASH_ALIGN, crash_max);
 		if (!crash_base) {
 			pr_err("crashkernel reservation failed - No suitable area found.\n");
 			return;
 		}
 	} else {
+		unsigned long long crash_max = crash_base + crash_size;
 		unsigned long long start;
 
-		start = memblock_find_in_range(crash_base,
-					       crash_base + crash_size,
-					       crash_size, SECTION_SIZE);
-		if (start != crash_base) {
+		start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
+						  crash_base, crash_max);
+		if (!start) {
 			pr_err("crashkernel reservation failed - memory is in use.\n");
 			return;
 		}
 	}
 
-	ret = memblock_reserve(crash_base, crash_size);
-	if (ret < 0) {
-		pr_warn("crashkernel reservation failed - memory is in use (0x%lx)\n",
-			(unsigned long)crash_base);
-		return;
-	}
-
 	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
 		(unsigned long)(crash_size >> 20),
 		(unsigned long)(crash_base >> 20),
diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
index d654921dd09b..578670e3f608 100644
--- a/arch/arm64/kvm/hyp/reserved_mem.c
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -92,12 +92,10 @@ void __init kvm_hyp_reserve(void)
 	 * this is unmapped from the host stage-2, and fallback to PAGE_SIZE.
 	 */
 	hyp_mem_size = hyp_mem_pages << PAGE_SHIFT;
-	hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
-					      ALIGN(hyp_mem_size, PMD_SIZE),
-					      PMD_SIZE);
+	hyp_mem_base = memblock_phys_alloc(ALIGN(hyp_mem_size, PMD_SIZE),
+					   PMD_SIZE);
 	if (!hyp_mem_base)
-		hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
-						      hyp_mem_size, PAGE_SIZE);
+		hyp_mem_base = memblock_phys_alloc(hyp_mem_size, PAGE_SIZE);
 	else
 		hyp_mem_size = ALIGN(hyp_mem_size, PMD_SIZE);
 
@@ -105,7 +103,6 @@ void __init kvm_hyp_reserve(void)
 		kvm_err("Failed to reserve hyp memory\n");
 		return;
 	}
-	memblock_reserve(hyp_mem_base, hyp_mem_size);
 
 	kvm_info("Reserved %lld MiB at 0x%llx\n", hyp_mem_size >> 20,
 		 hyp_mem_base);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8490ed2917ff..0bffd2d1854f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -74,6 +74,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
+	unsigned long long crash_max = arm64_dma_phys_limit;
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
@@ -84,33 +85,18 @@ static void __init reserve_crashkernel(void)
 
 	crash_size = PAGE_ALIGN(crash_size);
 
-	if (crash_base == 0) {
-		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, arm64_dma_phys_limit,
-				crash_size, SZ_2M);
-		if (crash_base == 0) {
-			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-				crash_size);
-			return;
-		}
-	} else {
-		/* User specifies base address explicitly. */
-		if (!memblock_is_region_memory(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region is not memory\n");
-			return;
-		}
+	/* User specifies base address explicitly. */
+	if (crash_base)
+		crash_max = crash_base + crash_size;
 
-		if (memblock_is_region_reserved(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
-			return;
-		}
-
-		if (!IS_ALIGNED(crash_base, SZ_2M)) {
-			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
-			return;
-		}
+	/* Current arm64 boot protocol requires 2MB alignment */
+	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
+					       crash_base, crash_max);
+	if (!crash_base) {
+		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
+			crash_size);
+		return;
 	}
-	memblock_reserve(crash_base, crash_size);
 
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 23a140327a0b..f979adfd4fc2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -452,8 +452,9 @@ static void __init mips_parse_crashkernel(void)
 		return;
 
 	if (crash_base <= 0) {
-		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_MAX,
-							crash_size, CRASH_ALIGN);
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+						       CRASH_ALIGN,
+						       CRASH_ADDR_MAX);
 		if (!crash_base) {
 			pr_warn("crashkernel reservation failed - No suitable area found.\n");
 			return;
@@ -461,8 +462,9 @@ static void __init mips_parse_crashkernel(void)
 	} else {
 		unsigned long long start;
 
-		start = memblock_find_in_range(crash_base, crash_base + crash_size,
-						crash_size, 1);
+		start = memblock_phys_alloc_range(crash_size, 1,
+						  crash_base,
+						  crash_base + crash_size);
 		if (start != crash_base) {
 			pr_warn("Invalid memory region reserved for crash kernel\n");
 			return;
@@ -656,10 +658,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	mips_reserve_vmcore();
 
 	mips_parse_crashkernel();
-#ifdef CONFIG_KEXEC
-	if (crashk_res.start != crashk_res.end)
-		memblock_reserve(crashk_res.start, resource_size(&crashk_res));
-#endif
 	device_tree_init();
 
 	/*
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a14bf3910eec..88649337c568 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -812,38 +812,22 @@ static void __init reserve_crashkernel(void)
 
 	crash_size = PAGE_ALIGN(crash_size);
 
-	if (crash_base == 0) {
-		/*
-		 * Current riscv boot protocol requires 2MB alignment for
-		 * RV64 and 4MB alignment for RV32 (hugepage size)
-		 */
-		crash_base = memblock_find_in_range(search_start, search_end,
-						    crash_size, PMD_SIZE);
-
-		if (crash_base == 0) {
-			pr_warn("crashkernel: couldn't allocate %lldKB\n",
-				crash_size >> 10);
-			return;
-		}
-	} else {
-		/* User specifies base address explicitly. */
-		if (!memblock_is_region_memory(crash_base, crash_size)) {
-			pr_warn("crashkernel: requested region is not memory\n");
-			return;
-		}
-
-		if (memblock_is_region_reserved(crash_base, crash_size)) {
-			pr_warn("crashkernel: requested region is reserved\n");
-			return;
-		}
-
+	if (crash_base) {
+		search_start = crash_base;
+		search_end = crash_base + crash_size;
+	}
 
-		if (!IS_ALIGNED(crash_base, PMD_SIZE)) {
-			pr_warn("crashkernel: requested region is misaligned\n");
-			return;
-		}
+	/*
+	 * Current riscv boot protocol requires 2MB alignment for
+	 * RV64 and 4MB alignment for RV32 (hugepage size)
+	 */
+	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
+					       search_start, search_end);
+	if (crash_base == 0) {
+		pr_warn("crashkernel: couldn't allocate %lldKB\n",
+			crash_size >> 10);
+		return;
 	}
-	memblock_reserve(crash_base, crash_size);
 
 	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index ff0f9e838916..3d9efee0f43c 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -626,8 +626,9 @@ static void __init reserve_crashkernel(void)
 			return;
 		}
 		low = crash_base ?: low;
-		crash_base = memblock_find_in_range(low, high, crash_size,
-						    KEXEC_CRASH_MEM_ALIGN);
+		crash_base = memblock_phys_alloc_range(crash_size,
+						       KEXEC_CRASH_MEM_ALIGN,
+						       low, high);
 	}
 
 	if (!crash_base) {
@@ -636,14 +637,15 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if (register_memory_notifier(&kdump_mem_nb))
+	if (register_memory_notifier(&kdump_mem_nb)) {
+		memblock_free(crash_base, crash_size);
 		return;
+	}
 
 	if (!OLDMEM_BASE && MACHINE_IS_VM)
 		diag10_range(PFN_DOWN(crash_base), PFN_DOWN(crash_size));
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
-	memblock_remove(crash_base, crash_size);
 	pr_info("Reserving %lluMB of memory at %lluMB "
 		"for crashkernel (System RAM: %luMB)\n",
 		crash_size >> 20, crash_base >> 20,
diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 294ed4392a0e..10562885f5fc 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -109,14 +109,13 @@ static u32 __init allocate_aperture(void)
 	 * memory. Unfortunately we cannot move it up because that would
 	 * make the IOMMU useless.
 	 */
-	addr = memblock_find_in_range(GART_MIN_ADDR, GART_MAX_ADDR,
-				      aper_size, aper_size);
+	addr = memblock_phys_alloc_range(aper_size, aper_size,
+					 GART_MIN_ADDR, GART_MAX_ADDR);
 	if (!addr) {
 		pr_err("Cannot allocate aperture memory hole [mem %#010lx-%#010lx] (%uKB)\n",
 		       addr, addr + aper_size - 1, aper_size >> 10);
 		return 0;
 	}
-	memblock_reserve(addr, aper_size);
 	pr_info("Mapping aperture over RAM [mem %#010lx-%#010lx] (%uKB)\n",
 		addr, addr + aper_size - 1, aper_size >> 10);
 	register_nosave_region(addr >> PAGE_SHIFT,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 75ef19aa8903..23a14d82e783 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -127,14 +127,12 @@ __ref void *alloc_low_pages(unsigned int num)
 		unsigned long ret = 0;
 
 		if (min_pfn_mapped < max_pfn_mapped) {
-			ret = memblock_find_in_range(
+			ret = memblock_phys_alloc_range(
+					PAGE_SIZE * num, PAGE_SIZE,
 					min_pfn_mapped << PAGE_SHIFT,
-					max_pfn_mapped << PAGE_SHIFT,
-					PAGE_SIZE * num , PAGE_SIZE);
+					max_pfn_mapped << PAGE_SHIFT);
 		}
-		if (ret)
-			memblock_reserve(ret, PAGE_SIZE * num);
-		else if (can_use_brk_pgt)
+		if (!ret && can_use_brk_pgt)
 			ret = __pa(extend_brk(PAGE_SIZE * num, PAGE_SIZE));
 
 		if (!ret)
@@ -610,8 +608,17 @@ static void __init memory_map_top_down(unsigned long map_start,
 	unsigned long addr;
 	unsigned long mapped_ram_size = 0;
 
-	/* xen has big range in reserved near end of ram, skip it at first.*/
-	addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
+	/*
+	 * Systems that have many reserved areas near top of the memory,
+	 * e.g. QEMU with less than 1G RAM and EFI enabled, or Xen, will
+	 * require lots of 4K mappings which may exhaust pgt_buf.
+	 * Start with top-most PMD_SIZE range aligned at PMD_SIZE to ensure
+	 * there is enough mapped memory that can be allocated from
+	 * memblock.
+	 */
+	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
+					 map_end);
+	memblock_free(addr, PMD_SIZE);
 	real_end = addr + PMD_SIZE;
 
 	/* step_size need to be small so pgt_buf from BRK could cover it */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e94da744386f..a1b5c71099e6 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -376,15 +376,14 @@ static int __init numa_alloc_distance(void)
 	cnt++;
 	size = cnt * cnt * sizeof(numa_distance[0]);
 
-	phys = memblock_find_in_range(0, PFN_PHYS(max_pfn_mapped),
-				      size, PAGE_SIZE);
+	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0,
+					 PFN_PHYS(max_pfn_mapped));
 	if (!phys) {
 		pr_warn("Warning: can't allocate distance table!\n");
 		/* don't retry until explicitly reset */
 		numa_distance = (void *)1LU;
 		return -ENOMEM;
 	}
-	memblock_reserve(phys, size);
 
 	numa_distance = __va(phys);
 	numa_distance_cnt = cnt;
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 87d77cc52f86..737491b13728 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -447,13 +447,12 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 	if (numa_dist_cnt) {
 		u64 phys;
 
-		phys = memblock_find_in_range(0, PFN_PHYS(max_pfn_mapped),
-					      phys_size, PAGE_SIZE);
+		phys = memblock_phys_alloc_range(phys_size, PAGE_SIZE, 0,
+						 PFN_PHYS(max_pfn_mapped));
 		if (!phys) {
 			pr_warn("NUMA: Warning: can't allocate copy of distance table, disabling emulation\n");
 			goto no_emu;
 		}
-		memblock_reserve(phys, phys_size);
 		phys_dist = __va(phys);
 
 		for (i = 0; i < numa_dist_cnt; i++)
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 6534c92d0f83..31b5856010cb 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -28,7 +28,7 @@ void __init reserve_real_mode(void)
 	WARN_ON(slab_is_available());
 
 	/* Has to be under 1M so we can execute real-mode AP code. */
-	mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
+	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
 	if (!mem)
 		pr_info("No sub-1M memory is available for the trampoline\n");
 	else
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a37a1532a575..f9383736fa0f 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -583,8 +583,8 @@ void __init acpi_table_upgrade(void)
 	}
 
 	acpi_tables_addr =
-		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
-				       all_tables_size, PAGE_SIZE);
+		memblock_phys_alloc_range(all_tables_size, PAGE_SIZE,
+					  0, ACPI_TABLE_UPGRADE_MAX_PHYS);
 	if (!acpi_tables_addr) {
 		WARN_ON(1);
 		return;
@@ -599,7 +599,6 @@ void __init acpi_table_upgrade(void)
 	 * Both memblock_reserve and e820__range_add (via arch_reserve_mem_area)
 	 * works fine.
 	 */
-	memblock_reserve(acpi_tables_addr, all_tables_size);
 	arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
 
 	/*
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 4cc4e117727d..46c503486e96 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -279,13 +279,10 @@ static int __init numa_alloc_distance(void)
 	int i, j;
 
 	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
-	phys = memblock_find_in_range(0, PFN_PHYS(max_pfn),
-				      size, PAGE_SIZE);
+	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0, PFN_PHYS(max_pfn));
 	if (WARN_ON(!phys))
 		return -ENOMEM;
 
-	memblock_reserve(phys, size);
-
 	numa_distance = __va(phys);
 	numa_distance_cnt = nr_node_ids;
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index fd3964d24224..59c1390cdf42 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -33,18 +33,22 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	phys_addr_t *res_base)
 {
 	phys_addr_t base;
+	int err = 0;
 
 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
 	align = !align ? SMP_CACHE_BYTES : align;
-	base = memblock_find_in_range(start, end, size, align);
+	base = memblock_phys_alloc_range(size, align, start, end);
 	if (!base)
 		return -ENOMEM;
 
 	*res_base = base;
-	if (nomap)
-		return memblock_mark_nomap(base, size);
+	if (nomap) {
+		err = memblock_mark_nomap(base, size);
+		if (err)
+			memblock_free(base, size);
+	}
 
-	return memblock_reserve(base, size);
+	return err;
 }
 
 /*
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 4a53c3ca86bd..b066024c62e3 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -99,8 +99,6 @@ void memblock_discard(void);
 static inline void memblock_discard(void) {}
 #endif
 
-phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
-				   phys_addr_t size, phys_addr_t align);
 void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
 int memblock_add(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index de7b553baa50..28a813d9e955 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -315,7 +315,7 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
  * Return:
  * Found address on success, 0 on failure.
  */
-phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
+static phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 					phys_addr_t end, phys_addr_t size,
 					phys_addr_t align)
 {

base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
