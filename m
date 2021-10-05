Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD9422512
	for <lists+kvmarm@lfdr.de>; Tue,  5 Oct 2021 13:37:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 619DC4B270;
	Tue,  5 Oct 2021 07:37:42 -0400 (EDT)
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
	with ESMTP id 7znpImIIBT+p; Tue,  5 Oct 2021 07:37:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21E2B4B2DF;
	Tue,  5 Oct 2021 07:37:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 951314B2C4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Oct 2021 07:37:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PM26gqInVp56 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Oct 2021 07:37:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AE9D24B2CA
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Oct 2021 07:37:38 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 579CD613AC;
 Tue,  5 Oct 2021 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633433857;
 bh=YDg8wjlM3PEKxET6Y7NSL5dzz3DAKCknRgdO4XsRQio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AbrYFeAXygGZtwMc6B3g1VaSM5p6goSJPJ0eK5rzK65BPP1ot7ZIl3F10e5v5s7be
 Wq0K+Cp4IMM4Uqo4PG9M1DuBUi9/D8yKZ0oj/Dudx+f3w0px00b9+N6mEx5M+ycwsH
 swEhyftNSFWivF6YJNNGCOlF1Xi6HGTOeB03uPvk4I61XSluwvcSEZ+Xpo4KU8k1aD
 g3R2/DlRhyVQJwtbUCvampB/WN/LAcoodh99bswkhd9Vis+IviuO/Xo+DVcRJasKtC
 aDsYr8hVU1YH702uo2CKSj8T4cbMUscBKAGNMG05pNWstv/IKI+jK4QpRdE9/07Mhd
 TlExoMjOiJoVg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] arm64: Prevent kexec and hibernation if
 is_protected_kvm_enabled()
Date: Tue,  5 Oct 2021 12:37:17 +0100
Message-Id: <20211005113721.29441-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211005113721.29441-1-will@kernel.org>
References: <20211005113721.29441-1-will@kernel.org>
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

When pKVM is enabled, the hypervisor code at EL2 and its data structures
are inaccessible to the host kernel and cannot be torn down or replaced
as this would defeat the integrity properies which pKVM aims to provide.
Furthermore, the ABI between the host and EL2 is flexible and private to
whatever the current implementation of KVM requires and so booting a new
kernel with an old EL2 component is very likely to end in disaster.

In preparation for uninstalling the hyp stub calls which are relied upon
to reset EL2, disable kexec and hibernation in the host when protected
KVM is enabled.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6f6ff072acbd..44369b99a57e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1128,5 +1128,6 @@ bool cpus_are_stuck_in_kernel(void)
 {
 	bool smp_spin_tables = (num_possible_cpus() > 1 && !have_cpu_die());
 
-	return !!cpus_stuck_in_kernel || smp_spin_tables;
+	return !!cpus_stuck_in_kernel || smp_spin_tables ||
+		is_protected_kvm_enabled();
 }
-- 
2.33.0.800.g4c38ced690-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
