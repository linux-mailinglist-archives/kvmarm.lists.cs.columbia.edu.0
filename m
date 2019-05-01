Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 354B01067E
	for <lists+kvmarm@lfdr.de>; Wed,  1 May 2019 11:48:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E24E4A4F5;
	Wed,  1 May 2019 05:48:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n1mEGERMERkD; Wed,  1 May 2019 05:48:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15B1D4A4AD;
	Wed,  1 May 2019 05:48:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C81B4A4F0
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 May 2019 05:48:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIhkj4KZQahL for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 May 2019 05:48:17 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9689A4A4AD
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 May 2019 05:48:17 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BC752D90602CEF28528A;
 Wed,  1 May 2019 17:48:14 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 1 May 2019 17:48:06 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [RFC PATCH 0/5] KVM: arm64: Add support for contiguous PTE/PMD
 hugepages at stage2
Date: Wed, 1 May 2019 09:44:22 +0000
Message-ID: <1556703867-22396-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux@armlinux.org.uk
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

Currently, we support the following page sizes at stage2:

                PTE     PMD     PUD
               -----   -----   -----
 4K granule:     4K      2M      1G
16K granule:    16K     32M
64K granule:    64K    512M

And we have Contiguous bit[52] in stage2 VMSAv8-64 block and page
descriptors. As ARM ARM said, when the value of the Contiguous bit
is 1, it indicates that the entry is one of a number of adjacent
translation table entries that point to a contiguous output address
range.

This series add support for contiguous PTE/PMD hugepages at stage2
and then we can create huge mappings with following additional
sizes:

                CONT PTE     CONT PMD
                --------     --------
 4K granule:      64K          32M
16K granule:       2M           1G
64K granule:       2M          16G

These patches are based on v5.1.0-rc7 and have been tested on
Taishan 2280 server (D05) with 4K and 64K granule.

Any comments will be appreciated, thanks!

Zenghui Yu (5):
  KVM: arm/arm64: Introduce helpers for page table enties with
    contiguous bit
  KVM: arm/arm64: Re-factor building the stage2 page table entries
  KVM: arm/arm64: Support dirty page tracking for contiguous hugepages
  KVM: arm/arm64: Add support for creating PTE contiguous hugepages at
    stage2
  KVM: arm/arm64: Add support for creating PMD contiguous hugepages at
    stage2

 arch/arm/include/asm/kvm_mmu.h       |  22 +++
 arch/arm/include/asm/pgtable-hwdef.h |   8 +
 arch/arm64/include/asm/kvm_mmu.h     |  20 +++
 virt/kvm/arm/mmu.c                   | 299 ++++++++++++++++++++++++++++++-----
 4 files changed, 312 insertions(+), 37 deletions(-)

-- 
1.8.3.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
