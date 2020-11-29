Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 353E82C7899
	for <lists+kvmarm@lfdr.de>; Sun, 29 Nov 2020 11:20:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 526554D8F6;
	Sun, 29 Nov 2020 05:20:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3thKIkMvmh4; Sun, 29 Nov 2020 05:20:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 93B7E4D8F8;
	Sun, 29 Nov 2020 05:20:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 116E74D9EC
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Nov 2020 09:19:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nlDMLYXAw5sL for <kvmarm@lists.cs.columbia.edu>;
 Sat, 28 Nov 2020 09:19:37 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 33C024B3D7
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Nov 2020 09:19:37 -0500 (EST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CjtsL68GZzLwH9;
 Sat, 28 Nov 2020 22:19:02 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.187.74) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 22:19:24 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason Cooper" <jason@lakedaemon.net>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <kvm@vger.kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry
 <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Christoffer Dall
 <christoffer.dall@arm.com>
Subject: [PATCH v2 0/2] KVM: arm64: Optimize the wait for the completion of
 the VPT analysis
Date: Sat, 28 Nov 2020 22:18:55 +0800
Message-ID: <20201128141857.983-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.187.74]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sun, 29 Nov 2020 05:20:37 -0500
Cc: lushenming@huawei.com
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

Right after a vPE is made resident, the code starts polling the
GICR_VPENDBASER.Dirty bit until it becomes 0, where the delay_us
is set to 10. But in our measurement, it takes only hundreds of
nanoseconds, or 1~2 microseconds, to finish parsing the VPT in most
cases. What's more, we found that the MMIO delay on GICv4.1 system
(HiSilicon) is about 10 times higher than that on GICv4.0 system in
kvm-unit-tests (the specific data is as follows).

                        |   GICv4.1 emulator   |  GICv4.0 emulator
mmio_read_user (ns)     |        12811         |        1598

After analysis, this is mainly caused by the 10 delay_us, so it might
really hurt performance.

To avoid this, we can set the delay_us to 1, which is more appropriate
in this situation and universal. Besides, we can delay the execution
of the polling, giving the GIC a chance to work in parallel with the CPU
on the entry path.

Shenming Lu (2):
  irqchip/gic-v4.1: Reduce the delay time of the poll on the
    GICR_VPENDBASER.Dirty bit
  KVM: arm64: Delay the execution of the polling on the
    GICR_VPENDBASER.Dirty bit

 arch/arm64/kvm/vgic/vgic-v4.c      | 16 ++++++++++++++++
 arch/arm64/kvm/vgic/vgic.c         |  3 +++
 drivers/irqchip/irq-gic-v3-its.c   | 18 +++++++++++++-----
 drivers/irqchip/irq-gic-v4.c       | 11 +++++++++++
 include/kvm/arm_vgic.h             |  3 +++
 include/linux/irqchip/arm-gic-v4.h |  4 ++++
 6 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
