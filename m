Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 71390647655
	for <lists+kvmarm@lfdr.de>; Thu,  8 Dec 2022 20:39:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E4F814BA24;
	Thu,  8 Dec 2022 14:39:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N9-AiztQvZ-k; Thu,  8 Dec 2022 14:39:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03ECA4BA62;
	Thu,  8 Dec 2022 14:39:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4ACF84BA24
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Dec 2022 14:39:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Lp2RXhXKFkn for <kvmarm@lists.cs.columbia.edu>;
 Thu,  8 Dec 2022 14:39:18 -0500 (EST)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 392F04BA41
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Dec 2022 14:39:16 -0500 (EST)
Received: by mail-yb1-f201.google.com with SMTP id
 y6-20020a25b9c6000000b006c1c6161716so2533163ybj.8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 08 Dec 2022 11:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7K9ka6MUeaf4VmwASDJsBFWEG85o/chirVO+ir7DJ1k=;
 b=irP5mcGoAOYc8wosnD/TtALC0WWa+NGjhVIHJTTnr/3Z8yjzEK7JM4oiVhdZFBRQwy
 zJ2t/ttFB0YDo1jKtcssuFL71HMxb9Mn2FDYgr/S1maeH1kDPYzBK0DF9LASFH6X+Gyz
 ADGVieTHTJS3Xu0juG8XWrdDMzDZvqxucwC6VjLm3/r24BngHKVLne44DdbtStaOGGOh
 nAuOImwdaJqBcKx9C/oAm0bmd7zRXkwa5CkgPV2RFBbSGZAPdiE+y9pF0NYdTwDcUcBb
 YIWPvUTgaFvUXFehRkfrZQ4c+oYOqfGi3KvXXK7lpuBLnfpJgagtw4O5VTtpSo61tAre
 q86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K9ka6MUeaf4VmwASDJsBFWEG85o/chirVO+ir7DJ1k=;
 b=orto1qcsg807wtIsyraeW69j1VRVAMfAhvv9pwdcsejFpuyuMep4r2LCfFp+O+QITQ
 JMt87Rtdcz9wNlMKYHC0+IL97S9WL8mok5eE+v6VSuU3V2JyS1cpDKkM3M9kxlcUgMq3
 r/cez1qD1Ef2QP2QpCryc6dfskqtVG/pkoisi2fZimgL7ad7I8CwvqmWHJLSQwACT+yP
 olYdYoWcoZ9NbmSIhbfaSaYVzHp5PCnycT8Rq+w+1SV8u9GI5wWpkKaIzG40OG8VFLBS
 MNKlmMPfWDIR4/48X23LEnov/oZPk+CYiCIxDU3YFcWbKsRAUMbz6gTQtoPLLiV2364e
 0oug==
X-Gm-Message-State: ANoB5pmmLruuMn+ujpja8GhoxrM3846m0LuKK8XTjD+ngoYR314VRLWu
 NxyMYoml9f024mEh7IJmmhVbWNyW/5PBoQ==
X-Google-Smtp-Source: AA0mqf4/lKyQk5lKEjo3ymU4c9dqtITM1gYvYc6O/tXnyNlkcxf5NSwbnRprMsGK5JwDZSs7UsMVtOf+2DbYHA==
X-Received: from dmatlack-n2d-128.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:1309])
 (user=dmatlack job=sendgmr) by 2002:a81:120d:0:b0:3d5:ecbb:2923 with SMTP id
 13-20020a81120d000000b003d5ecbb2923mr35023748yws.485.1670528355728; Thu, 08
 Dec 2022 11:39:15 -0800 (PST)
Date: Thu,  8 Dec 2022 11:38:25 -0800
In-Reply-To: <20221208193857.4090582-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20221208193857.4090582-1-dmatlack@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221208193857.4090582-6-dmatlack@google.com>
Subject: [RFC PATCH 05/37] KVM: x86/mmu: Unify TDP MMU and Shadow MMU root
 refcounts
From: David Matlack <dmatlack@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Hugh Dickins <hughd@google.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 kvmarm@lists.linux.dev, Nadav Amit <namit@vmware.com>,
 Colin Cross <ccross@google.com>, Ben Gardon <bgardon@google.com>,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 Yu Zhao <yuzhao@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mingwei Zhang <mizhang@google.com>,
 Albert Ou <aou@eecs.berkeley.edu>, xu xin <cgel.zte@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 kvm@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
 David Matlack <dmatlack@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>
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

Use the same field for refcounting roots in the TDP MMU and Shadow MMU.
The atomicity provided by refcount_t is overkill for the Shadow MMU,
since it holds the write-lock. But converging this field will enable a
future commit to more easily move struct kvm_mmu_page to common code.

Note, refcount_dec_and_test() returns true if the resulting refcount is
0. Hence the check in mmu_free_root_page() is inverted to check if
shadow root refcount is 0.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 14 +++++++-------
 arch/x86/kvm/mmu/mmu_internal.h |  6 ++----
 arch/x86/kvm/mmu/mmutrace.h     |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  8 ++++----
 arch/x86/kvm/mmu/tdp_mmu.h      |  2 +-
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f7668a32721d..11cef930d5ed 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2498,14 +2498,14 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
 
 	if (sp->unsync)
 		kvm_unlink_unsync_page(kvm, sp);
-	if (!sp->root_count) {
+	if (!refcount_read(&sp->root_refcount)) {
 		/* Count self */
 		(*nr_zapped)++;
 
 		/*
 		 * Already invalid pages (previously active roots) are not on
 		 * the active page list.  See list_del() in the "else" case of
-		 * !sp->root_count.
+		 * !sp->root_refcount.
 		 */
 		if (sp->role.invalid)
 			list_add(&sp->link, invalid_list);
@@ -2515,7 +2515,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
 	} else {
 		/*
 		 * Remove the active root from the active page list, the root
-		 * will be explicitly freed when the root_count hits zero.
+		 * will be explicitly freed when the root_refcount hits zero.
 		 */
 		list_del(&sp->link);
 
@@ -2570,7 +2570,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	kvm_flush_remote_tlbs(kvm);
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
-		WARN_ON(!sp->role.invalid || sp->root_count);
+		WARN_ON(!sp->role.invalid || refcount_read(&sp->root_refcount));
 		kvm_mmu_free_shadow_page(sp);
 	}
 }
@@ -2593,7 +2593,7 @@ static unsigned long kvm_mmu_zap_oldest_mmu_pages(struct kvm *kvm,
 		 * Don't zap active root pages, the page itself can't be freed
 		 * and zapping it will just force vCPUs to realloc and reload.
 		 */
-		if (sp->root_count)
+		if (refcount_read(&sp->root_refcount))
 			continue;
 
 		unstable = __kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list,
@@ -3481,7 +3481,7 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 
 	if (is_tdp_mmu_page(sp))
 		kvm_tdp_mmu_put_root(kvm, sp, false);
-	else if (!--sp->root_count && sp->role.invalid)
+	else if (refcount_dec_and_test(&sp->root_refcount) && sp->role.invalid)
 		kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
 
 	*root_hpa = INVALID_PAGE;
@@ -3592,7 +3592,7 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	WARN_ON_ONCE(role.arch.direct && role.arch.has_4_byte_gpte);
 
 	sp = kvm_mmu_get_shadow_page(vcpu, gfn, role);
-	++sp->root_count;
+	refcount_inc(&sp->root_refcount);
 
 	return __pa(sp->spt);
 }
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index c1a379fba24d..fd4990c8b0e9 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -87,10 +87,8 @@ struct kvm_mmu_page {
 	u64 *shadowed_translation;
 
 	/* Currently serving as active root */
-	union {
-		int root_count;
-		refcount_t tdp_mmu_root_count;
-	};
+	refcount_t root_refcount;
+
 	unsigned int unsync_children;
 	union {
 		struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 6a4a43b90780..ffd10ce3eae3 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -19,7 +19,7 @@
 	__entry->mmu_valid_gen = sp->mmu_valid_gen;	\
 	__entry->gfn = sp->gfn;				\
 	__entry->role = sp->role.word;			\
-	__entry->root_count = sp->root_count;		\
+	__entry->root_count = refcount_read(&sp->root_refcount);	\
 	__entry->unsync = sp->unsync;
 
 #define KVM_MMU_PAGE_PRINTK() ({				        \
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index fc0b87ceb1ea..34d674080170 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -130,7 +130,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
 {
 	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
 
-	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
+	if (!refcount_dec_and_test(&root->root_refcount))
 		return;
 
 	/*
@@ -158,7 +158,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
 	 * zap the root because a root cannot go from invalid to valid.
 	 */
 	if (!kvm_tdp_root_mark_invalid(root)) {
-		refcount_set(&root->tdp_mmu_root_count, 1);
+		refcount_set(&root->root_refcount, 1);
 
 		/*
 		 * Zapping the root in a worker is not just "nice to have";
@@ -316,7 +316,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 	root = tdp_mmu_alloc_sp(vcpu);
 	tdp_mmu_init_sp(root, NULL, 0, role);
 
-	refcount_set(&root->tdp_mmu_root_count, 1);
+	refcount_set(&root->root_refcount, 1);
 
 	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
 	list_add_rcu(&root->link, &kvm->arch.tdp_mmu_roots);
@@ -883,7 +883,7 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
 	 * and lead to use-after-free as zapping a SPTE triggers "writeback" of
 	 * dirty accessed bits to the SPTE's associated struct page.
 	 */
-	WARN_ON_ONCE(!refcount_read(&root->tdp_mmu_root_count));
+	WARN_ON_ONCE(!refcount_read(&root->root_refcount));
 
 	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 18d3719f14ea..19d3153051a3 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -14,7 +14,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 
 __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm_mmu_page *root)
 {
-	return refcount_inc_not_zero(&root->tdp_mmu_root_count);
+	return refcount_inc_not_zero(&root->root_refcount);
 }
 
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
-- 
2.39.0.rc1.256.g54fd8350bd-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
