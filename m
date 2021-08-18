Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F30073EFFBC
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 10:57:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DAD04B0BE;
	Wed, 18 Aug 2021 04:57:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8H0nk7t+ifDF; Wed, 18 Aug 2021 04:57:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FB3F4B0BC;
	Wed, 18 Aug 2021 04:57:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F25B4B08B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 04:57:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xTQLSSJkw0s for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 04:57:42 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 70AF949F5F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 04:57:42 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76BA761075;
 Wed, 18 Aug 2021 08:57:41 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mGHOF-005hti-Px; Wed, 18 Aug 2021 09:57:39 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
 Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 0/5] KVM: arm64: General cleanups
Date: Wed, 18 Aug 2021 09:57:37 +0100
Message-Id: <162927703840.2372.14610953148314715293.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
References: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 anshuman.khandual@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 james.morse@arm.com, alexandru.elisei@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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

On Thu, 12 Aug 2021 10:39:49 +0530, Anshuman Khandual wrote:
> This series contains mostly unrelated general cleanups. This series applies
> on v5.14-rc5 and has been boot tested with different page sized guests.
> 
> Changes in V2:
> 
> - Dropped the first patch regarding PAGE_[SHIFT|SIZE] per Marc
> - Added remaining ID_AA64MMFR0_PARANGE_ macros and ARM64_MIN_PARANGE_BITS per Marc
> - Dropped memory and cycle reference from commit message in [PATCH 3/5]
> - Changed return value as u32 in kvm_target_cpu() per Will
> 
> [...]

Applied to next, thanks!

[1/5] arm64/mm: Add remaining ID_AA64MMFR0_PARANGE_ macros
      commit: 504c6295b998effa682089747a96d7bb5933d4db
[2/5] KVM: arm64: Use ARM64_MIN_PARANGE_BITS as the minimum supported IPA
      commit: 9788c14060f3c179c376b2a87af1a430d4d84973
[3/5] KVM: arm64: Drop init_common_resources()
      commit: bf249d9e362f1011a839d57e771b4b1a7eed9656
[4/5] KVM: arm64: Drop check_kvm_target_cpu() based percpu probe
      commit: 6b7982fefc1fdcaa31b712f5fbc2e993cc99ad23
[5/5] KVM: arm64: Drop unused REQUIRES_VIRT
      commit: 9329752bc8659e3934e2b13434b2fddb0df0bb13

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
