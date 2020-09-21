Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 67E85272499
	for <lists+kvmarm@lfdr.de>; Mon, 21 Sep 2020 15:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C7AE4B4B7;
	Mon, 21 Sep 2020 09:08:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kc7AFAPPZdvj; Mon, 21 Sep 2020 09:08:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B20D64B5BD;
	Mon, 21 Sep 2020 09:08:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 747F64B5B9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 09:08:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q5we7gzj9gTb for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Sep 2020 09:08:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CA234B537
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 09:08:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6639142F;
 Mon, 21 Sep 2020 06:07:59 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6773F73B;
 Mon, 21 Sep 2020 06:07:58 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 2/2] KVM: arm64: Match PMU error code descriptions with error
 conditions
Date: Mon, 21 Sep 2020 14:08:38 +0100
Message-Id: <20200921130838.37296-3-alexandru.elisei@arm.com>
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

Update the description of the PMU KVM_{GET, SET}_DEVICE_ATTR error codes
to be a better match for the code that returns them.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/devices/vcpu.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 96d6cf77cb1e..5b8db30c61db 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -26,8 +26,8 @@ Returns:
 	 =======  ========================================================
 	 -EBUSY   The PMU overflow interrupt is already set
 	 -EFAULT  Error reading interrupt number
-	 -ENXIO   The overflow interrupt not set when attempting to get it
-	 -ENODEV  PMUv3 not supported
+	 -ENXIO   PMUv3 not supported
+	 -ENODEV  KVM_ARM_VCPU_PMU_V3 feature missing from VCPU
 	 -EINVAL  Invalid PMU overflow interrupt number supplied or
 		  trying to set the IRQ number without using an in-kernel
 		  irqchip.
@@ -48,8 +48,8 @@ Returns:
 	 =======  ======================================================
 	 -EEXIST  Interrupt number already used
 	 -ENODEV  PMUv3 not supported or GIC not initialized
-	 -ENXIO   PMUv3 not properly configured or in-kernel irqchip not
-		  configured as required prior to calling this attribute
+	 -ENXIO   PMUv3 not supported, missing VCPU feature or interrupt
+                  number not set
 	 -EBUSY   PMUv3 already initialized
 	 =======  ======================================================
 
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
