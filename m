Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9845951E5E9
	for <lists+kvmarm@lfdr.de>; Sat,  7 May 2022 11:14:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 328CA4B249;
	Sat,  7 May 2022 05:14:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level: 
X-Spam-Status: No, score=-1.898 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_BLOCKED=0.001, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DdkkP6aDHEvE; Sat,  7 May 2022 05:14:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05C5A4B2D2;
	Sat,  7 May 2022 05:14:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F18B4B152
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 May 2022 10:09:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xoo4rP0b566Q for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 May 2022 10:09:22 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 09E994B18A
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 May 2022 10:09:22 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7A941570;
 Fri,  6 May 2022 07:09:21 -0700 (PDT)
Received: from godel.lab.cambridge.arm.com (godel.lab.cambridge.arm.com
 [10.7.66.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84753F885;
 Fri,  6 May 2022 07:09:20 -0700 (PDT)
From: Nikos Nikoleris <nikos.nikoleris@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: [kvm-unit-tests PATCH 17/23] arm64: Copy code from GNU-EFI
Date: Fri,  6 May 2022 15:08:49 +0100
Message-Id: <20220506140855.353337-18-nikos.nikoleris@arm.com>
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

This change adds unmodified dependencies that we need from GNU-EFI in
order to build arm64 EFI apps.

GNU-EFI sources from  https://git.code.sf.net/p/gnu-efi/code v3.0.14

Signed-off-by: Nikos Nikoleris <nikos.nikoleris@arm.com>
---
 arm/efi/elf_aarch64_efi.lds |  63 +++++++++++++++++
 arm/efi/crt0-efi-aarch64.S  | 130 ++++++++++++++++++++++++++++++++++++
 arm/efi/reloc_aarch64.c     |  97 +++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 arm/efi/elf_aarch64_efi.lds
 create mode 100644 arm/efi/crt0-efi-aarch64.S
 create mode 100644 arm/efi/reloc_aarch64.c

diff --git a/arm/efi/elf_aarch64_efi.lds b/arm/efi/elf_aarch64_efi.lds
new file mode 100644
index 0000000..836d982
--- /dev/null
+++ b/arm/efi/elf_aarch64_efi.lds
@@ -0,0 +1,63 @@
+OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+OUTPUT_ARCH(aarch64)
+ENTRY(_start)
+SECTIONS
+{
+  .text 0x0 : {
+    _text = .;
+    *(.text.head)
+    *(.text)
+    *(.text.*)
+    *(.gnu.linkonce.t.*)
+    *(.srodata)
+    *(.rodata*)
+    . = ALIGN(16);
+  }
+  _etext = .;
+  _text_size = . - _text;
+  .dynamic  : { *(.dynamic) }
+  .data : ALIGN(4096)
+  {
+   _data = .;
+   *(.sdata)
+   *(.data)
+   *(.data1)
+   *(.data.*)
+   *(.got.plt)
+   *(.got)
+
+   /* the EFI loader doesn't seem to like a .bss section, so we stick
+      it all into .data: */
+   . = ALIGN(16);
+   _bss = .;
+   *(.sbss)
+   *(.scommon)
+   *(.dynbss)
+   *(.bss)
+   *(COMMON)
+   . = ALIGN(16);
+   _bss_end = .;
+  }
+
+  .rela.dyn : { *(.rela.dyn) }
+  .rela.plt : { *(.rela.plt) }
+  .rela.got : { *(.rela.got) }
+  .rela.data : { *(.rela.data) *(.rela.data*) }
+  . = ALIGN(512);
+  _edata = .;
+  _data_size = . - _data;
+
+  . = ALIGN(4096);
+  .dynsym   : { *(.dynsym) }
+  . = ALIGN(4096);
+  .dynstr   : { *(.dynstr) }
+  . = ALIGN(4096);
+  .note.gnu.build-id : { *(.note.gnu.build-id) }
+  /DISCARD/ :
+  {
+    *(.rel.reloc)
+    *(.eh_frame)
+    *(.note.GNU-stack)
+  }
+  .comment 0 : { *(.comment) }
+}
diff --git a/arm/efi/crt0-efi-aarch64.S b/arm/efi/crt0-efi-aarch64.S
new file mode 100644
index 0000000..d50e78d
--- /dev/null
+++ b/arm/efi/crt0-efi-aarch64.S
@@ -0,0 +1,130 @@
+/*
+ * crt0-efi-aarch64.S - PE/COFF header for AArch64 EFI applications
+ *
+ * Copright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice and this list of conditions, without modification.
+ * 2. The name of the author may not be used to endorse or promote products
+ *    derived from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License as published by the Free Software Foundation;
+ * either version 2 of the License, or (at your option) any later version.
+ */
+
+	.section	.text.head
+
+	/*
+	 * Magic "MZ" signature for PE/COFF
+	 */
+	.globl	ImageBase
+ImageBase:
+	.ascii	"MZ"
+	.skip	58				// 'MZ' + pad + offset == 64
+	.long	pe_header - ImageBase		// Offset to the PE header.
+pe_header:
+	.ascii	"PE"
+	.short 	0
+coff_header:
+	.short	0xaa64				// AArch64
+	.short	2				// nr_sections
+	.long	0 				// TimeDateStamp
+	.long	0				// PointerToSymbolTable
+	.long	0				// NumberOfSymbols
+	.short	section_table - optional_header	// SizeOfOptionalHeader
+	.short	0x206				// Characteristics.
+						// IMAGE_FILE_DEBUG_STRIPPED |
+						// IMAGE_FILE_EXECUTABLE_IMAGE |
+						// IMAGE_FILE_LINE_NUMS_STRIPPED
+optional_header:
+	.short	0x20b				// PE32+ format
+	.byte	0x02				// MajorLinkerVersion
+	.byte	0x14				// MinorLinkerVersion
+	.long	_data - _start			// SizeOfCode
+	.long	_data_size			// SizeOfInitializedData
+	.long	0				// SizeOfUninitializedData
+	.long	_start - ImageBase		// AddressOfEntryPoint
+	.long	_start - ImageBase		// BaseOfCode
+
+extra_header_fields:
+	.quad	0				// ImageBase
+	.long	0x1000				// SectionAlignment
+	.long	0x200				// FileAlignment
+	.short	0				// MajorOperatingSystemVersion
+	.short	0				// MinorOperatingSystemVersion
+	.short	0				// MajorImageVersion
+	.short	0				// MinorImageVersion
+	.short	0				// MajorSubsystemVersion
+	.short	0				// MinorSubsystemVersion
+	.long	0				// Win32VersionValue
+
+	.long	_edata - ImageBase		// SizeOfImage
+
+	// Everything before the kernel image is considered part of the header
+	.long	_start - ImageBase		// SizeOfHeaders
+	.long	0				// CheckSum
+	.short	EFI_SUBSYSTEM			// Subsystem
+	.short	0				// DllCharacteristics
+	.quad	0				// SizeOfStackReserve
+	.quad	0				// SizeOfStackCommit
+	.quad	0				// SizeOfHeapReserve
+	.quad	0				// SizeOfHeapCommit
+	.long	0				// LoaderFlags
+	.long	0x6				// NumberOfRvaAndSizes
+
+	.quad	0				// ExportTable
+	.quad	0				// ImportTable
+	.quad	0				// ResourceTable
+	.quad	0				// ExceptionTable
+	.quad	0				// CertificationTable
+	.quad	0				// BaseRelocationTable
+
+	// Section table
+section_table:
+	.ascii	".text\0\0\0"
+	.long	_data - _start		// VirtualSize
+	.long	_start - ImageBase	// VirtualAddress
+	.long	_data - _start		// SizeOfRawData
+	.long	_start - ImageBase	// PointerToRawData
+
+	.long	0		// PointerToRelocations (0 for executables)
+	.long	0		// PointerToLineNumbers (0 for executables)
+	.short	0		// NumberOfRelocations  (0 for executables)
+	.short	0		// NumberOfLineNumbers  (0 for executables)
+	.long	0x60000020	// Characteristics (section flags)
+
+	.ascii	".data\0\0\0"
+	.long	_data_size		// VirtualSize
+	.long	_data - ImageBase	// VirtualAddress
+	.long	_data_size		// SizeOfRawData
+	.long	_data - ImageBase	// PointerToRawData
+
+	.long	0		// PointerToRelocations (0 for executables)
+	.long	0		// PointerToLineNumbers (0 for executables)
+	.short	0		// NumberOfRelocations  (0 for executables)
+	.short	0		// NumberOfLineNumbers  (0 for executables)
+	.long	0xc0000040	// Characteristics (section flags)
+
+	.align		12
+_start:
+	stp		x29, x30, [sp, #-32]!
+	mov		x29, sp
+
+	stp		x0, x1, [sp, #16]
+	mov		x2, x0
+	mov		x3, x1
+	adr		x0, ImageBase
+	adrp		x1, _DYNAMIC
+	add		x1, x1, #:lo12:_DYNAMIC
+	bl		_relocate
+	cbnz		x0, 0f
+
+	ldp		x0, x1, [sp, #16]
+	bl		efi_main
+
+0:	ldp		x29, x30, [sp], #32
+	ret
diff --git a/arm/efi/reloc_aarch64.c b/arm/efi/reloc_aarch64.c
new file mode 100644
index 0000000..0867279
--- /dev/null
+++ b/arm/efi/reloc_aarch64.c
@@ -0,0 +1,97 @@
+/* reloc_aarch64.c - position independent x86 ELF shared object relocator
+   Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+   Copyright (C) 1999 Hewlett-Packard Co.
+	Contributed by David Mosberger <davidm@hpl.hp.com>.
+
+    All rights reserved.
+
+    Redistribution and use in source and binary forms, with or without
+    modification, are permitted provided that the following conditions
+    are met:
+
+    * Redistributions of source code must retain the above copyright
+      notice, this list of conditions and the following disclaimer.
+    * Redistributions in binary form must reproduce the above
+      copyright notice, this list of conditions and the following
+      disclaimer in the documentation and/or other materials
+      provided with the distribution.
+    * Neither the name of Hewlett-Packard Co. nor the names of its
+      contributors may be used to endorse or promote products derived
+      from this software without specific prior written permission.
+
+    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+    MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
+    BE LIABLE FOR ANYDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
+    OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+    TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
+    THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+    SUCH DAMAGE.
+*/
+
+#include <efi.h>
+#include <efilib.h>
+
+#include <elf.h>
+
+EFI_STATUS _relocate (long ldbase, Elf64_Dyn *dyn,
+		      EFI_HANDLE image EFI_UNUSED,
+		      EFI_SYSTEM_TABLE *systab EFI_UNUSED)
+{
+	long relsz = 0, relent = 0;
+	Elf64_Rela *rel = 0;
+	unsigned long *addr;
+	int i;
+
+	for (i = 0; dyn[i].d_tag != DT_NULL; ++i) {
+		switch (dyn[i].d_tag) {
+			case DT_RELA:
+				rel = (Elf64_Rela*)
+					((unsigned long)dyn[i].d_un.d_ptr
+					 + ldbase);
+				break;
+
+			case DT_RELASZ:
+				relsz = dyn[i].d_un.d_val;
+				break;
+
+			case DT_RELAENT:
+				relent = dyn[i].d_un.d_val;
+				break;
+
+			default:
+				break;
+		}
+	}
+
+	if (!rel && relent == 0)
+		return EFI_SUCCESS;
+
+	if (!rel || relent == 0)
+		return EFI_LOAD_ERROR;
+
+	while (relsz > 0) {
+		/* apply the relocs */
+		switch (ELF64_R_TYPE (rel->r_info)) {
+			case R_AARCH64_NONE:
+				break;
+
+			case R_AARCH64_RELATIVE:
+				addr = (unsigned long *)
+					(ldbase + rel->r_offset);
+				*addr = ldbase + rel->r_addend;
+				break;
+
+			default:
+				break;
+		}
+		rel = (Elf64_Rela*) ((char *) rel + relent);
+		relsz -= relent;
+	}
+	return EFI_SUCCESS;
+}
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
