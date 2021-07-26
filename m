Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B776B3D5D24
	for <lists+kvmarm@lfdr.de>; Mon, 26 Jul 2021 17:36:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B5604A5A0;
	Mon, 26 Jul 2021 11:36:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKyJZg7BqQlz; Mon, 26 Jul 2021 11:36:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C5584A534;
	Mon, 26 Jul 2021 11:36:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1529640569
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 11:36:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mBRX5-LoxFsN for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Jul 2021 11:35:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9BD4440870
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 11:35:58 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8495360295;
 Mon, 26 Jul 2021 15:35:57 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m82e3-001511-EF; Mon, 26 Jul 2021 16:35:55 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
Subject: [PATCH v2 0/6] KVM: Remove kvm_is_transparent_hugepage() and friends
Date: Mon, 26 Jul 2021 16:35:46 +0100
Message-Id: <20210726153552.1535838-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org, seanjc@google.com,
 willy@infradead.org, pbonzini@redhat.com, will@kernel.org, qperret@google.com,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Sean Christopherson <seanjc@google.com>,
 Matthew Wilcox <willy@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>
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

A while ago, Willy and Sean pointed out[0] that arm64 is the last user
of kvm_is_transparent_hugepage(), and that there would actually be
some benefit in looking at the userspace mapping directly instead.

This small series does exactly that, although it doesn't try to
support more than a PMD-sized mapping yet for THPs. We could probably
look into unifying this with the huge PUD code, and there is still
some potential use of the contiguous hint.

As a consequence, it removes kvm_is_transparent_hugepage(),
PageTransCompoundMap() and kvm_get_pfn(), all of which have no user
left after this rework.

This has been lightly tested on an Altra box (VHE) and on a SC2A11
system (nVHE). Although nothing caught fire, it requires some careful
reviewing on the arm64 side.

* From v1 [1]:

  - Move the PT helper into its own function, as both Quentin and I
    need it for other developments
  - Fixed stupid bug introduced by a bad conflict resolution, spotted
    by Alexandru
  - Collected Acks from Paolo, with thanks

[0] https://lore.kernel.org/r/YLpLvFPXrIp8nAK4@google.com
[1] https://lore.kernel.org/r/20210717095541.1486210-1-maz@kernel.org

Marc Zyngier (6):
  KVM: arm64: Introduce helper to retrieve a PTE and its level
  KVM: arm64: Walk userspace page tables to compute the THP mapping size
  KVM: arm64: Avoid mapping size adjustment on permission fault
  KVM: Remove kvm_is_transparent_hugepage() and PageTransCompoundMap()
  KVM: arm64: Use get_page() instead of kvm_get_pfn()
  KVM: Get rid of kvm_get_pfn()

 arch/arm64/include/asm/kvm_pgtable.h | 19 ++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 39 ++++++++++++++++++++++++
 arch/arm64/kvm/mmu.c                 | 45 +++++++++++++++++++++++-----
 include/linux/kvm_host.h             |  1 -
 include/linux/page-flags.h           | 37 -----------------------
 virt/kvm/kvm_main.c                  | 19 +-----------
 6 files changed, 97 insertions(+), 63 deletions(-)

-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
