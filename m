Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8565C3DAEA7
	for <lists+kvmarm@lfdr.de>; Fri, 30 Jul 2021 00:09:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C2764B0D8;
	Thu, 29 Jul 2021 18:09:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IVhInR+G6HUJ; Thu, 29 Jul 2021 18:09:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E86474B0EC;
	Thu, 29 Jul 2021 18:09:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E4A114B0D2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 18:09:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xkTgN2c+8UT for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 18:09:28 -0400 (EDT)
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1557C4B0D5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 18:09:28 -0400 (EDT)
Received: by mail-io1-f74.google.com with SMTP id
 k20-20020a6b6f140000b029053817be16cdso4653540ioc.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=OUDEC1vqPr7sdUdf2B7zr2nu10+QX6s5o8FUl8jn128=;
 b=afE61tmFlcKYV3syP0+ocrz06Dzk453aCfpsM5SdLvc9pXlbGValTdHId9+zvt7H+M
 wYkB0MblDqvsjNJQs3xi0hlRFhf5T2vW5CS2ZIv7ezpfpvzRtWEk9hygtiKge9mN1F9U
 WnKUVDYfMwPaMVDB778tT5OjBgssPZfqJsShDS+S+hY3M/4XbAe07rjzHqhnrsB3QOlh
 oDO1n0Hr+y+GJtvHFGUarcecAb9fZi4NVCmTTOKOsxmhlfSrIW1+GQ/kW8St9S68/pH6
 ZZ3P18M07QIcvNF07ClKQqYPgHfSkbBLFtoN8V027CGEypWH8yATHh6g3uqpDKBhxT3p
 U58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=OUDEC1vqPr7sdUdf2B7zr2nu10+QX6s5o8FUl8jn128=;
 b=O8MlUBtPs8Qs8ZCUg0gGDH84TJvvlvqWty6bFivRalkMcoRUL+lCPgZ48C7m+8Zard
 JbaqZufdENY8Vrg/9nTiv0QGYAISFWhU/S1DNe7LtiCunrFWEQTYnUrtzPx8vetl1WIK
 9H6N/9cxaiNTZ8DenzlaJdAMq3ncENdo1DHSVve4Fqlg6SinQSAnMsOFGpodmGbu/qip
 vJptp5j6eMAlSYr3N5p3nFtRMO7uf8/0h94UjvRa9kTADuPBtzkRYJmaH8QpNE+Twuux
 a61yhbUosvVnuOHnG6NuW+4XuFQGXQYFK1ezTivshLpCI3VCyyidqKUhLDQeEKHUC6Av
 LV+w==
X-Gm-Message-State: AOAM530g6jYJkTqyqLC+zPwBT8xfscfKOwhkVtvCTztQcmoxbWMViwwc
 RMw5/ZnT5ZBkv7DIa1tN1jsPcmzkR83uOkRynGERu40hGd3YagpHzM1EWwAv0bWqHNKWsre9xfh
 12+/GRGwnV7Ka13CluPEBCcplkt2d8p3qeGRFUH0NRmPFd3tK9cEjvem37fEhpYkN+jLGsA==
X-Google-Smtp-Source: ABdhPJynKEKZCh3Kk0HnLCvNi7Sc5MHDpzqm8Ql84cT0T630dSbB3HhwdbM09/xE2CFjkssQ6KG4bWN3Y/U=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a02:b058:: with SMTP id
 q24mr117122jah.88.1627596567382; 
 Thu, 29 Jul 2021 15:09:27 -0700 (PDT)
Date: Thu, 29 Jul 2021 22:09:15 +0000
In-Reply-To: <20210729220916.1672875-1-oupton@google.com>
Message-Id: <20210729220916.1672875-3-oupton@google.com>
Mime-Version: 1.0
References: <20210729220916.1672875-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2 2/3] entry: KVM: Allow use of generic KVM entry w/o full
 generic support
From: Oliver Upton <oupton@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: Shakeel Butt <shakeelb@google.com>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Guangyu Shi <guangyus@google.com>, Will Deacon <will@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
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

Some architectures (e.g. arm64) have yet to adopt the generic entry
infrastructure. Despite that, it would be nice to use some common
plumbing for guest entry/exit handling. For example, KVM/arm64 currently
does not handle TIF_NOTIFY_PENDING correctly.

Allow use of only the generic KVM entry code by tightening up the
include list. No functional change intended.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 include/linux/entry-kvm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 136b8d97d8c0..0d7865a0731c 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -2,7 +2,11 @@
 #ifndef __LINUX_ENTRYKVM_H
 #define __LINUX_ENTRYKVM_H
 
-#include <linux/entry-common.h>
+#include <linux/static_call_types.h>
+#include <linux/tracehook.h>
+#include <linux/syscalls.h>
+#include <linux/seccomp.h>
+#include <linux/sched.h>
 #include <linux/tick.h>
 
 /* Transfer to guest mode work */
-- 
2.32.0.554.ge1b32706d8-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
