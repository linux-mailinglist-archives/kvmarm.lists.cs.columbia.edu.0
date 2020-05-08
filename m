Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 260711CAA57
	for <lists+kvmarm@lfdr.de>; Fri,  8 May 2020 14:11:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCB314B1EB;
	Fri,  8 May 2020 08:11:17 -0400 (EDT)
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
	with ESMTP id BamzKIKyF1iy; Fri,  8 May 2020 08:11:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 715274B1E5;
	Fri,  8 May 2020 08:11:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A11834B561
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 23:31:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Wa5IZ1QdRkL for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 May 2020 23:31:16 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DBBA24B54E
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 23:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588908676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8MHh9dyvpe8bslvZNsUP5j2B3v4NSqfl6A+NT0wxD4=;
 b=BC5rWRRzCn4QvHcORTqm3ZaoPOdFeOEoTjuK0yb618C1oQ8s7F4f9gGCDADJWYXCRVRWLO
 PxFYUpnnlGQaFv0+aVL7tUVZ0aynzoJCW7fC7DhBcev+tYLA039RRvvZPijSG5CzBZq3vA
 alHrkvq1na6SQXYERuOyPu44DQgEHrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-kwm_sW8LPE6l4dM0Y68Z0w-1; Thu, 07 May 2020 23:31:13 -0400
X-MC-Unique: kwm_sW8LPE6l4dM0Y68Z0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6762D107ACCA;
 Fri,  8 May 2020 03:31:11 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-199.bne.redhat.com
 [10.64.54.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 783242E052;
 Fri,  8 May 2020 03:31:03 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH RFCv2 8/9] kernel/sched: Add cpu_rq_is_locked()
Date: Fri,  8 May 2020 13:29:18 +1000
Message-Id: <20200508032919.52147-9-gshan@redhat.com>
In-Reply-To: <20200508032919.52147-1-gshan@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mailman-Approved-At: Fri, 08 May 2020 08:11:07 -0400
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

This adds API cpu_rq_is_locked() to check if the CPU's runqueue has been
locked or not. It's used in the subsequent patch to determine the task
wakeup should be executed immediately or delayed.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/core.c   | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..e68882443da7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1691,6 +1691,7 @@ extern struct task_struct *find_task_by_pid_ns(pid_t nr, struct pid_namespace *n
  */
 extern struct task_struct *find_get_task_by_vpid(pid_t nr);
 
+extern bool cpu_rq_is_locked(int cpu);
 extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..30f4a8845495 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -73,6 +73,14 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+bool cpu_rq_is_locked(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return raw_spin_is_locked(&rq->lock) ? true :  false;
+}
+EXPORT_SYMBOL_GPL(cpu_rq_is_locked);
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
