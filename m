Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE940BB88
	for <lists+kvmarm@lfdr.de>; Wed, 15 Sep 2021 00:31:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 915EE4B101;
	Tue, 14 Sep 2021 18:31:44 -0400 (EDT)
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
	with ESMTP id 1dkivQYUspU1; Tue, 14 Sep 2021 18:31:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 923FD4B13B;
	Tue, 14 Sep 2021 18:31:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 297BE4B118
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 18:31:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 134rW4YBxYfm for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Sep 2021 18:31:41 -0400 (EDT)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 23A414B13A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 18:31:41 -0400 (EDT)
Received: by mail-pl1-f201.google.com with SMTP id
 r20-20020a170902be1400b0013b9a9629b7so40957pls.21
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=HPlM28T/oJ4/6Xh6FGi+9sK76pxmz7U2+VXMGXF95EA=;
 b=tmMkF1iIlgid4lE+KCI081z+kIafX017lVcJzrb5ucmqZ5rG5veS8v5u5HwYZXdp+z
 DPQjGLbCiQ+Od2qaK2fU1ClGTGViwPjMrf8G6a+hreSrSdDvmbOJdg9WCcvJI3eznihO
 hDfbf2rgTUryAbdPZNXJ1Lz9OSlAOO4yoHi0d+0j35RXV0cjNYyrULP3CcEi207DuCWS
 XiXAIVBRYGzOJSOg+RpAE8vt2EylVoS1mDPIef4+NzPiSf07EdL48rIcoIKu7la5ztSG
 PR4E/j02ore8dcGMZVzt9BJuIPUVPokgd22Pi7pEFL90fLnINykMY+Pg+KzVdrgCNFGi
 8aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=HPlM28T/oJ4/6Xh6FGi+9sK76pxmz7U2+VXMGXF95EA=;
 b=M8wANK2nh5guJpoRMFAeItBq2dzcuo/ZC+8NmOUbY2gxOUzB2bHLNd3k+EBMPPz1CC
 odb3xIzKS5KBUVJYx7PUZf57T4+OGaGAJU+VlCsRb1KtOeoyxNjk7eaNEqJawhvX4tzG
 fs312WFH6DsQ9mmiSS3GX1/DDaS2M4Zg69PlPSKJgAJ78ynM9vLZJ6dqfAToN9TfaXb+
 W6IfpkmNY0Oa2eFWt/v1fKisFVPV+xQA5gO0tL4MbYCEtB9d1NCb4kJLou/I5Yo2WuQR
 ASw84bftdSrz1vXZWS13Ga4o8YMTv+xNNTU5OCK1I+hPWiYFpr/U/J19M6gMAph+IDv0
 nB/g==
X-Gm-Message-State: AOAM533uOVNGXTCRwXlAPW0qzN87kzbB60Lz+PS6r55Zbtl+x4uQ0zKT
 DC1b1gvJY3cVeTyi57lwKA8o7F0DB7sx
X-Google-Smtp-Source: ABdhPJwijJSNntP3Ve1O0fbt6STM+Z/x8Y4JILzfiVpM8hiFewlC+opxgb5n5h3BsxgGhFmC5kJd70EctepX
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:be08:b0:134:924:1733 with SMTP id
 r8-20020a170902be0800b0013409241733mr17011901pls.64.1631658700158; Tue, 14
 Sep 2021 15:31:40 -0700 (PDT)
Date: Tue, 14 Sep 2021 22:31:07 +0000
In-Reply-To: <20210914223114.435273-1-rananta@google.com>
Message-Id: <20210914223114.435273-9-rananta@google.com>
Mime-Version: 1.0
References: <20210914223114.435273-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v7 08/15] KVM: arm64: selftests: Add support to disable and
 enable local IRQs
From: Raghavendra Rao Ananta <rananta@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Add functions local_irq_enable() and local_irq_disable() to
enable and disable the IRQs from the guest, respectively.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 .../testing/selftests/kvm/include/aarch64/processor.h  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 265054c24481..515d04a3c27d 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -172,4 +172,14 @@ static __always_inline u32 __raw_readl(const volatile void *addr)
 #define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c));})
 #define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
 
+static inline void local_irq_enable(void)
+{
+	asm volatile("msr daifclr, #3" : : : "memory");
+}
+
+static inline void local_irq_disable(void)
+{
+	asm volatile("msr daifset, #3" : : : "memory");
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
