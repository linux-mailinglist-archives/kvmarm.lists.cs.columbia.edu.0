Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 60B0C56FC60
	for <lists+kvmarm@lfdr.de>; Mon, 11 Jul 2022 11:43:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CEF7D4B9AE;
	Mon, 11 Jul 2022 05:43:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80SdT-EXahgj; Mon, 11 Jul 2022 05:43:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52F224BB6A;
	Mon, 11 Jul 2022 05:42:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F0254B56C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Jul 2022 17:21:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eG03qetIHbwm for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Jul 2022 17:21:17 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4D7E04B58D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Jul 2022 17:21:17 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 g12-20020a05690203cc00b0066e232409c9so13984993ybs.22
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Jul 2022 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=twUVJxIVhhRUka3ujAGpgx5jyolc6+CWViYPAjBE+SE=;
 b=gGW7BYWFyEalfApr15oYFvpIMQcxD7X1mQiNqiPuiVHYYUJgo4j9T8+HQrwKcnXi4E
 uEYEIa6xfRlrn0clPA2WDvMuAzqAf91T7W2xQHSARkmZ8P1Lz2oyGz5DLXF4tH9Ry9TJ
 NSulr8r64BRrltG4I9PBO5kezDuJpeqU5FtSpSKwFcouadKfcfrj2G0ftpInI2imZOKz
 SM+n0KcxkrqAmu334mXP1Menw+lX76bcByeebg6rmKPRCwX4ejI7DrvTf6emYPf0kcHg
 /DgDGUJ4pRWEXgIDl2tKPrWdfeRCoIuV6Znk/PyHVb51PY7O7o//T5G4QkZZXL6unvXn
 Qp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=twUVJxIVhhRUka3ujAGpgx5jyolc6+CWViYPAjBE+SE=;
 b=pzM3DaIV8cB59XNl4xt550IvM0To/k6AOHA3k2mc5eQCTt422/6joHZwBVKdIzVriV
 CuXKcaSBEve/2E+hX8rf66ResLAsQfVdUrF1vfgi+CNXzVfHdwU5kiiPt9DGgVCrs25Y
 Kt6lYXX2seVRapOeii5qcd/v9ETAPUUlsAxbKviAPOW50S5PvWWccP8ewrZfetm1Hw5c
 8ucNvqckRjmmOxFjrQOPF5w5oNPr0JUM1oQEZL64hpDBVbFM2VuuFcpCJbRZtXt9ystc
 sgBNjFE/nKzzqAJG8BxbP8i/6D4bmGOOC9Tj+IYJ8lmVVvF0CLnZFSv0NbtIWet7qwnR
 Efqw==
X-Gm-Message-State: AJIora+rPucFFfXsI89rw/gchALnrNqd5ZZfIf6X3isMT8rH4l4kgXxH
 nnssAUCltOkgZB7wTIE6NiZ1ln1gErOFjYa5gqhHLUrKU3T85LU7j+KiR6g1naTInJROoNYOns7
 ElXjibYMjDjcSAFKWHEwSB6xskTdx90K9da++b8qvUG9XjErcow2IVblbh7B5YA==
X-Google-Smtp-Source: AGRyM1sGe6ArR8ij03wbQdy/kCKJfdsfrfRo/UOh8N3xvvxXsh3eCjHm+5S8mVUGa8PtuJjzKsK3bH4=
X-Received: from pcc-desktop.svl.corp.google.com
 ([2620:15c:2ce:200:ff27:d65:6bb8:b084])
 (user=pcc job=sendgmr) by 2002:a81:4eca:0:b0:31c:7a6a:f6d3 with SMTP id
 c193-20020a814eca000000b0031c7a6af6d3mr6573793ywb.82.1657315276782; Fri, 08
 Jul 2022 14:21:16 -0700 (PDT)
Date: Fri,  8 Jul 2022 14:21:04 -0700
In-Reply-To: <20220708212106.325260-1-pcc@google.com>
Message-Id: <20220708212106.325260-2-pcc@google.com>
Mime-Version: 1.0
References: <20220708212106.325260-1-pcc@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v2 1/3] KVM: arm64: add a hypercall for disowning pages
From: Peter Collingbourne <pcc@google.com>
To: kvmarm@lists.cs.columbia.edu
X-Mailman-Approved-At: Mon, 11 Jul 2022 05:42:55 -0400
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Deacon <will@kernel.org>, Evgenii Stepanov <eugenis@google.com>,
 Michael Roth <michael.roth@amd.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
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

Currently we only deny the host access to hyp and guest pages. However,
there may be other pages that could potentially be used to indirectly
compromise the hypervisor or the other guests. Therefore introduce a
__pkvm_disown_pages hypercall that the host kernel may use to deny its
future self access to those pages before deprivileging itself.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
v2:
- refcount the PTEs owned by NOBODY

 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 +++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 11 +++++++++++
 5 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 411cfbe3ebbd..1a177d9ed517 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -63,6 +63,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid_ipa,
 	__KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_cpu_context,
+	__KVM_HOST_SMCCC_FUNC___pkvm_disown_pages,
 	__KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize,
 
 	/* Hypercalls available after pKVM finalisation */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index e0bbb1726fa3..e88a9dab9cd5 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -58,6 +58,7 @@ enum pkvm_component_id {
 	PKVM_ID_HOST,
 	PKVM_ID_HYP,
 	PKVM_ID_GUEST,
+	PKVM_ID_NOBODY,
 };
 
 extern unsigned long hyp_nr_cpus;
diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index c1987115b217..fbd991a46ab3 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -98,6 +98,7 @@ int __pkvm_init_shadow(struct kvm *kvm,
 		       unsigned long pgd_hva,
 		       unsigned long last_ran_hva, size_t last_ran_size);
 int __pkvm_teardown_shadow(unsigned int shadow_handle);
+int __pkvm_disown_pages(phys_addr_t phys, size_t size);
 
 struct kvm_shadow_vcpu_state *
 pkvm_load_shadow_vcpu_state(unsigned int shadow_handle, unsigned int vcpu_idx);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index e575224244e6..0dab343734e8 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -1031,6 +1031,14 @@ static void handle___pkvm_teardown_shadow(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_teardown_shadow(shadow_handle);
 }
 
+static void handle___pkvm_disown_pages(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
+	DECLARE_REG(size_t, size, host_ctxt, 2);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_disown_pages(phys, size);
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -1048,6 +1056,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__kvm_tlb_flush_vmid_ipa),
 	HANDLE_FUNC(__kvm_tlb_flush_vmid),
 	HANDLE_FUNC(__kvm_flush_cpu_context),
+	HANDLE_FUNC(__pkvm_disown_pages),
 	HANDLE_FUNC(__pkvm_prot_finalize),
 
 	HANDLE_FUNC(__pkvm_host_share_hyp),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d839bb573b49..b3a2ad8454cc 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1756,3 +1756,14 @@ int __pkvm_host_reclaim_page(u64 pfn)
 
 	return ret;
 }
+
+int __pkvm_disown_pages(phys_addr_t phys, size_t size)
+{
+	int ret;
+
+	host_lock_component();
+	ret = host_stage2_set_owner_locked(phys, size, PKVM_ID_NOBODY);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.37.0.144.g8ac04bfd2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
