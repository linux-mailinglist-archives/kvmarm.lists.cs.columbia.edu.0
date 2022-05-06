Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E48AE51E5E7
	for <lists+kvmarm@lfdr.de>; Sat,  7 May 2022 11:14:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 685804291D;
	Sat,  7 May 2022 05:14:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dwm6MTY0W4SO; Sat,  7 May 2022 05:14:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D746F4B2CF;
	Sat,  7 May 2022 05:14:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C0114B1CB
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 May 2022 10:09:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i3gZKmKNvBuL for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 May 2022 10:09:20 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C19244B177
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 May 2022 10:09:20 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DACA1595;
 Fri,  6 May 2022 07:09:20 -0700 (PDT)
Received: from godel.lab.cambridge.arm.com (godel.lab.cambridge.arm.com
 [10.7.66.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E40A3F885;
 Fri,  6 May 2022 07:09:19 -0700 (PDT)
From: Nikos Nikoleris <nikos.nikoleris@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: [kvm-unit-tests PATCH 16/23] arm/arm64: Add a setup sequence for
 systems that boot through EFI
Date: Fri,  6 May 2022 15:08:48 +0100
Message-Id: <20220506140855.353337-17-nikos.nikoleris@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506140855.353337-1-nikos.nikoleris@arm.com>
References: <20220506140855.353337-1-nikos.nikoleris@arm.com>
MIME-Version: 1.0
X-ARM-No-Footer: FoSSMail
X-Mailman-Approved-At: Sat, 07 May 2022 05:14:38 -0400
Cc: Nikos Nikoleris <nikos.nikoleris@arm.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, jade.alglave@arm.com
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

This change implements an alternative setup sequence for the system
when we are booting through EFI. The memory map is discovered through
EFI boot services and devices through ACPI.

This change is based on a change initially proposed by
Andrew Jones <drjones@redhat.com>

Signed-off-by: Nikos Nikoleris <nikos.nikoleris@arm.com>
---
 lib/linux/efi.h     |   1 +
 lib/arm/asm/setup.h |   2 +
 lib/arm/setup.c     | 179 +++++++++++++++++++++++++++++++++++++++++++-
 arm/cstart.S        |   1 +
 arm/cstart64.S      |   1 +
 5 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/lib/linux/efi.h b/lib/linux/efi.h
index d7401c9..73faa70 100644
--- a/lib/linux/efi.h
+++ b/lib/linux/efi.h
@@ -63,6 +63,7 @@ typedef guid_t efi_guid_t;
 	(c) & 0xff, ((c) >> 8) & 0xff, d } }
 
 #define ACPI_TABLE_GUID EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3, 0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
+#define ACPI_20_TABLE_GUID EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
 
 #define LOADED_IMAGE_PROTOCOL_GUID EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 
diff --git a/lib/arm/asm/setup.h b/lib/arm/asm/setup.h
index 64cd379..1a7e734 100644
--- a/lib/arm/asm/setup.h
+++ b/lib/arm/asm/setup.h
@@ -5,6 +5,7 @@
  *
  * This work is licensed under the terms of the GNU LGPL, version 2.
  */
+#include <efi.h>
 #include <libcflat.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
@@ -37,5 +38,6 @@ extern unsigned int mem_region_get_flags(phys_addr_t paddr);
 #define SMP_CACHE_BYTES		L1_CACHE_BYTES
 
 void setup(const void *fdt, phys_addr_t freemem_start);
+efi_status_t setup_efi(efi_bootinfo_t *efi_bootinfo);
 
 #endif /* _ASMARM_SETUP_H_ */
diff --git a/lib/arm/setup.c b/lib/arm/setup.c
index 2d67292..edd4dc5 100644
--- a/lib/arm/setup.c
+++ b/lib/arm/setup.c
@@ -34,7 +34,7 @@
 #define NR_EXTRA_MEM_REGIONS	16
 #define NR_INITIAL_MEM_REGIONS	(MAX_DT_MEM_REGIONS + NR_EXTRA_MEM_REGIONS)
 
-extern unsigned long _etext;
+extern unsigned long _text, _etext, _data, _edata;
 
 char *initrd;
 u32 initrd_size;
@@ -44,7 +44,10 @@ int nr_cpus;
 
 static struct mem_region __initial_mem_regions[NR_INITIAL_MEM_REGIONS + 1];
 struct mem_region *mem_regions = __initial_mem_regions;
-phys_addr_t __phys_offset, __phys_end;
+phys_addr_t __phys_offset = (phys_addr_t)-1, __phys_end = 0;
+
+extern void exceptions_init(void);
+extern void asm_mmu_disable(void);
 
 int mpidr_to_cpu(uint64_t mpidr)
 {
@@ -272,3 +275,175 @@ void setup(const void *fdt, phys_addr_t freemem_start)
 	if (!(auxinfo.flags & AUXINFO_MMU_OFF))
 		setup_vm();
 }
+
+#ifdef CONFIG_EFI
+
+#include <efi.h>
+
+static efi_status_t setup_rsdp(efi_bootinfo_t *efi_bootinfo)
+{
+	efi_status_t status;
+	struct rsdp_descriptor *rsdp;
+
+	/*
+	 * RSDP resides in an EFI_ACPI_RECLAIM_MEMORY region, which is not used
+	 * by kvm-unit-tests arm64 memory allocator. So it is not necessary to
+	 * copy the data structure to another memory region to prevent
+	 * unintentional overwrite.
+	 */
+	status = efi_get_system_config_table(ACPI_20_TABLE_GUID, (void **)&rsdp);
+	if (status != EFI_SUCCESS) {
+		return status;
+	}
+
+	set_efi_rsdp(rsdp);
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t efi_mem_init(efi_bootinfo_t *efi_bootinfo)
+{
+	int i;
+	unsigned long free_mem_pages = 0;
+	unsigned long free_mem_start = 0;
+	struct efi_boot_memmap *map = &(efi_bootinfo->mem_map);
+	efi_memory_desc_t *buffer = *map->map;
+	efi_memory_desc_t *d = NULL;
+	phys_addr_t base, top;
+	struct mem_region *r;
+	uintptr_t text = (uintptr_t)&_text, etext = __ALIGN((uintptr_t)&_etext, 4096);
+	uintptr_t data = (uintptr_t)&_data, edata = __ALIGN((uintptr_t)&_edata, 4096);
+
+	/*
+	 * Record the largest free EFI_CONVENTIONAL_MEMORY region
+	 * which will be used to set up the memory allocator, so that
+	 * the memory allocator can work in the largest free
+	 * continuous memory region.
+	 */
+	for (i = 0, r = &mem_regions[0]; i < *(map->map_size); i += *(map->desc_size), ++r) {
+		d = (efi_memory_desc_t *)(&((u8 *)buffer)[i]);
+
+		r->start = d->phys_addr;
+		r->end = d->phys_addr + d->num_pages * EFI_PAGE_SIZE;
+
+		switch(d->type) {
+		case EFI_RESERVED_TYPE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_RUNTIME_SERVICES_CODE:
+		case EFI_RUNTIME_SERVICES_DATA:
+		case EFI_UNUSABLE_MEMORY:
+		case EFI_ACPI_RECLAIM_MEMORY:
+		case EFI_ACPI_MEMORY_NVS:
+		case EFI_PAL_CODE:
+			r->flags = MR_F_RESERVED;
+			break;
+		case EFI_MEMORY_MAPPED_IO:
+		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
+			r->flags = MR_F_IO;
+			break;
+		case EFI_LOADER_CODE:
+			if (r->start <= text && r->end > text) {
+				/* This is the unit test region. Flag the code separately. */
+				phys_addr_t tmp = r->end;
+				assert(etext <= data);
+				assert(edata <= r->end);
+				r->flags = MR_F_CODE;
+				r->end = data;
+				++r;
+				r->start = data;
+				r->end = tmp;
+			} else {
+				r->flags = MR_F_RESERVED;
+			}
+			break;
+		case EFI_CONVENTIONAL_MEMORY:
+			if (free_mem_pages < d->num_pages) {
+				free_mem_pages = d->num_pages;
+				free_mem_start = d->phys_addr;
+			}
+			break;
+		}
+
+		if (!(r->flags & MR_F_IO)) {
+			if (r->start < __phys_offset)
+				__phys_offset = r->start;
+			if (r->end > __phys_end)
+				__phys_end = r->end;
+		}
+	}
+	__phys_end &= PHYS_MASK;
+	asm_mmu_disable();
+
+	if (free_mem_pages == 0) {
+		return EFI_OUT_OF_RESOURCES;
+	}
+	assert(sizeof(long) == 8 || free_mem_start < (3ul << 30));
+
+	phys_alloc_init(free_mem_start, free_mem_pages << EFI_PAGE_SHIFT);
+	phys_alloc_set_minimum_alignment(SMP_CACHE_BYTES);
+
+	phys_alloc_get_unused(&base, &top);
+	base = PAGE_ALIGN(base);
+	top = top & PAGE_MASK;
+	assert(sizeof(long) == 8 || !(base >> 32));
+	if (sizeof(long) != 8 && (top >> 32) != 0)
+		top = ((uint64_t)1 << 32);
+	page_alloc_init_area(0, base >> PAGE_SHIFT, top >> PAGE_SHIFT);
+	page_alloc_ops_enable();
+
+	return EFI_SUCCESS;
+}
+
+efi_status_t setup_efi(efi_bootinfo_t *efi_bootinfo)
+{
+	efi_status_t status;
+
+	struct thread_info *ti = current_thread_info();
+	memset(ti, 0, sizeof(*ti));
+
+	exceptions_init();
+
+	status = efi_mem_init(efi_bootinfo);
+	if (status != EFI_SUCCESS) {
+		printf("Failed to initialize memory: ");
+		switch (status) {
+		case EFI_OUT_OF_RESOURCES:
+			printf("No free memory region\n");
+			break;
+		default:
+			printf("Unknown error\n");
+			break;
+		}
+		return status;
+	}
+
+	status = setup_rsdp(efi_bootinfo);
+	if (status != EFI_SUCCESS) {
+		printf("Cannot find RSDP in EFI system table\n");
+		return status;
+	}
+
+	psci_set_conduit();
+	cpu_init();
+	/* cpu_init must be called before thread_info_init */
+	thread_info_init(current_thread_info(), 0);
+	/* mem_init must be called before io_init */
+	io_init();
+
+	timer_save_state();
+	if (initrd) {
+		/* environ is currently the only file in the initrd */
+		char *env = malloc(initrd_size);
+		memcpy(env, initrd, initrd_size);
+		setup_env(env, initrd_size);
+	}
+
+	if (!(auxinfo.flags & AUXINFO_MMU_OFF))
+		setup_vm();
+
+	return EFI_SUCCESS;
+}
+
+#endif
diff --git a/arm/cstart.S b/arm/cstart.S
index dc324c5..66a55b9 100644
--- a/arm/cstart.S
+++ b/arm/cstart.S
@@ -256,6 +256,7 @@ asm_mmu_disable:
  *
  * Input r0 is the stack top, which is the exception stacks base
  */
+.globl exceptions_init
 exceptions_init:
 	mrc	p15, 0, r2, c1, c0, 0	@ read SCTLR
 	bic	r2, #CR_V		@ SCTLR.V := 0
diff --git a/arm/cstart64.S b/arm/cstart64.S
index 390feb9..55b41ea 100644
--- a/arm/cstart64.S
+++ b/arm/cstart64.S
@@ -276,6 +276,7 @@ asm_mmu_disable:
  * Vectors
  */
 
+.globl exceptions_init
 exceptions_init:
 	adrp	x4, vector_table
 	add	x4, x4, :lo12:vector_table
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
