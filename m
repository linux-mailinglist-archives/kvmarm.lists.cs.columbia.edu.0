Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B1C653DC572
	for <lists+kvmarm@lfdr.de>; Sat, 31 Jul 2021 11:33:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 647F04AED4;
	Sat, 31 Jul 2021 05:33:59 -0400 (EDT)
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
	with ESMTP id teRCIe1KYgyk; Sat, 31 Jul 2021 05:33:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 65A7A4B0BA;
	Sat, 31 Jul 2021 05:33:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F5664B0AC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Jul 2021 14:34:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7nypm2gjJAs for <kvmarm@lists.cs.columbia.edu>;
 Fri, 30 Jul 2021 14:34:55 -0400 (EDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DD5284B0B2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Jul 2021 14:34:54 -0400 (EDT)
Received: by mail-pj1-f50.google.com with SMTP id
 k4-20020a17090a5144b02901731c776526so22029249pjm.4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Jul 2021 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MHVKyzd14+bXJS6plIu4IUmaJdRagfuE25k0EE+Xexw=;
 b=vxfy/3IexWWM1pPBriCm2dHZSmDkdeDDKnaVyebUTS0Ge5XOF41vnT42NaOhMvE2LU
 0ikO0Bflto39Qz/417FEkSC4WuA0ooV26mom4BwPx55nzRof91kbZocGCIXr0LYrSCnd
 bLyedh+1CoICFQXSo9gYSDwDAdHcZfGzPdheVfC+aLZ8HgpVGkIUuqR8VbAoCAsxI70Q
 7r2nxjhtgLeseGpwBqCHh+TvS2fcR5xF0vawOzxZDM/DRAIfDggjGzPv78OvXgyRAVYH
 DE7ssBmmoxZCMmyH3WH8K00txU7DJJF7zX0pW+eBPx6FJpKXuVtsRKEMh1dTP84QpVLl
 y8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MHVKyzd14+bXJS6plIu4IUmaJdRagfuE25k0EE+Xexw=;
 b=Z/TAEbykiejdYuYk4Yuw0YX8oT1rWIsayDDJ6Nhniig9C537avk/CfbGFaWD10ZKcm
 CQzFztn5/S9OxozlDja6JXgzFEymqE5G9hASYjQTihyGmZ/VOROyMAHJcMmstoj2T9C4
 Dq41DMS+qpp5L8k/+5ccZuPwcAwCxU9uyyWiqsyosRHhjPlwr+9LknT4xOa0pCccnYb2
 6LZ+YBgNUN2/g1P3/1W/qKqfEOIlRhSC61uKjMAnufIisKT7gbnrekx2ch/Q50xncLyy
 lQz/4x9VwSuhCGaJVN7dzX7jMOeuS3wEB3NFDL6ynSRB8wcESvbWoTFcdez7IY1wtLU3
 fuIw==
X-Gm-Message-State: AOAM5330nriXfLxDu2xrAw4tdIr7UV9jLT4wqlnJiaes1qUhzgxC71JT
 WreDCYJXzIpDvT1VbR/bTr3VNg==
X-Google-Smtp-Source: ABdhPJzmArUCUSb7myordJj/msTBloS+oEtWndoVJ0DvbqTCJ7uAP+e8GIRgeggA/w/m87RZpJai4g==
X-Received: by 2002:a17:90a:e56:: with SMTP id
 p22mr4342315pja.73.1627670093578; 
 Fri, 30 Jul 2021 11:34:53 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id r15sm2920618pjl.29.2021.07.30.11.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 11:34:53 -0700 (PDT)
Date: Fri, 30 Jul 2021 18:34:49 +0000
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 03/13] KVM: x86: Expose TSC offset controls to userspace
Message-ID: <YQRGSd9Pce+Hlpnq@google.com>
References: <20210729173300.181775-1-oupton@google.com>
 <20210729173300.181775-4-oupton@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210729173300.181775-4-oupton@google.com>
X-Mailman-Approved-At: Sat, 31 Jul 2021 05:33:51 -0400
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Raghavendra Rao Anata <rananta@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

On Thu, Jul 29, 2021, Oliver Upton wrote:
> To date, VMM-directed TSC synchronization and migration has been a bit
> messy. KVM has some baked-in heuristics around TSC writes to infer if
> the VMM is attempting to synchronize. This is problematic, as it depends
> on host userspace writing to the guest's TSC within 1 second of the last
> write.
> 
> A much cleaner approach to configuring the guest's views of the TSC is to
> simply migrate the TSC offset for every vCPU. Offsets are idempotent,
> and thus not subject to change depending on when the VMM actually
> reads/writes values from/to KVM. The VMM can then read the TSC once with
> KVM_GET_CLOCK to capture a (realtime, host_tsc) pair at the instant when
> the guest is paused.
> 
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>  Documentation/virt/kvm/devices/vcpu.rst |  57 ++++++++
>  arch/x86/include/asm/kvm_host.h         |   1 +
>  arch/x86/include/uapi/asm/kvm.h         |   4 +
>  arch/x86/kvm/x86.c                      | 167 ++++++++++++++++++++++++
>  4 files changed, 229 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
> index 2acec3b9ef65..0f46f2588905 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -161,3 +161,60 @@ Specifies the base address of the stolen time structure for this VCPU. The
>  base address must be 64 byte aligned and exist within a valid guest memory
>  region. See Documentation/virt/kvm/arm/pvtime.rst for more information
>  including the layout of the stolen time structure.
> +
> +4. GROUP: KVM_VCPU_TSC_CTRL
> +===========================
> +
> +:Architectures: x86
> +
> +4.1 ATTRIBUTE: KVM_VCPU_TSC_OFFSET
> +
> +:Parameters: 64-bit unsigned TSC offset
> +
> +Returns:
> +
> +	 ======= ======================================
> +	 -EFAULT Error reading/writing the provided
> +	 	 parameter address.

There's a rogue space in here (git show highlights it).

> +	 -ENXIO  Attribute not supported
> +	 ======= ======================================
> +
> +Specifies the guest's TSC offset relative to the host's TSC. The guest's
> +TSC is then derived by the following equation:
> +
> +  guest_tsc = host_tsc + KVM_VCPU_TSC_OFFSET
> +
> +This attribute is useful for the precise migration of a guest's TSC. The
> +following describes a possible algorithm to use for the migration of a
> +guest's TSC:
> +
> +From the source VMM process:
> +
> +1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (t_0),
> +   kvmclock nanoseconds (k_0), and realtime nanoseconds (r_0).
> +
> +2. Read the KVM_VCPU_TSC_OFFSET attribute for every vCPU to record the
> +   guest TSC offset (off_n).
> +
> +3. Invoke the KVM_GET_TSC_KHZ ioctl to record the frequency of the
> +   guest's TSC (freq).
> +
> +From the destination VMM process:
> +
> +4. Invoke the KVM_SET_CLOCK ioctl, providing the kvmclock nanoseconds
> +   (k_0) and realtime nanoseconds (r_0) in their respective fields.
> +   Ensure that the KVM_CLOCK_REALTIME flag is set in the provided
> +   structure. KVM will advance the VM's kvmclock to account for elapsed
> +   time since recording the clock values.
> +
> +5. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (t_1) and
> +   kvmclock nanoseconds (k_1).
> +
> +6. Adjust the guest TSC offsets for every vCPU to account for (1) time
> +   elapsed since recording state and (2) difference in TSCs between the
> +   source and destination machine:
> +
> +   new_off_n = t_0 + off_n + (k_1 - k_0) * freq - t_1
> +
> +7. Write the KVM_VCPU_TSC_OFFSET attribute for every vCPU with the
> +   respective value derived in the previous step.
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 65a20c64f959..855698923dd0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1070,6 +1070,7 @@ struct kvm_arch {
>  	u64 last_tsc_nsec;
>  	u64 last_tsc_write;
>  	u32 last_tsc_khz;
> +	u64 last_tsc_offset;
>  	u64 cur_tsc_nsec;
>  	u64 cur_tsc_write;
>  	u64 cur_tsc_offset;
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index a6c327f8ad9e..0b22e1e84e78 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -503,4 +503,8 @@ struct kvm_pmu_event_filter {
>  #define KVM_PMU_EVENT_ALLOW 0
>  #define KVM_PMU_EVENT_DENY 1
>  
> +/* for KVM_{GET,SET,HAS}_DEVICE_ATTR */
> +#define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
> +#define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
> +
>  #endif /* _ASM_X86_KVM_H */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 27435a07fb46..17d87a8d0c75 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2413,6 +2413,11 @@ static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
>  	static_call(kvm_x86_write_tsc_offset)(vcpu, vcpu->arch.tsc_offset);
>  }
>  
> +static u64 kvm_vcpu_read_tsc_offset(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.l1_tsc_offset;
> +}

This is not a helpful, uh, helper.  Based on the name, I would expect it to read
the TSC_OFFSET in the context of L1 vs. L2.  Assuming you really want L1's offset,
just read vcpu->arch.l1_tsc_offset directly.  That will obviate the "need" for
a local offset (see below).

> +
>  static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier)
>  {
>  	vcpu->arch.l1_tsc_scaling_ratio = l1_multiplier;
> @@ -2469,6 +2474,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
>  	kvm->arch.last_tsc_nsec = ns;
>  	kvm->arch.last_tsc_write = tsc;
>  	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
> +	kvm->arch.last_tsc_offset = offset;
>  
>  	vcpu->arch.last_guest_tsc = tsc;
>  
> @@ -4928,6 +4934,137 @@ static int kvm_set_guest_paused(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vcpu,
> +				 struct kvm_device_attr *attr)
> +{
> +	int r;
> +
> +	switch (attr->attr) {
> +	case KVM_VCPU_TSC_OFFSET:
> +		r = 0;
> +		break;
> +	default:
> +		r = -ENXIO;
> +	}
> +
> +	return r;
> +}
> +
> +static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
> +				 struct kvm_device_attr *attr)
> +{
> +	void __user *uaddr = (void __user *)attr->addr;
> +	int r;
> +
> +	switch (attr->attr) {
> +	case KVM_VCPU_TSC_OFFSET: {
> +		u64 offset;
> +
> +		offset = kvm_vcpu_read_tsc_offset(vcpu);
> +		r = -EFAULT;
> +		if (copy_to_user(uaddr, &offset, sizeof(offset)))
> +			break;

Use put_user(), then this all becomes short and sweet without curly braces:

	case KVM_VCPU_TSC_OFFSET:
		r = -EFAULT;
		if (put_user(vcpu->arch.l1_tsc_offset, uaddr))
			break;
		r = 0;
		break;

> +
> +		r = 0;
> +		break;
> +	}
> +	default:
> +		r = -ENXIO;
> +	}
> +
> +	return r;
> +}
> +
> +static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
> +				 struct kvm_device_attr *attr)
> +{
> +	void __user *uaddr = (void __user *)attr->addr;
> +	struct kvm *kvm = vcpu->kvm;
> +	int r;
> +
> +	switch (attr->attr) {
> +	case KVM_VCPU_TSC_OFFSET: {
> +		u64 offset, tsc, ns;
> +		unsigned long flags;
> +		bool matched;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&offset, uaddr, sizeof(offset)))

This can be get_user().

> +			break;
> +
> +		raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> +
> +		matched = (vcpu->arch.virtual_tsc_khz &&
> +			   kvm->arch.last_tsc_khz == vcpu->arch.virtual_tsc_khz &&
> +			   kvm->arch.last_tsc_offset == offset);
> +
> +		tsc = kvm_scale_tsc(vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
> +		ns = get_kvmclock_base_ns();
> +
> +		__kvm_synchronize_tsc(vcpu, offset, tsc, ns, matched);
> +		raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
> +
> +		r = 0;
> +		break;
> +	}
> +	default:
> +		r = -ENXIO;
> +	}
> +
> +	return r;
> +}

...

>  static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  				     struct kvm_enable_cap *cap)
>  {
> @@ -5382,6 +5519,36 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = __set_sregs2(vcpu, u.sregs2);
>  		break;
>  	}
> +	case KVM_HAS_DEVICE_ATTR: {
> +		struct kvm_device_attr attr;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&attr, argp, sizeof(attr)))
> +			goto out;
> +
> +		r = kvm_vcpu_ioctl_has_device_attr(vcpu, &attr);
> +		break;
> +	}
> +	case KVM_GET_DEVICE_ATTR: {
> +		struct kvm_device_attr attr;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&attr, argp, sizeof(attr)))
> +			goto out;
> +
> +		r = kvm_vcpu_ioctl_get_device_attr(vcpu, &attr);
> +		break;
> +	}
> +	case KVM_SET_DEVICE_ATTR: {
> +		struct kvm_device_attr attr;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&attr, argp, sizeof(attr)))
> +			goto out;
> +
> +		r = kvm_vcpu_ioctl_set_device_attr(vcpu, &attr);
> +		break;

That's a lot of copy paste code, and I omitted a big chunk, too.  What about
something like:

static int kvm_vcpu_ioctl_do_device_attr(struct kvm_vcpu *vcpu,
					 unsigned int ioctl, void __user *argp)
{
	struct kvm_device_attr attr;
	int r;

	if (copy_from_user(&attr, argp, sizeof(attr)))
		return -EFAULT;

	if (attr->group != KVM_VCPU_TSC_CTRL)
		return -ENXIO;

	switch (ioctl) {
	case KVM_HAS_DEVICE_ATTR:
		r = kvm_arch_tsc_has_attr(vcpu, attr);
		break;
	case KVM_GET_DEVICE_ATTR:
		r = kvm_arch_tsc_get_attr(vcpu, attr);
		break;
	case KVM_SET_DEVICE_ATTR:
		r = kvm_arch_tsc_set_attr(vcpu, attr);
		break;
	default:
		BUG();
	}
	return r;
}

and then:

	case KVM_GET_DEVICE_ATTR:
	case KVM_HAS_DEVICE_ATTR:
	case KVM_SET_DEVICE_ATTR:
		r = kvm_vcpu_ioctl_do_device_attr(vcpu, ioctl, argp);
		break;


or if we want to plan for the future a bit more:

static int kvm_vcpu_ioctl_do_device_attr(struct kvm_vcpu *vcpu,
					 unsigned int ioctl, void __user *argp)
{
	struct kvm_device_attr attr;
	int r;

	if (copy_from_user(&attr, argp, sizeof(attr)))
		return -EFAULT;

	r = -ENXIO;

	switch (ioctl) {
	case KVM_HAS_DEVICE_ATTR:
		if (attr->group != KVM_VCPU_TSC_CTRL)
			r = kvm_arch_tsc_has_attr(vcpu, attr);
		break;
	case KVM_GET_DEVICE_ATTR:
		if (attr->group != KVM_VCPU_TSC_CTRL)
			r = kvm_arch_tsc_get_attr(vcpu, attr);
		break;
	case KVM_SET_DEVICE_ATTR:
		if (attr->group != KVM_VCPU_TSC_CTRL)
			r = kvm_arch_tsc_set_attr(vcpu, attr);
		break;
	}
	return r;
}

> +	}
>  	default:
>  		r = -EINVAL;
>  	}
> -- 
> 2.32.0.432.gabb21c7263-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
