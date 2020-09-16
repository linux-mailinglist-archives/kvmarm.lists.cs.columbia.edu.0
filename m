Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8483B26C626
	for <lists+kvmarm@lfdr.de>; Wed, 16 Sep 2020 19:35:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A10B4B4DB;
	Wed, 16 Sep 2020 13:35:04 -0400 (EDT)
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
	with ESMTP id PHIOB5RHRT2L; Wed, 16 Sep 2020 13:35:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A2DE4B4D2;
	Wed, 16 Sep 2020 13:35:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F6474B4D2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 13:35:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGWK67Cn86im for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Sep 2020 13:35:00 -0400 (EDT)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 667BB4B47F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 13:35:00 -0400 (EDT)
Received: by mail-wr1-f66.google.com with SMTP id t10so7813011wrv.1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N/a5esHE2nX/K6yt6KRtONQ/utoU9A1KMk/TmGOQstA=;
 b=cKP/rHoQVyZyHVqZKyh7DfsE+mZFPUCn8SD3R2cnVqPlL2IpZN/1aLKkpOuKklj1R1
 Ff4dtVMf31VqV7eFBh6ys+o6DxOtke8LtPBezFeyWpXkzs3EU+umYnaWkrQnejG9YXnB
 sHAqmCN4KOZBEQnZDiWlay4r0GDhl5YJGXgS8X0RlMcYif6v2kf7SYPcj7OcW10ScDk1
 vjhBdmd1g44WnQjvQUVjyp6PazaRbDijYf2bR5RSFaB6frYEk96o78v/rIri2yBfQGOr
 AGYUvN3smNU0kV381ttfiFlS2yJpKppiHzhvMlNiMB9av3Maor7OK9Esa5xZHrFb599K
 0BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N/a5esHE2nX/K6yt6KRtONQ/utoU9A1KMk/TmGOQstA=;
 b=heNQK+wGJQW4cbfnwjEERaqFiniWglJ8Sb5LJFwFTBY5sKxZzg6DUwKAtX7/wJ5riW
 aNQJTA7OOBk07EDI95dhngc/jbqXF8CQTTQvHe4Pv0U+wOosWsnNnRpyau0GW5LSGKim
 jdu3tKSERvRDnVkH3OJFyQXZaw9LipXXku7bq1VdPiqKb80pvZJvBeBYwoIZCpxQswmi
 R/XcmKqOKBIz++AJWBIHeORbwUR4ktRfpiJKEJIV9mY4nrTjQdRjv3BguVSUBE5vBCfY
 urUhlHgQnM7joKtud2Ke/pXYiYAqgdpxlFXF8PLDrNRUMqB7vhnRRlgi7NUPqTsj8mAR
 HDdw==
X-Gm-Message-State: AOAM531jMSaGQu0PMbNb1ckQe9HlxpuPoHdZhA5/ofRMvL8DCiw4yg+I
 HSqz5sr1w9JdUYYzq+YTw4ChyCX7DNYvyd8N
X-Google-Smtp-Source: ABdhPJxomQAbrt08pj/u0T2EZWQsduo0LZzXxFu69uumIM0NIEhf5lzxyS7IebV8zrXzmcgv8Rs77w==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr28414841wrp.168.1600277699045; 
 Wed, 16 Sep 2020 10:34:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
 by smtp.gmail.com with ESMTPSA id i3sm33528281wrs.4.2020.09.16.10.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 10:34:58 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 07/11] kvm: arm64: Duplicate arm64_ssbd_callback_required
 for nVHE hyp
Date: Wed, 16 Sep 2020 18:34:35 +0100
Message-Id: <20200916173439.32265-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>
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

Hyp keeps track of which cores require SSBD callback by accessing a
kernel-proper global variable. Create an nVHE symbol of the same name
and copy the value from kernel proper to nVHE at KVM init time.

Done in preparation for separating percpu memory owned by kernel
proper and nVHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 10 +++++++---
 arch/arm64/kernel/image-vars.h   |  1 -
 arch/arm64/kvm/arm.c             |  2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c |  3 +++
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 189839c3706a..9db93da35606 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -529,23 +529,27 @@ static inline int kvm_map_vectors(void)
 
 #ifdef CONFIG_ARM64_SSBD
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_map_aux_data(void)
+static inline int hyp_init_aux_data(void)
 {
 	int cpu, err;
 
 	for_each_possible_cpu(cpu) {
 		u64 *ptr;
 
-		ptr = per_cpu_ptr(&arm64_ssbd_callback_required, cpu);
+		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
 		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
 		if (err)
 			return err;
+
+		/* Copy value from kernel to hyp. */
+		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
 	}
 	return 0;
 }
 #else
-static inline int hyp_map_aux_data(void)
+static inline int hyp_init_aux_data(void)
 {
 	return 0;
 }
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 76da2ad1010c..59d12a0b4622 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -67,7 +67,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(arm64_ssbd_callback_required);
 KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b588c3b5c2f0..3bdc2661d276 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1552,7 +1552,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	err = hyp_map_aux_data();
+	err = hyp_init_aux_data();
 	if (err)
 		kvm_err("Cannot map host auxiliary data: %d\n", err);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index cc4f8e790fb3..4662df6330d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -27,6 +27,9 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 
+/* Non-VHE copy of the kernel symbol. */
+DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
