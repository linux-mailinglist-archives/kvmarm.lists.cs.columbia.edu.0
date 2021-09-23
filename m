Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DB415CC4
	for <lists+kvmarm@lfdr.de>; Thu, 23 Sep 2021 13:23:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 415E94B102;
	Thu, 23 Sep 2021 07:23:14 -0400 (EDT)
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
	with ESMTP id 6l1B3tvAZJdj; Thu, 23 Sep 2021 07:23:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 314314B0D7;
	Thu, 23 Sep 2021 07:23:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CBBD4B132
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rYCKzA5Evegk for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 07:23:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9AA064B102
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:10 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75BEF6121F;
 Thu, 23 Sep 2021 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632396189;
 bh=9XTol94Ae+OoVJE6oULI43J/aM3k1N+7z3owBAICrso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RXMy8DYZ5qgn6LaLVqLH062rIFiZAAAwxgsAQJg2dkYGFmW+c9v1zKYJNJEL8Ncl6
 /O7Pls6/YD7T2VtlghGoupJg3Vx6DXNs0TTtJ4cYKdvL7SCYHnDliF7m8sDXKIyIKz
 cfrqah6slI/Ob10r5teEu3UdmaEf97SwgYO0U0+r9qn0OsC/Xe4zZZL45/l2/toZim
 mbNN+6Tm3zVI6qPrdZUmtUysR76X9+j1RrZXRZ73BdjjJSEv64raFc8syVCHiytAwW
 hxjA0/AzL29OtgeAXGFmg5yNThvwhDSxpdlmangTe8fuVsf5zcFu5OxTGh6H7sfryn
 zc82FT5+misCQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] KVM: arm64: Prevent re-finalisation of pKVM for a given
 CPU
Date: Thu, 23 Sep 2021 12:22:55 +0100
Message-Id: <20210923112256.15767-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923112256.15767-1-will@kernel.org>
References: <20210923112256.15767-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

__pkvm_prot_finalize() completes the deprivilege of the host when pKVM
is in use by installing a stage-2 translation table for the calling CPU.

Issuing the hypercall multiple times for a given CPU makes little sense,
but in such a case just return early with -EPERM rather than go through
the whole page-table dance again.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index bacd493a4eac..cafe17e5fa8f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -123,6 +123,9 @@ int __pkvm_prot_finalize(void)
 	struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
 	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
 
+	if (params->hcr_el2 & HCR_VM)
+		return -EPERM;
+
 	params->vttbr = kvm_get_vttbr(mmu);
 	params->vtcr = host_kvm.arch.vtcr;
 	params->hcr_el2 |= HCR_VM;
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
