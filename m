Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5998A13703A
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jan 2020 15:55:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CBEB4B1B9;
	Fri, 10 Jan 2020 09:55:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRbm095iORvj; Fri, 10 Jan 2020 09:55:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 687424B162;
	Fri, 10 Jan 2020 09:55:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C53794B0FA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 09:55:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4EDtbmjAY1be for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jan 2020 09:55:21 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A23014B0CF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 09:55:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578668120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTriFbjg+KTXFXNVq3B1F0AYstGQbF6Xm4dB+5LymY0=;
 b=WkFL1KY1kqx0Y8qhonlvDk0YTHIK34zX57raDgy2OKbQXysnIJO8thFV2fpZFSSLW4YZPe
 ZHmGmFTWPiSuMNIUMDA9ktOdc+KvwfWRj5mEiGj4Hi9FAR4hFxK/1/ui2hW4lcjenfMx1s
 QKFKymKLB03VzYnrsEJQlkkvzUEOdCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-rCA5sDRrOg-dIHWM7zytDA-1; Fri, 10 Jan 2020 09:55:19 -0500
X-MC-Unique: rCA5sDRrOg-dIHWM7zytDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DB5F10883A1;
 Fri, 10 Jan 2020 14:55:17 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EF2D7BA5F;
 Fri, 10 Jan 2020 14:55:14 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v2 12/16] arm/arm64: ITS: commands
Date: Fri, 10 Jan 2020 15:54:08 +0100
Message-Id: <20200110145412.14937-13-eric.auger@redhat.com>
In-Reply-To: <20200110145412.14937-1-eric.auger@redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: andre.przywara@arm.com, thuth@redhat.com
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

Implement main ITS commands. The code is largely inherited from
the ITS driver.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- removed its_print_cmd_state
---
 arm/Makefile.common      |   2 +-
 lib/arm/asm/gic-v3-its.h |  35 +++
 lib/arm/gic-v3-its-cmd.c | 453 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 489 insertions(+), 1 deletion(-)
 create mode 100644 lib/arm/gic-v3-its-cmd.c

diff --git a/arm/Makefile.common b/arm/Makefile.common
index 1aae5a3..7cc0f04 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -52,7 +52,7 @@ cflatobjs += lib/arm/psci.o
 cflatobjs += lib/arm/smp.o
 cflatobjs += lib/arm/delay.o
 cflatobjs += lib/arm/gic.o lib/arm/gic-v2.o lib/arm/gic-v3.o
-cflatobjs += lib/arm/gic-v3-its.o
+cflatobjs += lib/arm/gic-v3-its.o lib/arm/gic-v3-its-cmd.o
 
 OBJDIRS += lib/arm
 
diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 0497a78..463174f 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -58,6 +58,24 @@
 #define GITS_MAX_DEVICES		8
 #define GITS_MAX_COLLECTIONS		8
 
+/*
+ * ITS commands
+ */
+#define GITS_CMD_MAPD                   0x08
+#define GITS_CMD_MAPC                   0x09
+#define GITS_CMD_MAPTI                  0x0a
+/* older GIC documentation used MAPVI for this command */
+#define GITS_CMD_MAPVI                  GITS_CMD_MAPTI
+#define GITS_CMD_MAPI                   0x0b
+#define GITS_CMD_MOVI                   0x01
+#define GITS_CMD_DISCARD                0x0f
+#define GITS_CMD_INV                    0x0c
+#define GITS_CMD_MOVALL                 0x0e
+#define GITS_CMD_INVALL                 0x0d
+#define GITS_CMD_INT                    0x03
+#define GITS_CMD_CLEAR                  0x04
+#define GITS_CMD_SYNC                   0x05
+
 struct its_typer {
 	unsigned int ite_size;
 	unsigned int eventid_bits;
@@ -122,5 +140,22 @@ extern void its_enable_defaults(void);
 extern struct its_device *its_create_device(u32 dev_id, int nr_ites);
 extern struct its_collection *its_create_collection(u32 col_id, u32 target_pe);
 
+extern void its_send_mapd(struct its_device *dev, int valid);
+extern void its_send_mapc(struct its_collection *col, int valid);
+extern void its_send_mapti(struct its_device *dev, u32 irq_id,
+			   u32 event_id, struct its_collection *col);
+extern void its_send_int(struct its_device *dev, u32 event_id);
+extern void its_send_inv(struct its_device *dev, u32 event_id);
+extern void its_send_discard(struct its_device *dev, u32 event_id);
+extern void its_send_clear(struct its_device *dev, u32 event_id);
+extern void its_send_invall(struct its_collection *col);
+extern void its_send_movi(struct its_device *dev,
+			  struct its_collection *col, u32 id);
+extern void its_send_sync(struct its_collection *col);
+
+#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING           (1ULL << 0)
+#define ITS_FLAGS_WORKAROUND_CAVIUM_22375       (1ULL << 1)
+#define ITS_FLAGS_WORKAROUND_CAVIUM_23144       (1ULL << 2)
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_V3_ITS_H_ */
diff --git a/lib/arm/gic-v3-its-cmd.c b/lib/arm/gic-v3-its-cmd.c
new file mode 100644
index 0000000..9c6cbc6
--- /dev/null
+++ b/lib/arm/gic-v3-its-cmd.c
@@ -0,0 +1,453 @@
+/*
+ * Copyright (C) 2016, Red Hat Inc, Eric Auger <eric.auger@redhat.com>
+ *
+ * Most of the code is copy-pasted from:
+ * drivers/irqchip/irq-gic-v3-its.c
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#include <asm/io.h>
+#include <asm/gic.h>
+
+#define ITS_ITT_ALIGN           SZ_256
+
+static const char * const its_cmd_string[] = {
+	[GITS_CMD_MAPD]		= "MAPD",
+	[GITS_CMD_MAPC]		= "MAPC",
+	[GITS_CMD_MAPTI]	= "MAPTI",
+	[GITS_CMD_MAPI]		= "MAPI",
+	[GITS_CMD_MOVI]		= "MOVI",
+	[GITS_CMD_DISCARD]	= "DISCARD",
+	[GITS_CMD_INV]		= "INV",
+	[GITS_CMD_MOVALL]	= "MOVALL",
+	[GITS_CMD_INVALL]	= "INVALL",
+	[GITS_CMD_INT]		= "INT",
+	[GITS_CMD_CLEAR]	= "CLEAR",
+	[GITS_CMD_SYNC]		= "SYNC",
+};
+
+struct its_cmd_desc {
+	union {
+		struct {
+			struct its_device *dev;
+			u32 event_id;
+		} its_inv_cmd;
+
+		struct {
+			struct its_device *dev;
+			u32 event_id;
+		} its_int_cmd;
+
+		struct {
+			struct its_device *dev;
+			bool valid;
+		} its_mapd_cmd;
+
+		struct {
+			struct its_collection *col;
+			bool valid;
+		} its_mapc_cmd;
+
+		struct {
+			struct its_device *dev;
+			u32 phys_id;
+			u32 event_id;
+			u32 col_id;
+		} its_mapti_cmd;
+
+		struct {
+			struct its_device *dev;
+			struct its_collection *col;
+			u32 event_id;
+		} its_movi_cmd;
+
+		struct {
+			struct its_device *dev;
+			u32 event_id;
+		} its_discard_cmd;
+
+		struct {
+			struct its_device *dev;
+			u32 event_id;
+		} its_clear_cmd;
+
+		struct {
+			struct its_collection *col;
+		} its_invall_cmd;
+
+		struct {
+			struct its_collection *col;
+		} its_sync_cmd;
+	};
+};
+
+typedef void (*its_cmd_builder_t)(struct its_cmd_block *,
+				  struct its_cmd_desc *);
+
+/* ITS COMMANDS */
+
+static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
+{
+	cmd->raw_cmd[0] &= ~0xffUL;
+	cmd->raw_cmd[0] |= cmd_nr;
+}
+
+static void its_encode_devid(struct its_cmd_block *cmd, u32 devid)
+{
+	cmd->raw_cmd[0] &= BIT_ULL(32) - 1;
+	cmd->raw_cmd[0] |= ((u64)devid) << 32;
+}
+
+static void its_encode_event_id(struct its_cmd_block *cmd, u32 id)
+{
+	cmd->raw_cmd[1] &= ~0xffffffffUL;
+	cmd->raw_cmd[1] |= id;
+}
+
+static void its_encode_phys_id(struct its_cmd_block *cmd, u32 phys_id)
+{
+	cmd->raw_cmd[1] &= 0xffffffffUL;
+	cmd->raw_cmd[1] |= ((u64)phys_id) << 32;
+}
+
+static void its_encode_size(struct its_cmd_block *cmd, u8 size)
+{
+	cmd->raw_cmd[1] &= ~0x1fUL;
+	cmd->raw_cmd[1] |= size & 0x1f;
+}
+
+static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
+{
+	cmd->raw_cmd[2] &= ~0xffffffffffffUL;
+	cmd->raw_cmd[2] |= itt_addr & 0xffffffffff00UL;
+}
+
+static void its_encode_valid(struct its_cmd_block *cmd, int valid)
+{
+	cmd->raw_cmd[2] &= ~(1UL << 63);
+	cmd->raw_cmd[2] |= ((u64)!!valid) << 63;
+}
+
+static void its_encode_target(struct its_cmd_block *cmd, u64 target_addr)
+{
+	cmd->raw_cmd[2] &= ~(0xfffffffffUL << 16);
+	cmd->raw_cmd[2] |= (target_addr & (0xffffffffUL << 16));
+}
+
+static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
+{
+	cmd->raw_cmd[2] &= ~0xffffUL;
+	cmd->raw_cmd[2] |= col;
+}
+
+static inline void its_fixup_cmd(struct its_cmd_block *cmd)
+{
+	/* Let's fixup BE commands */
+	cmd->raw_cmd[0] = cpu_to_le64(cmd->raw_cmd[0]);
+	cmd->raw_cmd[1] = cpu_to_le64(cmd->raw_cmd[1]);
+	cmd->raw_cmd[2] = cpu_to_le64(cmd->raw_cmd[2]);
+	cmd->raw_cmd[3] = cpu_to_le64(cmd->raw_cmd[3]);
+}
+
+static u64 its_cmd_ptr_to_offset(struct its_cmd_block *ptr)
+{
+	return (ptr - its_data.cmd_base) * sizeof(*ptr);
+}
+
+static struct its_cmd_block *its_post_commands(void)
+{
+	u64 wr = its_cmd_ptr_to_offset(its_data.cmd_write);
+
+	writeq(wr, its_data.base + GITS_CWRITER);
+	return its_data.cmd_write;
+}
+
+
+/* We just assume the queue is large enough */
+static struct its_cmd_block *its_allocate_entry(void)
+{
+	struct its_cmd_block *cmd;
+
+	cmd = its_data.cmd_write++;
+	return cmd;
+}
+
+static void its_wait_for_range_completion(struct its_cmd_block *from,
+					  struct its_cmd_block *to)
+{
+	u64 rd_idx, from_idx, to_idx;
+	u32 count = 1000000;    /* 1s! */
+
+	from_idx = its_cmd_ptr_to_offset(from);
+	to_idx = its_cmd_ptr_to_offset(to);
+	while (1) {
+		rd_idx = readq(its_data.base + GITS_CREADR);
+		if (rd_idx >= to_idx || rd_idx < from_idx)
+			break;
+
+		count--;
+		if (!count) {
+			unsigned int cmd_id = from->raw_cmd[0] & 0xFF;
+
+			report(false, "%s timeout!",
+			       cmd_id <= 0xF ? its_cmd_string[cmd_id] :
+			       "Unexpected");
+			return;
+		}
+		cpu_relax();
+		udelay(1);
+	}
+}
+
+static void its_send_single_command(its_cmd_builder_t builder,
+				    struct its_cmd_desc *desc)
+{
+	struct its_cmd_block *cmd, *next_cmd;
+
+	cmd = its_allocate_entry();
+	builder(cmd, desc);
+	next_cmd = its_post_commands();
+
+	its_wait_for_range_completion(cmd, next_cmd);
+}
+
+
+static void its_build_mapd_cmd(struct its_cmd_block *cmd,
+			       struct its_cmd_desc *desc)
+{
+	unsigned long itt_addr;
+	u8 size = 12; //TODO ilog2(desc->its_mapd_cmd.dev->nr_ites);
+
+	itt_addr = (unsigned long)desc->its_mapd_cmd.dev->itt;
+	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
+
+	its_encode_cmd(cmd, GITS_CMD_MAPD);
+	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
+	its_encode_size(cmd, size - 1);
+	its_encode_itt(cmd, itt_addr);
+	its_encode_valid(cmd, desc->its_mapd_cmd.valid);
+
+	its_fixup_cmd(cmd);
+	report_info("MAPD devid=%d size = 0x%x itt=0x%lx valid=%d",
+		    desc->its_mapd_cmd.dev->device_id,
+		    size, itt_addr, desc->its_mapd_cmd.valid);
+
+}
+
+static void its_build_mapc_cmd(struct its_cmd_block *cmd,
+			       struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_MAPC);
+	its_encode_collection(cmd, desc->its_mapc_cmd.col->col_id);
+	its_encode_target(cmd, desc->its_mapc_cmd.col->target_address);
+	its_encode_valid(cmd, desc->its_mapc_cmd.valid);
+
+	its_fixup_cmd(cmd);
+	report_info("MAPC col_id=%d target_addr = 0x%lx valid=%d",
+		    desc->its_mapc_cmd.col->col_id,
+		    desc->its_mapc_cmd.col->target_address,
+		    desc->its_mapc_cmd.valid);
+}
+
+static void its_build_mapti_cmd(struct its_cmd_block *cmd,
+				struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_MAPTI);
+	its_encode_devid(cmd, desc->its_mapti_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_mapti_cmd.event_id);
+	its_encode_phys_id(cmd, desc->its_mapti_cmd.phys_id);
+	its_encode_collection(cmd, desc->its_mapti_cmd.col_id);
+
+	its_fixup_cmd(cmd);
+	report_info("MAPTI dev_id=%d event_id=%d -> phys_id=%d, col_id=%d",
+		    desc->its_mapti_cmd.dev->device_id,
+		    desc->its_mapti_cmd.event_id,
+		    desc->its_mapti_cmd.phys_id,
+		    desc->its_mapti_cmd.col_id);
+}
+
+static void its_build_invall_cmd(struct its_cmd_block *cmd,
+			      struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_INVALL);
+	its_encode_collection(cmd, desc->its_invall_cmd.col->col_id);
+
+	its_fixup_cmd(cmd);
+	report_info("INVALL col_id=%d", desc->its_invall_cmd.col->col_id);
+}
+
+static void its_build_clear_cmd(struct its_cmd_block *cmd,
+				struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_CLEAR);
+	its_encode_devid(cmd, desc->its_clear_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_clear_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+	report_info("CLEAR col_id=%d", desc->its_invall_cmd.col->col_id);
+}
+
+static void its_build_discard_cmd(struct its_cmd_block *cmd,
+				  struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_DISCARD);
+	its_encode_devid(cmd, desc->its_discard_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_discard_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+	report_info("DISCARD col_id=%d", desc->its_invall_cmd.col->col_id);
+}
+
+static void its_build_inv_cmd(struct its_cmd_block *cmd,
+			      struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_INV);
+	its_encode_devid(cmd, desc->its_inv_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_inv_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+	report_info("INV dev_id=%d event_id=%d",
+		    desc->its_inv_cmd.dev->device_id,
+		    desc->its_inv_cmd.event_id);
+}
+
+static void its_build_int_cmd(struct its_cmd_block *cmd,
+			      struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_INT);
+	its_encode_devid(cmd, desc->its_int_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_int_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+	report_info("INT dev_id=%d event_id=%d",
+		    desc->its_int_cmd.dev->device_id,
+		    desc->its_int_cmd.event_id);
+}
+
+static void its_build_sync_cmd(struct its_cmd_block *cmd,
+			       struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_SYNC);
+	its_encode_target(cmd, desc->its_sync_cmd.col->target_address);
+	its_fixup_cmd(cmd);
+	report_info("SYNC target_addr = 0x%lx",
+		    desc->its_sync_cmd.col->target_address);
+}
+
+static void its_build_movi_cmd(struct its_cmd_block *cmd,
+			       struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_MOVI);
+	its_encode_devid(cmd, desc->its_movi_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_movi_cmd.event_id);
+	its_encode_collection(cmd, desc->its_movi_cmd.col->col_id);
+
+	its_fixup_cmd(cmd);
+	report_info("MOVI dev_id=%d event_id = %d col_id=%d",
+		    desc->its_movi_cmd.dev->device_id,
+		    desc->its_movi_cmd.event_id,
+		    desc->its_movi_cmd.col->col_id);
+}
+
+void its_send_mapd(struct its_device *dev, int valid)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_mapd_cmd.dev = dev;
+	desc.its_mapd_cmd.valid = !!valid;
+
+	its_send_single_command(its_build_mapd_cmd, &desc);
+}
+
+void its_send_mapc(struct its_collection *col, int valid)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_mapc_cmd.col = col;
+	desc.its_mapc_cmd.valid = !!valid;
+
+	its_send_single_command(its_build_mapc_cmd, &desc);
+}
+
+void its_send_mapti(struct its_device *dev, u32 irq_id,
+		    u32 event_id, struct its_collection *col)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_mapti_cmd.dev = dev;
+	desc.its_mapti_cmd.phys_id = irq_id;
+	desc.its_mapti_cmd.event_id = event_id;
+	desc.its_mapti_cmd.col_id = col->col_id;
+
+	its_send_single_command(its_build_mapti_cmd, &desc);
+}
+
+void its_send_int(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_int_cmd.dev = dev;
+	desc.its_int_cmd.event_id = event_id;
+
+	its_send_single_command(its_build_int_cmd, &desc);
+}
+
+void its_send_movi(struct its_device *dev,
+		   struct its_collection *col, u32 id)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_movi_cmd.dev = dev;
+	desc.its_movi_cmd.col = col;
+	desc.its_movi_cmd.event_id = id;
+
+	its_send_single_command(its_build_movi_cmd, &desc);
+}
+
+void its_send_invall(struct its_collection *col)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_invall_cmd.col = col;
+
+	its_send_single_command(its_build_invall_cmd, &desc);
+}
+
+void its_send_inv(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_inv_cmd.dev = dev;
+	desc.its_inv_cmd.event_id = event_id;
+
+	its_send_single_command(its_build_inv_cmd, &desc);
+}
+
+void its_send_discard(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_discard_cmd.dev = dev;
+	desc.its_discard_cmd.event_id = event_id;
+
+	its_send_single_command(its_build_discard_cmd, &desc);
+}
+
+void its_send_clear(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_clear_cmd.dev = dev;
+	desc.its_clear_cmd.event_id = event_id;
+
+	its_send_single_command(its_build_clear_cmd, &desc);
+}
+
+void its_send_sync(struct its_collection *col)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_sync_cmd.col = col;
+
+	its_send_single_command(its_build_sync_cmd, &desc);
+}
+
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
