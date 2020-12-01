Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EE03C2CA66F
	for <lists+kvmarm@lfdr.de>; Tue,  1 Dec 2020 16:00:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F5344C280;
	Tue,  1 Dec 2020 10:00:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yuwDdqR4NYaL; Tue,  1 Dec 2020 10:00:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83E6D4C17B;
	Tue,  1 Dec 2020 10:00:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C5E9D4C17B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Dec 2020 10:00:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kn8DhQmJNt+X for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Dec 2020 10:00:41 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E37F4B1DF
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Dec 2020 10:00:41 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD7530E;
 Tue,  1 Dec 2020 07:00:40 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 863B23F575;
 Tue,  1 Dec 2020 07:00:39 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com
Subject: [PATCH 0/5] KVM: arm64: Miscellaneous improvements
Date: Tue,  1 Dec 2020 15:01:52 +0000
Message-Id: <20201201150157.223625-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.2
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

The documentation update in the first patch was suggested by Marc [1]. When
I was going through the code to track down all the places error codes were
coming from I noticed a few things that in my opinion could be improved.
The following patches aim to do just that. I'm fine dropping them if the
churn looks unjustified.

Tested the Documentation changes by building pdfdocs, didn't notice any
warnings regarding api.rst.

Tested the other patches on a rockpro64 on the little cores. I ran
kvm-unit-tests with qemu and kvmtool. I also ran a Linux guest with qemu
and ran perf:

$ perf record -a -- iperf3 -c 127.0.0.1 -t 60

I checked that interrupts were firing and nothing looked out of the
ordinary. I used qemu because qemu VCPUs do initialization concurrently
from their own thread, not from the main thread like kvmtool.

To check that kvm_timer_enable() is never reached if the VGIC is not
initialized, I hacked kvmtool to remove the ioctl
KVM_DEV_ARM_VGIC_GRP_CTRL(KVM_DEV_ARM_VGIC_CTRL_INIT) from gic__init_gic().
When trying to run a guest, I got the following error message:

KVM_RUN failed: Device or resource busy

which is consistent with the EBUSY return code from
vgic_v3_map_resources(). Double checked that that's where the code is
coming from by adding a pr_info statement to
kvm_arch_vcpu_first_run_init().

[1] https://www.spinics.net/lists/arm-kernel/msg858024.html

Alexandru Elisei (5):
  KVM: Documentation: Add arm64 KVM_RUN error codes
  KVM: arm64: arch_timer: Remove VGIC initialization check
  KVM: arm64: Move double-checked lock to kvm_vgic_map_resources()
  KVM: arm64: Update comment in kvm_vgic_map_resources()
  KVM: arm64: Remove redundant call to kvm_pmu_vcpu_reset()

 Documentation/virt/kvm/api.rst  | 9 +++++++--
 arch/arm64/kvm/arch_timer.c     | 3 ---
 arch/arm64/kvm/arm.c            | 8 +++-----
 arch/arm64/kvm/pmu-emul.c       | 2 --
 arch/arm64/kvm/vgic/vgic-init.c | 9 ++++++++-
 arch/arm64/kvm/vgic/vgic-v2.c   | 3 ---
 arch/arm64/kvm/vgic/vgic-v3.c   | 3 ---
 7 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
