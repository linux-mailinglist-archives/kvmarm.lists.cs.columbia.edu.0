Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66616639E
	for <lists+kvmarm@lfdr.de>; Thu, 20 Feb 2020 17:58:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A90F4AF73;
	Thu, 20 Feb 2020 11:58:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlfOAIfNsS9l; Thu, 20 Feb 2020 11:58:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D90644AF46;
	Thu, 20 Feb 2020 11:58:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89D844AEA3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 11:58:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4OrMgNwdJfSe for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Feb 2020 11:58:50 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BD3D4AC69
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 11:58:50 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A30B631B;
 Thu, 20 Feb 2020 08:58:49 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53BE13F68F;
 Thu, 20 Feb 2020 08:58:48 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/3] KVM: arm64: Ask the compiler to __always_inline functions
 used by KVM at HYP
Date: Thu, 20 Feb 2020 16:58:36 +0000
Message-Id: <20200220165839.256881-1-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

Hello!

It turns out KVM relies on the inline hint being honoured by the compiler
in quite a few more places than expected. Something about the Shadow Call
Stack support[0] causes the compiler to avoid inline-ing and to place
these functions outside the __hyp_text. This ruins KVM's day.

Add the simon-says __always_inline annotation to all the static
inlines that KVM calls from HYP code.

This series based on v5.6-rc2.


[0] https://lore.kernel.org/linux-arm-kernel/20200219000817.195049-1-samitolvanen@google.com/

Thanks,

James Morse (3):
  KVM: arm64: Ask the compiler to __always_inline functions used at HYP
  KVM: arm64: define our own swab32() to avoid a uapi static inline
  arm64: Ask the compiler to __always_inline functions used by KVM at
    HYP

 arch/arm64/include/asm/arch_gicv3.h      |  2 +-
 arch/arm64/include/asm/cache.h           |  2 +-
 arch/arm64/include/asm/cacheflush.h      |  2 +-
 arch/arm64/include/asm/cpufeature.h      | 10 ++---
 arch/arm64/include/asm/io.h              |  4 +-
 arch/arm64/include/asm/kvm_emulate.h     | 48 ++++++++++++------------
 arch/arm64/include/asm/kvm_hyp.h         |  7 ++++
 arch/arm64/include/asm/kvm_mmu.h         |  3 +-
 arch/arm64/include/asm/virt.h            |  2 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  4 +-
 10 files changed, 46 insertions(+), 38 deletions(-)

-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
