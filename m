Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9253407EC
	for <lists+kvmarm@lfdr.de>; Thu, 18 Mar 2021 15:33:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF7274B758;
	Thu, 18 Mar 2021 10:33:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ljNE0rmpukL; Thu, 18 Mar 2021 10:33:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29C824B773;
	Thu, 18 Mar 2021 10:33:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 98DD54B74F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 10:33:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PLb5J8l9zTiI for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Mar 2021 10:33:17 -0400 (EDT)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9E5054B750
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 10:33:17 -0400 (EDT)
Received: by mail-qk1-f201.google.com with SMTP id p133so8024234qka.17
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=lwu0ik8K5xkKiPNmsNqdCf8yvD7kRadSzYnuuneaC20=;
 b=siGG9fIw7URqG65Iq/b8jMisHgvOw2J/gwb1zluqlmzIWGU+cJCJfn7iCgDrmSoWDT
 dC5ypgFwGC9U0KUF2TLUBaWx6x+XX5BjHfnF84SdXmFCXQAXjzDAgQOq86s9C5tav91t
 Y+g9X1AhD/8A9Cg35FUpmvgG+kV/29hbq6AwOAzXvns5XwAtzl8Tv9I+ThW0TGZBbk4I
 xGY4OXYtkhgqi7Dd7EpIcYTsAWZUD394wdhZz2tdm4lm4qfXKiNsrp+Af4KhFC1LK0HZ
 enzIBVCPzeYY5AhmMt41AoHdv0QZRMyreXjU3jkjw5VS2QRkLUXnrAK2vJ0t/xhWM5EK
 NZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=lwu0ik8K5xkKiPNmsNqdCf8yvD7kRadSzYnuuneaC20=;
 b=rJ1V69DcJkXALVEHygpcC6yHn7WPcYDBXqUCPekjNNqoC9rip76mmmTaxpthFk34/U
 XmonxwPjQO4cGmAnqGm8QtyPdobZt4rY3otzmOJ3XPgj88S4fNfX/FHINtD5kVgD4Pmt
 bEctFRRIGhS8yJk6PQBYbFCvlaFFS4swWCwrDTnAjJjl2fs2ECkI9Va9bZtWQC4lsWzm
 1E9VMopAHt8QGXJ1p4JzsGzWfziNvdrEIv8iWhK2kITrQbXeYoj5Qhe67iuzb5X88j9W
 hcZi1BCqSE0A/UKc/5KtKu3YVWlN5tEVb0wdfoKL1+KeYGecJkq51Wc/WsjgBSMV4NJ8
 QkHw==
X-Gm-Message-State: AOAM532Y/yEUZ15XYULEjswLiFJop8YdcmD/VzEreUDzpVPU0FzElQCo
 K0pHtB/bueWse7MEMsnCD7teJ+0lh952IHkebrrdqgYya0s8JpkInSkWmqag/sap8JbknVzudrC
 mnDJs1CH6obdDWYnyicBsGS5pdFv5qbzSL/BIPvCskVHwMPCk7slZievfJRLXwqHEpp8QJA==
X-Google-Smtp-Source: ABdhPJwCxJnuB3RBkvyga3pVL9EAlTkkKQoIsVDm6e4thF/Pi7BiZSgv4z4sBuFFA202dUeogOmODade85M=
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:a0c:f053:: with SMTP id
 b19mr4593533qvl.7.1616077997102; 
 Thu, 18 Mar 2021 07:33:17 -0700 (PDT)
Date: Thu, 18 Mar 2021 14:33:07 +0000
In-Reply-To: <20210318143311.839894-1-ascull@google.com>
Message-Id: <20210318143311.839894-2-ascull@google.com>
Mime-Version: 1.0
References: <20210318143311.839894-1-ascull@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v3 1/5] bug: Remove redundant condition check in report_bug
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
 maz@kernel.org, "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 catalin.marinas@arm.com, will@kernel.org
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

report_bug() will return early if it cannot find a bug corresponding to
the provided address. The subsequent test for the bug will always be
true so remove it.

Fixes: 1b4cfe3c0a30d ("lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()")
Signed-off-by: Andrew Scull <ascull@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bug.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/lib/bug.c b/lib/bug.c
index 8f9d537bfb2a..b92da1f6e21b 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -155,30 +155,27 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 
 	file = NULL;
 	line = 0;
-	warning = 0;
 
-	if (bug) {
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-		file = bug->file;
+	file = bug->file;
 #else
-		file = (const char *)bug + bug->file_disp;
+	file = (const char *)bug + bug->file_disp;
 #endif
-		line = bug->line;
+	line = bug->line;
 #endif
-		warning = (bug->flags & BUGFLAG_WARNING) != 0;
-		once = (bug->flags & BUGFLAG_ONCE) != 0;
-		done = (bug->flags & BUGFLAG_DONE) != 0;
-
-		if (warning && once) {
-			if (done)
-				return BUG_TRAP_TYPE_WARN;
-
-			/*
-			 * Since this is the only store, concurrency is not an issue.
-			 */
-			bug->flags |= BUGFLAG_DONE;
-		}
+	warning = (bug->flags & BUGFLAG_WARNING) != 0;
+	once = (bug->flags & BUGFLAG_ONCE) != 0;
+	done = (bug->flags & BUGFLAG_DONE) != 0;
+
+	if (warning && once) {
+		if (done)
+			return BUG_TRAP_TYPE_WARN;
+
+		/*
+		 * Since this is the only store, concurrency is not an issue.
+		 */
+		bug->flags |= BUGFLAG_DONE;
 	}
 
 	/*
-- 
2.31.0.rc2.261.g7f71774620-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
