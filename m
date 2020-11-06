Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB32A99BA
	for <lists+kvmarm@lfdr.de>; Fri,  6 Nov 2020 17:44:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27D544B8B5;
	Fri,  6 Nov 2020 11:44:48 -0500 (EST)
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
	with ESMTP id DyXvKUlSKEO0; Fri,  6 Nov 2020 11:44:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C32C44B8B3;
	Fri,  6 Nov 2020 11:44:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 28C1D4B8B7
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Nov 2020 11:44:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZhMS5YT7SmC7 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Nov 2020 11:44:42 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 56F064B8B2
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Nov 2020 11:44:41 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 69B3422203;
 Fri,  6 Nov 2020 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604681080;
 bh=MxmBxdTqSNyaIiaHEHjj6oQDH7cYA7bcMmR2qQ3oQdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ewv8wIbAVqIuoWReAh75l3bjiOcV6UNdCFAccmIHFHgv5spKhsh6Jcs0lmb+P0NSO
 aEi4QknKa+RDAqOQauzR2ZomXT4mO6502isrGgtR1MpKL0l9n+dxbc2qxK+lG4lV70
 zyJ8yMWCa9fqwOxOkVSW6VMImlQ2re/JDPHGIkP8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kb4qs-008FYW-Io; Fri, 06 Nov 2020 16:44:38 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/5] KVM: arm64: Remove AA64ZFR0_EL1 accessors
Date: Fri,  6 Nov 2020 16:44:16 +0000
Message-Id: <20201106164416.326787-6-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106164416.326787-1-maz@kernel.org>
References: <20201106164416.326787-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, drjones@redhat.com,
 eric.auger@redhat.com, gshan@redhat.com, xu910121@sina.com,
 dave.martin@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 =?UTF-8?q?=E5=BC=A0=E4=B8=9C=E6=97=AD?= <xu910121@sina.com>,
 linux-arm-kernel@lists.infradead.org, dave.martin@arm.com
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

From: Andrew Jones <drjones@redhat.com>

The AA64ZFR0_EL1 accessors are just the general accessors with
its visibility function open-coded. It also skips the if-else
chain in read_id_reg, but there's no reason not to go there.
Indeed consolidating ID register accessors and removing lines
of code make it worthwhile.

Remove the AA64ZFR0_EL1 accessors, replacing them with the
general accessors for sanitized ID registers.

No functional change intended.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201105091022.15373-5-drjones@redhat.com
---
 arch/arm64/kvm/sys_regs.c | 61 +++++++--------------------------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4ee098abd87c..436043cd327e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1154,6 +1154,16 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
 				  const struct sys_reg_desc *r)
 {
+	u32 id = sys_reg((u32)r->Op0, (u32)r->Op1,
+			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
+
+	switch (id) {
+	case SYS_ID_AA64ZFR0_EL1:
+		if (!vcpu_has_sve(vcpu))
+			return REG_RAZ;
+		break;
+	}
+
 	return 0;
 }
 
@@ -1201,55 +1211,6 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
-/* Generate the emulated ID_AA64ZFR0_EL1 value exposed to the guest */
-static u64 guest_id_aa64zfr0_el1(const struct kvm_vcpu *vcpu)
-{
-	if (!vcpu_has_sve(vcpu))
-		return 0;
-
-	return read_sanitised_ftr_reg(SYS_ID_AA64ZFR0_EL1);
-}
-
-static bool access_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
-				   struct sys_reg_params *p,
-				   const struct sys_reg_desc *rd)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p, rd);
-
-	p->regval = guest_id_aa64zfr0_el1(vcpu);
-	return true;
-}
-
-static int get_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
-		const struct sys_reg_desc *rd,
-		const struct kvm_one_reg *reg, void __user *uaddr)
-{
-	u64 val;
-
-	val = guest_id_aa64zfr0_el1(vcpu);
-	return reg_to_user(uaddr, &val, reg->id);
-}
-
-static int set_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
-		const struct sys_reg_desc *rd,
-		const struct kvm_one_reg *reg, void __user *uaddr)
-{
-	const u64 id = sys_reg_to_index(rd);
-	int err;
-	u64 val;
-
-	err = reg_from_user(&val, uaddr, id);
-	if (err)
-		return err;
-
-	/* This is what we mean by invariant: you can't change it. */
-	if (val != guest_id_aa64zfr0_el1(vcpu))
-		return -EINVAL;
-
-	return 0;
-}
-
 /*
  * cpufeature ID register user accessors
  *
@@ -1506,7 +1467,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_SANITISED(ID_AA64PFR1_EL1),
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
-	{ SYS_DESC(SYS_ID_AA64ZFR0_EL1), access_id_aa64zfr0_el1, .get_user = get_id_aa64zfr0_el1, .set_user = set_id_aa64zfr0_el1, },
+	ID_SANITISED(ID_AA64ZFR0_EL1),
 	ID_UNALLOCATED(4,5),
 	ID_UNALLOCATED(4,6),
 	ID_UNALLOCATED(4,7),
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
