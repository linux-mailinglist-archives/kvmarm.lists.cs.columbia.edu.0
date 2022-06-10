Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9B179546289
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jun 2022 11:35:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 31A3E4B400;
	Fri, 10 Jun 2022 05:35:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vft501Xc9jz7; Fri, 10 Jun 2022 05:35:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D5914B11F;
	Fri, 10 Jun 2022 05:35:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A78E4B3C8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jun 2022 05:35:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MIHPsfkbijxo for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jun 2022 05:35:40 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7B96C4B3BC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jun 2022 05:35:38 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F18E161E8F;
 Fri, 10 Jun 2022 09:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60996C34114;
 Fri, 10 Jun 2022 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654853737;
 bh=UWqmfJ/Rf0ncHATIJtPlqt9EtH/WUDpFfEL5zZJ0POM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nDQU8ZH4C54TrEq7hrjSR33rA1R6JJVn5oeeYRt4rc5fGzv4jwDzpDkyDFrAEUwiA
 kDwHpewK1tOckCRSgfNb208QtawUXE3GzFWfBNfkqVbapnkL4hq2zgPE8sp0pAfpYG
 Dom2KrWpuL60qAS9Qo4ulflLWRB97X2uWOUdruDeMtXwnkqf3jWk5nPmbcRlT/FUwc
 cS8D26f4iZjJeWs3GBZQkKYVa03JIVrWT59kujn0Yw4dQKt53Ok82X5ivoQdtAT3TV
 0LTABEvXuq/YERyhmVnlgRNl+WVsFkr5+b6EBr0y7JYVj0JVmWqlrzQWGgFiSY7WNh
 y0p3fRz8uUMXw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nzawr-00H6Dt-Ex; Fri, 10 Jun 2022 10:28:57 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 15/19] KVM: arm64: Warn when PENDING_EXCEPTION and
 INCREMENT_PC are set together
Date: Fri, 10 Jun 2022 10:28:34 +0100
Message-Id: <20220610092838.1205755-16-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220610092838.1205755-1-maz@kernel.org>
References: <20220610092838.1205755-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 will@kernel.org, tabba@google.com, qperret@google.com, broonie@kernel.org,
 reijiw@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

We really don't want PENDING_EXCEPTION and INCREMENT_PC to ever be
set at the same time, as they are mutually exclusive. Add checks
that will generate a warning should this ever happen.

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 6ec58080ece8..9bdba47f7e14 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -473,11 +473,13 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 
 static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 {
+	WARN_ON(vcpu_get_flag(vcpu, PENDING_EXCEPTION));
 	vcpu_set_flag(vcpu, INCREMENT_PC);
 }
 
 #define kvm_pend_exception(v, e)					\
 	do {								\
+		WARN_ON(vcpu_get_flag((v), INCREMENT_PC));		\
 		vcpu_set_flag((v), PENDING_EXCEPTION);			\
 		vcpu_set_flag((v), e);					\
 	} while (0)
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
