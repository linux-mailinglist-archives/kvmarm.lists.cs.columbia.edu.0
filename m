Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 21995365A35
	for <lists+kvmarm@lfdr.de>; Tue, 20 Apr 2021 15:34:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A28D14B369;
	Tue, 20 Apr 2021 09:34:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AadEKjtuSmp5; Tue, 20 Apr 2021 09:34:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6903D4B3C1;
	Tue, 20 Apr 2021 09:34:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 305564B382
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Apr 2021 09:08:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9yN3dOZMfvPM for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Apr 2021 09:08:41 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 16EED4B381
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Apr 2021 09:08:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A794B1478;
 Tue, 20 Apr 2021 06:08:40 -0700 (PDT)
Received: from yoan-MS-7758.Home (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CEFA3F792;
 Tue, 20 Apr 2021 06:08:39 -0700 (PDT)
From: Yoan Picchi <yoan.picchi@arm.com>
To: maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 0/3] KVM: arm64: add more event counters for kvm_stat
Date: Tue, 20 Apr 2021 14:08:22 +0100
Message-Id: <20210420130825.15585-1-yoan.picchi@arm.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 20 Apr 2021 09:34:06 -0400
Cc: catalin.marinas@arm.com, Yoan Picchi <yoan.picchi@arm.com>, will@kernel.org
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

Hi all,

Considering the feedback on my first version https://lore.kernel.org/linux-arm-kernel/20210319161711.24972-1-yoan.picchi@arm.com/
I started from scratch and focussed only on stage 2 page fault.

For the context, as mentioned in the KVM forum talk from 2019 
(https://kvmforum2019.sched.com/event/Tmwf/kvmstat-and-beyond-past-present-and-future-of-performance-monitoring-christian-borntrager-ibm page 10),
there are few event counters for kvm_stat in the arm64 version of kvm when
you compare it to something like the x86 version.
Those counters are used in kvm_stat by kernel/driver developers to
have a rough idea of the impact of their patches on the general performance.

In this patchset I introduce 3 counters to use in kvm stat. They aim to help
a kernel/driver dev troubleshot performance issues by letting them know how
much exits comes from stage 2 table faults, and thus, see if their changes
added a lot. Between the existing mmio_user_exit and the added page_mapped,
the main reasons for a stage 2 page fault should be covered and thus give
some finer granularity when looking for the source of exits.


Yoan Picchi (3):
  KVM: arm64: Add a stage2 page fault counter for kvm_stat
  KVM: arm64: Add two page mapping counters for kvm_stat
  KVM: arm64: Add irq_exit counter for kvm_stat

 arch/arm64/include/asm/kvm_host.h | 4 ++++
 arch/arm64/kvm/guest.c            | 4 ++++
 arch/arm64/kvm/handle_exit.c      | 1 +
 arch/arm64/kvm/hyp/pgtable.c      | 5 +++++
 arch/arm64/kvm/mmu.c              | 2 ++
 5 files changed, 16 insertions(+)

-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
