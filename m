Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A93C319B42D
	for <lists+kvmarm@lfdr.de>; Wed,  1 Apr 2020 18:58:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 254844B0FC;
	Wed,  1 Apr 2020 12:58:37 -0400 (EDT)
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
	with ESMTP id Ge1M-lZkUM58; Wed,  1 Apr 2020 12:58:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DB8634B101;
	Wed,  1 Apr 2020 12:58:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E2CE94B0F3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 12:58:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-5a+1Xad+J4 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Apr 2020 12:58:32 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BE9384B0F5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 12:58:32 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFDF820719;
 Wed,  1 Apr 2020 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585760312;
 bh=1VnEWEuVBOL5E3YcqQhiydYDdUG2n1hdJCQbR18YrBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lLTl6mXIqSe+j3KVbVAutMBaFeah0MsW0rLw/cBSMe39O/7YRSCmUz0j0ZS+IkkQt
 JiJECtLGFwwxJG5ZPSKd5jUtW+vnsiIg0/2uhPRpiZj0mOAgS6OqI0McZizHIjiARN
 t6ys/6rpJCKoJUnh1xo3J72aq6zf28LFbDzoC+jk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jJghC-00Haev-6L; Wed, 01 Apr 2020 17:58:30 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 2/2] KVM: arm64: PSCI: Forbid 64bit functions for 32bit guests
Date: Wed,  1 Apr 2020 17:58:16 +0100
Message-Id: <20200401165816.530281-3-maz@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200401165816.530281-1-maz@kernel.org>
References: <20200401165816.530281-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Christoffer.Dall@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

Implementing (and even advertising) 64bit PSCI functions to 32bit
guests is at least a bit odd, if not altogether violating the
spec which says ("5.2.1 Register usage in arguments and return values"):

"Adherence to the SMC Calling Conventions implies that any AArch32
caller of an SMC64 function will get a return code of 0xFFFFFFFF(int32).
This matches the NOT_SUPPORTED error code used in PSCI"

Tighten the implementation by pretending these functions are not
there for 32bit guests.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/psci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index 69ff4a51ceb5..122795cdd984 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -199,6 +199,21 @@ static void kvm_psci_narrow_to_32bit(struct kvm_vcpu *vcpu)
 		vcpu_set_reg(vcpu, i, (u32)vcpu_get_reg(vcpu, i));
 }
 
+static unsigned long kvm_psci_check_allowed_function(struct kvm_vcpu *vcpu, u32 fn)
+{
+	switch(fn) {
+	case PSCI_0_2_FN64_CPU_SUSPEND:
+	case PSCI_0_2_FN64_CPU_ON:
+	case PSCI_0_2_FN64_AFFINITY_INFO:
+		/* Disallow these functions for 32bit guests */
+		if (vcpu_mode_is_32bit(vcpu))
+			return PSCI_RET_NOT_SUPPORTED;
+		break;
+	}
+
+	return 0;
+}
+
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -206,6 +221,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 	unsigned long val;
 	int ret = 1;
 
+	val = kvm_psci_check_allowed_function(vcpu, psci_fn);
+	if (val)
+		goto out;
+
 	switch (psci_fn) {
 	case PSCI_0_2_FN_PSCI_VERSION:
 		/*
@@ -273,6 +292,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		break;
 	}
 
+out:
 	smccc_set_retval(vcpu, val, 0, 0, 0);
 	return ret;
 }
@@ -290,6 +310,10 @@ static int kvm_psci_1_0_call(struct kvm_vcpu *vcpu)
 		break;
 	case PSCI_1_0_FN_PSCI_FEATURES:
 		feature = smccc_get_arg1(vcpu);
+		val = kvm_psci_check_allowed_function(vcpu, feature);
+		if (val)
+			break;
+
 		switch(feature) {
 		case PSCI_0_2_FN_PSCI_VERSION:
 		case PSCI_0_2_FN_CPU_SUSPEND:
-- 
2.25.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
