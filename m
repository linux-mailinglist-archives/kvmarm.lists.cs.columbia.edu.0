Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B84C0AFE
	for <lists+kvmarm@lfdr.de>; Wed, 23 Feb 2022 05:20:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3179D4C420;
	Tue, 22 Feb 2022 23:20:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2aX8INqgMKOt; Tue, 22 Feb 2022 23:20:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C0274C41A;
	Tue, 22 Feb 2022 23:19:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F6404C3F0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 23:19:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-82Jk9M9nQw for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 23:19:56 -0500 (EST)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AA8684C2FE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 23:19:56 -0500 (EST)
Received: by mail-yb1-f201.google.com with SMTP id
 i205-20020a2522d6000000b00622c778ac7cso26632479ybi.3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 20:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wX3uLQzTSI1VGuKWaldZ9OxCxf9p8PEqoE0rKvDDfEY=;
 b=Kf5M0rxY7HQQeZge6xI5zVRK2n2hqX67dNO4ZfduWzrnYcNHFWeUg6et/fV66kMTv9
 f3yK6Yl1K3Rf5O3bbEuBdW12/ZYF9SuD5mkVNppx/+UfgCTU0qr6XUJkDPFOc/Oe37sU
 EUWuxkItN92Y6rYy1DwSj8++FXcg1m+6/7j1CFy0Na2YsV+ZP/ayfTUOl0p7Mh1TzUGE
 x/59SqmzMR2JBIXSbQaVin+KiZw9cDuhjNnx/nH5/fQs7TJQ+IZZBeLXQn209Lx0af92
 4jmDJJiHNB9g0ulDKUFPq7U1w6vuxSjflkmLk7luJbee+y9MyDgIBi+MVcqR6av2cYo1
 tvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wX3uLQzTSI1VGuKWaldZ9OxCxf9p8PEqoE0rKvDDfEY=;
 b=F2azODbUvFDGZdKbF2rXGR4gorYHboCVbpb/4ikQvluCIG+cpFvaW/PYDNuXPNcXX1
 DUUnftkXAWAta6qTey5/tMZdxDcYlvU2YBkKu10YOodbETFKysxeCUonLPFgzvWA2Qm3
 bt49BFoedQy5fCVG7S/UlKyPx/A7EjZ/zLLVIL8Y/PcObjbRcR6TwGviGbTGfa1fDBYT
 Ke2PG6G+D/878Z+o6XncP9u9lFhC/t+gqwfz++6vpeeYUCe30qVZcYqb0pzEE2v80A91
 N3ehiaSU8p/AroXyATQBigtEbO9hL7zjOTqhGzuApnpu8t+2G2hR0BzsnAIvJaad52C7
 /OXQ==
X-Gm-Message-State: AOAM531bl3QcC2NfWCc1gcIm7LumsFLzHOHwV9L2gcoefu2+K8QoBRGV
 81IkGRHKIGVsp6Rv0Juuqqvf6RMVQdI125Wt9nQQg2IARRptuPyU2PBqFdUSKR6LWJEvIXWbc+z
 8Bh/TPYnztCep1IXnBGcA64knH9w/3wuiseh09WnKlnB2xzHJq8KLHkL23jGZkh8DWJGXWA==
X-Google-Smtp-Source: ABdhPJx2YT+GU5lWSgnrMCYBlsHI2XDxNPpCJLOOdiCNG5irLKCRPgODRJMyBSnjRIKFdre9AH202Lw+e4M=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a25:ac53:0:b0:624:6fce:7c6e with
 SMTP id
 r19-20020a25ac53000000b006246fce7c6emr16211592ybd.164.1645589996212; Tue, 22
 Feb 2022 20:19:56 -0800 (PST)
Date: Wed, 23 Feb 2022 04:18:41 +0000
In-Reply-To: <20220223041844.3984439-1-oupton@google.com>
Message-Id: <20220223041844.3984439-17-oupton@google.com>
Mime-Version: 1.0
References: <20220223041844.3984439-1-oupton@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 16/19] selftests: KVM: Create helper for making SMCCC calls
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

The PSCI and PV stolen time tests both need to make SMCCC calls within
the guest. Create a helper for making SMCCC calls and rework the
existing tests to use the library function.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 .../testing/selftests/kvm/aarch64/psci_test.c | 25 ++++++-------------
 .../selftests/kvm/include/aarch64/processor.h | 22 ++++++++++++++++
 .../selftests/kvm/lib/aarch64/processor.c     | 25 +++++++++++++++++++
 tools/testing/selftests/kvm/steal_time.c      | 13 +++-------
 4 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index 4c5f6814030f..8c998f0b802c 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -26,32 +26,23 @@
 static uint64_t psci_cpu_on(uint64_t target_cpu, uint64_t entry_addr,
 			    uint64_t context_id)
 {
-	register uint64_t x0 asm("x0") = PSCI_0_2_FN64_CPU_ON;
-	register uint64_t x1 asm("x1") = target_cpu;
-	register uint64_t x2 asm("x2") = entry_addr;
-	register uint64_t x3 asm("x3") = context_id;
+	struct arm_smccc_res res;
 
-	asm("hvc #0"
-	    : "=r"(x0)
-	    : "r"(x0), "r"(x1), "r"(x2), "r"(x3)
-	    : "memory");
+	smccc_hvc(PSCI_0_2_FN64_CPU_ON, target_cpu, entry_addr, context_id,
+		  0, 0, 0, 0, &res);
 
-	return x0;
+	return res.a0;
 }
 
 static uint64_t psci_affinity_info(uint64_t target_affinity,
 				   uint64_t lowest_affinity_level)
 {
-	register uint64_t x0 asm("x0") = PSCI_0_2_FN64_AFFINITY_INFO;
-	register uint64_t x1 asm("x1") = target_affinity;
-	register uint64_t x2 asm("x2") = lowest_affinity_level;
+	struct arm_smccc_res res;
 
-	asm("hvc #0"
-	    : "=r"(x0)
-	    : "r"(x0), "r"(x1), "r"(x2)
-	    : "memory");
+	smccc_hvc(PSCI_0_2_FN64_AFFINITY_INFO, target_affinity, lowest_affinity_level,
+		  0, 0, 0, 0, 0, &res);
 
-	return x0;
+	return res.a0;
 }
 
 static void guest_main(uint64_t target_cpu)
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 8f9f46979a00..59ece9d4e0d1 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -185,4 +185,26 @@ static inline void local_irq_disable(void)
 	asm volatile("msr daifset, #3" : : : "memory");
 }
 
+/**
+ * struct arm_smccc_res - Result from SMC/HVC call
+ * @a0-a3 result values from registers 0 to 3
+ */
+struct arm_smccc_res {
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+};
+
+/**
+ * smccc_hvc - Invoke a SMCCC function using the hvc conduit
+ * @function_id: the SMCCC function to be called
+ * @arg0-arg6: SMCCC function arguments, corresponding to registers x1-x7
+ * @res: pointer to write the return values from registers x0-x3
+ *
+ */
+void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
+	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
+	       uint64_t arg6, struct arm_smccc_res *res);
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 9343d82519b4..6a041289fa80 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -500,3 +500,28 @@ void __attribute__((constructor)) init_guest_modes(void)
 {
        guest_modes_append_default();
 }
+
+void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
+	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
+	       uint64_t arg6, struct arm_smccc_res *res)
+{
+	asm volatile("mov   w0, %w[function_id]\n"
+		     "mov   x1, %[arg0]\n"
+		     "mov   x2, %[arg1]\n"
+		     "mov   x3, %[arg2]\n"
+		     "mov   x4, %[arg3]\n"
+		     "mov   x5, %[arg4]\n"
+		     "mov   x6, %[arg5]\n"
+		     "mov   x7, %[arg6]\n"
+		     "hvc   #0\n"
+		     "mov   %[res0], x0\n"
+		     "mov   %[res1], x1\n"
+		     "mov   %[res2], x2\n"
+		     "mov   %[res3], x3\n"
+		     : [res0] "=r"(res->a0), [res1] "=r"(res->a1),
+		       [res2] "=r"(res->a2), [res3] "=r"(res->a3)
+		     : [function_id] "r"(function_id), [arg0] "r"(arg0),
+		       [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3),
+		       [arg4] "r"(arg4), [arg5] "r"(arg5), [arg6] "r"(arg6)
+		     : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7");
+}
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 62f2eb9ee3d5..8c4e811bd586 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -118,17 +118,10 @@ struct st_time {
 
 static int64_t smccc(uint32_t func, uint64_t arg)
 {
-	unsigned long ret;
+	struct arm_smccc_res res;
 
-	asm volatile(
-		"mov	w0, %w1\n"
-		"mov	x1, %2\n"
-		"hvc	#0\n"
-		"mov	%0, x0\n"
-	: "=r" (ret) : "r" (func), "r" (arg) :
-	  "x0", "x1", "x2", "x3");
-
-	return ret;
+	smccc_hvc(func, arg, 0, 0, 0, 0, 0, 0, &res);
+	return res.a0;
 }
 
 static void check_status(struct st_time *st)
-- 
2.35.1.473.g83b2b277ed-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
