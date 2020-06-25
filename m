Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 29708209DCE
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jun 2020 13:54:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C6314B4CE;
	Thu, 25 Jun 2020 07:54:02 -0400 (EDT)
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
	with ESMTP id gxygzhOClJTj; Thu, 25 Jun 2020 07:54:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FD824B4CC;
	Thu, 25 Jun 2020 07:54:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 326D44B4C7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jun 2020 07:53:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFDI-F77aOnA for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jun 2020 07:53:58 -0400 (EDT)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 001674B4A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jun 2020 07:53:57 -0400 (EDT)
Received: by mail-wr1-f68.google.com with SMTP id s10so5503811wrw.12
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jun 2020 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CW6BYTLV8RVUMjaLp+LWWUGTwyDc3MgC2HjUHbF/G2s=;
 b=MhOzW3yI+siMjHTtYaiCz2XLI6/mry8izaTQaA34GiRDbsBr88f4b3j8djs9+W84H4
 F+tDSo9EVncOoAMEqTx3X5wJsmZn3M3Phy8Ait0ENNBBAuKcEFkQkOgU4YaEj/fMgFkN
 4qGDx8jnpdvv4MTKVr6SE2n7URh3I3WOvT8qwnrx26Z/a5zvG5xtwrGZRoj73cNfJnLC
 nYLmhjOcqQBfKnKjbGTp7DPyAIOn8vR019zIH0M4SzNBjAc4PS/zfjgw6TZ8z6PU0qxV
 RdkFK9ebW2V1iQfgLGgGt0MmWs1sUY+I1jWGbdLNOAYbZ3AJCooZimhraUf0vFkOVwsS
 UJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CW6BYTLV8RVUMjaLp+LWWUGTwyDc3MgC2HjUHbF/G2s=;
 b=HAJkZgcLN1BX/dT5bj9F6pkkx3anpjbqfHnC+wcvlSUq8p/yXYgFwEVCBd37/53h7R
 mX607SNqOR2/K+uTJ6znReuPemIvzFq0wMgYNXngd1GGiZ42XXCnmbo1gJKE5lIwyJN4
 OF7NS7u4HQIDfw0au5FMXipdguGt3LrIIM5nU8roiqeueBJk8+c9v1pqyrxSjmm3NJuJ
 HdnWa9s4HIX3lULv5+PF2zphS31tnfXF46qLoICQN0W+ie69fsXz1U0bkIolyJey7+DJ
 hmCp36HfSWLuYFbKjx8it/xrmn4eGM2Cl32dztY+AgsR1kWZ9VwQriYDu+Rfz9befkcX
 VuyA==
X-Gm-Message-State: AOAM532Ic4gwlTIl85Lvp3xsmYDq4vPm2K3pkBMxG9oapIbvhRbABpZd
 znEYf7xsYzUqJMWT7q7sl6Xv/g==
X-Google-Smtp-Source: ABdhPJy559uKp/8Pf7fBmRXt3yEfg0Q4Vzy6+P4IVjpOo/VV24C39KBymKP81gddL3dRbcznwrSMKA==
X-Received: by 2002:adf:e749:: with SMTP id c9mr39236061wrn.25.1593086036592; 
 Thu, 25 Jun 2020 04:53:56 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
 by smtp.gmail.com with ESMTPSA id h203sm12165406wme.37.2020.06.25.04.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 04:53:55 -0700 (PDT)
Date: Thu, 25 Jun 2020 12:53:55 +0100
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 05/15] arm64: kvm: Build hyp-entry.S separately for
 VHE/nVHE
Message-ID: <20200625115355.iqt3np4m6gjmpbap@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-6-dbrazdil@google.com>
 <5029f8fb4a7816e11de7469c09347c79@kernel.org>
 <20200622102041.myve2otyoj5q7j5s@google.com>
 <491f3c8877897a4ac69d69fb7354c1cb@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <491f3c8877897a4ac69d69fb7354c1cb@kernel.org>
Cc: kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

Hey Marc,

> I'd be happy with the (maybe temporary) magic approach. It helps reasoning
> about things, and makes the transition smoother. Yes, bugs could crop up
> there, but given the static nature of obtaining a symbol's address, I'm
> fairly confident we'll get it right. The same cannot be said about pointers
> though.

Ok, so this is what it would look like:

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6a682d66a640..0d1b3b1946f0 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -59,13 +59,14 @@
 #define DECLARE_KVM_HYP_SYM(sym)               \
        DECLARE_KVM_VHE_SYM(sym);               \
        DECLARE_KVM_NVHE_SYM(sym)
+#define CHOOSE_HYP_SYM(sym) (has_vhe() ? sym : kvm_nvhe_sym(sym))

 /* Translate a kernel address of @sym into its equivalent linear mapping */
-#define kvm_ksym_ref(sym)                                              \
+#define kvm_ksym_ref(ptr)                                              \
        ({                                                              \
-               void *val = &sym;                                       \
+               void *val = (ptr);                                      \
                if (!is_kernel_in_hyp_mode())                           \
-                       val = lm_alias(&sym);                           \
+                       val = lm_alias((ptr));                          \
                val;                                                    \
         })
 #define kvm_ksym_ref_nvhe(sym) kvm_ksym_ref(kvm_nvhe_sym(sym))
@@ -76,7 +77,14 @@ struct kvm_vcpu;
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];

-extern char __kvm_hyp_vector[];
+DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
+#define __kvm_hyp_vector CHOOSE_HYP_SYM(__kvm_hyp_vector)
+
+#ifdef CONFIG_KVM_INDIRECT_VECTORS
+DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);
+#define __bp_harden_hyp_vecs CHOOSE_HYP_SYM(__bp_harden_hyp_vecs)
+extern atomic_t arm64_el2_vector_last_slot;
+#endif

 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);

Everything compiles and boots. Only existing code I had to change was:

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 90cb90561446..34b551385153 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1285,7 +1285,7 @@ static void cpu_init_hyp_mode(void)
         * so that we can use adr_l to access per-cpu variables in EL2.
         */
        tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
-                    (unsigned long)kvm_ksym_ref(kvm_host_data));
+                    (unsigned long)kvm_ksym_ref(&kvm_host_data));

        pgd_ptr = kvm_mmu_get_httbr();
        hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;

WDYT?

Thanks,
-David

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
