Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A535B21ED21
	for <lists+kvmarm@lfdr.de>; Tue, 14 Jul 2020 11:45:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CBDF44B172;
	Tue, 14 Jul 2020 05:45:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 81vNu3-DvaKL; Tue, 14 Jul 2020 05:45:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 94B324B1CE;
	Tue, 14 Jul 2020 05:45:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CD564B1BA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jul 2020 05:45:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZcCKyUuT+5vD for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Jul 2020 05:45:24 -0400 (EDT)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A840E4B1B1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jul 2020 05:45:24 -0400 (EDT)
Received: by mail-qt1-f201.google.com with SMTP id s25so12199592qth.9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jul 2020 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=FMeLLrLGlVrLyat0/dy++psqxJ6EVaik+OHWVG4c7Dg=;
 b=B+m2/A8DEOCD3umsXZwLC+NuVvx0P/cNufJV7/LTeEAIJBvBnh9DAOoFwTuYGgKncD
 qhNeHb5yGwcu8FPTmt1Qty6xSzVvTvNjCASp6P8nV30dcDm94qzUhFW7LxlFTd8Ee+d2
 pF6J/mqEmbabfZcVvibWUOF3YSnmDji6R0V6Vs2IqmXKNklmys8tjdntXpKwH93NORX3
 Gk5stacZRyWm8xVgeC/yHOoLVgwjLxjFYdourRY7xmWP+hMxWmLy2iEbrbVwaLrTpuAt
 btCZIIdlmFGXLQS86TkbMeHSdoLw8jFeXtN0wpWOBBsYQAfwSPTlxgl9VrbMzm0Ja+/J
 qKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=FMeLLrLGlVrLyat0/dy++psqxJ6EVaik+OHWVG4c7Dg=;
 b=rin3BxncCI2gGyUfzR5Si02416DQjdhI8csAS/rhrKs4lyMY7IMI0mIEPe9lPypj0+
 Niy7ILp6zX2VzCeRTPb/6ylhr2M86iBgTfaP3cNxVaPa8rISr8ZiFSOHSZ/Pa3Mu2Lg/
 JyOgRo1dh+I20nPJZKmP93pK+meigWCU4Lb+emxc6g+EezJBWp639FqhTH4uDPO8qgxP
 knYEU56wd4xsFsVlE34LP41cGSXsj9oAgo09gxeiUPFlT1EjK5p0ohQ6UG1e1Q5mNBGa
 uCHF/faG+WV55QH0BWxEQbHlsJ4p+6IksfWi8cqSgb9vEVh5Vqn776ysTWtZBeDasTn/
 /maA==
X-Gm-Message-State: AOAM5338GMcuwtR2uh6dwdysw+vp0fKKWJCmyGXjgvjv3zITEWfcWZ0y
 q3PjFkzSuPxWnhLCO2qhxqO3XIANYzWpLdnGez5ckY8OJrDvTM3g3eawekQ2m0R7MMi/WprCKSq
 NQe1Olo1y+tPrhgxi/stkNlIbhqWTDaLS0n6nWEtnkwtW7+ySG4CKPfwp8kMOlp9G3yHFFw==
X-Google-Smtp-Source: ABdhPJxBUDzW2Fuq4CfEEsdo70389a7L1x2LtybMLS5Ywp8DxSZaiSuupoOKEGGMmhRm9s2NcTGJOV7w/6Q=
X-Received: by 2002:a0c:b61d:: with SMTP id f29mr3497305qve.249.1594719924058; 
 Tue, 14 Jul 2020 02:45:24 -0700 (PDT)
Date: Tue, 14 Jul 2020 10:45:20 +0100
Message-Id: <20200714094520.3313396-1-ascull@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH] KVM: arm64: Avoid rewinding the PC for trapped SMCs
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, kernel-team@android.com
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

When handling a guest's SError that was identified in __guest_exit, it
is injected back into the guest at the instruction that caused the
switch into hyp. A trapped SMC does not advance the PC so no adjustment
needs to be made to the PC.

Fixes: ddb3d07cfe90 ("arm64: KVM: Inject a Virtual SError if it was pending")
Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/kvm/handle_exit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 98ab33139982..7d9e198ebdf2 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -244,12 +244,11 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		u8 esr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
 
 		/*
-		 * HVC/SMC already have an adjusted PC, which we need
+		 * HVC already has an adjusted PC, which we need
 		 * to correct in order to return to after having
 		 * injected the SError.
 		 */
-		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64 ||
-		    esr_ec == ESR_ELx_EC_SMC32 || esr_ec == ESR_ELx_EC_SMC64) {
+		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64) {
 			u32 adj =  kvm_vcpu_trap_il_is32bit(vcpu) ? 4 : 2;
 			*vcpu_pc(vcpu) -= adj;
 		}
-- 
2.27.0.389.gc38d7665816-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
