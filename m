Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 074DB3D0B28
	for <lists+kvmarm@lfdr.de>; Wed, 21 Jul 2021 11:20:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E5ED4B0DF;
	Wed, 21 Jul 2021 05:20:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucqMOF0Kxsk3; Wed, 21 Jul 2021 05:20:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C5254B0CF;
	Wed, 21 Jul 2021 05:20:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C7CA64A534
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Jul 2021 05:20:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id njd0WXPVS3-Z for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Jul 2021 05:20:31 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E2D84A32E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Jul 2021 05:20:31 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3679731B;
 Wed, 21 Jul 2021 02:20:31 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com
 (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.208])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12F7A3F694;
 Wed, 21 Jul 2021 02:20:27 -0700 (PDT)
From: Jianyong Wu <jianyong.wu@arm.com>
To: maz@kernel.org, james.morse@arm.com, andre.przywara@arm.com,
 lushenming@huawei.com
Subject: [PATCH] doc/arm: take care restore order of GICR_* in ITS restore
Date: Wed, 21 Jul 2021 17:20:19 +0800
Message-Id: <20210721092019.144088-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: justin.he@arm.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

When restore GIC/ITS, GICR_CTLR must be restored after GICR_PROPBASER
and GICR_PENDBASER. That is important, as both of GICR_PROPBASER and
GICR_PENDBASER will fail to be loaded when lpi has enabled yet in
GICR_CTLR. Keep the restore order above will avoid that issue.
Shout it out at the doc is very helpful that may avoid lots of debug work.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 Documentation/virt/kvm/devices/arm-vgic-its.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/devices/arm-vgic-its.rst b/Documentation/virt/kvm/devices/arm-vgic-its.rst
index d257eddbae29..6b36de6937f8 100644
--- a/Documentation/virt/kvm/devices/arm-vgic-its.rst
+++ b/Documentation/virt/kvm/devices/arm-vgic-its.rst
@@ -126,7 +126,8 @@ ITS Restore Sequence:
 The following ordering must be followed when restoring the GIC and the ITS:
 
 a) restore all guest memory and create vcpus
-b) restore all redistributors
+b) restore all redistributors:
+   make sure restore GICR_CTLR after GICR_PROPBASER and GICR_PENDBASER
 c) provide the ITS base address
    (KVM_DEV_ARM_VGIC_GRP_ADDR)
 d) restore the ITS in the following order:
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
