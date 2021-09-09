Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC464042EE
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 03:39:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ABB3C4B0C0;
	Wed,  8 Sep 2021 21:39:12 -0400 (EDT)
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
	with ESMTP id KWeMjJNZleIs; Wed,  8 Sep 2021 21:39:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B6964B128;
	Wed,  8 Sep 2021 21:39:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F3C24B091
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 21:39:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ou72n+PKPwLn for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Sep 2021 21:39:08 -0400 (EDT)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 486054B0C5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 21:39:08 -0400 (EDT)
Received: by mail-pj1-f73.google.com with SMTP id
 g14-20020a17090a300e00b00186081195c2so308965pjb.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 18:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=lTqRO0idkBiaTW7ItUglmOAQqB88QiCZDRsI2c4OZ58=;
 b=dfmrkza0ggbmDEkjnJXOJPPETnwr63qICydj3Wpk8FVdGfgYnUe3tdRfwf43izmZlh
 JxSOd1JqW1MTS0/ZHkQAgMprhPbV4BSXeeIgbYbBKCA3AWlwrnCAMQOskkdJFtl3SpNS
 NYlk8NySDfFVwsWLNbt2aS2gMdiUIkjGqwUlX44XPD2fRg7V9U35AJtKn/mf6byslUqD
 NL5atvXUVIEsY54aZVVM2EKW1bkWeIMUnjVL5L817AjCF1JO7Y+b6N8XSmkYDpYuLgN4
 YHDXKEqFOETcnAtyGUP//89V6/7ir8IEwum8I50MTn0aWy8o2ROanviCskBO+Lby+UH4
 Dn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=lTqRO0idkBiaTW7ItUglmOAQqB88QiCZDRsI2c4OZ58=;
 b=Ju+fHWqMIrW5UIk0awtfehgpYfwmWFnks+nfuECvdbI/aPlZTIz/3NPDRR+ynbpT+K
 SRwDbglGXgne4NfQfY0fQhpb8Gr6ilsfyDrZya0xOdrF0QPi7WAggnlse/vfiQaZ6GXi
 I6MIOakFNH1b2MZeBP0VNUSnVaawtBh3jU7RoUada6Ar9hzzNcLlBQ3zz8cwTRacSgEj
 hnIt/KKT1dnOLX6FpkiL0S/0VrqabABZautdSu91IWt+apzacTHBzuxRW1t+viIJ/iUl
 cxnK2FSKQrYOgzrxLaO+//l8Ra0eUDz6X5csQDIE3U1Qg4LnYuOuTvxIby5q4FGy4WEg
 fzFQ==
X-Gm-Message-State: AOAM533zAtwtfsfg5m61e+bmnmH7R0P/EwECLz6SlM/PE4yXm5LqW9/e
 jenDs0a+Obd07vjlzZuBOcxH9MrK2WNb
X-Google-Smtp-Source: ABdhPJyc3BV8YSCcmMBcGFTF2wB4u0hyIS/oC54sk3TRAH4F3aSdUtllvTioIXtRosmVEfGWFTdqYH0KLtaf
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90b:38cc:: with SMTP id
 nn12mr608867pjb.139.1631151547473; Wed, 08 Sep 2021 18:39:07 -0700 (PDT)
Date: Thu,  9 Sep 2021 01:38:18 +0000
In-Reply-To: <20210909013818.1191270-1-rananta@google.com>
Message-Id: <20210909013818.1191270-19-rananta@google.com>
Mime-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v4 18/18] KVM: selftests: vgic_init: Pull
 REDIST_REGION_ATTR_ADDR from vgic.h
From: Raghavendra Rao Ananta <rananta@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Pull the definition of REDIST_REGION_ATTR_ADDR from vgic.h.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/aarch64/vgic_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 623f31a14326..157fc24f39c5 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -13,11 +13,10 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "vgic.h"
 
 #define NR_VCPUS		4
 
-#define REDIST_REGION_ATTR_ADDR(count, base, flags, index) (((uint64_t)(count) << 52) | \
-	((uint64_t)((base) >> 16) << 16) | ((uint64_t)(flags) << 12) | index)
 #define REG_OFFSET(vcpu, offset) (((uint64_t)vcpu << 32) | offset)
 
 #define GICR_TYPER 0x8
-- 
2.33.0.153.gba50c8fa24-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
