Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D35292A334F
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 19:50:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 878794B56F;
	Mon,  2 Nov 2020 13:50:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZO1un5kJNai; Mon,  2 Nov 2020 13:50:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B8354B552;
	Mon,  2 Nov 2020 13:50:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 286334B569
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 13:50:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BV9kll8ifden for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 13:50:50 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F4D54B53D
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 13:50:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604343049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewICqjJ+g7NR/9mXydm+rzs6vd70AnmoX0KY0J5pfzo=;
 b=Ffo1dVfyL7RcPY5skGzRGebZZo05r+lyfwd7I4FGTgej3jSMz2W8Oh/M0g760CygKHo3VE
 kZPlkVVWXGzDFPMc05J0a8g/Aee2Ngl3U9z89bgpysiTwhNHEzkHWPu476wjPmuFQFOdoC
 cgY/P8vbnE0JU8JEC8znHKiNREkJ/pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-FD9NovLcMTa6BbjDzKmacQ-1; Mon, 02 Nov 2020 13:50:47 -0500
X-MC-Unique: FD9NovLcMTa6BbjDzKmacQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B3A5879512;
 Mon,  2 Nov 2020 18:50:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04E9E5C22A;
 Mon,  2 Nov 2020 18:50:44 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 3/3] KVM: arm64: Remove AA64ZFR0_EL1 accessors
Date: Mon,  2 Nov 2020 19:50:37 +0100
Message-Id: <20201102185037.49248-4-drjones@redhat.com>
In-Reply-To: <20201102185037.49248-1-drjones@redhat.com>
References: <20201102185037.49248-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: maz@kernel.org, xu910121@sina.com, Dave.Martin@arm.com
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

The AA64ZFR0_EL1 accessors are just the general accessors with
its visibility function open-coded. It also skips the if-else
chain in read_id_reg, but there's no reason not to go there.
Indeed consolidating ID register accessors and removing lines
of code make it worthwhile.

No functional change intended.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 61 +++++++--------------------------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b8822a20b1ea..e2d6fb83280e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1156,6 +1156,16 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
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
 
@@ -1203,55 +1213,6 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
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
@@ -1515,7 +1476,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_SANITISED(ID_AA64PFR1_EL1),
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
-	{ SYS_DESC(SYS_ID_AA64ZFR0_EL1), access_id_aa64zfr0_el1, .get_user = get_id_aa64zfr0_el1, .set_user = set_id_aa64zfr0_el1, },
+	ID_SANITISED(ID_AA64ZFR0_EL1),
 	ID_UNALLOCATED(4,5),
 	ID_UNALLOCATED(4,6),
 	ID_UNALLOCATED(4,7),
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
