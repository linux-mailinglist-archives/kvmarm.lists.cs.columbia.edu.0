Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D07D0442AA4
	for <lists+kvmarm@lfdr.de>; Tue,  2 Nov 2021 10:47:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FE0A4B154;
	Tue,  2 Nov 2021 05:47:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYQW2B8UFBnJ; Tue,  2 Nov 2021 05:47:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7067F4B176;
	Tue,  2 Nov 2021 05:47:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E1DF4B177
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Nov 2021 05:47:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x3-MdLI4sWZJ for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Nov 2021 05:47:02 -0400 (EDT)
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 46F844B15B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Nov 2021 05:47:02 -0400 (EDT)
Received: by mail-io1-f74.google.com with SMTP id
 k5-20020a0566022a4500b005e1c84e667dso986328iov.16
 for <kvmarm@lists.cs.columbia.edu>; Tue, 02 Nov 2021 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=DbmokXu45N05i00rjRKFS9Aukc67vZn4OjwqX1uC/YU=;
 b=EdDi9FOXMCGHRhU016qAQn/ZmuBFvVQyBV401phw9A0mM29D7FCBkKrqoRN+ddaDKu
 WMNSZyuCDNWevO/SP5n9ML9GzsOq3KJVi026ObUqHeQqAO6uvqeRwYkUUMyOGQWHiYA2
 tnvJWSLvjtmZY8JFr6NQakWEW4/5U9vJZL8Lqm47kV26cjyA2ANUqH8OMBybG6CG908N
 x0okPVWvlaqCs8jLleOKU+LoC7nP19scolOl5HFZ8y+ukdy5eVk5p2toXh3eLSrG2BBJ
 +fwB5JpZB8U6m0jYd/lt9RgHDohbN545YLjTCvSuLn+ccimIQxFvgF0GnE25PMzP3z+b
 oMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DbmokXu45N05i00rjRKFS9Aukc67vZn4OjwqX1uC/YU=;
 b=Jq04evVoi7hGUYO0iVhdyicGZ/lAciwz+0EezdXCvxCeKJJaetkfR4d0wm5D54Fp6y
 3qP/BPdkgt/zeK64Jx4PX+AQ8KKKDlarhBSwLO2+s6llmAcl7aeSgkb2HYD+4ZMOW5nA
 WxEnJtMY2FbjQw+P1It9buhatOzrjVrm+WtmCokbz4IkH02wdIOEIaiTCdx2aJiYvSow
 RkXaBFV6T4+KRwPmcISX9okqt8ZlkuCydyAmN1iGdJ6h3+uVuEpHuERigzQhOAulc/H6
 ts/TRqy9idW3Fcp3E4JjYDRBC/X0YCzZvKpbyD4eLJOXkGtIFJSJxdHoPFKWkLmW0o/b
 tnPA==
X-Gm-Message-State: AOAM530U5jiISJUDi/LoY9CihZCcSvcXwAjiM+1LI1tEA9x/bg/De/VQ
 4CPZroCN8UHaz80ySo1Kwq3hUy+T/xL0tRgrel0apt7fZo5++eGHKxWS8BsvmKptK/Jr4u9gHtv
 rNezP48nalAygwE0Rh61blzMcaybHSav8PEqIOpC/+a32wyD1OPvNliZKJbF1oJimyFSejA==
X-Google-Smtp-Source: ABdhPJyDtijBd6vvihLRehY/zlMTHVriiJWyurunjgvekkIvbB0W9BlpBBhTD9Sttnoy8lUPFahbqXpiX6c=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a02:a884:: with SMTP id
 l4mr26257855jam.44.1635846421777; 
 Tue, 02 Nov 2021 02:47:01 -0700 (PDT)
Date: Tue,  2 Nov 2021 09:46:47 +0000
In-Reply-To: <20211102094651.2071532-1-oupton@google.com>
Message-Id: <20211102094651.2071532-3-oupton@google.com>
Mime-Version: 1.0
References: <20211102094651.2071532-1-oupton@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 2/6] KVM: arm64: Stash OSLSR_EL1 in the cpu context
From: Oliver Upton <oupton@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, linux-arm-kernel@lists.infradead.org
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

An upcoming change to KVM will context switch the OS Lock status between
guest/host. Add OSLSR_EL1 to the cpu context and handle guest reads
using the stored value.

Wire up a custom handler for writes from userspace and prevent any of
the invariant bits from changing.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/sys_regs.c         | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f8be56d5342b..c98f65c4a1f7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -172,6 +172,7 @@ enum vcpu_sysreg {
 	MDSCR_EL1,	/* Monitor Debug System Control Register */
 	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
 	DISR_EL1,	/* Deferred Interrupt Status Register */
+	OSLSR_EL1,	/* OS Lock Status Register */
 
 	/* Performance Monitors Registers */
 	PMCR_EL0,	/* Control Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 17fa6ddf5405..0326b3df0736 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -291,12 +291,28 @@ static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {
-	if (p->is_write) {
+	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
-	} else {
-		p->regval = (1 << 3);
-		return true;
-	}
+
+	p->regval = __vcpu_sys_reg(vcpu, r->reg);
+	return true;
+}
+
+static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			 const struct kvm_one_reg *reg, void __user *uaddr)
+{
+	u64 id = sys_reg_to_index(rd);
+	u64 val;
+	int err;
+
+	err = reg_from_user(&val, uaddr, id);
+	if (err)
+		return err;
+
+	if (val != rd->val)
+		return -EINVAL;
+
+	return 0;
 }
 
 static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
@@ -1441,7 +1457,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_OSLAR_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1 },
+	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_val, OSLSR_EL1, 0x00000008,
+		.set_user = set_oslsr_el1, },
 	{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
@@ -1916,7 +1933,7 @@ static const struct sys_reg_desc cp14_regs[] = {
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 4), trap_raz_wi },
 	DBGBXVR(1),
 	/* DBGOSLSR */
-	{ Op1( 0), CRn( 1), CRm( 1), Op2( 4), trap_oslsr_el1 },
+	{ Op1( 0), CRn( 1), CRm( 1), Op2( 4), trap_oslsr_el1, NULL, OSLSR_EL1 },
 	DBGBXVR(2),
 	DBGBXVR(3),
 	/* DBGOSDLR */
-- 
2.33.1.1089.g2158813163f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
