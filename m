Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6F2143DCC
	for <lists+kvmarm@lfdr.de>; Tue, 21 Jan 2020 14:18:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3053A4AECD;
	Tue, 21 Jan 2020 08:18:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YHPjg02zx1Dl; Tue, 21 Jan 2020 08:18:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADE774B020;
	Tue, 21 Jan 2020 08:17:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1EC3D4B019
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 08:17:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fqFc3g6cy8BX for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Jan 2020 08:17:57 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AFB14B023
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 08:17:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579612675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYCjGxzJCWEwpMFHkJ6WPIm1RckrAtr3ks7PkFNvEmw=;
 b=bczA6WgFy+siNWBYvgIGntc/1KJKYI+IgSb5fRXDXuTicdeC1Op9EeLBvEcq97AvfZ1S6u
 g/dhLWXSuzyVC52xLyWl7DbHD5pMACXuSZnOCh/6mAKaQjP4bArOZoEgv0NJBFAndONfpm
 hWF5qr25NFpm3JkzaTcRdfZWXk3her8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-PWsKZbK5MwC71CbYSz9OuQ-1; Tue, 21 Jan 2020 08:17:52 -0500
X-MC-Unique: PWsKZbK5MwC71CbYSz9OuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09EB410509B6;
 Tue, 21 Jan 2020 13:17:51 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C488B10842AC;
 Tue, 21 Jan 2020 13:17:49 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvm-unit-tests 2/3] arm/arm64: selftest: Allow test_exception
 clobber list to be extended
Date: Tue, 21 Jan 2020 14:17:44 +0100
Message-Id: <20200121131745.7199-3-drjones@redhat.com>
In-Reply-To: <20200121131745.7199-1-drjones@redhat.com>
References: <20200121131745.7199-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: pbonzini@redhat.com
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

test_exception() callers may need to extend the clobber list. Also
there's no reason for the callers to need to assume that R0 and R1
are already in the list.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/selftest.c | 105 ++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 54 deletions(-)

diff --git a/arm/selftest.c b/arm/selftest.c
index 89759cf9f592..6d74fa1fa4c4 100644
--- a/arm/selftest.c
+++ b/arm/selftest.c
@@ -74,24 +74,22 @@ static bool svc_works;
  * that causes an exception. The test handler will check that its
  * capture of the current register state matches the capture done
  * here.
- *
- * NOTE: update clobber list if passed insns needs more than r0,r1
  */
-#define test_exception(pre_insns, excptn_insn, post_insns)	\
-	asm volatile(						\
-		pre_insns "\n"					\
-		"mov	r0, %0\n"				\
-		"stmia	r0, { r0-lr }\n"			\
-		"mrs	r1, cpsr\n"				\
-		"str	r1, [r0, #" xstr(S_PSR) "]\n"		\
-		"mov	r1, #-1\n"				\
-		"str	r1, [r0, #" xstr(S_OLD_R0) "]\n"	\
-		"add	r1, pc, #8\n"				\
-		"str	r1, [r0, #" xstr(S_R1) "]\n"		\
-		"str	r1, [r0, #" xstr(S_PC) "]\n"		\
-		excptn_insn "\n"				\
-		post_insns "\n"					\
-	:: "r" (&expected_regs) : "r0", "r1")
+#define test_exception(pre_insns, excptn_insn, post_insns, clobbers...)	\
+	asm volatile(							\
+		pre_insns "\n"						\
+		"mov	r0, %0\n"					\
+		"stmia	r0, { r0-lr }\n"				\
+		"mrs	r1, cpsr\n"					\
+		"str	r1, [r0, #" xstr(S_PSR) "]\n"			\
+		"mov	r1, #-1\n"					\
+		"str	r1, [r0, #" xstr(S_OLD_R0) "]\n"		\
+		"add	r1, pc, #8\n"					\
+		"str	r1, [r0, #" xstr(S_R1) "]\n"			\
+		"str	r1, [r0, #" xstr(S_PC) "]\n"			\
+		excptn_insn "\n"					\
+		post_insns "\n"						\
+	:: "r" (&expected_regs) : "r0", "r1", ##clobbers)
 
 static bool check_regs(struct pt_regs *regs)
 {
@@ -119,7 +117,7 @@ static bool check_und(void)
 	install_exception_handler(EXCPTN_UND, und_handler);
 
 	/* issue an instruction to a coprocessor we don't have */
-	test_exception("", "mcr p2, 0, r0, c0, c0", "");
+	test_exception("", "mcr p2, 0, r0, c0, c0", "", "r0");
 
 	install_exception_handler(EXCPTN_UND, NULL);
 
@@ -156,7 +154,8 @@ static bool check_svc(void)
 			"push	{ r0,lr }\n",
 			"svc	#123\n",
 			"pop	{ r0,lr }\n"
-			"msr	spsr_cxsf, r0\n"
+			"msr	spsr_cxsf, r0\n",
+			"r0", "lr"
 		);
 	} else {
 		test_exception("", "svc #123", "");
@@ -178,41 +177,39 @@ static void user_psci_system_off(struct pt_regs *regs)
  * that causes an exception. The test handler will check that its
  * capture of the current register state matches the capture done
  * here.
- *
- * NOTE: update clobber list if passed insns needs more than x0,x1
  */
-#define test_exception(pre_insns, excptn_insn, post_insns)	\
-	asm volatile(						\
-		pre_insns "\n"					\
-		"mov	x1, %0\n"				\
-		"ldr	x0, [x1, #" xstr(S_PSTATE) "]\n"	\
-		"mrs	x1, nzcv\n"				\
-		"orr	w0, w0, w1\n"				\
-		"mov	x1, %0\n"				\
-		"str	w0, [x1, #" xstr(S_PSTATE) "]\n"	\
-		"mov	x0, sp\n"				\
-		"str	x0, [x1, #" xstr(S_SP) "]\n"		\
-		"adr	x0, 1f\n"				\
-		"str	x0, [x1, #" xstr(S_PC) "]\n"		\
-		"stp	 x2,  x3, [x1,  #16]\n"			\
-		"stp	 x4,  x5, [x1,  #32]\n"			\
-		"stp	 x6,  x7, [x1,  #48]\n"			\
-		"stp	 x8,  x9, [x1,  #64]\n"			\
-		"stp	x10, x11, [x1,  #80]\n"			\
-		"stp	x12, x13, [x1,  #96]\n"			\
-		"stp	x14, x15, [x1, #112]\n"			\
-		"stp	x16, x17, [x1, #128]\n"			\
-		"stp	x18, x19, [x1, #144]\n"			\
-		"stp	x20, x21, [x1, #160]\n"			\
-		"stp	x22, x23, [x1, #176]\n"			\
-		"stp	x24, x25, [x1, #192]\n"			\
-		"stp	x26, x27, [x1, #208]\n"			\
-		"stp	x28, x29, [x1, #224]\n"			\
-		"str	x30, [x1, #" xstr(S_LR) "]\n"		\
-		"stp	 x0,  x1, [x1]\n"			\
-	"1:"	excptn_insn "\n"				\
-		post_insns "\n"					\
-	:: "r" (&expected_regs) : "x0", "x1")
+#define test_exception(pre_insns, excptn_insn, post_insns, clobbers...)	\
+	asm volatile(							\
+		pre_insns "\n"						\
+		"mov	x1, %0\n"					\
+		"ldr	x0, [x1, #" xstr(S_PSTATE) "]\n"		\
+		"mrs	x1, nzcv\n"					\
+		"orr	w0, w0, w1\n"					\
+		"mov	x1, %0\n"					\
+		"str	w0, [x1, #" xstr(S_PSTATE) "]\n"		\
+		"mov	x0, sp\n"					\
+		"str	x0, [x1, #" xstr(S_SP) "]\n"			\
+		"adr	x0, 1f\n"					\
+		"str	x0, [x1, #" xstr(S_PC) "]\n"			\
+		"stp	 x2,  x3, [x1,  #16]\n"				\
+		"stp	 x4,  x5, [x1,  #32]\n"				\
+		"stp	 x6,  x7, [x1,  #48]\n"				\
+		"stp	 x8,  x9, [x1,  #64]\n"				\
+		"stp	x10, x11, [x1,  #80]\n"				\
+		"stp	x12, x13, [x1,  #96]\n"				\
+		"stp	x14, x15, [x1, #112]\n"				\
+		"stp	x16, x17, [x1, #128]\n"				\
+		"stp	x18, x19, [x1, #144]\n"				\
+		"stp	x20, x21, [x1, #160]\n"				\
+		"stp	x22, x23, [x1, #176]\n"				\
+		"stp	x24, x25, [x1, #192]\n"				\
+		"stp	x26, x27, [x1, #208]\n"				\
+		"stp	x28, x29, [x1, #224]\n"				\
+		"str	x30, [x1, #" xstr(S_LR) "]\n"			\
+		"stp	 x0,  x1, [x1]\n"				\
+	"1:"	excptn_insn "\n"					\
+		post_insns "\n"						\
+	:: "r" (&expected_regs) : "x0", "x1", ##clobbers)
 
 static bool check_regs(struct pt_regs *regs)
 {
@@ -260,7 +257,7 @@ static bool check_und(void)
 	install_exception_handler(v, ESR_EL1_EC_UNKNOWN, unknown_handler);
 
 	/* try to read an el2 sysreg from el0/1 */
-	test_exception("", "mrs x0, sctlr_el2", "");
+	test_exception("", "mrs x0, sctlr_el2", "", "x0");
 
 	install_exception_handler(v, ESR_EL1_EC_UNKNOWN, NULL);
 
-- 
2.21.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
