Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 66CED428215
	for <lists+kvmarm@lfdr.de>; Sun, 10 Oct 2021 16:57:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 166594B0DB;
	Sun, 10 Oct 2021 10:57:03 -0400 (EDT)
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
	with ESMTP id cseCIhwDSL1d; Sun, 10 Oct 2021 10:57:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA0244B13A;
	Sun, 10 Oct 2021 10:57:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5001F4B11B
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 Oct 2021 10:57:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3rTz626M8V9 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 10 Oct 2021 10:56:59 -0400 (EDT)
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 04C9E49FB7
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 Oct 2021 10:56:59 -0400 (EDT)
Received: by mail-wr1-f74.google.com with SMTP id
 e12-20020a056000178c00b001606927de88so11160661wrg.10
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 Oct 2021 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=NjmzICmgs/1/SRU9S1PIoFoU/QO2NcwvWdQNYWVlfS8=;
 b=qJXoTWLIck34aUq2vWI+yRaH1p2dPNKc5RilSQ2TjF15hJYVdQuO5LFwBiwz2+s7qL
 qxbP45kiEkCMKWlfQnu0m2Ry0UozRA/bQwdyQBMnYT2sR9IB7G/hdRavPrAKAzpQ1wLk
 mCYRuz3EEmXPvrUPcSUfqr4t9T97djcmNdiProPKbbscCqxiiSgwL7Ov9itNNYvmbuVy
 RaLpTyex5ZZ8iJc6mYhQaB8nfl44lpN2GSxh5GKhsI9iQtd9zOI1xXGC7Oh7EimAOYif
 AdVJAh6lq2JOqJuQW0F5Gx9eKRg76zaPBFYIdO9frERP5eKgKLoEgc7b36X5DA1/8/Gl
 nFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=NjmzICmgs/1/SRU9S1PIoFoU/QO2NcwvWdQNYWVlfS8=;
 b=iAqyQruG5a15hS7Cgk17mk7JkaotSm7bW+L+eIIMqmbqK8EjU32aRg5UgcNE0EWfd+
 B2Wyn/zgyNGrVlZKsXrHmEm5j1hyKoaEJteW95f61DvFBewWb/R7Xity8eKY26kM1R8h
 Ix3HMR0iR7ON+2RFesnqps2duAO5i57VAPs8GMz7Tl+7au8R0UO2jSQdKWsMkgIPTzzn
 p0rYBguPpQLmm02GDQK/UG2T6SzaTK6n5rrZqtP0CwQsZuuT7PTsHvzmgwlr5+sdty2v
 vXckwIJwLWuP+RaQ+OALP1zuJhk+FMTd8rNXzFKJyVm6ktpyBFUScFEKfdXoVMjitH5g
 8CWg==
X-Gm-Message-State: AOAM530gvC4emocub5XsIVXrAdiRgCOEq52G6spuBLsrVyEXjzdZ4lRt
 4EB+NNy6JUbFNhOyXhpj/qoEMze97DHVh59rzF/166zf0UOn6CzciKVxc3C29FTiwShLPQ7qjG8
 HlEg6TDCgLA4zDa14dfmJtP/wCzUrgO7PB+q8FkwHnmH/KA8bxhzvuLJfPaI4OfSVPLI=
X-Google-Smtp-Source: ABdhPJyaRIw2i8Vmfc3FxfbM4wwoieTXOLpMnD+P+7LcGqnctSEbohnVUEjCI/49CwnkqLd//Ok/pbYkGw==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a1c:19c4:: with SMTP id
 187mr15371722wmz.149.1633877817910; 
 Sun, 10 Oct 2021 07:56:57 -0700 (PDT)
Date: Sun, 10 Oct 2021 15:56:34 +0100
In-Reply-To: <20211010145636.1950948-1-tabba@google.com>
Message-Id: <20211010145636.1950948-10-tabba@google.com>
Mime-Version: 1.0
References: <20211010145636.1950948-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v8 09/11] KVM: arm64: Move sanitized copies of CPU features
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Move the sanitized copies of the CPU feature registers to the
recently created sys_regs.c. This consolidates all copies in a
more relevant file.

No functional change intended.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 6 ------
 arch/arm64/kvm/hyp/nvhe/sys_regs.c    | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 2a07d63b8498..f6d96e60b323 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -25,12 +25,6 @@ struct host_kvm host_kvm;
 
 static struct hyp_pool host_s2_pool;
 
-/*
- * Copies of the host's CPU features registers holding sanitized values.
- */
-u64 id_aa64mmfr0_el1_sys_val;
-u64 id_aa64mmfr1_el1_sys_val;
-
 const u8 pkvm_hyp_id = 1;
 
 static void *host_s2_zalloc_pages_exact(size_t size)
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 6e3ea49af302..6bde2dc5205c 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -21,6 +21,8 @@ u64 id_aa64pfr0_el1_sys_val;
 u64 id_aa64pfr1_el1_sys_val;
 u64 id_aa64isar0_el1_sys_val;
 u64 id_aa64isar1_el1_sys_val;
+u64 id_aa64mmfr0_el1_sys_val;
+u64 id_aa64mmfr1_el1_sys_val;
 u64 id_aa64mmfr2_el1_sys_val;
 
 /*
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
