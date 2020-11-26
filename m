Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17C2C5892
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 16:54:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C69024C075;
	Thu, 26 Nov 2020 10:54:39 -0500 (EST)
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
	with ESMTP id mWl9UYLYMbAX; Thu, 26 Nov 2020 10:54:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EFF14C065;
	Thu, 26 Nov 2020 10:54:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8480D4B747
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 10:54:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7IRC+-8wom+u for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 10:54:34 -0500 (EST)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 425B44C020
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 10:54:34 -0500 (EST)
Received: by mail-wm1-f68.google.com with SMTP id 10so2564741wml.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t3ZEYk2Uf0v1klDyIVNllC4hj8a8TzhOU5HlrW3d3XY=;
 b=WB708Y6ZQsVTnPDe3k8SGt1N+Zi1ArG5DNJ8Ikjx+GwIsVyKkyANitm+7v9D8STbCN
 4sIx6XZ9WxtYX8XP7V/bVY64iZPta0oEQJhY5JctNUzEqp/siO8Mh7MOaSHI9jTKRX/G
 ba18CMjyRpguJUKBwLVRI8k5AHvlNVRnB1DKj5K2COahoTLJrC8pp74gWQmVJtRJ8ivp
 fJffW03dFEtg1jOc/x7+J4NtCy/6j6euZgUM7vcZ5okmBEc+hu9CLbAHOr83RhZZ7PAd
 Ya9qvceAHvZJLaq5R4L/3OTpAnWZot8Djf5EA45iNDBN22H7c4JKiI1EzSkX09tYRLsS
 Ahyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t3ZEYk2Uf0v1klDyIVNllC4hj8a8TzhOU5HlrW3d3XY=;
 b=ID5d3GtqWmwbv54gAT+JslF9MPyTjSWOQZbJQUmAgGwalG7WYgRli1gPlyvNUl9QA1
 mtbQpBbOneA7evjapYhWy5TknRRvcVqJR1iBuq63O93TPY2V3i4JOwCAxcdXcj1juczg
 gu4UUE8alHvmalfEnFahddC5hUwt61ftD1Rznd0xoBHsi+B7a/CHzLaorb4kBokIc2cU
 K1S4SLhRFe1AOcf/cnw1+Wg2/seSmyzgGdkMHFPQAazxBYErC314eOk/R1XWH5jlF7S2
 I6QEzpZskQrrviz6UJUQTpnZVl+6QoqsoJlx5fHwTdY1ZT+lZ9sMYDZAT3SjPdI44mo4
 rBHA==
X-Gm-Message-State: AOAM532E8jt2YBarGL89QjxztBOPRqFr66PBqX0XPL16/i4B20tYcZBt
 U0Dk5kN8voucF8DgLwmfIGnHmICCcMlsHOoI
X-Google-Smtp-Source: ABdhPJwqAqu5fiW6MkcfS54w+9X9od3V8YYUykJ0+y44LSiV/rX3jrG5iDECe1WB8DPMFJnBgkCsIA==
X-Received: by 2002:a1c:3b07:: with SMTP id i7mr4113356wma.118.1606406072986; 
 Thu, 26 Nov 2020 07:54:32 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
 by smtp.gmail.com with ESMTPSA id d8sm8607196wmb.11.2020.11.26.07.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2020 07:54:32 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 03/23] arm64: Make cpu_logical_map() take unsigned int
Date: Thu, 26 Nov 2020 15:54:01 +0000
Message-Id: <20201126155421.14901-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
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

CPU index should never be negative. Change the signature of
(set_)cpu_logical_map to take an unsigned int.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/smp.h | 4 ++--
 arch/arm64/kernel/setup.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2e7f529ec5a6..bcb01ca15325 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -46,9 +46,9 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
  * Logical CPU mapping.
  */
 extern u64 __cpu_logical_map[NR_CPUS];
-extern u64 cpu_logical_map(int cpu);
+extern u64 cpu_logical_map(unsigned int cpu);
 
-static inline void set_cpu_logical_map(int cpu, u64 hwid)
+static inline void set_cpu_logical_map(unsigned int cpu, u64 hwid)
 {
 	__cpu_logical_map[cpu] = hwid;
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 133257ffd859..2f2973bc67c7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -276,7 +276,7 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
-u64 cpu_logical_map(int cpu)
+u64 cpu_logical_map(unsigned int cpu)
 {
 	return __cpu_logical_map[cpu];
 }
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
