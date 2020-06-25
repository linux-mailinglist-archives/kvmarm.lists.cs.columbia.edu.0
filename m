Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1007D209F6D
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jun 2020 15:14:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B70884B543;
	Thu, 25 Jun 2020 09:14:37 -0400 (EDT)
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
	with ESMTP id AJjdK2DusN-p; Thu, 25 Jun 2020 09:14:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E1514B55F;
	Thu, 25 Jun 2020 09:14:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C17864B54B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jun 2020 09:14:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSALIo7Tj8NH for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jun 2020 09:14:33 -0400 (EDT)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C5364B2EA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jun 2020 09:14:32 -0400 (EDT)
Received: by mail-wm1-f67.google.com with SMTP id u26so6720429wmn.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jun 2020 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wraev6ZBkvjCXqVdZoeks0aAoF06EDUQslGWSfcwelE=;
 b=ua7P+YZJwVqfWDyuPBaOjCABX1tSBuIIGIhiG1M2l3I9pUVwlIpIaLg4tk1vR6DAEh
 xQUnQ2orukTjqBWFut7xqaSuDXy3DXYDlYGhTELnZtsUvD/Cd3xIEN/CKH74JI9PA6Nd
 rKmturGSVa/8/WsP6oa76tKofsgGbvmi2qPtMaPE9UnhUkfeIXrHGwoUuXQLnVbgGfCp
 ucEEpOl318TFEhm1s0ykC4Twr8wGoZHtkpkL58rV/Y3cfXmvJcJiWP/Ry9azYYe//N5v
 mJmJzCEebK98IQhJoPjkGbS7E29bK4nED+seNPErBGhKnMyITD3dUnEHtjk8780W46ud
 Motg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wraev6ZBkvjCXqVdZoeks0aAoF06EDUQslGWSfcwelE=;
 b=BnnpZqGICjiz0BtFKciRzF+yBQvDi7ESMh0UMmdC0VqF1lLB8F/OWd/UGrc7b+Gm3J
 YpM7OEcdWcHfH9iV8k6SrsuZrJ9/BqS/0CkSu7G1RysDkYks04whGulanY+HoQ90jWmr
 Y8YXUbuLRk372OpVhgWLBM2QrAFOGjXAOwdrjRSd3dCDbcQzuEoAlQzMVFpLvS+Prq7p
 5a09pvFD9KqxURjsEu9yZ6X963G8q6PgXhT6+fUdhfDkZPI/oPsz/btmiek2nqlPdGXe
 K87XRloJ6DVojhEvk/rXqcVxyV4ieA8aDr/myCMKaHS1vYo3jgSrcDosrISS/74Njjf7
 ufUw==
X-Gm-Message-State: AOAM530Hsi6+7rvfBnSGvNSFlImErLV5p5GTwrhIpq6EWEP9cT6QnlDy
 +fUcsVlixNRVI61D14gbqyuBxA==
X-Google-Smtp-Source: ABdhPJwSD6tTR4A51iFYqmD+o4uh7mMxnCrC2utrSiSA099BJejStzsjCmFzuSX9rIPS1ekV3bn+rQ==
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr3259403wme.152.1593090871469; 
 Thu, 25 Jun 2020 06:14:31 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
 by smtp.gmail.com with ESMTPSA id 30sm28006922wrm.74.2020.06.25.06.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 06:14:30 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 04/15] arm64: kvm: Use build-time defines in has_vhe()
Date: Thu, 25 Jun 2020 14:14:09 +0100
Message-Id: <20200625131420.71444-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
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

Build system compiles hyp code with macros specifying if the code belongs
to VHE or nVHE. Use these macros to evaluate has_vhe() at compile time.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/virt.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 5051b388c654..09977acc007d 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -85,10 +85,17 @@ static inline bool is_kernel_in_hyp_mode(void)
 
 static __always_inline bool has_vhe(void)
 {
-	if (cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN))
+	/*
+	 * The following macros are defined for code specic to VHE/nVHE.
+	 * If has_vhe() is inlined into those compilation units, it can
+	 * be determined statically. Otherwise fall back to caps.
+	 */
+	if (__is_defined(__KVM_VHE_HYPERVISOR__))
 		return true;
-
-	return false;
+	else if (__is_defined(__KVM_NVHE_HYPERVISOR__))
+		return false;
+	else
+		return cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN);
 }
 
 #endif /* __ASSEMBLY__ */
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
