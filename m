Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E6389B9A
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 05:05:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C6494B712;
	Wed, 19 May 2021 23:05:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUwLo7izB-hN; Wed, 19 May 2021 23:05:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B7DD4B59C;
	Wed, 19 May 2021 23:05:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 534B24B4B0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 23:05:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cv-dBSpG-bkT for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 May 2021 23:05:53 -0400 (EDT)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 351134B466
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 23:05:53 -0400 (EDT)
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Flvff052jzqV3M;
 Thu, 20 May 2021 11:02:18 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:05:33 +0800
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:05:32 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 "Jonathan Corbet" <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH] KVM: halt polling: Make the adjustment of polling time clearer
Date: Thu, 20 May 2021 11:05:29 +0800
Message-ID: <20210520030529.22048-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Cc: gaojinhao@huawei.com, zhang.zhanghailiang@huawei.com
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

When we have "block_ns > halt_poll_ns" and "block_ns < max_halt_poll_ns",
then "halt_poll_ns < max_halt_poll_ns" is true, so we can drop this extra
condition.

We want to make sure halt_poll_ns is not zero before shrinking it. Put
the condition in shrinking primitive can make code clearer.

None functional change.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 Documentation/virt/kvm/halt-polling.rst | 21 ++++++++++-----------
 virt/kvm/kvm_main.c                     | 11 ++++++-----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/halt-polling.rst b/Documentation/virt/kvm/halt-polling.rst
index 4922e4a15f18..d9f699395a7f 100644
--- a/Documentation/virt/kvm/halt-polling.rst
+++ b/Documentation/virt/kvm/halt-polling.rst
@@ -47,17 +47,16 @@ Thus this is a per vcpu (or vcore) value.
 During polling if a wakeup source is received within the halt polling interval,
 the interval is left unchanged. In the event that a wakeup source isn't
 received during the polling interval (and thus schedule is invoked) there are
-two options, either the polling interval and total block time[0] were less than
-the global max polling interval (see module params below), or the total block
-time was greater than the global max polling interval.
-
-In the event that both the polling interval and total block time were less than
-the global max polling interval then the polling interval can be increased in
-the hope that next time during the longer polling interval the wake up source
-will be received while the host is polling and the latency benefits will be
-received. The polling interval is grown in the function grow_halt_poll_ns() and
-is multiplied by the module parameters halt_poll_ns_grow and
-halt_poll_ns_grow_start.
+two options, either the total block time[0] were less than the global max
+polling interval (see module params below), or the total block time was greater
+than the global max polling interval.
+
+In the event that the total block time were less than the global max polling
+interval then the polling interval can be increased in the hope that next time
+during the longer polling interval the wake up source will be received while the
+host is polling and the latency benefits will be received. The polling interval
+is grown in the function grow_halt_poll_ns() and is multiplied by the module
+parameters halt_poll_ns_grow and halt_poll_ns_grow_start.
 
 In the event that the total block time was greater than the global max polling
 interval then the host will never poll for long enough (limited by the global
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6b4feb92dc79..13a9996c4ccb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2906,6 +2906,9 @@ static void shrink_halt_poll_ns(struct kvm_vcpu *vcpu)
 	unsigned int old, val, shrink;
 
 	old = val = vcpu->halt_poll_ns;
+	if (!old)
+		return;
+
 	shrink = READ_ONCE(halt_poll_ns_shrink);
 	if (shrink == 0)
 		val = 0;
@@ -3003,12 +3006,10 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 			if (block_ns <= vcpu->halt_poll_ns)
 				;
 			/* we had a long block, shrink polling */
-			else if (vcpu->halt_poll_ns &&
-					block_ns > vcpu->kvm->max_halt_poll_ns)
+			else if (block_ns > vcpu->kvm->max_halt_poll_ns)
 				shrink_halt_poll_ns(vcpu);
-			/* we had a short halt and our poll time is too small */
-			else if (vcpu->halt_poll_ns < vcpu->kvm->max_halt_poll_ns &&
-					block_ns < vcpu->kvm->max_halt_poll_ns)
+			/* we had a short block, grow polling */
+			else if (block_ns < vcpu->kvm->max_halt_poll_ns)
 				grow_halt_poll_ns(vcpu);
 		} else {
 			vcpu->halt_poll_ns = 0;
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
