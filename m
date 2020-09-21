Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6710F272498
	for <lists+kvmarm@lfdr.de>; Mon, 21 Sep 2020 15:08:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BD4E4B5BF;
	Mon, 21 Sep 2020 09:08:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBdxnHe5rkyz; Mon, 21 Sep 2020 09:08:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E6704B5BD;
	Mon, 21 Sep 2020 09:08:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BA96A4B4B7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 09:07:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cv3WRHJtoILo for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Sep 2020 09:07:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BCA0A4B5B1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 09:07:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BB271045;
 Mon, 21 Sep 2020 06:07:58 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6983F73B;
 Mon, 21 Sep 2020 06:07:57 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 1/2] KVM: arm64: Add undocumented return values for PMU device
 control group
Date: Mon, 21 Sep 2020 14:08:37 +0100
Message-Id: <20200921130838.37296-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921130838.37296-1-alexandru.elisei@arm.com>
References: <20200921130838.37296-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

KVM_ARM_VCPU_PMU_V3_IRQ returns -EFAULT if get_user() fails when reading
the interrupt number from kvm_device_attr.addr.

KVM_ARM_VCPU_PMU_V3_INIT returns the error value from kvm_vgic_set_owner().
kvm_arm_pmu_v3_init() checks that the vgic has been initialized and the
interrupt number is valid, but kvm_vgic_set_owner() can still return the
error code -EEXIST if another device has already claimed the interrupt.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/devices/vcpu.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index ca374d3fe085..96d6cf77cb1e 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -25,6 +25,7 @@ Returns:
 
 	 =======  ========================================================
 	 -EBUSY   The PMU overflow interrupt is already set
+	 -EFAULT  Error reading interrupt number
 	 -ENXIO   The overflow interrupt not set when attempting to get it
 	 -ENODEV  PMUv3 not supported
 	 -EINVAL  Invalid PMU overflow interrupt number supplied or
@@ -45,6 +46,7 @@ all vcpus, while as an SPI it must be a separate number per vcpu.
 Returns:
 
 	 =======  ======================================================
+	 -EEXIST  Interrupt number already used
 	 -ENODEV  PMUv3 not supported or GIC not initialized
 	 -ENXIO   PMUv3 not properly configured or in-kernel irqchip not
 		  configured as required prior to calling this attribute
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
