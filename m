Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44E3F7A5B
	for <lists+kvmarm@lfdr.de>; Wed, 25 Aug 2021 18:20:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DF254B29F;
	Wed, 25 Aug 2021 12:20:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sbasgjji2TGm; Wed, 25 Aug 2021 12:20:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B71214B1F5;
	Wed, 25 Aug 2021 12:19:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EE82E4064F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:19:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3V8PGSLXo9L for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Aug 2021 12:19:36 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BAEA24B2B7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:18:47 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7415BD6E;
 Wed, 25 Aug 2021 09:18:47 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0DF3F66F;
 Wed, 25 Aug 2021 09:18:46 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v4 kvmtool 0/5] KVM SPE support
Date: Wed, 25 Aug 2021 17:19:53 +0100
Message-Id: <20210825161958.266411-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
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

This series adds userspace support for creating a guest which can use SPE.
It requires KVM SPE support which is in the RFC phase, hence why this
series is also RFC. The kvmtool patches can also be found at [1], and the
KVM SPE patches can be found at [2].

To create a guest with SPE support the following steps must be executed:

1. Set the SPE virtual interrupt ID and then initialize the features on
every VCPU.

2. After the guest memory memslots have been created and SPE initialized,
kvmtool will lock the memslot memory using the newly introduced capability.

The first patch is a simple update to the Linux headers; the next two
patches are preparatory patches. SPE support is added in patch number 4.
And finally, in patch number 5, we take advantage of the newly added
KVM_ARM_VCPU_SUPPORTED_CPUS ioctl to inform KVM that we intend to run the
VCPUs only on those physical CPUs which support SPE. This is done by
concatenating the cpulists from each of the /sys/devices/arm_spe_x/cpumask
files created by the Linux SPE driver for each separate PPI partition which
has SPE support.

[1] https://gitlab.arm.com/linux-arm/kvmtool-ae/-/tree/kvm-spe-v4
[2] https://gitlab.arm.com/linux-arm/linux-ae/-/tree/kvm-spe-v4

Alexandru Elisei (4):
  update_headers: Sync KVM UAPI headers with KVM SPE implementation
  arm/arm64: Make kvm__arch_delete_ram() aarch32/aarch64 specific
  init: Add last_{init, exit} list macros
  arm64: SPE: Set KVM_ARM_VCPU_SUPPORTED_CPUS

Sudeep Holla (1):
  arm64: Add SPE support

 Makefile                                  |   2 +
 arm/aarch32/kvm.c                         |   8 +
 arm/aarch64/arm-cpu.c                     |   2 +
 arm/aarch64/include/asm/kvm.h             |  67 +++-
 arm/aarch64/include/kvm/kvm-config-arch.h |   2 +
 arm/aarch64/include/kvm/spe.h             |   7 +
 arm/aarch64/kvm-cpu.c                     |   5 +
 arm/aarch64/kvm.c                         |  18 +
 arm/aarch64/spe.c                         | 269 ++++++++++++++
 arm/include/arm-common/kvm-config-arch.h  |   1 +
 arm/kvm-cpu.c                             |   4 +
 arm/kvm.c                                 |   5 -
 include/kvm/util-init.h                   |   6 +-
 include/linux/kvm.h                       | 425 +++++++++++++++++++++-
 powerpc/include/asm/kvm.h                 |  10 +
 x86/include/asm/kvm.h                     |  59 ++-
 16 files changed, 870 insertions(+), 20 deletions(-)
 create mode 100644 arm/aarch32/kvm.c
 create mode 100644 arm/aarch64/include/kvm/spe.h
 create mode 100644 arm/aarch64/spe.c

-- 
2.33.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
