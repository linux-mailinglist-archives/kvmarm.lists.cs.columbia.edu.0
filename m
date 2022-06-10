Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 10A92546217
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jun 2022 11:29:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 81FF14B3FC;
	Fri, 10 Jun 2022 05:29:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hOQG9RpptQp4; Fri, 10 Jun 2022 05:29:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9038A4B415;
	Fri, 10 Jun 2022 05:29:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00FA34B3D9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jun 2022 05:29:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqZDzgxs+WSr for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jun 2022 05:28:59 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 966DF4B335
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jun 2022 05:28:59 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 98E66B83354;
 Fri, 10 Jun 2022 09:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A3CC341C5;
 Fri, 10 Jun 2022 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654853337;
 bh=VMmecCnQBGsMYvAuZ5HTUn0NbyxZfCqp9Cto7QAyto4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TXLZJ8ekvp6EELQzaPCvO3grvmCVQiQQYxVFifksfwBiZ+RVfuPiYysFn/rMh12tE
 BfaZh/Py8Gbms5WLo+rDTVvt+1ErizFGSJGSsnxDIKoIPhvqsovgHIwdSJqMd35QjG
 +wgqqZixFrZFsIEtKjXxr8GO+4PFDY2KsMUzvtGLkFT6c22Rtrm8hFjcv6rFGOlc8b
 lu20MUqcKvzd+/BXERK7J62wbJ5U71G6rQRH6dinO7kqQdCPj4t0qVh0MBcyOuSBBP
 8DVYu9YY6XHpwRrf7AUkwsSxOgMBvqj2mh2qTmtIJDEhsXYXB56fApBPCTbm8rhNLw
 VN3OsGq7BFp7A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nzawp-00H6Dt-5Z; Fri, 10 Jun 2022 10:28:55 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/19] KVM: arm64: Add three sets of flags to the vcpu state
Date: Fri, 10 Jun 2022 10:28:25 +0100
Message-Id: <20220610092838.1205755-7-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220610092838.1205755-1-maz@kernel.org>
References: <20220610092838.1205755-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 will@kernel.org, tabba@google.com, qperret@google.com, broonie@kernel.org,
 reijiw@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

It so appears that each of the vcpu flags is really belonging to
one of three categories:

- a configuration flag, set once and for all
- an input flag generated by the kernel for the hypervisor to use
- a state flag that is only for the kernel's own bookkeeping

As we are going to split all the existing flags into these three
sets, introduce all three in one go.

No functional change other than a bit of bloat...

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6d30ac7e3164..af45320f247f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -335,6 +335,15 @@ struct kvm_vcpu_arch {
 	/* Miscellaneous vcpu state flags */
 	u64 flags;
 
+	/* Configuration flags, set once and for all before the vcpu can run */
+	u64 cflags;
+
+	/* Input flags to the hypervisor code, potentially cleared after use */
+	u64 iflags;
+
+	/* State flags for kernel bookkeeping, unused by the hypervisor code */
+	u64 sflags;
+
 	/*
 	 * We maintain more than a single set of debug registers to support
 	 * debugging the guest from the host and to maintain separate host and
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
