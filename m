Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB7569034
	for <lists+kvmarm@lfdr.de>; Wed,  6 Jul 2022 19:05:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C9134BEAE;
	Wed,  6 Jul 2022 13:05:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxMdQEUf4+58; Wed,  6 Jul 2022 13:05:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 415A94BEAC;
	Wed,  6 Jul 2022 13:05:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C5194BE4E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jul 2022 13:05:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUcuSKHo+cgo for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Jul 2022 13:05:19 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D15EF4BC9D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jul 2022 13:05:18 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0FFB8B81DA3;
 Wed,  6 Jul 2022 17:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6824C3411C;
 Wed,  6 Jul 2022 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657127115;
 bh=zgRDna+JT0ihS8l+P7EzSsz4c34XT3kVcOWf0LX/Eeo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NI7Hefb8YGq5b0z46Lkj86OubKFbgqJ5jZd2SEMdcxMFBNkuxU75htUasnJ4fs9cK
 qsir9nsJNF3M7vy5HMUlYXyt9pE7kg7+RzERmGYAbMLt48JbWavvo9ncMbK/FVIsNB
 w00puHzjK5r3O8xsFmUaF3krpPOvsQ6aFqpU5OVz2rqeoh0EICKAelK1EBfWVVRSt3
 FSVIMkOhHJHgPGhsxubXXiLPDt0uvD+YQFpzlII/v384VCE0W8CEZxF9YlUK8SzTfx
 4Rs/3e9sxzhH41As3QfpO+UTqnzsSTP3TCsco2DZa9pcg6LSR0GtupIXNSyeumzigh
 +v9KgseeiYHpw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1o987O-005h9i-IM;
 Wed, 06 Jul 2022 17:43:14 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 18/19] KVM: arm64: Descope kvm_arm_sys_reg_{get,set}_reg()
Date: Wed,  6 Jul 2022 17:43:03 +0100
Message-Id: <20220706164304.1582687-19-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706164304.1582687-1-maz@kernel.org>
References: <20220706164304.1582687-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 schspa@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Schspa Shi <schspa@gmail.com>, kernel-team@android.com,
 Oliver Upton <oliver.upton@linux.dev>
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

Having kvm_arm_sys_reg_get_reg and co in kvm_host.h gives the
impression that these functions are free to be called from
anywhere.

Not quite. They really are tied to out internal sysreg handling,
and they would be better off in the sys_regs.h header, which is
private. kvm_host.h could also get a bit of a diet, so let's
just do that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 2 --
 arch/arm64/kvm/sys_regs.h         | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index de32152cea04..0c9c85981a8e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -620,8 +620,6 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 
 unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
-int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
-int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 
 int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 49517f58deb5..a8c4cc32eb9a 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -194,9 +194,10 @@ const struct sys_reg_desc *get_reg_by_id(u64 id,
 					 const struct sys_reg_desc table[],
 					 unsigned int num);
 
+int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
+int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 			 const struct sys_reg_desc table[], unsigned int num);
-
 int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 			 const struct sys_reg_desc table[], unsigned int num);
 
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
