Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4A43E6FD
	for <lists+kvmarm@lfdr.de>; Thu, 28 Oct 2021 19:16:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F39B24B1F1;
	Thu, 28 Oct 2021 13:16:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UqZ44iKc6zwG; Thu, 28 Oct 2021 13:16:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E9E04B1DA;
	Thu, 28 Oct 2021 13:16:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 114CB4B1DF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Oct 2021 11:34:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5YTVwB3uoiQr for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Oct 2021 11:33:59 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A2D24B1DA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Oct 2021 11:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635435239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNmDdkecq8SKnVGFVDimL3g8xbus4hzEhU0dnSsqlkw=;
 b=gnM2uVNPgGm3sJhy5TE11B7tZXgcElx7U4vo9js/OP8b9u2RM5ejv4MIs/PofdaZkJvn98
 9fcNo6NaE0jRxL2H0d1Q0d1pECmmqukOCtWEcrLvIMb04I8ZFlcFSlZqLU0RxNGHJgdXKR
 Q9dvMmCxhZPTu1b38D2aW0X9WCZSuuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-ePtPTvZLPR-5P1TjiMfLTA-1; Thu, 28 Oct 2021 11:33:55 -0400
X-MC-Unique: ePtPTvZLPR-5P1TjiMfLTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48699EC1A0;
 Thu, 28 Oct 2021 15:33:51 +0000 (UTC)
Received: from starship (unknown [10.40.194.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0A7F60BF1;
 Thu, 28 Oct 2021 15:33:38 +0000 (UTC)
Message-ID: <eea801ba765679e34a7a94a947ae7340a5cad796.camel@redhat.com>
Subject: Re: [PATCH v2 31/43] KVM: Move x86 VMX's posted interrupt list_head
 to vcpu_vmx
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, Aleksandar Markovic
 <aleksandar.qemu.devel@gmail.com>, Paul Mackerras <paulus@ozlabs.org>, Anup
 Patel <anup.patel@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Oct 2021 18:33:37 +0300
In-Reply-To: <20211009021236.4122790-32-seanjc@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-32-seanjc@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mailman-Approved-At: Thu, 28 Oct 2021 13:15:59 -0400
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

On Fri, 2021-10-08 at 19:12 -0700, Sean Christopherson wrote:
> Move the seemingly generic block_vcpu_list from kvm_vcpu to vcpu_vmx, and
> rename the list and all associated variables to clarify that it tracks
> the set of vCPU that need to be poked on a posted interrupt to the wakeup
> vector.  The list is not used to track _all_ vCPUs that are blocking, and
> the term "blocked" can be misleading as it may refer to a blocking
> condition in the host or the guest, where as the PI wakeup case is
> specifically for the vCPUs that are actively blocking from within the
> guest.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/posted_intr.c | 39 +++++++++++++++++-----------------
>  arch/x86/kvm/vmx/vmx.c         |  2 ++
>  arch/x86/kvm/vmx/vmx.h         |  3 +++
>  include/linux/kvm_host.h       |  2 --
>  virt/kvm/kvm_main.c            |  2 --
>  5 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index d2b3d75c57d1..f1bcf8c32b6d 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -18,7 +18,7 @@
>   * wake the target vCPUs.  vCPUs are removed from the list and the notification
>   * vector is reset when the vCPU is scheduled in.
>   */
> -static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
> +static DEFINE_PER_CPU(struct list_head, wakeup_vcpus_on_cpu);
This looks good, you can disregard my comment on this variable from previous patch
where I nitpicked about it.

>  /*
>   * Protect the per-CPU list with a per-CPU spinlock to handle task migration.
>   * When a blocking vCPU is awakened _and_ migrated to a different pCPU, the
> @@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
>   * CPU.  IRQs must be disabled when taking this lock, otherwise deadlock will
>   * occur if a wakeup IRQ arrives and attempts to acquire the lock.
>   */
> -static DEFINE_PER_CPU(spinlock_t, blocked_vcpu_on_cpu_lock);
> +static DEFINE_PER_CPU(spinlock_t, wakeup_vcpus_on_cpu_lock);
>  
>  static inline struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
>  {
> @@ -36,6 +36,7 @@ static inline struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
>  void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>  {
>  	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct pi_desc old, new;
>  	unsigned long flags;
>  	unsigned int dest;
> @@ -71,9 +72,9 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>  	 * current pCPU if the task was migrated.
>  	 */
>  	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR) {
> -		spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
> -		list_del(&vcpu->blocked_vcpu_list);
> -		spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
> +		spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
> +		list_del(&vmx->pi_wakeup_list);
> +		spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
>  	}
>  
>  	dest = cpu_physical_id(cpu);
> @@ -121,15 +122,16 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>  static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
>  {
>  	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct pi_desc old, new;
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
>  
> -	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
> -	list_add_tail(&vcpu->blocked_vcpu_list,
> -		      &per_cpu(blocked_vcpu_on_cpu, vcpu->cpu));
> -	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
> +	spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
> +	list_add_tail(&vmx->pi_wakeup_list,
> +		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
> +	spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
>  
>  	WARN(pi_desc->sn, "PI descriptor SN field set before blocking");
>  
> @@ -182,24 +184,23 @@ void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
>   */
>  void pi_wakeup_handler(void)
>  {
> -	struct kvm_vcpu *vcpu;
>  	int cpu = smp_processor_id();
> +	struct vcpu_vmx *vmx;
>  
> -	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> -	list_for_each_entry(vcpu, &per_cpu(blocked_vcpu_on_cpu, cpu),
> -			blocked_vcpu_list) {
> -		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> +	spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
> +	list_for_each_entry(vmx, &per_cpu(wakeup_vcpus_on_cpu, cpu),
> +			    pi_wakeup_list) {
>  
> -		if (pi_test_on(pi_desc))
> -			kvm_vcpu_kick(vcpu);
> +		if (pi_test_on(&vmx->pi_desc))
> +			kvm_vcpu_kick(&vmx->vcpu);
>  	}
> -	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> +	spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
>  }
>  
>  void __init pi_init_cpu(int cpu)
>  {
> -	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> -	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> +	INIT_LIST_HEAD(&per_cpu(wakeup_vcpus_on_cpu, cpu));
> +	spin_lock_init(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
>  }
>  
>  bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 26ed8cd1a1f2..b3bb2031a7ac 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6848,6 +6848,8 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>  	BUILD_BUG_ON(offsetof(struct vcpu_vmx, vcpu) != 0);
>  	vmx = to_vmx(vcpu);
>  
> +	INIT_LIST_HEAD(&vmx->pi_wakeup_list);
> +
>  	err = -ENOMEM;
>  
>  	vmx->vpid = allocate_vpid();
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 592217fd7d92..d1a720be9a64 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -298,6 +298,9 @@ struct vcpu_vmx {
>  	/* Posted interrupt descriptor */
>  	struct pi_desc pi_desc;
>  
> +	/* Used if this vCPU is waiting for PI notification wakeup. */
> +	struct list_head pi_wakeup_list;
> +
>  	/* Support for a guest hypervisor (nested VMX) */
>  	struct nested_vmx nested;
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 87996b22e681..c5961a361c73 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -304,8 +304,6 @@ struct kvm_vcpu {
>  	u64 requests;
>  	unsigned long guest_debug;
>  
> -	struct list_head blocked_vcpu_list;
> -
>  	struct mutex mutex;
>  	struct kvm_run *run;
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2bbf5c9d410f..c1850b60f38b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -426,8 +426,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
>  #endif
>  	kvm_async_pf_vcpu_init(vcpu);
>  
> -	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
> -
>  	kvm_vcpu_set_in_spin_loop(vcpu, false);
>  	kvm_vcpu_set_dy_eligible(vcpu, false);
>  	vcpu->preempted = false;


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
