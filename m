Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3280F415CC1
	for <lists+kvmarm@lfdr.de>; Thu, 23 Sep 2021 13:23:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D69234B12C;
	Thu, 23 Sep 2021 07:23:08 -0400 (EDT)
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
	with ESMTP id thAnZSDSrC3T; Thu, 23 Sep 2021 07:23:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB38F4B10B;
	Thu, 23 Sep 2021 07:23:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CA974A19A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDcBHej2VQIw for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 07:23:05 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 27C8D4079A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:05 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B855611B0;
 Thu, 23 Sep 2021 11:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632396184;
 bh=9V6D01rnhhu/XVUyi+hFbDZbhJ0tu8PwpuRqUVWmUbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EUArm6thYy22n/hiDJOWbwy+k/vvSIYESSWeMzpw8oXHTN3jgmC3ELFh+Vix2NuX4
 xzIJ/Tz+yhSa6aDPRLc0Cx7j26c0BSkTAxLwairyJOR5AcuR4zfji+YiMJs/sQRiMK
 kffRQRqRPcpL1GkIv4fR0/k9RPRAvSFS0Aa/F4UBsaq3WM36LoZmcwdYR/w4ulueR5
 Opx0Zmr0K7nR+Gy56KtALZVbSB3frUtBUanV1lsMslv3QMW5ZRzCF/v1CpVMTzel1m
 8tejstLQW7YsYlENUPXaHbWjL6zvbS6C+UDaexUdYnJQKPKFQ8sQ9z54H+8FLx7Pw+
 275YAW0PuT3Lg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] arm64: Prevent kexec and hibernation if
 is_protected_kvm_enabled()
Date: Thu, 23 Sep 2021 12:22:52 +0100
Message-Id: <20210923112256.15767-2-will@kernel.org>
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
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
