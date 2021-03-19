Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF834191D
	for <lists+kvmarm@lfdr.de>; Fri, 19 Mar 2021 11:02:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02AF04B6A9;
	Fri, 19 Mar 2021 06:02:15 -0400 (EDT)
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
	with ESMTP id YSTMJ2z9YXxE; Fri, 19 Mar 2021 06:02:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB4F24B6A8;
	Fri, 19 Mar 2021 06:02:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F20374B611
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 06:02:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yBjgC704VocF for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Mar 2021 06:02:11 -0400 (EDT)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BA3454B5CC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 06:02:09 -0400 (EDT)
Received: by mail-qk1-f202.google.com with SMTP id x11so30349620qki.22
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
 b=mxpQrZ8gNL/t8iySLxtG3kNdKlZSs0r0Mt6WLEJ+xYt02Sibhx2GhBYgVmtffTsidV
 JMdP9JdMDQvQn8+P4mVyA3o13U8KZbMz1nkqS+pCDmdzWF4u4/9ktQT+iEYs87nNGRls
 C/nYwV3ipvNG6nAKct925qTm/Y23zArUpvX8B3xQnnXBOTiVsx+0F/XZxatVGtzSGzCP
 yj84Uv06GMNVkldApWkew2knEXWSn68Hr7Sm4QQnevZPzERlCj0IJ2Zi8KiUi6rBlRsk
 ylcl/Ea5Z6tGxsVJI1nTKWoUNA7YEZ8o4MQawN9jDuAZJHlvglRxfhEvADdRt+TjzDvq
 1o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
 b=IdtNHhWWgSQU3gtgQI8YuYcsXqVZqgZxkfYV50RMA5OjCyg+ndBlYhtKPS4dz7cZIG
 akzXqIHp5n7KaSRohrh68u7fvR1Ud1+ypCViWkUPNHG6+OHVSlsZ3v/KIk4aDlxdQddU
 BBpvrGnnP44rawJ/spWK5gf9n82vo3jUPgJvstDLc/gfgomv/ZkKIE7LkFPOqxSSnaar
 KApjGZOdooLxIXClT8e9WspBAHpQLM1JyfIbB7RlIyt5vT+CJiajAnV2f34iKVZFzbZX
 sTANUR8OY/JRmIwOkEd/OqUhZhq2XFTlTUsuTGvRk4d0HCkNOZ16l2/czgX2O+rFhoen
 fe+Q==
X-Gm-Message-State: AOAM5302aCZ0nvbD63Txr1EopSzXt4r+YDyDy2dv0lfTQU94jll8ZuOA
 JgtoJ147Vob5ULAx1Dx1rSmYi3islJq3
X-Google-Smtp-Source: ABdhPJxdeOyw7F8LEDXqPaxD4/XKhLFDVdrSX3/+Wq2Z6NaQDQAjwvxv64KJelAZOfkMtqhUmxag8EYto+fC
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:88:: with SMTP id
 n8mr8623708qvr.22.1616148129286; Fri, 19 Mar 2021 03:02:09 -0700 (PDT)
Date: Fri, 19 Mar 2021 10:01:17 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-10-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 09/38] KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
From: Quentin Perret <qperret@google.com>
To: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
Cc: android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, tabba@google.com,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

In order to allow the usage of code shared by the host and the hyp in
static inline library functions, allow the usage of kvm_nvhe_sym() at
EL2 by defaulting to the raw symbol name.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 78cd77990c9c..b4b3076a76fb 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -10,11 +10,15 @@
 #define __HYP_CONCAT(a, b)	a ## b
 #define HYP_CONCAT(a, b)	__HYP_CONCAT(a, b)
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
  * to separate it from the kernel proper.
  */
 #define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+#else
+#define kvm_nvhe_sym(sym)	sym
+#endif
 
 #ifdef LINKER_SCRIPT
 
-- 
2.31.0.rc2.261.g7f71774620-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
