Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 984B13F0CA0
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 22:21:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4AAC14B0C7;
	Wed, 18 Aug 2021 16:21:47 -0400 (EDT)
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
	with ESMTP id ABHz38+e-D+X; Wed, 18 Aug 2021 16:21:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 75E3E4B0CC;
	Wed, 18 Aug 2021 16:21:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 321494A32E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 16:21:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R2Cz4OlNPzVk for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 16:21:37 -0400 (EDT)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2B5854A19B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 16:21:37 -0400 (EDT)
Received: by mail-qv1-f73.google.com with SMTP id
 u8-20020a0cec880000b029035825559ec4so2971319qvo.22
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=RsQw2+A6Y7v0C6V3YM0HBQbdtVAQ2NdDTbPPjc85eBM=;
 b=TUbYJCoU5mNFScZR1T6MWKR0qv9dR3+Cv2+4X3Nd2cRi6UXDkt3rmAzI5bXsjMFaJL
 m5vg09zXuY0c78nd4U+tpJCriXknDWGd4FvJS8NFNr98PaxCHdv+1kTEoNMslSqHD1QX
 JhwYhXysgKmydSBaQyFEC7qT3ySd7zOu4z5eOPGPqaS7VhNC0tkragx/ABg5fiKeCi80
 sQcXm5docwNzGfUGGprbBLbDQyodr0we9559CqUJzDqklmyPaN+L8UlJwUdvrPottnyX
 BmCka7tnuCU5RBTeksUAa+Nfz3dAQ+GP+JsWK9IL0FEkkIWK1TutAIlsADq48osIleFW
 ND+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=RsQw2+A6Y7v0C6V3YM0HBQbdtVAQ2NdDTbPPjc85eBM=;
 b=cHmjDE4FNLCZY6HejxJuH9cIRDNNDwEWVloVJbyGP+nwKRh0iu+eVTeWBDka9fxNQ7
 0pKKTGpjC5e5h4RKnbbJx3uKbUThikpmGwvEjakqhF0egu8ktsJai19UxAdi/ukarQh7
 vNA89hcLtr8x5YyJu4juNVaLaFVij6eLTNyJMm2jEwuRgsvHaifdIk2F96w7mreMJ7XF
 uA1nv+XtRgEvvqhnqaPrEzxYdLrAhAnx7PbzXVljW69TyImdZaPSwpdV9MuHCzbK09g4
 LS1o/bP/09P7MVE9tAmAFuRXuvF6DH2iUM9tvundPWxC7tV2Jy96EXU+WXX+psJl5UBg
 8PmA==
X-Gm-Message-State: AOAM530LaCTb3MfLbF0wLG/Agn3wnHN2pAiECZWQhpOIj5fkw2z1KBh5
 Yx59eZsIwary/mdTDMgePqn9xsBvR+E=
X-Google-Smtp-Source: ABdhPJz4xN3hybVA6/XryTpEYGPYLhn3XqACAJim9UMbamFc5G7dYZ5hZazqjOJDpZO5CPCkmrtHSgv7QNg=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a0c:be85:: with SMTP id
 n5mr10684618qvi.59.1629318096780; 
 Wed, 18 Aug 2021 13:21:36 -0700 (PDT)
Date: Wed, 18 Aug 2021 20:21:30 +0000
In-Reply-To: <20210818202133.1106786-1-oupton@google.com>
Message-Id: <20210818202133.1106786-2-oupton@google.com>
Mime-Version: 1.0
References: <20210818202133.1106786-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 1/4] KVM: arm64: Fix read-side race on updates to vcpu
 reset state
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Raghavendra Rao Anata <rananta@google.com>
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

KVM correctly serializes writes to a vCPU's reset state, however since
we do not take the KVM lock on the read side it is entirely possible to
read state from two different reset requests.

Cure the race for now by taking the KVM lock when reading the
reset_state structure.

Fixes: 358b28f09f0a ("arm/arm64: KVM: Allow a VCPU to fully reset itself")
Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/kvm/reset.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872d69a8..d862441b03b1 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -210,10 +210,16 @@ static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
  */
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_reset_state reset_state;
 	int ret;
 	bool loaded;
 	u32 pstate;
 
+	mutex_lock(&vcpu->kvm->lock);
+	reset_state = vcpu->arch.reset_state;
+	WRITE_ONCE(vcpu->arch.reset_state.reset, false);
+	mutex_unlock(&vcpu->kvm->lock);
+
 	/* Reset PMU outside of the non-preemptible section */
 	kvm_pmu_vcpu_reset(vcpu);
 
@@ -276,8 +282,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	 * Additional reset state handling that PSCI may have imposed on us.
 	 * Must be done after all the sys_reg reset.
 	 */
-	if (vcpu->arch.reset_state.reset) {
-		unsigned long target_pc = vcpu->arch.reset_state.pc;
+	if (reset_state.reset) {
+		unsigned long target_pc = reset_state.pc;
 
 		/* Gracefully handle Thumb2 entry point */
 		if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
@@ -286,13 +292,11 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		}
 
 		/* Propagate caller endianness */
-		if (vcpu->arch.reset_state.be)
+		if (reset_state.be)
 			kvm_vcpu_set_be(vcpu);
 
 		*vcpu_pc(vcpu) = target_pc;
-		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
-
-		vcpu->arch.reset_state.reset = false;
+		vcpu_set_reg(vcpu, 0, reset_state.r0);
 	}
 
 	/* Reset timer */
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
