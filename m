Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 03B863F0D55
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 23:29:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C9F14B0D7;
	Wed, 18 Aug 2021 17:29:50 -0400 (EDT)
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
	with ESMTP id 4tX3pQNmPMUH; Wed, 18 Aug 2021 17:29:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FF0B4B0D4;
	Wed, 18 Aug 2021 17:29:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 24C254B0AC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 17:29:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBuYW-+8VzCJ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 17:29:43 -0400 (EDT)
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1AEA14B0D4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 17:29:43 -0400 (EDT)
Received: by mail-io1-f74.google.com with SMTP id
 d23-20020a056602281700b005b5b34670c7so1993428ioe.12
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=r0FgUlCJu9+wIAf52h2bi1oS9KbPICUGE0YYTryeif4=;
 b=GGlQqDPl+00f6Sw7Ej0S+LP6MVGJpkd0Q6zAxuztEEw0vrQohIjWqGQtZaUDxPJmBM
 liFqt/gLOvHtLDd3mhe+QH4v24BGdhFnuF4aQUyAnx9fU/JAZjQ+ie+aGO/8dET0tNug
 5/bibVsZwTNmAszZouYcnULfpF/eTGM95aptt9UHk0trQ5h9sX0RfzPVdzEm9rqJU7lh
 jzEAfEMiRGTvGK4tI6rAunZip4C7M9te4LxqdiZ0mF8e7R/nWRl7dc5nu7QIAwNO/4RK
 qlRQ1++dsIzwypVhhXnuYXLG4Iii0HvJy21Jx4itlXOjU5k9POjUu0MSDLvtdc5+zpsQ
 0V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=r0FgUlCJu9+wIAf52h2bi1oS9KbPICUGE0YYTryeif4=;
 b=qcJvTTXMPmf3U/fAI71ruwcTeKVF25U981dU+teLUbGIyh6+mAJ3rxk0jWQsQYd3yW
 8+ltHrLNHMD098wRWb/rWVdtiQPOvKvQqx8e1SVQuJ2QAmimEMXWjb9k7Bp4qZgmwvnW
 Y3QqjDJsRFLD4mOZ+r4rSKmCHNVeXaQ8S6za0P3oH3JA14/vtlZu19rL916p5312Ejyt
 Z4oyKgAfWMRU+FFIGxc1l8N520TKdjYq9iKEdyogoSRfQKBpoNKraeIdmpcvt+m1XGdp
 4CCt+pkAQ1Y4/OtEdqWp/ld5giplzNS2HNVQe69Tut8CT46gGe+/zC84E4OS9/P+K9OE
 9K2Q==
X-Gm-Message-State: AOAM5308licYLBl3/kffC8CFzCm0pk6RXi8JWT/x9ZjvYvShX+dh1GQt
 EqaOKAeb7WsxkLU0Qh4KOCJp/VD//BQ=
X-Google-Smtp-Source: ABdhPJz3u9ty537z/NPYa/tLv11Wq28UhMlKAPaNZSneh5bzjU0yVDovnyinmUVLtziNrE8PCJFBj/VpU1g=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a02:860d:: with SMTP id
 e13mr9986329jai.12.1629322182458; 
 Wed, 18 Aug 2021 14:29:42 -0700 (PDT)
Date: Wed, 18 Aug 2021 21:29:40 +0000
Message-Id: <20210818212940.1382549-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] selftests: KVM: Gracefully handle missing vCPU features
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Raghavendra Rao Anata <rananta@google.com>
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

An error of ENOENT for the KVM_ARM_VCPU_INIT ioctl indicates that one of
the requested feature flags is not supported by the kernel/hardware.
Detect the case when KVM doesn't support the requested features and skip
the test rather than failing it.

Cc: Andrew Jones <drjones@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
Applies to 5.14-rc6. Tested by running all selftests on an Ampere Mt.
Jade system.

 .../testing/selftests/kvm/lib/aarch64/processor.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 632b74d6b3ca..b1064a0c5e62 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -216,6 +216,7 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
 {
 	struct kvm_vcpu_init default_init = { .target = -1, };
 	uint64_t sctlr_el1, tcr_el1;
+	int ret;
 
 	if (!init)
 		init = &default_init;
@@ -226,7 +227,19 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
 		init->target = preferred.target;
 	}
 
-	vcpu_ioctl(vm, vcpuid, KVM_ARM_VCPU_INIT, init);
+	ret = _vcpu_ioctl(vm, vcpuid, KVM_ARM_VCPU_INIT, init);
+
+	/*
+	 * Missing kernel feature support should result in skipping the test,
+	 * not failing it.
+	 */
+	if (ret && errno == ENOENT) {
+		print_skip("requested vCPU features not supported; skipping test.");
+		exit(KSFT_SKIP);
+	}
+
+	TEST_ASSERT(!ret, "KVM_ARM_VCPU_INIT failed, rc: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
 
 	/*
 	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
