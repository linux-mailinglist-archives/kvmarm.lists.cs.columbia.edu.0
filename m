Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0D22B465396
	for <lists+kvmarm@lfdr.de>; Wed,  1 Dec 2021 18:05:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B43694B243;
	Wed,  1 Dec 2021 12:05:18 -0500 (EST)
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
	with ESMTP id 0KOxRflgM+eY; Wed,  1 Dec 2021 12:05:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DD884B269;
	Wed,  1 Dec 2021 12:05:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E095D4B243
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Dec 2021 12:05:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RH9B094XuB1y for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Dec 2021 12:05:14 -0500 (EST)
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 127404B222
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Dec 2021 12:05:14 -0500 (EST)
Received: by mail-wm1-f73.google.com with SMTP id
 201-20020a1c04d2000000b003335bf8075fso12600112wme.0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 01 Dec 2021 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=94lgfXtWTVzPjMgUB8UON2q/QY1bS12ewvWubTStSBY=;
 b=byjaspXWj3Emirw/SYW07K50hbbJRqfTTb/c+PdXpZ0s9t6fSMlrX8UA6jozLKWJT/
 FzbGPWt4tNhwSGSlojLMXTJG5BJZLCGiIimZ+laxo/7TdLeglhvGLKDQJioEzGJg1dVx
 j7YVB6jfQsQlTpZoq9A27qDCvWfQHMd2DwTBjzu6tg0vHrPL2BGv551S3HM377d/kbWt
 X+GNVh9o9oIUYDsoOXowzMyK6+WpNO3mKqSvKHfAGpagL+J5RU5Ml5NA/5H0Ue9pW75X
 qzNE12E3WOdHLnzof4efNf1OjChZkivDFFknbJxjtvTRGyDI6UdwHsNvz1rL8cTvayu/
 U2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=94lgfXtWTVzPjMgUB8UON2q/QY1bS12ewvWubTStSBY=;
 b=xrjdTCslXTyRmCMCRfOR+D5W3PDgQOZlAWGYvu8S3p+mmQG//GL2ZCa0E2NMEGjzIL
 0l/aNNNhBmZWqNrBIB1srJLKh1n4cRviTO0jXr/ThFc4Yrb/k26tjnFJwn5Q7j0Bqxg7
 iAQGGuYKVDbz6aRjBLZ3I+PBIjDUI4zGJOny1Jj10woJR6V6Ibtll3vtAmUCoMNkDiNa
 LaxBRaLfsql4Lp4uNTMC0s/K+8YWF/Ay8lgbJg0XSDunClCuFAbkRlJsAeX5w/Gp039a
 3z6mGxjoJWkRVxD06faMMjYQGQAvhp5+czwooBlrduBNqHuqInZH02jNFg0Geys8LA0c
 RIJw==
X-Gm-Message-State: AOAM533+AiEwfe08lDsBKzDgxURT3o/HQkTqs8WRTVE7bEf10KQkhdVG
 hvY08P8zLou3btJSyYLhbzwhyBvRmXNe
X-Google-Smtp-Source: ABdhPJxbxvLDyUj4CZ5Ql0OoMQ3x1gNpb3V5A/9auOAcSgkEsXxfrFva++4+GqLbfoV75ix1zNS22MKmonO8
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:1d97:: with SMTP id
 p23mr8674163wms.186.1638378313175; Wed, 01 Dec 2021 09:05:13 -0800 (PST)
Date: Wed,  1 Dec 2021 17:04:09 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-16-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 15/15] KVM: arm64: pkvm: Unshare guest structs during
 teardown
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

Make use of the newly introduced unshare hypercall during guest teardown
to unmap guest-related data structures from the hyp stage-1.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 arch/arm64/kvm/arm.c              |  2 ++
 arch/arm64/kvm/fpsimd.c           | 34 ++++++++++++++++++++++---
 arch/arm64/kvm/mmu.c              | 42 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/reset.c            |  8 +++++-
 6 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index cf858a7e3533..9360a2804df1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -321,6 +321,7 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch external_debug_state;
 
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
+	struct task_struct *parent_task;
 
 	struct {
 		/* {Break,watch}point registers */
@@ -737,6 +738,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
+void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu);
 
 static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
 {
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 185d0f62b724..81839e9a8a24 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -151,6 +151,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 #include <asm/stage2_pgtable.h>
 
 int kvm_share_hyp(void *from, void *to);
+void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c202abb448b1..6057f3c5aafe 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -188,6 +188,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		}
 	}
 	atomic_set(&kvm->online_vcpus, 0);
+
+	kvm_unshare_hyp(kvm, kvm + 1);
 }
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 86899d3aa9a9..2f48fd362a8c 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -14,6 +14,19 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
+void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
+{
+	struct task_struct *p = vcpu->arch.parent_task;
+	struct user_fpsimd_state *fpsimd;
+
+	if (!is_protected_kvm_enabled() || !p)
+		return;
+
+	fpsimd = &p->thread.uw.fpsimd_state;
+	kvm_unshare_hyp(fpsimd, fpsimd + 1);
+	put_task_struct(p);
+}
+
 /*
  * Called on entry to KVM_RUN unless this vcpu previously ran at least
  * once and the most recent prior KVM_RUN for this vcpu was called from
@@ -29,12 +42,27 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 
 	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
 
+	kvm_vcpu_unshare_task_fp(vcpu);
+
 	/* Make sure the host task fpsimd state is visible to hyp: */
 	ret = kvm_share_hyp(fpsimd, fpsimd + 1);
-	if (!ret)
-		vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
+	if (ret)
+		return ret;
+
+	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
+
+	/*
+	 * We need to keep current's task_struct pinned until its data has been
+	 * unshared with the hypervisor to make sure it is not re-used by the
+	 * kernel and donated to someone else while already shared -- see
+	 * kvm_vcpu_unshare_task_fp() for the matching put_task_struct().
+	 */
+	if (is_protected_kvm_enabled()) {
+		get_task_struct(current);
+		vcpu->arch.parent_task = current;
+	}
 
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d72566896755..8e506ba8988e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -344,6 +344,32 @@ static int share_pfn_hyp(u64 pfn)
 	return ret;
 }
 
+static int unshare_pfn_hyp(u64 pfn)
+{
+	struct rb_node **node, *parent;
+	struct hyp_shared_pfn *this;
+	int ret = 0;
+
+	mutex_lock(&hyp_shared_pfns_lock);
+	this = find_shared_pfn(pfn, &node, &parent);
+	if (WARN_ON(!this)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	this->count--;
+	if (this->count)
+		goto unlock;
+
+	rb_erase(&this->node, &hyp_shared_pfns);
+	kfree(this);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp, pfn, 1);
+unlock:
+	mutex_unlock(&hyp_shared_pfns_lock);
+
+	return ret;
+}
+
 int kvm_share_hyp(void *from, void *to)
 {
 	phys_addr_t start, end, cur;
@@ -376,6 +402,22 @@ int kvm_share_hyp(void *from, void *to)
 	return 0;
 }
 
+void kvm_unshare_hyp(void *from, void *to)
+{
+	phys_addr_t start, end, cur;
+	u64 pfn;
+
+	if (is_kernel_in_hyp_mode() || kvm_host_owns_hyp_mappings() || !from)
+		return;
+
+	start = ALIGN_DOWN(__pa(from), PAGE_SIZE);
+	end = PAGE_ALIGN(__pa(to));
+	for (cur = start; cur < end; cur += PAGE_SIZE) {
+		pfn = __phys_to_pfn(cur);
+		WARN_ON(unshare_pfn_hyp(pfn));
+	}
+}
+
 /**
  * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index e3e2a79fbd75..798a84eddbde 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -150,7 +150,13 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	kfree(vcpu->arch.sve_state);
+	void *sve_state = vcpu->arch.sve_state;
+
+	kvm_vcpu_unshare_task_fp(vcpu);
+	kvm_unshare_hyp(vcpu, vcpu + 1);
+	if (sve_state)
+		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
+	kfree(sve_state);
 }
 
 static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
-- 
2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
