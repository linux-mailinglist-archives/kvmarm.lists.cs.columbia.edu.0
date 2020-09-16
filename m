Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6D26C2AD
	for <lists+kvmarm@lfdr.de>; Wed, 16 Sep 2020 14:24:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E5FA4B45C;
	Wed, 16 Sep 2020 08:24:19 -0400 (EDT)
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
	with ESMTP id 1sF919oh0y19; Wed, 16 Sep 2020 08:24:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E1CB4B3FA;
	Wed, 16 Sep 2020 08:24:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E0CF4B0AD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 08:24:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oTYfskm60wUm for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Sep 2020 08:24:15 -0400 (EDT)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6918C4B45C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 08:24:15 -0400 (EDT)
Received: by mail-wr1-f68.google.com with SMTP id s12so6662857wrw.11
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yWmAHcgT2wDa3AHqlJ16t/WowuUKj+5oH128IS3to+s=;
 b=ecyvxJA9SssekdAOtuviJ13pOnV2clLGkWhiOWO+2yrKD8LW/yxDkjFG3CzSaKPwdz
 lO4l8QLk4EjgOwdsycDk3JkggZLdyWLIjx79hY9n3+KYGB1WQIAQ4FECAlbZPLNNzst2
 +V8xxssKHQL+hxHT661evNUe9qi63Lr5THWvEXVzmU8ys481d4Icv0X7UrGAWcX3Y6R6
 TW53J0GJUqSsZ/FtTU9WDgV3l69ZLSMQ+ne9CePfgEfWy5GDf3/fHWWq15NCFehU95v3
 AHJkB5O7SLJY0IhMVow1YeZiDiMLuOOGL8aCTq8O7o0OtK/8YUEzsxMcZLk6TNgC2ruT
 WwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yWmAHcgT2wDa3AHqlJ16t/WowuUKj+5oH128IS3to+s=;
 b=h+47FiU6H1oV9hE1uf+7ya+98s2FP3PU2qLlRLPzBZo8N6USzcT/LdT3jqy19yGhCH
 c4Eo9DcPsGno3UcNABZRUp7o2JWu1sMs88LYBj9t/slt1le8Vo7ucVrg+4oyY8zlPFcE
 1/lWtMuTLjxMrh7mnL852alB0/Nd0wTjDv3nkjPdkSj+xCCveouPT4A5Cd/CTt0Sk747
 AltAzfuzhjE0SuYVlm+SeaSwTPE1Pm2iNcHRdTw9qLsdeAHll1q3jQ8xZVmIRiYr4pkt
 9b3ADYclClqsioR/DLmwVnlXLwPcRTd5m2ykJXTPyejjAaSjNxY87HFwkPg6pOOsqtYD
 6d5g==
X-Gm-Message-State: AOAM530lAxq3143VXkTKbYFs165z7nIqALNs419uNG2CG0Q/DyQnq7nt
 5O/Gu/KSttgNAJfnsuBA1dUe/g==
X-Google-Smtp-Source: ABdhPJyN8ng2AKyfXE308SyYBOpK5+vw1l709E5yQIVxjKXFjVd61eroffH5kXqXdkXmnXUZ3JvTow==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr19383508wrc.71.1600259054273; 
 Wed, 16 Sep 2020 05:24:14 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
 by smtp.gmail.com with ESMTPSA id j26sm2567165wrc.79.2020.09.16.05.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:24:13 -0700 (PDT)
Date: Wed, 16 Sep 2020 13:24:12 +0100
From: David Brazdil <dbrazdil@google.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 00/10] Independent per-CPU data section for nVHE
Message-ID: <20200916122412.elxfxbdygvmdgrj5@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200914174008.GA25238@willie-the-truck>
 <20200916115404.rhv4dkyjz35e4x25@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916115404.rhv4dkyjz35e4x25@google.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

> I was also wondering about another approach - using the PERCPU_SECTION macro
> unchanged in the hyp linker script. It would lay out a single .data..percpu and
> we would then prefix it with .hyp and the symbols with __kvm_nvhe_ as with
> everything else. WDYT? Haven't tried that yet, could be a naive idea. 

Seems to work. Can't use PERCPU_SECTION directly because then we couldn't
rename it in the same linker script, but if we just unwrap that one layer
we can use PERCPU_INPUT. No global macro changes needed.

Let me know what you think.

------8<------
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5904a4de9f40..9e6bf21268f1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -195,11 +195,9 @@ SECTIONS
        PERCPU_SECTION(L1_CACHE_BYTES)

        /* KVM nVHE per-cpu section */
-       #undef PERCPU_SECTION_NAME
-       #undef PERCPU_SYMBOL_NAME
-       #define PERCPU_SECTION_NAME(suffix)     CONCAT3(.hyp, PERCPU_SECTION_BASE_NAME, suffix)
-       #define PERCPU_SYMBOL_NAME(name)        __kvm_nvhe_ ## name
-       PERCPU_SECTION(L1_CACHE_BYTES)
+       . = ALIGN(PAGE_SIZE);
+       .hyp.data..percpu : { *(.hyp.data..percpu) }
+       . = ALIGN(PAGE_SIZE);

        .rela.dyn : ALIGN(8) {
                *(.rela .rela*)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 7d8c3fa004f4..1d8e4f7edc29 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -4,6 +4,10 @@
  * Written by David Brazdil <dbrazdil@google.com>
  */

+#include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
+#include <asm/memory.h>
+
 /*
  * Defines an ELF hyp section from input section @NAME and its subsections.
  */
@@ -11,9 +15,9 @@

 SECTIONS {
        HYP_SECTION(.text)
-       HYP_SECTION(.data..percpu)
-       HYP_SECTION(.data..percpu..first)
-       HYP_SECTION(.data..percpu..page_aligned)
-       HYP_SECTION(.data..percpu..read_mostly)
-       HYP_SECTION(.data..percpu..shared_aligned)
+
+       .hyp..data..percpu : {
+               __per_cpu_load = .;
+               PERCPU_INPUT(L1_CACHE_BYTES)
+       }
 }
-----8<------

David
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
