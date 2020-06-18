Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D32291FF192
	for <lists+kvmarm@lfdr.de>; Thu, 18 Jun 2020 14:26:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F7C94B142;
	Thu, 18 Jun 2020 08:26:00 -0400 (EDT)
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
	with ESMTP id gkOdSUPFpdYt; Thu, 18 Jun 2020 08:25:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 61D9C4B15D;
	Thu, 18 Jun 2020 08:25:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F8704B17F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 08:25:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gzJqk8U5ZiKj for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Jun 2020 08:25:56 -0400 (EDT)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B4654B17B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 08:25:55 -0400 (EDT)
Received: by mail-wr1-f66.google.com with SMTP id t13so3417381wrs.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9UqUeY7OXLgzhtG0HSCI0KGyw2fojhVrUyAizWtz3uQ=;
 b=lDL+1M12TpapBiE/BxxPn7H/Zdg//ebIYbJekkz1AV0ZryE1ikhGJ5S23TJI3xERzk
 4VVo1NVYtqQQ9io/3n17rVZorxQ9hPbukspNmDlfaI201Arw7MDytSRjgsfWxCgQIjrO
 v5VNJRuIhv08aJGwKRn/Q74a80Gs0DKvQn0oa9bycdXCe5JH2D6sYktAaqxQC9rv+tma
 gnM9hF6A9VlmIvGMFAnurXHJedhdR2pEHgINA7A81uqJKqgzZgjRE4XVIzDOs+5YXMnC
 dyvhAbfkN+IHx2AactUh9w6/nvIPTHquaz6kXgqjknUS+4TILH16apm8+74uWp3+5oZ4
 HzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9UqUeY7OXLgzhtG0HSCI0KGyw2fojhVrUyAizWtz3uQ=;
 b=kLtEE7ARHxQR26vkVIDAKhJ4f3NtOfCYlBdffV4yoMzPLIHSKfBk2PiZpi8dH//UBs
 pvxIuxZKkh5yu+GWqVzJ/5UqLeFdQRP2KRuk1jb5Vq1q3/331OFi54+4w+LmvknXsO30
 W15ULBFL7KITUVSIX+Hr3GaflQ+Yypsqz2Mb/h5hbYIuDIsIfzi9dwWGxT1zNOpZvuTj
 aOhysPGuWBPQ+lx6NC7p0QC2OYY0yHNAlDNfF4xyo2A7Hb48B3+wa4u005hn0b8fjHbJ
 CXQy73c0uphdJQHwl7uYg9NhjnwYmEHMa/OmzoM6TQ38RjBICoO1ZVRquad9XtPWrn8Z
 FIUA==
X-Gm-Message-State: AOAM53052pYPrz4fZgf+KGcbflMaFrifavKQVo74oX8OTY9ccvru1B66
 +x2P5uA+rg1ESdOe8I5qIj02MQ==
X-Google-Smtp-Source: ABdhPJzcWJJmllc8nXAIXAc3nGaGVvG8RkpVHVgkWk2PFkI55fnUiJ1XjM/incD87Yee3o8Ny+J3vQ==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr4427208wrw.6.1592483154144;
 Thu, 18 Jun 2020 05:25:54 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
 by smtp.gmail.com with ESMTPSA id u13sm3336611wrp.53.2020.06.18.05.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 05:25:53 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 03/15] arm64: kvm: Add build rules for separate nVHE object
 files
Date: Thu, 18 Jun 2020 13:25:25 +0100
Message-Id: <20200618122537.9625-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: android-kvm@google.com, linux-kernel@vger.kernel.org,
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

Add new folder arch/arm64/kvm/hyp/nvhe and a Makefile for building code that
runs in EL2 under nVHE KVM.

Compile each source file into a `.hyp.tmp.o` object first, then prefix all
its symbols with "__kvm_nvhe_" using `objcopy` and produce a `.hyp.o`.
Suffixes were chosen so that it would be possible for VHE and nVHE to share
some source files, but compiled with different CFLAGS. nVHE build rules add
-D__KVM_NVHE_HYPERVISOR__.

The nVHE ELF symbol prefix is added to kallsyms.c as ignored. EL2-only symbols
will never appear in EL1 stack traces.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h   | 12 +++++++++++
 arch/arm64/kvm/hyp/Makefile      |  2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile | 35 ++++++++++++++++++++++++++++++++
 scripts/kallsyms.c               |  1 +
 4 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index be0a63ffed23..f32b406e90c0 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -51,4 +51,16 @@ __efistub__ctype		= _ctype;
 
 #endif
 
+#ifdef CONFIG_KVM
+
+/*
+ * KVM nVHE code has its own symbol namespace prefixed by __kvm_nvhe_, to
+ * isolate it from the kernel proper. The following symbols are legally
+ * accessed by it, therefore provide aliases to make them linkable.
+ * Do not include symbols which may not be safely accessed under hypervisor
+ * memory mappings.
+ */
+
+#endif /* CONFIG_KVM */
+
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 5d8357ddc234..5f4f217532e0 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -6,7 +6,7 @@
 ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 		$(DISABLE_STACKLEAK_PLUGIN)
 
-obj-$(CONFIG_KVM) += hyp.o
+obj-$(CONFIG_KVM) += hyp.o nvhe/
 obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
new file mode 100644
index 000000000000..7d64235dba62
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Kernel-based Virtual Machine module, HYP/nVHE part
+#
+
+asflags-y := -D__KVM_NVHE_HYPERVISOR__
+ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
+	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
+
+obj-y :=
+
+obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
+extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
+
+$(obj)/%.hyp.tmp.o: $(src)/%.c FORCE
+	$(call if_changed_rule,cc_o_c)
+$(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
+	$(call if_changed_rule,as_o_S)
+$(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
+	$(call if_changed,hypcopy)
+
+quiet_cmd_hypcopy = HYPCOPY $@
+      cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
+
+# KVM nVHE code is run at a different exception code with a different map, so
+# compiler instrumentation that inserts callbacks or checks into the code may
+# cause crashes. Just disable it.
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
+
+# Skip objtool checking for this directory because nVHE code is compiled with
+# non-standard build rules.
+OBJECT_FILES_NON_STANDARD := y
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 6dc3078649fa..0096cd965332 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -109,6 +109,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		".LASANPC",		/* s390 kasan local symbols */
 		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
+		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
 		NULL
 	};
 
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
