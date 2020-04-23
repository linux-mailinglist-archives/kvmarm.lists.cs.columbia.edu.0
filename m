Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EF8521B6223
	for <lists+kvmarm@lfdr.de>; Thu, 23 Apr 2020 19:39:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A1C044B0B1;
	Thu, 23 Apr 2020 13:39:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E97hWpSrfEpA; Thu, 23 Apr 2020 13:39:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D3D2E4B1B5;
	Thu, 23 Apr 2020 13:39:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21C534B187
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 13:39:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZfGFrTQeStCB for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Apr 2020 13:39:13 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14B7E4B19E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 13:39:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A386EC14;
 Thu, 23 Apr 2020 10:39:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FA713F68F;
 Thu, 23 Apr 2020 10:39:09 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v4 5/5] cfi-flash: Add support for mapping flash into
 guest
Date: Thu, 23 Apr 2020 18:38:44 +0100
Message-Id: <20200423173844.24220-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423173844.24220-1-andre.przywara@arm.com>
References: <20200423173844.24220-1-andre.przywara@arm.com>
Cc: kvm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Raphael Gault <raphael.gault@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
 kvmarm@lists.cs.columbia.edu
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

At the moment we trap *every* access to the flash memory, even when we
are in array read mode (which just directly copies from the storage
array to the guest).
To improve performance, allow cacheable mappings and to avoid fatal traps
on unsupported instructions (on ARM), export a read-only memslot to the
guest when the flash is in read-array mode. A guest does not need to
trap on read accesses then.
A write command (which always traps) will revoke this mapping if the
read mode changes.

This reduces the number of read traps from more than 800,000 to a few
hundreds when booting into the UEFI shell.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 hw/cfi_flash.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/cfi_flash.c b/hw/cfi_flash.c
index 3c76c04a..7faecdfb 100644
--- a/hw/cfi_flash.c
+++ b/hw/cfi_flash.c
@@ -8,6 +8,7 @@
 
 #include "kvm/kvm.h"
 #include "kvm/kvm-arch.h"
+#include "kvm/kvm-cpu.h"
 #include "kvm/devices.h"
 #include "kvm/fdt.h"
 #include "kvm/mutex.h"
@@ -139,6 +140,7 @@ struct cfi_flash_device {
 	enum cfi_flash_state	state;
 	enum cfi_read_mode	read_mode;
 	u8			sr;
+	bool			is_mapped;
 };
 
 static int nr_erase_blocks(struct cfi_flash_device *sfdev)
@@ -437,6 +439,43 @@ static void cfi_flash_write(struct cfi_flash_device *sfdev, u16 command,
 	}
 }
 
+/*
+ * If we are in ARRAY_READ mode, we can map the flash array directly
+ * into the guest, just as read-only. This greatly improves read
+ * performance, and avoids problems with exits due to accesses from
+ * load instructions without syndrome information (on ARM).
+ * Also it could allow code to be executed XIP in there.
+ */
+static int map_flash_memory(struct kvm *kvm, struct cfi_flash_device *sfdev)
+{
+	int ret;
+
+	ret = kvm__register_mem(kvm, sfdev->base_addr, sfdev->size,
+				sfdev->flash_memory,
+				KVM_MEM_TYPE_RAM | KVM_MEM_TYPE_READONLY);
+	if (!ret)
+		sfdev->is_mapped = true;
+
+	return ret;
+}
+
+/*
+ * Any write access changing the read mode would need to bring us back to
+ * "trap everything", as the CFI query read need proper handholding.
+ */
+static int unmap_flash_memory(struct kvm *kvm, struct cfi_flash_device *sfdev)
+{
+	int ret;
+
+	ret = kvm__destroy_mem(kvm, sfdev->base_addr, sfdev->size,
+			       sfdev->flash_memory);
+
+	if (!ret)
+		sfdev->is_mapped = false;
+
+	return ret;
+}
+
 static void cfi_flash_mmio(struct kvm_cpu *vcpu,
 			   u64 addr, u8 *data, u32 len, u8 is_write,
 			   void *context)
@@ -467,6 +506,12 @@ static void cfi_flash_mmio(struct kvm_cpu *vcpu,
 
 	cfi_flash_write(sfdev, value & 0xffff, faddr, data, len);
 
+	/* Adjust our mapping status accordingly. */
+	if (!sfdev->is_mapped && sfdev->read_mode == READ_ARRAY)
+		map_flash_memory(vcpu->kvm, sfdev);
+	else if (sfdev->is_mapped && sfdev->read_mode != READ_ARRAY)
+		unmap_flash_memory(vcpu->kvm, sfdev);
+
 	mutex_unlock(&sfdev->mutex);
 }
 
@@ -543,6 +588,8 @@ static struct cfi_flash_device *create_flash_device_file(struct kvm *kvm,
 	sfdev->read_mode = READ_ARRAY;
 	sfdev->sr = CFI_STATUS_READY;
 
+	map_flash_memory(kvm, sfdev);
+
 	value = roundup(nr_erase_blocks(sfdev), BITS_PER_LONG) / 8;
 	sfdev->lock_bm = malloc(value);
 	memset(sfdev->lock_bm, 0, value);
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
