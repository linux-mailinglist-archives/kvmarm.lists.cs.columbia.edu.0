Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0C3F7A5E
	for <lists+kvmarm@lfdr.de>; Wed, 25 Aug 2021 18:20:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C04C4B290;
	Wed, 25 Aug 2021 12:20:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y77l-zBdD+yX; Wed, 25 Aug 2021 12:20:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE03C4B2B6;
	Wed, 25 Aug 2021 12:19:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 718B64B230
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:19:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUlTAEaNsK7K for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Aug 2021 12:19:41 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D16354ACC9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:18:50 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EBFC13A1;
 Wed, 25 Aug 2021 09:18:50 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3170B3F66F;
 Wed, 25 Aug 2021 09:18:49 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v4 kvmtool 2/5] arm/arm64: Make kvm__arch_delete_ram()
 aarch32/aarch64 specific
Date: Wed, 25 Aug 2021 17:19:55 +0100
Message-Id: <20210825161958.266411-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161958.266411-1-alexandru.elisei@arm.com>
References: <20210825161958.266411-1-alexandru.elisei@arm.com>
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

Move kvm__arch_delete_ram() into aarch32 and aarch64 specific locations.
The function is kept identical between the two architectures, but adding
KVM SPE support will mean making changes to the aarch64 version of the
function to unlock the guest memory on virtual machine tear down.

No functional change intended.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Makefile          | 1 +
 arm/aarch32/kvm.c | 8 ++++++++
 arm/aarch64/kvm.c | 5 +++++
 arm/kvm.c         | 5 -----
 4 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 arm/aarch32/kvm.c

diff --git a/Makefile b/Makefile
index bb7ad3ecf66e..313fdc3c0201 100644
--- a/Makefile
+++ b/Makefile
@@ -165,6 +165,7 @@ ifeq ($(ARCH), arm)
 	OBJS		+= $(OBJS_ARM_COMMON)
 	OBJS		+= arm/aarch32/arm-cpu.o
 	OBJS		+= arm/aarch32/kvm-cpu.o
+	OBJS		+= arm/aarch32/kvm.o
 	ARCH_INCLUDE	:= $(HDRS_ARM_COMMON)
 	ARCH_INCLUDE	+= -Iarm/aarch32/include
 	CFLAGS		+= -march=armv7-a
diff --git a/arm/aarch32/kvm.c b/arm/aarch32/kvm.c
new file mode 100644
index 000000000000..626cf728fa70
--- /dev/null
+++ b/arm/aarch32/kvm.c
@@ -0,0 +1,8 @@
+#include "kvm/kvm.h"
+
+#include <sys/mman.h>
+
+void kvm__arch_delete_ram(struct kvm *kvm)
+{
+	munmap(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size);
+}
diff --git a/arm/aarch64/kvm.c b/arm/aarch64/kvm.c
index 49e1dd31f55f..1ab4e541c8b6 100644
--- a/arm/aarch64/kvm.c
+++ b/arm/aarch64/kvm.c
@@ -1,6 +1,7 @@
 #include "kvm/kvm.h"
 
 #include <asm/image.h>
+#include <sys/mman.h>
 
 #include <linux/byteorder.h>
 
@@ -46,3 +47,7 @@ fail:
 	return 0x80000;
 }
 
+void kvm__arch_delete_ram(struct kvm *kvm)
+{
+	munmap(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size);
+}
diff --git a/arm/kvm.c b/arm/kvm.c
index 5aea18fedc3e..e44a94046747 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -42,11 +42,6 @@ void kvm__init_ram(struct kvm *kvm)
 	kvm->arch.memory_guest_start = phys_start;
 }
 
-void kvm__arch_delete_ram(struct kvm *kvm)
-{
-	munmap(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size);
-}
-
 void kvm__arch_read_term(struct kvm *kvm)
 {
 	serial8250__update_consoles(kvm);
-- 
2.33.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
