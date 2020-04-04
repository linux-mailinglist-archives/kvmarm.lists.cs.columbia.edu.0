Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BB19E59C
	for <lists+kvmarm@lfdr.de>; Sat,  4 Apr 2020 16:38:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E070F4B1FB;
	Sat,  4 Apr 2020 10:38:00 -0400 (EDT)
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
	with ESMTP id QcJWqNakYZWS; Sat,  4 Apr 2020 10:38:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEB234B1F4;
	Sat,  4 Apr 2020 10:37:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B3B94B1E8
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:37:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ySLy283GS+Go for <kvmarm@lists.cs.columbia.edu>;
 Sat,  4 Apr 2020 10:37:56 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F49F4B19D
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586011075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+W8aLqjWNoS2hm7NQW8E99+QZ2PFnvwa+mg/8to+p4=;
 b=EH/9ue7RAfzZcL1HVqD38VAaqqx/Wkm7oSANADA8ErfoHctUeguRilwf3bWonQLQ4YMEhg
 Nc+elNWhymlAyqODginYqZ0MCy1C8wtYBuRqEKuIyNW/KWN43+ZQCyTUXd+ZRo8mj5xiaC
 OL+nLlleexgmboZZVfogQHTDoKTAvkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-wdevQmdpNLKDzTmd4c2rTA-1; Sat, 04 Apr 2020 10:37:53 -0400
X-MC-Unique: wdevQmdpNLKDzTmd4c2rTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8330518AB2DA;
 Sat,  4 Apr 2020 14:37:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B0089B912;
 Sat,  4 Apr 2020 14:37:44 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: pbonzini@redhat.com
Subject: [PULL kvm-unit-tests 03/39] arm64: timer: Add ISB after register
 writes
Date: Sat,  4 Apr 2020 16:36:55 +0200
Message-Id: <20200404143731.208138-4-drjones@redhat.com>
In-Reply-To: <20200404143731.208138-1-drjones@redhat.com>
References: <20200404143731.208138-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

From: Alexandru Elisei <alexandru.elisei@arm.com>

From ARM DDI 0487E.a glossary, the section "Context synchronization
event":

"All direct and indirect writes to System registers that are made before
the Context synchronization event affect any instruction, including a
direct read, that appears in program order after the instruction causing
the Context synchronization event."

The ISB instruction is a context synchronization event [1]. Add an ISB
after all register writes, to make sure that the writes have been
completed when we try to test their effects.

[1] ARM DDI 0487E.a, section C6.2.96

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/timer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arm/timer.c b/arm/timer.c
index f390e8e65d31..c6ea108cfa4b 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -41,6 +41,7 @@ static u64 read_vtimer_cval(void)
 static void write_vtimer_cval(u64 val)
 {
 	write_sysreg(val, cntv_cval_el0);
+	isb();
 }
 
 static s32 read_vtimer_tval(void)
@@ -51,6 +52,7 @@ static s32 read_vtimer_tval(void)
 static void write_vtimer_tval(s32 val)
 {
 	write_sysreg(val, cntv_tval_el0);
+	isb();
 }
 
 static u64 read_vtimer_ctl(void)
@@ -61,6 +63,7 @@ static u64 read_vtimer_ctl(void)
 static void write_vtimer_ctl(u64 val)
 {
 	write_sysreg(val, cntv_ctl_el0);
+	isb();
 }
 
 static u64 read_ptimer_counter(void)
@@ -76,6 +79,7 @@ static u64 read_ptimer_cval(void)
 static void write_ptimer_cval(u64 val)
 {
 	write_sysreg(val, cntp_cval_el0);
+	isb();
 }
 
 static s32 read_ptimer_tval(void)
@@ -86,6 +90,7 @@ static s32 read_ptimer_tval(void)
 static void write_ptimer_tval(s32 val)
 {
 	write_sysreg(val, cntp_tval_el0);
+	isb();
 }
 
 static u64 read_ptimer_ctl(void)
@@ -96,6 +101,7 @@ static u64 read_ptimer_ctl(void)
 static void write_ptimer_ctl(u64 val)
 {
 	write_sysreg(val, cntp_ctl_el0);
+	isb();
 }
 
 struct timer_info {
@@ -181,7 +187,6 @@ static bool test_cval_10msec(struct timer_info *info)
 	before_timer = info->read_counter();
 	info->write_cval(before_timer + time_10ms);
 	info->write_ctl(ARCH_TIMER_CTL_ENABLE);
-	isb();
 
 	/* Wait for the timer to fire */
 	while (!(info->read_ctl() & ARCH_TIMER_CTL_ISTATUS))
@@ -217,11 +222,9 @@ static void test_timer(struct timer_info *info)
 	/* Enable the timer, but schedule it for much later */
 	info->write_cval(later);
 	info->write_ctl(ARCH_TIMER_CTL_ENABLE);
-	isb();
 	report(!gic_timer_pending(info), "not pending before");
 
 	info->write_cval(now - 1);
-	isb();
 	report(gic_timer_pending(info), "interrupt signal pending");
 
 	/* Disable the timer again and prepare to take interrupts */
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
