Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3701D659481
	for <lists+kvmarm@lfdr.de>; Fri, 30 Dec 2022 05:01:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B5444B645;
	Thu, 29 Dec 2022 23:01:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.78
X-Spam-Level: 
X-Spam-Status: No, score=-6.78 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01, UPPERCASE_50_75=0.008, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPlT+Z4zTqii; Thu, 29 Dec 2022 23:01:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C63F84B133;
	Thu, 29 Dec 2022 23:00:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E3B1340CDE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Dec 2022 23:00:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qfCodNnzsRTG for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Dec 2022 23:00:56 -0500 (EST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 625DF40C0A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Dec 2022 23:00:56 -0500 (EST)
Received: by mail-pf1-f202.google.com with SMTP id
 n22-20020a62e516000000b005817b3a197aso3717948pff.14
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Dec 2022 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qn3YPHvbxT5N4Qy2asilovtHbC32P/cAZl7ccVXdKtc=;
 b=ovXnx3AiVWTWLZP1nqPGnA9G9aXvjVhU8yCZsweOlia82btgeLm9JpA1wGNvyQ4teE
 vMsKdZTGAe1G5aaSxl9BHjyRW5HlhqlZHtGXxM1iMYg6JMqzuORg5ysJvLWY7kkhmM8w
 5lETtvybqcO+R3WY3bd/eg+70LYYOiZzWAHI0QQZRuMrOZqRARrlGyhCQiJaxTEFs8R3
 PFze2j/FZsjcIpqI9zKZRwa1ohQDfuv8tP5FGPhA0QISAOJpXXE3lZIKBVuMNFUk8kI3
 tBmrZoPqjNVxyJsGIx5qb5HVvZH6du+5Vy/WcXsZuY3nAWbkQApXksFm7P/GR7H4tQ9L
 /niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qn3YPHvbxT5N4Qy2asilovtHbC32P/cAZl7ccVXdKtc=;
 b=3qhrB8GCG4HdmyJStI3/f73cTUQC2/jlA/1KuqSJSpvfgsxG8AwCmlwp73EAqrP9TU
 U9f/0oMhwapwQGmEgTUlpg9Q8Ovz359iICpj/+Mg0rPpwA9krfbfzubzNqtBFWrl3UcI
 WSrXXfJN1NIgvsEgCdGqR/U2uMJweugzvmjyjU5jiPaSAYduRNhMb59WaJwEzYIGZ/gG
 b7JiGuDCIyXQ0CvrzvOc8aVTOhGaaFdK4koGwjtHjCHFewzgJDjzxRB7KTTp8f+v5pg9
 D2SoM3C5x2QpHUyFb/PH3AUjy3T/XY7iNl0wMiZ2QIaIHGJ0JNjyA7ETFQ8Qz+pdLsdn
 9UOg==
X-Gm-Message-State: AFqh2koPLF/J7FvKvxOoJlJDWhDtGKJKDvB2aRHB5+l1GBP0BtHVX1eG
 ZJ2powvb6MyqKYofDYmzsXblDBXpkrg=
X-Google-Smtp-Source: AMrXdXsbI0ZXpiajNWg3ek185LMsn1CCNRFvnkex6Yos+Gcb4IKLJ/VmsEmttW2joaMa3amU9SzjC6quPrM=
X-Received: from reijiw-west4.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:aa1])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:3404:b0:580:104f:9b35 with SMTP id
 cn4-20020a056a00340400b00580104f9b35mr1814410pfb.13.1672372855519; Thu, 29
 Dec 2022 20:00:55 -0800 (PST)
Date: Thu, 29 Dec 2022 19:59:25 -0800
In-Reply-To: <20221230035928.3423990-1-reijiw@google.com>
Mime-Version: 1.0
References: <20221230035928.3423990-1-reijiw@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221230035928.3423990-5-reijiw@google.com>
Subject: [PATCH 4/7] tools: arm64: Import perf_event.h
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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

Copy perf_event.h from the kernel's arch/arm64/include/asm/perf_event.h.
The following patches will use macros defined in this header.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 tools/arch/arm64/include/asm/perf_event.h | 258 ++++++++++++++++++++++
 1 file changed, 258 insertions(+)
 create mode 100644 tools/arch/arm64/include/asm/perf_event.h

diff --git a/tools/arch/arm64/include/asm/perf_event.h b/tools/arch/arm64/include/asm/perf_event.h
new file mode 100644
index 000000000000..b2ae51f5f93d
--- /dev/null
+++ b/tools/arch/arm64/include/asm/perf_event.h
@@ -0,0 +1,258 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __ASM_PERF_EVENT_H
+#define __ASM_PERF_EVENT_H
+
+#define	ARMV8_PMU_MAX_COUNTERS	32
+#define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
+
+/*
+ * Common architectural and microarchitectural event numbers.
+ */
+#define ARMV8_PMUV3_PERFCTR_SW_INCR				0x0000
+#define ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL			0x0001
+#define ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL			0x0002
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL			0x0003
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE				0x0004
+#define ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL			0x0005
+#define ARMV8_PMUV3_PERFCTR_LD_RETIRED				0x0006
+#define ARMV8_PMUV3_PERFCTR_ST_RETIRED				0x0007
+#define ARMV8_PMUV3_PERFCTR_INST_RETIRED			0x0008
+#define ARMV8_PMUV3_PERFCTR_EXC_TAKEN				0x0009
+#define ARMV8_PMUV3_PERFCTR_EXC_RETURN				0x000A
+#define ARMV8_PMUV3_PERFCTR_CID_WRITE_RETIRED			0x000B
+#define ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED			0x000C
+#define ARMV8_PMUV3_PERFCTR_BR_IMMED_RETIRED			0x000D
+#define ARMV8_PMUV3_PERFCTR_BR_RETURN_RETIRED			0x000E
+#define ARMV8_PMUV3_PERFCTR_UNALIGNED_LDST_RETIRED		0x000F
+#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED				0x0010
+#define ARMV8_PMUV3_PERFCTR_CPU_CYCLES				0x0011
+#define ARMV8_PMUV3_PERFCTR_BR_PRED				0x0012
+#define ARMV8_PMUV3_PERFCTR_MEM_ACCESS				0x0013
+#define ARMV8_PMUV3_PERFCTR_L1I_CACHE				0x0014
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_WB			0x0015
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE				0x0016
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL			0x0017
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_WB			0x0018
+#define ARMV8_PMUV3_PERFCTR_BUS_ACCESS				0x0019
+#define ARMV8_PMUV3_PERFCTR_MEMORY_ERROR			0x001A
+#define ARMV8_PMUV3_PERFCTR_INST_SPEC				0x001B
+#define ARMV8_PMUV3_PERFCTR_TTBR_WRITE_RETIRED			0x001C
+#define ARMV8_PMUV3_PERFCTR_BUS_CYCLES				0x001D
+#define ARMV8_PMUV3_PERFCTR_CHAIN				0x001E
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_ALLOCATE			0x001F
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_ALLOCATE			0x0020
+#define ARMV8_PMUV3_PERFCTR_BR_RETIRED				0x0021
+#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED_RETIRED			0x0022
+#define ARMV8_PMUV3_PERFCTR_STALL_FRONTEND			0x0023
+#define ARMV8_PMUV3_PERFCTR_STALL_BACKEND			0x0024
+#define ARMV8_PMUV3_PERFCTR_L1D_TLB				0x0025
+#define ARMV8_PMUV3_PERFCTR_L1I_TLB				0x0026
+#define ARMV8_PMUV3_PERFCTR_L2I_CACHE				0x0027
+#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_REFILL			0x0028
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_ALLOCATE			0x0029
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_REFILL			0x002A
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE				0x002B
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB			0x002C
+#define ARMV8_PMUV3_PERFCTR_L2D_TLB_REFILL			0x002D
+#define ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL			0x002E
+#define ARMV8_PMUV3_PERFCTR_L2D_TLB				0x002F
+#define ARMV8_PMUV3_PERFCTR_L2I_TLB				0x0030
+#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS			0x0031
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE				0x0032
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS			0x0033
+#define ARMV8_PMUV3_PERFCTR_DTLB_WALK				0x0034
+#define ARMV8_PMUV3_PERFCTR_ITLB_WALK				0x0035
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE_RD				0x0036
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS_RD			0x0037
+#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS_RD			0x0038
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_LMISS_RD			0x0039
+#define ARMV8_PMUV3_PERFCTR_OP_RETIRED				0x003A
+#define ARMV8_PMUV3_PERFCTR_OP_SPEC				0x003B
+#define ARMV8_PMUV3_PERFCTR_STALL				0x003C
+#define ARMV8_PMUV3_PERFCTR_STALL_SLOT_BACKEND			0x003D
+#define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND			0x003E
+#define ARMV8_PMUV3_PERFCTR_STALL_SLOT				0x003F
+
+/* Statistical profiling extension microarchitectural events */
+#define	ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
+#define	ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001
+#define	ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE			0x4002
+#define	ARMV8_SPE_PERFCTR_SAMPLE_COLLISION			0x4003
+
+/* AMUv1 architecture events */
+#define	ARMV8_AMU_PERFCTR_CNT_CYCLES				0x4004
+#define	ARMV8_AMU_PERFCTR_STALL_BACKEND_MEM			0x4005
+
+/* long-latency read miss events */
+#define	ARMV8_PMUV3_PERFCTR_L1I_CACHE_LMISS			0x4006
+#define	ARMV8_PMUV3_PERFCTR_L2D_CACHE_LMISS_RD			0x4009
+#define	ARMV8_PMUV3_PERFCTR_L2I_CACHE_LMISS			0x400A
+#define	ARMV8_PMUV3_PERFCTR_L3D_CACHE_LMISS_RD			0x400B
+
+/* Trace buffer events */
+#define ARMV8_PMUV3_PERFCTR_TRB_WRAP				0x400C
+#define ARMV8_PMUV3_PERFCTR_TRB_TRIG				0x400E
+
+/* Trace unit events */
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT0				0x4010
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT1				0x4011
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT2				0x4012
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT3				0x4013
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT4			0x4018
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT5			0x4019
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT6			0x401A
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT7			0x401B
+
+/* additional latency from alignment events */
+#define	ARMV8_PMUV3_PERFCTR_LDST_ALIGN_LAT			0x4020
+#define	ARMV8_PMUV3_PERFCTR_LD_ALIGN_LAT			0x4021
+#define	ARMV8_PMUV3_PERFCTR_ST_ALIGN_LAT			0x4022
+
+/* Armv8.5 Memory Tagging Extension events */
+#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED			0x4024
+#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_RD			0x4025
+#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_WR			0x4026
+
+/* ARMv8 recommended implementation defined event types */
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD			0x0040
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR			0x0041
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD		0x0042
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR		0x0043
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_INNER		0x0044
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_OUTER		0x0045
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_VICTIM		0x0046
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_CLEAN			0x0047
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_INVAL			0x0048
+
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD			0x004C
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR			0x004D
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD				0x004E
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR				0x004F
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_RD			0x0050
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WR			0x0051
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_RD		0x0052
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_WR		0x0053
+
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_VICTIM		0x0056
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_CLEAN			0x0057
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_INVAL			0x0058
+
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_RD			0x005C
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_WR			0x005D
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_RD				0x005E
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_WR				0x005F
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD			0x0060
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR			0x0061
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_SHARED			0x0062
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NOT_SHARED		0x0063
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NORMAL			0x0064
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_PERIPH			0x0065
+#define ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_RD			0x0066
+#define ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_WR			0x0067
+#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_LD_SPEC			0x0068
+#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_ST_SPEC			0x0069
+#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_LDST_SPEC		0x006A
+
+#define ARMV8_IMPDEF_PERFCTR_LDREX_SPEC				0x006C
+#define ARMV8_IMPDEF_PERFCTR_STREX_PASS_SPEC			0x006D
+#define ARMV8_IMPDEF_PERFCTR_STREX_FAIL_SPEC			0x006E
+#define ARMV8_IMPDEF_PERFCTR_STREX_SPEC				0x006F
+#define ARMV8_IMPDEF_PERFCTR_LD_SPEC				0x0070
+#define ARMV8_IMPDEF_PERFCTR_ST_SPEC				0x0071
+#define ARMV8_IMPDEF_PERFCTR_LDST_SPEC				0x0072
+#define ARMV8_IMPDEF_PERFCTR_DP_SPEC				0x0073
+#define ARMV8_IMPDEF_PERFCTR_ASE_SPEC				0x0074
+#define ARMV8_IMPDEF_PERFCTR_VFP_SPEC				0x0075
+#define ARMV8_IMPDEF_PERFCTR_PC_WRITE_SPEC			0x0076
+#define ARMV8_IMPDEF_PERFCTR_CRYPTO_SPEC			0x0077
+#define ARMV8_IMPDEF_PERFCTR_BR_IMMED_SPEC			0x0078
+#define ARMV8_IMPDEF_PERFCTR_BR_RETURN_SPEC			0x0079
+#define ARMV8_IMPDEF_PERFCTR_BR_INDIRECT_SPEC			0x007A
+
+#define ARMV8_IMPDEF_PERFCTR_ISB_SPEC				0x007C
+#define ARMV8_IMPDEF_PERFCTR_DSB_SPEC				0x007D
+#define ARMV8_IMPDEF_PERFCTR_DMB_SPEC				0x007E
+
+#define ARMV8_IMPDEF_PERFCTR_EXC_UNDEF				0x0081
+#define ARMV8_IMPDEF_PERFCTR_EXC_SVC				0x0082
+#define ARMV8_IMPDEF_PERFCTR_EXC_PABORT				0x0083
+#define ARMV8_IMPDEF_PERFCTR_EXC_DABORT				0x0084
+
+#define ARMV8_IMPDEF_PERFCTR_EXC_IRQ				0x0086
+#define ARMV8_IMPDEF_PERFCTR_EXC_FIQ				0x0087
+#define ARMV8_IMPDEF_PERFCTR_EXC_SMC				0x0088
+
+#define ARMV8_IMPDEF_PERFCTR_EXC_HVC				0x008A
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_PABORT			0x008B
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_DABORT			0x008C
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_OTHER			0x008D
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_IRQ			0x008E
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_FIQ			0x008F
+#define ARMV8_IMPDEF_PERFCTR_RC_LD_SPEC				0x0090
+#define ARMV8_IMPDEF_PERFCTR_RC_ST_SPEC				0x0091
+
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_RD			0x00A0
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WR			0x00A1
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_REFILL_RD		0x00A2
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_REFILL_WR		0x00A3
+
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WB_VICTIM		0x00A6
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WB_CLEAN			0x00A7
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_INVAL			0x00A8
+
+/*
+ * Per-CPU PMCR: config reg
+ */
+#define ARMV8_PMU_PMCR_E	(1 << 0) /* Enable all counters */
+#define ARMV8_PMU_PMCR_P	(1 << 1) /* Reset all counters */
+#define ARMV8_PMU_PMCR_C	(1 << 2) /* Cycle counter reset */
+#define ARMV8_PMU_PMCR_D	(1 << 3) /* CCNT counts every 64th cpu cycle */
+#define ARMV8_PMU_PMCR_X	(1 << 4) /* Export to ETM */
+#define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
+#define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
+#define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
+#define	ARMV8_PMU_PMCR_N_SHIFT	11	 /* Number of counters supported */
+#define	ARMV8_PMU_PMCR_N_MASK	0x1f
+#define	ARMV8_PMU_PMCR_MASK	0xff	 /* Mask for writable bits */
+
+/*
+ * PMOVSR: counters overflow flag status reg
+ */
+#define	ARMV8_PMU_OVSR_MASK		0xffffffff	/* Mask for writable bits */
+#define	ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_OVSR_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define	ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define	ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv3
+ */
+#define	ARMV8_PMU_EXCLUDE_EL1	(1U << 31)
+#define	ARMV8_PMU_EXCLUDE_EL0	(1U << 30)
+#define	ARMV8_PMU_INCLUDE_EL2	(1U << 27)
+
+/*
+ * PMUSERENR: user enable reg
+ */
+#define ARMV8_PMU_USERENR_MASK	0xf		/* Mask for writable bits */
+#define ARMV8_PMU_USERENR_EN	(1 << 0) /* PMU regs can be accessed at EL0 */
+#define ARMV8_PMU_USERENR_SW	(1 << 1) /* PMSWINC can be written at EL0 */
+#define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
+#define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
+
+/* PMMIR_EL1.SLOTS mask */
+#define ARMV8_PMU_SLOTS_MASK	0xff
+
+#define ARMV8_PMU_BUS_SLOTS_SHIFT 8
+#define ARMV8_PMU_BUS_SLOTS_MASK 0xff
+#define ARMV8_PMU_BUS_WIDTH_SHIFT 16
+#define ARMV8_PMU_BUS_WIDTH_MASK 0xf
+
+#endif /* __ASM_PERF_EVENT_H */
-- 
2.39.0.314.g84b9a713c41-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
