Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86CB727730E
	for <lists+kvmarm@lfdr.de>; Thu, 24 Sep 2020 15:48:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 243584B34C;
	Thu, 24 Sep 2020 09:48:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVXRU-foTyhN; Thu, 24 Sep 2020 09:48:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EFBD4B28A;
	Thu, 24 Sep 2020 09:48:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A2944B23C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 09:48:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZeNf1-+s876 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Sep 2020 09:48:55 -0400 (EDT)
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5FB564B189
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 09:48:55 -0400 (EDT)
Received: by mail-il1-f196.google.com with SMTP id h2so3144886ilo.12
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 06:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3WaX3GB+RjtdnSP+LhD8IcmydPpakTj1sPjuGaJHhUk=;
 b=Ie7k5XSeLpGkaFdTBvZsFcv45QvMOvN+megaD8k6G6UCqdQdp6WsR0s6bME5B9Yoqv
 X/YQzg7dUhlvhJRlCs5ExTcpcqvSNezPNDyPwn9ztWYBXgDQcTyYbwQpAh0cnP9PEOjB
 YHLSRU3yQ+pcv3CocQFs8ngJT3r/VW9Hk93lxJftF60dbB+enQ190p1QWitLfoMaCDJt
 uTY9H5HlbllbsAycl4stHi9nuxOaqUHhDAOAAzRmNqomWhhuoq7X2gghdq3pKDR015jp
 PU9nFNwmzWr6lnjbRN1aTW2S/jl5MAI3e7sLPRwAPfPAsGl3dTEt9+taTMUSI3ex2nu5
 FaXA==
X-Gm-Message-State: AOAM533y6Y5vQUDe7x3Z6w/MBtx7ZP3IV0pkv886Jtj2XQwYA2dIPH16
 JIM+HKCXWddWxk2C3ErNUA==
X-Google-Smtp-Source: ABdhPJyUyofZsuK9sw3RF8ovn6mV27/FPSpocHIZ1Mv4BvydMhTVe26RUtJiPMp2pFwFcBJVbyZx+w==
X-Received: by 2002:a92:ad11:: with SMTP id w17mr4344417ilh.77.1600955334727; 
 Thu, 24 Sep 2020 06:48:54 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
 by smtp.googlemail.com with ESMTPSA id k16sm1389152ioc.15.2020.09.24.06.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 06:48:54 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 1/2] arm64: Add part number for Arm Cortex-A77
Date: Thu, 24 Sep 2020 07:48:52 -0600
Message-Id: <20200924134853.2696503-1-robh@kernel.org>
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
