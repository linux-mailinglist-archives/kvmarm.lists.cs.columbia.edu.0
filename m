Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 261D51B05B
	for <lists+kvmarm@lfdr.de>; Mon, 13 May 2019 08:32:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 422974A4F0;
	Mon, 13 May 2019 02:32:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.098
X-Spam-Level: 
X-Spam-Status: No, score=0.098 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3Zi+shxy26f; Mon, 13 May 2019 02:32:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DFB414A4EE;
	Mon, 13 May 2019 02:32:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D0274A4DF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 May 2019 02:32:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxPIllxKmcN7 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 May 2019 02:32:13 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 778A94A3B2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 May 2019 02:32:13 -0400 (EDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4339F9940403AE8FA378;
 Mon, 13 May 2019 14:32:09 +0800 (CST)
Received: from ros.huawei.com (10.143.28.118) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 13 May 2019 14:32:00 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
 <peter.maydell@linaro.org>, <james.morse@arm.com>, <rkrcmar@redhat.com>,
 <corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
 <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH V2] kvm: arm64: export memory error recovery capability to
 user space
Date: Sun, 12 May 2019 23:28:37 -0700
Message-ID: <1557728917-49079-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.143.28.118]
X-CFilter-Loop: Reflected
Cc: gengdongjiu@huawei.com
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

When user space do memory recovery, it will check whether KVM and
guest support the error recovery, only when both of them support,
user space will do the error recovery. This patch exports this
capability of KVM to user space.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
v1->v2:
1. check whether host support memory failure instead of RAS capability
   https://patchwork.kernel.org/patch/10730827/

v1:
1. User space needs to check this capability of host is suggested by Peter[1],
this patch as RFC tag because user space patches are still under review,
so this kernel patch is firstly sent out for review.

[1]: https://patchwork.codeaurora.org/patch/652261/
---
 Documentation/virtual/kvm/api.txt | 9 +++++++++
 arch/arm64/kvm/reset.c            | 3 +++
 include/uapi/linux/kvm.h          | 1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index cd209f7..822a57b 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4895,3 +4895,12 @@ Architectures: x86
 This capability indicates that KVM supports paravirtualized Hyper-V IPI send
 hypercalls:
 HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
+
+8.21 KVM_CAP_ARM_MEMORY_ERROR_RECOVERY
+
+Architectures: arm, arm64
+
+This capability indicates that guest memory error can be detected by the host which
+supports the error recovery. When user space do recovery, such as QEMU, it will
+check whether host and guest all support memory error recovery, only when both of them
+support, user space will do the error recovery.
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b72a3dd..b6e3986 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -84,6 +84,9 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_INJECT_SERROR_ESR:
 		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
 		break;
+	case KVM_CAP_ARM_MEMORY_ERROR_RECOVERY:
+		r= IS_ENABLED(CONFIG_MEMORY_FAILURE);
+		break;
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
 		r = 1;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2b7a652..3b19580 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_ARM_MEMORY_ERROR_RECOVERY 166
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
