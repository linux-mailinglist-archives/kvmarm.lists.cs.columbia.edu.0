Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 206C3298E75
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 14:49:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C21224B4F4;
	Mon, 26 Oct 2020 09:49:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBSM22Ihh3hF; Mon, 26 Oct 2020 09:49:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A11534B4DA;
	Mon, 26 Oct 2020 09:49:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 24D6C4B4DF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:49:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zHDPws4pyNmS for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 09:49:40 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC8C44B4DA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:49:39 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 642A81042;
 Mon, 26 Oct 2020 06:49:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73C0E3F68F;
 Mon, 26 Oct 2020 06:49:38 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 0/3]  arm64: kvm: avoid referencing cpu_hwcaps from hyp
Date: Mon, 26 Oct 2020 13:49:28 +0000
Message-Id: <20201026134931.28246-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Cc: maz@kernel.org, will@kernel.org
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

In a few places we use cpus_have_const_cap() in hyp code, usually
because this is hidden within a helper that's also used in regular
kernel context. As cpus_have_const_cap() generates code to read the
cpu_hwcaps array before capabilities are finalized, this means we
generate some potentially-unsound references to regular kernel VAs, but
this these are redundant as capabilities are finalized before we
initialize the kvm hyp code.

This series gets rid of the redundant code by automatically upgrading
cpust_have_const_cap() to cpus_have_final_cap() when used in hyp code.
This allows us to avoid creating an NVHE alias for the cpu_hwcaps array,
so we can catch if we accidentally introduce an runtime reference to
this (e.g. via cpus_have_cap()).

Since v1 [1]:
* Trivial rebase to v5.10-rc1

[1] https://lore.kernel.org/r/20201007125211.30043-1-mark.rutland@arm.com

Mark Rutland (3):
  arm64: kvm: factor out is_{vhe,nvhe}_hyp_code()
  arm64: cpufeature: reorder cpus_have_{const,final}_cap()
  arm64: cpufeature: upgrade hyp caps to final

 arch/arm64/include/asm/cpufeature.h | 40 ++++++++++++++++++++++++++++---------
 arch/arm64/include/asm/virt.h       |  9 ++++-----
 arch/arm64/kernel/image-vars.h      |  1 -
 3 files changed, 35 insertions(+), 15 deletions(-)

-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
