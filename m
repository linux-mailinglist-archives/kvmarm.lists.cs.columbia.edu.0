Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5124625BE3D
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 11:18:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 04CA54B260;
	Thu,  3 Sep 2020 05:18:02 -0400 (EDT)
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
	with ESMTP id P0efDVD8UMvM; Thu,  3 Sep 2020 05:18:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED4BA4B259;
	Thu,  3 Sep 2020 05:18:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D7DDC4B09A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 05:17:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K3W1tTnt5pam for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 05:17:57 -0400 (EDT)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F373F4B24E
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 05:17:56 -0400 (EDT)
Received: by mail-ed1-f65.google.com with SMTP id w1so1943148edr.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 03 Sep 2020 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SnlRtG/CWSkZI4NVeKIKEydnJw+LdVFZjKE2XgTifuQ=;
 b=hUF/wWznrhIV4kD0nNa5LDuTyvYBcRJqJRT4AjaF0cV0Cm85jlZhKS8Ka8OrV/1IAb
 3ShKef+kcOd+ghf91meHp8twmWmMTmr4i5li7S6u7jJW6COg/KwmunepQBEEG8a5QFIu
 1S2h+XyMXH330ZazXmjmCzIWyT2Qywoc6aqRJCEVxaYU4ilpOuUylSu269/RPYD7X8bP
 NjDFh5AJcfRDgrzcsJvPmljNBjZqDVaWRNQ/lIcy0aO4vsDvRiJzYGI3BUma+LFFGV1K
 2wy6oRw6OCKcrv6ifEqMw0FCTMubNFMKgTFfLp2vzTIloUIxgJ9boRrWrZ6ZZz5qUzG+
 xdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SnlRtG/CWSkZI4NVeKIKEydnJw+LdVFZjKE2XgTifuQ=;
 b=oCgsP/V+hR9JIoF5/Q17xXK50CBrGxRsBKqja2NsQft5ebGlYVRUn2S0uwyHvOjQHM
 X323cSBuLF3qHM3gfidVsQmScrAaMdEfM3QxEWWvnstebalNUteH9gy7wAufbFs+Egqk
 1GyA3Myfky8v2NUXAi/qAkfyAK9ybxGsqbqMRzHEScSJ4lRHdilZFnMtjf82Ek6++pO6
 eR1iKxaAEC80hopv5TNd3j8EVaYMvxAy80nTXESSMqIjZJ7DaELN7zHDnqIPBNkZ+hUe
 mFFVATi4SibzBYHO+p5shVRWXpO+nWKoDIT2glYvZc1TqaOp6G0dtnq18awDhIXGYUhS
 VNNQ==
X-Gm-Message-State: AOAM532LRKDEvyFvTGbHln+AXttp+vqN9n6RFbTsq9kVY+TY3eALAiVD
 0dSkeryIL/OKmU1t6Raqkuc1/w==
X-Google-Smtp-Source: ABdhPJyT2Eil9AjKw8R/4nwj3PA9MLb8SnTJe5Rd8N1txrd2cT5Dl89hJVcJvGxtWZCvckgjsovWlA==
X-Received: by 2002:aa7:dc16:: with SMTP id b22mr2013761edu.252.1599124675844; 
 Thu, 03 Sep 2020 02:17:55 -0700 (PDT)
Received: from localhost
 (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz.
 [2a00:1028:919a:a06e:64ac:36:822c:68d3])
 by smtp.gmail.com with ESMTPSA id v13sm2714856edl.9.2020.09.03.02.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 02:17:55 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 08/10] kvm: arm64: Mark hyp stack pages reserved
Date: Thu,  3 Sep 2020 11:17:10 +0200
Message-Id: <20200903091712.46456-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
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

In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
stack using new helpers which automatically mark the pages reserved.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d437052c5481..8a1fcf4dffca 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1453,13 +1453,58 @@ static int init_subsystems(void)
 	return err;
 }
 
+/*
+ * Alloc pages and mark them reserved so the kernel never tries to
+ * take them away from the hypervisor.
+ */
+static unsigned long alloc_hyp_pages(gfp_t flags, unsigned int order)
+{
+	struct page *page;
+	unsigned long i;
+
+	page = alloc_pages(flags, order);
+	if (!page)
+		return 0;
+
+	for (i = 0; i < (1ul << order); ++i)
+		mark_page_reserved(page + i);
+
+	return (unsigned long)page_address(page);
+}
+
+static unsigned long alloc_hyp_page(gfp_t flags)
+{
+	return alloc_hyp_pages(flags, 0);
+}
+
+/*
+ * Free pages which were previously marked reserved for the hypervisor.
+ */
+static void free_hyp_pages(unsigned long addr, unsigned int order)
+{
+	unsigned long i;
+	struct page *page;
+
+	if (!addr)
+		return;
+
+	page = virt_to_page(addr);
+	for (i = 0; i < (1ul << order); ++i)
+		free_reserved_page(page + i);
+}
+
+static void free_hyp_page(unsigned long addr)
+{
+	return free_hyp_pages(addr, 0);
+}
+
 static void teardown_hyp_mode(void)
 {
 	int cpu;
 
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
-		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_hyp_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
 }
 
 /**
@@ -1483,7 +1528,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		unsigned long stack_page;
 
-		stack_page = __get_free_page(GFP_KERNEL);
+		stack_page = alloc_hyp_page(GFP_KERNEL);
 		if (!stack_page) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.28.0.402.g5ffc5be6b7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
