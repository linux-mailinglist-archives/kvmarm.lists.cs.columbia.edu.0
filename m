Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4732481D
	for <lists+kvmarm@lfdr.de>; Thu, 25 Feb 2021 02:00:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21B024B2C4;
	Wed, 24 Feb 2021 20:00:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNEFWRERSvYu; Wed, 24 Feb 2021 20:00:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9E5C4B2FB;
	Wed, 24 Feb 2021 20:00:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A5DDC4B25E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uoz83+QshFci for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Feb 2021 20:00:36 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C37734B272
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Feb 2021 20:00:35 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B18E12FC;
 Wed, 24 Feb 2021 17:00:35 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30AE83F73B;
 Wed, 24 Feb 2021 17:00:34 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v2 06/22] hw/i8042: Refactor trap handler
Date: Thu, 25 Feb 2021 00:58:59 +0000
Message-Id: <20210225005915.26423-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210225005915.26423-1-andre.przywara@arm.com>
References: <20210225005915.26423-1-andre.przywara@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Sami Mujawar <sami.mujawar@arm.com>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

With the planned retirement of the special ioport emulation code, we
need to provide an emulation function compatible with the MMIO
prototype.

Adjust the trap handler to use that new function, and provide shims to
implement the old ioport interface, for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 hw/i8042.c | 68 +++++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/hw/i8042.c b/hw/i8042.c
index 7d1f9772..ab866662 100644
--- a/hw/i8042.c
+++ b/hw/i8042.c
@@ -292,52 +292,52 @@ static void kbd_reset(void)
 	};
 }
 
-/*
- * Called when the OS has written to one of the keyboard's ports (0x60 or 0x64)
- */
-static bool kbd_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static void kbd_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
+		   u8 is_write, void *ptr)
 {
-	switch (port) {
-	case I8042_COMMAND_REG: {
-		u8 value = kbd_read_status();
-		ioport__write8(data, value);
+	u8 value;
+
+	if (is_write)
+		value = ioport__read8(data);
+
+	switch (addr) {
+	case I8042_COMMAND_REG:
+		if (is_write)
+			kbd_write_command(vcpu->kvm, value);
+		else
+			value = kbd_read_status();
 		break;
-	}
-	case I8042_DATA_REG: {
-		u8 value = kbd_read_data();
-		ioport__write8(data, value);
+	case I8042_DATA_REG:
+		if (is_write)
+			kbd_write_data(value);
+		else
+			value = kbd_read_data();
 		break;
-	}
-	case I8042_PORT_B_REG: {
-		ioport__write8(data, 0x20);
+	case I8042_PORT_B_REG:
+		if (!is_write)
+			value = 0x20;
 		break;
-	}
 	default:
-		return false;
+		return;
 	}
 
+	if (!is_write)
+		ioport__write8(data, value);
+}
+
+/*
+ * Called when the OS has written to one of the keyboard's ports (0x60 or 0x64)
+ */
+static bool kbd_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+{
+	kbd_io(vcpu, port, data, size, 0, NULL);
+
 	return true;
 }
 
 static bool kbd_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
 {
-	switch (port) {
-	case I8042_COMMAND_REG: {
-		u8 value = ioport__read8(data);
-		kbd_write_command(vcpu->kvm, value);
-		break;
-	}
-	case I8042_DATA_REG: {
-		u8 value = ioport__read8(data);
-		kbd_write_data(value);
-		break;
-	}
-	case I8042_PORT_B_REG: {
-		break;
-	}
-	default:
-		return false;
-	}
+	kbd_io(vcpu, port, data, size, 1, NULL);
 
 	return true;
 }
-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
