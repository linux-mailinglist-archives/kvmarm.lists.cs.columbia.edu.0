Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 11615448049
	for <lists+kvmarm@lfdr.de>; Mon,  8 Nov 2021 14:30:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E2E804B23C;
	Mon,  8 Nov 2021 08:30:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ibm.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bDS4EaWZX754; Mon,  8 Nov 2021 08:30:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D99D4B22A;
	Mon,  8 Nov 2021 08:30:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD70D4B1BD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Nov 2021 08:19:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9-9zXzpUoAtc for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Nov 2021 08:19:28 -0500 (EST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 970BB4B173
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Nov 2021 08:19:28 -0500 (EST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8BVjpj011343; 
 Mon, 8 Nov 2021 13:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=tO9J68T6dugNoJpwwppvs8tTbmLbm1qXxehdAk72Ho0=;
 b=WP+TzDRRMReG4jzSp7eYxKF34sAiWzTg3/K51yZZWnoC4UG+A68sL17lkAJke64Xf3zh
 4gllDBYaxPKDWizcW0dfeogzo34TK+N6Qq50Je3TmEHceQY+GVITtbfUXCn8/6gScsdk
 M4lfEFokv1F7jERNt8AGkF+Qu28oIseWdDn8wtpxWHTJtKTKErumZuiVbiSBGi6thNS6
 v25hGMoCsHLeAHUoiLEQlutbChm11BVW/oKvVdCP/OkSP67Tyxkb0FYm6D8QABXjS0Ai
 4CfmY9p+dlgN3CVpJAjdLD9F7J3EsKIpd5jM7Uk2mfUIubwVeDs1GFGcUC71bRC2XhKN 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3c67qcf1ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Nov 2021 13:19:19 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A8D1a3e001140;
 Mon, 8 Nov 2021 13:19:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3c67qcf1e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Nov 2021 13:19:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A8DDjd7024378;
 Mon, 8 Nov 2021 13:19:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 3c5gyj6f48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Nov 2021 13:19:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1A8DJDUw60162454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Nov 2021 13:19:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F9B34205C;
 Mon,  8 Nov 2021 13:19:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41AF942072;
 Mon,  8 Nov 2021 13:19:12 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.11.147])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  8 Nov 2021 13:19:12 +0000 (GMT)
Date: Mon, 8 Nov 2021 13:12:02 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/5] KVM: Move wiping of the kvm->vcpus array to common
 code
Message-ID: <20211108131202.774812b9@p-imbrenda>
In-Reply-To: <20211105192101.3862492-2-maz@kernel.org>
References: <20211105192101.3862492-1-maz@kernel.org>
 <20211105192101.3862492-2-maz@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8mYXWMdMPVgpwC7GFr3_KXd1sKvdMkVU
X-Proofpoint-ORIG-GUID: XztAnVpBiEcmznvaQpyKQ2UrXf-dxOyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_05,2021-11-08_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080082
X-Mailman-Approved-At: Mon, 08 Nov 2021 08:30:26 -0500
Cc: Juergen Gross <jgross@suse.com>, Anup Patel <anup.patel@wdc.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, David Hildenbrand <david@redhat.com>,
 linux-mips@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Atish Patra <atish.patra@wdc.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kernel-team@android.com,
 linuxppc-dev@lists.ozlabs.org, kvmarm@lists.cs.columbia.edu
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

On Fri,  5 Nov 2021 19:20:57 +0000
Marc Zyngier <maz@kernel.org> wrote:

> All architectures have similar loops iterating over the vcpus,
> freeing one vcpu at a time, and eventually wiping the reference
> off the vcpus array. They are also inconsistently taking
> the kvm->lock mutex when wiping the references from the array.
> 
> Make this code common, which will simplify further changes.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

no objections

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/arm64/kvm/arm.c       | 10 +---------
>  arch/mips/kvm/mips.c       | 21 +--------------------
>  arch/powerpc/kvm/powerpc.c | 10 +---------
>  arch/riscv/kvm/vm.c        | 10 +---------
>  arch/s390/kvm/kvm-s390.c   | 18 +-----------------
>  arch/x86/kvm/x86.c         |  9 +--------
>  include/linux/kvm_host.h   |  2 +-
>  virt/kvm/kvm_main.c        | 20 ++++++++++++++++++--
>  8 files changed, 25 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index f5490afe1ebf..75bb7215da03 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -175,19 +175,11 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
>   */
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> -	int i;
> -
>  	bitmap_free(kvm->arch.pmu_filter);
>  
>  	kvm_vgic_destroy(kvm);
>  
> -	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
> -		if (kvm->vcpus[i]) {
> -			kvm_vcpu_destroy(kvm->vcpus[i]);
> -			kvm->vcpus[i] = NULL;
> -		}
> -	}
> -	atomic_set(&kvm->online_vcpus, 0);
> +	kvm_destroy_vcpus(kvm);
>  }
>  
>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 562aa878b266..ceacca74f808 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -171,25 +171,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	return 0;
>  }
>  
> -void kvm_mips_free_vcpus(struct kvm *kvm)
> -{
> -	unsigned int i;
> -	struct kvm_vcpu *vcpu;
> -
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		kvm_vcpu_destroy(vcpu);
> -	}
> -
> -	mutex_lock(&kvm->lock);
> -
> -	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
> -		kvm->vcpus[i] = NULL;
> -
> -	atomic_set(&kvm->online_vcpus, 0);
> -
> -	mutex_unlock(&kvm->lock);
> -}
> -
>  static void kvm_mips_free_gpa_pt(struct kvm *kvm)
>  {
>  	/* It should always be safe to remove after flushing the whole range */
> @@ -199,7 +180,7 @@ static void kvm_mips_free_gpa_pt(struct kvm *kvm)
>  
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> -	kvm_mips_free_vcpus(kvm);
> +	kvm_destroy_vcpus(kvm);
>  	kvm_mips_free_gpa_pt(kvm);
>  }
>  
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 35e9cccdeef9..492e4a4121cb 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -463,9 +463,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> -	unsigned int i;
> -	struct kvm_vcpu *vcpu;
> -
>  #ifdef CONFIG_KVM_XICS
>  	/*
>  	 * We call kick_all_cpus_sync() to ensure that all
> @@ -476,14 +473,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  		kick_all_cpus_sync();
>  #endif
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_vcpu_destroy(vcpu);
> +	kvm_destroy_vcpus(kvm);
>  
>  	mutex_lock(&kvm->lock);
> -	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
> -		kvm->vcpus[i] = NULL;
> -
> -	atomic_set(&kvm->online_vcpus, 0);
>  
>  	kvmppc_core_destroy_vm(kvm);
>  
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 26399df15b63..6af6cde295eb 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -46,15 +46,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> -	int i;
> -
> -	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
> -		if (kvm->vcpus[i]) {
> -			kvm_vcpu_destroy(kvm->vcpus[i]);
> -			kvm->vcpus[i] = NULL;
> -		}
> -	}
> -	atomic_set(&kvm->online_vcpus, 0);
> +	kvm_destroy_vcpus(kvm);
>  }
>  
>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c6257f625929..7af53b8788fa 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2819,27 +2819,11 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  	free_page((unsigned long)(vcpu->arch.sie_block));
>  }
>  
> -static void kvm_free_vcpus(struct kvm *kvm)
> -{
> -	unsigned int i;
> -	struct kvm_vcpu *vcpu;
> -
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_vcpu_destroy(vcpu);
> -
> -	mutex_lock(&kvm->lock);
> -	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
> -		kvm->vcpus[i] = NULL;
> -
> -	atomic_set(&kvm->online_vcpus, 0);
> -	mutex_unlock(&kvm->lock);
> -}
> -
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
>  	u16 rc, rrc;
>  
> -	kvm_free_vcpus(kvm);
> +	kvm_destroy_vcpus(kvm);
>  	sca_dispose(kvm);
>  	kvm_s390_gisa_destroy(kvm);
>  	/*
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c1c4e2b05a63..498a43126615 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11302,15 +11302,8 @@ static void kvm_free_vcpus(struct kvm *kvm)
>  		kvm_clear_async_pf_completion_queue(vcpu);
>  		kvm_unload_vcpu_mmu(vcpu);
>  	}
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_vcpu_destroy(vcpu);
> -
> -	mutex_lock(&kvm->lock);
> -	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
> -		kvm->vcpus[i] = NULL;
>  
> -	atomic_set(&kvm->online_vcpus, 0);
> -	mutex_unlock(&kvm->lock);
> +	kvm_destroy_vcpus(kvm);
>  }
>  
>  void kvm_arch_sync_events(struct kvm *kvm)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 60a35d9fe259..36967291b8c6 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -725,7 +725,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
>  		if (WARN_ON_ONCE(!memslot->npages)) {			\
>  		} else
>  
> -void kvm_vcpu_destroy(struct kvm_vcpu *vcpu);
> +void kvm_destroy_vcpus(struct kvm *kvm);
>  
>  void vcpu_load(struct kvm_vcpu *vcpu);
>  void vcpu_put(struct kvm_vcpu *vcpu);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 3f6d450355f0..d83553eeea21 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -435,7 +435,7 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
>  	vcpu->last_used_slot = 0;
>  }
>  
> -void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
> +static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
>  	kvm_dirty_ring_free(&vcpu->dirty_ring);
>  	kvm_arch_vcpu_destroy(vcpu);
> @@ -450,7 +450,23 @@ void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
>  	free_page((unsigned long)vcpu->run);
>  	kmem_cache_free(kvm_vcpu_cache, vcpu);
>  }
> -EXPORT_SYMBOL_GPL(kvm_vcpu_destroy);
> +
> +void kvm_destroy_vcpus(struct kvm *kvm)
> +{
> +	unsigned int i;
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_vcpu_destroy(vcpu);
> +
> +	mutex_lock(&kvm->lock);
> +	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
> +		kvm->vcpus[i] = NULL;
> +
> +	atomic_set(&kvm->online_vcpus, 0);
> +	mutex_unlock(&kvm->lock);
> +}
> +EXPORT_SYMBOL_GPL(kvm_destroy_vcpus);
>  
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
