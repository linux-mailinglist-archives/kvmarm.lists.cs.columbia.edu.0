Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 934E62A237D
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 04:37:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25FC84B4DA;
	Sun,  1 Nov 2020 22:37:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SmlGIz7eUSy; Sun,  1 Nov 2020 22:37:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1ACC14B4CF;
	Sun,  1 Nov 2020 22:37:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1673B4B42A
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Nov 2020 22:37:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5IeTzBWpRnpa for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 Nov 2020 22:37:08 -0500 (EST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 79A294B229
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Nov 2020 22:37:08 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPdrZ712XzkdN2;
 Mon,  2 Nov 2020 11:37:02 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 11:36:58 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>
Subject: [RFC v3 00/12] kvm: arm64: emulate ID registers
Date: Mon, 2 Nov 2020 11:34:10 +0800
Message-ID: <20201102033422.657391-1-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, maz@kernel.org,
 will@kernel.org
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

In AArch64, guest will read the same values of the ID regsiters with
host.  Both of them read the values from arm64_ftr_regs.  This patch
series add support to emulate and configure ID registers so that we can
control the value of ID registers that guest read.

v2 -> v3:
 - remove check_user and split some set_user for some ID registers
 - check the consistency of ID registers of vCPUS
 - add more doc for the limits

v1 -> v2:
 - save the ID registers in sysreg file instead of a new struct
 - apply a checker before setting the value to the register
 - add doc for new KVM_CAP_ARM_CPU_FEATURE

Peng Liang (12):
  arm64: Add a helper function to traverse arm64_ftr_regs
  arm64: Introduce check_features
  kvm: arm64: Save ID registers to sys_regs file
  kvm: arm64: Make ID_AA64PFR0_EL1 configurable
  kvm: arm64: Make ID_AA64DFR0_EL1 configurable
  kvm: arm64: Make ID_AA64ISAR0_EL1 configurable
  kvm: arm64: Make ID_AA64ISAR1_EL1 configurable
  kvm: arm64: Make ID_DFR0_EL1 configurable
  kvm: arm64: Make MVFR1_EL1 configurable
  kvm: arm64: Make other ID registers configurable
  kvm: arm64: Check consistent of ID register
  kvm: arm64: add KVM_CAP_ARM_CPU_FEATURE extension

 Documentation/virt/kvm/api.rst      |  36 ++++
 arch/arm64/include/asm/cpufeature.h |   4 +
 arch/arm64/include/asm/kvm_coproc.h |   2 +
 arch/arm64/include/asm/kvm_host.h   |   9 +
 arch/arm64/kernel/cpufeature.c      |  36 ++++
 arch/arm64/kvm/arm.c                |  22 +++
 arch/arm64/kvm/sys_regs.c           | 272 ++++++++++++++++++++++++++--
 include/uapi/linux/kvm.h            |   1 +
 8 files changed, 365 insertions(+), 17 deletions(-)

-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
