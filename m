Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64B30356F24
	for <lists+kvmarm@lfdr.de>; Wed,  7 Apr 2021 16:48:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11D544B8E0;
	Wed,  7 Apr 2021 10:48:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ke-SQf-ByLX0; Wed,  7 Apr 2021 10:48:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA4B44B8E5;
	Wed,  7 Apr 2021 10:48:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB32D4B89F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 10:48:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJWsCcOAS7mL for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Apr 2021 10:48:42 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1448A4B746
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 10:48:42 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6E4F1424;
 Wed,  7 Apr 2021 07:48:40 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE6743F792;
 Wed,  7 Apr 2021 07:48:39 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 0/2] KVM: arm64: Debug fixes
Date: Wed,  7 Apr 2021 15:48:55 +0100
Message-Id: <20210407144857.199746-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.31.1
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

v2 can be found at [1]. Patch #1 in this series is new.

Tested on an odroid-c4 with VHE. vcpu->arch.mdcr_el2 is calculated to be
0x84e66. Without this patch, reading MDCR_EL2 after the first vcpu_load() in
kvm_arch_vcpu_ioctl_run() returns 0, subsequent reads return 0xe66
(FEAT_TFF and FEAT_SPE are not implemented by the PE). With this patch, all
reads, including the first time the VCPU is run, return 0xe66.

Also tested on the odroid-c4 board with a host compiled with
CONFIG_DEBUG_PREEMPT=y by running 2 VMs in parallel, saw no errors in
dmesg.

Changes in v3:

* Patch #1 ("Documentation: KVM: Document KVM_GUESTDBG_USE_HW control flag
  for arm64") is new.
* Rebased on top of v5.12-rc6.
* kvm_arm_setup_mdcr_el2() uses __this_cpu_read() to read the host's
  MDCR_EL2 value and kvm_arm_vcpu_init_debug() calls it with preemption
  disabled.
* Rewrote the condition for setting MDCR_EL2.TDA with the intention to make
  it clearer (to be decided if that's indeed the case).

Changes in v2:

* Moved kvm_arm_vcpu_init_debug() earlier in kvm_vcpu_first_run_init() so
  vcpu->arch.mdcr_el2 is calculated even if kvm_vgic_map_resources() fails.
* Added comment to kvm_arm_setup_mdcr_el2 to explain what testing
  vcpu->guest_debug means.

v1 can be found at [2].

[1] https://www.spinics.net/lists/kvm-arm/msg45999.html
[2] https://www.spinics.net/lists/kvm-arm/msg42959.html

Alexandru Elisei (2):
  Documentation: KVM: Document KVM_GUESTDBG_USE_HW control flag for
    arm64
  KVM: arm64: Initialize VCPU mdcr_el2 before loading it

 Documentation/virt/kvm/api.rst    |  3 +-
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/arm.c              |  2 +
 arch/arm64/kvm/debug.c            | 88 +++++++++++++++++++++----------
 4 files changed, 65 insertions(+), 29 deletions(-)

-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
