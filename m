Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0D2CC568
	for <lists+kvmarm@lfdr.de>; Wed,  2 Dec 2020 19:41:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F335F4B3E6;
	Wed,  2 Dec 2020 13:41:58 -0500 (EST)
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
	with ESMTP id f6yrs9ZlV6tz; Wed,  2 Dec 2020 13:41:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 018B24B426;
	Wed,  2 Dec 2020 13:41:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B2D024B384
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 13:41:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CiYmFWcv2Nyx for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Dec 2020 13:41:55 -0500 (EST)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7F7B84B2CD
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 13:41:55 -0500 (EST)
Received: by mail-wm1-f65.google.com with SMTP id x22so10031481wmc.5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Dec 2020 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FbhNL96u68QqM7Q1rkLQfNYMQNpyFncRvPJJEVMReqU=;
 b=aFE7s/N+LJ2214UmKW0aNWOqdMUPnXoa+EPsqwgnoGGxb8gEhdDmTcErY0lO7VX/of
 Pl4LzHwCPIYUm5h24H+uF+GVjDF8jfobBT3gBZqMIo6DJhMVbKU7Tear3xnCtVJhTA5Z
 H8UdHSoYKkI3GbRtMA+e9t2FLeHRS1USlflwgf2iXaGNryzWx/cGxM/H1WIW7F0TzFQm
 kUYSeVPW0o7VN8rQmnKCZzuQhKnOlQdi0fKh13kN7DNpfC847bpT3mlXKhcpfipcvWLM
 zXmrrrlzQf8R9QP/5CcjD6TobUxbU4+VxaXnueeA5C4NZSfWnZQsKClVCGz391574KZb
 MG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FbhNL96u68QqM7Q1rkLQfNYMQNpyFncRvPJJEVMReqU=;
 b=WLPvvhNJt74v5hVp09eIzM+veZlwzzeRqa6zohSrfRK7C4vkiXkLxITPkqxbj9WSZl
 4Ia4rRF/uXCzSTBkYytRvSMlWcH2QmuV6wA5H61Y7jbNxQeGI1olDbXjCjTzDDFUwljy
 ybb9PesNZ6YzjONFC+lWOr962fB8KSI6x2VQMOmxwwO3JGi/LilLIWumJCMF2OluGqSN
 av6ukNmsX5CziJwlFh1szRcIV0VR0qeo593rj9mWVn6D12fFjf5I/22Tpcipk/+G+kVL
 xUxRnJmzmzD9u1rz4eHQ2/+XU792LfV4UpkwH6p7rEbVbcNS4FbSLYF7N5cikTBwrhPs
 VIaw==
X-Gm-Message-State: AOAM53179bU6JEtWaJj4b0iU4BBgkm/TM8jdy0aPo0FdBByc9MCXUmum
 0A8hCCiWKQACBHEEUm/ts7gSIeBIudh9eA==
X-Google-Smtp-Source: ABdhPJzDonMAoe1/LUSeGrzjO/oX6VvyeXOfTR80+KWmzVofsLNtAQuxbUf5v7Ho6BG2owrCpnDifw==
X-Received: by 2002:a05:600c:2306:: with SMTP id
 6mr4532227wmo.53.1606934514097; 
 Wed, 02 Dec 2020 10:41:54 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
 by smtp.gmail.com with ESMTPSA id z140sm573266wmc.30.2020.12.02.10.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Dec 2020 10:41:52 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 12/26] kvm: arm64: Add .hyp.data..ro_after_init ELF section
Date: Wed,  2 Dec 2020 18:41:08 +0000
Message-Id: <20201202184122.26046-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
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

Add rules for renaming the .data..ro_after_init ELF section in KVM nVHE
object files to .hyp.data..ro_after_init, linking it into the kernel
and mapping it in hyp at runtime.

The section is RW to the host, then mapped RO in hyp. The expectation is
that the host populates the variables in the section and they are never
changed by hyp afterwards.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   | 10 ++++++++++
 arch/arm64/kvm/arm.c              |  8 ++++++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  1 +
 4 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 3994169985ef..8ff579361731 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -11,6 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
 extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
+extern char __hyp_data_ro_after_init_start[], __hyp_data_ro_after_init_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1bda604f4c70..4382b5d0645d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -30,6 +30,13 @@ jiffies = jiffies_64;
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
 
+#define HYPERVISOR_DATA_SECTIONS				\
+	HYP_SECTION_NAME(.data..ro_after_init) : {		\
+		__hyp_data_ro_after_init_start = .;		\
+		*(HYP_SECTION_NAME(.data..ro_after_init))	\
+		__hyp_data_ro_after_init_end = .;		\
+	}
+
 #define HYPERVISOR_PERCPU_SECTION				\
 	. = ALIGN(PAGE_SIZE);					\
 	HYP_SECTION_NAME(.data..percpu) : {			\
@@ -37,6 +44,7 @@ jiffies = jiffies_64;
 	}
 #else /* CONFIG_KVM */
 #define HYPERVISOR_EXTABLE
+#define HYPERVISOR_DATA_SECTIONS
 #define HYPERVISOR_PERCPU_SECTION
 #endif
 
@@ -234,6 +242,8 @@ SECTIONS
 	_sdata = .;
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
 
+	HYPERVISOR_DATA_SECTIONS
+
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
 	 * cache lines to be invalidated, discarding up to a Cache Writeback
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6c8594378865..40857cbed3d1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1705,6 +1705,14 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_ro_after_init_start),
+				  kvm_ksym_ref(__hyp_data_ro_after_init_end),
+				  PAGE_HYP_RO);
+	if (err) {
+		kvm_err("Cannot map .hyp.data..ro_after_init section\n");
+		goto out_err;
+	}
+
 	err = create_hyp_mappings(kvm_ksym_ref(__start_rodata),
 				  kvm_ksym_ref(__end_rodata), PAGE_HYP_RO);
 	if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index bb2d986ff696..5d76ff2ba63e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -16,4 +16,5 @@ SECTIONS {
 	HYP_SECTION_NAME(.data..percpu) : {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
+	HYP_SECTION(.data..ro_after_init)
 }
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
