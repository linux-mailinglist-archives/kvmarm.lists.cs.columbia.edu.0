Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B9A3B3DAA4A
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 19:33:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D8774B0FD;
	Thu, 29 Jul 2021 13:33:15 -0400 (EDT)
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
	with ESMTP id 3cUYM9rWcidw; Thu, 29 Jul 2021 13:33:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51BF34B112;
	Thu, 29 Jul 2021 13:33:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F6614B0E5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 13:33:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7DpEdOirFNe9 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 13:33:11 -0400 (EDT)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 63D214B09B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 13:33:10 -0400 (EDT)
Received: by mail-qt1-f201.google.com with SMTP id
 e19-20020ac84b530000b0290251f0b91196so1726883qts.14
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=TH1Yvn79VJJ2udpoO34z2Zst9bnL7g3/15hMs2k9XrU=;
 b=RCcrGmTpe6zYpQ8AAlZ+gcpni5nA36NT5jhbrSl3vbAeWO6T12yCE0WZY0NqLb6qiy
 VF+Fj3BuutHCBqUYzErx+cj/MSmgq2BEOYPXjv5n/rWCGmxg3E4Lt5mSGA+Mv7PSg7Iz
 IpX1c4Lqs43XQxVCJPOqYGhD2F/mUer9TNikayLhKU3HfVB98aanqGxC2nA0+TMKPsnV
 6UATv2svEl1aHfHiKXMGZnSCrzAgFYJwjXxTXqLrU7weJZ3munj8CtOVknEHiajaqTPo
 z6eF+aweEk9vSymTy/fBzUkFqyYpWgxDnPucCJo+puhA7Q2SjGqnVvLr3xQE/cJCIBec
 e8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=TH1Yvn79VJJ2udpoO34z2Zst9bnL7g3/15hMs2k9XrU=;
 b=W3b+PVHnKjVXrxDD/b9JtWuts2kOpzf2YYw8xNK3xLMxbmQ2YHT+NXmqUp/cM936yK
 nl+nVRIzqqTXY92uAbWY/GPJPzSY3KcmBk9pOczT9NhzTkDq304qvvM4Lvy63BeautHu
 uIL0pnftHGyuWTgaL/IhtVc3KeXkaZBIhEyklqIdqDtCgtSSVSYHwuSkhB4qBZknJMCq
 7pkpXxIVe10kxd//6UXxTn3i4LXHZ3LQJKAMH/GeSby8R5tS1MmprdXksXdElY17zgEG
 uv2nJ2sAZywoFUbuMATkXP3OJ6GSbmO9JmnMM/eqCwECTVnZLryrHMUKRsq6Ik38S3hh
 9FPg==
X-Gm-Message-State: AOAM532DktD5tH8L4fMgq8N8SV0p+0xJp8JkhFFgM8oI1MhOY4+Hv+jQ
 CvLcZee4qnZpup+I1d2WIOfGUp+/e6g=
X-Google-Smtp-Source: ABdhPJxJhaIODfs4vcnvGnNLiNAMEqLIdRVuYp2xpMYT1VyfNmqQolmbkLuOOKN177hNR/gEMr029wKo6dU=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6214:84:: with SMTP id
 n4mr6508541qvr.4.1627579990026; Thu, 29 Jul 2021 10:33:10 -0700 (PDT)
Date: Thu, 29 Jul 2021 17:32:53 +0000
In-Reply-To: <20210729173300.181775-1-oupton@google.com>
Message-Id: <20210729173300.181775-7-oupton@google.com>
Mime-Version: 1.0
References: <20210729173300.181775-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v5 06/13] selftests: KVM: Fix kvm device helper ioctl
 assertions
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

The KVM_CREATE_DEVICE and KVM_{GET,SET}_DEVICE_ATTR ioctls are defined
to return a value of zero on success. As such, tighten the assertions in
the helper functions to only pass if the return code is zero.

Suggested-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 10a8ed691c66..0ffc2d39c80d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1984,7 +1984,7 @@ int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr)
 {
 	int ret = _kvm_device_check_attr(dev_fd, group, attr);
 
-	TEST_ASSERT(ret >= 0, "KVM_HAS_DEVICE_ATTR failed, rc: %i errno: %i", ret, errno);
+	TEST_ASSERT(!ret, "KVM_HAS_DEVICE_ATTR failed, rc: %i errno: %i", ret, errno);
 	return ret;
 }
 
@@ -2008,7 +2008,7 @@ int kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test)
 	ret = _kvm_create_device(vm, type, test, &fd);
 
 	if (!test) {
-		TEST_ASSERT(ret >= 0,
+		TEST_ASSERT(!ret,
 			    "KVM_CREATE_DEVICE IOCTL failed, rc: %i errno: %i", ret, errno);
 		return fd;
 	}
@@ -2036,7 +2036,7 @@ int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
 {
 	int ret = _kvm_device_access(dev_fd, group, attr, val, write);
 
-	TEST_ASSERT(ret >= 0, "KVM_SET|GET_DEVICE_ATTR IOCTL failed, rc: %i errno: %i", ret, errno);
+	TEST_ASSERT(!ret, "KVM_SET|GET_DEVICE_ATTR IOCTL failed, rc: %i errno: %i", ret, errno);
 	return ret;
 }
 
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
