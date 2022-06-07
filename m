Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 35BFF536C8D
	for <lists+kvmarm@lfdr.de>; Sat, 28 May 2022 13:38:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF5F74B34E;
	Sat, 28 May 2022 07:38:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nbId7hwa2o2T; Sat, 28 May 2022 07:38:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B22184B382;
	Sat, 28 May 2022 07:38:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CF14D4B332
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 May 2022 07:38:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtdVb0dDo71z for <kvmarm@lists.cs.columbia.edu>;
 Sat, 28 May 2022 07:38:38 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8344D4B32E
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 May 2022 07:38:38 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E65D360EB5;
 Sat, 28 May 2022 11:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35E1C34116;
 Sat, 28 May 2022 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653737917;
 bh=EKftBCiDNzOcsTbdBZRP7gXNXU5G2xgQTq3/6/LAjDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t9LuTHK0YXjzCp6+iiPQH03rRe6PoMIiN+YWV3HzZMz48rMbPGfHBoSPr5XObeJlG
 Y95ZfucaxjrWEnKWYOcR1r644yt/noTn0Z6g242b+vIenqmZVPl9d9OnWzx/Oetbwb
 UDoVHBTnK76m72+Kdj3BVZAQii3h1GxZhZV9d3e1n8smYoK5jPn+5IdWwL0GlQLP+n
 98Ln/C5a47khU7vKDGg5F08eKV4O0/UMpTPZs6kYuPJhwVQtZB/M72YS5YN8QanVcU
 0nidkTyblXIC+Cs7Upaafz3raEC/PXo7xXAwF+b2J+mkGs5+iexBICh0SWxftLirVQ
 +y6by45j6PnBg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nuumA-00EEGh-SH; Sat, 28 May 2022 12:38:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/18] KVM: arm64: Add three sets of flags to the vcpu state
Date: Sat, 28 May 2022 12:38:16 +0100
Message-Id: <20220528113829.1043361-7-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220528113829.1043361-1-maz@kernel.org>
References: <20220528113829.1043361-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 will@kernel.org, tabba@google.com, qperret@google.com, broonie@kernel.org,
 kernel-team@android.com
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

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5eb6791df608..c9dd0d4e22f2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -338,6 +338,15 @@ struct kvm_vcpu_arch {
 	/* Miscellaneous vcpu state flags */
 	u64 flags;
 
+	/* Configuration flags */
+	u64 cflags;
+
+	/* Input flags to the hypervisor code */
+	u64 iflags;
+
+	/* State flags, unused by the hypervisor code */
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
