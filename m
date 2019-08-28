Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 900C3A0881
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 19:32:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EBFF4A511;
	Wed, 28 Aug 2019 13:32:43 -0400 (EDT)
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
	with ESMTP id KzI3dLpJ6RJH; Wed, 28 Aug 2019 13:32:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 50F474A536;
	Wed, 28 Aug 2019 13:32:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A75054A511
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 13:32:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UpKqCfTWZkSa for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 13:32:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9386C4A50F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 13:32:39 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E5F3222CF8;
 Wed, 28 Aug 2019 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567013558;
 bh=g4OCrTwVa9bGHj9tnxdp3jF6CcqJ8f1XiF9bSopoU3g=;
 h=Date:From:To:Cc:Subject:From;
 b=a3rf4aOlbouRot3H7YWNOPjdMdjcSi4kuaOwn9XEDNdNwloLChRW0NRPbuHXR9PXS
 C6MgP0i2QWJTMl2Pk08Rc1N/ScAAM4oPGmcweVwXtZ/63yqisTC31BDdQGAwJFmL4V
 GPPOqjrUiOAnRHK07SzjdAwi+63PljkdrwKkNN/A=
Date: Wed, 28 Aug 2019 18:32:33 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] arm64: Fixes for -rc7
Message-ID: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Linus,

Hot on the heels of our last set of fixes are a few more for -rc7. Two
of them are fixing issues with our virtual interrupt controller
implementation in KVM/arm, while the other is a longstanding but
straightforward kallsyms fix which was been acked by Masami and resolves
an initialisation failure in kprobes observed on arm64.

Please pull, thanks.

Will

--->8

The following changes since commit b6143d10d23ebb4a77af311e8b8b7f019d0163e6:

  arm64: ftrace: Ensure module ftrace trampoline is coherent with I-side (2019-08-16 17:40:03 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 82e40f558de566fdee214bec68096bbd5e64a6a4:

  KVM: arm/arm64: vgic-v2: Handle SGI bits in GICD_I{S,C}PENDR0 as WI (2019-08-28 11:21:42 +0100)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix GICv2 emulation bug (KVM)

- Fix deadlock in virtual GIC interrupt injection code (KVM)

- Fix kprobes blacklist init failure due to broken kallsyms lookup

----------------------------------------------------------------
Heyi Guo (1):
      KVM: arm/arm64: vgic: Fix potential deadlock when ap_list is long

Marc Zyngier (2):
      kallsyms: Don't let kallsyms_lookup_size_offset() fail on retrieving the first symbol
      KVM: arm/arm64: vgic-v2: Handle SGI bits in GICD_I{S,C}PENDR0 as WI

 kernel/kallsyms.c             |  6 ++++--
 virt/kvm/arm/vgic/vgic-mmio.c | 18 ++++++++++++++++++
 virt/kvm/arm/vgic/vgic-v2.c   |  5 ++++-
 virt/kvm/arm/vgic/vgic-v3.c   |  5 ++++-
 virt/kvm/arm/vgic/vgic.c      |  7 +++++++
 5 files changed, 37 insertions(+), 4 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
