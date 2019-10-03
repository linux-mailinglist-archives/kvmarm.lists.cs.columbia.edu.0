Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCBBC9D46
	for <lists+kvmarm@lfdr.de>; Thu,  3 Oct 2019 13:32:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CAE84A799;
	Thu,  3 Oct 2019 07:32:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Epn7Ap9hbQoW; Thu,  3 Oct 2019 07:32:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F015C4A797;
	Thu,  3 Oct 2019 07:32:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21ABA4A76A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Oct 2019 07:32:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hRyct2jBcPgt for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Oct 2019 07:32:35 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 012F44A763
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Oct 2019 07:32:34 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73465337;
 Thu,  3 Oct 2019 04:32:34 -0700 (PDT)
Received: from e123195-lin.cambridge.arm.com (e123195-lin.cambridge.arm.com
 [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65BED3F706;
 Thu,  3 Oct 2019 04:32:33 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH v2 0/3] arm64: Add code generation test
Date: Thu,  3 Oct 2019 12:32:14 +0100
Message-Id: <20191003113217.25464-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: pbonzini@redhat.com, andre.przywara@arm.com, maz@kernel.org
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

Add a test to check if KVM honors the CTR_EL0.{IDC, DIC} bits that it
advertises to the guests. Full details are in patch #3.

Changes in v2:
* Gathered Reviewed-by tags.
* Fixed typo s/group/groups in #3.

Alexandru Elisei (3):
  lib: arm64: Add missing ISB in flush_tlb_page
  lib: arm/arm64: Add function to clear the PTE_USER bit
  arm64: Add cache code generation test

 arm/Makefile.arm64    |   1 +
 lib/arm/asm/mmu-api.h |   1 +
 lib/arm64/asm/mmu.h   |   1 +
 lib/arm/mmu.c         |  15 ++++++
 arm/cache.c           | 122 ++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg     |   6 +++
 6 files changed, 146 insertions(+)
 create mode 100644 arm/cache.c

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
