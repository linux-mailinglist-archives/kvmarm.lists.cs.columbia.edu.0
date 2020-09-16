Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 267FF26C629
	for <lists+kvmarm@lfdr.de>; Wed, 16 Sep 2020 19:35:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CDDA54B329;
	Wed, 16 Sep 2020 13:35:11 -0400 (EDT)
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
	with ESMTP id Heca0I+W--+N; Wed, 16 Sep 2020 13:35:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 666B54B514;
	Wed, 16 Sep 2020 13:35:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A61A4B329
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 13:35:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vVHmC9y2+Xh6 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Sep 2020 13:35:07 -0400 (EDT)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5009A4B3D6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 13:35:07 -0400 (EDT)
Received: by mail-wm1-f65.google.com with SMTP id s13so3560670wmh.4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3ZouLpoLHZGhnRn3IE3lAdYTtqQtOaDPWcW0BXT72MM=;
 b=HNZo35gC+J7olQM/J4RAmLlZS6QxVf8SG/2BDEI9P1bohZ+P5Q96wTZVwc7II0n9BL
 cgE7q3s2HuB8SyeYAwP76jfvS9ilgnaSdWf3BN5CpaP3PpCWpHo7OyCzXoLczzUjYIh+
 TAvf72HVFbYYjUfwXRs9KQWyCZzjv5SmQjRTwHXgeAoUK3/2zXTwbrvIkPx4Um1P5RvS
 TU1N+Ppw0DKArVS8ynQ4bf+jV171VTr1y4ZU53me1jkwW1cniiMaCioHU1u/AMChZdp6
 1BnnWaIQvyESEBhMsuSyugrLCEkTdp5crIYFCA9FneqGow+l1YuEeHkCEHhBbzEX3vON
 E0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3ZouLpoLHZGhnRn3IE3lAdYTtqQtOaDPWcW0BXT72MM=;
 b=frW/W6KpbmdzBGZbkgoFd0mP80EqVmKQ5lWjBghqCQ3gmSyUNX/mnI8i9pJ0gQ6x6T
 Lsshnn9+l/KyoR6YHbWtoEP85cmi3L6a6R4l5rsmmGVDh5oBZLnth3WslLLRHim5vVbm
 cRP3f8VEPZvUugWPKnKWBljcyDgyjXCEp1mvvLXD48UryVIPjD+af76mn8dNVzmyO1R8
 VRloQXRZl0N26kpXECI9H3ouI73jOyAA1HV1074L/U8rO4fphF1v+/SgFjVxtoCCtPHm
 HxSrFFZUryjKZE93LSg5IsZRDE45lmvZwoIm7SV0CWM46Bv77o/Ad2JWyG1rz4a1KABP
 xQNg==
X-Gm-Message-State: AOAM530pJ/7MELGE9DHvO1FRgXg79XfFPwSyp1642yXBZpinIayGt5K5
 uuLb/4q3aHJdqt8kb8nTQyGfHlb4CgHAPvVb
X-Google-Smtp-Source: ABdhPJyjAeHVuIWwfCgiltujOqCdZJciMMvPMbdeAr38UjlrUERhWuN+mDjxXhXo26gYVThTzJRNbg==
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr6233481wmu.156.1600277702955; 
 Wed, 16 Sep 2020 10:35:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
 by smtp.gmail.com with ESMTPSA id p1sm8808360wma.0.2020.09.16.10.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 10:35:01 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 09/11] kvm: arm64: Mark hyp stack pages reserved
Date: Wed, 16 Sep 2020 18:34:37 +0100
Message-Id: <20200916173439.32265-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
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

In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
stack using new helpers which automatically mark the pages reserved.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7af9809fa193..58d7d614519b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1456,13 +1456,58 @@ static int init_subsystems(void)
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
@@ -1486,7 +1531,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		unsigned long stack_page;
 
-		stack_page = __get_free_page(GFP_KERNEL);
+		stack_page = alloc_hyp_page(GFP_KERNEL);
 		if (!stack_page) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
