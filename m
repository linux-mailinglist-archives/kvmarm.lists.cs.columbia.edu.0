Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BDF243A2F0C
	for <lists+kvmarm@lfdr.de>; Thu, 10 Jun 2021 17:08:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 23BAB4A3B4;
	Thu, 10 Jun 2021 11:08:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvGNwxziQgVE; Thu, 10 Jun 2021 11:08:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C497940CF9;
	Thu, 10 Jun 2021 11:08:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0372F40874
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Jun 2021 11:08:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id keW+BjY-EnhI for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Jun 2021 11:08:18 -0400 (EDT)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6CA1340839
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Jun 2021 11:08:18 -0400 (EDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G16Yn5pqWz6L6GR;
 Thu, 10 Jun 2021 22:58:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 17:08:16 +0200
Received: from localhost (10.52.126.112) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 16:08:15 +0100
Date: Thu, 10 Jun 2021 16:08:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 1/5] KVM: arm64: Replace power_off with mp_state in
 struct kvm_vcpu_arch
Message-ID: <20210610160812.0000679b@Huawei.com>
In-Reply-To: <20210608154805.216869-2-jean-philippe@linaro.org>
References: <20210608154805.216869-1-jean-philippe@linaro.org>
 <20210608154805.216869-2-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.52.126.112]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: salil.mehta@huawei.com, lorenzo.pieralisi@arm.com, kvm@vger.kernel.org,
 corbet@lwn.net, maz@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
 catalin.marinas@arm.com, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Tue,  8 Jun 2021 17:48:02 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> In order to add a new "suspend" power state, replace power_off with
> mp_state in struct kvm_vcpu_arch. Factor the vcpu_off() function while
> we're here.

Hi Jean-Phillipe,

2 changes, so if you do end up doing a v2 I'd prefer the
factor out of kvm_arm_vcpu_power_off() + possibly introduced
kvm_arm_vcpu_is_off() using the old boolean.
Then the change in how you track the state will be a bit easier to
pick out.

> 
> No functional change intended.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  arch/arm64/include/asm/kvm_host.h |  6 ++++--
>  arch/arm64/kvm/arm.c              | 29 +++++++++++++++--------------
>  arch/arm64/kvm/psci.c             | 19 ++++++-------------
>  3 files changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 7cd7d5c8c4bc..55a04f4d5919 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -340,8 +340,8 @@ struct kvm_vcpu_arch {
>  		u32	mdscr_el1;
>  	} guest_debug_preserved;
>  
> -	/* vcpu power-off state */
> -	bool power_off;
> +	/* vcpu power state (runnable, stopped, halted) */
> +	u32 mp_state;
>  
>  	/* Don't run the guest (internal implementation need) */
>  	bool pause;
> @@ -720,6 +720,8 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
>  			       struct kvm_device_attr *attr);
>  int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  			       struct kvm_device_attr *attr);
> +void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
> +bool kvm_arm_vcpu_is_off(struct kvm_vcpu *vcpu);
>  
>  /* Guest/host FPSIMD coordination helpers */
>  int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e720148232a0..bcc24adb9c0a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -435,21 +435,22 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  	vcpu->cpu = -1;
>  }
>  
> -static void vcpu_power_off(struct kvm_vcpu *vcpu)
> +void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu)
>  {
> -	vcpu->arch.power_off = true;
> +	vcpu->arch.mp_state = KVM_MP_STATE_STOPPED;
>  	kvm_make_request(KVM_REQ_SLEEP, vcpu);
>  	kvm_vcpu_kick(vcpu);
>  }
>  
> +bool kvm_arm_vcpu_is_off(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.mp_state == KVM_MP_STATE_STOPPED;
> +}
> +
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> -	if (vcpu->arch.power_off)
> -		mp_state->mp_state = KVM_MP_STATE_STOPPED;
> -	else
> -		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
> -
> +	mp_state->mp_state = vcpu->arch.mp_state;

Nice to have a blank line here.

>  	return 0;
>  }
>  
> @@ -460,10 +461,10 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  
>  	switch (mp_state->mp_state) {
>  	case KVM_MP_STATE_RUNNABLE:
> -		vcpu->arch.power_off = false;
> +		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  		break;
>  	case KVM_MP_STATE_STOPPED:
> -		vcpu_power_off(vcpu);
> +		kvm_arm_vcpu_power_off(vcpu);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -483,7 +484,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>  {
>  	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF);
>  	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
> -		&& !v->arch.power_off && !v->arch.pause);
> +		&& !kvm_arm_vcpu_is_off(v) && !v->arch.pause);
>  }
>  
>  bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
> @@ -643,10 +644,10 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
>  	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
>  
>  	rcuwait_wait_event(wait,
> -			   (!vcpu->arch.power_off) &&(!vcpu->arch.pause),
> +			   !kvm_arm_vcpu_is_off(vcpu) && !vcpu->arch.pause,
>  			   TASK_INTERRUPTIBLE);
>  
> -	if (vcpu->arch.power_off || vcpu->arch.pause) {
> +	if (kvm_arm_vcpu_is_off(vcpu) || vcpu->arch.pause) {
>  		/* Awaken to handle a signal, request we sleep again later. */
>  		kvm_make_request(KVM_REQ_SLEEP, vcpu);
>  	}
> @@ -1087,9 +1088,9 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>  	 * Handle the "start in power-off" case.
>  	 */
>  	if (test_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
> -		vcpu_power_off(vcpu);
> +		kvm_arm_vcpu_power_off(vcpu);
>  	else
> -		vcpu->arch.power_off = false;
> +		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  
>  	return 0;
>  }
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index db4056ecccfd..24b4a2265dbd 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -52,13 +52,6 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
>  	return PSCI_RET_SUCCESS;
>  }
>  
> -static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
> -{
> -	vcpu->arch.power_off = true;
> -	kvm_make_request(KVM_REQ_SLEEP, vcpu);
> -	kvm_vcpu_kick(vcpu);
> -}
> -
>  static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  {
>  	struct vcpu_reset_state *reset_state;
> @@ -78,7 +71,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	 */
>  	if (!vcpu)
>  		return PSCI_RET_INVALID_PARAMS;
> -	if (!vcpu->arch.power_off) {
> +	if (!kvm_arm_vcpu_is_off(vcpu)) {
>  		if (kvm_psci_version(source_vcpu, kvm) != KVM_ARM_PSCI_0_1)
>  			return PSCI_RET_ALREADY_ON;
>  		else
> @@ -107,7 +100,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	 */
>  	smp_wmb();
>  
> -	vcpu->arch.power_off = false;
> +	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  	kvm_vcpu_wake_up(vcpu);
>  
>  	return PSCI_RET_SUCCESS;
> @@ -142,7 +135,7 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>  		mpidr = kvm_vcpu_get_mpidr_aff(tmp);
>  		if ((mpidr & target_affinity_mask) == target_affinity) {
>  			matching_cpus++;
> -			if (!tmp->arch.power_off)
> +			if (!kvm_arm_vcpu_is_off(tmp))
>  				return PSCI_0_2_AFFINITY_LEVEL_ON;
>  		}
>  	}
> @@ -168,7 +161,7 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  	 * re-initialized.
>  	 */
>  	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
> -		tmp->arch.power_off = true;
> +		tmp->arch.mp_state = KVM_MP_STATE_STOPPED;
>  	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
>  
>  	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
> @@ -237,7 +230,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		val = kvm_psci_vcpu_suspend(vcpu);
>  		break;
>  	case PSCI_0_2_FN_CPU_OFF:
> -		kvm_psci_vcpu_off(vcpu);
> +		kvm_arm_vcpu_power_off(vcpu);
>  		val = PSCI_RET_SUCCESS;
>  		break;
>  	case PSCI_0_2_FN_CPU_ON:
> @@ -350,7 +343,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
>  
>  	switch (psci_fn) {
>  	case KVM_PSCI_FN_CPU_OFF:
> -		kvm_psci_vcpu_off(vcpu);
> +		kvm_arm_vcpu_power_off(vcpu);
>  		val = PSCI_RET_SUCCESS;
>  		break;
>  	case KVM_PSCI_FN_CPU_ON:

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
