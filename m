Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6601FF1A0
	for <lists+kvmarm@lfdr.de>; Thu, 18 Jun 2020 14:26:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 009EA4B148;
	Thu, 18 Jun 2020 08:26:33 -0400 (EDT)
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
	with ESMTP id vLiPZ7tN5cI5; Thu, 18 Jun 2020 08:26:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25B3B4B112;
	Thu, 18 Jun 2020 08:26:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 612654B150
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 08:26:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KunrL6ujoeWM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Jun 2020 08:26:26 -0400 (EDT)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 23A174B144
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 08:26:16 -0400 (EDT)
Received: by mail-wr1-f67.google.com with SMTP id r7so5871285wro.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eoJNhGWephHh2kHxeUxYOokymywaEEsB1soK0bgoMag=;
 b=TEXYXyhlg3yz0B8UIHkZXn6oAo3avJRrYkTyA9xaGkqdf5nonfGKN+VqZuKiArfpyg
 C4p/meD1W8zwxsQnM57O6GwJ4OdMceJ9XCYBBSHM7mMozUWAEhbCA6F0qm/dj2K9xK/e
 k/mK2fqb1vNFuJxs07bips/lRohz68SPOfmnqdd/TRIFyt5B/5+ceGinZ5PANTif+PWr
 EsACQ5qWGE413ytIYmfBVWTRRrjBhtqAGsGUFtYXw/Qx7SCxH8auMx0siwVhfPpoacYz
 Z4e+upQ9X957zGzIo//NEh3QnseeF0MDGnex47/HvPWSesAyd77vTORe6vQxrdY/0Gsg
 YedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eoJNhGWephHh2kHxeUxYOokymywaEEsB1soK0bgoMag=;
 b=mYFvukiIQkZqGK2uAotsXHxVg+2RqbW79/VR9QAzgZuzEJodtCDw5JmBXOpk7t9wdZ
 bfRHEnptdJjPDyCtHHEpxrjGbjow04eijLRkCvLTwtrRQYgCgXY+9uj7s9slqfX7J1EY
 GKF+p/SnjjiNbXPHoE0R8QcKKkW+LMxR2ysrDFVpdVjJvXAekSftPFO71eiaUuf3J/Pf
 XwvPOrJ8fwkyxZo8Wxqz7Z42ZtzvEOEK6e7C5Aq9Ctf/2yG6hK6CXoLoXbFEzI1QbHUi
 cF4pOfAdRby47/LDpFkpVLBnfSI3PkN8DpAKD8HzSzoVyo1kYkE9T+i+vihAdnAi8k/G
 GmdA==
X-Gm-Message-State: AOAM532N1UsfqZZvMCJ/D5nrLwB6flS0zHowrsujcvyT/pIwzpl8AGI4
 WStPJpSbX17kKAnisc0mHjuU+w==
X-Google-Smtp-Source: ABdhPJxWu2jWVCT4QdDVDT6jQzuNA/gmHgg6owA60mBPTRcDkKwon5A4vNDF90GMtDZwYVwwGKyFJQ==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr4371001wrb.314.1592483175166; 
 Thu, 18 Jun 2020 05:26:15 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
 by smtp.gmail.com with ESMTPSA id t188sm3491013wmt.27.2020.06.18.05.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 05:26:14 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 15/15] arm64: kvm: Lift instrumentation restrictions on VHE
Date: Thu, 18 Jun 2020 13:25:37 +0100
Message-Id: <20200618122537.9625-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: android-kvm@google.com, linux-kernel@vger.kernel.org,
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

With VHE and nVHE executable code completely separated, remove build config
that disabled GCOV/KASAN/UBSAN/KCOV instrumentation for VHE as these now
execute under the same memory mappings as the rest of the kernel.

No violations are currently being reported by either KASAN or UBSAN.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 5f4f217532e0..cd0c3936d266 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -11,11 +11,3 @@ obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
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
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
