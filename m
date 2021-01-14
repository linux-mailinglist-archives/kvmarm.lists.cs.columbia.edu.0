Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E52F60D3
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jan 2021 13:14:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 59EE64B1A1;
	Thu, 14 Jan 2021 07:14:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UIJXbsko81ki; Thu, 14 Jan 2021 07:14:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EFA14B1C5;
	Thu, 14 Jan 2021 07:14:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05D654B1C0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 07:14:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id joQspYknLzb5 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jan 2021 07:14:08 -0500 (EST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 777564B19D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 07:14:08 -0500 (EST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DGjrD4zP5z7VFy;
 Thu, 14 Jan 2021 20:13:00 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 20:13:52 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Some optimization for stage-2 translation
Date: Thu, 14 Jan 2021 20:13:47 +0800
Message-ID: <20210114121350.123684-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
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

Hi,
This patch series(v3) make some optimization for stage-2 translation.

About patch-1:
Procedures of hyp stage-1 map and guest stage-2 map are quite different,
but they are now tied closely by function kvm_set_valid_leaf_pte().
So adjust the relative code for ease of code maintenance in the future.

About patch-2:
There have been the separate map handler and perms handler used independently
for mapping and relaxing permissions in the new page-table infrastructure for
stage-2, yet there is still a specific case where we end up changing the access
permissions in the map path, and something unsatisfactory could happen because
of current handling for this case.

To solve above problem, we can filter out this case from the map path and abort
the PTE update. Instead, let the vCPU enter back the guest and it will exit next
time to go through the relax_perms path if still needed.

About patch-3:
We now set the pfn dirty and mark the page dirty before calling fault
handlers in user_mem_abort(), so we might end up having spurious dirty
pages if update of permissions or mapping has failed. Let's move these
two operations after the fault handlers, and they will be done only if
the fault has been handled successfully.

When an -EAGAIN errno is returned from the map handler, we hope to the
vcpu to enter guest directly instead of exiting back to userspace, so
adjust the return value at the end of function.

---

Changelogs

v2->v3:
- Rebased on top of v5.11-rc3
- Refine the commit messages
- Make some adjustment about return value in patch-2 and patch-3
- v2: https://lore.kernel.org/lkml/20201216122844.25092-1-wangyanan55@huawei.com/

v1->v2:
- Make part of the diff a seperate patch (patch-1)
- Add Will's Signed-off-by for patch-1
- Return an errno when meeting changing permissions case in map path
- Add a new patch (patch-3)
- v1: https://lore.kernel.org/lkml/20201211080115.21460-1-wangyanan55@huawei.com/

---

Yanan Wang (3):
  KVM: arm64: Adjust partial code of hyp stage-1 map and guest stage-2
    map
  KVM: arm64: Filter out the case of only changing permissions from
    stage-2 map path
  KVM: arm64: Mark the page dirty only if the fault is handled
    successfully

 arch/arm64/include/asm/kvm_pgtable.h |  5 ++
 arch/arm64/kvm/hyp/pgtable.c         | 83 ++++++++++++++++------------
 arch/arm64/kvm/mmu.c                 | 13 +++--
 3 files changed, 60 insertions(+), 41 deletions(-)

-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
