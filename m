Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 432C3157D26
	for <lists+kvmarm@lfdr.de>; Mon, 10 Feb 2020 15:13:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA5074AC83;
	Mon, 10 Feb 2020 09:13:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X6ALUZuCddPG; Mon, 10 Feb 2020 09:13:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 373F14A7FD;
	Mon, 10 Feb 2020 09:13:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A92A4A7FE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Feb 2020 09:13:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbsRO58910Jp for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Feb 2020 09:13:32 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2BAAC4A7FD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Feb 2020 09:13:32 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 56CB32080C;
 Mon, 10 Feb 2020 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581344011;
 bh=hDXM35cw6+Es9hwKXIhTeBLspHFdiCAaxJXZ6ZUVtnQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t1CQJLS9Z4KyqqU+XoRBLlJ3iR1ZDGBQyMd8QoDRfsVt7MVH0uuHlpw2xRC5vfVwt
 bTopmDwjetKOCfKN+wf5boJ/3laaGZDsBsZVqJaZjOSPKp8I8hjibppxOyD2n73CXf
 ZMLzmY8XqKImnjsIDeVlnJYn58myWWxZBGeBldaQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j19oX-0048kH-MQ; Mon, 10 Feb 2020 14:13:29 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [RFC PATCH 2/5] arm: Remove KVM from config files
Date: Mon, 10 Feb 2020 14:13:21 +0000
Message-Id: <20200210141324.21090-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210141324.21090-1-maz@kernel.org>
References: <20200210141324.21090-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, pbonzini@redhat.com,
 Christoffer.Dall@arm.com, will@kernel.org, qperret@google.com,
 linux@arm.linux.org.uk, vladimir.murzin@arm.com, anders.berg@lsi.com,
 arnd@arndb.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Anders Berg <anders.berg@lsi.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
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

Only one platform is building KVM by default. How crazy! Remove
it whilst nobody is watching.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/configs/axm55xx_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index f53634af014b..ce10bc2af320 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -237,5 +237,3 @@ CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_SHA256=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_VIRTUALIZATION=y
-CONFIG_KVM=y
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
