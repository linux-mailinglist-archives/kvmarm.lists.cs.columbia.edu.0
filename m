Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D37A5343906
	for <lists+kvmarm@lfdr.de>; Mon, 22 Mar 2021 07:02:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DA834B414;
	Mon, 22 Mar 2021 02:02:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IcxvC8biq75F; Mon, 22 Mar 2021 02:02:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DB134B40A;
	Mon, 22 Mar 2021 02:02:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 07E1C4B403
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 02:02:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UlmAktXVcEgd for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Mar 2021 02:02:32 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C6FC74B401
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 02:02:31 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F3kPv4k4tzkdDV;
 Mon, 22 Mar 2021 14:00:51 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 14:02:18 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Eric Auger <eric.auger@redhat.com>, "Will
 Deacon" <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/6] KVM: arm64: Add VLPI migration support on GICv4.1
Date: Mon, 22 Mar 2021 14:01:52 +0800
Message-ID: <20210322060158.1584-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>
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

In GICv4.1, migration has been supported except for (directly-injected)
VLPI. And GICv4.1 Spec explicitly gives a way to get the VLPI's pending
state (which was crucially missing in GICv4.0). So we make VLPI migration
capable on GICv4.1 in this series.

In order to support VLPI migration, we need to save and restore all
required configuration information and pending states of VLPIs. But
in fact, the configuration information of VLPIs has already been saved
(or will be reallocated on the dst host...) in vgic(kvm) migration.
So we only have to migrate the pending states of VLPIs specially.

Below is the related workflow in migration.

On the save path:
	In migration completion:
		pause all vCPUs
				|
		call each VM state change handler:
			pause other devices (just keep from sending interrupts, and
			such as VFIO migration protocol has already realized it [1])
					|
			flush ITS tables into guest RAM
					|
			flush RDIST pending tables (also flush VLPI pending states here)
				|
		...
On the resume path:
	load each device's state:
		restore ITS tables (include pending tables) from guest RAM
				|
		for other (PCI) devices (paused), if configured to have VLPIs,
		establish the forwarding paths of their VLPIs (and transfer
		the pending states from kvm's vgic to VPT here)

We have tested this series in VFIO migration, and found some related
issues in QEMU [2].

Links:
[1] vfio: UAPI for migration interface for device state:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8a24f3f6e38103b77cf399c38eb54e1219d00d6
[2] vfio: Some fixes and optimizations for VFIO migration:
    https://patchwork.ozlabs.org/project/qemu-devel/cover/20210310030233.1133-1-lushenming@huawei.com/

History:

v4 -> v5
 - Lock the whole pending state read/write sequence. (in Patch 5, from Marc)

v3 -> v4
 - Nit fixes.
 - Add a CPU cache invalidation right after unmapping the vPE. (Patch 1)
 - Drop the setting of PTZ altogether. (Patch 2)
 - Bail out if spot !vgic_initialized(). (in Patch 4)
 - Communicate the state change (clear pending_latch) via
   vgic_queue_irq_unlock. (in Patch 5)

Thanks a lot for the suggestions from Marc!

v2 -> v3
 - Add the vgic initialized check to ensure that the allocation and enabling
   of the doorbells have already been done before unmapping the vPEs.
 - Check all get_vlpi_state related conditions in save_pending_tables in one place.
 - Nit fixes.

v1 -> v2:
 - Get the VLPI state from the KVM side.
 - Nit fixes.

Thanks,
Shenming


Marc Zyngier (1):
  irqchip/gic-v3-its: Add a cache invalidation right after vPE unmapping

Shenming Lu (4):
  irqchip/gic-v3-its: Drop the setting of PTZ altogether
  KVM: arm64: GICv4.1: Add function to get VLPI state
  KVM: arm64: GICv4.1: Try to save VLPI state in save_pending_tables
  KVM: arm64: GICv4.1: Give a chance to save VLPI state

Zenghui Yu (1):
  KVM: arm64: GICv4.1: Restore VLPI pending state to physical side

 .../virt/kvm/devices/arm-vgic-its.rst         |  2 +-
 arch/arm64/kvm/vgic/vgic-its.c                |  6 +-
 arch/arm64/kvm/vgic/vgic-v3.c                 | 66 +++++++++++++++++--
 arch/arm64/kvm/vgic/vgic-v4.c                 | 38 +++++++++++
 arch/arm64/kvm/vgic/vgic.h                    |  1 +
 drivers/irqchip/irq-gic-v3-its.c              | 21 +++++-
 6 files changed, 122 insertions(+), 12 deletions(-)

-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
