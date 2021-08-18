Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C03EFF97
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 10:51:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF9AC4B0D9;
	Wed, 18 Aug 2021 04:51:16 -0400 (EDT)
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
	with ESMTP id xu2scH2soabY; Wed, 18 Aug 2021 04:51:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 71F674B0CC;
	Wed, 18 Aug 2021 04:51:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE2F04B0E3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 04:51:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Bp4umQDC4rF for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 04:51:02 -0400 (EDT)
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com
 [209.85.166.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D8D684B0B4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 04:50:59 -0400 (EDT)
Received: by mail-il1-f202.google.com with SMTP id
 j14-20020a92c20e000000b00224641b3943so814270ilo.23
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=RzZprkEWFZ008a+bVSl7uQhCMtaydrmCD3SE9hzh+pU=;
 b=IvF/U5wPABq15FuyOcb0sbg1Hh2z0d5YLQIesZb8QDgekFfl6QTp2Rw/afAlIX9Z+6
 thKo2xaK2mWb7n4J3JAa8yCvMozOoixoWC10FyCSeSR5LZ/dAj5tgusvmZcQ8taRGUQN
 jW/AznJkcihfMUs4yd68+7ypyAySESNYd1iEKFtTkDGi/kGN3tgMdLY5GJR9LRsSYPcw
 rNu2gwHGzkdQhZShUhXfG5Q1mTHuOdOhCVD1yAId/kCmfqgVmapSPIORlrl8WCT5QbLD
 ZDAF2GEcPTEgRF4srRbekJZGaOFdr4Z+e9oqNsmtNHiV/ckI0JbEAlYEN5+RP0YcqAo4
 jWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=RzZprkEWFZ008a+bVSl7uQhCMtaydrmCD3SE9hzh+pU=;
 b=lqUju2pz2VzLZvp4r1nnYWVgh4H5vI7AUAqv+QpkzteNWVNhaQwUuqvnrt9uedZ+wV
 5UYhtUj4EDDhAVZAl6iEJDaGyS2FBser1Knq9p4e03Skd7LIVp4/7N6HwZ3yEeqWAu8s
 h5jO//SI9jQ0CMPsHtv0hMKLXS086dDf6iiYWuOtogr8gIOshFADYcTLdmNlE9tx2mo1
 NpiiZDT7Ky9qacOg6IjDp1920C8czvYSiqNpyc9ztFiqpOR1czsIDlUkCM3MQzAu38N/
 X9TQkCEO5hWZXtNp4kC3SWyp+KDFxqx9EZBfJw4LmYOfRy+w0avjUdCEpI2EvDK5Q0uK
 TaDg==
X-Gm-Message-State: AOAM533dHHwtkcTbvn+LW6i3lCIBE/gnzKqEGWLhWWreEJmWJp5NfXyW
 DMVlwYlxcHpbik6pNJwmKihHPxcAM9s=
X-Google-Smtp-Source: ABdhPJx15vycUuHJYydv3hMTk18jP78ZvSV61NkZ7tsJQUfLnkQHgNR6oAiadaFWKzz+sQBwMvhGLwMTc0U=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a6b:e712:: with SMTP id
 b18mr6273736ioh.186.1629276659300; 
 Wed, 18 Aug 2021 01:50:59 -0700 (PDT)
Date: Wed, 18 Aug 2021 08:50:46 +0000
In-Reply-To: <20210818085047.1005285-1-oupton@google.com>
Message-Id: <20210818085047.1005285-4-oupton@google.com>
Mime-Version: 1.0
References: <20210818085047.1005285-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 3/4] KVM: arm64: Enforce reserved bits for PSCI target
 affinities
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

Some calls in PSCI take a target affinity argument, defined to be
bit-compatible with the affinity fields in MPIDR_EL1. All other bits in
the parameter are reserved and must be 0. Return INVALID_PARAMETERS if
the guest incorrectly sets a reserved bit.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/kvm/psci.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index db4056ecccfd..bb76be01abd2 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -59,6 +59,17 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 	kvm_vcpu_kick(vcpu);
 }
 
+static inline bool kvm_psci_valid_affinity(struct kvm_vcpu *vcpu,
+					   unsigned long affinity)
+{
+	unsigned long mask = MPIDR_HWID_BITMASK;
+
+	if (vcpu_mode_is_32bit(vcpu))
+		mask &= ~((u32) 0);
+
+	return !(affinity & ~mask);
+}
+
 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct vcpu_reset_state *reset_state;
@@ -66,9 +77,9 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	struct kvm_vcpu *vcpu = NULL;
 	unsigned long cpu_id;
 
-	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
-	if (vcpu_mode_is_32bit(source_vcpu))
-		cpu_id &= ~((u32) 0);
+	cpu_id = smccc_get_arg1(source_vcpu);
+	if (!kvm_psci_valid_affinity(source_vcpu, cpu_id))
+		return PSCI_RET_INVALID_PARAMS;
 
 	vcpu = kvm_mpidr_to_vcpu(kvm, cpu_id);
 
@@ -126,6 +137,9 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 	target_affinity = smccc_get_arg1(vcpu);
 	lowest_affinity_level = smccc_get_arg2(vcpu);
 
+	if (!kvm_psci_valid_affinity(vcpu, target_affinity))
+		return PSCI_RET_INVALID_PARAMS;
+
 	/* Determine target affinity mask */
 	target_affinity_mask = psci_affinity_mask(lowest_affinity_level);
 	if (!target_affinity_mask)
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
