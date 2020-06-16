Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37D1FAC99
	for <lists+kvmarm@lfdr.de>; Tue, 16 Jun 2020 11:36:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BC984B13C;
	Tue, 16 Jun 2020 05:36:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VB3xHNncPwDz; Tue, 16 Jun 2020 05:36:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2930C4B11A;
	Tue, 16 Jun 2020 05:36:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C3B304B0E6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 05:36:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJ8qg+HzLKy5 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Jun 2020 05:36:18 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1791B4A49C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 05:36:18 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 968F783B892EBF894D59;
 Tue, 16 Jun 2020 17:36:13 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.173.221.230) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 17:36:03 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [PATCH 00/12] KVM: arm64: Support stage2 hardware DBM
Date: Tue, 16 Jun 2020 17:35:41 +0800
Message-ID: <20200616093553.27512-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>, liangpeng10@huawei.com,
 Alexios Zavras <alexios.zavras@intel.com>, Mark Brown <broonie@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
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

This patch series add support for stage2 hardware DBM, and it is only
used for dirty log for now.

It works well under some migration test cases, including VM with 4K
pages or 2M THP. I checked the SHA256 hash digest of all memory and
they keep same for source VM and destination VM, which means no dirty
pages is missed under hardware DBM.

Some key points:

1. Only support hardware updates of dirty status for PTEs. PMDs and PUDs
   are not involved for now.

2. About *performance*: In RFC patch, I have mentioned that for every 64GB
   memory, KVM consumes about 40ms to scan all PTEs to collect dirty log.
   
   Initially, I plan to solve this problem using parallel CPUs. However
   I faced two problems.

   The first is bottleneck of memory bandwith. Single thread will occupy
   bandwidth about 500GB/s, we can support about 4 parallel threads at
   most, so the ideal speedup ratio is low.

   The second is huge impact on other CPUs. To scan PTs quickly, I use
   smp_call_function_many, which is based on IPI, to dispatch workload
   on other CPUs. Though it can complete work in time, the interrupt is
   disabled during scaning PTs, which has huge impact on other CPUs.

   Now, I make hardware dirty log can be dynamic enabled and disabled.
   Userspace can enable it before VM migration and disable it when
   remaining dirty pages is little. Thus VM downtime is not affected. 


3. About correctness: Only add DBM bit when PTE is already writable, so
   we still have readonly PTE and some mechanisms which rely on readonly
   PTs are not broken.

4. About PTs modification races: There are two kinds of PTs modification.
   
   The first is adding or clearing specific bit, such as AF or RW. All
   these operations have been converted to be atomic, avoid covering
   dirty status set by hardware.
   
   The second is replacement, such as PTEs unmapping or changement. All
   these operations will invoke kvm_set_pte finally. kvm_set_pte have
   been converted to be atomic and we save the dirty status to underlying
   bitmap if dirty status is coverred.


Keqian Zhu (12):
  KVM: arm64: Add some basic functions to support hw DBM
  KVM: arm64: Modify stage2 young mechanism to support hw DBM
  KVM: arm64: Report hardware dirty status of stage2 PTE if coverred
  KVM: arm64: Support clear DBM bit for PTEs
  KVM: arm64: Add KVM_CAP_ARM_HW_DIRTY_LOG capability
  KVM: arm64: Set DBM bit of PTEs during write protecting
  KVM: arm64: Scan PTEs to sync dirty log
  KVM: Omit dirty log sync in log clear if initially all set
  KVM: arm64: Steply write protect page table by mask bit
  KVM: arm64: Save stage2 PTE dirty status if it is coverred
  KVM: arm64: Support disable hw dirty log after enable
  KVM: arm64: Enable stage2 hardware DBM

 arch/arm64/include/asm/kvm_host.h |  11 +
 arch/arm64/include/asm/kvm_mmu.h  |  56 +++-
 arch/arm64/include/asm/sysreg.h   |   2 +
 arch/arm64/kvm/arm.c              |  22 +-
 arch/arm64/kvm/mmu.c              | 411 ++++++++++++++++++++++++++++--
 arch/arm64/kvm/reset.c            |  14 +-
 include/uapi/linux/kvm.h          |   1 +
 tools/include/uapi/linux/kvm.h    |   1 +
 virt/kvm/kvm_main.c               |   7 +-
 9 files changed, 499 insertions(+), 26 deletions(-)

-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
