Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8F2B52E8
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 21:43:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A7F734C27B;
	Mon, 16 Nov 2020 15:43:52 -0500 (EST)
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
	with ESMTP id pqCjRmviFanm; Mon, 16 Nov 2020 15:43:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87B424C269;
	Mon, 16 Nov 2020 15:43:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC2814C246
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:43:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rjCpAmy8Tq2Y for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 15:43:48 -0500 (EST)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B6FA54C260
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:43:47 -0500 (EST)
Received: by mail-wr1-f66.google.com with SMTP id o15so20282035wru.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ukXSUN19mXtfVB5KA9zIxdiaxcyIFf7md5Ba/R31Grg=;
 b=DtlUevJisO+Ne7msAwCftQSbY5nowGLB869EeOLkjw0F81MdrCqjDeKvugVKq3Sp5J
 S04UBfQXncuByRKTyMtZ5PbC6Aclz1HK9lq4lmHfTRa+k6TjW8rlDu00jkvmG842jvwR
 CToBu0Up7QSDulDyqdBIeoMMTlBGEguHoh3BwOHRANjc+QbfdEtWHrssIikzt2IVhoy9
 cW1/RDl/sHbKZceIOdM167bSgCSfGEaZV/EUBfSk/QAtofmsv5Tn0KA5YxWiN60xNl3U
 RCwzP47jCjo1LI1LF9xATRlsODTHr4chgOstjE3PWlwSQDszrzdSzPF5pYn+fiP3er60
 yWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ukXSUN19mXtfVB5KA9zIxdiaxcyIFf7md5Ba/R31Grg=;
 b=pZWaWeTofGTuhVGgUrvZIgCX+pAMFQkSZr6tvreM8bZ5OBolWE/7B5Xs+TuFw1etWt
 olWQutuJSonZJXrXcU/yynoVdIN/6HEuKoHuaT7/A3YaeLRcQu4BJClfjtHcJcOHuT5J
 yA8FeT4zw7QvLP/6fO8Yb5igf4EFDUgAfyP7W4HxPtF+IOsJIJjZTbAUC0MzsEimj3Tt
 zFZ2q3YTDBYCMwmwCvaZzkTvph+8MRcD4kEf/bS7IZgPGSr24mqfQ4IdTuRlD2MSb8dF
 5um7yoxN93AsuC56u2CoWmObjZMsgVZhXf4h03Q3BG9ezwuunTNRS3Jb1w0inyYDyjHk
 8cfQ==
X-Gm-Message-State: AOAM533DB2OBCyixxybQezoJfCvEW5se7cMhg777Gbhn0pKJog12H7Xg
 5hz8mg6n3zSUbiouE2SfoNuzCYyOw/oYMMlGLUQ=
X-Google-Smtp-Source: ABdhPJx25hon/zoN9uwbhaQ0xvgAGMatL+ACDWBbBSCTiedwhmvJQc7wLeQ54lWE1BtGJuIUBvWQaw==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr22410355wrs.178.1605559426421; 
 Mon, 16 Nov 2020 12:43:46 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
 by smtp.gmail.com with ESMTPSA id d3sm26115072wrg.16.2020.11.16.12.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2020 12:43:45 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 11/24] kvm: arm64: Create nVHE copy of cpu_logical_map
Date: Mon, 16 Nov 2020 20:43:05 +0000
Message-Id: <20201116204318.63987-12-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrew Walbran <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
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

When KVM starts validating host's PSCI requests, it will need to map
MPIDR back to the CPU ID. To this end, copy cpu_logical_map into nVHE
hyp memory when KVM is initialized.

Only copy the information for CPUs that are online at the point of KVM
initialization so that KVM rejects CPUs whose features were not checked
against the finalized capabilities.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c              | 17 +++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c | 16 ++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 97af6c285f84..cdd7981ea560 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1499,6 +1499,21 @@ static inline void hyp_cpu_pm_exit(void)
 }
 #endif
 
+static void init_cpu_logical_map(void)
+{
+	extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
+	int cpu;
+
+	/*
+	 * Copy the MPIDR <-> logical CPU ID mapping to hyp.
+	 * Only copy the set of online CPUs whose features have been chacked
+	 * against the finalized system capabilities. The hypervisor will not
+	 * allow any other CPUs from the `possible` set to boot.
+	 */
+	for_each_online_cpu(cpu)
+		CHOOSE_NVHE_SYM(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
+}
+
 static int init_common_resources(void)
 {
 	return kvm_set_ipa_limit();
@@ -1677,6 +1692,8 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	init_cpu_logical_map();
+
 	return 0;
 
 out_err:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index 7b0363b4857f..cbab0c6246e2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -8,6 +8,22 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+/*
+ * nVHE copy of data structures tracking available CPU cores.
+ * Only entries for CPUs that were online at KVM init are populated.
+ * Other CPUs should not be allowed to boot because their features were
+ * not checked against the finalized system capabilities.
+ */
+u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
+
+u64 cpu_logical_map(unsigned int cpu)
+{
+	if (cpu >= ARRAY_SIZE(__cpu_logical_map))
+		hyp_panic();
+
+	return __cpu_logical_map[cpu];
+}
+
 unsigned long __hyp_per_cpu_offset(unsigned int cpu)
 {
 	unsigned long *cpu_base_array;
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
