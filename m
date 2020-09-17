Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC226D531
	for <lists+kvmarm@lfdr.de>; Thu, 17 Sep 2020 09:51:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6AC664B861;
	Thu, 17 Sep 2020 03:51:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ky53DqvVm24u; Thu, 17 Sep 2020 03:51:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21D714B864;
	Thu, 17 Sep 2020 03:51:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 18AE94B720
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 23:01:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FJql88GjzaUp for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Sep 2020 23:01:10 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 181C04B6D0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 23:01:10 -0400 (EDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2924B8737466F9CFAE96;
 Thu, 17 Sep 2020 11:01:06 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:00:56 +0800
From: Ying Fang <fangying1@huawei.com>
To: <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 0/2] KVM: arm64: Add support for setting MPIDR
Date: Thu, 17 Sep 2020 11:00:51 +0800
Message-ID: <20200917030053.1747-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 17 Sep 2020 03:51:33 -0400
Cc: zhang.zhanghailiang@huawei.com, maz@kernel.org, alex.chen@huawei.com,
 Ying Fang <fangying1@huawei.com>
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

MPIDR is used to show multiprocessor affinity on arm platform. It is
also used to provide an additional processor identification mechanism
for scheduling purposes. To add support for setting MPIDR from usersapce
an vcpu ioctl KVM_CAP_ARM_MP_AFFINITY is introduced. This patch series is
needed to help qemu to build the accurate cpu topology for arm.

Ying Fang (2):
  KVM: arm64: add KVM_CAP_ARM_MP_AFFINITY extension
  kvm/arm: Add mp_affinity for arm vcpu

 Documentation/virt/kvm/api.rst    |  8 ++++++++
 arch/arm64/include/asm/kvm_host.h |  5 +++++
 arch/arm64/kvm/arm.c              |  9 +++++++++
 arch/arm64/kvm/reset.c            | 11 +++++++++++
 arch/arm64/kvm/sys_regs.c         | 30 +++++++++++++++++++-----------
 include/uapi/linux/kvm.h          |  3 +++
 6 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
