Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9CADC61E926
	for <lists+kvmarm@lfdr.de>; Mon,  7 Nov 2022 04:13:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D8A214B89B;
	Sun,  6 Nov 2022 22:13:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered)
	header.i=@brainfault-org.20210112.gappssmtp.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6CO4Zr9DiHT; Sun,  6 Nov 2022 22:13:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 70EBB4B8A8;
	Sun,  6 Nov 2022 22:13:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C143F4B89B
 for <kvmarm@lists.cs.columbia.edu>; Sun,  6 Nov 2022 22:13:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id smJiG2sfD4pT for <kvmarm@lists.cs.columbia.edu>;
 Sun,  6 Nov 2022 22:13:38 -0500 (EST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4CD8B4B889
 for <kvmarm@lists.cs.columbia.edu>; Sun,  6 Nov 2022 22:13:38 -0500 (EST)
Received: by mail-ej1-f49.google.com with SMTP id ud5so26778125ejc.4
 for <kvmarm@lists.cs.columbia.edu>; Sun, 06 Nov 2022 19:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSzSSykdSUMY4z4QifNhRv3KUDv6uVGdlzhODRpQKlU=;
 b=Q5Al979g3+9Gavat8UlkB2Vleew+RmRbxdo+12K5r30eUrjF3YlGq0gOgvyYiLB3mt
 xgUU5ersVZgrB7+2jJY/bYXwsyIwwhtdWpcjxIdfzpDR5elbZNcB3K1l5DpUeR+BlciO
 idhic3khR724h6Kur7YB5I6R8BRlRfSrPOCcVMYpVLmUdl3EmI7WB0tcku7Xie02geae
 eDiGCrNsXaCEqHNBI+afAsQfH8ga4ziKwv6dMs7TpaKnqLBYnx3mO1Kmkb76PW7I4nHp
 zTYmmE0IV6+5AUD6cMBbhksIlq29dbZUxDj36O2JK9+DFGax2INM4cuyGR/ddy4VkTs8
 0+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSzSSykdSUMY4z4QifNhRv3KUDv6uVGdlzhODRpQKlU=;
 b=CkmYxZaAtd3kUMYdDb+XiB5EJDbYLHW0ToNUprRaCbcC1ANA+PPOphwJwOHbNY3Otz
 BqN0ToLQT45hMlrrN6ZXd375L1dpgP3dUuE8AQtR19kTa3e56AlaPKo1VLIYqhjUh8UX
 wN41oeDBX9IHC+PNOkW3g7IE4pSsOQvt/aTCalqdfbGSykz6CRaxYuuQXihNvxKqkamn
 MqO9+CVSEONBJ/gC2X6iin5CfqEmUXI/YPZO4xxfuLB97GTUXMI011LfnR0Xj1GZD8zJ
 k444NPJ15j8yJi0bLUWT4JiEGQzZ4B/s3aecnritXxH5dkCoTkP49bLxz/EPe+NrzUMj
 9XWg==
X-Gm-Message-State: ACrzQf0yqlVe8VofjMRfNLcPFfyuqPwEkhaf7PDj4i8wI122QOlXIDgj
 t7R9GBGKR7dKcHNR8GVVAc6zlBAgpDK4tWQX6aV51w==
X-Google-Smtp-Source: AMsMyM7D2DoscbPAWYNYytpiXrSBqYxlapsLxGuKk8BIHT4WrARNfmGmCFDOprFU5TU26yMJOep8BKHwirYzuxZh2l8=
X-Received: by 2002:a17:906:dac8:b0:741:545b:796a with SMTP id
 xi8-20020a170906dac800b00741545b796amr45641186ejb.240.1667790817058; Sun, 06
 Nov 2022 19:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-28-seanjc@google.com>
In-Reply-To: <20221102231911.3107438-28-seanjc@google.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 7 Nov 2022 08:43:25 +0530
Message-ID: <CAAhSdy0NME71v2QMBWG-OFn1LLvGVZ=Gvadfiw70+OpZ2uLdPQ@mail.gmail.com>
Subject: Re: [PATCH 27/44] KVM: Drop kvm_arch_{init,exit}() hooks
To: Sean Christopherson <seanjc@google.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Yuan Yao <yuan.yao@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
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
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
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

On Thu, Nov 3, 2022 at 4:50 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Drop kvm_arch_init() and kvm_arch_exit() now that all implementations
> are nops.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/arm64/kvm/arm.c                | 11 -----------
>  arch/mips/kvm/mips.c                | 10 ----------
>  arch/powerpc/include/asm/kvm_host.h |  1 -
>  arch/powerpc/kvm/powerpc.c          |  5 -----
>  arch/riscv/kvm/main.c               |  9 ---------
>  arch/s390/kvm/kvm-s390.c            | 10 ----------
>  arch/x86/kvm/x86.c                  | 10 ----------
>  include/linux/kvm_host.h            |  3 ---
>  virt/kvm/kvm_main.c                 | 19 ++-----------------
>  9 files changed, 2 insertions(+), 76 deletions(-)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 6e0061eac627..75c5125b0dd3 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2284,17 +2284,6 @@ static __init int kvm_arm_init(void)
>         return err;
>  }
>
> -int kvm_arch_init(void *opaque)
> -{
> -       return 0;
> -}
> -
> -/* NOP: Compiling as a module not supported */
> -void kvm_arch_exit(void)
> -{
> -
> -}
> -
>  static int __init early_kvm_mode_cfg(char *arg)
>  {
>         if (!arg)
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index ae7a24342fdf..3cade648827a 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1010,16 +1010,6 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>         return r;
>  }
>
> -int kvm_arch_init(void *opaque)
> -{
> -       return 0;
> -}
> -
> -void kvm_arch_exit(void)
> -{
> -
> -}
> -
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>                                   struct kvm_sregs *sregs)
>  {
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 5d2c3a487e73..0a80e80c7b9e 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -881,7 +881,6 @@ static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
>  static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
> -static inline void kvm_arch_exit(void) {}
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 36c27381a769..34278042ad27 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -2525,11 +2525,6 @@ void kvmppc_init_lpid(unsigned long nr_lpids_param)
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_init_lpid);
>
> -int kvm_arch_init(void *opaque)
> -{
> -       return 0;
> -}
> -
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ppc_instr);
>
>  void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index cb063b8a9a0f..4710a6751687 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -65,15 +65,6 @@ void kvm_arch_hardware_disable(void)
>         csr_write(CSR_HIDELEG, 0);
>  }
>
> -int kvm_arch_init(void *opaque)
> -{
> -       return 0;
> -}
> -
> -void kvm_arch_exit(void)
> -{
> -}
> -
>  static int __init riscv_kvm_init(void)
>  {
>         const char *str;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f6ae845bc1c1..7c1c6d81b5d7 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -533,16 +533,6 @@ static void __kvm_s390_exit(void)
>         debug_unregister(kvm_s390_dbf_uv);
>  }
>
> -int kvm_arch_init(void *opaque)
> -{
> -       return 0;
> -}
> -
> -void kvm_arch_exit(void)
> -{
> -
> -}
> -
>  /* Section: device related */
>  long kvm_arch_dev_ioctl(struct file *filp,
>                         unsigned int ioctl, unsigned long arg)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 218707597bea..2b4530a33298 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9271,16 +9271,6 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
>         kvm_pmu_ops_update(ops->pmu_ops);
>  }
>
> -int kvm_arch_init(void *opaque)
> -{
> -       return 0;
> -}
> -
> -void kvm_arch_exit(void)
> -{
> -
> -}
> -
>  static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  {
>         u64 host_pat;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9b52bd40be56..6c2a28c4c684 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1423,9 +1423,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>                                         struct kvm_guest_debug *dbg);
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu);
>
> -int kvm_arch_init(void *opaque);
> -void kvm_arch_exit(void);
> -
>  void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu);
>
>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 27ce263a80e4..17c852cb6842 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5833,20 +5833,8 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
>         int r;
>         int cpu;
>
> -       /*
> -        * FIXME: Get rid of kvm_arch_init(), vendor code should call arch code
> -        * directly.  Note, kvm_arch_init() _must_ be called before anything
> -        * else as x86 relies on checks buried in kvm_arch_init() to guard
> -        * against multiple calls to kvm_init().
> -        */
> -       r = kvm_arch_init(opaque);
> -       if (r)
> -               return r;
> -
> -       if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL)) {
> -               r = -ENOMEM;
> -               goto err_hw_enabled;
> -       }
> +       if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL))
> +               return -ENOMEM;
>
>         c.ret = &r;
>         c.opaque = opaque;
> @@ -5934,8 +5922,6 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
>         cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
>  out_free_2:
>         free_cpumask_var(cpus_hardware_enabled);
> -err_hw_enabled:
> -       kvm_arch_exit();
>         return r;
>  }
>  EXPORT_SYMBOL_GPL(kvm_init);
> @@ -5963,7 +5949,6 @@ void kvm_exit(void)
>         on_each_cpu(hardware_disable_nolock, NULL, 1);
>         kvm_irqfd_exit();
>         free_cpumask_var(cpus_hardware_enabled);
> -       kvm_arch_exit();
>  }
>  EXPORT_SYMBOL_GPL(kvm_exit);
>
> --
> 2.38.1.431.g37b22c650d-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
