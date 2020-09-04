Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A925D6B7
	for <lists+kvmarm@lfdr.de>; Fri,  4 Sep 2020 12:46:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 91BC84B377;
	Fri,  4 Sep 2020 06:46:10 -0400 (EDT)
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
	with ESMTP id YOBmSUc8gzsv; Fri,  4 Sep 2020 06:46:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF4CB4B30C;
	Fri,  4 Sep 2020 06:46:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A1D74B32D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Sep 2020 06:46:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1j8D2Z1js2Jz for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Sep 2020 06:46:04 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1405C4B284
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Sep 2020 06:46:04 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43221208C7;
 Fri,  4 Sep 2020 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599216363;
 bh=r1nUMqPwXmhAO7LeAjn9TKtUZUP8P8LrWl0p6iXFp+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IeMvMk1HhiB05xCF2ZOYGM7OWAMEMfnO6ngLrDDYzUJTdyE1juRd6yMW8xMe4YEKx
 xeF4x10p6YHPJKUGnV3IaAyACxAtuzJbXcJ1acctP6laJohwrcA4hPu0gqyZu9DzzC
 HSROr4xYc7gyEobeVR02rdrl2IGTYsELZjd75lqg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kE9EH-0098oH-O1; Fri, 04 Sep 2020 11:46:01 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/9] KVM: arm64: Drop type input from kvm_put_guest
Date: Fri,  4 Sep 2020 11:45:24 +0100
Message-Id: <20200904104530.1082676-4-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200904104530.1082676-1-maz@kernel.org>
References: <20200904104530.1082676-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 drjones@redhat.com, eric.auger@redhat.com, gshan@redhat.com,
 steven.price@arm.com, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

We can use typeof() to avoid the need for the type input.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200804170604.42662-4-drjones@redhat.com
---
 arch/arm64/kvm/pvtime.c  |  2 +-
 include/linux/kvm_host.h | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index 95f9580275b1..241ded7ee0ad 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -32,7 +32,7 @@ void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	steal_le = cpu_to_le64(steal);
 	idx = srcu_read_lock(&kvm->srcu);
 	offset = offsetof(struct pvclock_vcpu_stolen_time, stolen_time);
-	kvm_put_guest(kvm, base + offset, steal_le, u64);
+	kvm_put_guest(kvm, base + offset, steal_le);
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a23076765b4c..84371fb06209 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -749,25 +749,26 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 
-#define __kvm_put_guest(kvm, gfn, offset, value, type)			\
+#define __kvm_put_guest(kvm, gfn, offset, v)				\
 ({									\
 	unsigned long __addr = gfn_to_hva(kvm, gfn);			\
-	type __user *__uaddr = (type __user *)(__addr + offset);	\
+	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
 	if (!kvm_is_error_hva(__addr))					\
-		__ret = put_user(value, __uaddr);			\
+		__ret = put_user(v, __uaddr);				\
 	if (!__ret)							\
 		mark_page_dirty(kvm, gfn);				\
 	__ret;								\
 })
 
-#define kvm_put_guest(kvm, gpa, value, type)				\
+#define kvm_put_guest(kvm, gpa, v)					\
 ({									\
 	gpa_t __gpa = gpa;						\
 	struct kvm *__kvm = kvm;					\
+									\
 	__kvm_put_guest(__kvm, __gpa >> PAGE_SHIFT,			\
-			offset_in_page(__gpa), (value), type);		\
+			offset_in_page(__gpa), v);			\
 })
 
 int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len);
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
