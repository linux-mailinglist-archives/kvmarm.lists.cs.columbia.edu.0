Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B70C53F2AB0
	for <lists+kvmarm@lfdr.de>; Fri, 20 Aug 2021 13:06:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BD884B0F5;
	Fri, 20 Aug 2021 07:06:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id trRKkuD6KBih; Fri, 20 Aug 2021 07:06:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 31C1F4B0EF;
	Fri, 20 Aug 2021 07:05:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C295407D1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 07:05:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7t-iW1pBGmb for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Aug 2021 07:05:54 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2E156407A0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 07:05:54 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4016C60FDC;
 Fri, 20 Aug 2021 11:05:53 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mH2LO-006AgP-Dv; Fri, 20 Aug 2021 12:05:51 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	David Brazdil <dbrazdil@google.com>
Subject: Re: (subset) [PATCH 0/2] Fix off-by-one in range_is_memory
Date: Fri, 20 Aug 2021 12:05:44 +0100
Message-Id: <162945752305.2126143.7959914980998500483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210728153232.1018911-1-dbrazdil@google.com>
References: <20210728153232.1018911-1-dbrazdil@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, dbrazdil@google.com,
 linux-kernel@vger.kernel.org, will@kernel.org, qperret@google.com,
 alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org,
 james.morse@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Wed, 28 Jul 2021 15:32:30 +0000, David Brazdil wrote:
> the range_is_memory function in hyp.
> 
> David Brazdil (2):
>   KVM: arm64: Fix off-by-one in range_is_memory
>   KVM: arm64: Minor optimization of range_is_memory
> 
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied to kvm-arm64/mmu/el2-tracking, thanks!

[2/2] KVM: arm64: Minor optimization of range_is_memory
      commit: 14ecf075fe5be01860927fdf3aa11d7b18023ab2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
