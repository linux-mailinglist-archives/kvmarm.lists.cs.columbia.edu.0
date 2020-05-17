Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 284D21D6748
	for <lists+kvmarm@lfdr.de>; Sun, 17 May 2020 12:11:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73AE04B0F8;
	Sun, 17 May 2020 06:11:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blsZ6SOngjLP; Sun, 17 May 2020 06:11:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CE5C4B0F9;
	Sun, 17 May 2020 06:11:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EB2F4B0E1
 for <kvmarm@lists.cs.columbia.edu>; Sun, 17 May 2020 06:11:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0sftpuiGQ4tm for <kvmarm@lists.cs.columbia.edu>;
 Sun, 17 May 2020 06:11:22 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1E5384B0DA
 for <kvmarm@lists.cs.columbia.edu>; Sun, 17 May 2020 06:11:22 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EDB92EA9E14D29C6CA83;
 Sun, 17 May 2020 18:11:18 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.173.222.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sun, 17 May 2020 18:11:12 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <wangjingyi11@huawei.com>
Subject: [kvm-unit-tests PATCH 0/6] arm64: add IPI/LPI/vtimer latency
Date: Sun, 17 May 2020 18:08:54 +0800
Message-ID: <20200517100900.30792-1-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.173.222.58]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org
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

With the development of arm gic architecture, we think it will be useful
to add some performance test in kut to measure the cost of interrupts.
In this series, we add GICv4.1 support for ipi latency test and
implement LPI/vtimer latency test.

Jingyi Wang (6):
  arm64: microbench: get correct ipi recieved num
  arm64: microbench: Use the funcions for ipi test as the general
    functions for gic(ipi/lpi/timer) test.
  arm64: microbench: gic: Add gicv4.1 support for ipi latency test.
  arm64: its: Handle its command queue wrapping
  arm64: microbench: its: Add LPI latency test.
  arm64: microbench: Add vtimer latency test

 arm/micro-bench.c          | 215 +++++++++++++++++++++++++++++++------
 lib/arm/asm/gic-v3.h       |   5 +
 lib/arm/asm/gic.h          |   1 +
 lib/arm64/gic-v3-its-cmd.c |   3 +-
 4 files changed, 192 insertions(+), 32 deletions(-)

-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
