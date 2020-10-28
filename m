Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A77C629D178
	for <lists+kvmarm@lfdr.de>; Wed, 28 Oct 2020 19:28:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EECDF4B478;
	Wed, 28 Oct 2020 14:28:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKkXi8kY9cXz; Wed, 28 Oct 2020 14:28:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E72944B42E;
	Wed, 28 Oct 2020 14:28:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FD894B3F4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Oct 2020 14:28:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8bpbClHquGb0 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Oct 2020 14:28:42 -0400 (EDT)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 57AC74B307
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Oct 2020 14:28:42 -0400 (EDT)
Received: by mail-oi1-f194.google.com with SMTP id m128so545363oig.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Oct 2020 11:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3WaX3GB+RjtdnSP+LhD8IcmydPpakTj1sPjuGaJHhUk=;
 b=R50+f2HMexiXujn/3s8wbSDSpzZkxztPT6ukKafGon3JZaL1WZLUTH+QAwokOvCsaQ
 sAYmS20X/V9umsC2qlaQY+YXgWf3FMIVwQ6jILxnl7CJ9IJwEP7i8o8xQuHsjdPCZDgk
 JStUIYGyBN/2nAofGuT0fTXDC9iDZvU8g9fMkbqj2p5ahcMiqko73o+JDZP43RjiKkbU
 aoHW1nSebxxc6yWs8Qs5L6alH+Iu7HCFLYZPOjW+Xeg1Qu+mVGD7g+p7VIsD7AlsrFoo
 sotty7nCPkhUVjtFyM+rXuEPScwsN9GilAWO5dV7a/N3r3WSwQdeewsIW+bRh9aKqYee
 VJTA==
X-Gm-Message-State: AOAM532/Rq2UttUZwQOL0aYEnyB/rpdEniEcmznpsfu1Kgc5KRpU/RDx
 hzUZw0b+m1wDZLrIElZtxg==
X-Google-Smtp-Source: ABdhPJzur/PKmLwkw1flAMpQOY0haYZbk9KroThCQXZkOi38EBn55AXKH98+wfHnGuSc+8KGlHBnPQ==
X-Received: by 2002:aca:bcc2:: with SMTP id m185mr188337oif.127.1603909721767; 
 Wed, 28 Oct 2020 11:28:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id a16sm77241otk.39.2020.10.28.11.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 11:28:40 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v7 1/2] arm64: Add part number for Arm Cortex-A77
Date: Wed, 28 Oct 2020 13:28:38 -0500
Message-Id: <20201028182839.166037-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

Add the MIDR part number info for the Arm Cortex-A77.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7219cddeba66..9e2e9a63c7b6 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -71,6 +71,7 @@
 #define ARM_CPU_PART_CORTEX_A55		0xD05
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
+#define ARM_CPU_PART_CORTEX_A77		0xD0D
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -105,6 +106,7 @@
 #define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
+#define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
