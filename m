Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14E2C565F
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 14:46:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21F984BD0F;
	Thu, 26 Nov 2020 08:46:55 -0500 (EST)
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
	with ESMTP id Opjdv2QhLCti; Thu, 26 Nov 2020 08:46:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E4A584BD3B;
	Thu, 26 Nov 2020 08:46:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7919C4BD1F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 08:46:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q9qi8SEdGVZ5 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 08:46:51 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F4154BD0B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 08:46:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606398411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKc5aEKRgESznOyNqWAxSwkF4sfTwGCbJ8eNsRiWoLs=;
 b=RBM4d0d6nbSScpIlH48QA9IGDDfk39fs8Bve3TtYOD9wGLEo2tdOhknp8Ey9q/FrFgikNR
 DqT0oN87QSstk72AT/8xzhjUahCV9VIlbZEiOJ6hIdVyVjhtUiGWWPNSWeBcwJsRtwsvpf
 IOc5MXhYP0Pg06mUFWKoFx8vifG03KM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-SJKDpST2MqGnClnGXiWCAQ-1; Thu, 26 Nov 2020 08:46:49 -0500
X-MC-Unique: SJKDpST2MqGnClnGXiWCAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 278161015C80;
 Thu, 26 Nov 2020 13:46:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC253100239A;
 Thu, 26 Nov 2020 13:46:46 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 2/2] KVM: selftests: Filter out DEMUX registers
Date: Thu, 26 Nov 2020 14:46:41 +0100
Message-Id: <20201126134641.35231-3-drjones@redhat.com>
In-Reply-To: <20201126134641.35231-1-drjones@redhat.com>
References: <20201126134641.35231-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: maz@kernel.org, pbonzini@redhat.com
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

DEMUX register presence depends on the host's hardware (the
CLIDR_EL1 register to be precise). This means there's no set
of them that we can bless and that it's possible to encounter
new ones when running on different hardware (which would
generate "Consider adding them ..." messages, but we'll never
want to add them.)

Remove the ones we have in the blessed list and filter them
out of the new list, but also provide a new command line switch
to list them if one so desires.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 33218a395d9f..486932164cf2 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -42,12 +42,16 @@
 #define for_each_reg(i)								\
 	for ((i) = 0; (i) < reg_list->n; ++(i))
 
+#define for_each_reg_filtered(i)						\
+	for_each_reg(i)								\
+		if (!filter_reg(reg_list->reg[i]))
+
 #define for_each_missing_reg(i)							\
 	for ((i) = 0; (i) < blessed_n; ++(i))					\
 		if (!find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))
 
 #define for_each_new_reg(i)							\
-	for ((i) = 0; (i) < reg_list->n; ++(i))					\
+	for_each_reg_filtered(i)						\
 		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
 
 
@@ -57,6 +61,18 @@ static __u64 base_regs[], vregs[], sve_regs[], rejects_set[];
 static __u64 base_regs_n, vregs_n, sve_regs_n, rejects_set_n;
 static __u64 *blessed_reg, blessed_n;
 
+static bool filter_reg(__u64 reg)
+{
+	/*
+	 * DEMUX register presence depends on the host's CLIDR_EL1.
+	 * This means there's no set of them that we can bless.
+	 */
+	if ((reg & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return true;
+
+	return false;
+}
+
 static bool find_reg(__u64 regs[], __u64 nr_regs, __u64 reg)
 {
 	int i;
@@ -325,7 +341,7 @@ int main(int ac, char **av)
 	struct kvm_vcpu_init init = { .target = -1, };
 	int new_regs = 0, missing_regs = 0, i;
 	int failed_get = 0, failed_set = 0, failed_reject = 0;
-	bool print_list = false, fixup_core_regs = false;
+	bool print_list = false, print_filtered = false, fixup_core_regs = false;
 	struct kvm_vm *vm;
 	__u64 *vec_regs;
 
@@ -336,8 +352,10 @@ int main(int ac, char **av)
 			fixup_core_regs = true;
 		else if (strcmp(av[i], "--list") == 0)
 			print_list = true;
+		else if (strcmp(av[i], "--list-filtered") == 0)
+			print_filtered = true;
 		else
-			fprintf(stderr, "Ignoring unknown option: %s\n", av[i]);
+			TEST_FAIL("Unknown option: %s\n", av[i]);
 	}
 
 	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
@@ -350,10 +368,14 @@ int main(int ac, char **av)
 	if (fixup_core_regs)
 		core_reg_fixup();
 
-	if (print_list) {
+	if (print_list || print_filtered) {
 		putchar('\n');
-		for_each_reg(i)
-			print_reg(reg_list->reg[i]);
+		for_each_reg(i) {
+			__u64 id = reg_list->reg[i];
+			if ((print_list && !filter_reg(id)) ||
+			    (print_filtered && filter_reg(id)))
+				print_reg(id);
+		}
 		putchar('\n');
 		return 0;
 	}
@@ -458,6 +480,8 @@ int main(int ac, char **av)
 /*
  * The current blessed list was primed with the output of kernel version
  * v4.15 with --core-reg-fixup and then later updated with new registers.
+ *
+ * The blessed list is up to date with kernel version v5.10-rc5
  */
 static __u64 base_regs[] = {
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(regs.regs[0]),
@@ -736,9 +760,6 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 4, 3, 0, 0),	/* DACR32_EL2 */
 	ARM64_SYS_REG(3, 4, 5, 0, 1),	/* IFSR32_EL2 */
 	ARM64_SYS_REG(3, 4, 5, 3, 0),	/* FPEXC32_EL2 */
-	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX | KVM_REG_ARM_DEMUX_ID_CCSIDR | 0,
-	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX | KVM_REG_ARM_DEMUX_ID_CCSIDR | 1,
-	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX | KVM_REG_ARM_DEMUX_ID_CCSIDR | 2,
 };
 static __u64 base_regs_n = ARRAY_SIZE(base_regs);
 
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
