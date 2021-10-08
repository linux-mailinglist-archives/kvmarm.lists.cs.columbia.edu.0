Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB9426C37
	for <lists+kvmarm@lfdr.de>; Fri,  8 Oct 2021 15:58:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8174B4B162;
	Fri,  8 Oct 2021 09:58:57 -0400 (EDT)
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
	with ESMTP id B0xQvUimkFb7; Fri,  8 Oct 2021 09:58:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 721094B15C;
	Fri,  8 Oct 2021 09:58:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AA8144B149
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 09:58:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NxNzrrIVLhzZ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 09:58:54 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6F7944B13E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 09:58:54 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2062D610CE;
 Fri,  8 Oct 2021 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633701533;
 bh=4KM8LxAKb5VvinllXj4LLTwxDcCC5aREEGZbHA8T4I4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BVV5/5Y6SlVKAxflH4ZlZtnx40guLDtRcu1pC5GXvaOIzVXoIK6eWsGI5GW2j2cUZ
 uM7tHkCPBcRpo9/kiQBep/dcHeAaNqMN2ARnydZRa/pBH+shi7c5HJK3X1nnsjtrLI
 +HLVTcxpJYt19kmnVJvBok3AHqtWg+ixgBRxpQfB29s4TlsIep/VYAS78e5phnKESo
 inKzNTw26JzivAmtTmYtiwm7737K/ebrwaJH4TGrBcJuutgs/KHOqwg2NmjeHHCVSA
 /5nPzDuWAsVssiTIUlRgUCvI15mfeOAK9E0HiY7ial7VXUXVYElal8eabV2vY9VGkN
 v+Nr8PPTZo4fA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/6] arm64: Prevent kexec and hibernation if
 is_protected_kvm_enabled()
Date: Fri,  8 Oct 2021 14:58:35 +0100
Message-Id: <20211008135839.1193-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211008135839.1193-1-will@kernel.org>
References: <20211008135839.1193-1-will@kernel.org>
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
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
