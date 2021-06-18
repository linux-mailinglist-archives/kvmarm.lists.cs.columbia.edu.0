Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1547D3AC469
	for <lists+kvmarm@lfdr.de>; Fri, 18 Jun 2021 09:01:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 809A440212;
	Fri, 18 Jun 2021 03:01:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.09
X-Spam-Level: 
X-Spam-Status: No, score=-4.09 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01, URIBL_RED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c7Ap1k-4izxr; Fri, 18 Jun 2021 03:01:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BB25C4A1A7;
	Fri, 18 Jun 2021 03:01:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D04D49F6C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 03:01:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnrbmrzK4EeV for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Jun 2021 03:01:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 16FC240821
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 03:01:02 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 602FF613A9;
 Fri, 18 Jun 2021 07:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623999661;
 bh=ZRGwwAUAzylgsP7owXfWJpwsoI7wygcM9r7LbOfxcI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=avKza7oGlS6T/xJyYJ6l/NWEWrugGpP5KDEBonnaufhEKFeIlDWGAbYvza8u9mgvo
 FxeFh7LzgjZtu7QNHhmqwgbkQ+jmyqCqWauXATKyme1MQ6+LPcgszUI4+Uc/b8B9mx
 ueu3X9qraFKXSKEwo9SBsBRt0ZGKovJlnpewgryY=
Date: Fri, 18 Jun 2021 09:00:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary
 stats data
Message-ID: <YMxEqvKyGnZinMOS@kroah.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-3-jingzhangos@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210618044819.3690166-3-jingzhangos@google.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>,
 David Matlack <dmatlack@google.com>, Jim Mattson <jmattson@google.com>,
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

On Fri, Jun 18, 2021 at 04:48:14AM +0000, Jing Zhang wrote:
> This commit defines the API for userspace and prepare the common
> functionalities to support per VM/VCPU binary stats data readings.
> 
> The KVM stats now is only accessible by debugfs, which has some
> shortcomings this change series are supposed to fix:
> 1. The current debugfs stats solution in KVM could be disabled
>    when kernel Lockdown mode is enabled, which is a potential
>    rick for production.
> 2. The current debugfs stats solution in KVM is organized as "one
>    stats per file", it is good for debugging, but not efficient
>    for production.
> 3. The stats read/clear in current debugfs solution in KVM are
>    protected by the global kvm_lock.
> 
> Besides that, there are some other benefits with this change:
> 1. All KVM VM/VCPU stats can be read out in a bulk by one copy
>    to userspace.
> 2. A schema is used to describe KVM statistics. From userspace's
>    perspective, the KVM statistics are self-describing.
> 3. With the fd-based solution, a separate telemetry would be able
>    to read KVM stats in a less privileged environment.
> 4. After the initial setup by reading in stats descriptors, a
>    telemetry only needs to read the stats data itself, no more
>    parsing or setup is needed.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com> #arm64
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  arch/arm64/kvm/Makefile   |   2 +-
>  arch/mips/kvm/Makefile    |   2 +-
>  arch/powerpc/kvm/Makefile |   2 +-
>  arch/s390/kvm/Makefile    |   3 +-
>  arch/x86/kvm/Makefile     |   2 +-
>  include/linux/kvm_host.h  | 145 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h  |  42 +++++++++++
>  virt/kvm/binary_stats.c   | 130 ++++++++++++++++++++++++++++++++++
>  8 files changed, 323 insertions(+), 5 deletions(-)
>  create mode 100644 virt/kvm/binary_stats.c
> 
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 589921392cb1..989bb5dad2c8 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_KVM) += kvm.o
>  obj-$(CONFIG_KVM) += hyp/
>  
>  kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
> -	 $(KVM)/vfio.o $(KVM)/irqchip.o \
> +	 $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
>  	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
>  	 inject_fault.o va_layout.o handle_exit.o \
>  	 guest.o debug.o reset.o sys_regs.o \
> diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
> index 30cc060857c7..c67250a956b8 100644
> --- a/arch/mips/kvm/Makefile
> +++ b/arch/mips/kvm/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for KVM support for MIPS
>  #
>  
> -common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o)
> +common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o binary_stats.o)
>  
>  EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
>  
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 2bfeaa13befb..b347d043b932 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -6,7 +6,7 @@
>  ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
>  KVM := ../../../virt/kvm
>  
> -common-objs-y = $(KVM)/kvm_main.o $(KVM)/eventfd.o
> +common-objs-y = $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
>  common-objs-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
>  common-objs-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
>  
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 12decca22e7c..b3aaadc60ead 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -4,7 +4,8 @@
>  # Copyright IBM Corp. 2008
>  
>  KVM := ../../../virt/kvm
> -common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o $(KVM)/vfio.o
> +common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o \
> +	      $(KVM)/irqchip.o $(KVM)/vfio.o $(KVM)/binary_stats.o
>  
>  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
>  
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 83331376b779..75dfd27b6e8a 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -11,7 +11,7 @@ KVM := ../../../virt/kvm
>  
>  kvm-y			+= $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
>  				$(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o \
> -				$(KVM)/dirty_ring.o
> +				$(KVM)/dirty_ring.o $(KVM)/binary_stats.o
>  kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
>  
>  kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5a31e0696360..2f0d12064ae7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1272,6 +1272,12 @@ struct kvm_stats_debugfs_item {
>  	int mode;
>  };
>  
> +#define KVM_STATS_NAME_LEN	48
> +struct _kvm_stats_desc {
> +	struct kvm_stats_desc desc;
> +	char name[KVM_STATS_NAME_LEN];
> +};
> +
>  #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
>  	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
>  
> @@ -1285,8 +1291,147 @@ struct kvm_stats_debugfs_item {
>  	{ n, offsetof(struct kvm_vcpu, stat.generic.x),			       \
>  	  KVM_STAT_VCPU, ## __VA_ARGS__ }
>  
> +#define STATS_DESC_COMMON(type, unit, base, exp)			       \
> +	.flags = type | unit | base |					       \
> +	    BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |		       \
> +	    BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |		       \
> +	    BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),		       \
> +	.exponent = exp,						       \
> +	.size = 1
> +
> +#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp)		       \
> +	{								       \
> +		{							       \
> +			STATS_DESC_COMMON(type, unit, base, exp),	       \
> +			.offset = offsetof(struct kvm_vm_stat, generic.stat)   \
> +		},							       \
> +		.name = #stat,						       \
> +	}
> +#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp)		       \
> +	{								       \
> +		{							       \
> +			STATS_DESC_COMMON(type, unit, base, exp),	       \
> +			.offset = offsetof(struct kvm_vcpu_stat, generic.stat) \
> +		},							       \
> +		.name = #stat,						       \
> +	}
> +#define VM_STATS_DESC(stat, type, unit, base, exp)			       \
> +	{								       \
> +		{							       \
> +			STATS_DESC_COMMON(type, unit, base, exp),	       \
> +			.offset = offsetof(struct kvm_vm_stat, stat)	       \
> +		},							       \
> +		.name = #stat,						       \
> +	}
> +#define VCPU_STATS_DESC(stat, type, unit, base, exp)			       \
> +	{								       \
> +		{							       \
> +			STATS_DESC_COMMON(type, unit, base, exp),	       \
> +			.offset = offsetof(struct kvm_vcpu_stat, stat)	       \
> +		},							       \
> +		.name = #stat,						       \
> +	}
> +/* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC */
> +#define STATS_DESC(SCOPE, stat, type, unit, base, exp)			       \
> +	SCOPE##_STATS_DESC(stat, type, unit, base, exp)
> +
> +#define STATS_DESC_CUMULATIVE(SCOPE, name, unit, base, exponent)	       \
> +	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_CUMULATIVE,		       \
> +		      unit, base, exponent)
> +#define STATS_DESC_INSTANT(SCOPE, name, unit, base, exponent)		       \
> +	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_INSTANT, unit, base, exponent)  \
> +
> +/* Cumulative counter */
> +#define STATS_DESC_COUNTER(SCOPE, name)					       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Instantaneous counter */
> +#define STATS_DESC_ICOUNTER(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +
> +/* Cumulative clock cycles */
> +#define STATS_DESC_CYCLE(SCOPE, name)					       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_CYCLES,	       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Instantaneous clock cycles */
> +#define STATS_DESC_ICYCLE(SCOPE, name)					       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_CYCLES,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +
> +/* Cumulative memory size in Byte */
> +#define STATS_DESC_SIZE_BYTE(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
> +		KVM_STATS_BASE_POW2, 0)
> +/* Cumulative memory size in KiByte */
> +#define STATS_DESC_SIZE_KBYTE(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
> +		KVM_STATS_BASE_POW2, 10)
> +/* Cumulative memory size in MiByte */
> +#define STATS_DESC_SIZE_MBYTE(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
> +		KVM_STATS_BASE_POW2, 20)
> +/* Cumulative memory size in GiByte */
> +#define STATS_DESC_SIZE_GBYTE(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
> +		KVM_STATS_BASE_POW2, 30)
> +
> +/* Instantaneous memory size in Byte */
> +#define STATS_DESC_ISIZE_BYTE(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 0)
> +/* Instantaneous memory size in KiByte */
> +#define STATS_DESC_ISIZE_KBYTE(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 10)
> +/* Instantaneous memory size in MiByte */
> +#define STATS_DESC_ISIZE_MBYTE(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 20)
> +/* Instantaneous memory size in GiByte */
> +#define STATS_DESC_ISIZE_GBYTE(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 30)
> +
> +/* Cumulative time in second */
> +#define STATS_DESC_TIME_SEC(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Cumulative time in millisecond */
> +#define STATS_DESC_TIME_MSEC(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
> +		KVM_STATS_BASE_POW10, -3)
> +/* Cumulative time in microsecond */
> +#define STATS_DESC_TIME_USEC(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
> +		KVM_STATS_BASE_POW10, -6)
> +/* Cumulative time in nanosecond */
> +#define STATS_DESC_TIME_NSEC(SCOPE, name)				       \
> +	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
> +		KVM_STATS_BASE_POW10, -9)
> +
> +/* Instantaneous time in second */
> +#define STATS_DESC_ITIME_SEC(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Instantaneous time in millisecond */
> +#define STATS_DESC_ITIME_MSEC(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -3)
> +/* Instantaneous time in microsecond */
> +#define STATS_DESC_ITIME_USEC(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -6)
> +/* Instantaneous time in nanosecond */
> +#define STATS_DESC_ITIME_NSEC(SCOPE, name)				       \
> +	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -9)
> +
>  extern struct kvm_stats_debugfs_item debugfs_entries[];
>  extern struct dentry *kvm_debugfs_dir;
> +ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
> +		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
> +		char __user *user_buffer, size_t size, loff_t *offset);
>  
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 9febe1412f7a..ab73e905105c 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1086,6 +1086,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_ENFORCE_CPUID 199
>  #define KVM_CAP_SREGS2 200
>  #define KVM_CAP_EXIT_HYPERCALL 201
> +#define KVM_CAP_BINARY_STATS_FD 202
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -1905,4 +1906,45 @@ struct kvm_dirty_gfn {
>  #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
>  #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
>  
> +#define KVM_STATS_ID_MAXLEN		64
> +
> +struct kvm_stats_header {
> +	__u32 name_size;
> +	__u32 count;
> +	__u32 desc_offset;
> +	__u32 data_offset;
> +	char id[];
> +};

You mentioned before that the size of this really is the size of the
structure + KVM_STATS_ID_MAXLEN, right?  Or is it - KVM_STATS_ID_MAXLEN?

If so, why not put that value explicitly in:
	char id[THE_REST_OF_THE_HEADER_SPACE];

As this is not a variable header size at all, and you can not change it
going forward, so the variable length array here feels disingenuous.



> +
> +#define KVM_STATS_TYPE_SHIFT		0
> +#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
> +
> +#define KVM_STATS_UNIT_SHIFT		4
> +#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
> +
> +#define KVM_STATS_BASE_SHIFT		8
> +#define KVM_STATS_BASE_MASK		(0xF << KVM_STATS_BASE_SHIFT)
> +#define KVM_STATS_BASE_POW10		(0x0 << KVM_STATS_BASE_SHIFT)
> +#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
> +#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
> +
> +struct kvm_stats_desc {
> +	__u32 flags;
> +	__s16 exponent;
> +	__u16 size;
> +	__u32 offset;
> +	__u32 unused;
> +	char name[];
> +};

What is the max length of name?

Why aren't these structures defined here in kerneldoc so that we can
understand them better?  Putting them in a .rst file guarantees they
will get out of sync, and you can always directly import the kerneldoc
into the .rst file.

thanks,

greg k-h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
