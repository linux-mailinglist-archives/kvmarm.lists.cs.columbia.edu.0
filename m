Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF081F1C0B
	for <lists+kvmarm@lfdr.de>; Mon,  8 Jun 2020 17:28:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2910C4B1AF;
	Mon,  8 Jun 2020 11:28:15 -0400 (EDT)
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
	with ESMTP id jL+DziJeUzAq; Mon,  8 Jun 2020 11:28:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D21A44B1BD;
	Mon,  8 Jun 2020 11:28:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EA1974B1AF
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 11:28:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MW0zwZikQ5XA for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Jun 2020 11:28:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9C0B94B1AA
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 11:28:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 725ED206D5;
 Mon,  8 Jun 2020 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591630089;
 bh=dLu0XJ1TYdNhKvkSJPwUcvKrUNbDTGDeAe/7UCVVlKI=;
 h=From:To:Cc:Subject:Date:From;
 b=diyDYWHvk1c6D/XEQnkWOhPkj9WV6PEnRf7nqyH2tLdplBuPmBzqAGzN5Hr1PwZUX
 VshTX5+WGk9edlFny5qPInE6jeZZGdz9Y4b3P0GBekUOTNaucnpWbHU9tkGW66HtqG
 ndOkCsfflQl0uIQTgdtZLYneR1jxE0nSyr+pelR0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jiJh1-0019tL-Ue; Mon, 08 Jun 2020 16:28:08 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [kvmtool][PATCH v2] arm64: Obtain text offset from kernel image
Date: Mon,  8 Jun 2020 16:28:01 +0100
Message-Id: <20200608152801.1415902-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, will@kernel.org,
 julien.thierry.kdev@gmail.com, alexandru.elisei@arm.com, ardb@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
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

Recent changes made to Linux 5.8 have outlined that kvmtool
hardcodes the text offset instead of reading it from the arm64
image itself.

To address this, import the image header structure into kvmtool
and do the right thing. 32bit guests are still loaded to their
usual locations.

While we're at it, check the image magic and default to the text
offset to be 0x80000 when image_size is 0, as described in the
kernel's booting.rst document.

Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Reported-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---

Notes:
    v2: Check magic, assume offset to be 0x8000 if image_size is 0.

 Makefile                           |  1 +
 arm/aarch32/include/kvm/kvm-arch.h |  2 +-
 arm/aarch64/include/asm/image.h    | 59 ++++++++++++++++++++++++++++++
 arm/aarch64/include/kvm/kvm-arch.h |  5 +--
 arm/aarch64/kvm.c                  | 43 ++++++++++++++++++++++
 arm/kvm.c                          |  2 +-
 6 files changed, 107 insertions(+), 5 deletions(-)
 create mode 100644 arm/aarch64/include/asm/image.h
 create mode 100644 arm/aarch64/kvm.c

diff --git a/Makefile b/Makefile
index d27ff38..35bb118 100644
--- a/Makefile
+++ b/Makefile
@@ -179,6 +179,7 @@ ifeq ($(ARCH), arm64)
 	OBJS		+= $(OBJS_ARM_COMMON)
 	OBJS		+= arm/aarch64/arm-cpu.o
 	OBJS		+= arm/aarch64/kvm-cpu.o
+	OBJS		+= arm/aarch64/kvm.o
 	ARCH_INCLUDE	:= $(HDRS_ARM_COMMON)
 	ARCH_INCLUDE	+= -Iarm/aarch64/include
 
diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
index cd31e72..a772bb1 100644
--- a/arm/aarch32/include/kvm/kvm-arch.h
+++ b/arm/aarch32/include/kvm/kvm-arch.h
@@ -1,7 +1,7 @@
 #ifndef KVM__KVM_ARCH_H
 #define KVM__KVM_ARCH_H
 
-#define ARM_KERN_OFFSET(...)	0x8000
+#define kvm__arch_get_kern_offset(...)	0x8000
 
 #define ARM_MAX_MEMORY(...)	ARM_LOMAP_MAX_MEMORY
 
diff --git a/arm/aarch64/include/asm/image.h b/arm/aarch64/include/asm/image.h
new file mode 100644
index 0000000..c2b1321
--- /dev/null
+++ b/arm/aarch64/include/asm/image.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#define ARM64_IMAGE_MAGIC	"ARM\x64"
+
+#define ARM64_IMAGE_FLAG_BE_SHIFT		0
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_SHIFT	(ARM64_IMAGE_FLAG_BE_SHIFT + 1)
+#define ARM64_IMAGE_FLAG_PHYS_BASE_SHIFT \
+					(ARM64_IMAGE_FLAG_PAGE_SIZE_SHIFT + 2)
+#define ARM64_IMAGE_FLAG_BE_MASK		0x1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_MASK		0x3
+#define ARM64_IMAGE_FLAG_PHYS_BASE_MASK		0x1
+
+#define ARM64_IMAGE_FLAG_LE			0
+#define ARM64_IMAGE_FLAG_BE			1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_4K		1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_16K		2
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_64K		3
+#define ARM64_IMAGE_FLAG_PHYS_BASE		1
+
+#ifndef __ASSEMBLY__
+
+#define arm64_image_flag_field(flags, field) \
+				(((flags) >> field##_SHIFT) & field##_MASK)
+
+/*
+ * struct arm64_image_header - arm64 kernel image header
+ * See Documentation/arm64/booting.rst for details
+ *
+ * @code0:		Executable code, or
+ *   @mz_header		  alternatively used for part of MZ header
+ * @code1:		Executable code
+ * @text_offset:	Image load offset
+ * @image_size:		Effective Image size
+ * @flags:		kernel flags
+ * @reserved:		reserved
+ * @magic:		Magic number
+ * @reserved5:		reserved, or
+ *   @pe_header:	  alternatively used for PE COFF offset
+ */
+
+struct arm64_image_header {
+	__le32 code0;
+	__le32 code1;
+	__le64 text_offset;
+	__le64 image_size;
+	__le64 flags;
+	__le64 res2;
+	__le64 res3;
+	__le64 res4;
+	__le32 magic;
+	__le32 res5;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_IMAGE_H */
diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
index 9de623a..55ef8ed 100644
--- a/arm/aarch64/include/kvm/kvm-arch.h
+++ b/arm/aarch64/include/kvm/kvm-arch.h
@@ -1,9 +1,8 @@
 #ifndef KVM__KVM_ARCH_H
 #define KVM__KVM_ARCH_H
 
-#define ARM_KERN_OFFSET(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
-				0x8000				:	\
-				0x80000)
+struct kvm;
+unsigned long long kvm__arch_get_kern_offset(struct kvm *kvm, int fd);
 
 #define ARM_MAX_MEMORY(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
 				ARM_LOMAP_MAX_MEMORY		:	\
diff --git a/arm/aarch64/kvm.c b/arm/aarch64/kvm.c
new file mode 100644
index 0000000..a46d438
--- /dev/null
+++ b/arm/aarch64/kvm.c
@@ -0,0 +1,43 @@
+#include "kvm/kvm.h"
+
+#include <asm/image.h>
+
+#include <linux/byteorder.h>
+
+/*
+ * Return the TEXT_OFFSET value that the guest kernel expects. Note
+ * that pre-3.17 kernels expose this value using the native endianness
+ * instead of Little-Endian. BE kernels of this vintage may fail to
+ * boot. See Documentation/arm64/booting.rst in your local kernel tree.
+ */
+unsigned long long kvm__arch_get_kern_offset(struct kvm *kvm, int fd)
+{
+	struct arm64_image_header header;
+	off_t cur_offset;
+	ssize_t size;
+
+	/* the 32bit kernel offset is a well known value */
+	if (kvm->cfg.arch.aarch32_guest)
+		return 0x8000;
+
+	cur_offset = lseek(fd, 0, SEEK_CUR);
+	if (cur_offset == (off_t)-1 ||
+	    lseek(fd, 0, SEEK_SET) == (off_t)-1)
+		die("Failed to seek in image file");
+
+	size = xread(fd, &header, sizeof(header));
+	if (size < 0 || (size_t)size < sizeof(header))
+		die("Failed to read kernel image header");
+
+	lseek(fd, cur_offset, SEEK_SET);
+
+	if (memcmp(&header.magic, ARM64_IMAGE_MAGIC, sizeof(header.magic)))
+		pr_warning("Kernel image magic not matching");
+
+	if (le64_to_cpu(header.image_size))
+		return le64_to_cpu(header.text_offset);
+
+	pr_warning("Image size is 0, assuming TEXT_OFFSET to be 0x80000");
+	return 0x80000;
+}
+
diff --git a/arm/kvm.c b/arm/kvm.c
index 1f85fc6..5aea18f 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -103,7 +103,7 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 	 */
 	limit = kvm->ram_start + min(kvm->ram_size, (u64)SZ_256M) - 1;
 
-	pos = kvm->ram_start + ARM_KERN_OFFSET(kvm);
+	pos = kvm->ram_start + kvm__arch_get_kern_offset(kvm, fd_kernel);
 	kvm->arch.kern_guest_start = host_to_guest_flat(kvm, pos);
 	file_size = read_file(fd_kernel, pos, limit - pos);
 	if (file_size < 0) {
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
