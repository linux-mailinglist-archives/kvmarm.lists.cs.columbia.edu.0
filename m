Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A19DA2B1A27
	for <lists+kvmarm@lfdr.de>; Fri, 13 Nov 2020 12:39:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5031D4BCC8;
	Fri, 13 Nov 2020 06:39:02 -0500 (EST)
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
	with ESMTP id 4rbEfc3cfJSv; Fri, 13 Nov 2020 06:39:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DB4224BD10;
	Fri, 13 Nov 2020 06:39:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99BC04BCB9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:38:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LfgSxzELcae1 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Nov 2020 06:38:54 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EE7514BCB6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:38:53 -0500 (EST)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 59846207DE;
 Fri, 13 Nov 2020 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605267532;
 bh=TQW1HtvAeQY9ozNTwkErSVp734i5VC2RIXr7phnNwbA=;
 h=From:To:Cc:Subject:Date:From;
 b=WC2ub51q1aO355REBOJk95M6SkzV09XmGnloSOScxtl+M5jHcOjmZ7WuiUhfcE/45
 BAd/BurVda+ZMGOceuBon29QtC7JMjJo6Jwqobc/S+GQNd+HJSZZsqKVBmoTpStAcm
 GEiMCIDcCndotdYXcyHaqZLrl8TINhvd433QpacA=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 00/10] Rework hyp vector handling
Date: Fri, 13 Nov 2020 11:38:37 +0000
Message-Id: <20201113113847.21619-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
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

Hi all,

This is version three of the patches I previously posted here:

  v1: https://lore.kernel.org/r/20201026155833.24847-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109214726.15276-1-will@kernel.org

Changes since v3 include:

  * Fix vector initialisation for VHE systems
  * Remove redundant hyp vectors entry

Hopefully this survives more testing than the last lot.

Cheers,

Will

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>

--->8

Will Deacon (10):
  KVM: arm64: Remove redundant Spectre-v2 code from kvm_map_vector()
  KVM: arm64: Tidy up kvm_map_vector()
  KVM: arm64: Move kvm_get_hyp_vector() out of header file
  KVM: arm64: Make BP hardening globals static instead
  KVM: arm64: Move BP hardening helpers into spectre.h
  KVM: arm64: Re-jig logic when patching hardened hyp vectors
  KVM: arm64: Allocate hyp vectors statically
  arm64: spectre: Rename ARM64_HARDEN_EL2_VECTORS to ARM64_SPECTRE_V3A
  arm64: spectre: Consolidate spectre-v3a detection
  KVM: arm64: Remove redundant hyp vectors entry

 Documentation/arm64/memory.rst   |  2 +-
 arch/arm64/include/asm/cpucaps.h |  2 +-
 arch/arm64/include/asm/kvm_asm.h |  5 --
 arch/arm64/include/asm/kvm_mmu.h | 46 ---------------
 arch/arm64/include/asm/mmu.h     | 29 ----------
 arch/arm64/include/asm/spectre.h | 63 ++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c   | 19 ++-----
 arch/arm64/kernel/proton-pack.c  | 84 +++++++++++----------------
 arch/arm64/kvm/arm.c             | 98 ++++++++++++++++++++++----------
 arch/arm64/kvm/hyp/Makefile      |  2 +-
 arch/arm64/kvm/hyp/hyp-entry.S   | 71 +++++++++++++----------
 arch/arm64/kvm/hyp/smccc_wa.S    | 32 -----------
 arch/arm64/kvm/va_layout.c       | 18 +-----
 13 files changed, 215 insertions(+), 256 deletions(-)
 delete mode 100644 arch/arm64/kvm/hyp/smccc_wa.S

-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
