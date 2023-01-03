Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B080265BDBA
	for <lists+kvmarm@lfdr.de>; Tue,  3 Jan 2023 11:13:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 358D34BB89;
	Tue,  3 Jan 2023 05:13:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VYNRXKhpf5wB; Tue,  3 Jan 2023 05:13:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA6A64BB84;
	Tue,  3 Jan 2023 05:13:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E39BD40E25
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Jan 2023 05:13:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTq3m71bLKN4 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Jan 2023 05:13:11 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C130E40BB5
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Jan 2023 05:13:11 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 25B3661232;
 Tue,  3 Jan 2023 10:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790A3C433D2;
 Tue,  3 Jan 2023 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672740790;
 bh=9OKqpjCDRd3C36Nqs8Q17tIqDdDxTiYwlP2yAWpmOsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HAVJ5bFqx589bVX+ta4DzcoNpOYa8X4yM3FdrkuGA4BPgI2eE8UXFpJzJM63g5gp5
 nsX3pyPQUFcPY3nYm/0NGdSmCDj5+XfTsJzG3YSZaiYLTfp5mVfxC5flkS/0/8B44+
 ZWWNhAtifkPM0vZMiVWJlHr52bMrcz5rbzCelSjKJLwE/Jg/i31vxU6fYb/0OXfnoh
 GhM9+8ta+6pOf8Ns7oLbx6JWiqzQ8GJl2XwG4lUZmxxvB9zlOKZqqWPakj2+9gq+W8
 Jk0lS2osrMJUvfjKezTJaggYU4gAcT9BSJ4xmSD+ko1wopemqMwT6ZOQ3/EeniR2KS
 XP3P+sNN5m/aA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1pCeGC-00GTpw-Ap;
 Tue, 03 Jan 2023 10:13:08 +0000
From: Marc Zyngier <maz@kernel.org>
To: <kvmarm@lists.cs.columbia.edu>, <kvmarm@lists.linux.dev>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] KVM: arm64: Fix S1PTW handling on RO memslots
Date: Tue,  3 Jan 2023 10:09:02 +0000
Message-Id: <20230103100904.3232426-2-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103100904.3232426-1-maz@kernel.org>
References: <20230103100904.3232426-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 ardb@kernel.org, will@kernel.org, qperret@google.com, ricarkol@google.com,
 stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, stable@vger.kernel.org
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

A recent development on the EFI front has resulted in guests having
their page tables baked in the firmware binary, and mapped into the
IPA space as part of a read-only memslot. Not only is this legitimate,
but it also results in added security, so thumbs up.

It is possible to take an S1PTW translation fault if the S1 PTs are
unmapped at stage-2. However, KVM unconditionally treats S1PTW as a
write to correctly handle hardware AF/DB updates to the S1 PTs.
Furthermore, KVM injects an exception into the guest for S1PTW writes.
In the aforementioned case this results in the guest taking an abort
it won't recover from, as the S1 PTs mapping the vectors suffer from
the same problem.

So clearly our handling is... wrong.

Instead, switch to a two-pronged approach:

- On S1PTW translation fault, handle the fault as a read

- On S1PTW permission fault, handle the fault as a write

This is of no consequence to SW that *writes* to its PTs (the write
will trigger a non-S1PTW fault), and SW that uses RO PTs will not
use HW-assisted AF/DB anyway, as that'd be wrong.

Only in the case described in c4ad98e4b72c ("KVM: arm64: Assume write
fault on S1PTW permission fault on instruction fetch") do we end-up
with two back-to-back faults (page being evicted and faulted back).
I don't think this is a case worth optimising for.

Fixes: c4ad98e4b72c ("KVM: arm64: Assume write fault on S1PTW permission fault on instruction fetch")
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Regression-tested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/kvm_emulate.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 9bdba47f7e14..0d40c48d8132 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -373,8 +373,26 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 {
-	if (kvm_vcpu_abt_iss1tw(vcpu))
-		return true;
+	if (kvm_vcpu_abt_iss1tw(vcpu)) {
+		/*
+		 * Only a permission fault on a S1PTW should be
+		 * considered as a write. Otherwise, page tables baked
+		 * in a read-only memslot will result in an exception
+		 * being delivered in the guest.
+		 *
+		 * The drawback is that we end-up faulting twice if the
+		 * guest is using any of HW AF/DB: a translation fault
+		 * to map the page containing the PT (read only at
+		 * first), then a permission fault to allow the flags
+		 * to be set.
+		 */
+		switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
+		case ESR_ELx_FSC_PERM:
+			return true;
+		default:
+			return false;
+		}
+	}
 
 	if (kvm_vcpu_trap_is_iabt(vcpu))
 		return false;
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
