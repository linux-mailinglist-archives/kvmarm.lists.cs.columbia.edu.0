Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA71AD92F
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 10:55:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 239244B286;
	Fri, 17 Apr 2020 04:55:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbJruSNYAv6a; Fri, 17 Apr 2020 04:55:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32F304B280;
	Fri, 17 Apr 2020 04:55:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DB8F4B281
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:55:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QEAOpq3sIWvT for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 04:55:34 -0400 (EDT)
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9AECB4B261
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:55:34 -0400 (EDT)
Received: by mail-wr1-f74.google.com with SMTP id u4so661302wrm.13
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=vGPNF491bxrDEQ4y4XdtN54K88PEEl3XpOEkc6sDiiY=;
 b=KyLN68SM05m9ISgdxUX0r8JMjqbp92zC8cWlvKlWaR+06zE/MUJb0giP74wZecvf7B
 711QOHH47Uqvv+yhaqKAE6kEGWFYWOdpG/1SK/Bp8i0oLku0Be8y+/XKMfFUGtjQJ7Ro
 YbSLlG7VpAwhZa1EBFi3kg5oTI+OGGffayyDAVtYDIWOL1XSx3Wdp27TBlfq/6P2FMy9
 gN5RXSp0MH60wvIjgM1lnG9hZ+i/PGsnHZtHWePRMGC5pZHtXkAgaOfxbwfPLXTLr24N
 WpP+N/1/OFd6fCefGrDdQQEttIZ6oVba1wMQawQLLzlkS/vbOxa6oI1USWFlmj4P/C9n
 rpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=vGPNF491bxrDEQ4y4XdtN54K88PEEl3XpOEkc6sDiiY=;
 b=gW5WhIosnbime7y8+pJNT+zyLfWGb5rPk27MssmI8AVHjlifSZMA16iMLo34WtmHx5
 j1HCbjCmO17jIohrD+BDLNj4LBIff4gPY+kgD4tNEZDxhEX22z4TMJfabT9R6MmHnohs
 VOI26atZcwYBBfCDXUFiDk1Vrn1Wz1P413T7gQVpYZxB211ia+jwP7g+xYymMVL+DfI6
 sErlIt+1/xRuHIrD4JmiZ017LjG1CEJ1/KPHyiFagAHK+IEwLeyiFslk/MKyWyHw+mZS
 4dhZQTrLwAWP1eehCr1RsmfOnDgSdpaHRptvqcH6IEZnymFULRRQ88SP1WqSuEvhRp+4
 e2DA==
X-Gm-Message-State: AGi0PuaOUC3ppEdKWcOxb3BnVfKgd2jUAct/UxfK9lb4ivyJtsESkCaq
 j12R4zi0OD/kVhqrvZBCPGJ7/x6VoQ==
X-Google-Smtp-Source: APiQypKy824y6E1JvSp/MPUyG1LdXKWUKjeGZ5dIIZQQzBzxL21EP9wCo1moneOV3TKVCF2WJPLWxhXugw==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr2695329wrt.126.1587113733399; 
 Fri, 17 Apr 2020 01:55:33 -0700 (PDT)
Date: Fri, 17 Apr 2020 09:55:20 +0100
In-Reply-To: <20200417085522.150701-1-tabba@google.com>
Message-Id: <20200417085522.150701-3-tabba@google.com>
Mime-Version: 1.0
References: <20200417085522.150701-1-tabba@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH 2/4] KVM: arm64: Update help text
From: Fuad Tabba <tabba@google.com>
To: catalin.marinas@arm.com, maz@kernel.org, julien.thierry.kdev@gmail.com, 
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu
Cc: will@kernel.org
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

From: Will Deacon <will@kernel.org>

arm64 KVM supports 16k pages since commit 02e0b7600f83
("arm64: kvm: Add support for 16K pages"), so update the Kconfig help
text accordingly.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index ce724e526689..d2cf4f099454 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -44,8 +44,6 @@ config KVM
 	select TASK_DELAY_ACCT
 	---help---
 	  Support hosting virtualized guest machines.
-	  We don't support KVM with 16K page tables yet, due to the multiple
-	  levels of fake page tables.
 
 	  If unsure, say N.
 
-- 
2.26.0.110.g2183baf09c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
