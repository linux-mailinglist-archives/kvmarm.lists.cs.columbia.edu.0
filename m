Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50333D514
	for <lists+kvmarm@lfdr.de>; Tue, 16 Mar 2021 14:44:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63E884B5EE;
	Tue, 16 Mar 2021 09:44:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQBTWuDUeAWY; Tue, 16 Mar 2021 09:44:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FD564B5D1;
	Tue, 16 Mar 2021 09:44:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D964D4B430
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 09:44:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIkDRwUD+v1w for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Mar 2021 09:44:05 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 562F74B3C3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 09:44:04 -0400 (EDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0Dwq1PWlzrXLl;
 Tue, 16 Mar 2021 21:42:03 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 21:43:49 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH v2 0/2] kvm/arm64: Try stage2 block mapping for host
 device MMIO
Date: Tue, 16 Mar 2021 21:43:36 +0800
Message-ID: <20210316134338.18052-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>, lushenming@huawei.com
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

Hi all,

We have two pathes to build stage2 mapping for MMIO regions.

Create time's path and stage2 fault path.

Patch#1 removes the creation time's mapping of MMIO regions
Patch#2 tries stage2 block mapping for host device MMIO at fault path

Thanks,
Keqian

Keqian Zhu (2):
  kvm/arm64: Remove the creation time's mapping of MMIO regions
  kvm/arm64: Try stage2 block mapping for host device MMIO

 arch/arm64/kvm/mmu.c | 80 +++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
