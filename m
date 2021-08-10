Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4022D3DA831
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 18:01:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ACA714B0C8;
	Thu, 29 Jul 2021 12:01:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e+2jOYf5sbym; Thu, 29 Jul 2021 12:01:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6766C4B0B7;
	Thu, 29 Jul 2021 12:01:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B7D8040CF9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 12:01:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFUtEoOMHRgR for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 12:01:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 42B1140870
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 12:01:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B10661FB;
 Thu, 29 Jul 2021 09:01:00 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D33B3F73D;
 Thu, 29 Jul 2021 09:00:58 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH] KVM: arm64: Fix race when enabling KVM_ARM_CAP_MTE
Date: Thu, 29 Jul 2021 17:00:36 +0100
Message-Id: <20210729160036.20433-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

When enabling KVM_CAP_ARM_MTE the ioctl checks that there are no VCPUs
created to ensure that the capability is enabled before the VM is
running. However no locks are held at that point so it is
(theoretically) possible for another thread in the VMM to create VCPUs
between the check and actually setting mte_enabled. Close the race by
taking kvm->lock.

Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
Fixes: 673638f434ee ("KVM: arm64: Expose KVM_ARM_CAP_MTE")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kvm/arm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..0ca72f5cda41 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -94,10 +94,14 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		kvm->arch.return_nisv_io_abort_to_user = true;
 		break;
 	case KVM_CAP_ARM_MTE:
-		if (!system_supports_mte() || kvm->created_vcpus)
-			return -EINVAL;
-		r = 0;
-		kvm->arch.mte_enabled = true;
+		mutex_lock(&kvm->lock);
+		if (!system_supports_mte() || kvm->created_vcpus) {
+			r = -EINVAL;
+		} else {
+			r = 0;
+			kvm->arch.mte_enabled = true;
+		}
+		mutex_unlock(&kvm->lock);
 		break;
 	default:
 		r = -EINVAL;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
