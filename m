Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C860BF3AF
	for <lists+kvmarm@lfdr.de>; Thu, 26 Sep 2019 15:06:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF69C4A745;
	Thu, 26 Sep 2019 09:06:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DTx8lsBIqKo8; Thu, 26 Sep 2019 09:06:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A0BA94A73B;
	Thu, 26 Sep 2019 09:06:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 54D6C4A657
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Sep 2019 07:42:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mbXURbgEimE3 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Sep 2019 07:42:24 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 28F3F4A64D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Sep 2019 07:42:24 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97FA5142F;
 Thu, 26 Sep 2019 04:42:23 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com
 [10.169.40.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C9173F67D;
 Thu, 26 Sep 2019 04:42:18 -0700 (PDT)
From: Jianyong Wu <jianyong.wu@arm.com>
To: netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, pbonzini@redhat.com, sean.j.christopherson@intel.com,
 maz@kernel.org, richardcochran@gmail.com, Mark.Rutland@arm.com,
 Will.Deacon@arm.com, suzuki.poulose@arm.com
Subject: [RFC PATCH v4 0/6] Enable ptp_kvm for arm64
Date: Thu, 26 Sep 2019 19:42:07 +0800
Message-Id: <20190926114212.5322-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 26 Sep 2019 09:06:20 -0400
Cc: justin.he@arm.com, kvm@vger.kernel.org, jianyong.wu@arm.com,
 linux-kernel@vger.kernel.org, nd@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

kvm ptp targets to provide high precision time sync between guest
and host in virtualization environment. This patch enable kvm ptp
for arm64.
This patch set base on [1][2][3]

change log:
from v3 to v4:
        (1) fix clocksource of ptp_kvm to arch_sys_counter.
        (2) move kvm_arch_ptp_get_clock_fn into arm_arch_timer.c
        (3) subtract cntvoff before return cycles from host.
        (4) use ktime_get_snapshot instead of getnstimeofday and
get_current_counterval to return time and counter value.
        (5) split ktime and counter into two 32-bit block respectively
to avoid Y2038-safe issue.
        (6) set time compensation to device time as half of the delay of hvc call.
        (7) add ARM_ARCH_TIMER as dependency of ptp_kvm for
arm64.
from v2 to v3:
        (1) fix some issues in commit log.
        (2) add some receivers in send list.
from v1 to v2:
        (1) move arch-specific code from arch/ to driver/ptp/
        (2) offer mechanism to inform userspace if ptp_kvm service is
available.
        (3) separate ptp_kvm code for arm64 into hypervisor part and
guest part.
        (4) add API to expose monotonic clock and counter value.
        (5) refine code: remove no necessary part and reconsitution.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
commit/?h=kvm/hvc&id=125ea89e4a21e2fc5235410f966a996a1a7148bf
[2]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
commit/?h=kvm/hvc&id=464f5a1741e5959c3e4d2be1966ae0093b4dce06
[3]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
commit/?h=kvm/hvc&id=6597490e005d0eeca8ed8c1c1d7b4318ee014681

Jianyong Wu (5):
  psci: Export psci_ops.conduit symbol as modules will use it.
  ptp: Reorganize ptp_kvm modules to make it arch-independent.
  psci: Add hvc call service for ptp_kvm.
  ptp: arm64: Enable ptp_kvm for arm64
  kvm: arm64: Add capability check extension for ptp_kvm

 drivers/clocksource/arm_arch_timer.c | 28 +++++++++
 drivers/firmware/psci/psci.c         |  6 ++
 drivers/ptp/Kconfig                  |  2 +-
 drivers/ptp/Makefile                 |  1 +
 drivers/ptp/{ptp_kvm.c => kvm_ptp.c} | 79 +++++++------------------
 drivers/ptp/ptp_kvm_arm64.c          | 73 +++++++++++++++++++++++
 drivers/ptp/ptp_kvm_x86.c            | 87 ++++++++++++++++++++++++++++
 include/asm-generic/ptp_kvm.h        | 12 ++++
 include/linux/arm-smccc.h            | 14 ++++-
 include/linux/psci.h                 |  1 +
 include/uapi/linux/kvm.h             |  1 +
 virt/kvm/arm/arm.c                   |  1 +
 virt/kvm/arm/psci.c                  | 18 ++++++
 13 files changed, 262 insertions(+), 61 deletions(-)
 rename drivers/ptp/{ptp_kvm.c => kvm_ptp.c} (63%)
 create mode 100644 drivers/ptp/ptp_kvm_arm64.c
 create mode 100644 drivers/ptp/ptp_kvm_x86.c
 create mode 100644 include/asm-generic/ptp_kvm.h

-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
