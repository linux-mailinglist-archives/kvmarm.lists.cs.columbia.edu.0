Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A9A5E415CC3
	for <lists+kvmarm@lfdr.de>; Thu, 23 Sep 2021 13:23:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 58DF84B12F;
	Thu, 23 Sep 2021 07:23:12 -0400 (EDT)
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
	with ESMTP id uplq1O9-SZoY; Thu, 23 Sep 2021 07:23:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15D5E4B13E;
	Thu, 23 Sep 2021 07:23:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C353A4A19A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjzMqluAA5G0 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 07:23:08 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D22EE4B130
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:08 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A39B560EC0;
 Thu, 23 Sep 2021 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632396188;
 bh=zTSEoixQnsN3jbLczk6zfspLIXgI2IJ8ZyDChfPcm6s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fFSg2eCfq7DlcK2X8lz+o8qpNPlQZb3vzjvDAK+6e4fjl+ZAgtnud90Mb5L+VKdU2
 ffXHb/OEgiKumuztfDLE8gILHTcBs/Dq1pLEF2JB8ARcrg3pH80oyIbHDCzv42lfIB
 DZ+7C7MGSrgy6BGo8wrhXY+fvBfy7USZgHc6rDSVzxIb3cAk5k0RZJDBTUmw3WzJpy
 VxKVMMz38G/WBcy+6GBmcK0asTZoojzV90e92cWk9q2iqQzBG/kqtSEBzqYEKbEAuu
 wSX7TXUtDrRVLRhCesU3nGN+XEJ2i64KpmUyxp403TqmGFtv7NF+ITAdesmWU6tBN9
 TcvWAT1j/2n6Q==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] KVM: arm64: Propagate errors from __pkvm_prot_finalize
 hypercall
Date: Thu, 23 Sep 2021 12:22:54 +0100
Message-Id: <20210923112256.15767-4-will@kernel.org>
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

If the __pkvm_prot_finalize hypercall returns an error, we WARN but fail
to propagate the failure code back to kvm_arch_init().

Pass a pointer to a zero-initialised return variable so that failure
to finalise the pKVM protections on a host CPU can be reported back to
KVM.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arm.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9506cf88fa0e..13bbf35896cd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1986,9 +1986,25 @@ static int init_hyp_mode(void)
 	return err;
 }
 
-static void _kvm_host_prot_finalize(void *discard)
+static void _kvm_host_prot_finalize(void *arg)
 {
-	WARN_ON(kvm_call_hyp_nvhe(__pkvm_prot_finalize));
+	int *err = arg;
+
+	if (WARN_ON(kvm_call_hyp_nvhe(__pkvm_prot_finalize)))
+		WRITE_ONCE(*err, -EINVAL);
+}
+
+static int pkvm_drop_host_privileges(void)
+{
+	int ret = 0;
+
+	/*
+	 * Flip the static key upfront as that may no longer be possible
+	 * once the host stage 2 is installed.
+	 */
+	static_branch_enable(&kvm_protected_mode_initialized);
+	on_each_cpu(_kvm_host_prot_finalize, &ret, 1);
+	return ret;
 }
 
 static int finalize_hyp_mode(void)
@@ -2002,15 +2018,7 @@ static int finalize_hyp_mode(void)
 	 * None of other sections should ever be introspected.
 	 */
 	kmemleak_free_part(__hyp_bss_start, __hyp_bss_end - __hyp_bss_start);
-
-	/*
-	 * Flip the static key upfront as that may no longer be possible
-	 * once the host stage 2 is installed.
-	 */
-	static_branch_enable(&kvm_protected_mode_initialized);
-	on_each_cpu(_kvm_host_prot_finalize, NULL, 1);
-
-	return 0;
+	return pkvm_drop_host_privileges();
 }
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
