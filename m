Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E5A4C34
	for <lists+kvmarm@lfdr.de>; Sun,  1 Sep 2019 23:13:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73E154A591;
	Sun,  1 Sep 2019 17:13:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 92fjdiKiN9gi; Sun,  1 Sep 2019 17:13:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6212F4A55D;
	Sun,  1 Sep 2019 17:12:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C3B754A4F6
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Sep 2019 17:12:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vzTrv2SI9YZy for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 Sep 2019 17:12:56 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C74054A3B4
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Sep 2019 17:12:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552DE28;
 Sun,  1 Sep 2019 14:12:56 -0700 (PDT)
Received: from why.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 180C73F718;
 Sun,  1 Sep 2019 14:12:54 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
Subject: [PATCH 0/3] arm64: KVM: Kiss hyp_alternate_select() goodbye
Date: Sun,  1 Sep 2019 22:12:34 +0100
Message-Id: <20190901211237.11673-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

hyp_alternate_select() is a leftover from the my second attempt at
supporting VHE (the first one was never merged, thankfully), and is
now an irrelevant relic. It was a way to patch function pointers
without having to dereference memory, a bit like static keys for
function calls.

Lovely idea, but since Christoffer mostly separated the VHE and !VHE
hypervisor paths, most of the uses of hyp_alternate_select() are
gone. What is left is two instances that are better replaced by
already existing static keys. One of the instances becomes
cpus_have_const_cap(), and the rest is a light sprinkling of
has_vhe().

So off it goes.

Marc Zyngier (3):
  arm64: KVM: Drop hyp_alternate_select for checking for
    ARM64_WORKAROUND_834220
  arm64: KVM: Replace hyp_alternate_select with has_vhe()
  arm64: KVM: Kill hyp_alternate_select()

 arch/arm64/include/asm/kvm_hyp.h | 24 ---------------------
 arch/arm64/kvm/hyp/switch.c      | 17 ++-------------
 arch/arm64/kvm/hyp/tlb.c         | 36 +++++++++++++++++++-------------
 3 files changed, 24 insertions(+), 53 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
