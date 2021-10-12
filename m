Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41F429C7D
	for <lists+kvmarm@lfdr.de>; Tue, 12 Oct 2021 06:36:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF91E4B0B8;
	Tue, 12 Oct 2021 00:36:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eklZhQ5db3aN; Tue, 12 Oct 2021 00:36:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B46EA4B099;
	Tue, 12 Oct 2021 00:36:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 69D744048B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WUU7r1kYREQG for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Oct 2021 00:36:11 -0400 (EDT)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59D76402A9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:11 -0400 (EDT)
Received: by mail-qk1-f202.google.com with SMTP id
 c16-20020a05620a0cf000b0045f1d55407aso11356497qkj.22
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=MgUI8dr71wiUF9Cg1eutjpaNE80Sfg4+1lD1k7gsd/M=;
 b=VuhEW5SxS1LqbD1y6W2u5fujsSWvlKITcaC+DfzF+nbgthQHFlCdofRA8Pi8vjahVC
 zj5zQtHgIuUulE5UV8fh2IwmG0qfPMjxzv4Je1fkjXzNToQ1TIi+isd08BO+cHpf5mov
 GmjnInH4aCSFrGLvvSDPH1qi1c0JUrr9tj+w/BIlW7hXWPzqtAYmhtej7Tn4nhbt1g2L
 /0kQzyKo+7Q8e5Igsao58iALORgjb0FH2nN+mof+i0fYRMQZ6jHwDhydsKPpT3TPWrqi
 beLVi1ReaNB51oUSUxAxWkT0IUBzCucR/GAogYdticZGdaMWLM519PKt+Oh3nLkuZcym
 8cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=MgUI8dr71wiUF9Cg1eutjpaNE80Sfg4+1lD1k7gsd/M=;
 b=kxpMu/E9vNQrMEeswgg0YKYWrv8jtef5RFQJLxauzCqJyh4tubLDPRu7Z9VJIYthoN
 DRt6wKt/o14cMTEi+aLvKVAgTdi/vYzdsohr/qZBNafkSI8LGHi5woC/N7HWETlp0mYL
 QnCZtDbdiwWf7UDhqDPm5o8VlE+xh+EysvxVgQ5nJeJCH3FiYf73UOWIy88f5YTy2cHJ
 u/URKOMN21QfCWVQJjHeyc37mJV3KxMRQ8h6SCNqxZhcMk9M/zwpXGGbbfWZ3tCHR0X/
 /63dllE8RlL3oa8wZfxjOGy4CODQ8WrxWo9FvqR4+DkVLdEWxQrtGJSPB5/fTml2UF0l
 uFSw==
X-Gm-Message-State: AOAM531/IR21uDPiMhN28aNTSR46MEuR0OOr8aZpJp9OnvpOpiR1SVy5
 MbWILWZ4OckMPXQMt2pDAsM04EwLORY=
X-Google-Smtp-Source: ABdhPJy2iKOySRcH3Ml4eFC4AOnvEXGxnJDRyYb6ehxJKmextSbm1vjwq+zjkblu6svI8PlWaI/8labARB4=
X-Received: from reiji-vws.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:15a3])
 (user=reijiw job=sendgmr) by 2002:ac8:202:: with SMTP id
 k2mr20117332qtg.398.1634013370868; 
 Mon, 11 Oct 2021 21:36:10 -0700 (PDT)
Date: Mon, 11 Oct 2021 21:35:11 -0700
In-Reply-To: <20211012043535.500493-1-reijiw@google.com>
Message-Id: <20211012043535.500493-2-reijiw@google.com>
Mime-Version: 1.0
References: <20211012043535.500493-1-reijiw@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 01/25] KVM: arm64: Add has_reset_once flag for vcpu
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

Introduce 'has_reset_once' flag in kvm_vcpu_arch, which indicates
if the vCPU reset has been done once, for later use.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 ++
 arch/arm64/kvm/reset.c            | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f8be56d5342b..9b5e7a3b6011 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -384,6 +384,7 @@ struct kvm_vcpu_arch {
 		u64 last_steal;
 		gpa_t base;
 	} steal;
+	bool has_reset_once;
 };
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
@@ -449,6 +450,7 @@ struct kvm_vcpu_arch {
 
 #define vcpu_has_sve(vcpu) (system_supports_sve() &&			\
 			    ((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_SVE))
+#define	vcpu_has_reset_once(vcpu) ((vcpu)->arch.has_reset_once)
 
 #ifdef CONFIG_ARM64_PTR_AUTH
 #define vcpu_has_ptrauth(vcpu)						\
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ce36b0a3343..4d34e5c1586c 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -305,6 +305,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	if (loaded)
 		kvm_arch_vcpu_load(vcpu, smp_processor_id());
 	preempt_enable();
+
+	if (!ret && !vcpu->arch.has_reset_once)
+		vcpu->arch.has_reset_once = true;
+
 	return ret;
 }
 
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
