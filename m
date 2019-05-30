Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A39082FF08
	for <lists+kvmarm@lfdr.de>; Thu, 30 May 2019 17:13:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DCCA04A4F3;
	Thu, 30 May 2019 11:13:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Ri5YtKVgVyE; Thu, 30 May 2019 11:13:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F12D4A4C1;
	Thu, 30 May 2019 11:13:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E7F94A3A3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 May 2019 11:13:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IaMJ+o8lfg-c for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 May 2019 11:13:23 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DB1B4A32E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 May 2019 11:13:23 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8D30341;
 Thu, 30 May 2019 08:13:22 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AA253F59C;
 Thu, 30 May 2019 08:13:21 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvmtool v3 0/9] arm64: Pointer Authentication and SVE support
Date: Thu, 30 May 2019 16:13:05 +0100
Message-Id: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

This series, based on kvmtool master [1], implements basic support for
pointer authentication and SVE for guests.

A git tree is also available [2].

For pointer auth, I include Amit's v10 patch [3], with some additional
refactoring to sit nicely alongside SVE, and some cosmetic / diagnostic
tidyups discussed during review on-list.  (I've kept the extra changes
separate for easier review, but they could be folded if desired.)

[Maintainer note: I'd like Amit to comment on my changes on top of his
pointer auth patch, but the first 4 patches just re-sync headers and
could be pulled earlier if you feel like it.]


This series has been tested against Linux v5.2-rc1.

If people have a strong view on the --sve-vls parameter, I'd be
interested to discuss what that should look like.  Since this is
primarily a debug/experimentation option, the current implementation is
probably good enough though.

[1] 
git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git master
https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git/log/
eaeaf60808d6 ("virtio/blk: Avoid taking pointer to packed struct")

[2] [PATCH v10 3/5] KVM: arm64: Add userspace flag to enable pointer authentication
https://lore.kernel.org/linux-arm-kernel/1555994558-26349-6-git-send-email-amit.kachhap@arm.com/

[3]
git://linux-arm.org/kvmtool-dm.git sve/v3/head
http://linux-arm.org/git?p=kvmtool-dm.git;a=shortlog;h=refs/heads/sve/v3/head


Amit Daniel Kachhap (1):
  KVM: arm/arm64: Add a vcpu feature for pointer authentication

Dave Martin (8):
  update_headers.sh: Add missing shell quoting
  update_headers.sh: Cleanly report failure on error
  update_headers.sh: arm64: Copy sve_context.h if available
  update_headers: Sync kvm UAPI headers with linux v5.1-rc1
  arm/arm64: Factor out ptrauth vcpu feature setup
  arm64: Make ptrauth enable/disable diagnostics more user-friendly
  arm64: Add SVE support
  arm64: Select SVE vector lengths via the command line

 arm/aarch32/include/kvm/kvm-cpu-arch.h    |   7 ++
 arm/aarch64/include/asm/kvm.h             |  43 +++++++++
 arm/aarch64/include/asm/sve_context.h     |  53 +++++++++++
 arm/aarch64/include/kvm/kvm-config-arch.h |  16 +++-
 arm/aarch64/include/kvm/kvm-cpu-arch.h    |   3 +
 arm/aarch64/kvm-cpu.c                     | 148 ++++++++++++++++++++++++++++++
 arm/include/arm-common/kvm-config-arch.h  |   5 +
 arm/kvm-cpu.c                             |   5 +
 include/linux/kvm.h                       |  15 ++-
 powerpc/include/asm/kvm.h                 |  48 ++++++++++
 util/update_headers.sh                    |  25 +++--
 x86/include/asm/kvm.h                     |   1 +
 12 files changed, 360 insertions(+), 9 deletions(-)
 create mode 100644 arm/aarch64/include/asm/sve_context.h

-- 
2.1.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
