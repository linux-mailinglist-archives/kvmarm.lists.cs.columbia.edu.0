Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 45B80427607
	for <lists+kvmarm@lfdr.de>; Sat,  9 Oct 2021 04:14:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E97044B10E;
	Fri,  8 Oct 2021 22:14:09 -0400 (EDT)
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
	with ESMTP id LQLBpjwrDhBo; Fri,  8 Oct 2021 22:14:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EEE694B1B4;
	Fri,  8 Oct 2021 22:14:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0F134B1A2
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:14:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yCQ79QiCTWwZ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 22:14:06 -0400 (EDT)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F1CB14B0D9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:14:05 -0400 (EDT)
Received: by mail-qk1-f202.google.com with SMTP id
 m1-20020a05620a290100b0045e5e0b11e6so9786553qkp.23
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Oct 2021 19:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=vAfx5V7oXhMQdNK6n8fKDF9GGCBj6ltSzPsyuPD42Bs=;
 b=HyCTY7JAidC//XRRYdKJX4UqDMF+OOF3bUAiJb+P7QyZ+wCs6Z/juMFKBQx23iMMVN
 cqVP/RAmIlHJJh/IhCDJgzpkP3/4PSr5HvmGU1YPAIdroNNdN/LgWT1sdedqNCFyThVJ
 OB3PsHG+5QPOxxfyOCjKqjYqJ4/3yZaYt4IJa7HdBQLnErOW6mzpDjvlQYRWWwwhfSDr
 es8zEbyw0sk5VgOb2rS8SbWA9aRFUd6GPvV5QVuzDE3suPpPWMfVuh4VMHrQBClBm931
 uNAJ7v8jb3UYDmZvbfs/UX4HaL+qaNp7Uu3y1027BulayBFMmGfZVNaeWs+z9FeE6i1a
 QWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=vAfx5V7oXhMQdNK6n8fKDF9GGCBj6ltSzPsyuPD42Bs=;
 b=XEtiu5SKhEd2cAEGtowT85xlGgjLkbJrMAkwUnJTuNRaXAsmOAt+gwwQi+CoH3JGsL
 56Z2Exuon/gdgJ1uXQuQpK8kONGuNDT5rHAfH8BVDOVCyXmXNYAJvgZcmxHOf8tOC78h
 SsEShXekMaBqvniGYvjUX8C7OFbSe175PMJx/WYT/36mxi+I9FXW7hjo+bnuU2UxaOtC
 qAidv88D4dNS5aMvJw2ZA+xmKF87KDKJP4giqwSZ86CpQkjFa7hBzdBl/M6HH8MjbXJ4
 psDXlZLwGOarNmLAwysnoNy2ydY4iwPIay/Azij95JSM1gUgndK69AqY9CXoScJ9XvNI
 m9Nw==
X-Gm-Message-State: AOAM533cL1V2VqExro+uJ6uq4x8HjDKHLAFtTGzmRV9YuK5TJ2uJIery
 c7+M8EJDA2TYPKTNgI3OfGnBJNQ89Wk=
X-Google-Smtp-Source: ABdhPJx91iwUKT3XNp8Nkk81qQnI7CC/+A7yDe4tFSaroMx6ORDJ7jKPf6Pp/KOtyNzdi03H7gazxyAr7d8=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:ac8:5c0a:: with SMTP id
 i10mr1952886qti.23.1633745645576; 
 Fri, 08 Oct 2021 19:14:05 -0700 (PDT)
Date: Fri,  8 Oct 2021 19:12:27 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-35-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 34/43] KVM: x86: Remove defunct pre_block/post_block
 kvm_x86_ops hooks
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Anup Patel <anup.patel@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Joerg Roedel <joro@8bytes.org>, kvm-ppc@vger.kernel.org,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

Drop kvm_x86_ops' pre/post_block() now that all implementations are nops.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 --
 arch/x86/include/asm/kvm_host.h    | 12 ------------
 arch/x86/kvm/vmx/vmx.c             | 13 -------------
 arch/x86/kvm/x86.c                 |  6 +-----
 4 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index cefe1d81e2e8..c2b007171abd 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -96,8 +96,6 @@ KVM_X86_OP(handle_exit_irqoff)
 KVM_X86_OP_NULL(request_immediate_exit)
 KVM_X86_OP(sched_in)
 KVM_X86_OP_NULL(update_cpu_dirty_logging)
-KVM_X86_OP_NULL(pre_block)
-KVM_X86_OP_NULL(post_block)
 KVM_X86_OP_NULL(vcpu_blocking)
 KVM_X86_OP_NULL(vcpu_unblocking)
 KVM_X86_OP_NULL(update_pi_irte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 328103a520d3..76a8dddc1a48 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1445,18 +1445,6 @@ struct kvm_x86_ops {
 	const struct kvm_pmu_ops *pmu_ops;
 	const struct kvm_x86_nested_ops *nested_ops;
 
-	/*
-	 * Architecture specific hooks for vCPU blocking due to
-	 * HLT instruction.
-	 * Returns for .pre_block():
-	 *    - 0 means continue to block the vCPU.
-	 *    - 1 means we cannot block the vCPU since some event
-	 *        happens during this period, such as, 'ON' bit in
-	 *        posted-interrupts descriptor is set.
-	 */
-	int (*pre_block)(struct kvm_vcpu *vcpu);
-	void (*post_block)(struct kvm_vcpu *vcpu);
-
 	void (*vcpu_blocking)(struct kvm_vcpu *vcpu);
 	void (*vcpu_unblocking)(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a24f19874716..13e732a818f3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7462,16 +7462,6 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 		secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_ENABLE_PML);
 }
 
-static int vmx_pre_block(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-
-static void vmx_post_block(struct kvm_vcpu *vcpu)
-{
-
-}
-
 static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mcg_cap & MCG_LMCE_P)
@@ -7665,9 +7655,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.cpu_dirty_log_size = PML_ENTITY_NUM,
 	.update_cpu_dirty_logging = vmx_update_cpu_dirty_logging,
 
-	.pre_block = vmx_pre_block,
-	.post_block = vmx_post_block,
-
 	.pmu_ops = &intel_pmu_ops,
 	.nested_ops = &vmx_nested_ops,
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 909e932a7ae7..9643f23c28c7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9898,8 +9898,7 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 	bool hv_timer;
 
-	if (!kvm_arch_vcpu_runnable(vcpu) &&
-	    (!kvm_x86_ops.pre_block || static_call(kvm_x86_pre_block)(vcpu) == 0)) {
+	if (!kvm_arch_vcpu_runnable(vcpu)) {
 		/*
 		 * Switch to the software timer before halt-polling/blocking as
 		 * the guest's timer may be a break event for the vCPU, and the
@@ -9921,9 +9920,6 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 		if (hv_timer)
 			kvm_lapic_switch_to_hv_timer(vcpu);
 
-		if (kvm_x86_ops.post_block)
-			static_call(kvm_x86_post_block)(vcpu);
-
 		if (!kvm_check_request(KVM_REQ_UNHALT, vcpu))
 			return 1;
 	}
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
