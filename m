Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 00BDA37239
	for <lists+kvmarm@lfdr.de>; Thu,  6 Jun 2019 12:58:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 283F74A4C0;
	Thu,  6 Jun 2019 06:58:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtDul1HKD5AP; Thu,  6 Jun 2019 06:58:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E36F44A4EA;
	Thu,  6 Jun 2019 06:58:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B89824A4C0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Jun 2019 06:58:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 899hCSg75JIG for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Jun 2019 06:58:16 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 52CF54A331
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Jun 2019 06:58:16 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BCF4A78;
 Thu,  6 Jun 2019 03:58:15 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8108F3F690;
 Thu,  6 Jun 2019 03:58:14 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/2] KVM: arm/arm64: vgic: A couple of memory leak fixes
Date: Thu,  6 Jun 2019 11:58:06 +0100
Message-Id: <1559818688-20638-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, linux-arm-kernel@lists.infradead.org
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

While using kmemleak to verify that the KVM SVE series wasn't
contributing any new memory leaks, I hit a couple of existing leaks to
do with vGIC irqs and the vGIC ITS that appear to have been there for
a while.

See the individual patches for details.

I'm not familiar with the affected code, so I may have overlooked
something.

Tested with qemu on ThunderX2.

Dave Martin (2):
  KVM: arm/arm64: vgic: Fix kvm_device leak in vgic_its_destroy
  KVM: arm/arm64: vgic: Fix irq refcount leak in kvm_vgic_set_owner()

 virt/kvm/arm/vgic/vgic-its.c | 1 +
 virt/kvm/arm/vgic/vgic.c     | 1 +
 2 files changed, 2 insertions(+)

-- 
2.1.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
