Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 413CB46538A
	for <lists+kvmarm@lfdr.de>; Wed,  1 Dec 2021 18:04:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E7D3B4B242;
	Wed,  1 Dec 2021 12:04:38 -0500 (EST)
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
	with ESMTP id bCdb-IdNCabH; Wed,  1 Dec 2021 12:04:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B40174B22A;
	Wed,  1 Dec 2021 12:04:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E68834B204
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Dec 2021 12:04:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0tZlSCXW2F-m for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Dec 2021 12:04:34 -0500 (EST)
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7313E4B1F5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Dec 2021 12:04:34 -0500 (EST)
Received: by mail-wm1-f73.google.com with SMTP id
 g80-20020a1c2053000000b003331a764709so149060wmg.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 01 Dec 2021 09:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=R4aAsZuEycX7jTv8i7SIMGlzcxlZQ+O2BggkYaTuEjA=;
 b=plQ5ysBljc0xG5cfba5Qiw3VOO5L5djBwH2KOMSeq2bRcSiUiqowbYb2+TW5TZ1dcR
 cZWPWJlgzX7jmmLaQ4ByFFTPnDp+JrwbYmQ0pJu3qL0LL5Eo+xr1+5IlSuQo/beLH3qI
 JiGvDzHNZtcTCeCYXNMRt2Eu49Ss2ylezV25kVj0ijXktXiPryN7T1mPUMkDLUYRtoQ9
 g5ziLntuM1OC00Zp1xER7Mdxpwh5cZbTWq+fg+F47gsCCyqUZ4vYXt6mWjWGzETLnuhs
 TFuCujebbXw0EIIYAgEOWZZVUNMrvnHiz1yf1Alt6UryT32jt7vGzOKDYq+Al4/E+S/J
 tosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=R4aAsZuEycX7jTv8i7SIMGlzcxlZQ+O2BggkYaTuEjA=;
 b=BUhSGCcAroTuPcvR8Vu1DBjt9iMdaK5mNrKklPAsCMbwd7lfVSu624B740cNklCHSj
 5I1aPCXtC+4CIJry20m5YRzdQMJX+glQ9Z5pxBrec+bsqDB0wmHt1ESFL6VKNdyNaTv0
 N6z3ghwGNZFawTZAq5XpoYS9jYQTbW6wh69MVUGfBudhGn5kz5sq3C3RtoYDm5WP6g29
 yUnW5h/V2r7uTgB9QV9t6RNDI6Dw/z69rMHKbbzx88c6vhyVtqledgzi3sqEiV+6jIIr
 qaG45Y+uoYghwRNNNbRRkigs1e+jDvs2SQaSOCRyBJkjKJx5sWBwltEYeDGGaP4WQ9A/
 fu7A==
X-Gm-Message-State: AOAM533V+jWJp89bwEihRZgKQEqbwpE8YyPLIaH5vz34JFSBLa39FKrt
 0flNfRvMh9ysnqcuqBghI5olLlsF/y/+
X-Google-Smtp-Source: ABdhPJzQigV4hbaNpX4iucPZvGwYvAo/hfN1TJ3QONjwQcFMPn8kkHe0dIUY1NGAIghVVqO5zssHeXhuINPH
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:4e02:: with SMTP id
 b2mr8493849wmq.105.1638378273705; Wed, 01 Dec 2021 09:04:33 -0800 (PST)
Date: Wed,  1 Dec 2021 17:03:59 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-6-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 05/15] KVM: arm64: Hook up ->page_count() for hypervisor
 stage-1 page-table
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

kvm_pgtable_hyp_unmap() relies on the ->page_count() function callback
being provided by the memory-management operations for the page-table.

Wire up this callback for the hypervisor stage-1 page-table.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 875b5174342f..855a19056627 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -257,6 +257,7 @@ void __noreturn __pkvm_init_finalise(void)
 		.virt_to_phys = hyp_virt_to_phys,
 		.get_page = hpool_get_page,
 		.put_page = hpool_put_page,
+		.page_count = hyp_page_count,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
