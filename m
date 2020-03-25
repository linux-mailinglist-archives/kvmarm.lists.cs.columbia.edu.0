Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55A19201C
	for <lists+kvmarm@lfdr.de>; Wed, 25 Mar 2020 05:26:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 849BA4B0B4;
	Wed, 25 Mar 2020 00:26:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ui+SVovHNdx; Wed, 25 Mar 2020 00:26:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 702434B08D;
	Wed, 25 Mar 2020 00:26:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D2A34ACC9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Mar 2020 00:26:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xxnYVEzvXUIV for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Mar 2020 00:26:43 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A7E5E4A5A0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Mar 2020 00:26:42 -0400 (EDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EBDB983B08E26A5DEBB8;
 Wed, 25 Mar 2020 12:26:38 +0800 (CST)
Received: from linux-kDCJWP.huawei.com (10.175.104.212) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Mar 2020 12:26:28 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH 0/3] KVM: arm64: Some optimizations about enabling dirty log
Date: Wed, 25 Mar 2020 12:24:20 +0800
Message-ID: <20200325042423.12181-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Jay Zhou <jianjay.zhou@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>
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

This patch series is for "queue" branch of [1] and based on patches[2].
It brings obvious time decreasement for migration with different page
size.

The QEMU counterpart will be sent out later, thanks.

[1] git://git.kernel.org/pub/scm/virt/kvm/kvm.git
[2] https://lore.kernel.org/kvm/20200227013227.1401-1-jianjay.zhou@huawei.com/

Keqian Zhu (3):
  KVM/memslot: Move the initial set of dirty bitmap to arch
  KVM/arm64: Support enabling dirty log graually in small chunks
  KVM/arm64: Only set bits of dirty bitmap with valid translation
    entries

 Documentation/virt/kvm/api.rst    |   2 +-
 arch/arm/include/asm/kvm_host.h   |   2 -
 arch/arm64/include/asm/kvm_host.h |   5 +-
 arch/x86/kvm/x86.c                |   3 +
 virt/kvm/arm/mmu.c                | 175 +++++++++++++++++++++++++-----
 virt/kvm/kvm_main.c               |   3 -
 6 files changed, 157 insertions(+), 33 deletions(-)

-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
