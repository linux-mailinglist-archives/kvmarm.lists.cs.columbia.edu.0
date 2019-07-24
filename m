Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86A72B09
	for <lists+kvmarm@lfdr.de>; Wed, 24 Jul 2019 11:04:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DEDBD4A59A;
	Wed, 24 Jul 2019 05:04:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tcom+APQgOUp; Wed, 24 Jul 2019 05:04:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B98374A570;
	Wed, 24 Jul 2019 05:04:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E85214A55A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jul 2019 05:04:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F95UVpeK2i6B for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Jul 2019 05:04:45 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5D9634A533
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jul 2019 05:04:45 -0400 (EDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 74AC1F6E4DA912F3682E;
 Wed, 24 Jul 2019 17:04:40 +0800 (CST)
Received: from localhost (10.177.19.122) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 17:04:38 +0800
From: Xiangyou Xie <xiexiangyou@huawei.com>
To: <marc.zyngier@arm.com>
Subject: [PATCH 0/3] KVM: arm/arm64: Optimize lpi translation cache performance
Date: Wed, 24 Jul 2019 17:04:34 +0800
Message-ID: <20190724090437.49952-1-xiexiangyou@huawei.com>
X-Mailer: git-send-email 2.10.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.177.19.122]
X-CFilter-Loop: Reflected
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

Hello,

This patches are based on Marc Zyngier's branch
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/its-translation-cache

As follows:
(1) Introduce multiple LPI translation caches to reduce concurrency
(2) Removed the unnecessary vgic_its_invalidate_cache()
(3) Introduced vgic_cpu->pending and vgic_cpu->lowest, reducing
    vgic_cpu.ap_list_lock competition

Best Regards,

Xiangyou

Xiangyou Xie (3):
  KVM: arm/arm64: vgic-its: Introduce multiple LPI translation caches
  KVM: arm/arm64: vgic-its: Do not execute invalidate MSI-LPI
    translation cache on movi command
  KVM: arm/arm64: vgic: introduce vgic_cpu pending status and
    lowest_priority

 include/kvm/arm_vgic.h        |  18 +++-
 virt/kvm/arm/vgic/vgic-init.c |   6 +-
 virt/kvm/arm/vgic/vgic-its.c  | 201 ++++++++++++++++++++++++------------------
 virt/kvm/arm/vgic/vgic.c      |  40 +++++----
 4 files changed, 160 insertions(+), 105 deletions(-)

-- 
1.8.3.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
