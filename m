Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C722725FCF4
	for <lists+kvmarm@lfdr.de>; Mon,  7 Sep 2020 17:24:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AEB84B50F;
	Mon,  7 Sep 2020 11:24:39 -0400 (EDT)
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
	with ESMTP id NUeZ31QJGMYB; Mon,  7 Sep 2020 11:24:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76FEB4B39A;
	Mon,  7 Sep 2020 11:24:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 296F24B29A
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 11:24:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4rxWsye5hAna for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Sep 2020 11:24:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 31CB54B543
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 11:24:36 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B4D021775;
 Mon,  7 Sep 2020 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599492275;
 bh=Dn5jXA6uX9hWT3V4d3OAqOGah3oL7clyOXpH3mNLhpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WC6xLQsQgsVXUjd/SbDkSc8iE4456d/EusiD15JVVtQidP8+7MeVKIWp8YEA8P7Wz
 Vn55pCzNwYGG8yNwawISZGBMVWMjhyQEwv3c6JF+YHgwj6cHaMYNwUOvK6+jogs1SI
 n+Y4cPihVDwWiPB+UwqaX74yvF03rDv0AhQ+JYYQ=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 18/21] KVM: arm64: Check the pgt instead of the pgd when
 modifying page-table
Date: Mon,  7 Sep 2020 16:23:41 +0100
Message-Id: <20200907152344.12978-19-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907152344.12978-1-will@kernel.org>
References: <20200907152344.12978-1-will@kernel.org>
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

In preparation for removing the 'pgd' field of 'struct kvm_s2_mmu',
update the few remaining users to check the 'pgt' field instead.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index dc923e873dad..548161795dd9 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1826,7 +1826,7 @@ static int kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *dat
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end, unsigned flags)
 {
-	if (!kvm->arch.mmu.pgd)
+	if (!kvm->arch.mmu.pgt)
 		return 0;
 
 	trace_kvm_unmap_hva_range(start, end);
@@ -1889,7 +1889,7 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *
 
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
 {
-	if (!kvm->arch.mmu.pgd)
+	if (!kvm->arch.mmu.pgt)
 		return 0;
 	trace_kvm_age_hva(start, end);
 	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
@@ -1897,7 +1897,7 @@ int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 {
-	if (!kvm->arch.mmu.pgd)
+	if (!kvm->arch.mmu.pgt)
 		return 0;
 	trace_kvm_test_age_hva(hva);
 	return handle_hva_to_gpa(kvm, hva, hva + PAGE_SIZE,
-- 
2.28.0.526.ge36021eeef-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
