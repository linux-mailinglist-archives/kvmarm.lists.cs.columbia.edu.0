Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 118D442060
	for <lists+kvmarm@lfdr.de>; Wed, 12 Jun 2019 11:15:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA41C4A53A;
	Wed, 12 Jun 2019 05:15:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5i2Ck9apZfJ; Wed, 12 Jun 2019 05:15:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B29304A523;
	Wed, 12 Jun 2019 05:15:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BF6D54A4EE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jun 2019 05:15:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I0eHrIGAszL7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 12 Jun 2019 05:15:03 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1B5FD4A4FF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jun 2019 05:15:03 -0400 (EDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EF3EA12D63526C173D19;
 Wed, 12 Jun 2019 17:11:50 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 17:11:42 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 0/5] perf kvm: Add stat support on arm64
Date: Wed, 12 Jun 2019 09:08:41 +0000
Message-ID: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 acme@kernel.org, linuxarm@huawei.com, acme@redhat.com, peterz@infradead.org,
 alexander.shishkin@linux.intel.com, mingo@redhat.com,
 ganapatrao.kulkarni@cavium.com, namhyung@kernel.org, jolsa@redhat.com,
 xiexiangyou@huawei.com
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

'perf kvm stat report/record' generates a statistical analysis of KVM
events and can be used to analyze guest exit reasons. This series tries
to add stat support on arm64 (Port perf-kvm-stat to arm64 - this is
already supported on x86).

"record" enables recording of two pair of tracepoints:
 - "kvm:kvm_entry" and "kvm:kvm_exit"
 - "kvm:kvm_trap_enter" and "kvm:kvm_trap_exit"
"report" reports statistical analysis of guest exit&trap events.

To record kvm events on the host:
 # perf kvm stat record -a

To report kvm VM EXIT events:
 # perf kvm stat report --event=vmexit

To report kvm VM TRAP (synchronous exceptions) events:
 # perf kvm stat report --event=trap

More information can be found at tools/perf/Documentation/perf-kvm.txt.

* Patch 1-2 touch KVM/ARM side, with #1 is cleanup and #2 is preparation
  for perf-kvm-stat support.
* Patch 3-5 touch perf side.
* Patch 3 adds support for get_cpuid() function on arm64. *RFC!*
* Patch 4 adds support for perf-kvm-stat on arm64, with VM-EXIT events.
* Patch 5 adds support to report TRAP-EVENT events.

Any suggestions, comments and test results will be appreciated.

Thanks,
zenghui

---

Zenghui Yu (5):
  KVM: arm/arm64: Remove kvm_mmio_emulate tracepoint
  KVM: arm/arm64: Adjust entry/exit and trap related tracepoints
  perf tools arm64: Add support for get_cpuid() function
  perf,kvm/arm64: Add stat support on arm64
  perf,kvm/arm64: perf-kvm-stat to report VM TRAP

 arch/arm64/kvm/handle_exit.c                     |   3 +
 arch/arm64/kvm/trace.h                           |  35 +++++++
 tools/perf/arch/arm64/Makefile                   |   2 +
 tools/perf/arch/arm64/util/Build                 |   1 +
 tools/perf/arch/arm64/util/aarch64_guest_exits.h |  91 +++++++++++++++++
 tools/perf/arch/arm64/util/header.c              |  74 +++++++++-----
 tools/perf/arch/arm64/util/kvm-stat.c            | 125 +++++++++++++++++++++++
 virt/kvm/arm/arm.c                               |   4 +-
 virt/kvm/arm/trace.h                             |  42 ++------
 9 files changed, 317 insertions(+), 60 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/aarch64_guest_exits.h
 create mode 100644 tools/perf/arch/arm64/util/kvm-stat.c

-- 
1.8.3.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
