Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3D605BC1
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 12:02:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B7E14B971;
	Thu, 20 Oct 2022 06:02:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X+TVTxQXbXYg; Thu, 20 Oct 2022 06:02:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 316804B973;
	Thu, 20 Oct 2022 06:02:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C03B4B942
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 06:02:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9AcUd8EQ7WYE for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 06:02:03 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A8CFB4B941
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 06:02:03 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 346F6B826A9;
 Thu, 20 Oct 2022 10:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE44C433D7;
 Thu, 20 Oct 2022 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666260121;
 bh=F7qx70jEHbzt/vc3VSIRa/2M9FvcpGx818RT/QyMnn4=;
 h=From:To:Cc:Subject:Date:From;
 b=rNottOnkoOUnHqL2cat/ocezSae1gieJhPortC8i2O3LbkolVLygfoh/4eklacETr
 JbFIH+nwTlqdrva6oqX7J5wBTgsSIyJ8x9dfy9p9qqqkBablet4Hs8pR6zfk4UIPVF
 beZBtBI1oXftI7RcRAxDP8bsYGoiI47/+qGLOvG57BwD9hkpYo0u5ybs2ilVDZrOFk
 nvCSuuBSa0kK38dboyew8mqKsfWkhU7ErmOA1moqz0RazP8UoxFZ/Y/tGwSzhgk9rr
 8T9Ua0ilUGokFok6oz0LKfWrUriDqC04YAAB7y5BF+ymoriNC4iBZDW2KKpObZ8b/5
 CXMzHGdxo92iA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1olSNC-000Cz4-Ru;
 Thu, 20 Oct 2022 11:01:59 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [GIT PULL] KVM/arm64 fixes for 6.1, take #2
Date: Thu, 20 Oct 2022 11:01:25 +0100
Message-Id: <20221020100125.3670769-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, denik@chromium.org,
 eric.auger@redhat.com, renzhengeek@gmail.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Denis Nikitin <denik@chromium.org>, kvm@vger.kernel.org,
 Eric Ren <renzhengeek@gmail.com>, kvmarm@lists.linux.dev,
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

Paolo,

Here's a couple of additional fixes for 6.1. The ITS one is pretty
annoying as it prevents a VM from being restored if it has a
convoluted device topology. Definitely a stable candidate.

Note that I can't see that you have pulled the first set of fixes
which I sent last week[1]. In order to avoid any problem, the current
pull-request is a suffix of the previous one. But you may want to pull
them individually in order to preserve the tag descriptions.

Please pull,

	M.

[1] https://lore.kernel.org/r/20221013132830.1304947-1-maz@kernel.org

The following changes since commit 05c2224d4b049406b0545a10be05280ff4b8ba0a:

  KVM: selftests: Fix number of pages for memory slot in memslot_modification_stress_test (2022-10-13 11:46:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-6.1-2

for you to fetch changes up to c000a2607145d28b06c697f968491372ea56c23a:

  KVM: arm64: vgic: Fix exit condition in scan_its_table() (2022-10-15 12:10:54 +0100)

----------------------------------------------------------------
KVM/arm64 fixes for 6.1, take #2

- Fix a bug preventing restoring an ITS containing mappings
  for very large and very sparse device topology

- Work around a relocation handling error when compiling
  the nVHE object with profile optimisation

----------------------------------------------------------------
Denis Nikitin (1):
      KVM: arm64: nvhe: Fix build with profile optimization

Eric Ren (1):
      KVM: arm64: vgic: Fix exit condition in scan_its_table()

 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++++
 arch/arm64/kvm/vgic/vgic-its.c   | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
