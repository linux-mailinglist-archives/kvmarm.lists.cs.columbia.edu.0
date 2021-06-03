Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 57D0239AA14
	for <lists+kvmarm@lfdr.de>; Thu,  3 Jun 2021 20:34:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F2EF64B111;
	Thu,  3 Jun 2021 14:34:07 -0400 (EDT)
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
	with ESMTP id Iw2HMtggyCNr; Thu,  3 Jun 2021 14:34:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9C1F4B10C;
	Thu,  3 Jun 2021 14:34:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 958224B10C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 14:34:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MgHG3nwfEitT for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Jun 2021 14:34:04 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B817D4B108
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 14:34:03 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F2C8613B8;
 Thu,  3 Jun 2021 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622745242;
 bh=osyrOd8rLcVCMiPHAeJKLzTGdMUBbbPPNLLfrYOVNtE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fOt+VKmNu2qb7NlmlC8F8f7NZks31mqaTKoFAcQTxTnnIZsP99bm4KVUW3Fy5BRvN
 k2jFjdJeC1Ex6aXIlzQTS6Z+2nmuqbXQ5BCBEDUFJ2hXtvBa2kF4PGG8m6Ug2xCo0Q
 2mkPnUbq1g9fcBSTNR1e0d8gzL2CvA8qU1mdCLwmONsEdMYiX9MBJPQUtdKpSzTkEr
 ei3Ud1mbQSStGuUhg7+ec20zSiVnEUYt0Fyd7Ylz0JXyoDEzLq6C2N7S8fN7v4J9dy
 l0CBMMnNmYEK9oOkkz2xWN2Ub6RyqV+ey0y9/m+fBqIL12YAOOv7nPK2CygTSFZayc
 TwB4LD/lrL5yg==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 2/4] KVM: arm64: Extend comment in has_vhe()
Date: Thu,  3 Jun 2021 19:33:45 +0100
Message-Id: <20210603183347.1695-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210603183347.1695-1-will@kernel.org>
References: <20210603183347.1695-1-will@kernel.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>
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

has_vhe() expands to a compile-time constant when evaluated from the VHE
or nVHE code, alternatively checking a static key when called from
elsewhere in the kernel. On face value, this looks like a case of
premature optimization, but in fact this allows symbol references on
VHE-specific code paths to be dropped from the nVHE object.

Expand the comment in has_vhe() to make this clearer, hopefully
discouraging anybody from simplifying the code.

Cc: David Brazdil <dbrazdil@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/virt.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7379f35ae2c6..3218ca17f819 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -111,6 +111,9 @@ static __always_inline bool has_vhe(void)
 	/*
 	 * Code only run in VHE/NVHE hyp context can assume VHE is present or
 	 * absent. Otherwise fall back to caps.
+	 * This allows the compiler to discard VHE-specific code from the
+	 * nVHE object, reducing the number of external symbol references
+	 * needed to link.
 	 */
 	if (is_vhe_hyp_code())
 		return true;
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
