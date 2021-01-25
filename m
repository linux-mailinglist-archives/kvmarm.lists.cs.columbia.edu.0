Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 28026302614
	for <lists+kvmarm@lfdr.de>; Mon, 25 Jan 2021 15:11:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB6F24B60B;
	Mon, 25 Jan 2021 09:11:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mDJl351jQwhv; Mon, 25 Jan 2021 09:11:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B03E34B5F7;
	Mon, 25 Jan 2021 09:11:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A9AC74B5E8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 09:11:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xijG4oNZA--e for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Jan 2021 09:11:05 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0B70D4B5CD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 09:11:04 -0500 (EST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPWvr3VkzzjD03;
 Mon, 25 Jan 2021 22:09:44 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 22:10:46 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>,
 "Julien Thierry" <julien.thierry.kdev@gmail.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Performance improvement about cache flush
Date: Mon, 25 Jan 2021 22:10:42 +0800
Message-ID: <20210125141044.380156-1-wangyanan55@huawei.com>
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
This two patches are posted to introduce a new method that can distinguish cases
of allocating memcache more precisely, and to elide some unnecessary cache flush.

For patch-1:
With a guest translation fault, we don't really need the memcache pages when
only installing a new entry to the existing page table or replacing the table
entry with a block entry. And with a guest permission fault, we also don't need
the memcache pages for a write_fault in dirty-logging time if VMs are not
configured with huge mappings. So a new method is introduced to distinguish cases
of allocating memcache more precisely.

For patch-2:
If migration of a VM with hugepages is canceled midway, KVM will adjust the
stage-2 table mappings back to block mappings. With multiple vCPUs accessing
guest pages within the same 1G range, there could be numbers of translation
faults to handle, and KVM will uniformly flush data cache for 1G range before
handling the faults. As it will cost a long time to flush the data cache for
1G range of memory(130ms on Kunpeng 920 servers, for example), the consequent
cache flush for each translation fault will finally lead to vCPU stuck for
seconds or even a soft lockup. I have met both the stuck and soft lockup on
Kunpeng servers with FWB not supported.

When KVM need to recover the table mappings back to block mappings, as we only
replace the existing page tables with a block entry and the cacheability has not
been changed, the cache maintenance opreations can be skipped.

Yanan Wang (2):
  KVM: arm64: Distinguish cases of allocating memcache more precisely
  KVM: arm64: Skip the cache flush when coalescing tables into a block

 arch/arm64/kvm/mmu.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
