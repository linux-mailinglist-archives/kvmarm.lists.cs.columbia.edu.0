Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A84C10EA
	for <lists+kvmarm@lfdr.de>; Wed, 23 Feb 2022 12:02:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C7EB4C333;
	Wed, 23 Feb 2022 06:02:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.766
X-Spam-Level: 
X-Spam-Status: No, score=-0.766 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, MISSING_HEADERS=1.021,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8V7KykepSh7c; Wed, 23 Feb 2022 06:02:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 457A64C495;
	Wed, 23 Feb 2022 06:02:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A7B640431
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 11:56:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mqg-0A9la6r for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 11:56:05 -0500 (EST)
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com
 [209.85.128.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 29371404B2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 11:56:05 -0500 (EST)
Received: by mail-yw1-f202.google.com with SMTP id
 00721157ae682-2d07ae11462so146977127b3.8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
 bh=R7NUgyhmz2Vzm1IbfrrDYD1qNpQGYjcjDbFVXUaMLH8=;
 b=KI3O3p6WIXcE6n5c1xlRqNCzstNa7C+hluEFjVsr0MOzveDFLD2VUOGSWGeKG0RHJy
 T/yqV6+ri+p/3rX+b1pYMjSNo3Ovj9yyZbKA1607HqCA3kbya8vyKQ2GDgWlYG9l1znh
 rWdySSjzOH0K6sfRsXIWIRMQFAHMD5jl44ausSef3FnfQgFOmyhWcQwfQoMj6etEc/LI
 hJHRQ66bszx5zigZGXaE9ntUDiXKmNtjFdm5S5h0xTnO2PAF2yNKcyiTDlX9Dq5Ziu1q
 t3RdfNDzIKa7Bq1TCGBRbeYsC4mW70m5JWLL7NBzuv6XS1rF0YDiOJcHIe7I88ZhGfi5
 7YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:cc;
 bh=R7NUgyhmz2Vzm1IbfrrDYD1qNpQGYjcjDbFVXUaMLH8=;
 b=gwC1yh0g94wpPCckS7HBguYl94ITnXbVWEkOIViEGUAVmshKjYJQOkCkf8XtEcxXk7
 91kTmlgntzpqmw/SJIQNiaJQowtU5xzd3EDfntijnjFxX4qrzbIpXl3uVf4Yxdv95b+O
 irzY/UrvV2M3wSXF8Lch3vBdJQBnrlBv/JwtgKOfCBCYR7Hk95wozmDgjec1arba8O7w
 lZPYorirQcSUwfbWR/NyliDVQzxRCxnVbnwcM7emy2ISbXh2vp2gYjErGHGyqbtL9T7N
 8EUOrNNiL8O+ck2ZaREgIZndMQUewwLnz4Mx/o87L1AlQiT0go1ghpTIPTmX4IPv5/bv
 IthA==
X-Gm-Message-State: AOAM532WeTZuKR60R/uG47jVzkJF4ZUW+CPJ2f42lvM+CD3CDwnCasih
 IZ901bsKhp3cayKkMDFCfcSItpgx3Wgmme6dKg==
X-Google-Smtp-Source: ABdhPJzj4uTOWudxzzJokeTZXJ0Xc+OcxmAl9Nm7IKWdiyC4Dj/qqu6z+Dkz3NZLlc5P6ZEzL8Pz6NCeaRU6Ltd2cA==
X-Received: from kaleshsingh.mtv.corp.google.com
 ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:ca:b0:5ff:5f2d:b533 with SMTP
 id i10-20020a05690200ca00b005ff5f2db533mr23967292ybs.606.1645548964571; Tue,
 22 Feb 2022 08:56:04 -0800 (PST)
Date: Tue, 22 Feb 2022 08:51:04 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 3/9] KVM: arm64: Add guard pages for KVM nVHE hypervisor
 stack
From: Kalesh Singh <kaleshsingh@google.com>
X-Mailman-Approved-At: Wed, 23 Feb 2022 06:02:29 -0500
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, will@kernel.org,
 Peter Collingbourne <pcc@google.com>, maz@kernel.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 kvmarm@lists.cs.columbia.edu, Kalesh Singh <kaleshsingh@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, surenb@google.com,
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

Maps the stack pages in the flexible private VA range and allocates
guard pages below the stack as unbacked VA space. The stack is aligned
to twice its size to aid overflow detection (implemented in a subsequent
patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/kvm_asm.h |  1 +
 arch/arm64/kvm/arm.c             | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index d5b0386ef765..2e277f2ed671 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -169,6 +169,7 @@ struct kvm_nvhe_init_params {
 	unsigned long tcr_el2;
 	unsigned long tpidr_el2;
 	unsigned long stack_hyp_va;
+	unsigned long stack_pa;
 	phys_addr_t pgd_pa;
 	unsigned long hcr_el2;
 	unsigned long vttbr;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ecc5958e27fe..7e2e680c3ffb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1541,7 +1541,6 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1990,14 +1989,41 @@ static int init_hyp_mode(void)
 	 * Map the Hyp stack pages
 	 */
 	for_each_possible_cpu(cpu) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 		char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
-		err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
-					  PAGE_HYP);
+		unsigned long stack_hyp_va, guard_hyp_va;
 
+		/*
+		 * Private mappings are allocated downwards from io_map_base
+		 * so allocate the stack first then the guard page.
+		 *
+		 * The stack is aligned to twice its size to facilitate overflow
+		 * detection.
+		 */
+		err = __create_hyp_private_mapping(__pa(stack_page), PAGE_SIZE,
+						PAGE_SIZE * 2, &stack_hyp_va, PAGE_HYP);
 		if (err) {
 			kvm_err("Cannot map hyp stack\n");
 			goto out_err;
 		}
+
+		/* Allocate unbacked private VA range for stack guard page */
+		guard_hyp_va = hyp_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
+		if (IS_ERR((void *)guard_hyp_va)) {
+			err = PTR_ERR((void *)guard_hyp_va);
+			kvm_err("Cannot allocate hyp stack guard page\n");
+			goto out_err;
+		}
+
+		/*
+		 * Save the stack PA in nvhe_init_params. This will be needed to recreate
+		 * the stack mapping in protected nVHE mode. __hyp_pa() won't do the right
+		 * thing there, since the stack has been mapped in the flexible private
+		 * VA space.
+		 */
+		params->stack_pa = __pa(stack_page) + PAGE_SIZE;
+
+		params->stack_hyp_va = stack_hyp_va + PAGE_SIZE;
 	}
 
 	for_each_possible_cpu(cpu) {
-- 
2.35.1.473.g83b2b277ed-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
