Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B674B38A066
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 10:58:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5996F4B712;
	Thu, 20 May 2021 04:58:08 -0400 (EDT)
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
	with ESMTP id jzDRkv2baMId; Thu, 20 May 2021 04:58:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E06214B7C2;
	Thu, 20 May 2021 04:58:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E0974B85D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 13:13:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GbAXnezP0Krh for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 May 2021 13:13:03 -0400 (EDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E47F14B84C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 13:13:02 -0400 (EDT)
Received: by mail-lf1-f50.google.com with SMTP id w33so12252036lfu.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DfjUqHmCmnu7yIMNZnryU3AtCo+l2P2auq9JwOqAvss=;
 b=TJVD0xL+1N7ZyR09pBbsnt7XuX6vDt1h0+JPTVNu1R1R6ZQGd6r4xMs05tnbTyrOw5
 uwHAp2TQcUr4WThKuH1XUREhI8NBxp0uaOkUQ0A9eTaJuopnyifLUohRcJRBpazLMJFN
 2d5BzTMYua8E+/q8AputebLP1waxTD8vJH2WEE1RlYrVKKgkv7rOSwHWFFPtNWg+c+7e
 1IvYvandcFZ5wkq58gNAeMUZfF6mUPKIVyTWHh/j4nWcwUl0ftBbbCjO6lSxi12kc8d8
 1hTPML+Gfx/8+g7F4Miq6MTUD+OelCMH7oImlRMLb54S8/tGr8egfUwmJUAEVw79cPxH
 p7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfjUqHmCmnu7yIMNZnryU3AtCo+l2P2auq9JwOqAvss=;
 b=s4Nlg6SQmBHyYcI2My4xO+m4x5tBUzXenJBNDInl8MR/GRmo0y5bI1nUg8WdrEAB7y
 /4W75Ub8SOIRJ+47x+2BP8/bKNfg75noq/i6Hb/YdbhNixTRbyodq8pKfQwkGHhqFL0d
 EZPmVCUJSQ19wlleOPJrPHm7KD/jypaS3CwJmU8ipELBCUciJ1whg7sJuhbQzhOv+Hq/
 vAl08EcyZO44TVxZ6buNpCdt6fqPsqYl22/NjiXGSQawqgTO9hAQn8jd+4nL2COLNUJR
 NibFhk6ihsA+X1EVTTZSx4XbsyrAGoya3ft8axTKjt1K/BK4FtTNllBROGo3CHB+OELC
 xXDg==
X-Gm-Message-State: AOAM531EdScfoGoYXfnpRP8FvNqcCaTwZGRHSsCAeLZsdJiim8zk5tCp
 AGj5K2Vzj/d1gUQvsIEkrHuzwF4N6MfligoCfinJTw==
X-Google-Smtp-Source: ABdhPJxb3Q3zg9MJTvsfBa/d9ZL8ExGXzECSl2lvYs0DCCfFbyY6yK2PHtslDKzXKRhkKIuudh6NxXyhhpjBxKBSbfM=
X-Received: by 2002:a05:6512:acc:: with SMTP id n12mr372920lfu.9.1621444380943; 
 Wed, 19 May 2021 10:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-3-jingzhangos@google.com>
In-Reply-To: <20210517145314.157626-3-jingzhangos@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 19 May 2021 10:12:34 -0700
Message-ID: <CALzav=cX3iEvpJCOWV+vhKD55uoVMRB9STmU+W0v9CvnqyRcJA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] KVM: stats: Add fd-based API to read binary stats
 data
To: Jing Zhang <jingzhangos@google.com>
X-Mailman-Approved-At: Thu, 20 May 2021 04:58:01 -0400
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Mon, May 17, 2021 at 9:32 AM Jing Zhang <jingzhangos@google.com> wrote:
>
> Provides a file descriptor per VM to read VM stats info/data.
> Provides a file descriptor per vCPU to read vCPU stats info/data.
>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  arch/arm64/kvm/guest.c    |  26 +++++
>  arch/mips/kvm/mips.c      |  52 +++++++++
>  arch/powerpc/kvm/book3s.c |  52 +++++++++
>  arch/powerpc/kvm/booke.c  |  45 ++++++++
>  arch/s390/kvm/kvm-s390.c  | 117 ++++++++++++++++++++
>  arch/x86/kvm/x86.c        |  53 +++++++++
>  include/linux/kvm_host.h  | 127 ++++++++++++++++++++++
>  include/uapi/linux/kvm.h  |  50 +++++++++
>  virt/kvm/kvm_main.c       | 223 ++++++++++++++++++++++++++++++++++++++
>  9 files changed, 745 insertions(+)
>
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 0e41331b0911..1cc1d83630ac 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -28,6 +28,32 @@
>
>  #include "trace.h"
>
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC();
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +       STATS_DESC_COUNTER("hvc_exit_stat"),
> +       STATS_DESC_COUNTER("wfe_exit_stat"),
> +       STATS_DESC_COUNTER("wfi_exit_stat"),
> +       STATS_DESC_COUNTER("mmio_exit_user"),
> +       STATS_DESC_COUNTER("mmio_exit_kernel"),
> +       STATS_DESC_COUNTER("exits"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vcpu_stats_desc),
> +};
> +
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
>         VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
>         VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index f4fc60c05e9c..f17a65743ccd 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -38,6 +38,58 @@
>  #define VECTORSPACING 0x100    /* for EI/VI mode */
>  #endif
>
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC();
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +       STATS_DESC_COUNTER("wait_exits"),
> +       STATS_DESC_COUNTER("cache_exits"),
> +       STATS_DESC_COUNTER("signal_exits"),
> +       STATS_DESC_COUNTER("int_exits"),
> +       STATS_DESC_COUNTER("cop_unusable_exits"),
> +       STATS_DESC_COUNTER("tlbmod_exits"),
> +       STATS_DESC_COUNTER("tlbmiss_ld_exits"),
> +       STATS_DESC_COUNTER("tlbmiss_st_exits"),
> +       STATS_DESC_COUNTER("addrerr_st_exits"),
> +       STATS_DESC_COUNTER("addrerr_ld_exits"),
> +       STATS_DESC_COUNTER("syscall_exits"),
> +       STATS_DESC_COUNTER("resvd_inst_exits"),
> +       STATS_DESC_COUNTER("break_inst_exits"),
> +       STATS_DESC_COUNTER("trap_inst_exits"),
> +       STATS_DESC_COUNTER("msa_fpe_exits"),
> +       STATS_DESC_COUNTER("fpe_exits"),
> +       STATS_DESC_COUNTER("msa_disabled_exits"),
> +       STATS_DESC_COUNTER("flush_dcache_exits"),
> +#ifdef CONFIG_KVM_MIPS_VZ
> +       STATS_DESC_COUNTER("vz_gpsi_exits"),
> +       STATS_DESC_COUNTER("vz_gsfc_exits"),
> +       STATS_DESC_COUNTER("vz_hc_exits"),
> +       STATS_DESC_COUNTER("vz_grr_exits"),
> +       STATS_DESC_COUNTER("vz_gva_exits"),
> +       STATS_DESC_COUNTER("vz_ghfc_exits"),
> +       STATS_DESC_COUNTER("vz_gpa_exits"),
> +       STATS_DESC_COUNTER("vz_resvd_exits"),
> +#ifdef CONFIG_CPU_LOONGSON64
> +       STATS_DESC_COUNTER("vz_cpucfg_exits"),
> +#endif
> +#endif
> +       );
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vcpu_stats_desc),
> +};
> +
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
>         VCPU_STAT("wait", wait_exits),
>         VCPU_STAT("cache", cache_exits),
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index bd3a10e1fdaf..5e8ee0d39ef9 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -38,6 +38,58 @@
>
>  /* #define EXIT_DEBUG */
>
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +       STATS_DESC_ICOUNTER("num_2M_pages"),
> +       STATS_DESC_ICOUNTER("num_1G_pages"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +       STATS_DESC_COUNTER("sum_exits"),
> +       STATS_DESC_COUNTER("mmio_exits"),
> +       STATS_DESC_COUNTER("signal_exits"),
> +       STATS_DESC_COUNTER("light_exits"),
> +       STATS_DESC_COUNTER("itlb_real_miss_exits"),
> +       STATS_DESC_COUNTER("itlb_virt_miss_exits"),
> +       STATS_DESC_COUNTER("dtlb_real_miss_exits"),
> +       STATS_DESC_COUNTER("dtlb_virt_miss_exits"),
> +       STATS_DESC_COUNTER("syscall_exits"),
> +       STATS_DESC_COUNTER("isi_exits"),
> +       STATS_DESC_COUNTER("dsi_exits"),
> +       STATS_DESC_COUNTER("emulated_inst_exits"),
> +       STATS_DESC_COUNTER("dec_exits"),
> +       STATS_DESC_COUNTER("ext_intr_exits"),
> +       STATS_DESC_TIME_NSEC("halt_wait_ns"),
> +       STATS_DESC_COUNTER("halt_successful_wait"),
> +       STATS_DESC_COUNTER("dbell_exits"),
> +       STATS_DESC_COUNTER("gdbell_exits"),
> +       STATS_DESC_COUNTER("ld"),
> +       STATS_DESC_COUNTER("st"),
> +       STATS_DESC_COUNTER("pf_storage"),
> +       STATS_DESC_COUNTER("pf_instruc"),
> +       STATS_DESC_COUNTER("sp_storage"),
> +       STATS_DESC_COUNTER("sp_instruc"),
> +       STATS_DESC_COUNTER("queue_intr"),
> +       STATS_DESC_COUNTER("ld_slow"),
> +       STATS_DESC_COUNTER("st_slow"),
> +       STATS_DESC_COUNTER("pthru_all"),
> +       STATS_DESC_COUNTER("pthru_host"),
> +       STATS_DESC_COUNTER("pthru_bad_aff"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vcpu_stats_desc),
> +};
> +
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
>         VCPU_STAT("exits", sum_exits),
>         VCPU_STAT("mmio", mmio_exits),
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 07fdd7a1254a..86d221e9193e 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -36,6 +36,51 @@
>
>  unsigned long kvmppc_booke_handlers;
>
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +       STATS_DESC_ICOUNTER("num_2M_pages"),
> +       STATS_DESC_ICOUNTER("num_1G_pages"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +       STATS_DESC_COUNTER("sum_exits"),
> +       STATS_DESC_COUNTER("mmio_exits"),
> +       STATS_DESC_COUNTER("signal_exits"),
> +       STATS_DESC_COUNTER("light_exits"),
> +       STATS_DESC_COUNTER("itlb_real_miss_exits"),
> +       STATS_DESC_COUNTER("itlb_virt_miss_exits"),
> +       STATS_DESC_COUNTER("dtlb_real_miss_exits"),
> +       STATS_DESC_COUNTER("dtlb_virt_miss_exits"),
> +       STATS_DESC_COUNTER("syscall_exits"),
> +       STATS_DESC_COUNTER("isi_exits"),
> +       STATS_DESC_COUNTER("dsi_exits"),
> +       STATS_DESC_COUNTER("emulated_inst_exits"),
> +       STATS_DESC_COUNTER("dec_exits"),
> +       STATS_DESC_COUNTER("ext_intr_exits"),
> +       STATS_DESC_TIME_NSEC("halt_wait_ns"),
> +       STATS_DESC_COUNTER("halt_successful_wait"),
> +       STATS_DESC_COUNTER("dbell_exits"),
> +       STATS_DESC_COUNTER("gdbell_exits"),
> +       STATS_DESC_COUNTER("ld"),
> +       STATS_DESC_COUNTER("st"),
> +       STATS_DESC_COUNTER("pthru_all"),
> +       STATS_DESC_COUNTER("pthru_host"),
> +       STATS_DESC_COUNTER("pthru_bad_aff"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vcpu_stats_desc),
> +};
> +
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
>         VCPU_STAT("mmio", mmio_exits),
>         VCPU_STAT("sig", signal_exits),
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d6bf3372bb10..003feee79fce 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -58,6 +58,123 @@
>  #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
>                            (KVM_MAX_VCPUS + LOCAL_IRQS))
>
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +       STATS_DESC_COUNTER("inject_io"),
> +       STATS_DESC_COUNTER("inject_float_mchk"),
> +       STATS_DESC_COUNTER("inject_pfault_done"),
> +       STATS_DESC_COUNTER("inject_service_signal"),
> +       STATS_DESC_COUNTER("inject_virtio"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +       STATS_DESC_COUNTER("exit_userspace"),
> +       STATS_DESC_COUNTER("exit_null"),
> +       STATS_DESC_COUNTER("exit_external_request"),
> +       STATS_DESC_COUNTER("exit_io_request"),
> +       STATS_DESC_COUNTER("exit_external_interrupt"),
> +       STATS_DESC_COUNTER("exit_stop_request"),
> +       STATS_DESC_COUNTER("exit_validity"),
> +       STATS_DESC_COUNTER("exit_instruction"),
> +       STATS_DESC_COUNTER("exit_pei"),
> +       STATS_DESC_COUNTER("halt_no_poll_steal"),
> +       STATS_DESC_COUNTER("instruction_lctl"),
> +       STATS_DESC_COUNTER("instruction_lctlg"),
> +       STATS_DESC_COUNTER("instruction_stctl"),
> +       STATS_DESC_COUNTER("instruction_stctg"),
> +       STATS_DESC_COUNTER("exit_program_interruption"),
> +       STATS_DESC_COUNTER("exit_instr_and_program"),
> +       STATS_DESC_COUNTER("exit_operation_exception"),
> +       STATS_DESC_COUNTER("deliver_ckc"),
> +       STATS_DESC_COUNTER("deliver_cputm"),
> +       STATS_DESC_COUNTER("deliver_external_call"),
> +       STATS_DESC_COUNTER("deliver_emergency_signal"),
> +       STATS_DESC_COUNTER("deliver_service_signal"),
> +       STATS_DESC_COUNTER("deliver_virtio"),
> +       STATS_DESC_COUNTER("deliver_stop_signal"),
> +       STATS_DESC_COUNTER("deliver_prefix_signal"),
> +       STATS_DESC_COUNTER("deliver_restart_signal"),
> +       STATS_DESC_COUNTER("deliver_program"),
> +       STATS_DESC_COUNTER("deliver_io"),
> +       STATS_DESC_COUNTER("deliver_machine_check"),
> +       STATS_DESC_COUNTER("exit_wait_state"),
> +       STATS_DESC_COUNTER("inject_ckc"),
> +       STATS_DESC_COUNTER("inject_cputm"),
> +       STATS_DESC_COUNTER("inject_external_call"),
> +       STATS_DESC_COUNTER("inject_emergency_signal"),
> +       STATS_DESC_COUNTER("inject_mchk"),
> +       STATS_DESC_COUNTER("inject_pfault_init"),
> +       STATS_DESC_COUNTER("inject_program"),
> +       STATS_DESC_COUNTER("inject_restart"),
> +       STATS_DESC_COUNTER("inject_set_prefix"),
> +       STATS_DESC_COUNTER("inject_stop_signal"),
> +       STATS_DESC_COUNTER("instruction_epsw"),
> +       STATS_DESC_COUNTER("instruction_gs"),
> +       STATS_DESC_COUNTER("instruction_io_other"),
> +       STATS_DESC_COUNTER("instruction_lpsw"),
> +       STATS_DESC_COUNTER("instruction_lpswe"),
> +       STATS_DESC_COUNTER("instruction_pfmf"),
> +       STATS_DESC_COUNTER("instruction_ptff"),
> +       STATS_DESC_COUNTER("instruction_sck"),
> +       STATS_DESC_COUNTER("instruction_sckpf"),
> +       STATS_DESC_COUNTER("instruction_stidp"),
> +       STATS_DESC_COUNTER("instruction_spx"),
> +       STATS_DESC_COUNTER("instruction_stpx"),
> +       STATS_DESC_COUNTER("instruction_stap"),
> +       STATS_DESC_COUNTER("instruction_iske"),
> +       STATS_DESC_COUNTER("instruction_ri"),
> +       STATS_DESC_COUNTER("instruction_rrbe"),
> +       STATS_DESC_COUNTER("instruction_sske"),
> +       STATS_DESC_COUNTER("instruction_ipte_interlock"),
> +       STATS_DESC_COUNTER("instruction_stsi"),
> +       STATS_DESC_COUNTER("instruction_stfl"),
> +       STATS_DESC_COUNTER("instruction_tb"),
> +       STATS_DESC_COUNTER("instruction_tpi"),
> +       STATS_DESC_COUNTER("instruction_tprot"),
> +       STATS_DESC_COUNTER("instruction_tsch"),
> +       STATS_DESC_COUNTER("instruction_sie"),
> +       STATS_DESC_COUNTER("instruction_essa"),
> +       STATS_DESC_COUNTER("instruction_sthyi"),
> +       STATS_DESC_COUNTER("instruction_sigp_sense"),
> +       STATS_DESC_COUNTER("instruction_sigp_sense_running"),
> +       STATS_DESC_COUNTER("instruction_sigp_external_call"),
> +       STATS_DESC_COUNTER("instruction_sigp_emergency"),
> +       STATS_DESC_COUNTER("instruction_sigp_cond_emergency"),
> +       STATS_DESC_COUNTER("instruction_sigp_start"),
> +       STATS_DESC_COUNTER("instruction_sigp_stop"),
> +       STATS_DESC_COUNTER("instruction_sigp_stop_store_status"),
> +       STATS_DESC_COUNTER("instruction_sigp_store_status"),
> +       STATS_DESC_COUNTER("instruction_sigp_store_adtl_status"),
> +       STATS_DESC_COUNTER("instruction_sigp_arch"),
> +       STATS_DESC_COUNTER("instruction_sigp_prefix"),
> +       STATS_DESC_COUNTER("instruction_sigp_restart"),
> +       STATS_DESC_COUNTER("instruction_sigp_init_cpu_reset"),
> +       STATS_DESC_COUNTER("instruction_sigp_cpu_reset"),
> +       STATS_DESC_COUNTER("instruction_sigp_unknown"),
> +       STATS_DESC_COUNTER("diagnose_10"),
> +       STATS_DESC_COUNTER("diagnose_44"),
> +       STATS_DESC_COUNTER("diagnose_9c"),
> +       STATS_DESC_COUNTER("diagnose_9c_ignored"),
> +       STATS_DESC_COUNTER("diagnose_258"),
> +       STATS_DESC_COUNTER("diagnose_308"),
> +       STATS_DESC_COUNTER("diagnose_500"),
> +       STATS_DESC_COUNTER("diagnose_other"),
> +       STATS_DESC_COUNTER("pfault_sync"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vcpu_stats_desc),
> +};
> +
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
>         VCPU_STAT("userspace_handled", exit_userspace),
>         VCPU_STAT("exit_null", exit_null),
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9a93d80caff6..84880687c199 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -214,6 +214,59 @@ EXPORT_SYMBOL_GPL(host_xss);
>  u64 __read_mostly supported_xss;
>  EXPORT_SYMBOL_GPL(supported_xss);
>
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +       STATS_DESC_COUNTER("mmu_shadow_zapped"),
> +       STATS_DESC_COUNTER("mmu_pte_write"),
> +       STATS_DESC_COUNTER("mmu_pde_zapped"),
> +       STATS_DESC_COUNTER("mmu_flooded"),
> +       STATS_DESC_COUNTER("mmu_recycled"),
> +       STATS_DESC_COUNTER("mmu_cache_miss"),
> +       STATS_DESC_ICOUNTER("mmu_unsync"),
> +       STATS_DESC_ICOUNTER("largepages"),
> +       STATS_DESC_ICOUNTER("nx_largepages_splits"),
> +       STATS_DESC_ICOUNTER("max_mmu_page_hash_collisions"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +       STATS_DESC_COUNTER("pf_fixed"),
> +       STATS_DESC_COUNTER("pf_guest"),
> +       STATS_DESC_COUNTER("tlb_flush"),
> +       STATS_DESC_COUNTER("invlpg"),
> +       STATS_DESC_COUNTER("exits"),
> +       STATS_DESC_COUNTER("io_exits"),
> +       STATS_DESC_COUNTER("mmio_exits"),
> +       STATS_DESC_COUNTER("signal_exits"),
> +       STATS_DESC_COUNTER("irq_window_exits"),
> +       STATS_DESC_COUNTER("nmi_window_exits"),
> +       STATS_DESC_COUNTER("l1d_flush"),
> +       STATS_DESC_COUNTER("halt_exits"),
> +       STATS_DESC_COUNTER("request_irq_exits"),
> +       STATS_DESC_COUNTER("irq_exits"),
> +       STATS_DESC_COUNTER("host_state_reload"),
> +       STATS_DESC_COUNTER("fpu_reload"),
> +       STATS_DESC_COUNTER("insn_emulation"),
> +       STATS_DESC_COUNTER("insn_emulation_fail"),
> +       STATS_DESC_COUNTER("hypercalls"),
> +       STATS_DESC_COUNTER("irq_injections"),
> +       STATS_DESC_COUNTER("nmi_injections"),
> +       STATS_DESC_COUNTER("req_event"),
> +       STATS_DESC_COUNTER("nested_run"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +       .name_size = KVM_STATS_NAME_LEN,
> +       .count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +       .desc_offset = sizeof(struct kvm_stats_header),
> +       .data_offset = sizeof(struct kvm_stats_header) +
> +               sizeof(kvm_vcpu_stats_desc),
> +};
> +
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
>         VCPU_STAT("pf_fixed", pf_fixed),
>         VCPU_STAT("pf_guest", pf_guest),
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 97700e41db3b..52783f8062ca 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1240,6 +1240,19 @@ struct kvm_stats_debugfs_item {
>         int mode;
>  };
>
> +struct _kvm_stats_header {
> +       __u32 name_size;
> +       __u32 count;
> +       __u32 desc_offset;
> +       __u32 data_offset;
> +};
> +
> +#define KVM_STATS_NAME_LEN     48
> +struct _kvm_stats_desc {
> +       struct kvm_stats_desc desc;
> +       char name[KVM_STATS_NAME_LEN];
> +};
> +
>  #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
>         ((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
>
> @@ -1253,8 +1266,122 @@ struct kvm_stats_debugfs_item {
>         { n, offsetof(struct kvm_vcpu, stat.common.x),                         \
>           KVM_STAT_VCPU, ## __VA_ARGS__ }
>
> +#define STATS_DESC(name, type, unit, scale, exponent)                         \
> +       {                                                                      \
> +               {type | unit | scale, exponent, 1}, name,                      \
> +       }

Suggest using designated initializers here.

> +#define STATS_DESC_CUMULATIVE(name, unit, scale, exponent)                    \
> +       STATS_DESC(name, KVM_STATS_TYPE_CUMULATIVE, unit, scale, exponent)
> +#define STATS_DESC_INSTANT(name, unit, scale, exponent)                               \
> +       STATS_DESC(name, KVM_STATS_TYPE_INSTANT, unit, scale, exponent)
> +
> +/* Cumulative counter */
> +#define STATS_DESC_COUNTER(name)                                              \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_NONE,                       \
> +               KVM_STATS_SCALE_POW10, 0)
> +/* Instantaneous counter */
> +#define STATS_DESC_ICOUNTER(name)                                             \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_NONE,                          \
> +               KVM_STATS_SCALE_POW10, 0)
> +
> +/* Cumulative clock cycles */
> +#define STATS_DESC_CYCLE(name)                                                \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_CYCLES,                     \
> +               KVM_STATS_SCALE_POW10, 0)
> +/* Instantaneous clock cycles */
> +#define STATS_DESC_ICYCLE(name)                                                       \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_CYCLES,                        \
> +               KVM_STATS_SCALE_POW10, 0)
> +
> +/* Cumulative memory size in Byte */
> +#define STATS_DESC_SIZE_BYTE(name)                                            \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> +               KVM_STATS_SCALE_POW2, 0)
> +/* Cumulative memory size in KiByte */
> +#define STATS_DESC_SIZE_KBYTE(name)                                           \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> +               KVM_STATS_SCALE_POW2, 10)
> +/* Cumulative memory size in MiByte */
> +#define STATS_DESC_SIZE_MBYTE(name)                                           \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> +               KVM_STATS_SCALE_POW2, 20)
> +/* Cumulative memory size in GiByte */
> +#define STATS_DESC_SIZE_GBYTE(name)                                           \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> +               KVM_STATS_SCALE_POW2, 30)
> +
> +/* Instantaneous memory size in Byte */
> +#define STATS_DESC_ISIZE_BYTE(name)                                           \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> +               KVM_STATS_SCALE_POW2, 0)
> +/* Instantaneous memory size in KiByte */
> +#define STATS_DESC_ISIZE_KBYTE(name)                                          \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> +               KVM_STATS_SCALE_POW2, 10)
> +/* Instantaneous memory size in MiByte */
> +#define STATS_DESC_ISIZE_MBYTE(name)                                          \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> +               KVM_STATS_SCALE_POW2, 20)
> +/* Instantaneous memory size in GiByte */
> +#define STATS_DESC_ISIZE_GBYTE(name)                                          \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> +               KVM_STATS_SCALE_POW2, 30)
> +
> +/* Cumulative time in second */
> +#define STATS_DESC_TIME_SEC(name)                                             \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> +               KVM_STATS_SCALE_POW10, 0)
> +/* Cumulative time in millisecond */
> +#define STATS_DESC_TIME_MSEC(name)                                            \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> +               KVM_STATS_SCALE_POW10, -3)
> +/* Cumulative time in microsecond */
> +#define STATS_DESC_TIME_USEC(name)                                            \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> +               KVM_STATS_SCALE_POW10, -6)
> +/* Cumulative time in nanosecond */
> +#define STATS_DESC_TIME_NSEC(name)                                            \
> +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> +               KVM_STATS_SCALE_POW10, -9)
> +
> +/* Instantaneous time in second */
> +#define STATS_DESC_ITIME_SEC(name)                                            \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> +               KVM_STATS_SCALE_POW10, 0)
> +/* Instantaneous time in millisecond */
> +#define STATS_DESC_ITIME_MSEC(name)                                           \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> +               KVM_STATS_SCALE_POW10, -3)
> +/* Instantaneous time in microsecond */
> +#define STATS_DESC_ITIME_USEC(name)                                           \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> +               KVM_STATS_SCALE_POW10, -6)
> +/* Instantaneous time in nanosecond */
> +#define STATS_DESC_ITIME_NSEC(name)                                           \
> +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> +               KVM_STATS_SCALE_POW10, -9)
> +
> +#define DEFINE_VM_STATS_DESC(...) {                                           \
> +       STATS_DESC_COUNTER("remote_tlb_flush"),                                \
> +       ## __VA_ARGS__                                                         \
> +}
> +
> +#define DEFINE_VCPU_STATS_DESC(...) {                                         \
> +       STATS_DESC_COUNTER("halt_successful_poll"),                            \
> +       STATS_DESC_COUNTER("halt_attempted_poll"),                             \
> +       STATS_DESC_COUNTER("halt_poll_invalid"),                               \
> +       STATS_DESC_COUNTER("halt_wakeup"),                                     \
> +       STATS_DESC_TIME_NSEC("halt_poll_success_ns"),                          \
> +       STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),                             \
> +       ## __VA_ARGS__                                                         \
> +}
> +
>  extern struct kvm_stats_debugfs_item debugfs_entries[];
>  extern struct dentry *kvm_debugfs_dir;
> +extern struct _kvm_stats_header kvm_vm_stats_header;
> +extern struct _kvm_stats_header kvm_vcpu_stats_header;
> +extern struct _kvm_stats_desc kvm_vm_stats_desc[];
> +extern struct _kvm_stats_desc kvm_vcpu_stats_desc[];
>
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 3fd9a7e9d90c..a64e92c7d9de 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1082,6 +1082,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_SGX_ATTRIBUTE 196
>  #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
>  #define KVM_CAP_PTP_KVM 198
> +#define KVM_CAP_STATS_BINARY_FD 199
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> @@ -1898,4 +1899,53 @@ struct kvm_dirty_gfn {
>  #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
>  #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
>
> +#define KVM_STATS_ID_MAXLEN            64
> +
> +struct kvm_stats_header {
> +       char id[KVM_STATS_ID_MAXLEN];
> +       __u32 name_size;
> +       __u32 count;
> +       __u32 desc_offset;
> +       __u32 data_offset;
> +};
> +
> +#define KVM_STATS_TYPE_SHIFT           0
> +#define KVM_STATS_TYPE_MASK            (0xF << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_CUMULATIVE      (0x0 << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_INSTANT         (0x1 << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_MAX             KVM_STATS_TYPE_INSTANT
> +
> +#define KVM_STATS_UNIT_SHIFT           4
> +#define KVM_STATS_UNIT_MASK            (0xF << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_NONE            (0x0 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_BYTES           (0x1 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_SECONDS         (0x2 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_CYCLES          (0x3 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_MAX             KVM_STATS_UNIT_CYCLES
> +
> +#define KVM_STATS_SCALE_SHIFT          8
> +#define KVM_STATS_SCALE_MASK           (0xF << KVM_STATS_SCALE_SHIFT)
> +#define KVM_STATS_SCALE_POW10          (0x0 << KVM_STATS_SCALE_SHIFT)
> +#define KVM_STATS_SCALE_POW2           (0x1 << KVM_STATS_SCALE_SHIFT)
> +#define KVM_STATS_SCALE_MAX            KVM_STATS_SCALE_POW2
> +
> +struct kvm_stats_desc {
> +       __u32 flags;
> +       __s16 exponent;
> +       __u16 size;
> +       __u32 unused1;
> +       __u32 unused2;
> +       char name[0];
> +};
> +
> +struct kvm_vm_stats_data {
> +       unsigned long value[0];
> +};
> +
> +struct kvm_vcpu_stats_data {
> +       __u64 value[0];
> +};
> +
> +#define KVM_STATS_GETFD  _IOR(KVMIO,  0xcc, struct kvm_stats_header)
> +
>  #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 34a4cf265297..9e2c8dcdeae9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3409,6 +3409,115 @@ static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
>         return 0;
>  }
>
> +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> +                             size_t size, loff_t *offset)
> +{
> +       char id[KVM_STATS_ID_MAXLEN];
> +       struct kvm_vcpu *vcpu = file->private_data;
> +       ssize_t copylen, len, remain = size;
> +       size_t size_header, size_desc, size_stats;
> +       loff_t pos = *offset;
> +       char __user *dest = user_buffer;
> +       void *src;
> +
> +       snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> +                       task_pid_nr(current), vcpu->vcpu_id);
> +       size_header = sizeof(kvm_vcpu_stats_header);
> +       size_desc =
> +               kvm_vcpu_stats_header.count * sizeof(struct _kvm_stats_desc);
> +       size_stats = sizeof(vcpu->stat);
> +
> +       len = sizeof(id) + size_header + size_desc + size_stats - pos;
> +       len = min(len, remain);
> +       if (len <= 0)
> +               return 0;
> +       remain = len;
> +
> +       /* Copy kvm vcpu stats header id string */
> +       copylen = sizeof(id) - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)id + pos;
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }
> +       /* Copy kvm vcpu stats header */
> +       copylen = sizeof(id) + size_header - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)&kvm_vcpu_stats_header;
> +               src += pos - sizeof(id);
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }
> +       /* Copy kvm vcpu stats descriptors */
> +       copylen = kvm_vcpu_stats_header.desc_offset + size_desc - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)&kvm_vcpu_stats_desc;
> +               src += pos - kvm_vcpu_stats_header.desc_offset;
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }

KVM could cache everything above this to avoid the cost of
regenerating it on every read. It would require allocating some extra
memory in the kernel though, so it's not free. But if userspace is
reading stats for every vCPU every second it could be worth it.

> +       /* Copy kvm vcpu stats values */
> +       copylen = kvm_vcpu_stats_header.data_offset + size_stats - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)&vcpu->stat;
> +               src += pos - kvm_vcpu_stats_header.data_offset;
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }
> +
> +       *offset = pos;
> +       return len;
> +}
> +
> +static const struct file_operations kvm_vcpu_stats_fops = {
> +       .read = kvm_vcpu_stats_read,
> +       .llseek = noop_llseek,
> +};
> +
> +static int kvm_vcpu_ioctl_get_statsfd(struct kvm_vcpu *vcpu)
> +{
> +       int error, fd;
> +       struct file *file;
> +       char name[15 + ITOA_MAX_LEN + 1];
> +
> +       snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);

Does this need to be globally unique? I was going to suggest using the
id ("kvm-%d/vcpu-%d") but the slash is probably not allowed. It would
be nice though to have the file name the same as the id though so
maybe change the id and name to something like  "kvm-%d.vcpu-%d"?

> +
> +       error = get_unused_fd_flags(O_CLOEXEC);
> +       if (error < 0)
> +               return error;
> +       fd = error;
> +
> +       file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
> +       if (IS_ERR(file)) {
> +               error = PTR_ERR(file);
> +               goto err_put_unused_fd;
> +       }
> +       file->f_mode |= FMODE_PREAD;
> +       fd_install(fd, file);
> +
> +       return fd;
> +
> +err_put_unused_fd:
> +       put_unused_fd(fd);
> +       return error;
> +}
> +
>  static long kvm_vcpu_ioctl(struct file *filp,
>                            unsigned int ioctl, unsigned long arg)
>  {
> @@ -3606,6 +3715,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
>                 r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
>                 break;
>         }
> +       case KVM_STATS_GETFD: {
> +               r = kvm_vcpu_ioctl_get_statsfd(vcpu);
> +               break;
> +       }
>         default:
>                 r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>         }
> @@ -3864,6 +3977,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  #else
>                 return 0;
>  #endif
> +       case KVM_CAP_STATS_BINARY_FD:
> +               return 1;
>         default:
>                 break;
>         }
> @@ -3967,6 +4082,111 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
>         }
>  }
>
> +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> +                             size_t size, loff_t *offset)
> +{
> +       char id[KVM_STATS_ID_MAXLEN];
> +       struct kvm *kvm = file->private_data;
> +       ssize_t copylen, len, remain = size;
> +       size_t size_header, size_desc, size_stats;
> +       loff_t pos = *offset;
> +       char __user *dest = user_buffer;
> +       void *src;
> +
> +       snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> +       size_header = sizeof(kvm_vm_stats_header);
> +       size_desc = kvm_vm_stats_header.count * sizeof(struct _kvm_stats_desc);
> +       size_stats = sizeof(kvm->stat);
> +
> +       len = sizeof(id) + size_header + size_desc + size_stats - pos;
> +       len = min(len, remain);
> +       if (len <= 0)
> +               return 0;
> +       remain = len;
> +
> +       /* Copy kvm vm stats header id string */
> +       copylen = sizeof(id) - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)id + pos;
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }
> +       /* Copy kvm vm stats header */
> +       copylen = sizeof(id) + size_header - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)&kvm_vm_stats_header;
> +               src += pos - sizeof(id);
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }
> +       /* Copy kvm vm stats descriptors */
> +       copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)&kvm_vm_stats_desc;
> +               src += pos - kvm_vm_stats_header.desc_offset;
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }

Ditto here about caching.


> +       /* Copy kvm vm stats values */
> +       copylen = kvm_vm_stats_header.data_offset + size_stats - pos;
> +       copylen = min(copylen, remain);
> +       if (copylen > 0) {
> +               src = (void *)&kvm->stat;
> +               src += pos - kvm_vm_stats_header.data_offset;
> +               if (copy_to_user(dest, src, copylen))
> +                       return -EFAULT;
> +               remain -= copylen;
> +               pos += copylen;
> +               dest += copylen;
> +       }
> +
> +       *offset = pos;
> +       return len;
> +}
> +
> +static const struct file_operations kvm_vm_stats_fops = {
> +       .read = kvm_vm_stats_read,
> +       .llseek = noop_llseek,
> +};
> +
> +static int kvm_vm_ioctl_get_statsfd(struct kvm *kvm)
> +{
> +       int error, fd;
> +       struct file *file;
> +
> +       error = get_unused_fd_flags(O_CLOEXEC);
> +       if (error < 0)
> +               return error;
> +       fd = error;
> +
> +       file = anon_inode_getfile("kvm-vm-stats",
> +                       &kvm_vm_stats_fops, kvm, O_RDONLY);
> +       if (IS_ERR(file)) {
> +               error = PTR_ERR(file);
> +               goto err_put_unused_fd;
> +       }
> +       file->f_mode |= FMODE_PREAD;
> +       fd_install(fd, file);
> +
> +       return fd;
> +
> +err_put_unused_fd:
> +       put_unused_fd(fd);
> +       return error;
> +}
> +
>  static long kvm_vm_ioctl(struct file *filp,
>                            unsigned int ioctl, unsigned long arg)
>  {
> @@ -4149,6 +4369,9 @@ static long kvm_vm_ioctl(struct file *filp,
>         case KVM_RESET_DIRTY_RINGS:
>                 r = kvm_vm_ioctl_reset_dirty_pages(kvm);
>                 break;
> +       case KVM_STATS_GETFD:
> +               r = kvm_vm_ioctl_get_statsfd(kvm);
> +               break;
>         default:
>                 r = kvm_arch_vm_ioctl(filp, ioctl, arg);
>         }
> --
> 2.31.1.751.gd2f1c929bd-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
