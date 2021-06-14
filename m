Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 759103A5EDB
	for <lists+kvmarm@lfdr.de>; Mon, 14 Jun 2021 11:06:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2900349F83;
	Mon, 14 Jun 2021 05:06:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNKcFy8xo2l6; Mon, 14 Jun 2021 05:06:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ACE514A500;
	Mon, 14 Jun 2021 05:06:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB3814A17F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 05:06:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7FphEAGxSJgd for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Jun 2021 05:06:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95CF9406AD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 05:06:02 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A4BB1FB;
 Mon, 14 Jun 2021 02:06:02 -0700 (PDT)
Received: from e112269-lin.arm.com (autoplooker.cambridge.arm.com
 [10.1.194.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 817AE3F694;
 Mon, 14 Jun 2021 02:05:59 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v15 7/7] KVM: arm64: Document MTE capability and ioctl
Date: Mon, 14 Jun 2021 10:05:25 +0100
Message-Id: <20210614090525.4338-8-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614090525.4338-1-steven.price@arm.com>
References: <20210614090525.4338-1-steven.price@arm.com>
MIME-Version: 1.0
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
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

A new capability (KVM_CAP_ARM_MTE) identifies that the kernel supports
granting a guest access to the tags, and provides a mechanism for the
VMM to enable it.

A new ioctl (KVM_ARM_MTE_COPY_TAGS) provides a simple way for a VMM to
access the tags of a guest without having to maintain a PROT_MTE mapping
in userspace. The above capability gates access to the ioctl.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 Documentation/virt/kvm/api.rst | 57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 22d077562149..d412928e50cd 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5034,6 +5034,43 @@ see KVM_XEN_VCPU_SET_ATTR above.
 The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
 with the KVM_XEN_VCPU_GET_ATTR ioctl.
 
+4.130 KVM_ARM_MTE_COPY_TAGS
+---------------------------
+
+:Capability: KVM_CAP_ARM_MTE
+:Architectures: arm64
+:Type: vm ioctl
+:Parameters: struct kvm_arm_copy_mte_tags
+:Returns: number of bytes copied, < 0 on error (-EINVAL for incorrect
+          arguments, -EFAULT if memory cannot be accessed).
+
+::
+
+  struct kvm_arm_copy_mte_tags {
+	__u64 guest_ipa;
+	__u64 length;
+	void __user *addr;
+	__u64 flags;
+	__u64 reserved[2];
+  };
+
+Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
+``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned. The ``addr``
+field must point to a buffer which the tags will be copied to or from.
+
+``flags`` specifies the direction of copy, either ``KVM_ARM_TAGS_TO_GUEST`` or
+``KVM_ARM_TAGS_FROM_GUEST``.
+
+The size of the buffer to store the tags is ``(length / 16)`` bytes
+(granules in MTE are 16 bytes long). Each byte contains a single tag
+value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
+``PTRACE_POKEMTETAGS``.
+
+If an error occurs before any data is copied then a negative error code is
+returned. If some tags have been copied before an error occurs then the number
+of bytes successfully copied is returned. If the call completes successfully
+then ``length`` is returned.
+
 5. The kvm_run structure
 ========================
 
@@ -6362,6 +6399,26 @@ default.
 
 See Documentation/x86/sgx/2.Kernel-internals.rst for more details.
 
+7.26 KVM_CAP_ARM_MTE
+--------------------
+
+:Architectures: arm64
+:Parameters: none
+
+This capability indicates that KVM (and the hardware) supports exposing the
+Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
+VMM before creating any VCPUs to allow the guest access. Note that MTE is only
+available to a guest running in AArch64 mode and enabling this capability will
+cause attempts to create AArch32 VCPUs to fail.
+
+When enabled the guest is able to access tags associated with any memory given
+to the guest. KVM will ensure that the tags are maintained during swap or
+hibernation of the host; however the VMM needs to manually save/restore the
+tags as appropriate if the VM is migrated.
+
+When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
+perform a bulk copy of tags to/from the guest.
+
 8. Other capabilities.
 ======================
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
