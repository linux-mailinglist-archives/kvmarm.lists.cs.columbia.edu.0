Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D28B5599EEE
	for <lists+kvmarm@lfdr.de>; Fri, 19 Aug 2022 18:21:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 343F24C78B;
	Fri, 19 Aug 2022 12:21:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88j0zFeRBW5j; Fri, 19 Aug 2022 12:21:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 08F104C78D;
	Fri, 19 Aug 2022 12:21:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 454CE4C786
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Aug 2022 12:21:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ugxw3H+XoVDT for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Aug 2022 12:21:11 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E9FDB4C78A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Aug 2022 12:21:10 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1660926070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5hkt6s+kNeBeIfkMLCBhtmNEE4XpaiKh/lt918dPnd0=;
 b=kmyW5NALJA/IWF7+aNqifmKM6VmbO+VGRyI/MIPPXjd+bLP4ePxgJ183oed0sF7O2Lb6ly
 l5z7FG+AO5zZVOL30StU6yxtit8hfukRfFjfeIIc8R4pS4AvVtpcPpf+ztLKq0g65toIEI
 JF8kPoVkWCToADVBuyrfQbKrO6ZKcMo=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Subject: [RESEND PATCH] KVM: selftests: Update top-of-file comment in psci_test
Date: Fri, 19 Aug 2022 16:21:00 +0000
Message-Id: <20220819162100.213854-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

Fix the comment to accurately describe the test and recently added
SYSTEM_SUSPEND test case.

What was once psci_cpu_on_test was renamed and extended to squeeze in a
test case for PSCI SYSTEM_SUSPEND. Nonetheless, the author of those
changes (whoever they may be...) failed to update the file comment to
reflect what had changed.

Reported-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---

Forgetting the name of the darned UAPI event. Tsk tsk.

 tools/testing/selftests/kvm/aarch64/psci_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index f7621f6e938e..e0b9e81a3e09 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * psci_cpu_on_test - Test that the observable state of a vCPU targeted by the
- * CPU_ON PSCI call matches what the caller requested.
+ * psci_test - Tests relating to KVM's PSCI implementation.
  *
  * Copyright (c) 2021 Google LLC.
  *
- * This is a regression test for a race between KVM servicing the PSCI call and
- * userspace reading the vCPUs registers.
+ * This test includes:
+ *  - A regression test for a race between KVM servicing the PSCI CPU_ON call
+ *    and userspace reading the targeted vCPU's registers.
+ *  - A test for KVM's handling of PSCI SYSTEM_SUSPEND and the associated
+ *    KVM_SYSTEM_EVENT_SUSPEND UAPI.
  */
 
 #define _GNU_SOURCE

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1.595.g718a3a8f04-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
