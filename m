Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C566C2AD7B2
	for <lists+kvmarm@lfdr.de>; Tue, 10 Nov 2020 14:36:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 790FB4B9AC;
	Tue, 10 Nov 2020 08:36:43 -0500 (EST)
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
	with ESMTP id QGri+7yn4DEn; Tue, 10 Nov 2020 08:36:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 881924B9F1;
	Tue, 10 Nov 2020 08:36:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 446674B98A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 08:36:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g6W2Lic7Emtd for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Nov 2020 08:36:35 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D014E4B99F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 08:36:33 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C94FB20867;
 Tue, 10 Nov 2020 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605015392;
 bh=eLjJK1buVxDAyag6pR/7LJkBKLx1jTibzLVMjABw4/w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ilrAfHlYmiJd6UNVlIB2dAZKJsCOjnNosLaznePEZ1Yi2mOXfBpQ/NqAb9pmuQQCw
 g29gEV4bEJ7IABjw9cXcfZRjxpWs8L5bbioiNillz28aIE6qqj57Ye7wyOLe0+0P/3
 ERnvkqGEJCHB4xZU818XHi7h59WpCrIj/HRdrZso=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kcTp1-009SZy-2V; Tue, 10 Nov 2020 13:36:31 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/9] KVM: arm64: Drop is_32bit trap attribute
Date: Tue, 10 Nov 2020 13:36:16 +0000
Message-Id: <20201110133619.451157-7-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110133619.451157-1-maz@kernel.org>
References: <20201110133619.451157-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

The is_32bit attribute is now completely unused, drop it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c        | 3 ---
 arch/arm64/kvm/sys_regs.h        | 1 -
 arch/arm64/kvm/vgic-sys-reg-v3.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 660ff6c18b2e..a4726cdbe16f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2176,7 +2176,6 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 	int Rt2 = (esr >> 10) & 0x1f;
 
 	params.is_aarch32 = true;
-	params.is_32bit = false;
 	params.CRm = (esr >> 1) & 0xf;
 	params.is_write = ((esr & 1) == 0);
 
@@ -2227,7 +2226,6 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
 	int Rt  = kvm_vcpu_sys_get_rt(vcpu);
 
 	params.is_aarch32 = true;
-	params.is_32bit = true;
 	params.CRm = (esr >> 1) & 0xf;
 	params.regval = vcpu_get_reg(vcpu, Rt);
 	params.is_write = ((esr & 1) == 0);
@@ -2322,7 +2320,6 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
 	trace_kvm_handle_sys_reg(esr);
 
 	params.is_aarch32 = false;
-	params.is_32bit = false;
 	params.Op0 = (esr >> 20) & 3;
 	params.Op1 = (esr >> 14) & 0x7;
 	params.CRn = (esr >> 10) & 0xf;
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 259864c3c76b..8c4958d6b5ce 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -20,7 +20,6 @@ struct sys_reg_params {
 	u64	regval;
 	bool	is_write;
 	bool	is_aarch32;
-	bool	is_32bit;	/* Only valid if is_aarch32 is true */
 };
 
 struct sys_reg_desc {
diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index 2f92bdcb1188..806d6701a7da 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -269,7 +269,6 @@ int vgic_v3_has_cpu_sysregs_attr(struct kvm_vcpu *vcpu, bool is_write, u64 id,
 	params.regval = *reg;
 	params.is_write = is_write;
 	params.is_aarch32 = false;
-	params.is_32bit = false;
 
 	if (find_reg_by_id(sysreg, &params, gic_v3_icc_reg_descs,
 			      ARRAY_SIZE(gic_v3_icc_reg_descs)))
@@ -289,7 +288,6 @@ int vgic_v3_cpu_sysregs_uaccess(struct kvm_vcpu *vcpu, bool is_write, u64 id,
 		params.regval = *reg;
 	params.is_write = is_write;
 	params.is_aarch32 = false;
-	params.is_32bit = false;
 
 	r = find_reg_by_id(sysreg, &params, gic_v3_icc_reg_descs,
 			   ARRAY_SIZE(gic_v3_icc_reg_descs));
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
