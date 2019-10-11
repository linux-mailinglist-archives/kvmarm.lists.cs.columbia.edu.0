Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62ED3DE8
	for <lists+kvmarm@lfdr.de>; Fri, 11 Oct 2019 13:07:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 16FEC4A885;
	Fri, 11 Oct 2019 07:07:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnBJFmMyIrF5; Fri, 11 Oct 2019 07:07:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E98714A86B;
	Fri, 11 Oct 2019 07:07:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC79D4A86B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Oct 2019 07:07:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-UAxo3LcHv0 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Oct 2019 07:07:15 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B093E4A7FC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Oct 2019 07:07:15 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EE6328;
 Fri, 11 Oct 2019 04:07:15 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.145.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66823F703;
 Fri, 11 Oct 2019 04:07:14 -0700 (PDT)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 0/2] Improve handling of stage 2 aborts without instruction
 decode
Date: Fri, 11 Oct 2019 13:07:04 +0200
Message-Id: <20191011110709.2764-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

When a guest accesses memory outside the memory slots, KVM usually
bounces the access back to userspace with KVM_EXIT_MMIO.  However, on
arm/arm64 systems, certain load/store instructions did not provide
decoding info for the hypervisor to emulate the instruction, and in this
case KVM has rather rudely returned -ENOSYS and printed a not overly
helpful error message:

  load/store instruction decoding not implemented

This patch series improves the error message and allows userspace to be
notified of this event instead of receiving -ENOSYS, and also allows
userspace to ask KVM to inject an external abort to the guest, which it
can use for any memory access that it either cannot handle.

One remaining case which this patch set does not address is if the guest
accesses an in-kernel emulated device, such as the VGIC, but using a
load/store instruction which doesn't provide decode info.  With these
patches, this will return to userspace for it to handle, but there's no
way for userspace to return the decoding information to KVM and have KVM
complete the access to the in-kernel emulated device.  I have no plans
to address this limitation.

Changes since v2:
 - Cleanup inconsistent use of has_ in patch 2 and allow injecting
   SError and external abort simultaenously with a single call to set
   VCPU events.

Changes since v1:
 - Rebased on v5.4-rc2
 - Fixed some documentation and coding nit in review of v1

Christoffer Dall (2):
  KVM: arm/arm64: Allow reporting non-ISV data aborts to userspace
  KVM: arm/arm64: Allow user injection of external data aborts

 Documentation/virt/kvm/api.txt       | 55 +++++++++++++++++++++++++++-
 arch/arm/include/asm/kvm_arm.h       |  1 +
 arch/arm/include/asm/kvm_emulate.h   |  5 +++
 arch/arm/include/asm/kvm_host.h      |  8 ++++
 arch/arm/include/uapi/asm/kvm.h      |  3 +-
 arch/arm/kvm/guest.c                 | 10 +++++
 arch/arm64/include/asm/kvm_emulate.h |  5 +++
 arch/arm64/include/asm/kvm_host.h    |  8 ++++
 arch/arm64/include/uapi/asm/kvm.h    |  3 +-
 arch/arm64/kvm/guest.c               | 10 +++++
 arch/arm64/kvm/inject_fault.c        |  4 +-
 include/uapi/linux/kvm.h             |  8 ++++
 virt/kvm/arm/arm.c                   | 22 +++++++++++
 virt/kvm/arm/mmio.c                  |  9 ++++-
 14 files changed, 145 insertions(+), 6 deletions(-)

-- 
2.18.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
