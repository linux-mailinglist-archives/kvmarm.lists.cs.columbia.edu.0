Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB56E4028D6
	for <lists+kvmarm@lfdr.de>; Tue,  7 Sep 2021 14:33:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B29D4B260;
	Tue,  7 Sep 2021 08:33:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOV45S-pTV33; Tue,  7 Sep 2021 08:33:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B57154B248;
	Tue,  7 Sep 2021 08:33:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 846C54B20E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 08:33:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ssr-8d5mhMf5 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Sep 2021 08:33:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FF524B20C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 08:33:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67CFE6D;
 Tue,  7 Sep 2021 05:33:10 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com
 (entos-ampere-02.shanghai.arm.com [10.169.214.103])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31CFC3F766;
 Tue,  7 Sep 2021 05:33:04 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 0/2] Add memcg accounting to Arm KVM
Date: Tue,  7 Sep 2021 20:31:10 +0800
Message-Id: <20210907123112.10232-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: Xiaoming Ni <nixiaoming@huawei.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jia He <justin.he@arm.com>,
 Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Liu Shixin <liushixin2@huawei.com>, Sami Tolvanen <samitolvanen@google.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Inspired by what had been done by X86 kvm and kvm common codes, it would
be better to make arm64 kvm consistent with them.

The memory allocations of VM scope should be charged into VM process.
Hence change the allocation flag from GFP_KERNEL to GFP_KERNEL_ACCOUNT.

There remain some GFP_KERNEL unchanged since they are global allocations,
instead of VM scope.

Changes:
v2: address a few comments from Marc Zyngier, including redundant
    GFP_KERNEL, incorrect memcg accounting and variable type   
v1: https://lkml.org/lkml/2021/9/2/649

Jia He (2):
  KVM: arm64: vgic: Add memcg accounting to vgic allocations
  KVM: arm64: Add memcg accounting to KVM allocations

 arch/arm64/kvm/arm.c               |  6 ++++--
 arch/arm64/kvm/mmu.c               |  2 +-
 arch/arm64/kvm/pmu-emul.c          |  2 +-
 arch/arm64/kvm/reset.c             |  2 +-
 arch/arm64/kvm/vgic/vgic-init.c    |  2 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c   |  2 +-
 arch/arm64/kvm/vgic/vgic-its.c     | 14 +++++++-------
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |  2 +-
 arch/arm64/kvm/vgic/vgic-v4.c      |  2 +-
 9 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
