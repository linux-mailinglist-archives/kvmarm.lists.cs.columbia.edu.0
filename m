Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A84C0AE2
	for <lists+kvmarm@lfdr.de>; Wed, 23 Feb 2022 05:19:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D7CE84C371;
	Tue, 22 Feb 2022 23:19:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNHCz2uhK2z5; Tue, 22 Feb 2022 23:19:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 90F214C3D6;
	Tue, 22 Feb 2022 23:19:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 791204C36A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 23:19:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0Ixz6kh2ePK for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 23:19:06 -0500 (EST)
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com
 [209.85.166.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C4324C3D6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 23:19:04 -0500 (EST)
Received: by mail-io1-f73.google.com with SMTP id
 k10-20020a5d91ca000000b006414a00b160so4007644ior.18
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 20:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=hgAQAdRcLSzomebV7T5zWpSf8Sqv0crdtVr6zMUFKdo=;
 b=kLwPfeDgRiC06/LMgqmn21pwYTrxD8wWyQPGPXcy9D5sejy59RpWLZLIQfhAB+7zbc
 UY8NGRAIA/uzhchPlRZh02gB57nAAh+rHFQ/fKY8iCPv11qjGweXN7axa5k0LChl838B
 75ogCb4VXicj9FhFFZ1Yj+9NhwvxVqHXXotu2QrkDDsmktMKg5iAkGgKBksVa2CwESXI
 zIYzPofAe8tu+R+Ku5SZaCoqWoGZtlDJUgJpwH1cUKKMKUTh2JBs0D3DMLG0s6Y2v9gu
 BNgkm7kVQI3AicbTSQlDah8CFngEj49pKQFj0cYsXbMu6gUt2u9IY6KgORJo+1rdQi7m
 OkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=hgAQAdRcLSzomebV7T5zWpSf8Sqv0crdtVr6zMUFKdo=;
 b=h3RRN1DzKt7xCFjnRpS+fqtCFCqHYqxLd7OS96q0JPqiz2uEhoA8WpJore85LySpeF
 noWcRxXZwNBMo8bKfymY4urbuwmJUpZN/bBkDHzKSul8LjjqqBCQwN4SxflIfMllcnxx
 O4Jm5zUB2zREgA/fWXOxEpTaqoY1q9EkoP5y1NyLFptWcEdugHa464znob5uVHpxqV3A
 DgJMqArDSSSccm/XVceHAwb3Q2VVtlzPxObKvKU9u4+mL9cMF4NhCBpQcbf4s+aimad8
 2+U5tczunfTX9UvX+ie3ATOsU5vDkp2zYvg6g+RvP9mhYWGF4BxCiWBUuhoClg2uXz3u
 Y0pQ==
X-Gm-Message-State: AOAM531tAgBbNbC+FGmmerEObSy3MpikOWEpWHyn60oqdlBFSMSEJvIA
 j1FC3ew8eTrsYGMolnvNnA3OqbkqyAdts/8rvi7KaCY8co7ja8Xe8YqzRbosMe0LBRQaxx3HfZ1
 2XMjmqQfbo6r5+mCFABiFrr3hRn1Sq7wtDUIe8pIWPSHoTtwJqRoGFNSFGxhfXesnBtfziA==
X-Google-Smtp-Source: ABdhPJzesx/F3VdiTU8q8DAYdFAI9MvGQ2hrEzXrG+QY121eCCuyEw1mDHNKhI3wKWR0nN2+nmdX/YoCJRw=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6638:378c:b0:313:f08c:e4df
 with SMTP id
 w12-20020a056638378c00b00313f08ce4dfmr21162221jal.192.1645589943753; Tue, 22
 Feb 2022 20:19:03 -0800 (PST)
Date: Wed, 23 Feb 2022 04:18:26 +0000
In-Reply-To: <20220223041844.3984439-1-oupton@google.com>
Message-Id: <20220223041844.3984439-2-oupton@google.com>
Mime-Version: 1.0
References: <20220223041844.3984439-1-oupton@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 01/19] KVM: arm64: Drop unused param from kvm_psci_version()
From: Oliver Upton <oupton@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Atish Patra <atishp@atishpatra.org>,
 Peter Shier <pshier@google.com>, kvm-riscv@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>
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

kvm_psci_version() consumes a pointer to struct kvm in addition to a
vcpu pointer. Drop the kvm pointer as it is unused. While the comment
suggests the explicit kvm pointer was useful for calling from hyp, there
exist no such callsite in hyp.

Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220208012705.640444-1-oupton@google.com
---
 arch/arm64/kvm/psci.c  | 6 +++---
 include/kvm/arm_psci.h | 6 +-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 3eae32876897..a0c10c11f40e 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -85,7 +85,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	if (!vcpu)
 		return PSCI_RET_INVALID_PARAMS;
 	if (!vcpu->arch.power_off) {
-		if (kvm_psci_version(source_vcpu, kvm) != KVM_ARM_PSCI_0_1)
+		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
 			return PSCI_RET_ALREADY_ON;
 		else
 			return PSCI_RET_INVALID_PARAMS;
@@ -392,7 +392,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
  */
 int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
-	switch (kvm_psci_version(vcpu, vcpu->kvm)) {
+	switch (kvm_psci_version(vcpu)) {
 	case KVM_ARM_PSCI_1_0:
 		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
@@ -471,7 +471,7 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 	switch (reg->id) {
 	case KVM_REG_ARM_PSCI_VERSION:
-		val = kvm_psci_version(vcpu, vcpu->kvm);
+		val = kvm_psci_version(vcpu);
 		break;
 	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
 	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 5b58bd2fe088..297645edcaff 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -16,11 +16,7 @@
 
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
-/*
- * We need the KVM pointer independently from the vcpu as we can call
- * this from HYP, and need to apply kern_hyp_va on it...
- */
-static inline int kvm_psci_version(struct kvm_vcpu *vcpu, struct kvm *kvm)
+static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * Our PSCI implementation stays the same across versions from
-- 
2.35.1.473.g83b2b277ed-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
