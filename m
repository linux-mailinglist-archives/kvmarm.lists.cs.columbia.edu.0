Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7A5E333A48
	for <lists+kvmarm@lfdr.de>; Wed, 10 Mar 2021 11:42:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A42F4B66A;
	Wed, 10 Mar 2021 05:42:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSJyORay+zw4; Wed, 10 Mar 2021 05:42:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A49DE4B640;
	Wed, 10 Mar 2021 05:42:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F70D4B5F1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Mar 2021 05:42:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RXCFX2sw+pfz for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Mar 2021 05:42:26 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 625B84B603
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Mar 2021 05:42:26 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 64F4664FE1;
 Wed, 10 Mar 2021 10:42:24 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lJwII-000jdD-Jy; Wed, 10 Mar 2021 10:42:22 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: arm64: Reject VM creation when the default IPA
 size is unsupported
Date: Wed, 10 Mar 2021 10:42:07 +0000
Message-Id: <20210310104208.3819061-2-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210310104208.3819061-1-maz@kernel.org>
References: <20210310104208.3819061-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, will@kernel.org,
 drjones@redhat.com, eric.auger@redhat.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>
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

KVM/arm64 has forever used a 40bit default IPA space, partially
due to its 32bit heritage (where the only choice is 40bit).

However, there are implementations in the wild that have a *cough*
much smaller *cough* IPA space, which leads to a misprogramming of
VTCR_EL2, and a guest that is stuck on its first memory access
if userspace dares to ask for the default IPA setting (which most
VMMs do).

Instead, blundly reject the creation of such VM, as we can't
satisfy the requirements from userspace (with a one-off warning).
Also clarify the boot warning, and document that the VM creation
will fail when an unsupported IPA size is probided.

Although this is an ABI change, it doesn't really change much
for userspace:

- the guest couldn't run before this change, but no error was
  returned. At least userspace knows what is happening.

- a memory slot that was accepted because it did fit the default
  IPA space now doesn't even get a chance to be registered.

The other thing that is left doing is to convince userspace to
actually use the IPA space setting instead of relying on the
antiquated default.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/virt/kvm/api.rst |  3 +++
 arch/arm64/kvm/reset.c         | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1a2b5210cdbf..38e327d4b479 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -182,6 +182,9 @@ is dependent on the CPU capability and the kernel configuration. The limit can
 be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the KVM_CHECK_EXTENSION
 ioctl() at run-time.
 
+Creation of the VM will fail if the requested IPA size (whether it is
+implicit or explicit) is unsupported on the host.
+
 Please note that configuring the IPA size does not affect the capability
 exposed by the guest CPUs in ID_AA64MMFR0_EL1[PARange]. It only affects
 size of the address translated by the stage2 level (guest physical to
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 47f3f035f3ea..f1a38405934e 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -324,10 +324,9 @@ int kvm_set_ipa_limit(void)
 	}
 
 	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
-	WARN(kvm_ipa_limit < KVM_PHYS_SHIFT,
-	     "KVM IPA Size Limit (%d bits) is smaller than default size\n",
-	     kvm_ipa_limit);
-	kvm_info("IPA Size Limit: %d bits\n", kvm_ipa_limit);
+	kvm_info("IPA Size Limit: %d bits%s\n", kvm_ipa_limit,
+		 ((kvm_ipa_limit < KVM_PHYS_SHIFT) ?
+		  " (Reduced IPA size, limited VM/VMM compatibility)" : ""));
 
 	return 0;
 }
@@ -356,6 +355,11 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 			return -EINVAL;
 	} else {
 		phys_shift = KVM_PHYS_SHIFT;
+		if (phys_shift > kvm_ipa_limit) {
+			pr_warn_once("%s using unsupported default IPA limit, upgrade your VMM\n",
+				     current->comm, kvm_ipa_limit);
+			return -EINVAL;
+		}
 	}
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
