Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8972B3E942F
	for <lists+kvmarm@lfdr.de>; Wed, 11 Aug 2021 17:02:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C24C5407EF;
	Wed, 11 Aug 2021 11:02:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdSOqfE-B+GP; Wed, 11 Aug 2021 11:02:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F01AF4A19E;
	Wed, 11 Aug 2021 11:02:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9477940874
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Aug 2021 11:02:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7hCwPZztu+BQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Aug 2021 11:02:50 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9C8FF407EF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Aug 2021 11:02:50 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 857E760F55;
 Wed, 11 Aug 2021 15:02:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mDpkl-004MSu-GS; Wed, 11 Aug 2021 16:02:47 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
 Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2] KVM: arm64: Restrict IPA size to maximum 48 bits on 4K
 and 16K page size
Date: Wed, 11 Aug 2021 16:02:44 +0100
Message-Id: <162869415426.2969316.15859233360100994637.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1628680275-16578-1-git-send-email-anshuman.khandual@arm.com>
References: <1628680275-16578-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, alexandru.elisei@arm.com,
 james.morse@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, will@kernel.org
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

On Wed, 11 Aug 2021 16:41:15 +0530, Anshuman Khandual wrote:
> Even though ID_AA64MMFR0.PARANGE reports 52 bit PA size support, it cannot
> be enabled as guest IPA size on 4K or 16K page size configurations. Hence
> kvm_ipa_limit must be restricted to 48 bits. This change achieves required
> IPA capping.
> 
> Before the commit c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA
> size based on host configuration"), the problem here would have been just
> latent via PHYS_MASK_SHIFT (which earlier in turn capped kvm_ipa_limit),
> which remains capped at 48 bits on 4K and 16K configs.

Applied to next, thanks!

[1/1] KVM: arm64: Restrict IPA size to maximum 48 bits on 4K and 16K page size
      commit: 5e5df9571c319fb107d7a523cc96fcc99961ee70

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
