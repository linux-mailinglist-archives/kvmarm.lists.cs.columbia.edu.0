Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2378C6195A2
	for <lists+kvmarm@lfdr.de>; Fri,  4 Nov 2022 12:47:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D59341075;
	Fri,  4 Nov 2022 07:47:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oC1sbIPOop0O; Fri,  4 Nov 2022 07:47:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0E134965C;
	Fri,  4 Nov 2022 07:47:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D004649F38
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 03:17:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXEaqZf-G4Gn for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 03:17:52 -0400 (EDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6A95249AF7
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 03:17:52 -0400 (EDT)
Received: by mail-pl1-f179.google.com with SMTP id g24so4125725plq.3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 04 Nov 2022 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W23pabEUt9UT3m96J/wXQrFDRtY2GakEItww0qjsSlg=;
 b=BBZsjNO1j2I9XyaCh+1C/QplBxwDB5vhB+H7e4gqHEmyQuF09JOrwCCVKtCrWle/V9
 chEyO5+47qEl+CAwKw4HczIJoOXA4u45YQ4pFc+tm1m/PYd7/pDyPWWmGXcEaYOG5WOG
 km826IeGruUsR1J8w/qHNbzrKwDEGoOOeidLlN+lT1AI7WAXrqVt3wu+X7a7S3qChiiQ
 +PoxgUS5+oRknQ7tcAC7hLCL+ws/LhR0FvDQv4v+gajs4KG64mX3ZIq6NdgF0X7pw0TH
 Nqp2Puq0UKysdQS/Q19gKjy2epUVXKYiN5tLrpvE0wCKlIsupCTYYxKngeigPBT/YDAE
 4rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W23pabEUt9UT3m96J/wXQrFDRtY2GakEItww0qjsSlg=;
 b=gatmSzPajeNu/r7jwqkcptBBvsGzFGiYYtqBG1UsDO6Dn/mmd873xZl0PHNPBOspJR
 pN9ScJxybXSDuwjoh0FRf8xdFXgCdt3jcTUzseUmFnGtD2UpX8aeLE0BAvwXIKqfdJ+z
 jg3GU59jpaz87E3XEVnvIR4Dz1tIBVpNWsdeYqSW76jqqeM/pv3WK3REyu1hVd1Xjeag
 ivbSoZyQ/bqHeyVKD/jsTtvUmA8cfASxBLojhTkN3Tz17Rs0GXdTyDJtgIZuozOKvLWR
 I6jzQDCGc0QqYyDg+LE0v8mLiTBzgMqZ81WpXHEpwiMZZP1PDR976WqB/f/GfMyooY82
 T7Ag==
X-Gm-Message-State: ACrzQf0zboPOInCtXIs0hiDNx6Jks2eOg0pE8mAtc302Jpy4aiBRq1vS
 FI18k5k79/hI8ak8LlZF8lw=
X-Google-Smtp-Source: AMsMyM590YqBBuU8ntwjS0byOPhDdbEQtOmQylRukKVmf0RiQ9hBMt6zvQhScFlRTTpMvabF9XrhuA==
X-Received: by 2002:a17:902:6542:b0:187:27fa:eef1 with SMTP id
 d2-20020a170902654200b0018727faeef1mr22696721pln.2.1667546271367; 
 Fri, 04 Nov 2022 00:17:51 -0700 (PDT)
Received: from localhost ([192.55.54.55]) by smtp.gmail.com with ESMTPSA id
 m5-20020a170902db0500b001708c4ebbaesm1787361plx.309.2022.11.04.00.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Nov 2022 00:17:50 -0700 (PDT)
Date: Fri, 4 Nov 2022 00:17:49 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 00/44] KVM: Rework kvm_init() and hardware enabling
Message-ID: <20221104071749.GC1063309@ls.amr.corp.intel.com>
References: <20221102231911.3107438-1-seanjc@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
X-Mailman-Approved-At: Fri, 04 Nov 2022 07:47:47 -0400
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Yuan Yao <yuan.yao@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-riscv@lists.infradead.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 isaku.yamahata@gmail.com, linux-s390@vger.kernel.org,
 Janosch Frank <frankja@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Chao Gao <chao.gao@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
 Atish Patra <atishp@atishpatra.org>, kvmarm@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, linux-mips@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, kvm-riscv@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
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

On Wed, Nov 02, 2022 at 11:18:27PM +0000,
Sean Christopherson <seanjc@google.com> wrote:

> Non-x86 folks, please test on hardware when possible.  I made a _lot_ of
> mistakes when moving code around.  Thankfully, x86 was the trickiest code
> to deal with, and I'm fairly confident that I found all the bugs I
> introduced via testing.  But the number of mistakes I made and found on
> x86 makes me more than a bit worried that I screwed something up in other
> arch code.
> 
> This is a continuation of Chao's series to do x86 CPU compatibility checks
> during virtualization hardware enabling[1], and of Isaku's series to try
> and clean up the hardware enabling paths so that x86 (Intel specifically)
> can temporarily enable hardware during module initialization without
> causing undue pain for other architectures[2].  It also includes one patch
> from another mini-series from Isaku that provides the less controversial
> patches[3].
> 
> The main theme of this series is to kill off kvm_arch_init(),
> kvm_arch_hardware_(un)setup(), and kvm_arch_check_processor_compat(), which
> all originated in x86 code from way back when, and needlessly complicate
> both common KVM code and architecture code.  E.g. many architectures don't
> mark functions/data as __init/__ro_after_init purely because kvm_init()
> isn't marked __init to support x86's separate vendor modules.
> 
> The idea/hope is that with those hooks gone (moved to arch code), it will
> be easier for x86 (and other architectures) to modify their module init
> sequences as needed without having to fight common KVM code.  E.g. I'm
> hoping that ARM can build on this to simplify its hardware enabling logic,
> especially the pKVM side of things.
> 
> There are bug fixes throughout this series.  They are more scattered than
> I would usually prefer, but getting the sequencing correct was a gigantic
> pain for many of the x86 fixes due to needing to fix common code in order
> for the x86 fix to have any meaning.  And while the bugs are often fatal,
> they aren't all that interesting for most users as they either require a
> malicious admin or broken hardware, i.e. aren't likely to be encountered
> by the vast majority of KVM users.  So unless someone _really_ wants a
> particular fix isolated for backporting, I'm not planning on shuffling
> patches.
> 
> Tested on x86.  Lightly tested on arm64.  Compile tested only on all other
> architectures.

Thanks for the patch series. I the rebased TDX KVM patch series and it worked.
Since cpu offline needs to be rejected in some cases(To keep at least one cpu
on a package), arch hook for cpu offline is needed.
I can keep it in TDX KVM patch series.

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 23c0f4bc63f1..ef7bcb845d42 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -17,6 +17,7 @@ BUILD_BUG_ON(1)
 KVM_X86_OP(hardware_enable)
 KVM_X86_OP(hardware_disable)
 KVM_X86_OP(hardware_unsetup)
+KVM_X86_OP_OPTIONAL_RET0(offline_cpu)
 KVM_X86_OP(has_emulated_msr)
 KVM_X86_OP(vcpu_after_set_cpuid)
 KVM_X86_OP(is_vm_type_supported)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 496c7c6eaff9..c420409aa96f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1468,6 +1468,7 @@ struct kvm_x86_ops {
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
 	void (*hardware_unsetup)(void);
+	int (*offline_cpu)(void);
 	bool (*has_emulated_msr)(struct kvm *kvm, u32 index);
 	void (*vcpu_after_set_cpuid)(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2ed5a017f7bc..17c5d6a76c93 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12039,6 +12039,11 @@ void kvm_arch_hardware_disable(void)
 	drop_user_return_notifiers();
 }
 
+int kvm_arch_offline_cpu(unsigned int cpu)
+{
+	return static_call(kvm_x86_offline_cpu)();
+}
+
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.bsp_vcpu_id == vcpu->vcpu_id;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 620489b9aa93..4df79443fd11 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1460,6 +1460,7 @@ static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
 #endif
+int kvm_arch_offline_cpu(unsigned int cpu);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f6b6dcedaa0a..f770fdc662d0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5396,16 +5396,24 @@ static void hardware_disable_nolock(void *junk)
 	__this_cpu_write(hardware_enabled, false);
 }
 
+__weak int kvm_arch_offline_cpu(unsigned int cpu)
+{
+	return 0;
+}
+
 static int kvm_offline_cpu(unsigned int cpu)
 {
+	int r = 0;
+
 	mutex_lock(&kvm_lock);
-	if (kvm_usage_count) {
+	r = kvm_arch_offline_cpu(cpu);
+	if (!r && kvm_usage_count) {
 		preempt_disable();
 		hardware_disable_nolock(NULL);
 		preempt_enable();
 	}
 	mutex_unlock(&kvm_lock);
-	return 0;
+	return r;
 }
 
 static void hardware_disable_all_nolock(void)

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
