Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F753527B
	for <lists+kvmarm@lfdr.de>; Thu, 26 May 2022 19:20:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 62A4E4B328;
	Thu, 26 May 2022 13:20:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level: 
X-Spam-Status: No, score=-1.898 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_BLOCKED=0.001, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fukmI--jNtfy; Thu, 26 May 2022 13:20:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F2BF4B292;
	Thu, 26 May 2022 13:20:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 772004B15E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 May 2022 13:20:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15PvWWtURzQV for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 May 2022 13:19:54 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E080B4B11A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 May 2022 13:19:52 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D341688;
 Thu, 26 May 2022 10:19:52 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B363F66F;
 Thu, 26 May 2022 10:19:49 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org,
 andre.przywara@arm.com, suzuki.poulose@arm.com, james.morse@arm.com,
 vladimir.murzin@arm.com, anup@brainfault.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 kvmtool 1/2] Add libfdt library
Date: Thu, 26 May 2022 18:19:54 +0100
Message-Id: <20220526171955.145563-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526171955.145563-1-alexandru.elisei@arm.com>
References: <20220526171955.145563-1-alexandru.elisei@arm.com>
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

The arm, arm64, powerpc and riscv architectures require that libfdt is
installed on the system, but the library might not be available on all
distros for every architecture. kvmtool has anticipated this situation and
it includes instructions to compile and install libfdt in the INSTALL file.

However, those instructions do not always work, leaving the user unable to
compile kvmtool. And when they work, it is tedious to clone, compile and
install libfdt manually for every supported architecture.

Even when libfdt for the chosen architecture is nicely packaged by the
distro, the user still has to do the extra step of locating and installing
it.

Get rid of all this overhead by adding the libfdt library to kvmtool.
kvmtool will be linked against the static version of the library, when an
architecture requires the library. This has been measured to add about
110KB to the total size of the binary, going from 2077KB to 2186KB, which
represents a 5.3% increase.

libfdt has been pulled from DTC commit ed310803ea89 ("pylibfdt: add
FdtRo.get_path()"). The changes to the kvmtool Makefile have been heavily
inspired by the DTC Makefile. No changes have been done to the libfdt
Makefile to allow easy updating in the future by copying the updated files.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Makefile                 |   39 +-
 libfdt/.gitignore        |    1 +
 libfdt/Makefile.libfdt   |   18 +
 libfdt/TODO              |    3 +
 libfdt/fdt.c             |  335 ++++++
 libfdt/fdt.h             |   66 ++
 libfdt/fdt_addresses.c   |  101 ++
 libfdt/fdt_check.c       |   93 ++
 libfdt/fdt_empty_tree.c  |   38 +
 libfdt/fdt_overlay.c     |  867 +++++++++++++++
 libfdt/fdt_ro.c          |  859 +++++++++++++++
 libfdt/fdt_rw.c          |  500 +++++++++
 libfdt/fdt_strerror.c    |   60 ++
 libfdt/fdt_sw.c          |  384 +++++++
 libfdt/fdt_wip.c         |   94 ++
 libfdt/libfdt.h          | 2147 ++++++++++++++++++++++++++++++++++++++
 libfdt/libfdt_env.h      |   96 ++
 libfdt/libfdt_internal.h |  192 ++++
 libfdt/meson.build       |   55 +
 libfdt/version.lds       |   83 ++
 20 files changed, 6017 insertions(+), 14 deletions(-)
 create mode 100644 libfdt/.gitignore
 create mode 100644 libfdt/Makefile.libfdt
 create mode 100644 libfdt/TODO
 create mode 100644 libfdt/fdt.c
 create mode 100644 libfdt/fdt.h
 create mode 100644 libfdt/fdt_addresses.c
 create mode 100644 libfdt/fdt_check.c
 create mode 100644 libfdt/fdt_empty_tree.c
 create mode 100644 libfdt/fdt_overlay.c
 create mode 100644 libfdt/fdt_ro.c
 create mode 100644 libfdt/fdt_rw.c
 create mode 100644 libfdt/fdt_strerror.c
 create mode 100644 libfdt/fdt_sw.c
 create mode 100644 libfdt/fdt_wip.c
 create mode 100644 libfdt/libfdt.h
 create mode 100644 libfdt/libfdt_env.h
 create mode 100644 libfdt/libfdt_internal.h
 create mode 100644 libfdt/meson.build
 create mode 100644 libfdt/version.lds

diff --git a/Makefile b/Makefile
index 6464446a9f24..432a3d235f67 100644
--- a/Makefile
+++ b/Makefile
@@ -5,6 +5,7 @@
 ifeq ($(strip $(V)),)
 	ifeq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
 		E = @echo
+		ARFLAGS = rc
 	else
 		E = @\#
 	endif
@@ -347,15 +348,16 @@ $(warning No static libc found. Skipping guest init)
 	NOTFOUND        += static-libc
 endif
 
+LIBFDT_dir = libfdt
+LIBFDT_archive = $(LIBFDT_dir)/libfdt.a
+
 ifeq (y,$(ARCH_WANT_LIBFDT))
-	ifneq ($(call try-build,$(SOURCE_LIBFDT),$(CFLAGS),-lfdt),y)
-          $(error No libfdt found. Please install libfdt-dev package)
-	else
-		CFLAGS_DYNOPT	+= -DCONFIG_HAS_LIBFDT
-		CFLAGS_STATOPT	+= -DCONFIG_HAS_LIBFDT
-		LIBS_DYNOPT	+= -lfdt
-		LIBS_STATOPT	+= -lfdt
-	endif
+	CFLAGS		+= -I libfdt
+	CFLAGS_DYNOPT	+= -DCONFIG_HAS_LIBFDT
+	CFLAGS_STATOPT	+= -DCONFIG_HAS_LIBFDT
+
+	LIBFDT_STATICOBJS = $(LIBFDT_archive)
+	LIBFDT_CLEAN 	= libfdt_clean
 endif
 
 ifeq ($(call try-build,$(SOURCE_HELLO),$(CFLAGS),-no-pie),y)
@@ -413,6 +415,8 @@ endif
 
 all: $(PROGRAM) $(PROGRAM_ALIAS)
 
+include libfdt/Makefile.libfdt
+
 # CFLAGS used when building objects
 # This is intentionally not assigned using :=
 c_flags	= -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CFLAGS)
@@ -428,18 +432,22 @@ STATIC_OBJS = $(patsubst %.o,%.static.o,$(OBJS) $(OBJS_STATOPT))
 STATIC_DEPS	:= $(foreach obj,$(STATIC_OBJS),\
 		$(subst $(comma),_,$(dir $(obj)).$(notdir $(obj)).d))
 
-$(PROGRAM)-static:  $(STATIC_OBJS) $(OTHEROBJS) $(GUEST_OBJS)
+$(PROGRAM)-static:  $(STATIC_OBJS) $(OTHEROBJS) $(GUEST_OBJS) $(LIBFDT_STATICOBJS)
 	$(E) "  LINK    " $@
-	$(Q) $(CC) -static $(CFLAGS) $(STATIC_OBJS) $(OTHEROBJS) $(GUEST_OBJS) $(LDFLAGS) $(LIBS) $(LIBS_STATOPT) -o $@
+	$(Q) $(CC) -static $(CFLAGS) $(STATIC_OBJS) $(OTHEROBJS) $(GUEST_OBJS) $(LDFLAGS) $(LIBS) $(LIBS_STATOPT) $(LIBFDT_STATICOBJS) -o $@
 
-$(PROGRAM): $(OBJS) $(OBJS_DYNOPT) $(OTHEROBJS) $(GUEST_OBJS)
+$(PROGRAM): $(OBJS) $(OBJS_DYNOPT) $(OTHEROBJS) $(GUEST_OBJS) $(LIBFDT_STATICOBJS)
 	$(E) "  LINK    " $@
-	$(Q) $(CC) $(CFLAGS) $(OBJS) $(OBJS_DYNOPT) $(OTHEROBJS) $(GUEST_OBJS) $(LDFLAGS) $(LIBS) $(LIBS_DYNOPT) -o $@
+	$(Q) $(CC) $(CFLAGS) $(OBJS) $(OBJS_DYNOPT) $(OTHEROBJS) $(GUEST_OBJS) $(LDFLAGS) $(LIBS) $(LIBS_DYNOPT) $(LIBFDT_STATICOBJS) -o $@
 
 $(PROGRAM_ALIAS): $(PROGRAM)
 	$(E) "  LN      " $@
 	$(Q) ln -f $(PROGRAM) $@
 
+$(LIBFDT_archive): $(addprefix $(LIBFDT_dir)/,$(LIBFDT_OBJS))
+	@$(E) "  AR      " $@
+	$(Q) $(AR) $(ARFLAGS) $@ $^
+
 ifneq ($(ARCH_PRE_INIT),)
 $(GUEST_PRE_INIT): $(ARCH_PRE_INIT)
 	$(E) "  COMPILE " $@
@@ -487,7 +495,6 @@ endif
 	$(E) "  CC      " $@
 	$(Q) $(CC) -c $(c_flags) $(CFLAGS_DYNOPT) $< -o $@
 
-
 #
 # BIOS assembly weirdness
 #
@@ -538,7 +545,7 @@ install: all
 	$(Q) $(INSTALL) $(PROGRAM) '$(DESTDIR_SQ)$(bindir_SQ)' 
 .PHONY: install
 
-clean:
+clean: $(LIBFDT_CLEAN)
 	$(E) "  CLEAN"
 	$(Q) rm -f x86/bios/*.bin
 	$(Q) rm -f x86/bios/*.elf
@@ -554,6 +561,10 @@ clean:
 	$(Q) rm -f KVMTOOLS-VERSION-FILE
 .PHONY: clean
 
+libfdt_clean: VECHO = $(E) " "
+libfdt_clean: STD_CLEANFILES = *.o libfdt.a
+libfdt_clean: SHAREDLIB_EXT = so
+
 KVM_DEV	?= /dev/kvm
 
 $(KVM_DEV):
diff --git a/libfdt/.gitignore b/libfdt/.gitignore
new file mode 100644
index 000000000000..fed46037038d
--- /dev/null
+++ b/libfdt/.gitignore
@@ -0,0 +1 @@
+libfdt.so.1
diff --git a/libfdt/Makefile.libfdt b/libfdt/Makefile.libfdt
new file mode 100644
index 000000000000..b6d8fc02dd0b
--- /dev/null
+++ b/libfdt/Makefile.libfdt
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+# Makefile.libfdt
+#
+# This is not a complete Makefile of itself.  Instead, it is designed to
+# be easily embeddable into other systems of Makefiles.
+#
+LIBFDT_soname = libfdt.$(SHAREDLIB_EXT).1
+LIBFDT_INCLUDES = fdt.h libfdt.h libfdt_env.h
+LIBFDT_VERSION = version.lds
+LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c fdt_empty_tree.c \
+	fdt_addresses.c fdt_overlay.c fdt_check.c
+LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
+LIBFDT_LIB = libfdt-$(DTC_VERSION).$(SHAREDLIB_EXT)
+
+libfdt_clean:
+	@$(VECHO) CLEAN "(libfdt)"
+	rm -f $(STD_CLEANFILES:%=$(LIBFDT_dir)/%)
+	rm -f $(LIBFDT_dir)/$(LIBFDT_soname)
diff --git a/libfdt/TODO b/libfdt/TODO
new file mode 100644
index 000000000000..288437e394fc
--- /dev/null
+++ b/libfdt/TODO
@@ -0,0 +1,3 @@
+- Tree traversal functions
+- Graft function
+- Complete libfdt.h documenting comments
diff --git a/libfdt/fdt.c b/libfdt/fdt.c
new file mode 100644
index 000000000000..9fe7cf4b747d
--- /dev/null
+++ b/libfdt/fdt.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+/*
+ * Minimal sanity check for a read-only tree. fdt_ro_probe_() checks
+ * that the given buffer contains what appears to be a flattened
+ * device tree with sane information in its header.
+ */
+int32_t fdt_ro_probe_(const void *fdt)
+{
+	uint32_t totalsize = fdt_totalsize(fdt);
+
+	if (can_assume(VALID_DTB))
+		return totalsize;
+
+	/* The device tree must be at an 8-byte aligned address */
+	if ((uintptr_t)fdt & 7)
+		return -FDT_ERR_ALIGNMENT;
+
+	if (fdt_magic(fdt) == FDT_MAGIC) {
+		/* Complete tree */
+		if (!can_assume(LATEST)) {
+			if (fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
+				return -FDT_ERR_BADVERSION;
+			if (fdt_last_comp_version(fdt) >
+					FDT_LAST_SUPPORTED_VERSION)
+				return -FDT_ERR_BADVERSION;
+		}
+	} else if (fdt_magic(fdt) == FDT_SW_MAGIC) {
+		/* Unfinished sequential-write blob */
+		if (!can_assume(VALID_INPUT) && fdt_size_dt_struct(fdt) == 0)
+			return -FDT_ERR_BADSTATE;
+	} else {
+		return -FDT_ERR_BADMAGIC;
+	}
+
+	if (totalsize < INT32_MAX)
+		return totalsize;
+	else
+		return -FDT_ERR_TRUNCATED;
+}
+
+static int check_off_(uint32_t hdrsize, uint32_t totalsize, uint32_t off)
+{
+	return (off >= hdrsize) && (off <= totalsize);
+}
+
+static int check_block_(uint32_t hdrsize, uint32_t totalsize,
+			uint32_t base, uint32_t size)
+{
+	if (!check_off_(hdrsize, totalsize, base))
+		return 0; /* block start out of bounds */
+	if ((base + size) < base)
+		return 0; /* overflow */
+	if (!check_off_(hdrsize, totalsize, base + size))
+		return 0; /* block end out of bounds */
+	return 1;
+}
+
+size_t fdt_header_size_(uint32_t version)
+{
+	if (version <= 1)
+		return FDT_V1_SIZE;
+	else if (version <= 2)
+		return FDT_V2_SIZE;
+	else if (version <= 3)
+		return FDT_V3_SIZE;
+	else if (version <= 16)
+		return FDT_V16_SIZE;
+	else
+		return FDT_V17_SIZE;
+}
+
+size_t fdt_header_size(const void *fdt)
+{
+	return can_assume(LATEST) ? FDT_V17_SIZE :
+		fdt_header_size_(fdt_version(fdt));
+}
+
+int fdt_check_header(const void *fdt)
+{
+	size_t hdrsize;
+
+	/* The device tree must be at an 8-byte aligned address */
+	if ((uintptr_t)fdt & 7)
+		return -FDT_ERR_ALIGNMENT;
+
+	if (fdt_magic(fdt) != FDT_MAGIC)
+		return -FDT_ERR_BADMAGIC;
+	if (!can_assume(LATEST)) {
+		if ((fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
+		    || (fdt_last_comp_version(fdt) >
+			FDT_LAST_SUPPORTED_VERSION))
+			return -FDT_ERR_BADVERSION;
+		if (fdt_version(fdt) < fdt_last_comp_version(fdt))
+			return -FDT_ERR_BADVERSION;
+	}
+	hdrsize = fdt_header_size(fdt);
+	if (!can_assume(VALID_DTB)) {
+
+		if ((fdt_totalsize(fdt) < hdrsize)
+		    || (fdt_totalsize(fdt) > INT_MAX))
+			return -FDT_ERR_TRUNCATED;
+
+		/* Bounds check memrsv block */
+		if (!check_off_(hdrsize, fdt_totalsize(fdt),
+				fdt_off_mem_rsvmap(fdt)))
+			return -FDT_ERR_TRUNCATED;
+	}
+
+	if (!can_assume(VALID_DTB)) {
+		/* Bounds check structure block */
+		if (!can_assume(LATEST) && fdt_version(fdt) < 17) {
+			if (!check_off_(hdrsize, fdt_totalsize(fdt),
+					fdt_off_dt_struct(fdt)))
+				return -FDT_ERR_TRUNCATED;
+		} else {
+			if (!check_block_(hdrsize, fdt_totalsize(fdt),
+					  fdt_off_dt_struct(fdt),
+					  fdt_size_dt_struct(fdt)))
+				return -FDT_ERR_TRUNCATED;
+		}
+
+		/* Bounds check strings block */
+		if (!check_block_(hdrsize, fdt_totalsize(fdt),
+				  fdt_off_dt_strings(fdt),
+				  fdt_size_dt_strings(fdt)))
+			return -FDT_ERR_TRUNCATED;
+	}
+
+	return 0;
+}
+
+const void *fdt_offset_ptr(const void *fdt, int offset, unsigned int len)
+{
+	unsigned int uoffset = offset;
+	unsigned int absoffset = offset + fdt_off_dt_struct(fdt);
+
+	if (offset < 0)
+		return NULL;
+
+	if (!can_assume(VALID_INPUT))
+		if ((absoffset < uoffset)
+		    || ((absoffset + len) < absoffset)
+		    || (absoffset + len) > fdt_totalsize(fdt))
+			return NULL;
+
+	if (can_assume(LATEST) || fdt_version(fdt) >= 0x11)
+		if (((uoffset + len) < uoffset)
+		    || ((offset + len) > fdt_size_dt_struct(fdt)))
+			return NULL;
+
+	return fdt_offset_ptr_(fdt, offset);
+}
+
+uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
+{
+	const fdt32_t *tagp, *lenp;
+	uint32_t tag;
+	int offset = startoffset;
+	const char *p;
+
+	*nextoffset = -FDT_ERR_TRUNCATED;
+	tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
+	if (!can_assume(VALID_DTB) && !tagp)
+		return FDT_END; /* premature end */
+	tag = fdt32_to_cpu(*tagp);
+	offset += FDT_TAGSIZE;
+
+	*nextoffset = -FDT_ERR_BADSTRUCTURE;
+	switch (tag) {
+	case FDT_BEGIN_NODE:
+		/* skip name */
+		do {
+			p = fdt_offset_ptr(fdt, offset++, 1);
+		} while (p && (*p != '\0'));
+		if (!can_assume(VALID_DTB) && !p)
+			return FDT_END; /* premature end */
+		break;
+
+	case FDT_PROP:
+		lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
+		if (!can_assume(VALID_DTB) && !lenp)
+			return FDT_END; /* premature end */
+		/* skip-name offset, length and value */
+		offset += sizeof(struct fdt_property) - FDT_TAGSIZE
+			+ fdt32_to_cpu(*lenp);
+		if (!can_assume(LATEST) &&
+		    fdt_version(fdt) < 0x10 && fdt32_to_cpu(*lenp) >= 8 &&
+		    ((offset - fdt32_to_cpu(*lenp)) % 8) != 0)
+			offset += 4;
+		break;
+
+	case FDT_END:
+	case FDT_END_NODE:
+	case FDT_NOP:
+		break;
+
+	default:
+		return FDT_END;
+	}
+
+	if (!fdt_offset_ptr(fdt, startoffset, offset - startoffset))
+		return FDT_END; /* premature end */
+
+	*nextoffset = FDT_TAGALIGN(offset);
+	return tag;
+}
+
+int fdt_check_node_offset_(const void *fdt, int offset)
+{
+	if (!can_assume(VALID_INPUT)
+	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
+		return -FDT_ERR_BADOFFSET;
+
+	if (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE)
+		return -FDT_ERR_BADOFFSET;
+
+	return offset;
+}
+
+int fdt_check_prop_offset_(const void *fdt, int offset)
+{
+	if (!can_assume(VALID_INPUT)
+	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
+		return -FDT_ERR_BADOFFSET;
+
+	if (fdt_next_tag(fdt, offset, &offset) != FDT_PROP)
+		return -FDT_ERR_BADOFFSET;
+
+	return offset;
+}
+
+int fdt_next_node(const void *fdt, int offset, int *depth)
+{
+	int nextoffset = 0;
+	uint32_t tag;
+
+	if (offset >= 0)
+		if ((nextoffset = fdt_check_node_offset_(fdt, offset)) < 0)
+			return nextoffset;
+
+	do {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+
+		switch (tag) {
+		case FDT_PROP:
+		case FDT_NOP:
+			break;
+
+		case FDT_BEGIN_NODE:
+			if (depth)
+				(*depth)++;
+			break;
+
+		case FDT_END_NODE:
+			if (depth && ((--(*depth)) < 0))
+				return nextoffset;
+			break;
+
+		case FDT_END:
+			if ((nextoffset >= 0)
+			    || ((nextoffset == -FDT_ERR_TRUNCATED) && !depth))
+				return -FDT_ERR_NOTFOUND;
+			else
+				return nextoffset;
+		}
+	} while (tag != FDT_BEGIN_NODE);
+
+	return offset;
+}
+
+int fdt_first_subnode(const void *fdt, int offset)
+{
+	int depth = 0;
+
+	offset = fdt_next_node(fdt, offset, &depth);
+	if (offset < 0 || depth != 1)
+		return -FDT_ERR_NOTFOUND;
+
+	return offset;
+}
+
+int fdt_next_subnode(const void *fdt, int offset)
+{
+	int depth = 1;
+
+	/*
+	 * With respect to the parent, the depth of the next subnode will be
+	 * the same as the last.
+	 */
+	do {
+		offset = fdt_next_node(fdt, offset, &depth);
+		if (offset < 0 || depth < 1)
+			return -FDT_ERR_NOTFOUND;
+	} while (depth > 1);
+
+	return offset;
+}
+
+const char *fdt_find_string_(const char *strtab, int tabsize, const char *s)
+{
+	int len = strlen(s) + 1;
+	const char *last = strtab + tabsize - len;
+	const char *p;
+
+	for (p = strtab; p <= last; p++)
+		if (memcmp(p, s, len) == 0)
+			return p;
+	return NULL;
+}
+
+int fdt_move(const void *fdt, void *buf, int bufsize)
+{
+	if (!can_assume(VALID_INPUT) && bufsize < 0)
+		return -FDT_ERR_NOSPACE;
+
+	FDT_RO_PROBE(fdt);
+
+	if (fdt_totalsize(fdt) > (unsigned int)bufsize)
+		return -FDT_ERR_NOSPACE;
+
+	memmove(buf, fdt, fdt_totalsize(fdt));
+	return 0;
+}
diff --git a/libfdt/fdt.h b/libfdt/fdt.h
new file mode 100644
index 000000000000..f2e68807f277
--- /dev/null
+++ b/libfdt/fdt.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+#ifndef FDT_H
+#define FDT_H
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ * Copyright 2012 Kim Phillips, Freescale Semiconductor.
+ */
+
+#ifndef __ASSEMBLY__
+
+struct fdt_header {
+	fdt32_t magic;			 /* magic word FDT_MAGIC */
+	fdt32_t totalsize;		 /* total size of DT block */
+	fdt32_t off_dt_struct;		 /* offset to structure */
+	fdt32_t off_dt_strings;		 /* offset to strings */
+	fdt32_t off_mem_rsvmap;		 /* offset to memory reserve map */
+	fdt32_t version;		 /* format version */
+	fdt32_t last_comp_version;	 /* last compatible version */
+
+	/* version 2 fields below */
+	fdt32_t boot_cpuid_phys;	 /* Which physical CPU id we're
+					    booting on */
+	/* version 3 fields below */
+	fdt32_t size_dt_strings;	 /* size of the strings block */
+
+	/* version 17 fields below */
+	fdt32_t size_dt_struct;		 /* size of the structure block */
+};
+
+struct fdt_reserve_entry {
+	fdt64_t address;
+	fdt64_t size;
+};
+
+struct fdt_node_header {
+	fdt32_t tag;
+	char name[0];
+};
+
+struct fdt_property {
+	fdt32_t tag;
+	fdt32_t len;
+	fdt32_t nameoff;
+	char data[0];
+};
+
+#endif /* !__ASSEMBLY */
+
+#define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
+#define FDT_TAGSIZE	sizeof(fdt32_t)
+
+#define FDT_BEGIN_NODE	0x1		/* Start node: full name */
+#define FDT_END_NODE	0x2		/* End node */
+#define FDT_PROP	0x3		/* Property: name off,
+					   size, content */
+#define FDT_NOP		0x4		/* nop */
+#define FDT_END		0x9
+
+#define FDT_V1_SIZE	(7*sizeof(fdt32_t))
+#define FDT_V2_SIZE	(FDT_V1_SIZE + sizeof(fdt32_t))
+#define FDT_V3_SIZE	(FDT_V2_SIZE + sizeof(fdt32_t))
+#define FDT_V16_SIZE	FDT_V3_SIZE
+#define FDT_V17_SIZE	(FDT_V16_SIZE + sizeof(fdt32_t))
+
+#endif /* FDT_H */
diff --git a/libfdt/fdt_addresses.c b/libfdt/fdt_addresses.c
new file mode 100644
index 000000000000..c40ba094f1f8
--- /dev/null
+++ b/libfdt/fdt_addresses.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2014 David Gibson <david@gibson.dropbear.id.au>
+ * Copyright (C) 2018 embedded brains GmbH
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+static int fdt_cells(const void *fdt, int nodeoffset, const char *name)
+{
+	const fdt32_t *c;
+	uint32_t val;
+	int len;
+
+	c = fdt_getprop(fdt, nodeoffset, name, &len);
+	if (!c)
+		return len;
+
+	if (len != sizeof(*c))
+		return -FDT_ERR_BADNCELLS;
+
+	val = fdt32_to_cpu(*c);
+	if (val > FDT_MAX_NCELLS)
+		return -FDT_ERR_BADNCELLS;
+
+	return (int)val;
+}
+
+int fdt_address_cells(const void *fdt, int nodeoffset)
+{
+	int val;
+
+	val = fdt_cells(fdt, nodeoffset, "#address-cells");
+	if (val == 0)
+		return -FDT_ERR_BADNCELLS;
+	if (val == -FDT_ERR_NOTFOUND)
+		return 2;
+	return val;
+}
+
+int fdt_size_cells(const void *fdt, int nodeoffset)
+{
+	int val;
+
+	val = fdt_cells(fdt, nodeoffset, "#size-cells");
+	if (val == -FDT_ERR_NOTFOUND)
+		return 1;
+	return val;
+}
+
+/* This function assumes that [address|size]_cells is 1 or 2 */
+int fdt_appendprop_addrrange(void *fdt, int parent, int nodeoffset,
+			     const char *name, uint64_t addr, uint64_t size)
+{
+	int addr_cells, size_cells, ret;
+	uint8_t data[sizeof(fdt64_t) * 2], *prop;
+
+	ret = fdt_address_cells(fdt, parent);
+	if (ret < 0)
+		return ret;
+	addr_cells = ret;
+
+	ret = fdt_size_cells(fdt, parent);
+	if (ret < 0)
+		return ret;
+	size_cells = ret;
+
+	/* check validity of address */
+	prop = data;
+	if (addr_cells == 1) {
+		if ((addr > UINT32_MAX) || (((uint64_t) UINT32_MAX + 1 - addr) < size))
+			return -FDT_ERR_BADVALUE;
+
+		fdt32_st(prop, (uint32_t)addr);
+	} else if (addr_cells == 2) {
+		fdt64_st(prop, addr);
+	} else {
+		return -FDT_ERR_BADNCELLS;
+	}
+
+	/* check validity of size */
+	prop += addr_cells * sizeof(fdt32_t);
+	if (size_cells == 1) {
+		if (size > UINT32_MAX)
+			return -FDT_ERR_BADVALUE;
+
+		fdt32_st(prop, (uint32_t)size);
+	} else if (size_cells == 2) {
+		fdt64_st(prop, size);
+	} else {
+		return -FDT_ERR_BADNCELLS;
+	}
+
+	return fdt_appendprop(fdt, nodeoffset, name, data,
+			      (addr_cells + size_cells) * sizeof(fdt32_t));
+}
diff --git a/libfdt/fdt_check.c b/libfdt/fdt_check.c
new file mode 100644
index 000000000000..fa410a86e282
--- /dev/null
+++ b/libfdt/fdt_check.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+int fdt_check_full(const void *fdt, size_t bufsize)
+{
+	int err;
+	int num_memrsv;
+	int offset, nextoffset = 0;
+	uint32_t tag;
+	unsigned int depth = 0;
+	const void *prop;
+	const char *propname;
+	bool expect_end = false;
+
+	if (bufsize < FDT_V1_SIZE)
+		return -FDT_ERR_TRUNCATED;
+	if (bufsize < fdt_header_size(fdt))
+		return -FDT_ERR_TRUNCATED;
+	err = fdt_check_header(fdt);
+	if (err != 0)
+		return err;
+	if (bufsize < fdt_totalsize(fdt))
+		return -FDT_ERR_TRUNCATED;
+
+	num_memrsv = fdt_num_mem_rsv(fdt);
+	if (num_memrsv < 0)
+		return num_memrsv;
+
+	while (1) {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+
+		if (nextoffset < 0)
+			return nextoffset;
+
+		/* If we see two root nodes, something is wrong */
+		if (expect_end && tag != FDT_END)
+			return -FDT_ERR_BADSTRUCTURE;
+
+		switch (tag) {
+		case FDT_NOP:
+			break;
+
+		case FDT_END:
+			if (depth != 0)
+				return -FDT_ERR_BADSTRUCTURE;
+			return 0;
+
+		case FDT_BEGIN_NODE:
+			depth++;
+			if (depth > INT_MAX)
+				return -FDT_ERR_BADSTRUCTURE;
+
+			/* The root node must have an empty name */
+			if (depth == 1) {
+				const char *name;
+				int len;
+
+				name = fdt_get_name(fdt, offset, &len);
+				if (*name || len)
+					return -FDT_ERR_BADSTRUCTURE;
+			}
+			break;
+
+		case FDT_END_NODE:
+			if (depth == 0)
+				return -FDT_ERR_BADSTRUCTURE;
+			depth--;
+			if (depth == 0)
+				expect_end = true;
+			break;
+
+		case FDT_PROP:
+			prop = fdt_getprop_by_offset(fdt, offset, &propname,
+						     &err);
+			if (!prop)
+				return err;
+			break;
+
+		default:
+			return -FDT_ERR_INTERNAL;
+		}
+	}
+}
diff --git a/libfdt/fdt_empty_tree.c b/libfdt/fdt_empty_tree.c
new file mode 100644
index 000000000000..49d54d44b8e7
--- /dev/null
+++ b/libfdt/fdt_empty_tree.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2012 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+int fdt_create_empty_tree(void *buf, int bufsize)
+{
+	int err;
+
+	err = fdt_create(buf, bufsize);
+	if (err)
+		return err;
+
+	err = fdt_finish_reservemap(buf);
+	if (err)
+		return err;
+
+	err = fdt_begin_node(buf, "");
+	if (err)
+		return err;
+
+	err =  fdt_end_node(buf);
+	if (err)
+		return err;
+
+	err = fdt_finish(buf);
+	if (err)
+		return err;
+
+	return fdt_open_into(buf, buf, bufsize);
+}
diff --git a/libfdt/fdt_overlay.c b/libfdt/fdt_overlay.c
new file mode 100644
index 000000000000..5c0c3981b89d
--- /dev/null
+++ b/libfdt/fdt_overlay.c
@@ -0,0 +1,867 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2016 Free Electrons
+ * Copyright (C) 2016 NextThing Co.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+/**
+ * overlay_get_target_phandle - retrieves the target phandle of a fragment
+ * @fdto: pointer to the device tree overlay blob
+ * @fragment: node offset of the fragment in the overlay
+ *
+ * overlay_get_target_phandle() retrieves the target phandle of an
+ * overlay fragment when that fragment uses a phandle (target
+ * property) instead of a path (target-path property).
+ *
+ * returns:
+ *      the phandle pointed by the target property
+ *      0, if the phandle was not found
+ *	-1, if the phandle was malformed
+ */
+static uint32_t overlay_get_target_phandle(const void *fdto, int fragment)
+{
+	const fdt32_t *val;
+	int len;
+
+	val = fdt_getprop(fdto, fragment, "target", &len);
+	if (!val)
+		return 0;
+
+	if ((len != sizeof(*val)) || (fdt32_to_cpu(*val) == (uint32_t)-1))
+		return (uint32_t)-1;
+
+	return fdt32_to_cpu(*val);
+}
+
+int fdt_overlay_target_offset(const void *fdt, const void *fdto,
+			      int fragment_offset, char const **pathp)
+{
+	uint32_t phandle;
+	const char *path = NULL;
+	int path_len = 0, ret;
+
+	/* Try first to do a phandle based lookup */
+	phandle = overlay_get_target_phandle(fdto, fragment_offset);
+	if (phandle == (uint32_t)-1)
+		return -FDT_ERR_BADPHANDLE;
+
+	/* no phandle, try path */
+	if (!phandle) {
+		/* And then a path based lookup */
+		path = fdt_getprop(fdto, fragment_offset, "target-path", &path_len);
+		if (path)
+			ret = fdt_path_offset(fdt, path);
+		else
+			ret = path_len;
+	} else
+		ret = fdt_node_offset_by_phandle(fdt, phandle);
+
+	/*
+	* If we haven't found either a target or a
+	* target-path property in a node that contains a
+	* __overlay__ subnode (we wouldn't be called
+	* otherwise), consider it a improperly written
+	* overlay
+	*/
+	if (ret < 0 && path_len == -FDT_ERR_NOTFOUND)
+		ret = -FDT_ERR_BADOVERLAY;
+
+	/* return on error */
+	if (ret < 0)
+		return ret;
+
+	/* return pointer to path (if available) */
+	if (pathp)
+		*pathp = path ? path : NULL;
+
+	return ret;
+}
+
+/**
+ * overlay_phandle_add_offset - Increases a phandle by an offset
+ * @fdt: Base device tree blob
+ * @node: Device tree overlay blob
+ * @name: Name of the property to modify (phandle or linux,phandle)
+ * @delta: offset to apply
+ *
+ * overlay_phandle_add_offset() increments a node phandle by a given
+ * offset.
+ *
+ * returns:
+ *      0 on success.
+ *      Negative error code on error
+ */
+static int overlay_phandle_add_offset(void *fdt, int node,
+				      const char *name, uint32_t delta)
+{
+	const fdt32_t *val;
+	uint32_t adj_val;
+	int len;
+
+	val = fdt_getprop(fdt, node, name, &len);
+	if (!val)
+		return len;
+
+	if (len != sizeof(*val))
+		return -FDT_ERR_BADPHANDLE;
+
+	adj_val = fdt32_to_cpu(*val);
+	if ((adj_val + delta) < adj_val)
+		return -FDT_ERR_NOPHANDLES;
+
+	adj_val += delta;
+	if (adj_val == (uint32_t)-1)
+		return -FDT_ERR_NOPHANDLES;
+
+	return fdt_setprop_inplace_u32(fdt, node, name, adj_val);
+}
+
+/**
+ * overlay_adjust_node_phandles - Offsets the phandles of a node
+ * @fdto: Device tree overlay blob
+ * @node: Offset of the node we want to adjust
+ * @delta: Offset to shift the phandles of
+ *
+ * overlay_adjust_node_phandles() adds a constant to all the phandles
+ * of a given node. This is mainly use as part of the overlay
+ * application process, when we want to update all the overlay
+ * phandles to not conflict with the overlays of the base device tree.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_adjust_node_phandles(void *fdto, int node,
+					uint32_t delta)
+{
+	int child;
+	int ret;
+
+	ret = overlay_phandle_add_offset(fdto, node, "phandle", delta);
+	if (ret && ret != -FDT_ERR_NOTFOUND)
+		return ret;
+
+	ret = overlay_phandle_add_offset(fdto, node, "linux,phandle", delta);
+	if (ret && ret != -FDT_ERR_NOTFOUND)
+		return ret;
+
+	fdt_for_each_subnode(child, fdto, node) {
+		ret = overlay_adjust_node_phandles(fdto, child, delta);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * overlay_adjust_local_phandles - Adjust the phandles of a whole overlay
+ * @fdto: Device tree overlay blob
+ * @delta: Offset to shift the phandles of
+ *
+ * overlay_adjust_local_phandles() adds a constant to all the
+ * phandles of an overlay. This is mainly use as part of the overlay
+ * application process, when we want to update all the overlay
+ * phandles to not conflict with the overlays of the base device tree.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_adjust_local_phandles(void *fdto, uint32_t delta)
+{
+	/*
+	 * Start adjusting the phandles from the overlay root
+	 */
+	return overlay_adjust_node_phandles(fdto, 0, delta);
+}
+
+/**
+ * overlay_update_local_node_references - Adjust the overlay references
+ * @fdto: Device tree overlay blob
+ * @tree_node: Node offset of the node to operate on
+ * @fixup_node: Node offset of the matching local fixups node
+ * @delta: Offset to shift the phandles of
+ *
+ * overlay_update_local_nodes_references() update the phandles
+ * pointing to a node within the device tree overlay by adding a
+ * constant delta.
+ *
+ * This is mainly used as part of a device tree application process,
+ * where you want the device tree overlays phandles to not conflict
+ * with the ones from the base device tree before merging them.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_update_local_node_references(void *fdto,
+						int tree_node,
+						int fixup_node,
+						uint32_t delta)
+{
+	int fixup_prop;
+	int fixup_child;
+	int ret;
+
+	fdt_for_each_property_offset(fixup_prop, fdto, fixup_node) {
+		const fdt32_t *fixup_val;
+		const char *tree_val;
+		const char *name;
+		int fixup_len;
+		int tree_len;
+		int i;
+
+		fixup_val = fdt_getprop_by_offset(fdto, fixup_prop,
+						  &name, &fixup_len);
+		if (!fixup_val)
+			return fixup_len;
+
+		if (fixup_len % sizeof(uint32_t))
+			return -FDT_ERR_BADOVERLAY;
+		fixup_len /= sizeof(uint32_t);
+
+		tree_val = fdt_getprop(fdto, tree_node, name, &tree_len);
+		if (!tree_val) {
+			if (tree_len == -FDT_ERR_NOTFOUND)
+				return -FDT_ERR_BADOVERLAY;
+
+			return tree_len;
+		}
+
+		for (i = 0; i < fixup_len; i++) {
+			fdt32_t adj_val;
+			uint32_t poffset;
+
+			poffset = fdt32_to_cpu(fixup_val[i]);
+
+			/*
+			 * phandles to fixup can be unaligned.
+			 *
+			 * Use a memcpy for the architectures that do
+			 * not support unaligned accesses.
+			 */
+			memcpy(&adj_val, tree_val + poffset, sizeof(adj_val));
+
+			adj_val = cpu_to_fdt32(fdt32_to_cpu(adj_val) + delta);
+
+			ret = fdt_setprop_inplace_namelen_partial(fdto,
+								  tree_node,
+								  name,
+								  strlen(name),
+								  poffset,
+								  &adj_val,
+								  sizeof(adj_val));
+			if (ret == -FDT_ERR_NOSPACE)
+				return -FDT_ERR_BADOVERLAY;
+
+			if (ret)
+				return ret;
+		}
+	}
+
+	fdt_for_each_subnode(fixup_child, fdto, fixup_node) {
+		const char *fixup_child_name = fdt_get_name(fdto, fixup_child,
+							    NULL);
+		int tree_child;
+
+		tree_child = fdt_subnode_offset(fdto, tree_node,
+						fixup_child_name);
+		if (tree_child == -FDT_ERR_NOTFOUND)
+			return -FDT_ERR_BADOVERLAY;
+		if (tree_child < 0)
+			return tree_child;
+
+		ret = overlay_update_local_node_references(fdto,
+							   tree_child,
+							   fixup_child,
+							   delta);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * overlay_update_local_references - Adjust the overlay references
+ * @fdto: Device tree overlay blob
+ * @delta: Offset to shift the phandles of
+ *
+ * overlay_update_local_references() update all the phandles pointing
+ * to a node within the device tree overlay by adding a constant
+ * delta to not conflict with the base overlay.
+ *
+ * This is mainly used as part of a device tree application process,
+ * where you want the device tree overlays phandles to not conflict
+ * with the ones from the base device tree before merging them.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_update_local_references(void *fdto, uint32_t delta)
+{
+	int fixups;
+
+	fixups = fdt_path_offset(fdto, "/__local_fixups__");
+	if (fixups < 0) {
+		/* There's no local phandles to adjust, bail out */
+		if (fixups == -FDT_ERR_NOTFOUND)
+			return 0;
+
+		return fixups;
+	}
+
+	/*
+	 * Update our local references from the root of the tree
+	 */
+	return overlay_update_local_node_references(fdto, 0, fixups,
+						    delta);
+}
+
+/**
+ * overlay_fixup_one_phandle - Set an overlay phandle to the base one
+ * @fdt: Base Device Tree blob
+ * @fdto: Device tree overlay blob
+ * @symbols_off: Node offset of the symbols node in the base device tree
+ * @path: Path to a node holding a phandle in the overlay
+ * @path_len: number of path characters to consider
+ * @name: Name of the property holding the phandle reference in the overlay
+ * @name_len: number of name characters to consider
+ * @poffset: Offset within the overlay property where the phandle is stored
+ * @label: Label of the node referenced by the phandle
+ *
+ * overlay_fixup_one_phandle() resolves an overlay phandle pointing to
+ * a node in the base device tree.
+ *
+ * This is part of the device tree overlay application process, when
+ * you want all the phandles in the overlay to point to the actual
+ * base dt nodes.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_fixup_one_phandle(void *fdt, void *fdto,
+				     int symbols_off,
+				     const char *path, uint32_t path_len,
+				     const char *name, uint32_t name_len,
+				     int poffset, const char *label)
+{
+	const char *symbol_path;
+	uint32_t phandle;
+	fdt32_t phandle_prop;
+	int symbol_off, fixup_off;
+	int prop_len;
+
+	if (symbols_off < 0)
+		return symbols_off;
+
+	symbol_path = fdt_getprop(fdt, symbols_off, label,
+				  &prop_len);
+	if (!symbol_path)
+		return prop_len;
+
+	symbol_off = fdt_path_offset(fdt, symbol_path);
+	if (symbol_off < 0)
+		return symbol_off;
+
+	phandle = fdt_get_phandle(fdt, symbol_off);
+	if (!phandle)
+		return -FDT_ERR_NOTFOUND;
+
+	fixup_off = fdt_path_offset_namelen(fdto, path, path_len);
+	if (fixup_off == -FDT_ERR_NOTFOUND)
+		return -FDT_ERR_BADOVERLAY;
+	if (fixup_off < 0)
+		return fixup_off;
+
+	phandle_prop = cpu_to_fdt32(phandle);
+	return fdt_setprop_inplace_namelen_partial(fdto, fixup_off,
+						   name, name_len, poffset,
+						   &phandle_prop,
+						   sizeof(phandle_prop));
+};
+
+/**
+ * overlay_fixup_phandle - Set an overlay phandle to the base one
+ * @fdt: Base Device Tree blob
+ * @fdto: Device tree overlay blob
+ * @symbols_off: Node offset of the symbols node in the base device tree
+ * @property: Property offset in the overlay holding the list of fixups
+ *
+ * overlay_fixup_phandle() resolves all the overlay phandles pointed
+ * to in a __fixups__ property, and updates them to match the phandles
+ * in use in the base device tree.
+ *
+ * This is part of the device tree overlay application process, when
+ * you want all the phandles in the overlay to point to the actual
+ * base dt nodes.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_fixup_phandle(void *fdt, void *fdto, int symbols_off,
+				 int property)
+{
+	const char *value;
+	const char *label;
+	int len;
+
+	value = fdt_getprop_by_offset(fdto, property,
+				      &label, &len);
+	if (!value) {
+		if (len == -FDT_ERR_NOTFOUND)
+			return -FDT_ERR_INTERNAL;
+
+		return len;
+	}
+
+	do {
+		const char *path, *name, *fixup_end;
+		const char *fixup_str = value;
+		uint32_t path_len, name_len;
+		uint32_t fixup_len;
+		char *sep, *endptr;
+		int poffset, ret;
+
+		fixup_end = memchr(value, '\0', len);
+		if (!fixup_end)
+			return -FDT_ERR_BADOVERLAY;
+		fixup_len = fixup_end - fixup_str;
+
+		len -= fixup_len + 1;
+		value += fixup_len + 1;
+
+		path = fixup_str;
+		sep = memchr(fixup_str, ':', fixup_len);
+		if (!sep || *sep != ':')
+			return -FDT_ERR_BADOVERLAY;
+
+		path_len = sep - path;
+		if (path_len == (fixup_len - 1))
+			return -FDT_ERR_BADOVERLAY;
+
+		fixup_len -= path_len + 1;
+		name = sep + 1;
+		sep = memchr(name, ':', fixup_len);
+		if (!sep || *sep != ':')
+			return -FDT_ERR_BADOVERLAY;
+
+		name_len = sep - name;
+		if (!name_len)
+			return -FDT_ERR_BADOVERLAY;
+
+		poffset = strtoul(sep + 1, &endptr, 10);
+		if ((*endptr != '\0') || (endptr <= (sep + 1)))
+			return -FDT_ERR_BADOVERLAY;
+
+		ret = overlay_fixup_one_phandle(fdt, fdto, symbols_off,
+						path, path_len, name, name_len,
+						poffset, label);
+		if (ret)
+			return ret;
+	} while (len > 0);
+
+	return 0;
+}
+
+/**
+ * overlay_fixup_phandles - Resolve the overlay phandles to the base
+ *                          device tree
+ * @fdt: Base Device Tree blob
+ * @fdto: Device tree overlay blob
+ *
+ * overlay_fixup_phandles() resolves all the overlay phandles pointing
+ * to nodes in the base device tree.
+ *
+ * This is one of the steps of the device tree overlay application
+ * process, when you want all the phandles in the overlay to point to
+ * the actual base dt nodes.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_fixup_phandles(void *fdt, void *fdto)
+{
+	int fixups_off, symbols_off;
+	int property;
+
+	/* We can have overlays without any fixups */
+	fixups_off = fdt_path_offset(fdto, "/__fixups__");
+	if (fixups_off == -FDT_ERR_NOTFOUND)
+		return 0; /* nothing to do */
+	if (fixups_off < 0)
+		return fixups_off;
+
+	/* And base DTs without symbols */
+	symbols_off = fdt_path_offset(fdt, "/__symbols__");
+	if ((symbols_off < 0 && (symbols_off != -FDT_ERR_NOTFOUND)))
+		return symbols_off;
+
+	fdt_for_each_property_offset(property, fdto, fixups_off) {
+		int ret;
+
+		ret = overlay_fixup_phandle(fdt, fdto, symbols_off, property);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * overlay_apply_node - Merges a node into the base device tree
+ * @fdt: Base Device Tree blob
+ * @target: Node offset in the base device tree to apply the fragment to
+ * @fdto: Device tree overlay blob
+ * @node: Node offset in the overlay holding the changes to merge
+ *
+ * overlay_apply_node() merges a node into a target base device tree
+ * node pointed.
+ *
+ * This is part of the final step in the device tree overlay
+ * application process, when all the phandles have been adjusted and
+ * resolved and you just have to merge overlay into the base device
+ * tree.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_apply_node(void *fdt, int target,
+			      void *fdto, int node)
+{
+	int property;
+	int subnode;
+
+	fdt_for_each_property_offset(property, fdto, node) {
+		const char *name;
+		const void *prop;
+		int prop_len;
+		int ret;
+
+		prop = fdt_getprop_by_offset(fdto, property, &name,
+					     &prop_len);
+		if (prop_len == -FDT_ERR_NOTFOUND)
+			return -FDT_ERR_INTERNAL;
+		if (prop_len < 0)
+			return prop_len;
+
+		ret = fdt_setprop(fdt, target, name, prop, prop_len);
+		if (ret)
+			return ret;
+	}
+
+	fdt_for_each_subnode(subnode, fdto, node) {
+		const char *name = fdt_get_name(fdto, subnode, NULL);
+		int nnode;
+		int ret;
+
+		nnode = fdt_add_subnode(fdt, target, name);
+		if (nnode == -FDT_ERR_EXISTS) {
+			nnode = fdt_subnode_offset(fdt, target, name);
+			if (nnode == -FDT_ERR_NOTFOUND)
+				return -FDT_ERR_INTERNAL;
+		}
+
+		if (nnode < 0)
+			return nnode;
+
+		ret = overlay_apply_node(fdt, nnode, fdto, subnode);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * overlay_merge - Merge an overlay into its base device tree
+ * @fdt: Base Device Tree blob
+ * @fdto: Device tree overlay blob
+ *
+ * overlay_merge() merges an overlay into its base device tree.
+ *
+ * This is the next to last step in the device tree overlay application
+ * process, when all the phandles have been adjusted and resolved and
+ * you just have to merge overlay into the base device tree.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_merge(void *fdt, void *fdto)
+{
+	int fragment;
+
+	fdt_for_each_subnode(fragment, fdto, 0) {
+		int overlay;
+		int target;
+		int ret;
+
+		/*
+		 * Each fragments will have an __overlay__ node. If
+		 * they don't, it's not supposed to be merged
+		 */
+		overlay = fdt_subnode_offset(fdto, fragment, "__overlay__");
+		if (overlay == -FDT_ERR_NOTFOUND)
+			continue;
+
+		if (overlay < 0)
+			return overlay;
+
+		target = fdt_overlay_target_offset(fdt, fdto, fragment, NULL);
+		if (target < 0)
+			return target;
+
+		ret = overlay_apply_node(fdt, target, fdto, overlay);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int get_path_len(const void *fdt, int nodeoffset)
+{
+	int len = 0, namelen;
+	const char *name;
+
+	FDT_RO_PROBE(fdt);
+
+	for (;;) {
+		name = fdt_get_name(fdt, nodeoffset, &namelen);
+		if (!name)
+			return namelen;
+
+		/* root? we're done */
+		if (namelen == 0)
+			break;
+
+		nodeoffset = fdt_parent_offset(fdt, nodeoffset);
+		if (nodeoffset < 0)
+			return nodeoffset;
+		len += namelen + 1;
+	}
+
+	/* in case of root pretend it's "/" */
+	if (len == 0)
+		len++;
+	return len;
+}
+
+/**
+ * overlay_symbol_update - Update the symbols of base tree after a merge
+ * @fdt: Base Device Tree blob
+ * @fdto: Device tree overlay blob
+ *
+ * overlay_symbol_update() updates the symbols of the base tree with the
+ * symbols of the applied overlay
+ *
+ * This is the last step in the device tree overlay application
+ * process, allowing the reference of overlay symbols by subsequent
+ * overlay operations.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_symbol_update(void *fdt, void *fdto)
+{
+	int root_sym, ov_sym, prop, path_len, fragment, target;
+	int len, frag_name_len, ret, rel_path_len;
+	const char *s, *e;
+	const char *path;
+	const char *name;
+	const char *frag_name;
+	const char *rel_path;
+	const char *target_path;
+	char *buf;
+	void *p;
+
+	ov_sym = fdt_subnode_offset(fdto, 0, "__symbols__");
+
+	/* if no overlay symbols exist no problem */
+	if (ov_sym < 0)
+		return 0;
+
+	root_sym = fdt_subnode_offset(fdt, 0, "__symbols__");
+
+	/* it no root symbols exist we should create them */
+	if (root_sym == -FDT_ERR_NOTFOUND)
+		root_sym = fdt_add_subnode(fdt, 0, "__symbols__");
+
+	/* any error is fatal now */
+	if (root_sym < 0)
+		return root_sym;
+
+	/* iterate over each overlay symbol */
+	fdt_for_each_property_offset(prop, fdto, ov_sym) {
+		path = fdt_getprop_by_offset(fdto, prop, &name, &path_len);
+		if (!path)
+			return path_len;
+
+		/* verify it's a string property (terminated by a single \0) */
+		if (path_len < 1 || memchr(path, '\0', path_len) != &path[path_len - 1])
+			return -FDT_ERR_BADVALUE;
+
+		/* keep end marker to avoid strlen() */
+		e = path + path_len;
+
+		if (*path != '/')
+			return -FDT_ERR_BADVALUE;
+
+		/* get fragment name first */
+		s = strchr(path + 1, '/');
+		if (!s) {
+			/* Symbol refers to something that won't end
+			 * up in the target tree */
+			continue;
+		}
+
+		frag_name = path + 1;
+		frag_name_len = s - path - 1;
+
+		/* verify format; safe since "s" lies in \0 terminated prop */
+		len = sizeof("/__overlay__/") - 1;
+		if ((e - s) > len && (memcmp(s, "/__overlay__/", len) == 0)) {
+			/* /<fragment-name>/__overlay__/<relative-subnode-path> */
+			rel_path = s + len;
+			rel_path_len = e - rel_path - 1;
+		} else if ((e - s) == len
+			   && (memcmp(s, "/__overlay__", len - 1) == 0)) {
+			/* /<fragment-name>/__overlay__ */
+			rel_path = "";
+			rel_path_len = 0;
+		} else {
+			/* Symbol refers to something that won't end
+			 * up in the target tree */
+			continue;
+		}
+
+		/* find the fragment index in which the symbol lies */
+		ret = fdt_subnode_offset_namelen(fdto, 0, frag_name,
+					       frag_name_len);
+		/* not found? */
+		if (ret < 0)
+			return -FDT_ERR_BADOVERLAY;
+		fragment = ret;
+
+		/* an __overlay__ subnode must exist */
+		ret = fdt_subnode_offset(fdto, fragment, "__overlay__");
+		if (ret < 0)
+			return -FDT_ERR_BADOVERLAY;
+
+		/* get the target of the fragment */
+		ret = fdt_overlay_target_offset(fdt, fdto, fragment, &target_path);
+		if (ret < 0)
+			return ret;
+		target = ret;
+
+		/* if we have a target path use */
+		if (!target_path) {
+			ret = get_path_len(fdt, target);
+			if (ret < 0)
+				return ret;
+			len = ret;
+		} else {
+			len = strlen(target_path);
+		}
+
+		ret = fdt_setprop_placeholder(fdt, root_sym, name,
+				len + (len > 1) + rel_path_len + 1, &p);
+		if (ret < 0)
+			return ret;
+
+		if (!target_path) {
+			/* again in case setprop_placeholder changed it */
+			ret = fdt_overlay_target_offset(fdt, fdto, fragment, &target_path);
+			if (ret < 0)
+				return ret;
+			target = ret;
+		}
+
+		buf = p;
+		if (len > 1) { /* target is not root */
+			if (!target_path) {
+				ret = fdt_get_path(fdt, target, buf, len + 1);
+				if (ret < 0)
+					return ret;
+			} else
+				memcpy(buf, target_path, len + 1);
+
+		} else
+			len--;
+
+		buf[len] = '/';
+		memcpy(buf + len + 1, rel_path, rel_path_len);
+		buf[len + 1 + rel_path_len] = '\0';
+	}
+
+	return 0;
+}
+
+int fdt_overlay_apply(void *fdt, void *fdto)
+{
+	uint32_t delta;
+	int ret;
+
+	FDT_RO_PROBE(fdt);
+	FDT_RO_PROBE(fdto);
+
+	ret = fdt_find_max_phandle(fdt, &delta);
+	if (ret)
+		goto err;
+
+	ret = overlay_adjust_local_phandles(fdto, delta);
+	if (ret)
+		goto err;
+
+	ret = overlay_update_local_references(fdto, delta);
+	if (ret)
+		goto err;
+
+	ret = overlay_fixup_phandles(fdt, fdto);
+	if (ret)
+		goto err;
+
+	ret = overlay_merge(fdt, fdto);
+	if (ret)
+		goto err;
+
+	ret = overlay_symbol_update(fdt, fdto);
+	if (ret)
+		goto err;
+
+	/*
+	 * The overlay has been damaged, erase its magic.
+	 */
+	fdt_set_magic(fdto, ~0);
+
+	return 0;
+
+err:
+	/*
+	 * The overlay might have been damaged, erase its magic.
+	 */
+	fdt_set_magic(fdto, ~0);
+
+	/*
+	 * The base device tree might have been damaged, erase its
+	 * magic.
+	 */
+	fdt_set_magic(fdt, ~0);
+
+	return ret;
+}
diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
new file mode 100644
index 000000000000..9f6c551a22c2
--- /dev/null
+++ b/libfdt/fdt_ro.c
@@ -0,0 +1,859 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+static int fdt_nodename_eq_(const void *fdt, int offset,
+			    const char *s, int len)
+{
+	int olen;
+	const char *p = fdt_get_name(fdt, offset, &olen);
+
+	if (!p || olen < len)
+		/* short match */
+		return 0;
+
+	if (memcmp(p, s, len) != 0)
+		return 0;
+
+	if (p[len] == '\0')
+		return 1;
+	else if (!memchr(s, '@', len) && (p[len] == '@'))
+		return 1;
+	else
+		return 0;
+}
+
+const char *fdt_get_string(const void *fdt, int stroffset, int *lenp)
+{
+	int32_t totalsize;
+	uint32_t absoffset;
+	size_t len;
+	int err;
+	const char *s, *n;
+
+	if (can_assume(VALID_INPUT)) {
+		s = (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
+
+		if (lenp)
+			*lenp = strlen(s);
+		return s;
+	}
+	totalsize = fdt_ro_probe_(fdt);
+	err = totalsize;
+	if (totalsize < 0)
+		goto fail;
+
+	err = -FDT_ERR_BADOFFSET;
+	absoffset = stroffset + fdt_off_dt_strings(fdt);
+	if (absoffset >= (unsigned)totalsize)
+		goto fail;
+	len = totalsize - absoffset;
+
+	if (fdt_magic(fdt) == FDT_MAGIC) {
+		if (stroffset < 0)
+			goto fail;
+		if (can_assume(LATEST) || fdt_version(fdt) >= 17) {
+			if ((unsigned)stroffset >= fdt_size_dt_strings(fdt))
+				goto fail;
+			if ((fdt_size_dt_strings(fdt) - stroffset) < len)
+				len = fdt_size_dt_strings(fdt) - stroffset;
+		}
+	} else if (fdt_magic(fdt) == FDT_SW_MAGIC) {
+		unsigned int sw_stroffset = -stroffset;
+
+		if ((stroffset >= 0) ||
+		    (sw_stroffset > fdt_size_dt_strings(fdt)))
+			goto fail;
+		if (sw_stroffset < len)
+			len = sw_stroffset;
+	} else {
+		err = -FDT_ERR_INTERNAL;
+		goto fail;
+	}
+
+	s = (const char *)fdt + absoffset;
+	n = memchr(s, '\0', len);
+	if (!n) {
+		/* missing terminating NULL */
+		err = -FDT_ERR_TRUNCATED;
+		goto fail;
+	}
+
+	if (lenp)
+		*lenp = n - s;
+	return s;
+
+fail:
+	if (lenp)
+		*lenp = err;
+	return NULL;
+}
+
+const char *fdt_string(const void *fdt, int stroffset)
+{
+	return fdt_get_string(fdt, stroffset, NULL);
+}
+
+static int fdt_string_eq_(const void *fdt, int stroffset,
+			  const char *s, int len)
+{
+	int slen;
+	const char *p = fdt_get_string(fdt, stroffset, &slen);
+
+	return p && (slen == len) && (memcmp(p, s, len) == 0);
+}
+
+int fdt_find_max_phandle(const void *fdt, uint32_t *phandle)
+{
+	uint32_t max = 0;
+	int offset = -1;
+
+	while (true) {
+		uint32_t value;
+
+		offset = fdt_next_node(fdt, offset, NULL);
+		if (offset < 0) {
+			if (offset == -FDT_ERR_NOTFOUND)
+				break;
+
+			return offset;
+		}
+
+		value = fdt_get_phandle(fdt, offset);
+
+		if (value > max)
+			max = value;
+	}
+
+	if (phandle)
+		*phandle = max;
+
+	return 0;
+}
+
+int fdt_generate_phandle(const void *fdt, uint32_t *phandle)
+{
+	uint32_t max;
+	int err;
+
+	err = fdt_find_max_phandle(fdt, &max);
+	if (err < 0)
+		return err;
+
+	if (max == FDT_MAX_PHANDLE)
+		return -FDT_ERR_NOPHANDLES;
+
+	if (phandle)
+		*phandle = max + 1;
+
+	return 0;
+}
+
+static const struct fdt_reserve_entry *fdt_mem_rsv(const void *fdt, int n)
+{
+	unsigned int offset = n * sizeof(struct fdt_reserve_entry);
+	unsigned int absoffset = fdt_off_mem_rsvmap(fdt) + offset;
+
+	if (!can_assume(VALID_INPUT)) {
+		if (absoffset < fdt_off_mem_rsvmap(fdt))
+			return NULL;
+		if (absoffset > fdt_totalsize(fdt) -
+		    sizeof(struct fdt_reserve_entry))
+			return NULL;
+	}
+	return fdt_mem_rsv_(fdt, n);
+}
+
+int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
+{
+	const struct fdt_reserve_entry *re;
+
+	FDT_RO_PROBE(fdt);
+	re = fdt_mem_rsv(fdt, n);
+	if (!can_assume(VALID_INPUT) && !re)
+		return -FDT_ERR_BADOFFSET;
+
+	*address = fdt64_ld_(&re->address);
+	*size = fdt64_ld_(&re->size);
+	return 0;
+}
+
+int fdt_num_mem_rsv(const void *fdt)
+{
+	int i;
+	const struct fdt_reserve_entry *re;
+
+	for (i = 0; (re = fdt_mem_rsv(fdt, i)) != NULL; i++) {
+		if (fdt64_ld_(&re->size) == 0)
+			return i;
+	}
+	return -FDT_ERR_TRUNCATED;
+}
+
+static int nextprop_(const void *fdt, int offset)
+{
+	uint32_t tag;
+	int nextoffset;
+
+	do {
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+
+		switch (tag) {
+		case FDT_END:
+			if (nextoffset >= 0)
+				return -FDT_ERR_BADSTRUCTURE;
+			else
+				return nextoffset;
+
+		case FDT_PROP:
+			return offset;
+		}
+		offset = nextoffset;
+	} while (tag == FDT_NOP);
+
+	return -FDT_ERR_NOTFOUND;
+}
+
+int fdt_subnode_offset_namelen(const void *fdt, int offset,
+			       const char *name, int namelen)
+{
+	int depth;
+
+	FDT_RO_PROBE(fdt);
+
+	for (depth = 0;
+	     (offset >= 0) && (depth >= 0);
+	     offset = fdt_next_node(fdt, offset, &depth))
+		if ((depth == 1)
+		    && fdt_nodename_eq_(fdt, offset, name, namelen))
+			return offset;
+
+	if (depth < 0)
+		return -FDT_ERR_NOTFOUND;
+	return offset; /* error */
+}
+
+int fdt_subnode_offset(const void *fdt, int parentoffset,
+		       const char *name)
+{
+	return fdt_subnode_offset_namelen(fdt, parentoffset, name, strlen(name));
+}
+
+int fdt_path_offset_namelen(const void *fdt, const char *path, int namelen)
+{
+	const char *end = path + namelen;
+	const char *p = path;
+	int offset = 0;
+
+	FDT_RO_PROBE(fdt);
+
+	/* see if we have an alias */
+	if (*path != '/') {
+		const char *q = memchr(path, '/', end - p);
+
+		if (!q)
+			q = end;
+
+		p = fdt_get_alias_namelen(fdt, p, q - p);
+		if (!p)
+			return -FDT_ERR_BADPATH;
+		offset = fdt_path_offset(fdt, p);
+
+		p = q;
+	}
+
+	while (p < end) {
+		const char *q;
+
+		while (*p == '/') {
+			p++;
+			if (p == end)
+				return offset;
+		}
+		q = memchr(p, '/', end - p);
+		if (! q)
+			q = end;
+
+		offset = fdt_subnode_offset_namelen(fdt, offset, p, q-p);
+		if (offset < 0)
+			return offset;
+
+		p = q;
+	}
+
+	return offset;
+}
+
+int fdt_path_offset(const void *fdt, const char *path)
+{
+	return fdt_path_offset_namelen(fdt, path, strlen(path));
+}
+
+const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
+{
+	const struct fdt_node_header *nh = fdt_offset_ptr_(fdt, nodeoffset);
+	const char *nameptr;
+	int err;
+
+	if (((err = fdt_ro_probe_(fdt)) < 0)
+	    || ((err = fdt_check_node_offset_(fdt, nodeoffset)) < 0))
+			goto fail;
+
+	nameptr = nh->name;
+
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
+		/*
+		 * For old FDT versions, match the naming conventions of V16:
+		 * give only the leaf name (after all /). The actual tree
+		 * contents are loosely checked.
+		 */
+		const char *leaf;
+		leaf = strrchr(nameptr, '/');
+		if (leaf == NULL) {
+			err = -FDT_ERR_BADSTRUCTURE;
+			goto fail;
+		}
+		nameptr = leaf+1;
+	}
+
+	if (len)
+		*len = strlen(nameptr);
+
+	return nameptr;
+
+ fail:
+	if (len)
+		*len = err;
+	return NULL;
+}
+
+int fdt_first_property_offset(const void *fdt, int nodeoffset)
+{
+	int offset;
+
+	if ((offset = fdt_check_node_offset_(fdt, nodeoffset)) < 0)
+		return offset;
+
+	return nextprop_(fdt, offset);
+}
+
+int fdt_next_property_offset(const void *fdt, int offset)
+{
+	if ((offset = fdt_check_prop_offset_(fdt, offset)) < 0)
+		return offset;
+
+	return nextprop_(fdt, offset);
+}
+
+static const struct fdt_property *fdt_get_property_by_offset_(const void *fdt,
+						              int offset,
+						              int *lenp)
+{
+	int err;
+	const struct fdt_property *prop;
+
+	if (!can_assume(VALID_INPUT) &&
+	    (err = fdt_check_prop_offset_(fdt, offset)) < 0) {
+		if (lenp)
+			*lenp = err;
+		return NULL;
+	}
+
+	prop = fdt_offset_ptr_(fdt, offset);
+
+	if (lenp)
+		*lenp = fdt32_ld_(&prop->len);
+
+	return prop;
+}
+
+const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
+						      int offset,
+						      int *lenp)
+{
+	/* Prior to version 16, properties may need realignment
+	 * and this API does not work. fdt_getprop_*() will, however. */
+
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
+		if (lenp)
+			*lenp = -FDT_ERR_BADVERSION;
+		return NULL;
+	}
+
+	return fdt_get_property_by_offset_(fdt, offset, lenp);
+}
+
+static const struct fdt_property *fdt_get_property_namelen_(const void *fdt,
+						            int offset,
+						            const char *name,
+						            int namelen,
+							    int *lenp,
+							    int *poffset)
+{
+	for (offset = fdt_first_property_offset(fdt, offset);
+	     (offset >= 0);
+	     (offset = fdt_next_property_offset(fdt, offset))) {
+		const struct fdt_property *prop;
+
+		prop = fdt_get_property_by_offset_(fdt, offset, lenp);
+		if (!can_assume(LIBFDT_FLAWLESS) && !prop) {
+			offset = -FDT_ERR_INTERNAL;
+			break;
+		}
+		if (fdt_string_eq_(fdt, fdt32_ld_(&prop->nameoff),
+				   name, namelen)) {
+			if (poffset)
+				*poffset = offset;
+			return prop;
+		}
+	}
+
+	if (lenp)
+		*lenp = offset;
+	return NULL;
+}
+
+
+const struct fdt_property *fdt_get_property_namelen(const void *fdt,
+						    int offset,
+						    const char *name,
+						    int namelen, int *lenp)
+{
+	/* Prior to version 16, properties may need realignment
+	 * and this API does not work. fdt_getprop_*() will, however. */
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
+		if (lenp)
+			*lenp = -FDT_ERR_BADVERSION;
+		return NULL;
+	}
+
+	return fdt_get_property_namelen_(fdt, offset, name, namelen, lenp,
+					 NULL);
+}
+
+
+const struct fdt_property *fdt_get_property(const void *fdt,
+					    int nodeoffset,
+					    const char *name, int *lenp)
+{
+	return fdt_get_property_namelen(fdt, nodeoffset, name,
+					strlen(name), lenp);
+}
+
+const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
+				const char *name, int namelen, int *lenp)
+{
+	int poffset;
+	const struct fdt_property *prop;
+
+	prop = fdt_get_property_namelen_(fdt, nodeoffset, name, namelen, lenp,
+					 &poffset);
+	if (!prop)
+		return NULL;
+
+	/* Handle realignment */
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
+	    (poffset + sizeof(*prop)) % 8 && fdt32_ld_(&prop->len) >= 8)
+		return prop->data + 4;
+	return prop->data;
+}
+
+const void *fdt_getprop_by_offset(const void *fdt, int offset,
+				  const char **namep, int *lenp)
+{
+	const struct fdt_property *prop;
+
+	prop = fdt_get_property_by_offset_(fdt, offset, lenp);
+	if (!prop)
+		return NULL;
+	if (namep) {
+		const char *name;
+		int namelen;
+
+		if (!can_assume(VALID_INPUT)) {
+			name = fdt_get_string(fdt, fdt32_ld_(&prop->nameoff),
+					      &namelen);
+			*namep = name;
+			if (!name) {
+				if (lenp)
+					*lenp = namelen;
+				return NULL;
+			}
+		} else {
+			*namep = fdt_string(fdt, fdt32_ld_(&prop->nameoff));
+		}
+	}
+
+	/* Handle realignment */
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
+	    (offset + sizeof(*prop)) % 8 && fdt32_ld_(&prop->len) >= 8)
+		return prop->data + 4;
+	return prop->data;
+}
+
+const void *fdt_getprop(const void *fdt, int nodeoffset,
+			const char *name, int *lenp)
+{
+	return fdt_getprop_namelen(fdt, nodeoffset, name, strlen(name), lenp);
+}
+
+uint32_t fdt_get_phandle(const void *fdt, int nodeoffset)
+{
+	const fdt32_t *php;
+	int len;
+
+	/* FIXME: This is a bit sub-optimal, since we potentially scan
+	 * over all the properties twice. */
+	php = fdt_getprop(fdt, nodeoffset, "phandle", &len);
+	if (!php || (len != sizeof(*php))) {
+		php = fdt_getprop(fdt, nodeoffset, "linux,phandle", &len);
+		if (!php || (len != sizeof(*php)))
+			return 0;
+	}
+
+	return fdt32_ld_(php);
+}
+
+const char *fdt_get_alias_namelen(const void *fdt,
+				  const char *name, int namelen)
+{
+	int aliasoffset;
+
+	aliasoffset = fdt_path_offset(fdt, "/aliases");
+	if (aliasoffset < 0)
+		return NULL;
+
+	return fdt_getprop_namelen(fdt, aliasoffset, name, namelen, NULL);
+}
+
+const char *fdt_get_alias(const void *fdt, const char *name)
+{
+	return fdt_get_alias_namelen(fdt, name, strlen(name));
+}
+
+int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen)
+{
+	int pdepth = 0, p = 0;
+	int offset, depth, namelen;
+	const char *name;
+
+	FDT_RO_PROBE(fdt);
+
+	if (buflen < 2)
+		return -FDT_ERR_NOSPACE;
+
+	for (offset = 0, depth = 0;
+	     (offset >= 0) && (offset <= nodeoffset);
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		while (pdepth > depth) {
+			do {
+				p--;
+			} while (buf[p-1] != '/');
+			pdepth--;
+		}
+
+		if (pdepth >= depth) {
+			name = fdt_get_name(fdt, offset, &namelen);
+			if (!name)
+				return namelen;
+			if ((p + namelen + 1) <= buflen) {
+				memcpy(buf + p, name, namelen);
+				p += namelen;
+				buf[p++] = '/';
+				pdepth++;
+			}
+		}
+
+		if (offset == nodeoffset) {
+			if (pdepth < (depth + 1))
+				return -FDT_ERR_NOSPACE;
+
+			if (p > 1) /* special case so that root path is "/", not "" */
+				p--;
+			buf[p] = '\0';
+			return 0;
+		}
+	}
+
+	if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
+		return -FDT_ERR_BADOFFSET;
+	else if (offset == -FDT_ERR_BADOFFSET)
+		return -FDT_ERR_BADSTRUCTURE;
+
+	return offset; /* error from fdt_next_node() */
+}
+
+int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
+				 int supernodedepth, int *nodedepth)
+{
+	int offset, depth;
+	int supernodeoffset = -FDT_ERR_INTERNAL;
+
+	FDT_RO_PROBE(fdt);
+
+	if (supernodedepth < 0)
+		return -FDT_ERR_NOTFOUND;
+
+	for (offset = 0, depth = 0;
+	     (offset >= 0) && (offset <= nodeoffset);
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		if (depth == supernodedepth)
+			supernodeoffset = offset;
+
+		if (offset == nodeoffset) {
+			if (nodedepth)
+				*nodedepth = depth;
+
+			if (supernodedepth > depth)
+				return -FDT_ERR_NOTFOUND;
+			else
+				return supernodeoffset;
+		}
+	}
+
+	if (!can_assume(VALID_INPUT)) {
+		if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
+			return -FDT_ERR_BADOFFSET;
+		else if (offset == -FDT_ERR_BADOFFSET)
+			return -FDT_ERR_BADSTRUCTURE;
+	}
+
+	return offset; /* error from fdt_next_node() */
+}
+
+int fdt_node_depth(const void *fdt, int nodeoffset)
+{
+	int nodedepth;
+	int err;
+
+	err = fdt_supernode_atdepth_offset(fdt, nodeoffset, 0, &nodedepth);
+	if (err)
+		return (can_assume(LIBFDT_FLAWLESS) || err < 0) ? err :
+			-FDT_ERR_INTERNAL;
+	return nodedepth;
+}
+
+int fdt_parent_offset(const void *fdt, int nodeoffset)
+{
+	int nodedepth = fdt_node_depth(fdt, nodeoffset);
+
+	if (nodedepth < 0)
+		return nodedepth;
+	return fdt_supernode_atdepth_offset(fdt, nodeoffset,
+					    nodedepth - 1, NULL);
+}
+
+int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
+				  const char *propname,
+				  const void *propval, int proplen)
+{
+	int offset;
+	const void *val;
+	int len;
+
+	FDT_RO_PROBE(fdt);
+
+	/* FIXME: The algorithm here is pretty horrible: we scan each
+	 * property of a node in fdt_getprop(), then if that didn't
+	 * find what we want, we scan over them again making our way
+	 * to the next node.  Still it's the easiest to implement
+	 * approach; performance can come later. */
+	for (offset = fdt_next_node(fdt, startoffset, NULL);
+	     offset >= 0;
+	     offset = fdt_next_node(fdt, offset, NULL)) {
+		val = fdt_getprop(fdt, offset, propname, &len);
+		if (val && (len == proplen)
+		    && (memcmp(val, propval, len) == 0))
+			return offset;
+	}
+
+	return offset; /* error from fdt_next_node() */
+}
+
+int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle)
+{
+	int offset;
+
+	if ((phandle == 0) || (phandle == ~0U))
+		return -FDT_ERR_BADPHANDLE;
+
+	FDT_RO_PROBE(fdt);
+
+	/* FIXME: The algorithm here is pretty horrible: we
+	 * potentially scan each property of a node in
+	 * fdt_get_phandle(), then if that didn't find what
+	 * we want, we scan over them again making our way to the next
+	 * node.  Still it's the easiest to implement approach;
+	 * performance can come later. */
+	for (offset = fdt_next_node(fdt, -1, NULL);
+	     offset >= 0;
+	     offset = fdt_next_node(fdt, offset, NULL)) {
+		if (fdt_get_phandle(fdt, offset) == phandle)
+			return offset;
+	}
+
+	return offset; /* error from fdt_next_node() */
+}
+
+int fdt_stringlist_contains(const char *strlist, int listlen, const char *str)
+{
+	int len = strlen(str);
+	const char *p;
+
+	while (listlen >= len) {
+		if (memcmp(str, strlist, len+1) == 0)
+			return 1;
+		p = memchr(strlist, '\0', listlen);
+		if (!p)
+			return 0; /* malformed strlist.. */
+		listlen -= (p-strlist) + 1;
+		strlist = p + 1;
+	}
+	return 0;
+}
+
+int fdt_stringlist_count(const void *fdt, int nodeoffset, const char *property)
+{
+	const char *list, *end;
+	int length, count = 0;
+
+	list = fdt_getprop(fdt, nodeoffset, property, &length);
+	if (!list)
+		return length;
+
+	end = list + length;
+
+	while (list < end) {
+		length = strnlen(list, end - list) + 1;
+
+		/* Abort if the last string isn't properly NUL-terminated. */
+		if (list + length > end)
+			return -FDT_ERR_BADVALUE;
+
+		list += length;
+		count++;
+	}
+
+	return count;
+}
+
+int fdt_stringlist_search(const void *fdt, int nodeoffset, const char *property,
+			  const char *string)
+{
+	int length, len, idx = 0;
+	const char *list, *end;
+
+	list = fdt_getprop(fdt, nodeoffset, property, &length);
+	if (!list)
+		return length;
+
+	len = strlen(string) + 1;
+	end = list + length;
+
+	while (list < end) {
+		length = strnlen(list, end - list) + 1;
+
+		/* Abort if the last string isn't properly NUL-terminated. */
+		if (list + length > end)
+			return -FDT_ERR_BADVALUE;
+
+		if (length == len && memcmp(list, string, length) == 0)
+			return idx;
+
+		list += length;
+		idx++;
+	}
+
+	return -FDT_ERR_NOTFOUND;
+}
+
+const char *fdt_stringlist_get(const void *fdt, int nodeoffset,
+			       const char *property, int idx,
+			       int *lenp)
+{
+	const char *list, *end;
+	int length;
+
+	list = fdt_getprop(fdt, nodeoffset, property, &length);
+	if (!list) {
+		if (lenp)
+			*lenp = length;
+
+		return NULL;
+	}
+
+	end = list + length;
+
+	while (list < end) {
+		length = strnlen(list, end - list) + 1;
+
+		/* Abort if the last string isn't properly NUL-terminated. */
+		if (list + length > end) {
+			if (lenp)
+				*lenp = -FDT_ERR_BADVALUE;
+
+			return NULL;
+		}
+
+		if (idx == 0) {
+			if (lenp)
+				*lenp = length - 1;
+
+			return list;
+		}
+
+		list += length;
+		idx--;
+	}
+
+	if (lenp)
+		*lenp = -FDT_ERR_NOTFOUND;
+
+	return NULL;
+}
+
+int fdt_node_check_compatible(const void *fdt, int nodeoffset,
+			      const char *compatible)
+{
+	const void *prop;
+	int len;
+
+	prop = fdt_getprop(fdt, nodeoffset, "compatible", &len);
+	if (!prop)
+		return len;
+
+	return !fdt_stringlist_contains(prop, len, compatible);
+}
+
+int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
+				  const char *compatible)
+{
+	int offset, err;
+
+	FDT_RO_PROBE(fdt);
+
+	/* FIXME: The algorithm here is pretty horrible: we scan each
+	 * property of a node in fdt_node_check_compatible(), then if
+	 * that didn't find what we want, we scan over them again
+	 * making our way to the next node.  Still it's the easiest to
+	 * implement approach; performance can come later. */
+	for (offset = fdt_next_node(fdt, startoffset, NULL);
+	     offset >= 0;
+	     offset = fdt_next_node(fdt, offset, NULL)) {
+		err = fdt_node_check_compatible(fdt, offset, compatible);
+		if ((err < 0) && (err != -FDT_ERR_NOTFOUND))
+			return err;
+		else if (err == 0)
+			return offset;
+	}
+
+	return offset; /* error from fdt_next_node() */
+}
diff --git a/libfdt/fdt_rw.c b/libfdt/fdt_rw.c
new file mode 100644
index 000000000000..3621d3651d3f
--- /dev/null
+++ b/libfdt/fdt_rw.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+static int fdt_blocks_misordered_(const void *fdt,
+				  int mem_rsv_size, int struct_size)
+{
+	return (fdt_off_mem_rsvmap(fdt) < FDT_ALIGN(sizeof(struct fdt_header), 8))
+		|| (fdt_off_dt_struct(fdt) <
+		    (fdt_off_mem_rsvmap(fdt) + mem_rsv_size))
+		|| (fdt_off_dt_strings(fdt) <
+		    (fdt_off_dt_struct(fdt) + struct_size))
+		|| (fdt_totalsize(fdt) <
+		    (fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt)));
+}
+
+static int fdt_rw_probe_(void *fdt)
+{
+	if (can_assume(VALID_DTB))
+		return 0;
+	FDT_RO_PROBE(fdt);
+
+	if (!can_assume(LATEST) && fdt_version(fdt) < 17)
+		return -FDT_ERR_BADVERSION;
+	if (fdt_blocks_misordered_(fdt, sizeof(struct fdt_reserve_entry),
+				   fdt_size_dt_struct(fdt)))
+		return -FDT_ERR_BADLAYOUT;
+	if (!can_assume(LATEST) && fdt_version(fdt) > 17)
+		fdt_set_version(fdt, 17);
+
+	return 0;
+}
+
+#define FDT_RW_PROBE(fdt) \
+	{ \
+		int err_; \
+		if ((err_ = fdt_rw_probe_(fdt)) != 0) \
+			return err_; \
+	}
+
+static inline unsigned int fdt_data_size_(void *fdt)
+{
+	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
+}
+
+static int fdt_splice_(void *fdt, void *splicepoint, int oldlen, int newlen)
+{
+	char *p = splicepoint;
+	unsigned int dsize = fdt_data_size_(fdt);
+	size_t soff = p - (char *)fdt;
+
+	if ((oldlen < 0) || (soff + oldlen < soff) || (soff + oldlen > dsize))
+		return -FDT_ERR_BADOFFSET;
+	if ((p < (char *)fdt) || (dsize + newlen < (unsigned)oldlen))
+		return -FDT_ERR_BADOFFSET;
+	if (dsize - oldlen + newlen > fdt_totalsize(fdt))
+		return -FDT_ERR_NOSPACE;
+	memmove(p + newlen, p + oldlen, ((char *)fdt + dsize) - (p + oldlen));
+	return 0;
+}
+
+static int fdt_splice_mem_rsv_(void *fdt, struct fdt_reserve_entry *p,
+			       int oldn, int newn)
+{
+	int delta = (newn - oldn) * sizeof(*p);
+	int err;
+	err = fdt_splice_(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
+	if (err)
+		return err;
+	fdt_set_off_dt_struct(fdt, fdt_off_dt_struct(fdt) + delta);
+	fdt_set_off_dt_strings(fdt, fdt_off_dt_strings(fdt) + delta);
+	return 0;
+}
+
+static int fdt_splice_struct_(void *fdt, void *p,
+			      int oldlen, int newlen)
+{
+	int delta = newlen - oldlen;
+	int err;
+
+	if ((err = fdt_splice_(fdt, p, oldlen, newlen)))
+		return err;
+
+	fdt_set_size_dt_struct(fdt, fdt_size_dt_struct(fdt) + delta);
+	fdt_set_off_dt_strings(fdt, fdt_off_dt_strings(fdt) + delta);
+	return 0;
+}
+
+/* Must only be used to roll back in case of error */
+static void fdt_del_last_string_(void *fdt, const char *s)
+{
+	int newlen = strlen(s) + 1;
+
+	fdt_set_size_dt_strings(fdt, fdt_size_dt_strings(fdt) - newlen);
+}
+
+static int fdt_splice_string_(void *fdt, int newlen)
+{
+	void *p = (char *)fdt
+		+ fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
+	int err;
+
+	if ((err = fdt_splice_(fdt, p, 0, newlen)))
+		return err;
+
+	fdt_set_size_dt_strings(fdt, fdt_size_dt_strings(fdt) + newlen);
+	return 0;
+}
+
+/**
+ * fdt_find_add_string_() - Find or allocate a string
+ *
+ * @fdt: pointer to the device tree to check/adjust
+ * @s: string to find/add
+ * @allocated: Set to 0 if the string was found, 1 if not found and so
+ *	allocated. Ignored if can_assume(NO_ROLLBACK)
+ * @return offset of string in the string table (whether found or added)
+ */
+static int fdt_find_add_string_(void *fdt, const char *s, int *allocated)
+{
+	char *strtab = (char *)fdt + fdt_off_dt_strings(fdt);
+	const char *p;
+	char *new;
+	int len = strlen(s) + 1;
+	int err;
+
+	if (!can_assume(NO_ROLLBACK))
+		*allocated = 0;
+
+	p = fdt_find_string_(strtab, fdt_size_dt_strings(fdt), s);
+	if (p)
+		/* found it */
+		return (p - strtab);
+
+	new = strtab + fdt_size_dt_strings(fdt);
+	err = fdt_splice_string_(fdt, len);
+	if (err)
+		return err;
+
+	if (!can_assume(NO_ROLLBACK))
+		*allocated = 1;
+
+	memcpy(new, s, len);
+	return (new - strtab);
+}
+
+int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size)
+{
+	struct fdt_reserve_entry *re;
+	int err;
+
+	FDT_RW_PROBE(fdt);
+
+	re = fdt_mem_rsv_w_(fdt, fdt_num_mem_rsv(fdt));
+	err = fdt_splice_mem_rsv_(fdt, re, 0, 1);
+	if (err)
+		return err;
+
+	re->address = cpu_to_fdt64(address);
+	re->size = cpu_to_fdt64(size);
+	return 0;
+}
+
+int fdt_del_mem_rsv(void *fdt, int n)
+{
+	struct fdt_reserve_entry *re = fdt_mem_rsv_w_(fdt, n);
+
+	FDT_RW_PROBE(fdt);
+
+	if (n >= fdt_num_mem_rsv(fdt))
+		return -FDT_ERR_NOTFOUND;
+
+	return fdt_splice_mem_rsv_(fdt, re, 1, 0);
+}
+
+static int fdt_resize_property_(void *fdt, int nodeoffset, const char *name,
+				int len, struct fdt_property **prop)
+{
+	int oldlen;
+	int err;
+
+	*prop = fdt_get_property_w(fdt, nodeoffset, name, &oldlen);
+	if (!*prop)
+		return oldlen;
+
+	if ((err = fdt_splice_struct_(fdt, (*prop)->data, FDT_TAGALIGN(oldlen),
+				      FDT_TAGALIGN(len))))
+		return err;
+
+	(*prop)->len = cpu_to_fdt32(len);
+	return 0;
+}
+
+static int fdt_add_property_(void *fdt, int nodeoffset, const char *name,
+			     int len, struct fdt_property **prop)
+{
+	int proplen;
+	int nextoffset;
+	int namestroff;
+	int err;
+	int allocated;
+
+	if ((nextoffset = fdt_check_node_offset_(fdt, nodeoffset)) < 0)
+		return nextoffset;
+
+	namestroff = fdt_find_add_string_(fdt, name, &allocated);
+	if (namestroff < 0)
+		return namestroff;
+
+	*prop = fdt_offset_ptr_w_(fdt, nextoffset);
+	proplen = sizeof(**prop) + FDT_TAGALIGN(len);
+
+	err = fdt_splice_struct_(fdt, *prop, 0, proplen);
+	if (err) {
+		/* Delete the string if we failed to add it */
+		if (!can_assume(NO_ROLLBACK) && allocated)
+			fdt_del_last_string_(fdt, name);
+		return err;
+	}
+
+	(*prop)->tag = cpu_to_fdt32(FDT_PROP);
+	(*prop)->nameoff = cpu_to_fdt32(namestroff);
+	(*prop)->len = cpu_to_fdt32(len);
+	return 0;
+}
+
+int fdt_set_name(void *fdt, int nodeoffset, const char *name)
+{
+	char *namep;
+	int oldlen, newlen;
+	int err;
+
+	FDT_RW_PROBE(fdt);
+
+	namep = (char *)(uintptr_t)fdt_get_name(fdt, nodeoffset, &oldlen);
+	if (!namep)
+		return oldlen;
+
+	newlen = strlen(name);
+
+	err = fdt_splice_struct_(fdt, namep, FDT_TAGALIGN(oldlen+1),
+				 FDT_TAGALIGN(newlen+1));
+	if (err)
+		return err;
+
+	memcpy(namep, name, newlen+1);
+	return 0;
+}
+
+int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name,
+			    int len, void **prop_data)
+{
+	struct fdt_property *prop;
+	int err;
+
+	FDT_RW_PROBE(fdt);
+
+	err = fdt_resize_property_(fdt, nodeoffset, name, len, &prop);
+	if (err == -FDT_ERR_NOTFOUND)
+		err = fdt_add_property_(fdt, nodeoffset, name, len, &prop);
+	if (err)
+		return err;
+
+	*prop_data = prop->data;
+	return 0;
+}
+
+int fdt_setprop(void *fdt, int nodeoffset, const char *name,
+		const void *val, int len)
+{
+	void *prop_data;
+	int err;
+
+	err = fdt_setprop_placeholder(fdt, nodeoffset, name, len, &prop_data);
+	if (err)
+		return err;
+
+	if (len)
+		memcpy(prop_data, val, len);
+	return 0;
+}
+
+int fdt_appendprop(void *fdt, int nodeoffset, const char *name,
+		   const void *val, int len)
+{
+	struct fdt_property *prop;
+	int err, oldlen, newlen;
+
+	FDT_RW_PROBE(fdt);
+
+	prop = fdt_get_property_w(fdt, nodeoffset, name, &oldlen);
+	if (prop) {
+		newlen = len + oldlen;
+		err = fdt_splice_struct_(fdt, prop->data,
+					 FDT_TAGALIGN(oldlen),
+					 FDT_TAGALIGN(newlen));
+		if (err)
+			return err;
+		prop->len = cpu_to_fdt32(newlen);
+		memcpy(prop->data + oldlen, val, len);
+	} else {
+		err = fdt_add_property_(fdt, nodeoffset, name, len, &prop);
+		if (err)
+			return err;
+		memcpy(prop->data, val, len);
+	}
+	return 0;
+}
+
+int fdt_delprop(void *fdt, int nodeoffset, const char *name)
+{
+	struct fdt_property *prop;
+	int len, proplen;
+
+	FDT_RW_PROBE(fdt);
+
+	prop = fdt_get_property_w(fdt, nodeoffset, name, &len);
+	if (!prop)
+		return len;
+
+	proplen = sizeof(*prop) + FDT_TAGALIGN(len);
+	return fdt_splice_struct_(fdt, prop, proplen, 0);
+}
+
+int fdt_add_subnode_namelen(void *fdt, int parentoffset,
+			    const char *name, int namelen)
+{
+	struct fdt_node_header *nh;
+	int offset, nextoffset;
+	int nodelen;
+	int err;
+	uint32_t tag;
+	fdt32_t *endtag;
+
+	FDT_RW_PROBE(fdt);
+
+	offset = fdt_subnode_offset_namelen(fdt, parentoffset, name, namelen);
+	if (offset >= 0)
+		return -FDT_ERR_EXISTS;
+	else if (offset != -FDT_ERR_NOTFOUND)
+		return offset;
+
+	/* Try to place the new node after the parent's properties */
+	tag = fdt_next_tag(fdt, parentoffset, &nextoffset);
+	/* the fdt_subnode_offset_namelen() should ensure this never hits */
+	if (!can_assume(LIBFDT_FLAWLESS) && (tag != FDT_BEGIN_NODE))
+		return -FDT_ERR_INTERNAL;
+	do {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+	} while ((tag == FDT_PROP) || (tag == FDT_NOP));
+
+	nh = fdt_offset_ptr_w_(fdt, offset);
+	nodelen = sizeof(*nh) + FDT_TAGALIGN(namelen+1) + FDT_TAGSIZE;
+
+	err = fdt_splice_struct_(fdt, nh, 0, nodelen);
+	if (err)
+		return err;
+
+	nh->tag = cpu_to_fdt32(FDT_BEGIN_NODE);
+	memset(nh->name, 0, FDT_TAGALIGN(namelen+1));
+	memcpy(nh->name, name, namelen);
+	endtag = (fdt32_t *)((char *)nh + nodelen - FDT_TAGSIZE);
+	*endtag = cpu_to_fdt32(FDT_END_NODE);
+
+	return offset;
+}
+
+int fdt_add_subnode(void *fdt, int parentoffset, const char *name)
+{
+	return fdt_add_subnode_namelen(fdt, parentoffset, name, strlen(name));
+}
+
+int fdt_del_node(void *fdt, int nodeoffset)
+{
+	int endoffset;
+
+	FDT_RW_PROBE(fdt);
+
+	endoffset = fdt_node_end_offset_(fdt, nodeoffset);
+	if (endoffset < 0)
+		return endoffset;
+
+	return fdt_splice_struct_(fdt, fdt_offset_ptr_w_(fdt, nodeoffset),
+				  endoffset - nodeoffset, 0);
+}
+
+static void fdt_packblocks_(const char *old, char *new,
+			    int mem_rsv_size,
+			    int struct_size,
+			    int strings_size)
+{
+	int mem_rsv_off, struct_off, strings_off;
+
+	mem_rsv_off = FDT_ALIGN(sizeof(struct fdt_header), 8);
+	struct_off = mem_rsv_off + mem_rsv_size;
+	strings_off = struct_off + struct_size;
+
+	memmove(new + mem_rsv_off, old + fdt_off_mem_rsvmap(old), mem_rsv_size);
+	fdt_set_off_mem_rsvmap(new, mem_rsv_off);
+
+	memmove(new + struct_off, old + fdt_off_dt_struct(old), struct_size);
+	fdt_set_off_dt_struct(new, struct_off);
+	fdt_set_size_dt_struct(new, struct_size);
+
+	memmove(new + strings_off, old + fdt_off_dt_strings(old), strings_size);
+	fdt_set_off_dt_strings(new, strings_off);
+	fdt_set_size_dt_strings(new, fdt_size_dt_strings(old));
+}
+
+int fdt_open_into(const void *fdt, void *buf, int bufsize)
+{
+	int err;
+	int mem_rsv_size, struct_size;
+	int newsize;
+	const char *fdtstart = fdt;
+	const char *fdtend = fdtstart + fdt_totalsize(fdt);
+	char *tmp;
+
+	FDT_RO_PROBE(fdt);
+
+	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
+		* sizeof(struct fdt_reserve_entry);
+
+	if (can_assume(LATEST) || fdt_version(fdt) >= 17) {
+		struct_size = fdt_size_dt_struct(fdt);
+	} else if (fdt_version(fdt) == 16) {
+		struct_size = 0;
+		while (fdt_next_tag(fdt, struct_size, &struct_size) != FDT_END)
+			;
+		if (struct_size < 0)
+			return struct_size;
+	} else {
+		return -FDT_ERR_BADVERSION;
+	}
+
+	if (can_assume(LIBFDT_ORDER) ||
+	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
+		/* no further work necessary */
+		err = fdt_move(fdt, buf, bufsize);
+		if (err)
+			return err;
+		fdt_set_version(buf, 17);
+		fdt_set_size_dt_struct(buf, struct_size);
+		fdt_set_totalsize(buf, bufsize);
+		return 0;
+	}
+
+	/* Need to reorder */
+	newsize = FDT_ALIGN(sizeof(struct fdt_header), 8) + mem_rsv_size
+		+ struct_size + fdt_size_dt_strings(fdt);
+
+	if (bufsize < newsize)
+		return -FDT_ERR_NOSPACE;
+
+	/* First attempt to build converted tree at beginning of buffer */
+	tmp = buf;
+	/* But if that overlaps with the old tree... */
+	if (((tmp + newsize) > fdtstart) && (tmp < fdtend)) {
+		/* Try right after the old tree instead */
+		tmp = (char *)(uintptr_t)fdtend;
+		if ((tmp + newsize) > ((char *)buf + bufsize))
+			return -FDT_ERR_NOSPACE;
+	}
+
+	fdt_packblocks_(fdt, tmp, mem_rsv_size, struct_size,
+			fdt_size_dt_strings(fdt));
+	memmove(buf, tmp, newsize);
+
+	fdt_set_magic(buf, FDT_MAGIC);
+	fdt_set_totalsize(buf, bufsize);
+	fdt_set_version(buf, 17);
+	fdt_set_last_comp_version(buf, 16);
+	fdt_set_boot_cpuid_phys(buf, fdt_boot_cpuid_phys(fdt));
+
+	return 0;
+}
+
+int fdt_pack(void *fdt)
+{
+	int mem_rsv_size;
+
+	FDT_RW_PROBE(fdt);
+
+	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
+		* sizeof(struct fdt_reserve_entry);
+	fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt),
+			fdt_size_dt_strings(fdt));
+	fdt_set_totalsize(fdt, fdt_data_size_(fdt));
+
+	return 0;
+}
diff --git a/libfdt/fdt_strerror.c b/libfdt/fdt_strerror.c
new file mode 100644
index 000000000000..d852b77e81e7
--- /dev/null
+++ b/libfdt/fdt_strerror.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+struct fdt_errtabent {
+	const char *str;
+};
+
+#define FDT_ERRTABENT(val) \
+	[(val)] = { .str = #val, }
+
+static struct fdt_errtabent fdt_errtable[] = {
+	FDT_ERRTABENT(FDT_ERR_NOTFOUND),
+	FDT_ERRTABENT(FDT_ERR_EXISTS),
+	FDT_ERRTABENT(FDT_ERR_NOSPACE),
+
+	FDT_ERRTABENT(FDT_ERR_BADOFFSET),
+	FDT_ERRTABENT(FDT_ERR_BADPATH),
+	FDT_ERRTABENT(FDT_ERR_BADPHANDLE),
+	FDT_ERRTABENT(FDT_ERR_BADSTATE),
+
+	FDT_ERRTABENT(FDT_ERR_TRUNCATED),
+	FDT_ERRTABENT(FDT_ERR_BADMAGIC),
+	FDT_ERRTABENT(FDT_ERR_BADVERSION),
+	FDT_ERRTABENT(FDT_ERR_BADSTRUCTURE),
+	FDT_ERRTABENT(FDT_ERR_BADLAYOUT),
+	FDT_ERRTABENT(FDT_ERR_INTERNAL),
+	FDT_ERRTABENT(FDT_ERR_BADNCELLS),
+	FDT_ERRTABENT(FDT_ERR_BADVALUE),
+	FDT_ERRTABENT(FDT_ERR_BADOVERLAY),
+	FDT_ERRTABENT(FDT_ERR_NOPHANDLES),
+	FDT_ERRTABENT(FDT_ERR_BADFLAGS),
+	FDT_ERRTABENT(FDT_ERR_ALIGNMENT),
+};
+#define FDT_ERRTABSIZE	((int)(sizeof(fdt_errtable) / sizeof(fdt_errtable[0])))
+
+const char *fdt_strerror(int errval)
+{
+	if (errval > 0)
+		return "<valid offset/length>";
+	else if (errval == 0)
+		return "<no error>";
+	else if (-errval < FDT_ERRTABSIZE) {
+		const char *s = fdt_errtable[-errval].str;
+
+		if (s)
+			return s;
+	}
+
+	return "<unknown error>";
+}
diff --git a/libfdt/fdt_sw.c b/libfdt/fdt_sw.c
new file mode 100644
index 000000000000..4c569ee7eb0d
--- /dev/null
+++ b/libfdt/fdt_sw.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+static int fdt_sw_probe_(void *fdt)
+{
+	if (!can_assume(VALID_INPUT)) {
+		if (fdt_magic(fdt) == FDT_MAGIC)
+			return -FDT_ERR_BADSTATE;
+		else if (fdt_magic(fdt) != FDT_SW_MAGIC)
+			return -FDT_ERR_BADMAGIC;
+	}
+
+	return 0;
+}
+
+#define FDT_SW_PROBE(fdt) \
+	{ \
+		int err; \
+		if ((err = fdt_sw_probe_(fdt)) != 0) \
+			return err; \
+	}
+
+/* 'memrsv' state:	Initial state after fdt_create()
+ *
+ * Allowed functions:
+ *	fdt_add_reservemap_entry()
+ *	fdt_finish_reservemap()		[moves to 'struct' state]
+ */
+static int fdt_sw_probe_memrsv_(void *fdt)
+{
+	int err = fdt_sw_probe_(fdt);
+	if (err)
+		return err;
+
+	if (!can_assume(VALID_INPUT) && fdt_off_dt_strings(fdt) != 0)
+		return -FDT_ERR_BADSTATE;
+	return 0;
+}
+
+#define FDT_SW_PROBE_MEMRSV(fdt) \
+	{ \
+		int err; \
+		if ((err = fdt_sw_probe_memrsv_(fdt)) != 0) \
+			return err; \
+	}
+
+/* 'struct' state:	Enter this state after fdt_finish_reservemap()
+ *
+ * Allowed functions:
+ *	fdt_begin_node()
+ *	fdt_end_node()
+ *	fdt_property*()
+ *	fdt_finish()			[moves to 'complete' state]
+ */
+static int fdt_sw_probe_struct_(void *fdt)
+{
+	int err = fdt_sw_probe_(fdt);
+	if (err)
+		return err;
+
+	if (!can_assume(VALID_INPUT) &&
+	    fdt_off_dt_strings(fdt) != fdt_totalsize(fdt))
+		return -FDT_ERR_BADSTATE;
+	return 0;
+}
+
+#define FDT_SW_PROBE_STRUCT(fdt) \
+	{ \
+		int err; \
+		if ((err = fdt_sw_probe_struct_(fdt)) != 0) \
+			return err; \
+	}
+
+static inline uint32_t sw_flags(void *fdt)
+{
+	/* assert: (fdt_magic(fdt) == FDT_SW_MAGIC) */
+	return fdt_last_comp_version(fdt);
+}
+
+/* 'complete' state:	Enter this state after fdt_finish()
+ *
+ * Allowed functions: none
+ */
+
+static void *fdt_grab_space_(void *fdt, size_t len)
+{
+	unsigned int offset = fdt_size_dt_struct(fdt);
+	unsigned int spaceleft;
+
+	spaceleft = fdt_totalsize(fdt) - fdt_off_dt_struct(fdt)
+		- fdt_size_dt_strings(fdt);
+
+	if ((offset + len < offset) || (offset + len > spaceleft))
+		return NULL;
+
+	fdt_set_size_dt_struct(fdt, offset + len);
+	return fdt_offset_ptr_w_(fdt, offset);
+}
+
+int fdt_create_with_flags(void *buf, int bufsize, uint32_t flags)
+{
+	const int hdrsize = FDT_ALIGN(sizeof(struct fdt_header),
+				      sizeof(struct fdt_reserve_entry));
+	void *fdt = buf;
+
+	if (bufsize < hdrsize)
+		return -FDT_ERR_NOSPACE;
+
+	if (flags & ~FDT_CREATE_FLAGS_ALL)
+		return -FDT_ERR_BADFLAGS;
+
+	memset(buf, 0, bufsize);
+
+	/*
+	 * magic and last_comp_version keep intermediate state during the fdt
+	 * creation process, which is replaced with the proper FDT format by
+	 * fdt_finish().
+	 *
+	 * flags should be accessed with sw_flags().
+	 */
+	fdt_set_magic(fdt, FDT_SW_MAGIC);
+	fdt_set_version(fdt, FDT_LAST_SUPPORTED_VERSION);
+	fdt_set_last_comp_version(fdt, flags);
+
+	fdt_set_totalsize(fdt,  bufsize);
+
+	fdt_set_off_mem_rsvmap(fdt, hdrsize);
+	fdt_set_off_dt_struct(fdt, fdt_off_mem_rsvmap(fdt));
+	fdt_set_off_dt_strings(fdt, 0);
+
+	return 0;
+}
+
+int fdt_create(void *buf, int bufsize)
+{
+	return fdt_create_with_flags(buf, bufsize, 0);
+}
+
+int fdt_resize(void *fdt, void *buf, int bufsize)
+{
+	size_t headsize, tailsize;
+	char *oldtail, *newtail;
+
+	FDT_SW_PROBE(fdt);
+
+	if (bufsize < 0)
+		return -FDT_ERR_NOSPACE;
+
+	headsize = fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt);
+	tailsize = fdt_size_dt_strings(fdt);
+
+	if (!can_assume(VALID_DTB) &&
+	    headsize + tailsize > fdt_totalsize(fdt))
+		return -FDT_ERR_INTERNAL;
+
+	if ((headsize + tailsize) > (unsigned)bufsize)
+		return -FDT_ERR_NOSPACE;
+
+	oldtail = (char *)fdt + fdt_totalsize(fdt) - tailsize;
+	newtail = (char *)buf + bufsize - tailsize;
+
+	/* Two cases to avoid clobbering data if the old and new
+	 * buffers partially overlap */
+	if (buf <= fdt) {
+		memmove(buf, fdt, headsize);
+		memmove(newtail, oldtail, tailsize);
+	} else {
+		memmove(newtail, oldtail, tailsize);
+		memmove(buf, fdt, headsize);
+	}
+
+	fdt_set_totalsize(buf, bufsize);
+	if (fdt_off_dt_strings(buf))
+		fdt_set_off_dt_strings(buf, bufsize);
+
+	return 0;
+}
+
+int fdt_add_reservemap_entry(void *fdt, uint64_t addr, uint64_t size)
+{
+	struct fdt_reserve_entry *re;
+	int offset;
+
+	FDT_SW_PROBE_MEMRSV(fdt);
+
+	offset = fdt_off_dt_struct(fdt);
+	if ((offset + sizeof(*re)) > fdt_totalsize(fdt))
+		return -FDT_ERR_NOSPACE;
+
+	re = (struct fdt_reserve_entry *)((char *)fdt + offset);
+	re->address = cpu_to_fdt64(addr);
+	re->size = cpu_to_fdt64(size);
+
+	fdt_set_off_dt_struct(fdt, offset + sizeof(*re));
+
+	return 0;
+}
+
+int fdt_finish_reservemap(void *fdt)
+{
+	int err = fdt_add_reservemap_entry(fdt, 0, 0);
+
+	if (err)
+		return err;
+
+	fdt_set_off_dt_strings(fdt, fdt_totalsize(fdt));
+	return 0;
+}
+
+int fdt_begin_node(void *fdt, const char *name)
+{
+	struct fdt_node_header *nh;
+	int namelen;
+
+	FDT_SW_PROBE_STRUCT(fdt);
+
+	namelen = strlen(name) + 1;
+	nh = fdt_grab_space_(fdt, sizeof(*nh) + FDT_TAGALIGN(namelen));
+	if (! nh)
+		return -FDT_ERR_NOSPACE;
+
+	nh->tag = cpu_to_fdt32(FDT_BEGIN_NODE);
+	memcpy(nh->name, name, namelen);
+	return 0;
+}
+
+int fdt_end_node(void *fdt)
+{
+	fdt32_t *en;
+
+	FDT_SW_PROBE_STRUCT(fdt);
+
+	en = fdt_grab_space_(fdt, FDT_TAGSIZE);
+	if (! en)
+		return -FDT_ERR_NOSPACE;
+
+	*en = cpu_to_fdt32(FDT_END_NODE);
+	return 0;
+}
+
+static int fdt_add_string_(void *fdt, const char *s)
+{
+	char *strtab = (char *)fdt + fdt_totalsize(fdt);
+	unsigned int strtabsize = fdt_size_dt_strings(fdt);
+	unsigned int len = strlen(s) + 1;
+	unsigned int struct_top, offset;
+
+	offset = strtabsize + len;
+	struct_top = fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt);
+	if (fdt_totalsize(fdt) - offset < struct_top)
+		return 0; /* no more room :( */
+
+	memcpy(strtab - offset, s, len);
+	fdt_set_size_dt_strings(fdt, strtabsize + len);
+	return -offset;
+}
+
+/* Must only be used to roll back in case of error */
+static void fdt_del_last_string_(void *fdt, const char *s)
+{
+	int strtabsize = fdt_size_dt_strings(fdt);
+	int len = strlen(s) + 1;
+
+	fdt_set_size_dt_strings(fdt, strtabsize - len);
+}
+
+static int fdt_find_add_string_(void *fdt, const char *s, int *allocated)
+{
+	char *strtab = (char *)fdt + fdt_totalsize(fdt);
+	int strtabsize = fdt_size_dt_strings(fdt);
+	const char *p;
+
+	*allocated = 0;
+
+	p = fdt_find_string_(strtab - strtabsize, strtabsize, s);
+	if (p)
+		return p - strtab;
+
+	*allocated = 1;
+
+	return fdt_add_string_(fdt, s);
+}
+
+int fdt_property_placeholder(void *fdt, const char *name, int len, void **valp)
+{
+	struct fdt_property *prop;
+	int nameoff;
+	int allocated;
+
+	FDT_SW_PROBE_STRUCT(fdt);
+
+	/* String de-duplication can be slow, _NO_NAME_DEDUP skips it */
+	if (sw_flags(fdt) & FDT_CREATE_FLAG_NO_NAME_DEDUP) {
+		allocated = 1;
+		nameoff = fdt_add_string_(fdt, name);
+	} else {
+		nameoff = fdt_find_add_string_(fdt, name, &allocated);
+	}
+	if (nameoff == 0)
+		return -FDT_ERR_NOSPACE;
+
+	prop = fdt_grab_space_(fdt, sizeof(*prop) + FDT_TAGALIGN(len));
+	if (! prop) {
+		if (allocated)
+			fdt_del_last_string_(fdt, name);
+		return -FDT_ERR_NOSPACE;
+	}
+
+	prop->tag = cpu_to_fdt32(FDT_PROP);
+	prop->nameoff = cpu_to_fdt32(nameoff);
+	prop->len = cpu_to_fdt32(len);
+	*valp = prop->data;
+	return 0;
+}
+
+int fdt_property(void *fdt, const char *name, const void *val, int len)
+{
+	void *ptr;
+	int ret;
+
+	ret = fdt_property_placeholder(fdt, name, len, &ptr);
+	if (ret)
+		return ret;
+	memcpy(ptr, val, len);
+	return 0;
+}
+
+int fdt_finish(void *fdt)
+{
+	char *p = (char *)fdt;
+	fdt32_t *end;
+	int oldstroffset, newstroffset;
+	uint32_t tag;
+	int offset, nextoffset;
+
+	FDT_SW_PROBE_STRUCT(fdt);
+
+	/* Add terminator */
+	end = fdt_grab_space_(fdt, sizeof(*end));
+	if (! end)
+		return -FDT_ERR_NOSPACE;
+	*end = cpu_to_fdt32(FDT_END);
+
+	/* Relocate the string table */
+	oldstroffset = fdt_totalsize(fdt) - fdt_size_dt_strings(fdt);
+	newstroffset = fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt);
+	memmove(p + newstroffset, p + oldstroffset, fdt_size_dt_strings(fdt));
+	fdt_set_off_dt_strings(fdt, newstroffset);
+
+	/* Walk the structure, correcting string offsets */
+	offset = 0;
+	while ((tag = fdt_next_tag(fdt, offset, &nextoffset)) != FDT_END) {
+		if (tag == FDT_PROP) {
+			struct fdt_property *prop =
+				fdt_offset_ptr_w_(fdt, offset);
+			int nameoff;
+
+			nameoff = fdt32_to_cpu(prop->nameoff);
+			nameoff += fdt_size_dt_strings(fdt);
+			prop->nameoff = cpu_to_fdt32(nameoff);
+		}
+		offset = nextoffset;
+	}
+	if (nextoffset < 0)
+		return nextoffset;
+
+	/* Finally, adjust the header */
+	fdt_set_totalsize(fdt, newstroffset + fdt_size_dt_strings(fdt));
+
+	/* And fix up fields that were keeping intermediate state. */
+	fdt_set_last_comp_version(fdt, FDT_LAST_COMPATIBLE_VERSION);
+	fdt_set_magic(fdt, FDT_MAGIC);
+
+	return 0;
+}
diff --git a/libfdt/fdt_wip.c b/libfdt/fdt_wip.c
new file mode 100644
index 000000000000..c2d7566a67dc
--- /dev/null
+++ b/libfdt/fdt_wip.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+int fdt_setprop_inplace_namelen_partial(void *fdt, int nodeoffset,
+					const char *name, int namelen,
+					uint32_t idx, const void *val,
+					int len)
+{
+	void *propval;
+	int proplen;
+
+	propval = fdt_getprop_namelen_w(fdt, nodeoffset, name, namelen,
+					&proplen);
+	if (!propval)
+		return proplen;
+
+	if ((unsigned)proplen < (len + idx))
+		return -FDT_ERR_NOSPACE;
+
+	memcpy((char *)propval + idx, val, len);
+	return 0;
+}
+
+int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
+			const void *val, int len)
+{
+	const void *propval;
+	int proplen;
+
+	propval = fdt_getprop(fdt, nodeoffset, name, &proplen);
+	if (!propval)
+		return proplen;
+
+	if (proplen != len)
+		return -FDT_ERR_NOSPACE;
+
+	return fdt_setprop_inplace_namelen_partial(fdt, nodeoffset, name,
+						   strlen(name), 0,
+						   val, len);
+}
+
+static void fdt_nop_region_(void *start, int len)
+{
+	fdt32_t *p;
+
+	for (p = start; (char *)p < ((char *)start + len); p++)
+		*p = cpu_to_fdt32(FDT_NOP);
+}
+
+int fdt_nop_property(void *fdt, int nodeoffset, const char *name)
+{
+	struct fdt_property *prop;
+	int len;
+
+	prop = fdt_get_property_w(fdt, nodeoffset, name, &len);
+	if (!prop)
+		return len;
+
+	fdt_nop_region_(prop, len + sizeof(*prop));
+
+	return 0;
+}
+
+int fdt_node_end_offset_(void *fdt, int offset)
+{
+	int depth = 0;
+
+	while ((offset >= 0) && (depth >= 0))
+		offset = fdt_next_node(fdt, offset, &depth);
+
+	return offset;
+}
+
+int fdt_nop_node(void *fdt, int nodeoffset)
+{
+	int endoffset;
+
+	endoffset = fdt_node_end_offset_(fdt, nodeoffset);
+	if (endoffset < 0)
+		return endoffset;
+
+	fdt_nop_region_(fdt_offset_ptr_w(fdt, nodeoffset, 0),
+			endoffset - nodeoffset);
+	return 0;
+}
diff --git a/libfdt/libfdt.h b/libfdt/libfdt.h
new file mode 100644
index 000000000000..a7f432c80ca6
--- /dev/null
+++ b/libfdt/libfdt.h
@@ -0,0 +1,2147 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+#ifndef LIBFDT_H
+#define LIBFDT_H
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+
+#include <libfdt_env.h>
+#include <fdt.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define FDT_FIRST_SUPPORTED_VERSION	0x02
+#define FDT_LAST_COMPATIBLE_VERSION 0x10
+#define FDT_LAST_SUPPORTED_VERSION	0x11
+
+/* Error codes: informative error codes */
+#define FDT_ERR_NOTFOUND	1
+	/* FDT_ERR_NOTFOUND: The requested node or property does not exist */
+#define FDT_ERR_EXISTS		2
+	/* FDT_ERR_EXISTS: Attempted to create a node or property which
+	 * already exists */
+#define FDT_ERR_NOSPACE		3
+	/* FDT_ERR_NOSPACE: Operation needed to expand the device
+	 * tree, but its buffer did not have sufficient space to
+	 * contain the expanded tree. Use fdt_open_into() to move the
+	 * device tree to a buffer with more space. */
+
+/* Error codes: codes for bad parameters */
+#define FDT_ERR_BADOFFSET	4
+	/* FDT_ERR_BADOFFSET: Function was passed a structure block
+	 * offset which is out-of-bounds, or which points to an
+	 * unsuitable part of the structure for the operation. */
+#define FDT_ERR_BADPATH		5
+	/* FDT_ERR_BADPATH: Function was passed a badly formatted path
+	 * (e.g. missing a leading / for a function which requires an
+	 * absolute path) */
+#define FDT_ERR_BADPHANDLE	6
+	/* FDT_ERR_BADPHANDLE: Function was passed an invalid phandle.
+	 * This can be caused either by an invalid phandle property
+	 * length, or the phandle value was either 0 or -1, which are
+	 * not permitted. */
+#define FDT_ERR_BADSTATE	7
+	/* FDT_ERR_BADSTATE: Function was passed an incomplete device
+	 * tree created by the sequential-write functions, which is
+	 * not sufficiently complete for the requested operation. */
+
+/* Error codes: codes for bad device tree blobs */
+#define FDT_ERR_TRUNCATED	8
+	/* FDT_ERR_TRUNCATED: FDT or a sub-block is improperly
+	 * terminated (overflows, goes outside allowed bounds, or
+	 * isn't properly terminated).  */
+#define FDT_ERR_BADMAGIC	9
+	/* FDT_ERR_BADMAGIC: Given "device tree" appears not to be a
+	 * device tree at all - it is missing the flattened device
+	 * tree magic number. */
+#define FDT_ERR_BADVERSION	10
+	/* FDT_ERR_BADVERSION: Given device tree has a version which
+	 * can't be handled by the requested operation.  For
+	 * read-write functions, this may mean that fdt_open_into() is
+	 * required to convert the tree to the expected version. */
+#define FDT_ERR_BADSTRUCTURE	11
+	/* FDT_ERR_BADSTRUCTURE: Given device tree has a corrupt
+	 * structure block or other serious error (e.g. misnested
+	 * nodes, or subnodes preceding properties). */
+#define FDT_ERR_BADLAYOUT	12
+	/* FDT_ERR_BADLAYOUT: For read-write functions, the given
+	 * device tree has it's sub-blocks in an order that the
+	 * function can't handle (memory reserve map, then structure,
+	 * then strings).  Use fdt_open_into() to reorganize the tree
+	 * into a form suitable for the read-write operations. */
+
+/* "Can't happen" error indicating a bug in libfdt */
+#define FDT_ERR_INTERNAL	13
+	/* FDT_ERR_INTERNAL: libfdt has failed an internal assertion.
+	 * Should never be returned, if it is, it indicates a bug in
+	 * libfdt itself. */
+
+/* Errors in device tree content */
+#define FDT_ERR_BADNCELLS	14
+	/* FDT_ERR_BADNCELLS: Device tree has a #address-cells, #size-cells
+	 * or similar property with a bad format or value */
+
+#define FDT_ERR_BADVALUE	15
+	/* FDT_ERR_BADVALUE: Device tree has a property with an unexpected
+	 * value. For example: a property expected to contain a string list
+	 * is not NUL-terminated within the length of its value. */
+
+#define FDT_ERR_BADOVERLAY	16
+	/* FDT_ERR_BADOVERLAY: The device tree overlay, while
+	 * correctly structured, cannot be applied due to some
+	 * unexpected or missing value, property or node. */
+
+#define FDT_ERR_NOPHANDLES	17
+	/* FDT_ERR_NOPHANDLES: The device tree doesn't have any
+	 * phandle available anymore without causing an overflow */
+
+#define FDT_ERR_BADFLAGS	18
+	/* FDT_ERR_BADFLAGS: The function was passed a flags field that
+	 * contains invalid flags or an invalid combination of flags. */
+
+#define FDT_ERR_ALIGNMENT	19
+	/* FDT_ERR_ALIGNMENT: The device tree base address is not 8-byte
+	 * aligned. */
+
+#define FDT_ERR_MAX		19
+
+/* constants */
+#define FDT_MAX_PHANDLE 0xfffffffe
+	/* Valid values for phandles range from 1 to 2^32-2. */
+
+/**********************************************************************/
+/* Low-level functions (you probably don't need these)                */
+/**********************************************************************/
+
+#ifndef SWIG /* This function is not useful in Python */
+const void *fdt_offset_ptr(const void *fdt, int offset, unsigned int checklen);
+#endif
+static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
+{
+	return (void *)(uintptr_t)fdt_offset_ptr(fdt, offset, checklen);
+}
+
+uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
+
+/*
+ * External helpers to access words from a device tree blob. They're built
+ * to work even with unaligned pointers on platforms (such as ARMv5) that don't
+ * like unaligned loads and stores.
+ */
+static inline uint16_t fdt16_ld(const fdt16_t *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint16_t)bp[0] << 8) | bp[1];
+}
+
+static inline uint32_t fdt32_ld(const fdt32_t *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint32_t)bp[0] << 24)
+		| ((uint32_t)bp[1] << 16)
+		| ((uint32_t)bp[2] << 8)
+		| bp[3];
+}
+
+static inline void fdt32_st(void *property, uint32_t value)
+{
+	uint8_t *bp = (uint8_t *)property;
+
+	bp[0] = value >> 24;
+	bp[1] = (value >> 16) & 0xff;
+	bp[2] = (value >> 8) & 0xff;
+	bp[3] = value & 0xff;
+}
+
+static inline uint64_t fdt64_ld(const fdt64_t *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint64_t)bp[0] << 56)
+		| ((uint64_t)bp[1] << 48)
+		| ((uint64_t)bp[2] << 40)
+		| ((uint64_t)bp[3] << 32)
+		| ((uint64_t)bp[4] << 24)
+		| ((uint64_t)bp[5] << 16)
+		| ((uint64_t)bp[6] << 8)
+		| bp[7];
+}
+
+static inline void fdt64_st(void *property, uint64_t value)
+{
+	uint8_t *bp = (uint8_t *)property;
+
+	bp[0] = value >> 56;
+	bp[1] = (value >> 48) & 0xff;
+	bp[2] = (value >> 40) & 0xff;
+	bp[3] = (value >> 32) & 0xff;
+	bp[4] = (value >> 24) & 0xff;
+	bp[5] = (value >> 16) & 0xff;
+	bp[6] = (value >> 8) & 0xff;
+	bp[7] = value & 0xff;
+}
+
+/**********************************************************************/
+/* Traversal functions                                                */
+/**********************************************************************/
+
+int fdt_next_node(const void *fdt, int offset, int *depth);
+
+/**
+ * fdt_first_subnode() - get offset of first direct subnode
+ * @fdt:	FDT blob
+ * @offset:	Offset of node to check
+ *
+ * Return: offset of first subnode, or -FDT_ERR_NOTFOUND if there is none
+ */
+int fdt_first_subnode(const void *fdt, int offset);
+
+/**
+ * fdt_next_subnode() - get offset of next direct subnode
+ * @fdt:	FDT blob
+ * @offset:	Offset of previous subnode
+ *
+ * After first calling fdt_first_subnode(), call this function repeatedly to
+ * get direct subnodes of a parent node.
+ *
+ * Return: offset of next subnode, or -FDT_ERR_NOTFOUND if there are no more
+ *         subnodes
+ */
+int fdt_next_subnode(const void *fdt, int offset);
+
+/**
+ * fdt_for_each_subnode - iterate over all subnodes of a parent
+ *
+ * @node:	child node (int, lvalue)
+ * @fdt:	FDT blob (const void *)
+ * @parent:	parent node (int)
+ *
+ * This is actually a wrapper around a for loop and would be used like so:
+ *
+ *	fdt_for_each_subnode(node, fdt, parent) {
+ *		Use node
+ *		...
+ *	}
+ *
+ *	if ((node < 0) && (node != -FDT_ERR_NOTFOUND)) {
+ *		Error handling
+ *	}
+ *
+ * Note that this is implemented as a macro and @node is used as
+ * iterator in the loop. The parent variable be constant or even a
+ * literal.
+ */
+#define fdt_for_each_subnode(node, fdt, parent)		\
+	for (node = fdt_first_subnode(fdt, parent);	\
+	     node >= 0;					\
+	     node = fdt_next_subnode(fdt, node))
+
+/**********************************************************************/
+/* General functions                                                  */
+/**********************************************************************/
+#define fdt_get_header(fdt, field) \
+	(fdt32_ld(&((const struct fdt_header *)(fdt))->field))
+#define fdt_magic(fdt)			(fdt_get_header(fdt, magic))
+#define fdt_totalsize(fdt)		(fdt_get_header(fdt, totalsize))
+#define fdt_off_dt_struct(fdt)		(fdt_get_header(fdt, off_dt_struct))
+#define fdt_off_dt_strings(fdt)		(fdt_get_header(fdt, off_dt_strings))
+#define fdt_off_mem_rsvmap(fdt)		(fdt_get_header(fdt, off_mem_rsvmap))
+#define fdt_version(fdt)		(fdt_get_header(fdt, version))
+#define fdt_last_comp_version(fdt)	(fdt_get_header(fdt, last_comp_version))
+#define fdt_boot_cpuid_phys(fdt)	(fdt_get_header(fdt, boot_cpuid_phys))
+#define fdt_size_dt_strings(fdt)	(fdt_get_header(fdt, size_dt_strings))
+#define fdt_size_dt_struct(fdt)		(fdt_get_header(fdt, size_dt_struct))
+
+#define fdt_set_hdr_(name) \
+	static inline void fdt_set_##name(void *fdt, uint32_t val) \
+	{ \
+		struct fdt_header *fdth = (struct fdt_header *)fdt; \
+		fdth->name = cpu_to_fdt32(val); \
+	}
+fdt_set_hdr_(magic);
+fdt_set_hdr_(totalsize);
+fdt_set_hdr_(off_dt_struct);
+fdt_set_hdr_(off_dt_strings);
+fdt_set_hdr_(off_mem_rsvmap);
+fdt_set_hdr_(version);
+fdt_set_hdr_(last_comp_version);
+fdt_set_hdr_(boot_cpuid_phys);
+fdt_set_hdr_(size_dt_strings);
+fdt_set_hdr_(size_dt_struct);
+#undef fdt_set_hdr_
+
+/**
+ * fdt_header_size - return the size of the tree's header
+ * @fdt: pointer to a flattened device tree
+ *
+ * Return: size of DTB header in bytes
+ */
+size_t fdt_header_size(const void *fdt);
+
+/**
+ * fdt_header_size_ - internal function to get header size from a version number
+ * @version: devicetree version number
+ *
+ * Return: size of DTB header in bytes
+ */
+size_t fdt_header_size_(uint32_t version);
+
+/**
+ * fdt_check_header - sanity check a device tree header
+ * @fdt: pointer to data which might be a flattened device tree
+ *
+ * fdt_check_header() checks that the given buffer contains what
+ * appears to be a flattened device tree, and that the header contains
+ * valid information (to the extent that can be determined from the
+ * header alone).
+ *
+ * returns:
+ *     0, if the buffer appears to contain a valid device tree
+ *     -FDT_ERR_BADMAGIC,
+ *     -FDT_ERR_BADVERSION,
+ *     -FDT_ERR_BADSTATE,
+ *     -FDT_ERR_TRUNCATED, standard meanings, as above
+ */
+int fdt_check_header(const void *fdt);
+
+/**
+ * fdt_move - move a device tree around in memory
+ * @fdt: pointer to the device tree to move
+ * @buf: pointer to memory where the device is to be moved
+ * @bufsize: size of the memory space at buf
+ *
+ * fdt_move() relocates, if possible, the device tree blob located at
+ * fdt to the buffer at buf of size bufsize.  The buffer may overlap
+ * with the existing device tree blob at fdt.  Therefore,
+ *     fdt_move(fdt, fdt, fdt_totalsize(fdt))
+ * should always succeed.
+ *
+ * returns:
+ *     0, on success
+ *     -FDT_ERR_NOSPACE, bufsize is insufficient to contain the device tree
+ *     -FDT_ERR_BADMAGIC,
+ *     -FDT_ERR_BADVERSION,
+ *     -FDT_ERR_BADSTATE, standard meanings
+ */
+int fdt_move(const void *fdt, void *buf, int bufsize);
+
+/**********************************************************************/
+/* Read-only functions                                                */
+/**********************************************************************/
+
+int fdt_check_full(const void *fdt, size_t bufsize);
+
+/**
+ * fdt_get_string - retrieve a string from the strings block of a device tree
+ * @fdt: pointer to the device tree blob
+ * @stroffset: offset of the string within the strings block (native endian)
+ * @lenp: optional pointer to return the string's length
+ *
+ * fdt_get_string() retrieves a pointer to a single string from the
+ * strings block of the device tree blob at fdt, and optionally also
+ * returns the string's length in *lenp.
+ *
+ * returns:
+ *     a pointer to the string, on success
+ *     NULL, if stroffset is out of bounds, or doesn't point to a valid string
+ */
+const char *fdt_get_string(const void *fdt, int stroffset, int *lenp);
+
+/**
+ * fdt_string - retrieve a string from the strings block of a device tree
+ * @fdt: pointer to the device tree blob
+ * @stroffset: offset of the string within the strings block (native endian)
+ *
+ * fdt_string() retrieves a pointer to a single string from the
+ * strings block of the device tree blob at fdt.
+ *
+ * returns:
+ *     a pointer to the string, on success
+ *     NULL, if stroffset is out of bounds, or doesn't point to a valid string
+ */
+const char *fdt_string(const void *fdt, int stroffset);
+
+/**
+ * fdt_find_max_phandle - find and return the highest phandle in a tree
+ * @fdt: pointer to the device tree blob
+ * @phandle: return location for the highest phandle value found in the tree
+ *
+ * fdt_find_max_phandle() finds the highest phandle value in the given device
+ * tree. The value returned in @phandle is only valid if the function returns
+ * success.
+ *
+ * returns:
+ *     0 on success or a negative error code on failure
+ */
+int fdt_find_max_phandle(const void *fdt, uint32_t *phandle);
+
+/**
+ * fdt_get_max_phandle - retrieves the highest phandle in a tree
+ * @fdt: pointer to the device tree blob
+ *
+ * fdt_get_max_phandle retrieves the highest phandle in the given
+ * device tree. This will ignore badly formatted phandles, or phandles
+ * with a value of 0 or -1.
+ *
+ * This function is deprecated in favour of fdt_find_max_phandle().
+ *
+ * returns:
+ *      the highest phandle on success
+ *      0, if no phandle was found in the device tree
+ *      -1, if an error occurred
+ */
+static inline uint32_t fdt_get_max_phandle(const void *fdt)
+{
+	uint32_t phandle;
+	int err;
+
+	err = fdt_find_max_phandle(fdt, &phandle);
+	if (err < 0)
+		return (uint32_t)-1;
+
+	return phandle;
+}
+
+/**
+ * fdt_generate_phandle - return a new, unused phandle for a device tree blob
+ * @fdt: pointer to the device tree blob
+ * @phandle: return location for the new phandle
+ *
+ * Walks the device tree blob and looks for the highest phandle value. On
+ * success, the new, unused phandle value (one higher than the previously
+ * highest phandle value in the device tree blob) will be returned in the
+ * @phandle parameter.
+ *
+ * Return: 0 on success or a negative error-code on failure
+ */
+int fdt_generate_phandle(const void *fdt, uint32_t *phandle);
+
+/**
+ * fdt_num_mem_rsv - retrieve the number of memory reserve map entries
+ * @fdt: pointer to the device tree blob
+ *
+ * Returns the number of entries in the device tree blob's memory
+ * reservation map.  This does not include the terminating 0,0 entry
+ * or any other (0,0) entries reserved for expansion.
+ *
+ * returns:
+ *     the number of entries
+ */
+int fdt_num_mem_rsv(const void *fdt);
+
+/**
+ * fdt_get_mem_rsv - retrieve one memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @n: index of reserve map entry
+ * @address: pointer to 64-bit variable to hold the start address
+ * @size: pointer to 64-bit variable to hold the size of the entry
+ *
+ * On success, @address and @size will contain the address and size of
+ * the n-th reserve map entry from the device tree blob, in
+ * native-endian format.
+ *
+ * returns:
+ *     0, on success
+ *     -FDT_ERR_BADMAGIC,
+ *     -FDT_ERR_BADVERSION,
+ *     -FDT_ERR_BADSTATE, standard meanings
+ */
+int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
+
+/**
+ * fdt_subnode_offset_namelen - find a subnode based on substring
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_subnode_offset(), but only examine the first
+ * namelen characters of name for matching the subnode name.  This is
+ * useful for finding subnodes based on a portion of a larger string,
+ * such as a full path.
+ *
+ * Return: offset of the subnode or -FDT_ERR_NOTFOUND if name not found.
+ */
+#ifndef SWIG /* Not available in Python */
+int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
+			       const char *name, int namelen);
+#endif
+/**
+ * fdt_subnode_offset - find a subnode of a given node
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ *
+ * fdt_subnode_offset() finds a subnode of the node at structure block
+ * offset parentoffset with the given name.  name may include a unit
+ * address, in which case fdt_subnode_offset() will find the subnode
+ * with that unit address, or the unit address may be omitted, in
+ * which case fdt_subnode_offset() will find an arbitrary subnode
+ * whose name excluding unit address matches the given name.
+ *
+ * returns:
+ *	structure block offset of the requested subnode (>=0), on success
+ *	-FDT_ERR_NOTFOUND, if the requested subnode does not exist
+ *	-FDT_ERR_BADOFFSET, if parentoffset did not point to an FDT_BEGIN_NODE
+ *		tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
+int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
+
+/**
+ * fdt_path_offset_namelen - find a tree node by its full path
+ * @fdt: pointer to the device tree blob
+ * @path: full path of the node to locate
+ * @namelen: number of characters of path to consider
+ *
+ * Identical to fdt_path_offset(), but only consider the first namelen
+ * characters of path as the path name.
+ *
+ * Return: offset of the node or negative libfdt error value otherwise
+ */
+#ifndef SWIG /* Not available in Python */
+int fdt_path_offset_namelen(const void *fdt, const char *path, int namelen);
+#endif
+
+/**
+ * fdt_path_offset - find a tree node by its full path
+ * @fdt: pointer to the device tree blob
+ * @path: full path of the node to locate
+ *
+ * fdt_path_offset() finds a node of a given path in the device tree.
+ * Each path component may omit the unit address portion, but the
+ * results of this are undefined if any such path component is
+ * ambiguous (that is if there are multiple nodes at the relevant
+ * level matching the given component, differentiated only by unit
+ * address).
+ *
+ * returns:
+ *	structure block offset of the node with the requested path (>=0), on
+ *		success
+ *	-FDT_ERR_BADPATH, given path does not begin with '/' or is invalid
+ *	-FDT_ERR_NOTFOUND, if the requested node does not exist
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
+int fdt_path_offset(const void *fdt, const char *path);
+
+/**
+ * fdt_get_name - retrieve the name of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of the starting node
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_get_name() retrieves the name (including unit address) of the
+ * device tree node at structure block offset nodeoffset.  If lenp is
+ * non-NULL, the length of this name is also returned, in the integer
+ * pointed to by lenp.
+ *
+ * returns:
+ *	pointer to the node's name, on success
+ *		If lenp is non-NULL, *lenp contains the length of that name
+ *			(>=0)
+ *	NULL, on error
+ *		if lenp is non-NULL *lenp contains an error code (<0):
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE
+ *			tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE, standard meanings
+ */
+const char *fdt_get_name(const void *fdt, int nodeoffset, int *lenp);
+
+/**
+ * fdt_first_property_offset - find the offset of a node's first property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of a node
+ *
+ * fdt_first_property_offset() finds the first property of the node at
+ * the given structure block offset.
+ *
+ * returns:
+ *	structure block offset of the property (>=0), on success
+ *	-FDT_ERR_NOTFOUND, if the requested node has no properties
+ *	-FDT_ERR_BADOFFSET, if nodeoffset did not point to an FDT_BEGIN_NODE tag
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
+int fdt_first_property_offset(const void *fdt, int nodeoffset);
+
+/**
+ * fdt_next_property_offset - step through a node's properties
+ * @fdt: pointer to the device tree blob
+ * @offset: structure block offset of a property
+ *
+ * fdt_next_property_offset() finds the property immediately after the
+ * one at the given structure block offset.  This will be a property
+ * of the same node as the given property.
+ *
+ * returns:
+ *	structure block offset of the next property (>=0), on success
+ *	-FDT_ERR_NOTFOUND, if the given property is the last in its node
+ *	-FDT_ERR_BADOFFSET, if nodeoffset did not point to an FDT_PROP tag
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
+int fdt_next_property_offset(const void *fdt, int offset);
+
+/**
+ * fdt_for_each_property_offset - iterate over all properties of a node
+ *
+ * @property:	property offset (int, lvalue)
+ * @fdt:	FDT blob (const void *)
+ * @node:	node offset (int)
+ *
+ * This is actually a wrapper around a for loop and would be used like so:
+ *
+ *	fdt_for_each_property_offset(property, fdt, node) {
+ *		Use property
+ *		...
+ *	}
+ *
+ *	if ((property < 0) && (property != -FDT_ERR_NOTFOUND)) {
+ *		Error handling
+ *	}
+ *
+ * Note that this is implemented as a macro and property is used as
+ * iterator in the loop. The node variable can be constant or even a
+ * literal.
+ */
+#define fdt_for_each_property_offset(property, fdt, node)	\
+	for (property = fdt_first_property_offset(fdt, node);	\
+	     property >= 0;					\
+	     property = fdt_next_property_offset(fdt, property))
+
+/**
+ * fdt_get_property_by_offset - retrieve the property at a given offset
+ * @fdt: pointer to the device tree blob
+ * @offset: offset of the property to retrieve
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_get_property_by_offset() retrieves a pointer to the
+ * fdt_property structure within the device tree blob at the given
+ * offset.  If lenp is non-NULL, the length of the property value is
+ * also returned, in the integer pointed to by lenp.
+ *
+ * Note that this code only works on device tree versions >= 16. fdt_getprop()
+ * works on all versions.
+ *
+ * returns:
+ *	pointer to the structure representing the property
+ *		if lenp is non-NULL, *lenp contains the length of the property
+ *		value (>=0)
+ *	NULL, on error
+ *		if lenp is non-NULL, *lenp contains an error code (<0):
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_PROP tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE,
+ *		-FDT_ERR_BADSTRUCTURE,
+ *		-FDT_ERR_TRUNCATED, standard meanings
+ */
+const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
+						      int offset,
+						      int *lenp);
+
+/**
+ * fdt_get_property_namelen - find a property based on substring
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @namelen: number of characters of name to consider
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * Identical to fdt_get_property(), but only examine the first namelen
+ * characters of name for matching the property name.
+ *
+ * Return: pointer to the structure representing the property, or NULL
+ *         if not found
+ */
+#ifndef SWIG /* Not available in Python */
+const struct fdt_property *fdt_get_property_namelen(const void *fdt,
+						    int nodeoffset,
+						    const char *name,
+						    int namelen, int *lenp);
+#endif
+
+/**
+ * fdt_get_property - find a given property in a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_get_property() retrieves a pointer to the fdt_property
+ * structure within the device tree blob corresponding to the property
+ * named 'name' of the node at offset nodeoffset.  If lenp is
+ * non-NULL, the length of the property value is also returned, in the
+ * integer pointed to by lenp.
+ *
+ * returns:
+ *	pointer to the structure representing the property
+ *		if lenp is non-NULL, *lenp contains the length of the property
+ *		value (>=0)
+ *	NULL, on error
+ *		if lenp is non-NULL, *lenp contains an error code (<0):
+ *		-FDT_ERR_NOTFOUND, node does not have named property
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE
+ *			tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE,
+ *		-FDT_ERR_BADSTRUCTURE,
+ *		-FDT_ERR_TRUNCATED, standard meanings
+ */
+const struct fdt_property *fdt_get_property(const void *fdt, int nodeoffset,
+					    const char *name, int *lenp);
+static inline struct fdt_property *fdt_get_property_w(void *fdt, int nodeoffset,
+						      const char *name,
+						      int *lenp)
+{
+	return (struct fdt_property *)(uintptr_t)
+		fdt_get_property(fdt, nodeoffset, name, lenp);
+}
+
+/**
+ * fdt_getprop_by_offset - retrieve the value of a property at a given offset
+ * @fdt: pointer to the device tree blob
+ * @offset: offset of the property to read
+ * @namep: pointer to a string variable (will be overwritten) or NULL
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_getprop_by_offset() retrieves a pointer to the value of the
+ * property at structure block offset 'offset' (this will be a pointer
+ * to within the device blob itself, not a copy of the value).  If
+ * lenp is non-NULL, the length of the property value is also
+ * returned, in the integer pointed to by lenp.  If namep is non-NULL,
+ * the property's namne will also be returned in the char * pointed to
+ * by namep (this will be a pointer to within the device tree's string
+ * block, not a new copy of the name).
+ *
+ * returns:
+ *	pointer to the property's value
+ *		if lenp is non-NULL, *lenp contains the length of the property
+ *		value (>=0)
+ *		if namep is non-NULL *namep contiains a pointer to the property
+ *		name.
+ *	NULL, on error
+ *		if lenp is non-NULL, *lenp contains an error code (<0):
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_PROP tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE,
+ *		-FDT_ERR_BADSTRUCTURE,
+ *		-FDT_ERR_TRUNCATED, standard meanings
+ */
+#ifndef SWIG /* This function is not useful in Python */
+const void *fdt_getprop_by_offset(const void *fdt, int offset,
+				  const char **namep, int *lenp);
+#endif
+
+/**
+ * fdt_getprop_namelen - get property value based on substring
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @namelen: number of characters of name to consider
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * Identical to fdt_getprop(), but only examine the first namelen
+ * characters of name for matching the property name.
+ *
+ * Return: pointer to the property's value or NULL on error
+ */
+#ifndef SWIG /* Not available in Python */
+const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
+				const char *name, int namelen, int *lenp);
+static inline void *fdt_getprop_namelen_w(void *fdt, int nodeoffset,
+					  const char *name, int namelen,
+					  int *lenp)
+{
+	return (void *)(uintptr_t)fdt_getprop_namelen(fdt, nodeoffset, name,
+						      namelen, lenp);
+}
+#endif
+
+/**
+ * fdt_getprop - retrieve the value of a given property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_getprop() retrieves a pointer to the value of the property
+ * named @name of the node at offset @nodeoffset (this will be a
+ * pointer to within the device blob itself, not a copy of the value).
+ * If @lenp is non-NULL, the length of the property value is also
+ * returned, in the integer pointed to by @lenp.
+ *
+ * returns:
+ *	pointer to the property's value
+ *		if lenp is non-NULL, *lenp contains the length of the property
+ *		value (>=0)
+ *	NULL, on error
+ *		if lenp is non-NULL, *lenp contains an error code (<0):
+ *		-FDT_ERR_NOTFOUND, node does not have named property
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE
+ *			tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE,
+ *		-FDT_ERR_BADSTRUCTURE,
+ *		-FDT_ERR_TRUNCATED, standard meanings
+ */
+const void *fdt_getprop(const void *fdt, int nodeoffset,
+			const char *name, int *lenp);
+static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
+				  const char *name, int *lenp)
+{
+	return (void *)(uintptr_t)fdt_getprop(fdt, nodeoffset, name, lenp);
+}
+
+/**
+ * fdt_get_phandle - retrieve the phandle of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of the node
+ *
+ * fdt_get_phandle() retrieves the phandle of the device tree node at
+ * structure block offset nodeoffset.
+ *
+ * returns:
+ *	the phandle of the node at nodeoffset, on success (!= 0, != -1)
+ *	0, if the node has no phandle, or another error occurs
+ */
+uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
+
+/**
+ * fdt_get_alias_namelen - get alias based on substring
+ * @fdt: pointer to the device tree blob
+ * @name: name of the alias th look up
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_get_alias(), but only examine the first @namelen
+ * characters of @name for matching the alias name.
+ *
+ * Return: a pointer to the expansion of the alias named @name, if it exists,
+ *	   NULL otherwise
+ */
+#ifndef SWIG /* Not available in Python */
+const char *fdt_get_alias_namelen(const void *fdt,
+				  const char *name, int namelen);
+#endif
+
+/**
+ * fdt_get_alias - retrieve the path referenced by a given alias
+ * @fdt: pointer to the device tree blob
+ * @name: name of the alias th look up
+ *
+ * fdt_get_alias() retrieves the value of a given alias.  That is, the
+ * value of the property named @name in the node /aliases.
+ *
+ * returns:
+ *	a pointer to the expansion of the alias named 'name', if it exists
+ *	NULL, if the given alias or the /aliases node does not exist
+ */
+const char *fdt_get_alias(const void *fdt, const char *name);
+
+/**
+ * fdt_get_path - determine the full path of a node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose path to find
+ * @buf: character buffer to contain the returned path (will be overwritten)
+ * @buflen: size of the character buffer at buf
+ *
+ * fdt_get_path() computes the full path of the node at offset
+ * nodeoffset, and records that path in the buffer at buf.
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset.
+ *
+ * returns:
+ *	0, on success
+ *		buf contains the absolute path of the node at
+ *		nodeoffset, as a NUL-terminated string.
+ *	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_NOSPACE, the path of the given node is longer than (bufsize-1)
+ *		characters and will not fit in the given buffer.
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
+
+/**
+ * fdt_supernode_atdepth_offset - find a specific ancestor of a node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose parent to find
+ * @supernodedepth: depth of the ancestor to find
+ * @nodedepth: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_supernode_atdepth_offset() finds an ancestor of the given node
+ * at a specific depth from the root (where the root itself has depth
+ * 0, its immediate subnodes depth 1 and so forth).  So
+ *	fdt_supernode_atdepth_offset(fdt, nodeoffset, 0, NULL);
+ * will always return 0, the offset of the root node.  If the node at
+ * nodeoffset has depth D, then:
+ *	fdt_supernode_atdepth_offset(fdt, nodeoffset, D, NULL);
+ * will return nodeoffset itself.
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset.
+ *
+ * returns:
+ *	structure block offset of the node at node offset's ancestor
+ *		of depth supernodedepth (>=0), on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_NOTFOUND, supernodedepth was greater than the depth of
+ *		nodeoffset
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
+				 int supernodedepth, int *nodedepth);
+
+/**
+ * fdt_node_depth - find the depth of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose parent to find
+ *
+ * fdt_node_depth() finds the depth of a given node.  The root node
+ * has depth 0, its immediate subnodes depth 1 and so forth.
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset.
+ *
+ * returns:
+ *	depth of the node at nodeoffset (>=0), on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_node_depth(const void *fdt, int nodeoffset);
+
+/**
+ * fdt_parent_offset - find the parent of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose parent to find
+ *
+ * fdt_parent_offset() locates the parent node of a given node (that
+ * is, it finds the offset of the node which contains the node at
+ * nodeoffset as a subnode).
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset, *twice*.
+ *
+ * returns:
+ *	structure block offset of the parent of the node at nodeoffset
+ *		(>=0), on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_parent_offset(const void *fdt, int nodeoffset);
+
+/**
+ * fdt_node_offset_by_prop_value - find nodes with a given property value
+ * @fdt: pointer to the device tree blob
+ * @startoffset: only find nodes after this offset
+ * @propname: property name to check
+ * @propval: property value to search for
+ * @proplen: length of the value in propval
+ *
+ * fdt_node_offset_by_prop_value() returns the offset of the first
+ * node after startoffset, which has a property named propname whose
+ * value is of length proplen and has value equal to propval; or if
+ * startoffset is -1, the very first such node in the tree.
+ *
+ * To iterate through all nodes matching the criterion, the following
+ * idiom can be used:
+ *	offset = fdt_node_offset_by_prop_value(fdt, -1, propname,
+ *					       propval, proplen);
+ *	while (offset != -FDT_ERR_NOTFOUND) {
+ *		// other code here
+ *		offset = fdt_node_offset_by_prop_value(fdt, offset, propname,
+ *						       propval, proplen);
+ *	}
+ *
+ * Note the -1 in the first call to the function, if 0 is used here
+ * instead, the function will never locate the root node, even if it
+ * matches the criterion.
+ *
+ * returns:
+ *	structure block offset of the located node (>= 0, >startoffset),
+ *		 on success
+ *	-FDT_ERR_NOTFOUND, no node matching the criterion exists in the
+ *		tree after startoffset
+ *	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
+				  const char *propname,
+				  const void *propval, int proplen);
+
+/**
+ * fdt_node_offset_by_phandle - find the node with a given phandle
+ * @fdt: pointer to the device tree blob
+ * @phandle: phandle value
+ *
+ * fdt_node_offset_by_phandle() returns the offset of the node
+ * which has the given phandle value.  If there is more than one node
+ * in the tree with the given phandle (an invalid tree), results are
+ * undefined.
+ *
+ * returns:
+ *	structure block offset of the located node (>= 0), on success
+ *	-FDT_ERR_NOTFOUND, no node with that phandle exists
+ *	-FDT_ERR_BADPHANDLE, given phandle value was invalid (0 or -1)
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle);
+
+/**
+ * fdt_node_check_compatible - check a node's compatible property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of a tree node
+ * @compatible: string to match against
+ *
+ * fdt_node_check_compatible() returns 0 if the given node contains a
+ * @compatible property with the given string as one of its elements,
+ * it returns non-zero otherwise, or on error.
+ *
+ * returns:
+ *	0, if the node has a 'compatible' property listing the given string
+ *	1, if the node has a 'compatible' property, but it does not list
+ *		the given string
+ *	-FDT_ERR_NOTFOUND, if the given node has no 'compatible' property
+ *	-FDT_ERR_BADOFFSET, if nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_node_check_compatible(const void *fdt, int nodeoffset,
+			      const char *compatible);
+
+/**
+ * fdt_node_offset_by_compatible - find nodes with a given 'compatible' value
+ * @fdt: pointer to the device tree blob
+ * @startoffset: only find nodes after this offset
+ * @compatible: 'compatible' string to match against
+ *
+ * fdt_node_offset_by_compatible() returns the offset of the first
+ * node after startoffset, which has a 'compatible' property which
+ * lists the given compatible string; or if startoffset is -1, the
+ * very first such node in the tree.
+ *
+ * To iterate through all nodes matching the criterion, the following
+ * idiom can be used:
+ *	offset = fdt_node_offset_by_compatible(fdt, -1, compatible);
+ *	while (offset != -FDT_ERR_NOTFOUND) {
+ *		// other code here
+ *		offset = fdt_node_offset_by_compatible(fdt, offset, compatible);
+ *	}
+ *
+ * Note the -1 in the first call to the function, if 0 is used here
+ * instead, the function will never locate the root node, even if it
+ * matches the criterion.
+ *
+ * returns:
+ *	structure block offset of the located node (>= 0, >startoffset),
+ *		 on success
+ *	-FDT_ERR_NOTFOUND, no node matching the criterion exists in the
+ *		tree after startoffset
+ *	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
+				  const char *compatible);
+
+/**
+ * fdt_stringlist_contains - check a string list property for a string
+ * @strlist: Property containing a list of strings to check
+ * @listlen: Length of property
+ * @str: String to search for
+ *
+ * This is a utility function provided for convenience. The list contains
+ * one or more strings, each terminated by \0, as is found in a device tree
+ * "compatible" property.
+ *
+ * Return: 1 if the string is found in the list, 0 not found, or invalid list
+ */
+int fdt_stringlist_contains(const char *strlist, int listlen, const char *str);
+
+/**
+ * fdt_stringlist_count - count the number of strings in a string list
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of a tree node
+ * @property: name of the property containing the string list
+ *
+ * Return:
+ *   the number of strings in the given property
+ *   -FDT_ERR_BADVALUE if the property value is not NUL-terminated
+ *   -FDT_ERR_NOTFOUND if the property does not exist
+ */
+int fdt_stringlist_count(const void *fdt, int nodeoffset, const char *property);
+
+/**
+ * fdt_stringlist_search - find a string in a string list and return its index
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of a tree node
+ * @property: name of the property containing the string list
+ * @string: string to look up in the string list
+ *
+ * Note that it is possible for this function to succeed on property values
+ * that are not NUL-terminated. That's because the function will stop after
+ * finding the first occurrence of @string. This can for example happen with
+ * small-valued cell properties, such as #address-cells, when searching for
+ * the empty string.
+ *
+ * return:
+ *   the index of the string in the list of strings
+ *   -FDT_ERR_BADVALUE if the property value is not NUL-terminated
+ *   -FDT_ERR_NOTFOUND if the property does not exist or does not contain
+ *                     the given string
+ */
+int fdt_stringlist_search(const void *fdt, int nodeoffset, const char *property,
+			  const char *string);
+
+/**
+ * fdt_stringlist_get() - obtain the string at a given index in a string list
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of a tree node
+ * @property: name of the property containing the string list
+ * @index: index of the string to return
+ * @lenp: return location for the string length or an error code on failure
+ *
+ * Note that this will successfully extract strings from properties with
+ * non-NUL-terminated values. For example on small-valued cell properties
+ * this function will return the empty string.
+ *
+ * If non-NULL, the length of the string (on success) or a negative error-code
+ * (on failure) will be stored in the integer pointer to by lenp.
+ *
+ * Return:
+ *   A pointer to the string at the given index in the string list or NULL on
+ *   failure. On success the length of the string will be stored in the memory
+ *   location pointed to by the lenp parameter, if non-NULL. On failure one of
+ *   the following negative error codes will be returned in the lenp parameter
+ *   (if non-NULL):
+ *     -FDT_ERR_BADVALUE if the property value is not NUL-terminated
+ *     -FDT_ERR_NOTFOUND if the property does not exist
+ */
+const char *fdt_stringlist_get(const void *fdt, int nodeoffset,
+			       const char *property, int index,
+			       int *lenp);
+
+/**********************************************************************/
+/* Read-only functions (addressing related)                           */
+/**********************************************************************/
+
+/**
+ * FDT_MAX_NCELLS - maximum value for #address-cells and #size-cells
+ *
+ * This is the maximum value for #address-cells, #size-cells and
+ * similar properties that will be processed by libfdt.  IEE1275
+ * requires that OF implementations handle values up to 4.
+ * Implementations may support larger values, but in practice higher
+ * values aren't used.
+ */
+#define FDT_MAX_NCELLS		4
+
+/**
+ * fdt_address_cells - retrieve address size for a bus represented in the tree
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to find the address size for
+ *
+ * When the node has a valid #address-cells property, returns its value.
+ *
+ * returns:
+ *	0 <= n < FDT_MAX_NCELLS, on success
+ *      2, if the node has no #address-cells property
+ *      -FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
+ *		#address-cells property
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_address_cells(const void *fdt, int nodeoffset);
+
+/**
+ * fdt_size_cells - retrieve address range size for a bus represented in the
+ *                  tree
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to find the address range size for
+ *
+ * When the node has a valid #size-cells property, returns its value.
+ *
+ * returns:
+ *	0 <= n < FDT_MAX_NCELLS, on success
+ *      1, if the node has no #size-cells property
+ *      -FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
+ *		#size-cells property
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_size_cells(const void *fdt, int nodeoffset);
+
+
+/**********************************************************************/
+/* Write-in-place functions                                           */
+/**********************************************************************/
+
+/**
+ * fdt_setprop_inplace_namelen_partial - change a property's value,
+ *                                       but not its size
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @namelen: number of characters of name to consider
+ * @idx: index of the property to change in the array
+ * @val: pointer to data to replace the property value with
+ * @len: length of the property value
+ *
+ * Identical to fdt_setprop_inplace(), but modifies the given property
+ * starting from the given index, and using only the first characters
+ * of the name. It is useful when you want to manipulate only one value of
+ * an array and you have a string that doesn't end with \0.
+ *
+ * Return: 0 on success, negative libfdt error value otherwise
+ */
+#ifndef SWIG /* Not available in Python */
+int fdt_setprop_inplace_namelen_partial(void *fdt, int nodeoffset,
+					const char *name, int namelen,
+					uint32_t idx, const void *val,
+					int len);
+#endif
+
+/**
+ * fdt_setprop_inplace - change a property's value, but not its size
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: pointer to data to replace the property value with
+ * @len: length of the property value
+ *
+ * fdt_setprop_inplace() replaces the value of a given property with
+ * the data in val, of length len.  This function cannot change the
+ * size of a property, and so will only work if len is equal to the
+ * current length of the property.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the given property value, and will not alter or move any other part
+ * of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, if len is not equal to the property's current length
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+#ifndef SWIG /* Not available in Python */
+int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
+			const void *val, int len);
+#endif
+
+/**
+ * fdt_setprop_inplace_u32 - change the value of a 32-bit integer property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value to replace the property with
+ *
+ * fdt_setprop_inplace_u32() replaces the value of a given property
+ * with the 32-bit integer value in val, converting val to big-endian
+ * if necessary.  This function cannot change the size of a property,
+ * and so will only work if the property already exists and has length
+ * 4.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the given property value, and will not alter or move any other part
+ * of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, if the property's length is not equal to 4
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+static inline int fdt_setprop_inplace_u32(void *fdt, int nodeoffset,
+					  const char *name, uint32_t val)
+{
+	fdt32_t tmp = cpu_to_fdt32(val);
+	return fdt_setprop_inplace(fdt, nodeoffset, name, &tmp, sizeof(tmp));
+}
+
+/**
+ * fdt_setprop_inplace_u64 - change the value of a 64-bit integer property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 64-bit integer value to replace the property with
+ *
+ * fdt_setprop_inplace_u64() replaces the value of a given property
+ * with the 64-bit integer value in val, converting val to big-endian
+ * if necessary.  This function cannot change the size of a property,
+ * and so will only work if the property already exists and has length
+ * 8.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the given property value, and will not alter or move any other part
+ * of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, if the property's length is not equal to 8
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+static inline int fdt_setprop_inplace_u64(void *fdt, int nodeoffset,
+					  const char *name, uint64_t val)
+{
+	fdt64_t tmp = cpu_to_fdt64(val);
+	return fdt_setprop_inplace(fdt, nodeoffset, name, &tmp, sizeof(tmp));
+}
+
+/**
+ * fdt_setprop_inplace_cell - change the value of a single-cell property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node containing the property
+ * @name: name of the property to change the value of
+ * @val: new value of the 32-bit cell
+ *
+ * This is an alternative name for fdt_setprop_inplace_u32()
+ * Return: 0 on success, negative libfdt error number otherwise.
+ */
+static inline int fdt_setprop_inplace_cell(void *fdt, int nodeoffset,
+					   const char *name, uint32_t val)
+{
+	return fdt_setprop_inplace_u32(fdt, nodeoffset, name, val);
+}
+
+/**
+ * fdt_nop_property - replace a property with nop tags
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to nop
+ * @name: name of the property to nop
+ *
+ * fdt_nop_property() will replace a given property's representation
+ * in the blob with FDT_NOP tags, effectively removing it from the
+ * tree.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the property, and will not alter or move any other part of the
+ * tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_nop_node - replace a node (subtree) with nop tags
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to nop
+ *
+ * fdt_nop_node() will replace a given node's representation in the
+ * blob, including all its subnodes, if any, with FDT_NOP tags,
+ * effectively removing it from the tree.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the node and its properties and subnodes, and will not alter or
+ * move any other part of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_nop_node(void *fdt, int nodeoffset);
+
+/**********************************************************************/
+/* Sequential write functions                                         */
+/**********************************************************************/
+
+/* fdt_create_with_flags flags */
+#define FDT_CREATE_FLAG_NO_NAME_DEDUP 0x1
+	/* FDT_CREATE_FLAG_NO_NAME_DEDUP: Do not try to de-duplicate property
+	 * names in the fdt. This can result in faster creation times, but
+	 * a larger fdt. */
+
+#define FDT_CREATE_FLAGS_ALL	(FDT_CREATE_FLAG_NO_NAME_DEDUP)
+
+/**
+ * fdt_create_with_flags - begin creation of a new fdt
+ * @buf: pointer to memory allocated where fdt will be created
+ * @bufsize: size of the memory space at fdt
+ * @flags: a valid combination of FDT_CREATE_FLAG_ flags, or 0.
+ *
+ * fdt_create_with_flags() begins the process of creating a new fdt with
+ * the sequential write interface.
+ *
+ * fdt creation process must end with fdt_finished() to produce a valid fdt.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, bufsize is insufficient for a minimal fdt
+ *	-FDT_ERR_BADFLAGS, flags is not valid
+ */
+int fdt_create_with_flags(void *buf, int bufsize, uint32_t flags);
+
+/**
+ * fdt_create - begin creation of a new fdt
+ * @buf: pointer to memory allocated where fdt will be created
+ * @bufsize: size of the memory space at fdt
+ *
+ * fdt_create() is equivalent to fdt_create_with_flags() with flags=0.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, bufsize is insufficient for a minimal fdt
+ */
+int fdt_create(void *buf, int bufsize);
+
+int fdt_resize(void *fdt, void *buf, int bufsize);
+int fdt_add_reservemap_entry(void *fdt, uint64_t addr, uint64_t size);
+int fdt_finish_reservemap(void *fdt);
+int fdt_begin_node(void *fdt, const char *name);
+int fdt_property(void *fdt, const char *name, const void *val, int len);
+static inline int fdt_property_u32(void *fdt, const char *name, uint32_t val)
+{
+	fdt32_t tmp = cpu_to_fdt32(val);
+	return fdt_property(fdt, name, &tmp, sizeof(tmp));
+}
+static inline int fdt_property_u64(void *fdt, const char *name, uint64_t val)
+{
+	fdt64_t tmp = cpu_to_fdt64(val);
+	return fdt_property(fdt, name, &tmp, sizeof(tmp));
+}
+
+#ifndef SWIG /* Not available in Python */
+static inline int fdt_property_cell(void *fdt, const char *name, uint32_t val)
+{
+	return fdt_property_u32(fdt, name, val);
+}
+#endif
+
+/**
+ * fdt_property_placeholder - add a new property and return a ptr to its value
+ *
+ * @fdt: pointer to the device tree blob
+ * @name: name of property to add
+ * @len: length of property value in bytes
+ * @valp: returns a pointer to where where the value should be placed
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_NOSPACE, standard meanings
+ */
+int fdt_property_placeholder(void *fdt, const char *name, int len, void **valp);
+
+#define fdt_property_string(fdt, name, str) \
+	fdt_property(fdt, name, str, strlen(str)+1)
+int fdt_end_node(void *fdt);
+int fdt_finish(void *fdt);
+
+/**********************************************************************/
+/* Read-write functions                                               */
+/**********************************************************************/
+
+int fdt_create_empty_tree(void *buf, int bufsize);
+int fdt_open_into(const void *fdt, void *buf, int bufsize);
+int fdt_pack(void *fdt);
+
+/**
+ * fdt_add_mem_rsv - add one memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @address: 64-bit start address of the reserve map entry
+ * @size: 64-bit size of the reserved region
+ *
+ * Adds a reserve map entry to the given blob reserving a region at
+ * address address of length size.
+ *
+ * This function will insert data into the reserve map and will
+ * therefore change the indexes of some entries in the table.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new reservation entry
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
+
+/**
+ * fdt_del_mem_rsv - remove a memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @n: entry to remove
+ *
+ * fdt_del_mem_rsv() removes the n-th memory reserve map entry from
+ * the blob.
+ *
+ * This function will delete data from the reservation table and will
+ * therefore change the indexes of some entries in the table.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, there is no entry of the given index (i.e. there
+ *		are less than n+1 reserve map entries)
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_del_mem_rsv(void *fdt, int n);
+
+/**
+ * fdt_set_name - change the name of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of a node
+ * @name: name to give the node
+ *
+ * fdt_set_name() replaces the name (including unit address, if any)
+ * of the given node with the given string.  NOTE: this function can't
+ * efficiently check if the new name is unique amongst the given
+ * node's siblings; results are undefined if this function is invoked
+ * with a name equal to one of the given node's siblings.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob
+ *		to contain the new name
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE, standard meanings
+ */
+int fdt_set_name(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_setprop - create or change a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: pointer to data to set the property value to
+ * @len: length of the property value
+ *
+ * fdt_setprop() sets the value of the named property in the given
+ * node to the given value and length, creating the property if it
+ * does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_setprop(void *fdt, int nodeoffset, const char *name,
+		const void *val, int len);
+
+/**
+ * fdt_setprop_placeholder - allocate space for a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @len: length of the property value
+ * @prop_data: return pointer to property data
+ *
+ * fdt_setprop_placeholer() allocates the named property in the given node.
+ * If the property exists it is resized. In either case a pointer to the
+ * property data is returned.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name,
+			    int len, void **prop_data);
+
+/**
+ * fdt_setprop_u32 - set a property to a 32-bit integer
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value for the property (native endian)
+ *
+ * fdt_setprop_u32() sets the value of the named property in the given
+ * node to the given 32-bit integer value (converting to big-endian if
+ * necessary), or creates a new property with that value if it does
+ * not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+static inline int fdt_setprop_u32(void *fdt, int nodeoffset, const char *name,
+				  uint32_t val)
+{
+	fdt32_t tmp = cpu_to_fdt32(val);
+	return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
+}
+
+/**
+ * fdt_setprop_u64 - set a property to a 64-bit integer
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 64-bit integer value for the property (native endian)
+ *
+ * fdt_setprop_u64() sets the value of the named property in the given
+ * node to the given 64-bit integer value (converting to big-endian if
+ * necessary), or creates a new property with that value if it does
+ * not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+static inline int fdt_setprop_u64(void *fdt, int nodeoffset, const char *name,
+				  uint64_t val)
+{
+	fdt64_t tmp = cpu_to_fdt64(val);
+	return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
+}
+
+/**
+ * fdt_setprop_cell - set a property to a single cell value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value for the property (native endian)
+ *
+ * This is an alternative name for fdt_setprop_u32()
+ *
+ * Return: 0 on success, negative libfdt error value otherwise.
+ */
+static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
+				   uint32_t val)
+{
+	return fdt_setprop_u32(fdt, nodeoffset, name, val);
+}
+
+/**
+ * fdt_setprop_string - set a property to a string value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @str: string value for the property
+ *
+ * fdt_setprop_string() sets the value of the named property in the
+ * given node to the given string value (using the length of the
+ * string to determine the new length of the property), or creates a
+ * new property with that value if it does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+#define fdt_setprop_string(fdt, nodeoffset, name, str) \
+	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
+
+
+/**
+ * fdt_setprop_empty - set a property to an empty value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ *
+ * fdt_setprop_empty() sets the value of the named property in the
+ * given node to an empty (zero length) value, or creates a new empty
+ * property if it does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+#define fdt_setprop_empty(fdt, nodeoffset, name) \
+	fdt_setprop((fdt), (nodeoffset), (name), NULL, 0)
+
+/**
+ * fdt_appendprop - append to or create a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to append to
+ * @val: pointer to data to append to the property value
+ * @len: length of the data to append to the property value
+ *
+ * fdt_appendprop() appends the value to the named property in the
+ * given node, creating the property if it does not already exist.
+ *
+ * This function may insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_appendprop(void *fdt, int nodeoffset, const char *name,
+		   const void *val, int len);
+
+/**
+ * fdt_appendprop_u32 - append a 32-bit integer value to a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value to append to the property (native endian)
+ *
+ * fdt_appendprop_u32() appends the given 32-bit integer value
+ * (converting to big-endian if necessary) to the value of the named
+ * property in the given node, or creates a new property with that
+ * value if it does not already exist.
+ *
+ * This function may insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+static inline int fdt_appendprop_u32(void *fdt, int nodeoffset,
+				     const char *name, uint32_t val)
+{
+	fdt32_t tmp = cpu_to_fdt32(val);
+	return fdt_appendprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
+}
+
+/**
+ * fdt_appendprop_u64 - append a 64-bit integer value to a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 64-bit integer value to append to the property (native endian)
+ *
+ * fdt_appendprop_u64() appends the given 64-bit integer value
+ * (converting to big-endian if necessary) to the value of the named
+ * property in the given node, or creates a new property with that
+ * value if it does not already exist.
+ *
+ * This function may insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+static inline int fdt_appendprop_u64(void *fdt, int nodeoffset,
+				     const char *name, uint64_t val)
+{
+	fdt64_t tmp = cpu_to_fdt64(val);
+	return fdt_appendprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
+}
+
+/**
+ * fdt_appendprop_cell - append a single cell value to a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value to append to the property (native endian)
+ *
+ * This is an alternative name for fdt_appendprop_u32()
+ *
+ * Return: 0 on success, negative libfdt error value otherwise.
+ */
+static inline int fdt_appendprop_cell(void *fdt, int nodeoffset,
+				      const char *name, uint32_t val)
+{
+	return fdt_appendprop_u32(fdt, nodeoffset, name, val);
+}
+
+/**
+ * fdt_appendprop_string - append a string to a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @str: string value to append to the property
+ *
+ * fdt_appendprop_string() appends the given string to the value of
+ * the named property in the given node, or creates a new property
+ * with that value if it does not already exist.
+ *
+ * This function may insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+#define fdt_appendprop_string(fdt, nodeoffset, name, str) \
+	fdt_appendprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
+
+/**
+ * fdt_appendprop_addrrange - append a address range property
+ * @fdt: pointer to the device tree blob
+ * @parent: offset of the parent node
+ * @nodeoffset: offset of the node to add a property at
+ * @name: name of property
+ * @addr: start address of a given range
+ * @size: size of a given range
+ *
+ * fdt_appendprop_addrrange() appends an address range value (start
+ * address and size) to the value of the named property in the given
+ * node, or creates a new property with that value if it does not
+ * already exist.
+ * If "name" is not specified, a default "reg" is used.
+ * Cell sizes are determined by parent's #address-cells and #size-cells.
+ *
+ * This function may insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
+ *		#address-cells property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADVALUE, addr or size doesn't fit to respective cells size
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain a new property
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_appendprop_addrrange(void *fdt, int parent, int nodeoffset,
+			     const char *name, uint64_t addr, uint64_t size);
+
+/**
+ * fdt_delprop - delete a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to nop
+ * @name: name of the property to nop
+ *
+ * fdt_del_property() will delete the given property.
+ *
+ * This function will delete data from the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_delprop(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_add_subnode_namelen - creates a new node based on substring
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to create
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_add_subnode(), but use only the first @namelen
+ * characters of @name as the name of the new node.  This is useful for
+ * creating subnodes based on a portion of a larger string, such as a
+ * full path.
+ *
+ * Return: structure block offset of the created subnode (>=0),
+ *	   negative libfdt error value otherwise
+ */
+#ifndef SWIG /* Not available in Python */
+int fdt_add_subnode_namelen(void *fdt, int parentoffset,
+			    const char *name, int namelen);
+#endif
+
+/**
+ * fdt_add_subnode - creates a new node
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ *
+ * fdt_add_subnode() creates a new node as a subnode of the node at
+ * structure block offset parentoffset, with the given name (which
+ * should include the unit address, if any).
+ *
+ * This function will insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	structure block offset of the created nodeequested subnode (>=0), on
+ *		success
+ *	-FDT_ERR_NOTFOUND, if the requested subnode does not exist
+ *	-FDT_ERR_BADOFFSET, if parentoffset did not point to an FDT_BEGIN_NODE
+ *		tag
+ *	-FDT_ERR_EXISTS, if the node at parentoffset already has a subnode of
+ *		the given name
+ *	-FDT_ERR_NOSPACE, if there is insufficient free space in the
+ *		blob to contain the new node
+ *	-FDT_ERR_NOSPACE
+ *	-FDT_ERR_BADLAYOUT
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
+int fdt_add_subnode(void *fdt, int parentoffset, const char *name);
+
+/**
+ * fdt_del_node - delete a node (subtree)
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to nop
+ *
+ * fdt_del_node() will remove the given node, including all its
+ * subnodes if any, from the blob.
+ *
+ * This function will delete data from the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_del_node(void *fdt, int nodeoffset);
+
+/**
+ * fdt_overlay_apply - Applies a DT overlay on a base DT
+ * @fdt: pointer to the base device tree blob
+ * @fdto: pointer to the device tree overlay blob
+ *
+ * fdt_overlay_apply() will apply the given device tree overlay on the
+ * given base device tree.
+ *
+ * Expect the base device tree to be modified, even if the function
+ * returns an error.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there's not enough space in the base device tree
+ *	-FDT_ERR_NOTFOUND, the overlay points to some inexistant nodes or
+ *		properties in the base DT
+ *	-FDT_ERR_BADPHANDLE,
+ *	-FDT_ERR_BADOVERLAY,
+ *	-FDT_ERR_NOPHANDLES,
+ *	-FDT_ERR_INTERNAL,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADOFFSET,
+ *	-FDT_ERR_BADPATH,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_overlay_apply(void *fdt, void *fdto);
+
+/**
+ * fdt_overlay_target_offset - retrieves the offset of a fragment's target
+ * @fdt: Base device tree blob
+ * @fdto: Device tree overlay blob
+ * @fragment_offset: node offset of the fragment in the overlay
+ * @pathp: pointer which receives the path of the target (or NULL)
+ *
+ * fdt_overlay_target_offset() retrieves the target offset in the base
+ * device tree of a fragment, no matter how the actual targeting is
+ * done (through a phandle or a path)
+ *
+ * returns:
+ *      the targeted node offset in the base device tree
+ *      Negative error code on error
+ */
+int fdt_overlay_target_offset(const void *fdt, const void *fdto,
+			      int fragment_offset, char const **pathp);
+
+/**********************************************************************/
+/* Debugging / informational functions                                */
+/**********************************************************************/
+
+const char *fdt_strerror(int errval);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* LIBFDT_H */
diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
new file mode 100644
index 000000000000..73b6d40450ac
--- /dev/null
+++ b/libfdt/libfdt_env.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+#ifndef LIBFDT_ENV_H
+#define LIBFDT_ENV_H
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ * Copyright 2012 Kim Phillips, Freescale Semiconductor.
+ */
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <limits.h>
+
+#ifdef __CHECKER__
+#define FDT_FORCE __attribute__((force))
+#define FDT_BITWISE __attribute__((bitwise))
+#else
+#define FDT_FORCE
+#define FDT_BITWISE
+#endif
+
+typedef uint16_t FDT_BITWISE fdt16_t;
+typedef uint32_t FDT_BITWISE fdt32_t;
+typedef uint64_t FDT_BITWISE fdt64_t;
+
+#define EXTRACT_BYTE(x, n)	((unsigned long long)((uint8_t *)&x)[n])
+#define CPU_TO_FDT16(x) ((EXTRACT_BYTE(x, 0) << 8) | EXTRACT_BYTE(x, 1))
+#define CPU_TO_FDT32(x) ((EXTRACT_BYTE(x, 0) << 24) | (EXTRACT_BYTE(x, 1) << 16) | \
+			 (EXTRACT_BYTE(x, 2) << 8) | EXTRACT_BYTE(x, 3))
+#define CPU_TO_FDT64(x) ((EXTRACT_BYTE(x, 0) << 56) | (EXTRACT_BYTE(x, 1) << 48) | \
+			 (EXTRACT_BYTE(x, 2) << 40) | (EXTRACT_BYTE(x, 3) << 32) | \
+			 (EXTRACT_BYTE(x, 4) << 24) | (EXTRACT_BYTE(x, 5) << 16) | \
+			 (EXTRACT_BYTE(x, 6) << 8) | EXTRACT_BYTE(x, 7))
+
+static inline uint16_t fdt16_to_cpu(fdt16_t x)
+{
+	return (FDT_FORCE uint16_t)CPU_TO_FDT16(x);
+}
+static inline fdt16_t cpu_to_fdt16(uint16_t x)
+{
+	return (FDT_FORCE fdt16_t)CPU_TO_FDT16(x);
+}
+
+static inline uint32_t fdt32_to_cpu(fdt32_t x)
+{
+	return (FDT_FORCE uint32_t)CPU_TO_FDT32(x);
+}
+static inline fdt32_t cpu_to_fdt32(uint32_t x)
+{
+	return (FDT_FORCE fdt32_t)CPU_TO_FDT32(x);
+}
+
+static inline uint64_t fdt64_to_cpu(fdt64_t x)
+{
+	return (FDT_FORCE uint64_t)CPU_TO_FDT64(x);
+}
+static inline fdt64_t cpu_to_fdt64(uint64_t x)
+{
+	return (FDT_FORCE fdt64_t)CPU_TO_FDT64(x);
+}
+#undef CPU_TO_FDT64
+#undef CPU_TO_FDT32
+#undef CPU_TO_FDT16
+#undef EXTRACT_BYTE
+
+#ifdef __APPLE__
+#include <AvailabilityMacros.h>
+
+/* strnlen() is not available on Mac OS < 10.7 */
+# if !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED < \
+                                         MAC_OS_X_VERSION_10_7)
+
+#define strnlen fdt_strnlen
+
+/*
+ * fdt_strnlen: returns the length of a string or max_count - which ever is
+ * smallest.
+ * Input 1 string: the string whose size is to be determined
+ * Input 2 max_count: the maximum value returned by this function
+ * Output: length of the string or max_count (the smallest of the two)
+ */
+static inline size_t fdt_strnlen(const char *string, size_t max_count)
+{
+    const char *p = memchr(string, 0, max_count);
+    return p ? p - string : max_count;
+}
+
+#endif /* !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED <
+          MAC_OS_X_VERSION_10_7) */
+
+#endif /* __APPLE__ */
+
+#endif /* LIBFDT_ENV_H */
diff --git a/libfdt/libfdt_internal.h b/libfdt/libfdt_internal.h
new file mode 100644
index 000000000000..16bda1906a7b
--- /dev/null
+++ b/libfdt/libfdt_internal.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+#ifndef LIBFDT_INTERNAL_H
+#define LIBFDT_INTERNAL_H
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include <fdt.h>
+
+#define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
+
+int32_t fdt_ro_probe_(const void *fdt);
+#define FDT_RO_PROBE(fdt)					\
+	{							\
+		int32_t totalsize_;				\
+		if ((totalsize_ = fdt_ro_probe_(fdt)) < 0)	\
+			return totalsize_;			\
+	}
+
+int fdt_check_node_offset_(const void *fdt, int offset);
+int fdt_check_prop_offset_(const void *fdt, int offset);
+const char *fdt_find_string_(const char *strtab, int tabsize, const char *s);
+int fdt_node_end_offset_(void *fdt, int nodeoffset);
+
+static inline const void *fdt_offset_ptr_(const void *fdt, int offset)
+{
+	return (const char *)fdt + fdt_off_dt_struct(fdt) + offset;
+}
+
+static inline void *fdt_offset_ptr_w_(void *fdt, int offset)
+{
+	return (void *)(uintptr_t)fdt_offset_ptr_(fdt, offset);
+}
+
+static inline const struct fdt_reserve_entry *fdt_mem_rsv_(const void *fdt, int n)
+{
+	const struct fdt_reserve_entry *rsv_table =
+		(const struct fdt_reserve_entry *)
+		((const char *)fdt + fdt_off_mem_rsvmap(fdt));
+
+	return rsv_table + n;
+}
+static inline struct fdt_reserve_entry *fdt_mem_rsv_w_(void *fdt, int n)
+{
+	return (void *)(uintptr_t)fdt_mem_rsv_(fdt, n);
+}
+
+/*
+ * Internal helpers to access tructural elements of the device tree
+ * blob (rather than for exaple reading integers from within property
+ * values).  We assume that we are either given a naturally aligned
+ * address for the platform or if we are not, we are on a platform
+ * where unaligned memory reads will be handled in a graceful manner.
+ * If not the external helpers fdtXX_ld() from libfdt.h can be used
+ * instead.
+ */
+static inline uint32_t fdt32_ld_(const fdt32_t *p)
+{
+	return fdt32_to_cpu(*p);
+}
+
+static inline uint64_t fdt64_ld_(const fdt64_t *p)
+{
+	return fdt64_to_cpu(*p);
+}
+
+#define FDT_SW_MAGIC		(~FDT_MAGIC)
+
+/**********************************************************************/
+/* Checking controls                                                  */
+/**********************************************************************/
+
+#ifndef FDT_ASSUME_MASK
+#define FDT_ASSUME_MASK 0
+#endif
+
+/*
+ * Defines assumptions which can be enabled. Each of these can be enabled
+ * individually. For maximum safety, don't enable any assumptions!
+ *
+ * For minimal code size and no safety, use ASSUME_PERFECT at your own risk.
+ * You should have another method of validating the device tree, such as a
+ * signature or hash check before using libfdt.
+ *
+ * For situations where security is not a concern it may be safe to enable
+ * ASSUME_SANE.
+ */
+enum {
+	/*
+	 * This does essentially no checks. Only the latest device-tree
+	 * version is correctly handled. Inconsistencies or errors in the device
+	 * tree may cause undefined behaviour or crashes. Invalid parameters
+	 * passed to libfdt may do the same.
+	 *
+	 * If an error occurs when modifying the tree it may leave the tree in
+	 * an intermediate (but valid) state. As an example, adding a property
+	 * where there is insufficient space may result in the property name
+	 * being added to the string table even though the property itself is
+	 * not added to the struct section.
+	 *
+	 * Only use this if you have a fully validated device tree with
+	 * the latest supported version and wish to minimise code size.
+	 */
+	ASSUME_PERFECT		= 0xff,
+
+	/*
+	 * This assumes that the device tree is sane. i.e. header metadata
+	 * and basic hierarchy are correct.
+	 *
+	 * With this assumption enabled, normal device trees produced by libfdt
+	 * and the compiler should be handled safely. Malicious device trees and
+	 * complete garbage may cause libfdt to behave badly or crash. Truncated
+	 * device trees (e.g. those only partially loaded) can also cause
+	 * problems.
+	 *
+	 * Note: Only checks that relate exclusively to the device tree itself
+	 * (not the parameters passed to libfdt) are disabled by this
+	 * assumption. This includes checking headers, tags and the like.
+	 */
+	ASSUME_VALID_DTB	= 1 << 0,
+
+	/*
+	 * This builds on ASSUME_VALID_DTB and further assumes that libfdt
+	 * functions are called with valid parameters, i.e. not trigger
+	 * FDT_ERR_BADOFFSET or offsets that are out of bounds. It disables any
+	 * extensive checking of parameters and the device tree, making various
+	 * assumptions about correctness.
+	 *
+	 * It doesn't make sense to enable this assumption unless
+	 * ASSUME_VALID_DTB is also enabled.
+	 */
+	ASSUME_VALID_INPUT	= 1 << 1,
+
+	/*
+	 * This disables checks for device-tree version and removes all code
+	 * which handles older versions.
+	 *
+	 * Only enable this if you know you have a device tree with the latest
+	 * version.
+	 */
+	ASSUME_LATEST		= 1 << 2,
+
+	/*
+	 * This assumes that it is OK for a failed addition to the device tree,
+	 * due to lack of space or some other problem, to skip any rollback
+	 * steps (such as dropping the property name from the string table).
+	 * This is safe to enable in most circumstances, even though it may
+	 * leave the tree in a sub-optimal state.
+	 */
+	ASSUME_NO_ROLLBACK	= 1 << 3,
+
+	/*
+	 * This assumes that the device tree components appear in a 'convenient'
+	 * order, i.e. the memory reservation block first, then the structure
+	 * block and finally the string block.
+	 *
+	 * This order is not specified by the device-tree specification,
+	 * but is expected by libfdt. The device-tree compiler always created
+	 * device trees with this order.
+	 *
+	 * This assumption disables a check in fdt_open_into() and removes the
+	 * ability to fix the problem there. This is safe if you know that the
+	 * device tree is correctly ordered. See fdt_blocks_misordered_().
+	 */
+	ASSUME_LIBFDT_ORDER	= 1 << 4,
+
+	/*
+	 * This assumes that libfdt itself does not have any internal bugs. It
+	 * drops certain checks that should never be needed unless libfdt has an
+	 * undiscovered bug.
+	 *
+	 * This can generally be considered safe to enable.
+	 */
+	ASSUME_LIBFDT_FLAWLESS	= 1 << 5,
+};
+
+/**
+ * can_assume_() - check if a particular assumption is enabled
+ *
+ * @mask: Mask to check (ASSUME_...)
+ * @return true if that assumption is enabled, else false
+ */
+static inline bool can_assume_(int mask)
+{
+	return FDT_ASSUME_MASK & mask;
+}
+
+/** helper macros for checking assumptions */
+#define can_assume(_assume)	can_assume_(ASSUME_ ## _assume)
+
+#endif /* LIBFDT_INTERNAL_H */
diff --git a/libfdt/meson.build b/libfdt/meson.build
new file mode 100644
index 000000000000..71f29b61e870
--- /dev/null
+++ b/libfdt/meson.build
@@ -0,0 +1,55 @@
+version_script = '-Wl,--version-script=@0@'.format(meson.current_source_dir() / 'version.lds')
+if not cc.has_link_argument(version_script)
+  version_script = []
+endif
+
+sources = files(
+  'fdt.c',
+  'fdt_addresses.c',
+  'fdt_check.c',
+  'fdt_empty_tree.c',
+  'fdt_overlay.c',
+  'fdt_ro.c',
+  'fdt_rw.c',
+  'fdt_strerror.c',
+  'fdt_sw.c',
+  'fdt_wip.c',
+)
+
+libfdt = library(
+  'fdt', sources,
+  version: '1.6.0',
+  link_args: ['-Wl,--no-undefined', version_script],
+  link_depends: 'version.lds',
+  install: true,
+)
+
+libfdt_a = static_library(
+  'fdt', sources,
+  install: true,
+)
+
+libfdt_inc = include_directories('.')
+
+libfdt_dep = declare_dependency(
+  include_directories: libfdt_inc,
+  link_with: libfdt,
+)
+
+install_headers(
+  files(
+    'fdt.h',
+    'libfdt.h',
+    'libfdt_env.h',
+  )
+)
+
+pkgconfig = import('pkgconfig')
+
+pkgconfig.generate(
+  libraries: libfdt,
+  version: meson.project_version(),
+  filebase: 'libfdt',
+  name: 'libfdt',
+  description: 'Flat Device Tree manipulation',
+)
diff --git a/libfdt/version.lds b/libfdt/version.lds
new file mode 100644
index 000000000000..cbce5d4a8bdc
--- /dev/null
+++ b/libfdt/version.lds
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+LIBFDT_1.2 {
+	global:
+		fdt_next_node;
+		fdt_check_header;
+		fdt_move;
+		fdt_string;
+		fdt_num_mem_rsv;
+		fdt_get_mem_rsv;
+		fdt_subnode_offset_namelen;
+		fdt_subnode_offset;
+		fdt_path_offset_namelen;
+		fdt_path_offset;
+		fdt_get_name;
+		fdt_get_property_namelen;
+		fdt_get_property;
+		fdt_getprop_namelen;
+		fdt_getprop;
+		fdt_get_phandle;
+		fdt_get_alias_namelen;
+		fdt_get_alias;
+		fdt_get_path;
+                fdt_header_size;
+		fdt_supernode_atdepth_offset;
+		fdt_node_depth;
+		fdt_parent_offset;
+		fdt_node_offset_by_prop_value;
+		fdt_node_offset_by_phandle;
+		fdt_node_check_compatible;
+		fdt_node_offset_by_compatible;
+		fdt_setprop_inplace;
+		fdt_nop_property;
+		fdt_nop_node;
+		fdt_create;
+		fdt_add_reservemap_entry;
+		fdt_finish_reservemap;
+		fdt_begin_node;
+		fdt_property;
+		fdt_end_node;
+		fdt_finish;
+		fdt_open_into;
+		fdt_pack;
+		fdt_add_mem_rsv;
+		fdt_del_mem_rsv;
+		fdt_set_name;
+		fdt_setprop;
+		fdt_delprop;
+		fdt_add_subnode_namelen;
+		fdt_add_subnode;
+		fdt_del_node;
+		fdt_strerror;
+		fdt_offset_ptr;
+		fdt_next_tag;
+		fdt_appendprop;
+		fdt_create_empty_tree;
+		fdt_first_property_offset;
+		fdt_get_property_by_offset;
+		fdt_getprop_by_offset;
+		fdt_next_property_offset;
+		fdt_first_subnode;
+		fdt_next_subnode;
+		fdt_address_cells;
+		fdt_size_cells;
+		fdt_stringlist_contains;
+		fdt_stringlist_count;
+		fdt_stringlist_search;
+		fdt_stringlist_get;
+		fdt_resize;
+		fdt_overlay_apply;
+		fdt_get_string;
+		fdt_find_max_phandle;
+		fdt_generate_phandle;
+		fdt_check_full;
+		fdt_setprop_placeholder;
+		fdt_property_placeholder;
+		fdt_header_size_;
+		fdt_appendprop_addrrange;
+		fdt_setprop_inplace_namelen_partial;
+		fdt_create_with_flags;
+		fdt_overlay_target_offset;
+	local:
+		*;
+};
-- 
2.36.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
