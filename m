Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17960605AA4
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 11:07:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F4654B975;
	Thu, 20 Oct 2022 05:07:52 -0400 (EDT)
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
	with ESMTP id Ue5L3o4fox73; Thu, 20 Oct 2022 05:07:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A1044B98F;
	Thu, 20 Oct 2022 05:07:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E29B4B916
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:07:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y8De963DZ4dO for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 05:07:48 -0400 (EDT)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 193904B95F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:07:45 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E3510CE242D;
 Thu, 20 Oct 2022 09:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B4CC433D6;
 Thu, 20 Oct 2022 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666256857;
 bh=2HQPwIcjnx+D5AD9h09X90hRYsJsZKbWVHayjSpUAE0=;
 h=From:To:Cc:Subject:Date:From;
 b=WTIhtrff87iG+LcQydL0Dg7ipSaIR/2JhYX4DPIhYWInKK/JuSG+mOdQOj9GrmPe8
 JWCbNA1TxATmFaB/gVn4bPgr1n0CI62qsYYoiQRnJBEZUv+4xhrKS12SvDtrKscY7z
 Z/j3RloGHUOR2dy2CR/7Kj1E7aLwaejhdqKRauJdgo6SQigomaOo3vK3WgWjv/Ag85
 wQww3rBF74ueBLReJRMTfWJVQzF7kRy4KnIQy2EVdmow0gta+t0pOf30Z+n7cfDH7Y
 Ig+13g9oPVZRV40hjoPrw67wC4FV7TUJPpcyoePafiSAeDshQDleu9GasTvKloLIpI
 WnuoRW1Ko+0bQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1olRWY-000Buf-GE;
 Thu, 20 Oct 2022 10:07:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: <kvmarm@lists.cs.columbia.edu>, <kvmarm@lists.linux.dev>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/17] KVM: arm64: Allow using VHE in the nVHE hypervisor
Date: Thu, 20 Oct 2022 10:07:10 +0100
Message-Id: <20221020090727.3669908-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 qperret@google.com, will@kernel.org, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>
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

KVM (on ARMv8.0) and pKVM (on all revisions of the architecture) uses
the split hypervisor model that makes the EL2 code more or less
standalone. For this, we totally ignore the VHE mode and stick with
the good old v8.0 EL2 setup.

This is all good, but means that the EL2 code is limited in what it
can do with its own address space. This series proposes to remove this
limitation and to allow VHE to be used even with the split hypervisor
model. This has some potential isolation benefits[1], and *maybe*
allow deviant systems to eventually run pKVM.

It introduce a new "mode" for KVM called hVHE, in reference to the
nVHE mode, and indicating that only the hypervisor is using VHE. Note
that this is all this series does. No effort is made to improve the VA
space management, which will be the subject of another series if this
one ever makes it.

This has been lightly tested on a M1 box, with no measurable change in
performance.

Thanks,

	M.

[1] https://www.youtube.com/watch?v=1F_Mf2j9eIo&list=PLbzoR-pLrL6qWL3v2KOcvwZ54-w0z5uXV&index=11

Marc Zyngier (17):
  arm64: Turn kaslr_feature_override into a generic SW feature override
  arm64: Add KVM_HVHE capability and has_hvhe() predicate
  arm64: Don't enable VHE for the kernel if OVERRIDE_HVHE is set
  arm64: Prevent the use of is_kernel_in_hyp_mode() in hypervisor code
  arm64: Allow EL1 physical timer access when running VHE
  arm64: Use CPACR_EL1 format to set CPTR_EL2 when E2H is set
  KVM: arm64: Elide kern_hyp_va() in VHE-specific parts of the
    hypervisor
  KVM: arm64: Remove alternatives from sysreg accessors in VHE
    hypervisor context
  KVM: arm64: Key use of VHE instructions in nVHE code off
    ARM64_KVM_HVHE
  KVM: arm64: Force HCR_EL2.E2H when ARM64_KVM_HVHE is set
  KVM: arm64: Disable TTBR1_EL2 when using ARM64_KVM_HVHE
  KVM: arm64: Adjust EL2 stage-1 leaf AP bits when ARM64_KVM_HVHE is set
  KVM: arm64: Rework CPTR_EL2 programming for HVHE configuration
  KVM: arm64: Program the timer traps with VHE layout in hVHE mode
  KVM: arm64: Force HCR_E2H in guest context when ARM64_KVM_HVHE is set
  arm64: Allow arm64_sw.hvhe on command line
  KVM: arm64: Terrible timer hack for M1 with hVHE

 arch/arm64/include/asm/arch_timer.h     |  8 ++++
 arch/arm64/include/asm/cpufeature.h     |  5 +++
 arch/arm64/include/asm/el2_setup.h      | 16 +++++++-
 arch/arm64/include/asm/kvm_arm.h        |  3 --
 arch/arm64/include/asm/kvm_asm.h        |  1 +
 arch/arm64/include/asm/kvm_emulate.h    | 33 +++++++++++++++-
 arch/arm64/include/asm/kvm_hyp.h        | 37 +++++++++++++-----
 arch/arm64/include/asm/kvm_mmu.h        |  4 ++
 arch/arm64/include/asm/virt.h           | 15 +++++++-
 arch/arm64/kernel/cpufeature.c          | 17 +++++++++
 arch/arm64/kernel/hyp-stub.S            | 21 ++++++++++-
 arch/arm64/kernel/idreg-override.c      | 25 ++++++++-----
 arch/arm64/kernel/image-vars.h          |  3 ++
 arch/arm64/kernel/kaslr.c               |  6 +--
 arch/arm64/kvm/arch_timer.c             |  5 +++
 arch/arm64/kvm/arm.c                    | 12 +++++-
 arch/arm64/kvm/fpsimd.c                 |  4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 17 ++++++++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c          | 27 ++++++++++---
 arch/arm64/kvm/hyp/nvhe/switch.c        | 28 ++++++++------
 arch/arm64/kvm/hyp/nvhe/timer-sr.c      | 29 ++++++++++----
 arch/arm64/kvm/hyp/pgtable.c            |  6 ++-
 arch/arm64/kvm/hyp/vhe/switch.c         |  2 +-
 arch/arm64/tools/cpucaps                |  1 +
 drivers/irqchip/irq-apple-aic.c         | 50 ++++++++++++++++++++++++-
 26 files changed, 312 insertions(+), 65 deletions(-)

-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
