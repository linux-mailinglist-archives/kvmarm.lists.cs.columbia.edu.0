Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8A48334EB25
	for <lists+kvmarm@lfdr.de>; Tue, 30 Mar 2021 16:54:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 271B44B304;
	Tue, 30 Mar 2021 10:54:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F3MBp0tr1VFu; Tue, 30 Mar 2021 10:54:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 211DC4B309;
	Tue, 30 Mar 2021 10:54:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA47B4B2FA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 10:54:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KzQokRe3vlWP for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Mar 2021 10:54:47 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8C2CC4B1B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 10:54:47 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A5B6961921;
 Tue, 30 Mar 2021 14:54:45 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lRFlT-004hoo-ML; Tue, 30 Mar 2021 15:54:43 +0100
From: Marc Zyngier <maz@kernel.org>
To: netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, pbonzini@redhat.com, seanjc@google.com,
 richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
 suzuki.poulose@arm.com, Andre.Przywara@arm.com, steven.price@arm.com,
 lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
Subject: [PATCH v19 0/7] KVM: arm64: Add host/guest KVM-PTP support
Date: Tue, 30 Mar 2021 15:54:23 +0100
Message-Id: <20210330145430.996981-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: netdev@vger.kernel.org, yangbo.lu@nxp.com,
 john.stultz@linaro.org, tglx@linutronix.de, pbonzini@redhat.com,
 seanjc@google.com, richardcochran@gmail.com, Mark.Rutland@arm.com,
 will@kernel.org, suzuki.poulose@arm.com, Andre.Przywara@arm.com,
 steven.price@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Steve.Capper@arm.com,
 justin.he@arm.com, jianyong.wu@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: justin.he@arm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Given that this series[0] has languished in my Inbox for the best of the
past two years, and in an effort to eventually get it merged, I've
taken the liberty to pick it up and do the changes I wanted to see
instead of waiting to go through yet another round.

All the patches have a link to their original counterpart (though I
have squashed a couple of them where it made sense). Tested both 64
and 32bit guests for a good measure. Of course, I claim full
responsibility for any bug introduced here.

Unless someone screams now, this is going in 5.13, because I'm frankly
fed up with it! ;-)

* From v18 [2]
  - Fix kvm_hypercall2() return type
  - Rebased on top of 5.12-rc3
  - Added RBs

* From v17 [1]:
  - Fixed compilation issue on 32bit systems not selecting
    CONFIG_HAVE_ARM_SMCCC_DISCOVERY
  - Fixed KVM service discovery not properly parsing the reply
    from the hypervisor

* From v16 [0]:
  - Moved the KVM service discovery to its own file, plugged it into
    PSCI instead of the arch code, dropped the inlining, made use of
    asm/hypervisor.h.
  - Tidied-up the namespacing
  - Cleanup the hypercall handler
  - De-duplicate the guest code
  - Tidied-up arm64-specific documentation
  - Dropped the generic PTP documentation as it needs a new location,
    and some cleanup
  - Squashed hypercall documentation and capability into the
    main KVM patch
  - Rebased on top of 5.11-rc4

[0] https://lore.kernel.org/r/20201209060932.212364-1-jianyong.wu@arm.com
[1] https://lore.kernel.org/r/20210202141204.3134855-1-maz@kernel.org
[2] https://lore.kernel.org/r/20210208134029.3269384-1-maz@kernel.org

Jianyong Wu (4):
  ptp: Reorganize ptp_kvm.c to make it arch-independent
  clocksource: Add clocksource id for arm arch counter
  KVM: arm64: Add support for the KVM PTP service
  ptp: arm/arm64: Enable ptp_kvm for arm/arm64

Thomas Gleixner (1):
  time: Add mechanism to recognize clocksource in time_get_snapshot

Will Deacon (2):
  arm/arm64: Probe for the presence of KVM hypervisor
  KVM: arm64: Advertise KVM UID to guests via SMCCC

 Documentation/virt/kvm/api.rst              | 10 +++
 Documentation/virt/kvm/arm/index.rst        |  1 +
 Documentation/virt/kvm/arm/ptp_kvm.rst      | 25 ++++++
 arch/arm/include/asm/hypervisor.h           |  3 +
 arch/arm64/include/asm/hypervisor.h         |  3 +
 arch/arm64/kvm/arm.c                        |  1 +
 arch/arm64/kvm/hypercalls.c                 | 80 +++++++++++++++--
 drivers/clocksource/arm_arch_timer.c        | 36 ++++++++
 drivers/firmware/psci/psci.c                |  2 +
 drivers/firmware/smccc/Makefile             |  2 +-
 drivers/firmware/smccc/kvm_guest.c          | 50 +++++++++++
 drivers/firmware/smccc/smccc.c              |  1 +
 drivers/ptp/Kconfig                         |  2 +-
 drivers/ptp/Makefile                        |  2 +
 drivers/ptp/ptp_kvm_arm.c                   | 28 ++++++
 drivers/ptp/{ptp_kvm.c => ptp_kvm_common.c} | 84 +++++-------------
 drivers/ptp/ptp_kvm_x86.c                   | 97 +++++++++++++++++++++
 include/linux/arm-smccc.h                   | 41 +++++++++
 include/linux/clocksource.h                 |  6 ++
 include/linux/clocksource_ids.h             | 12 +++
 include/linux/ptp_kvm.h                     | 19 ++++
 include/linux/timekeeping.h                 | 12 +--
 include/uapi/linux/kvm.h                    |  1 +
 kernel/time/clocksource.c                   |  2 +
 kernel/time/timekeeping.c                   |  1 +
 25 files changed, 443 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/virt/kvm/arm/ptp_kvm.rst
 create mode 100644 drivers/firmware/smccc/kvm_guest.c
 create mode 100644 drivers/ptp/ptp_kvm_arm.c
 rename drivers/ptp/{ptp_kvm.c => ptp_kvm_common.c} (60%)
 create mode 100644 drivers/ptp/ptp_kvm_x86.c
 create mode 100644 include/linux/clocksource_ids.h
 create mode 100644 include/linux/ptp_kvm.h

-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
