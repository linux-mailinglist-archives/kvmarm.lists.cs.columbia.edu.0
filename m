Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBAB3130A3
	for <lists+kvmarm@lfdr.de>; Mon,  8 Feb 2021 12:23:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 980724B484;
	Mon,  8 Feb 2021 06:23:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZJZEtGRvBrv; Mon,  8 Feb 2021 06:23:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A2054B490;
	Mon,  8 Feb 2021 06:23:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BB164B3B2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 06:23:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6gGUDDUbEjkg for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Feb 2021 06:23:05 -0500 (EST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0C2CE4B35C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 06:23:04 -0500 (EST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DZ3Wk0320zjK2N;
 Mon,  8 Feb 2021 19:21:54 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Feb 2021 19:22:52 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>,
 "Julien Thierry" <julien.thierry.kdev@gmail.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Gavin Shan <gshan@redhat.com>, Quentin Perret
 <qperret@google.com>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/4] KVM: arm64: Improve efficiency of stage2 page table
Date: Mon, 8 Feb 2021 19:22:46 +0800
Message-ID: <20210208112250.163568-1-wangyanan55@huawei.com>
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

This series makes some efficiency improvement of stage2 page table code,
and there are some test results to present the performance changes, which
were tested by a kvm selftest [1] that I have post:
[1] https://lore.kernel.org/lkml/20210208090841.333724-1-wangyanan55@huawei.com/ 

About patch 1:
We currently uniformly clean dcache in user_mem_abort() before calling the
fault handlers, if we take a translation fault and the pfn is cacheable.
But if there are concurrent translation faults on the same page or block,
clean of dcache for the first time is necessary while the others are not.

By moving clean of dcache to the map handler, we can easily identify the
conditions where CMOs are really needed and avoid the unnecessary ones.
As it's a time consuming process to perform CMOs especially when flushing
a block range, so this solution reduces much load of kvm and improve the
efficiency of creating mappings.

Test results:
(1) when 20 vCPUs concurrently access 20G ram (all 1G hugepages):
KVM create block mappings time: 52.83s -> 3.70s
KVM recover block mappings time(after dirty-logging): 52.0s -> 2.87s

(2) when 40 vCPUs concurrently access 20G ram (all 1G hugepages):
KVM creating block mappings time: 104.56s -> 3.70s
KVM recover block mappings time(after dirty-logging): 103.93s -> 2.96s

About patch 2, 3:
When KVM needs to coalesce the normal page mappings into a block mapping,
we currently invalidate the old table entry first followed by invalidation
of TLB, then unmap the page mappings, and install the block entry at last.

It will cost a lot of time to unmap the numerous page mappings, which means
the table entry will be left invalid for a long time before installation of
the block entry, and this will cause many spurious translation faults.

So let's quickly install the block entry at first to ensure uninterrupted
memory access of the other vCPUs, and then unmap the page mappings after
installation. This will reduce most of the time when the table entry is
invalid, and avoid most of the unnecessary translation faults.

Test results based on patch 1:
(1) when 20 vCPUs concurrently access 20G ram (all 1G hugepages):
KVM recover block mappings time(after dirty-logging): 2.87s -> 0.30s

(2) when 40 vCPUs concurrently access 20G ram (all 1G hugepages):
KVM recover block mappings time(after dirty-logging): 2.96s -> 0.35s

So combined with patch 1, it makes a big difference of KVM creating mappings
and recovering block mappings with not much code change.

About patch 4:
A new method to distinguish cases of memcache allocations is introduced.
By comparing fault_granule and vma_pagesize, cases that require allocations
from memcache and cases that don't can be distinguished completely.

---

Details of test results
platform: HiSilicon Kunpeng920 (FWB not supported)
host kernel: Linux mainline (v5.11-rc6)

(1) performance change of patch 1
cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 20
	   (20 vcpus, 20G memory, block mappings(granule 1G))
Before patch: KVM_CREATE_MAPPINGS: 52.8338s 52.8327s 52.8336s 52.8255s 52.8303s
After  patch: KVM_CREATE_MAPPINGS:  3.7022s  3.7031s  3.7028s  3.7012s  3.7024s

Before patch: KVM_ADJUST_MAPPINGS: 52.0466s 52.0473s 52.0550s 52.0518s 52.0467s
After  patch: KVM_ADJUST_MAPPINGS:  2.8787s  2.8781s  2.8785s  2.8742s  2.8759s

cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 40
	   (40 vcpus, 20G memory, block mappings(granule 1G))
Before patch: KVM_CREATE_MAPPINGS: 104.560s 104.556s 104.554s 104.556s 104.550s
After  patch: KVM_CREATE_MAPPINGS:  3.7011s  3.7103s  3.7005s  3.7024s  3.7106s

Before patch: KVM_ADJUST_MAPPINGS: 103.931s 103.936s 103.927s 103.942s 103.927s
After  patch: KVM_ADJUST_MAPPINGS:  2.9621s  2.9648s  2.9474s  2.9587s  2.9603s

(2) performance change of patch 2, 3(based on patch 1)
cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 1
	   (1 vcpu, 20G memory, block mappings(granule 1G))
Before patch: KVM_ADJUST_MAPPINGS: 2.8241s 2.8234s 2.8245s 2.8230s 2.8652s
After  patch: KVM_ADJUST_MAPPINGS: 0.2444s 0.2442s 0.2423s 0.2441s 0.2429s

cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 20
	   (20 vcpus, 20G memory, block mappings(granule 1G))
Before patch: KVM_ADJUST_MAPPINGS: 2.8787s 2.8781s 2.8785s 2.8742s 2.8759s
After  patch: KVM_ADJUST_MAPPINGS: 0.3008s 0.3004s 0.2974s 0.2917s 0.2900s

cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 40
	   (40 vcpus, 20G memory, block mappings(granule 1G))
Before patch: KVM_ADJUST_MAPPINGS: 2.9621s 2.9648s 2.9474s 2.9587s 2.9603s
After  patch: KVM_ADJUST_MAPPINGS: 0.3541s 0.3694s 0.3656s 0.3693s 0.3687s

---

Yanan Wang (4):
  KVM: arm64: Move the clean of dcache to the map handler
  KVM: arm64: Add an independent API for coalescing tables
  KVM: arm64: Install the block entry before unmapping the page mappings
  KVM: arm64: Distinguish cases of memcache allocations completely

 arch/arm64/include/asm/kvm_mmu.h | 16 -------
 arch/arm64/kvm/hyp/pgtable.c     | 82 +++++++++++++++++++++-----------
 arch/arm64/kvm/mmu.c             | 39 ++++++---------
 3 files changed, 69 insertions(+), 68 deletions(-)

-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
