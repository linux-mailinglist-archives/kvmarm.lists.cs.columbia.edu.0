Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CF80024860C
	for <lists+kvmarm@lfdr.de>; Tue, 18 Aug 2020 15:29:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 816504BF4F;
	Tue, 18 Aug 2020 09:29:20 -0400 (EDT)
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
	with ESMTP id PLgLXLTNFB5y; Tue, 18 Aug 2020 09:29:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E2894BC56;
	Tue, 18 Aug 2020 09:29:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 381B54BCD2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:29:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vlh+DQ-5YvSD for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Aug 2020 09:29:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 219C54BA3A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:29:14 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D9F5B206DA;
 Tue, 18 Aug 2020 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597757353;
 bh=eeFbjB1GLDvhaOFEH8/XLNvHqlG8yKwgmnDBzgor7fQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j50hMc7cpE8igAA3y50a5h9d022S+PgY0HA7Yx3dIZ/jYrNXqPvqvraocGFptWb/S
 X1cYBylnHuygbst+aB7A+X7zERYDlrmFAJpi9fDPidLYegVwY83en8pJbKpm0Hti6l
 3bDgYSFtcdzOUWQiuFhRHK+EqiQv8mdgfcpu1WBA=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 22/22] KVM: arm64: Don't constrain maximum IPA size based
 on host configuration
Date: Tue, 18 Aug 2020 14:28:18 +0100
Message-Id: <20200818132818.16065-23-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818132818.16065-1-will@kernel.org>
References: <20200818132818.16065-1-will@kernel.org>
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

Now that the guest stage-2 page-tables are managed independently from
the host stage-1 page-tables, we can avoid constraining the IPA size
based on the host and instead limit it only based on the PARange field
of the ID_AA64MMFR0 register.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/reset.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index ee33875c5c2a..471ee9234e40 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -339,7 +339,7 @@ u32 get_kvm_ipa_limit(void)
 
 int kvm_set_ipa_limit(void)
 {
-	unsigned int ipa_max, pa_max, va_max, parange, tgran_2;
+	unsigned int parange, tgran_2;
 	u64 mmfr0;
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
@@ -376,38 +376,10 @@ int kvm_set_ipa_limit(void)
 		break;
 	}
 
-	pa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
-
-	/* Clamp the IPA limit to the PA size supported by the kernel */
-	ipa_max = (pa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : pa_max;
-	/*
-	 * Since our stage2 table is dependent on the stage1 page table code,
-	 * we must always honor the following condition:
-	 *
-	 *  Number of levels in Stage1 >= Number of levels in Stage2.
-	 *
-	 * So clamp the ipa limit further down to limit the number of levels.
-	 * Since we can concatenate upto 16 tables at entry level, we could
-	 * go upto 4bits above the maximum VA addressable with the current
-	 * number of levels.
-	 */
-	va_max = PGDIR_SHIFT + PAGE_SHIFT - 3;
-	va_max += 4;
-
-	if (va_max < ipa_max)
-		ipa_max = va_max;
-
-	/*
-	 * If the final limit is lower than the real physical address
-	 * limit of the CPUs, report the reason.
-	 */
-	if (ipa_max < pa_max)
-		pr_info("kvm: Limiting the IPA size due to kernel %s Address limit\n",
-			(va_max < pa_max) ? "Virtual" : "Physical");
-
-	WARN(ipa_max < KVM_PHYS_SHIFT,
-	     "KVM IPA limit (%d bit) is smaller than default size\n", ipa_max);
-	kvm_ipa_limit = ipa_max;
+	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
+	WARN(kvm_ipa_limit < KVM_PHYS_SHIFT,
+	     "KVM IPA limit (%d bit) is smaller than default size\n",
+	     kvm_ipa_limit);
 	kvm_info("IPA Size Limit: %dbits\n", kvm_ipa_limit);
 
 	return 0;
-- 
2.28.0.220.ged08abb693-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
