Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5925BE34
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 11:17:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 629DE4B225;
	Thu,  3 Sep 2020 05:17:45 -0400 (EDT)
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
	with ESMTP id j12enEdMK096; Thu,  3 Sep 2020 05:17:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F3104B222;
	Thu,  3 Sep 2020 05:17:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 676074B20D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 05:17:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09iImNj8CXNw for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 05:17:42 -0400 (EDT)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ED3114B1C9
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 05:17:40 -0400 (EDT)
Received: by mail-ej1-f67.google.com with SMTP id e23so2853816eja.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 03 Sep 2020 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zNvDbfBdNwTHuqwmJ87zZAgkBHe207JszB0bJn56FTQ=;
 b=bKVLGacayIn54nHdLPKqW3i8uEBaZAwki24ZWWmC6StEw8/dwhS84EJljmlUfqPDzN
 os8Cz89rtKYRMOQozzZ6QHFUcakWPYFWt85KojPT2HEAJ5vAzQvf8RVMU4xH/NRXfvG1
 3bdX7bTf8sgCIGmRYkuDw3RUrax3VG60ypb2xKs8gIochB3Zkg1ZfP4oG2oGGUEX4ZtS
 S1DaMW7NxbxZ4GQrSBQL+3bYpDlVEz1Xcf2zT3DD55F6UuPfyc7VljV1HOWLMd6nT1bg
 bYSJOwJm6ojHGXX5B8rzmyp0EZhWXLVr9dl6F6VT7JHKmVgtrZYrBcaNOk77rMkhzTW/
 C3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zNvDbfBdNwTHuqwmJ87zZAgkBHe207JszB0bJn56FTQ=;
 b=KAp3VszTXaiiqn2uXmJ2vi9a1AHK1eAPq7Fumh4qQeVCnboYsSzYMZuMBQQuOvJ7xP
 FHbt8EXkTaE6cEAPCW4sRVp7CJ6fHsX8rjOupvM5DDg8SNv1lmNKWFdFG1AZQ6GVh/4K
 cxjIk3VetYGG11K2+n8IJo+HwMBKKhQcA8Xt+aNMJ+BZKvGC9uISMqSrhgpmWmrnGqED
 zEPp1ibomAM9O8PG9PB0IeIm5V/aYlY4OfNT/CkRq5EXktWItStrtsoRPuKrSOixqbdI
 wJGewRAdTEE51mCS/mhzbhM5UxFXBsR8nmaiqzOykXVHFI/92lrKmH8mzuX2cXCdEtZ1
 YTig==
X-Gm-Message-State: AOAM533K/w2eNrCze5tBthFWUcHY1pDkPLaFWJbcOOGkNjXJDJIybuwv
 SsnELpyBZRGemzKzVrEr7AbWSg==
X-Google-Smtp-Source: ABdhPJxjc2flZ0tLE+wu0DM0G8WaozAnEsLB5cW424g4zHnmjkJ4t03cn83T3cbh6pDJJ5h5XXDJhQ==
X-Received: by 2002:a17:906:3955:: with SMTP id
 g21mr1170038eje.69.1599124659856; 
 Thu, 03 Sep 2020 02:17:39 -0700 (PDT)
Received: from localhost
 (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz.
 [2a00:1028:919a:a06e:64ac:36:822c:68d3])
 by smtp.gmail.com with ESMTPSA id g19sm2670317ejz.5.2020.09.03.02.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 02:17:38 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 02/10] kvm: arm64: Partially link nVHE hyp code,
 simplify HYPCOPY
Date: Thu,  3 Sep 2020 11:17:04 +0200
Message-Id: <20200903091712.46456-3-dbrazdil@google.com>
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

Previous series introduced custom build rules for nVHE hyp code, using
objcopy to prefix ELF section and symbol names to separate nVHE code
into its own "namespace". This approach was limited by the expressiveness
of objcopy's command line interface, eg. missing support for wildcards.

Improve the build rules by partially linking all '.hyp.o' files and
prefixing their ELF section names using a linker script. Continue using
objcopy for prefixing ELF symbol names.

One immediate advantage of this approach is that all subsections
matching a pattern can be merged into a single prefixed section, eg.
.text and .text.* can be linked into a single '.hyp.text'. This removes
the need for -fno-reorder-functions on GCC and will be useful in the
future too: LTO builds use .text subsections, compilers routinely
generate .rodata subsections, etc.

Partially linking all hyp code into a single object file also makes it
easier to analyze.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile  | 56 ++++++++++++++++---------------
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S | 14 ++++++++
 2 files changed, 43 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index aef76487edc2..1b2fbb19f3e8 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -10,40 +10,42 @@ obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
 
-obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
-extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
+##
+## Build rules for compiling nVHE hyp code
+## Output of this folder is `hyp.o`, a partially linked object file containing
+## all nVHE hyp code and data.
+##
 
-$(obj)/%.hyp.tmp.o: $(src)/%.c FORCE
+hyp-obj := $(patsubst %.o,%.hyp.o,$(obj-y))
+obj-y := hyp.o
+extra-y := $(hyp-obj) hyp.tmp.o hyp.lds
+
+# 1) Compile all source files to `.hyp.o` object files. The file extension
+#    avoids file name clashes for files shared with VHE.
+$(obj)/%.hyp.o: $(src)/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
-$(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
+$(obj)/%.hyp.o: $(src)/%.S FORCE
 	$(call if_changed_rule,as_o_S)
-$(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
-	$(call if_changed,hypcopy)
 
-# Disable reordering functions by GCC (enabled at -O2).
-# This pass puts functions into '.text.*' sections to aid the linker
-# in optimizing ELF layout. See HYPCOPY comment below for more info.
-ccflags-y += $(call cc-option,-fno-reorder-functions)
+# 2) Compile linker script.
+$(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
+# 3) Partially link all '.hyp.o' files and apply the linker script.
+#    Prefixes names of ELF sections with '.hyp', eg. '.hyp.text'.
+LDFLAGS_hyp.tmp.o := -r -T $(obj)/hyp.lds
+$(obj)/hyp.tmp.o: $(addprefix $(obj)/,$(hyp-obj)) $(obj)/hyp.lds FORCE
+	$(call if_changed,ld)
+
+# 4) Produce the final 'hyp.o', ready to be linked into 'vmlinux'.
+#    Prefixes names of ELF symbols with '__kvm_nvhe_'.
+$(obj)/hyp.o: $(obj)/hyp.tmp.o FORCE
+	$(call if_changed,hypcopy)
 
 # The HYPCOPY command uses `objcopy` to prefix all ELF symbol names
-# and relevant ELF section names to avoid clashes with VHE code/data.
-#
-# Hyp code is assumed to be in the '.text' section of the input object
-# files (with the exception of specialized sections such as
-# '.hyp.idmap.text'). This assumption may be broken by a compiler that
-# divides code into sections like '.text.unlikely' so as to optimize
-# ELF layout. HYPCOPY checks that no such sections exist in the input
-# using `objdump`, otherwise they would be linked together with other
-# kernel code and not memory-mapped correctly at runtime.
+# to avoid clashes with VHE code/data.
 quiet_cmd_hypcopy = HYPCOPY $@
-      cmd_hypcopy =							\
-	if $(OBJDUMP) -h $< | grep -F '.text.'; then			\
-		echo "$@: function reordering not supported in nVHE hyp code" >&2; \
-		/bin/false;						\
-	fi;								\
-	$(OBJCOPY) --prefix-symbols=__kvm_nvhe_				\
-		   --rename-section=.text=.hyp.text			\
-		   $< $@
+      cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
 # Remove ftrace and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
new file mode 100644
index 000000000000..aaa0ce133a32
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linker script used during partial linking of nVHE EL2 object files.
+ * Written by David Brazdil <dbrazdil@google.com>
+ */
+
+/*
+ * Defines an ELF hyp section from input section @NAME and its subsections.
+ */
+#define HYP_SECTION(NAME) .hyp##NAME : { *(NAME NAME##.[0-9a-zA-Z_]*) }
+
+SECTIONS {
+	HYP_SECTION(.text)
+}
-- 
2.28.0.402.g5ffc5be6b7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
