Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4917522C819
	for <lists+kvmarm@lfdr.de>; Fri, 24 Jul 2020 16:35:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCE094B4B3;
	Fri, 24 Jul 2020 10:35:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ejuzK+MTyT8; Fri, 24 Jul 2020 10:35:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DD2A4B46F;
	Fri, 24 Jul 2020 10:35:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C9FE54B4AC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jul 2020 10:35:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3L8g81uIGyrs for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Jul 2020 10:35:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DEEBC4B46F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jul 2020 10:35:13 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A5682063A;
 Fri, 24 Jul 2020 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595601312;
 bh=WTr6hbkNz8uIk+9+PXztZX4f3S3xEa6hEDq7MKDUfN8=;
 h=From:To:Cc:Subject:Date:From;
 b=DHa2vWwbOcPxsZhyaojzIC+FrMSV/7QI8InQV+deY83HlJ5b2OZXwSFDcUiu13SY+
 nbiBad/k/RU+SZ1K9OwOMwa6HJzjdlCT2vphPIv/zsTDSDwuSOzHLq/HFqNr2nwSjy
 ExSXfqxM6b7iFYzUcN6NoR/vKHkLGG0DAh0+1m+8=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/7] KVM: arm64: Fixes to early stage-2 fault handling
Date: Fri, 24 Jul 2020 15:34:59 +0100
Message-Id: <20200724143506.17772-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Hi folks,

Continuing my journey into the KVM stage-2 page-table code, here are some fixes
for a bunch of issues I spotted purely by code inspection. Most of these
involve really unusual scenarios, but I'm a bit worried about the stage-2 fault
on stage-1 page-table walk during instruction fetch from a read-only memslot,
as that feels like it might be hittable with EFI.

Anyway, feedback welcome, especially as this is a user-visible change.

Cheers,

Will

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>

--->8

Will Deacon (7):
  KVM: arm64: Update comment when skipping guest MMIO access instruction
  KVM: arm64: Rename kvm_vcpu_dabt_isextabt()
  KVM: arm64: Handle data and instruction external aborts the same way
  KVM: arm64: Remove useless local variable
  KVM: arm64: Move 'invalid syndrome' logic out of io_mem_abort()
  KVM: arm64: Handle stage-2 faults on stage-1 page-table walks earlier
  KVM: arm64: Separate write faults on read-only memslots from MMIO

 arch/arm64/include/asm/kvm_emulate.h |  2 +-
 arch/arm64/kvm/hyp/switch.c          |  2 +-
 arch/arm64/kvm/mmio.c                | 29 +++-------
 arch/arm64/kvm/mmu.c                 | 87 +++++++++++++++++++---------
 4 files changed, 69 insertions(+), 51 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
