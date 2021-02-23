Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BFA16322E20
	for <lists+kvmarm@lfdr.de>; Tue, 23 Feb 2021 16:58:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 631BE4B1A7;
	Tue, 23 Feb 2021 10:58:11 -0500 (EST)
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
	with ESMTP id ZlQeZmWhuEV3; Tue, 23 Feb 2021 10:58:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ABE14B1FB;
	Tue, 23 Feb 2021 10:58:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5625C4B1A7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Feb 2021 10:58:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mln8HGQyVIbu for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Feb 2021 10:58:07 -0500 (EST)
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E64914B1A8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Feb 2021 10:58:06 -0500 (EST)
Received: by mail-wr1-f73.google.com with SMTP id l3so5885483wrx.15
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Feb 2021 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=CQEfesAGh6Yaxupcr8w3bDyhXlptt6J3Yf5vNzEZ7xI=;
 b=ahJMz/9QD//FktmI3FiYI5kZv2HmCwtxm6T0qpp83ZVG11ijWrwdYwZhWhlWBJ+CEk
 1jnG0OcblYWp0DVJ2dRRxnnLq+pq/xlYOWPblGlAnVTe4mmpgGKdY6ht57WvK4H62vTB
 CGC8mOl2P3AhVSh0z/+sXRUnjWeANK35861+rdXPjXd7vpwV2nV7e4gUfGh750HKKDJX
 r78EbvODYloUoicbFLZE55MmD1KVG5MrrSLwvm8nefA6P2EJdhqCH+x+jCmeDqeLQ68e
 oDb0F8nFaTaHd77uYGBKUBqhEv8gIzKcfslPSAY4HgpmgTHHKG5egD0k3uoCse1RY+Nw
 ZaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=CQEfesAGh6Yaxupcr8w3bDyhXlptt6J3Yf5vNzEZ7xI=;
 b=fLnHaDNMBwdvLgn8z3lBS4SOaQhUHftoksYvGv19Wrq33NGS23iwC6dXiW9KU9PvAC
 i2B9V81HEj7pPlyIELPz7EaLkUUUsfULTTFyRlz2c6/Nv6hgVhiLEjrRyIOpJiSEIUHa
 hEkjdZBeVNuEFGycehTP3FVpnzZV3gWjwteVGPmH0gQALQsV638lOwrot2FBL+V16y8M
 OdWzfD9LubI4kBhR6oawkNTm1sHz7mkAU5AgBeWmFXJ8D3MJVZZVZ3NW7m6z4G+rtvIW
 RJNPeYJBASX7hHOX+a6D7QmYtVGAjVu6ztuuVXeBOfGbgv8Ki1rt5+n491s6KE7zLw6Q
 1VIA==
X-Gm-Message-State: AOAM531VFodA05PD0x4/bH2OIFA7vtEmCPzhtCPDMe9mcqcJ4xTPHWU+
 rTcx0lXhPOz6fK8CuHSS6/Tri4n00Iq792dvi3fah3hX2wGi6bt3mqqSHRCotjVkCUlEhPu3/+q
 z8+iW2Ug2eD9D9fBs772Vpx5x/0mo2utxuF2v4KcWC6VCW8y4+aCI9cl8yXRUAbIkdYYGsA==
X-Google-Smtp-Source: ABdhPJx243HHOgDuZVZvZaJGT0iEdqLHawYC1nTIPMVKhxwcycsNTCwKSh8mZBNkhlNs39I7Nz8grf21hKw=
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:a1c:17:: with SMTP id
 23mr216919wma.6.1614095885613; 
 Tue, 23 Feb 2021 07:58:05 -0800 (PST)
Date: Tue, 23 Feb 2021 15:57:56 +0000
In-Reply-To: <20210223155759.3495252-1-ascull@google.com>
Message-Id: <20210223155759.3495252-2-ascull@google.com>
Mime-Version: 1.0
References: <20210223155759.3495252-1-ascull@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 1/4] bug: Remove redundant condition check in report_bug
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>, catalin.marinas@arm.com,
 will@kernel.org
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

Signed-off-by: Andrew Scull <ascull@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
---
 lib/bug.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/lib/bug.c b/lib/bug.c
index 7103440c0ee1..4ab398a2de93 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -158,30 +158,27 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 
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
2.30.0.617.g56c4b15f3c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
