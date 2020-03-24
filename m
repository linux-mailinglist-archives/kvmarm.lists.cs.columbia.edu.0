Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 77364190B15
	for <lists+kvmarm@lfdr.de>; Tue, 24 Mar 2020 11:34:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D6F04B0AC;
	Tue, 24 Mar 2020 06:34:16 -0400 (EDT)
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
	with ESMTP id 4TlWu1GXo4Lb; Tue, 24 Mar 2020 06:34:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 820894B0B4;
	Tue, 24 Mar 2020 06:34:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BEBA4B0A3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Mar 2020 06:34:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tzRpMwtOj2M1 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Mar 2020 06:34:09 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8DB664B0DF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Mar 2020 06:34:08 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE739208E0;
 Tue, 24 Mar 2020 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585046047;
 bh=/G1FsF/xAq6LA4+vlGRopU41c40Jo/k3MSVldBBWBqk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bnr9kZinhh4mzggrkfbK8sOy0GxJGoXxquBcLG/7WT6JS6rJalSAArFkXB0HonX1g
 HofQJHJ1fPiuzd0kx50tF9kCoM/+e2ybg/7zuoDzOTEgBjGw7b5QN0e4NzoEuyzqmM
 HxjGPzdwmQVvJWurUoXzKQ6vdOLxzmReTrjXHUFM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jGgso-00FE8V-4v; Tue, 24 Mar 2020 10:34:06 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 7/7] MAINTAINERS: RIP KVM/arm
Date: Tue, 24 Mar 2020 10:33:50 +0000
Message-Id: <20200324103350.138077-8-maz@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200324103350.138077-1-maz@kernel.org>
References: <20200324103350.138077-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, olof@lixom.net,
 arnd@arndb.de, will@kernel.org, vladimir.murzin@arm.com,
 catalin.marinas@arm.com, linus.walleij@linaro.org, christoffer.dall@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 pbonzini@redhat.com, qperret@google.com, linux@arm.linux.org.uk,
 stefan@agner.ch, jan.kiszka@siemens.com, krzk@kernel.org,
 b.zolnierkie@samsung.com, m.szyprowski@samsung.com, takashi@yoshi.email,
 daniel@makrotopia.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Takashi Yoshi <takashi@yoshi.email>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Olof Johansson <olof@lixom.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
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

Drop the KVM/arm entries from the MAINTAINERS file.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a143a13e..e84a94e5a336 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9164,7 +9164,7 @@ F:	virt/kvm/*
 F:	tools/kvm/
 F:	tools/testing/selftests/kvm/
 
-KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
+KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
 M:	Marc Zyngier <maz@kernel.org>
 R:	James Morse <james.morse@arm.com>
 R:	Julien Thierry <julien.thierry.kdev@gmail.com>
@@ -9173,9 +9173,6 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.cs.columbia.edu
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
 S:	Maintained
-F:	arch/arm/include/uapi/asm/kvm*
-F:	arch/arm/include/asm/kvm*
-F:	arch/arm/kvm/
 F:	arch/arm64/include/uapi/asm/kvm*
 F:	arch/arm64/include/asm/kvm*
 F:	arch/arm64/kvm/
-- 
2.25.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
