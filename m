Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C1AA7659706
	for <lists+kvmarm@lfdr.de>; Fri, 30 Dec 2022 10:55:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 56A9D4B615;
	Fri, 30 Dec 2022 04:55:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered)
	header.i=@daynix-com.20210112.gappssmtp.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X3orluwz7Xzo; Fri, 30 Dec 2022 04:55:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0C614B601;
	Fri, 30 Dec 2022 04:55:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A06464B286
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Dec 2022 04:55:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMdvYBm-q2Wp for <kvmarm@lists.cs.columbia.edu>;
 Fri, 30 Dec 2022 04:55:24 -0500 (EST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 85EAD4B628
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Dec 2022 04:55:24 -0500 (EST)
Received: by mail-pj1-f50.google.com with SMTP id v23so21789599pju.3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Dec 2022 01:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlWUJTvQq+dZLt1EiuVf3fldzhye5smOXD/qjtYfqYw=;
 b=q8gfFC2rx20mZ8f21CGm8m6P3RgItI4xjQEcG4ZFyFoA1/rqgjhzRZGPTQQOsGaq0w
 JLVSBYqLkrlkfVmySikCPck0cjomgaAd+gpSF3PXEP5Uyin0foTd7CIyHB5EBCIJ+9d5
 rZZkzquT1bvA7a7iomZBitMmehYHU62TgrFJ3Qrb5WN2tHd4195cyEt76t/WkKdvy9t0
 bvZ43yf7TcFmdi6Uc5jbVuZHjp4JSNcM7Z/SdUNg19uu/PfKC0EIxdqL3QFS4fZA/HSY
 DZ/q0pnYUJaHcQ6tqhxxwbs6bSdWWasEQ6DF74zPw8uM/Ai1/lew+a/Wv8mRoVQ5rR/K
 vS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlWUJTvQq+dZLt1EiuVf3fldzhye5smOXD/qjtYfqYw=;
 b=EOeWJ1L1IQCmhJk/pdIBNMJL5Plmm17+e1uIL5SfBlqypPk+rIfeFQvzWKVJztzHTi
 qqG9k/3BWXITlHSAT7OTUVT1kXumRy4c0DOyXhvx8Y+tqmcggNQsfwnnrv+pD1KuJbbO
 AmfLRz37VALT+wkxdYUm+bHNmL+FmyWNTJvWocPnbqXSieqeKqgp+0T/5gd3l8VmBb4e
 mXxp3VxG+Njv5WwEdlW6PaVcnDEINVZPWFu3YQr2oTmiI37Hjd1eo6lrf/gi3rSp58n1
 KCcQU+YmbuLIWdyS/ETQqcT9V2dQrqO4ejdhkajTy17aUXAlc10/DRCShgfHeeXLdosB
 MMOw==
X-Gm-Message-State: AFqh2kqL8GpdIjR4CD4ZAUetN8lYklbcWC6hLHvZ4aafCv7rDNZgE0Tu
 lyJIqDzFbjD5P3W1850MDwWEHA==
X-Google-Smtp-Source: AMrXdXt2wFAYM+BYT46pbundxQWM4pSsWH6zvrxdrN1FlBVVyA/LCeYCxWgdfk9ZZzLdSfoQsWgauA==
X-Received: by 2002:a17:903:1306:b0:192:5ec4:c439 with SMTP id
 iy6-20020a170903130600b001925ec4c439mr24986835plb.16.1672394124246; 
 Fri, 30 Dec 2022 01:55:24 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a170902650700b00189c536c72asm14487719plk.148.2022.12.30.01.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Dec 2022 01:55:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Subject: [PATCH v5 6/7] KVM: arm64: Mask FEAT_CCIDX
Date: Fri, 30 Dec 2022 18:54:51 +0900
Message-Id: <20221230095452.181764-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230095452.181764-1-akihiko.odaki@daynix.com>
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
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

The CCSIDR access handler masks the associativity bits according to the
bit layout for processors without FEAT_CCIDX. KVM also assumes CCSIDR is
32-bit where it will be 64-bit if FEAT_CCIDX is enabled. Mask FEAT_CCIDX
so that these assumptions hold.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/sys_regs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f4a7c5abcbca..aeabf1f3370b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1124,6 +1124,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
 						      ID_DFR0_PERFMON_SHIFT,
 						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_4 : 0);
 		break;
+	case SYS_ID_AA64MMFR2_EL1:
+		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
+		break;
+	case SYS_ID_MMFR4_EL1:
+		val &= ~ARM64_FEATURE_MASK(ID_MMFR4_CCIDX);
+		break;
 	}
 
 	return val;
@@ -1605,6 +1611,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
@@ -2106,6 +2113,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 
 	{ Op1(1), CRn( 0), CRm( 0), Op2(0), access_ccsidr },
 	{ Op1(1), CRn( 0), CRm( 0), Op2(1), access_clidr },
+
+	/* CCSIDR2 */
+	{ Op1(1), CRn( 0), CRm( 0),  Op2(2), undef_access },
+
 	{ Op1(2), CRn( 0), CRm( 0), Op2(0), access_csselr, NULL, CSSELR_EL1 },
 };
 
-- 
2.38.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
