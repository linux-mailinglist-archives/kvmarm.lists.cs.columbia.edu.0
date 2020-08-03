Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCC23AD0D
	for <lists+kvmarm@lfdr.de>; Mon,  3 Aug 2020 21:31:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 137274B6A8;
	Mon,  3 Aug 2020 15:31:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEshnrDcK3GR; Mon,  3 Aug 2020 15:31:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BFBB4B6BF;
	Mon,  3 Aug 2020 15:31:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F7934B6A9
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Aug 2020 15:31:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCXD2AUSgZv1 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 Aug 2020 15:31:32 -0400 (EDT)
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 388F94B6A5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Aug 2020 15:31:32 -0400 (EDT)
Received: by mail-io1-f67.google.com with SMTP id t15so30811495iob.3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 03 Aug 2020 12:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8xBC3nAXSULrgwmXIdCxH6li3ZbD31n6G3URGbOpyNA=;
 b=DZSekD6d89TYzGhyFzWSRHz62poAN54KFou4Gal2lV3tmNIF2Cv+AVPwEJuyFoqOa7
 6usIqgMi93UJ5AmFaRQH01/Ulv8b/TmZmH9rx2XaOobAgvRdFXS70KKuY4FGLc3QzdFZ
 RXrUE5dKeYSahfbsCol8BGld+nj6alv2Qsm0EpHSl+eFKCJQKDYrPAkJqXCf1+2+tu4W
 DKuu1wHbcjmZlbp6tuYC+fExU/YKRjBrMSZ7NY0GNnfgYkzlD4ypETLMcbVg9AvRuuml
 6O4KNYyZ2Q1UDSsuAe8QgiIs+zZl0beNyqbJCxwSDjuBN6LuVBDKn9hS5wuUnfm2C9NW
 0Hdw==
X-Gm-Message-State: AOAM532ZMnf+GGDCE2glWXhOUNIYlZh6h53Qt2iccUnVBFwEDro1zIEy
 P2R1kj31WK+Usn646vP7/A==
X-Google-Smtp-Source: ABdhPJxJOyoVL9xvKIcZih4yRwF6OsmfrqUlgOy4I7K+vm9fZtxaDR0KVIxW7FfTgrrBF4jFD2iVng==
X-Received: by 2002:a02:6a6b:: with SMTP id m43mr1453848jaf.79.1596483091835; 
 Mon, 03 Aug 2020 12:31:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
 by smtp.googlemail.com with ESMTPSA id j79sm11254738ilg.42.2020.08.03.12.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:31:31 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 2/3] arm64: Add part number for Arm Cortex-A77
Date: Mon,  3 Aug 2020 13:31:26 -0600
Message-Id: <20200803193127.3012242-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803193127.3012242-1-robh@kernel.org>
References: <20200803193127.3012242-1-robh@kernel.org>
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
index a87a93f67671..7a2d3c336579 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -71,6 +71,7 @@
 #define ARM_CPU_PART_CORTEX_A55		0xD05
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
+#define ARM_CPU_PART_CORTEX_A77		0xD0D
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -104,6 +105,7 @@
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
