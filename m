Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F133BFD1
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 16:34:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D9A64B637;
	Mon, 15 Mar 2021 11:34:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Z02fxb9E6I6; Mon, 15 Mar 2021 11:34:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B54ED4B617;
	Mon, 15 Mar 2021 11:34:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 33CBC4B641
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSEfixcwm1Z1 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 11:34:24 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F41564B60E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:23 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A18A6D6E;
 Mon, 15 Mar 2021 08:34:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587883F792;
 Mon, 15 Mar 2021 08:34:22 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v3 08/22] x86/ioport: Refactor trap handlers
Date: Mon, 15 Mar 2021 15:33:36 +0000
Message-Id: <20210315153350.19988-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210315153350.19988-1-andre.przywara@arm.com>
References: <20210315153350.19988-1-andre.przywara@arm.com>
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
need to provide emulation functions compatible with the MMIO
prototype.

Adjust the trap handlers to use that new function, and provide shims to
implement the old ioport interface, for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 x86/ioport.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/x86/ioport.c b/x86/ioport.c
index a8d2bb1a..b198de7a 100644
--- a/x86/ioport.c
+++ b/x86/ioport.c
@@ -3,8 +3,14 @@
 #include <stdlib.h>
 #include <stdio.h>
 
+static void dummy_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
+		     u8 is_write, void *ptr)
+{
+}
+
 static bool debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
 {
+	dummy_io(vcpu, port, data, size, true, NULL);
 	return 0;
 }
 
@@ -12,15 +18,23 @@ static struct ioport_operations debug_ops = {
 	.io_out		= debug_io_out,
 };
 
-static bool seabios_debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static void seabios_debug_io(struct kvm_cpu *vcpu, u64 addr, u8 *data,
+			     u32 len, u8 is_write, void *ptr)
 {
 	char ch;
 
+	if (!is_write)
+		return;
+
 	ch = ioport__read8(data);
 
 	putchar(ch);
+}
 
-	return true;
+static bool seabios_debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+{
+	seabios_debug_io(vcpu, port, data, size, true, NULL);
+	return 0;
 }
 
 static struct ioport_operations seabios_debug_ops = {
@@ -29,11 +43,13 @@ static struct ioport_operations seabios_debug_ops = {
 
 static bool dummy_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
 {
+	dummy_io(vcpu, port, data, size, false, NULL);
 	return true;
 }
 
 static bool dummy_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
 {
+	dummy_io(vcpu, port, data, size, true, NULL);
 	return true;
 }
 
@@ -50,13 +66,19 @@ static struct ioport_operations dummy_write_only_ioport_ops = {
  * The "fast A20 gate"
  */
 
-static bool ps2_control_a_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+static void ps2_control_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
+			   u8 is_write, void *ptr)
 {
 	/*
 	 * A20 is always enabled.
 	 */
-	ioport__write8(data, 0x02);
+	if (!is_write)
+		ioport__write8(data, 0x02);
+}
 
+static bool ps2_control_a_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+{
+	ps2_control_io(vcpu, port, data, size, false, NULL);
 	return true;
 }
 
-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
