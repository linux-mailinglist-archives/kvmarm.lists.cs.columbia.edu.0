Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 00C16229D63
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jul 2020 18:45:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5CCD4B2C3;
	Wed, 22 Jul 2020 12:45:19 -0400 (EDT)
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
	with ESMTP id vV3nS5nTYVIT; Wed, 22 Jul 2020 12:45:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44F254B2E7;
	Wed, 22 Jul 2020 12:45:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95B104B26F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:45:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PFo359BgoMY4 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jul 2020 12:45:16 -0400 (EDT)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E91914B2B7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:45:15 -0400 (EDT)
Received: by mail-wr1-f65.google.com with SMTP id q5so2553980wru.6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Zoc4jT5D/PnpX6Ge9Fh8+yTlt5xAHFadpjWGBF1q0w=;
 b=EHDURTcBkVhJJVi3ujf/kQeTfFBT7h/B9rxoO/V6rVCgVwVesI6SzZIa06WBR4XrFl
 EEc9WcBPE7DBmvVrqXAG2TZ6AgH9fDPkjcr/cpkZ3YeIKVPt1DBo+pvWJi6VB3G/JmeX
 fSgzbviAYvO/KtVcj8dE8gdhqC3wxBnOf4JlONMDO93pAlrrfS5v4nv9Avm7ELmCflWd
 3AltLvlQCDsboajAG8AeCOm8lC6ewgH11gH6xtNGdjO5UFpz3uUW8GRmqYaHIa02jYdR
 vH1wWLWsSKtXiU7d9T/LJrWMnSBWw2shzP30T5TVW0Z4QbYHatf6n/Uz3oyeSyz0QFKE
 7YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Zoc4jT5D/PnpX6Ge9Fh8+yTlt5xAHFadpjWGBF1q0w=;
 b=nanJ7gytumvwXB+0JZ9xbaLhDPPX2+R/Bj2v5XbZAzC8yGjyf++07D0OpA0EbrKGGv
 O1tA13Za0JIVpeiQ3vyOI63iGJuNmOimiYvKWGYmcAd1ZVoI27iWc/O+PIuorG1StnzY
 tp1jxcmsosyzU54mOe5/T3OaqjxmfIsYGzKvs3FKkC0umrxfhLx7JBbrRjMrryIT/Lnn
 tXKvULWUJ9397tdv6gARfQR6OmroEyi91pYgX65O9o7rECvLxEkFYiLatLJ7qz7igQt3
 m06x/9AQp/dDfyLRzcZQq7BOYApLQZLC12XUefmI+2LNI+hME8bAkw8FgSq8lnCXanhq
 h2GA==
X-Gm-Message-State: AOAM533YrO5UZKcol5ISWH92JerRCGBmeDdeuAmd14hj1Kb2XpNAnfMV
 m5FLwG1UFaJBq/K5lliijjODig==
X-Google-Smtp-Source: ABdhPJzLKmKG9pub1HFuNdCsYrh8zqcSQp68qHq5cvDc4U/7vFwUWtKwLOPhPUQibgTF3FLak/t0vg==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr365969wrv.331.1595436314869; 
 Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
 by smtp.gmail.com with ESMTPSA id t2sm242165wma.43.2020.07.22.09.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 9/9] kvm: arm64: Remove unnecessary hyp mappings
Date: Wed, 22 Jul 2020 17:44:24 +0100
Message-Id: <20200722164424.42225-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@google.com, kvmarm@lists.cs.columbia.edu,
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

With all nVHE per-CPU variables being part of the hyp per-CPU region,
mapping them individual is not necessary any longer. They are mapped to hyp
as part of the overall per-CPU region.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 25 +++++++------------------
 arch/arm64/kvm/arm.c             | 17 +----------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e9e5875274cb..1a66089cf4f4 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -531,28 +531,17 @@ static inline int kvm_map_vectors(void)
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_init_aux_data(void)
+static inline void hyp_init_aux_data(void)
 {
-	int cpu, err;
+	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		u64 *ptr;
-
-		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
-		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
-		if (err)
-			return err;
-
-		/* Copy value from kernel to hyp. */
-		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
-	}
-	return 0;
+	/* Copy arm64_ssbd_callback_required values from kernel to hyp. */
+	for_each_possible_cpu(cpu)
+		*(per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu)) =
+			per_cpu(arm64_ssbd_callback_required, cpu);
 }
 #else
-static inline int hyp_init_aux_data(void)
-{
-	return 0;
-}
+static inline void hyp_init_aux_data(void) {}
 #endif
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index bbbc5c1519a9..f2e537d99d2b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1628,22 +1628,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		kvm_host_data_t *cpu_data;
-
-		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
-		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
-
-		if (err) {
-			kvm_err("Cannot map host CPU state: %d\n", err);
-			goto out_err;
-		}
-	}
-
-	err = hyp_init_aux_data();
-	if (err)
-		kvm_err("Cannot map host auxiliary data: %d\n", err);
-
+	hyp_init_aux_data();
 	return 0;
 
 out_err:
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
