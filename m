Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73E471D4BEE
	for <lists+kvmarm@lfdr.de>; Fri, 15 May 2020 12:59:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29DE54B500;
	Fri, 15 May 2020 06:59:53 -0400 (EDT)
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
	with ESMTP id 5j7lqC8jpXRL; Fri, 15 May 2020 06:59:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 28F414B513;
	Fri, 15 May 2020 06:59:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 785464B4E5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 May 2020 06:59:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bz3CbIQpXoBN for <kvmarm@lists.cs.columbia.edu>;
 Fri, 15 May 2020 06:59:29 -0400 (EDT)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A27734B4FA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 May 2020 06:59:21 -0400 (EDT)
Received: by mail-wr1-f65.google.com with SMTP id l17so3033289wrr.4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 May 2020 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sW/5ZwfUkcrq8MNsWbZB8lRN7UAKxOnejMG35fACcpU=;
 b=tqre/qi7LotrlOupGSzYt/UzPtBy6RKj8xVepwDzpdtgmD2j1I7oQ4kcPPdkV2ZGOJ
 hkb6qLAW45uzBZeohJSLIXIGRY/7SVGY1leLVFJVuP4CMq9xSsZjxdeS5vfPPIJEl/y4
 MHUYKk1DPQdCyvYh7bT9gvsdjIWCHy1cgZBKcG/RbceKT+P2dXPlyzEVONehZKyuPUXL
 388pp6M15+gpipCoh7DAoq00mt0q5cZfUMfLfunZYQv4+z9cvbDoEj4JB4JSpO7k2DxO
 V5ckh4Ftfrl4+RmZy2SzVWEqFvC/U1b7tjmCt7qIYEAU6yVfSEpjBRvfcTtbYrhOj0xo
 KVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sW/5ZwfUkcrq8MNsWbZB8lRN7UAKxOnejMG35fACcpU=;
 b=Z6L8mKcJp4rmRoac8Ff39boIJXfJpRb1rpeh2kqwdjh2wCvtZ3UZQ/BwECT/h9aGdD
 q1kQZNNuJXo9UQCrdky69LkkK9s1j6yIuUDw4ImbvWP1AxsxXHAQtD92JXDxZS3qyGGg
 CsOLHp7vwmi+3W+5OLH/WEpE1E7nzDtbyFq6KV4Ra8aE8MqKZ6kDi27JhgPm7XWE+zEV
 KwiTjIyBiglAlsME0QMYQgO3zGeQ61ZQaJAkkSD6ySAJSC31mGEqI4kVmdn0fM5GfTsq
 dBMDLJ8cFo5sakR79F83vmCuTOEwJpooszy4wSbRm1hmya9V8/+LJXkg2ALcubDw8pyo
 2zHA==
X-Gm-Message-State: AOAM5326wiDxJO56J/SGMhAa2dyF6/NRArU3K9NxbzFmsJlsTAIG4FTo
 G20MCaxCOS7aZ1wKU9KP8ArvSw==
X-Google-Smtp-Source: ABdhPJypINRB1vch83S8A4T3nKixjdrHNtaJjymSWdrumgmpTeVVmG20s6/LdGZ7yzPGLe/h25kr3w==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr3816250wrk.92.1589540360508;
 Fri, 15 May 2020 03:59:20 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
 by smtp.gmail.com with ESMTPSA id f128sm3300011wme.1.2020.05.15.03.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 03:59:19 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v2 14/14] arm64: kvm: Lift instrumentation restrictions on VHE
Date: Fri, 15 May 2020 11:58:41 +0100
Message-Id: <20200515105841.73532-15-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

With VHE and nVHE executable code completely separated, remove build config
that disabled GCOV/KASAN/UBSAN/KCOV instrumentation for VHE as these now
execute under the same memory mappings as the rest of the kernel.

No violations are currently being reported by either KASAN or UBSAN.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index c9fd8618980d..69113bf193de 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -11,11 +11,3 @@ obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 vhe-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
 	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
-
-# KVM code is run at a different exception code with a different map, so
-# compiler instrumentation that inserts callbacks or checks into the code may
-# cause crashes. Just disable it.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
