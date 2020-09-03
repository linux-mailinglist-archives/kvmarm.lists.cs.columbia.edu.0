Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A39525BE3A
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 11:17:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E6D94B1C9;
	Thu,  3 Sep 2020 05:17:55 -0400 (EDT)
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
	with ESMTP id nY3xg1Id6vln; Thu,  3 Sep 2020 05:17:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E8274B256;
	Thu,  3 Sep 2020 05:17:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CEFC84B0F9
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 05:17:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uK0ZPqABzj23 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 05:17:48 -0400 (EDT)
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C38314B152
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 05:17:48 -0400 (EDT)
Received: by mail-ej1-f65.google.com with SMTP id a15so2779406ejf.11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 03 Sep 2020 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lr26ux0OOjKqBElJON72X2bDuUHIIFflkukJO3BWbvU=;
 b=ibaN6UVuyMWanD/p/syhzRmTyFuupe1wk12IPBNXGichEgTkklyUUzy7oxzAUVwF14
 5bnjjmfHLlMy5ji9KSMCLbP7UER0UcEHRPFkukXNMEJrAXyWkKKhNA6xGa5CjZ55qrBn
 M1JIPvdv5M1d5OYPv0nEEBa9+CWY76zMCqtZxvvUXWq+fTYMqlOYzh0VOa8DBh4sIxIU
 gPAB3kITbTsjqhMnV9JKcuqDcJEd+mL27vzwiNl8NSdIRVhBbvONoim/RFqzbpZ1zGDX
 KdUU4dB2O45UnNf3T4r/QYNBddgXEb080EB4ixmCZwI96W4HF9pMuBnfG+4vo77c214P
 +hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lr26ux0OOjKqBElJON72X2bDuUHIIFflkukJO3BWbvU=;
 b=USRZHQJc+6QGETeEns1/ENox74OT5XjG55PJtsnwkzdVhdjuoVaYoUmuUfVOHoU47j
 L6etD1ElM0+NVkZGNEAVBc86lGcJD6yzgJ3C+QTjWEPtGSCwp1Q0UW1lFWg7015RqJDA
 ongbTLN3tKxWAJr8bmiExyizEgr4CYfrKifPOmNF0LRksOTgAq6BWefClPsia9a/fODT
 TKSV9XRcv4oAY94icEKewh8LlP3HtfltoucIolVacFGElQlIKKi5BTCDPbp6BzSQnMiD
 M1yyv29skrZssuh8RKGg8tD6kz8CGUjJBqecbSGUJEScINl56HmrxQmvDRHX07gRU3b9
 /5BQ==
X-Gm-Message-State: AOAM5328RK8/f2blg/e7HRkTV4Zo27QFju9IcEIEPElS/S6Fr/znMAnf
 41w5bpkusSS49bRNq5VeG9iycA==
X-Google-Smtp-Source: ABdhPJzEdTeSQp0oSfef6z3rNf21sKeagThs669GopkjjafQDEK3m3QDA/V0e2Zh7SmEpjSfWGhgLw==
X-Received: by 2002:a17:906:5856:: with SMTP id
 h22mr1120110ejs.480.1599124667692; 
 Thu, 03 Sep 2020 02:17:47 -0700 (PDT)
Received: from localhost
 (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz.
 [2a00:1028:919a:a06e:64ac:36:822c:68d3])
 by smtp.gmail.com with ESMTPSA id gw6sm2638439ejb.47.2020.09.03.02.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 02:17:46 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 05/10] kvm: arm64: Add helpers for accessing nVHE hyp
 per-cpu vars
Date: Thu,  3 Sep 2020 11:17:07 +0200
Message-Id: <20200903091712.46456-6-dbrazdil@google.com>
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

Defining a per-CPU variable in hyp/nvhe will result in its name being
prefixed with __kvm_nvhe_. Add helpers for declaring these variables
in kernel proper and accessing them with this_cpu_ptr and per_cpu_ptr.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 469c0662f7f3..2b89817cdb01 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -60,9 +60,21 @@
 	DECLARE_KVM_VHE_SYM(sym);		\
 	DECLARE_KVM_NVHE_SYM(sym)
 
+#define DECLARE_KVM_VHE_PER_CPU(type, sym)	\
+	DECLARE_PER_CPU(type, sym)
+#define DECLARE_KVM_NVHE_PER_CPU(type, sym)	\
+	DECLARE_PER_CPU(type, kvm_nvhe_sym(sym))
+
+#define DECLARE_KVM_HYP_PER_CPU(type, sym)	\
+	DECLARE_KVM_VHE_PER_CPU(type, sym);	\
+	DECLARE_KVM_NVHE_PER_CPU(type, sym)
+
 #define CHOOSE_VHE_SYM(sym)	sym
 #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
 
+#define this_cpu_ptr_nvhe(sym)		this_cpu_ptr(&kvm_nvhe_sym(sym))
+#define per_cpu_ptr_nvhe(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
+
 #ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * BIG FAT WARNINGS:
@@ -75,12 +87,21 @@
  * - Don't let the nVHE hypervisor have access to this, as it will
  *   pick the *wrong* symbol (yes, it runs at EL2...).
  */
-#define CHOOSE_HYP_SYM(sym)	(is_kernel_in_hyp_mode() ? CHOOSE_VHE_SYM(sym) \
+#define CHOOSE_HYP_SYM(sym)		(is_kernel_in_hyp_mode()	\
+					   ? CHOOSE_VHE_SYM(sym)	\
 					   : CHOOSE_NVHE_SYM(sym))
+#define this_cpu_ptr_hyp(sym)		(is_kernel_in_hyp_mode()	\
+					   ? this_cpu_ptr(&sym)		\
+					   : this_cpu_ptr_nvhe(sym))
+#define per_cpu_ptr_hyp(sym, cpu)	(is_kernel_in_hyp_mode()	\
+					   ? per_cpu_ptr(&sym, cpu)	\
+					   : per_cpu_ptr_nvhe(sym, cpu))
 #else
 /* The nVHE hypervisor shouldn't even try to access anything */
 extern void *__nvhe_undefined_symbol;
-#define CHOOSE_HYP_SYM(sym)	__nvhe_undefined_symbol
+#define CHOOSE_HYP_SYM(sym)		__nvhe_undefined_symbol
+#define this_cpu_ptr_hyp(sym)		(&__nvhe_undefined_symbol)
+#define per_cpu_ptr_hyp(sym, cpu)	(&__nvhe_undefined_symbol)
 #endif
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
-- 
2.28.0.402.g5ffc5be6b7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
