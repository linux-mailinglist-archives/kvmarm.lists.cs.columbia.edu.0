Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1F1FAB52
	for <lists+kvmarm@lfdr.de>; Tue, 16 Jun 2020 10:33:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B8D14B0BB;
	Tue, 16 Jun 2020 04:33:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJ7-Wv3ttS3q; Tue, 16 Jun 2020 04:33:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D1FF64B080;
	Tue, 16 Jun 2020 04:33:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB75E4B080
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 04:33:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tpGD9RXxTInq for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Jun 2020 04:33:52 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D58E4A49C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 04:33:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592296431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KhVI+u9bEUhT74xVcv0t/prea14sD6xpQkCD+rX4+g=;
 b=R4Ms07KAHAYy5I03KmKt7QP9DCWuC28cnnzq6aba8EC/qMXHizzcPvccepC0qijIzE3EMB
 6OT4R6eJ4t2RiTOqAnDaivcQK4FnAbanixZqIZIFa6esfESFgRXRHIlEw7vs5b3GBdWdMe
 bd24MfVX+647Pe0VnUaEey4wthKhq30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-ERj2mK97NV-vqop6YixoMA-1; Tue, 16 Jun 2020 04:33:49 -0400
X-MC-Unique: ERj2mK97NV-vqop6YixoMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB6FD18585CA;
 Tue, 16 Jun 2020 08:33:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD91E1001E91;
 Tue, 16 Jun 2020 08:33:42 +0000 (UTC)
Date: Tue, 16 Jun 2020 10:33:37 +0200
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v5 1/2] target/arm: kvm: Handle DABT with no valid ISS
Message-ID: <20200616083337.yfgc4cyad4ipaqb7@kamzik.brq.redhat.com>
References: <20200529112757.32235-1-beata.michalska@linaro.org>
 <20200529112757.32235-2-beata.michalska@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200529112757.32235-2-beata.michalska@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
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

Hi Beata,

I see Peter just picked this up, so I'm a bit late getting to it. I do
have a couple comments below though.

Thanks,
drew

On Fri, May 29, 2020 at 12:27:56PM +0100, Beata Michalska wrote:
> On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
> exception with no valid ISS info to be decoded. The lack of decode info
> makes it at least tricky to emulate those instruction which is one of the
> (many) reasons why KVM will not even try to do so.
> 
> Add support for handling those by requesting KVM to inject external
> dabt into the quest.
> 
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  target/arm/cpu.h     |  2 ++
>  target/arm/kvm.c     | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  target/arm/kvm_arm.h | 11 +++++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 677584e..3702f21 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -570,6 +570,8 @@ typedef struct CPUARMState {
>          uint64_t esr;
>      } serror;
>  
> +    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> +
>      /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
>      uint32_t irq_line_state;
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4bdbe6d..bf84224 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>  
>  static bool cap_has_mp_state;
>  static bool cap_has_inject_serror_esr;
> +static bool cap_has_inject_ext_dabt;
>  
>  static ARMHostCPUFeatures arm_host_cpu_features;
>  
> @@ -244,6 +245,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          ret = -EINVAL;
>      }
>  
> +    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> +        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
> +            error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
> +        } else {
> +            /* Set status for supporting the external dabt injection */
> +            cap_has_inject_ext_dabt = kvm_check_extension(s,
> +                                    KVM_CAP_ARM_INJECT_EXT_DABT);
> +        }
> +    }
> +
>      return ret;
>  }
>  
> @@ -703,9 +714,16 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
>          events.exception.serror_esr = env->serror.esr;
>      }
>  
> +    if (cap_has_inject_ext_dabt) {
> +        events.exception.ext_dabt_pending = env->ext_dabt_pending;
> +    }
> +
>      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
>      if (ret) {
>          error_report("failed to put vcpu events");
> +    } else {
> +        /* Clear instantly if the call was successful */
> +        env->ext_dabt_pending = 0;
>      }
>  
>      return ret;
> @@ -819,7 +837,12 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>              ret = EXCP_DEBUG;
>          } /* otherwise return to guest */
>          break;
> -    default:
> +    case KVM_EXIT_ARM_NISV:
> +        /* External DABT with no valid iss to decode */
> +        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
> +                                       run->arm_nisv.fault_ipa);
> +        break;
> +     default:
>          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                        __func__, run->exit_reason);
>          break;
> @@ -955,3 +978,42 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>  {
>      return (data - 32) & 0xffff;
>  }
> +
> +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> +                             uint64_t fault_ipa)

This function could be static since it's in the same file as its one
and only caller.

> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +   /*
> +    * ISS [23:14] is invalid so there is a limited info
> +    * on what has just happened so the only *useful* thing that can
> +    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
> +    * might be less of a value as well)
> +    */
> +
> +    /*
> +     * Request KVM to inject the external data abort into the guest
> +     * by setting a pending exception on the affected vcpu.
> +     */
> +    if (cap_has_inject_ext_dabt) {
> +        /* Set pending exception */
> +        env->ext_dabt_pending = 1;
> +        /*
> +         * Even though at this point, the vcpu regs are out of sync,
> +         * directly calling the KVM_SET_VCPU_EVENTS ioctl without
> +         * explicitly synchronizing those, is enough and it also avoids
> +         * overwriting changes done by KVM.
> +         * The vcpu is not being marked as 'dirty' as all the changes
> +         * needed to inject the abort are being handled by KVM only
> +         * and there is no need for syncing either way
> +         */
> +        return kvm_put_vcpu_events(cpu);

This looks fragile. What if we change kvm_put_vcpu_events() in a way
that requires CPU synchronization? Or, what if we change something else
that results in the VCPU getting flagged as dirty before finishing this
run loop, and then we end up calling kvm_put_vcpu_events() twice, possibly
causing some other problem?

I think I'd prefer seeing the KVM_SET_VCPU_EVENTS ioctl get called
directly from here with the events set to only inject the dabt, as we
know that will be handled immediately and doesn't require any CPU
synchronization.

Thanks,
drew

> +    } else {
> +        error_report("Data abort exception triggered by guest memory access "
> +                     "at physical address: 0x"  TARGET_FMT_lx,
> +                     (target_ulong)fault_ipa);
> +        error_printf("KVM unable to emulate faulting instruction.\n");
> +        return -1;
> +    }
> +}
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 48bf5e1..e939e51 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -453,6 +453,17 @@ struct kvm_guest_debug_arch;
>  void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
>  
>  /**
> + * kvm_arm_handle_dabt_nisv:
> + * @cs: CPUState
> + * @esr_iss: ISS encoding (limited) for the exception from Data Abort
> + *           ISV bit set to '0b0' -> no valid instruction syndrome
> + * @fault_ipa: faulting address for the synch data abort
> + *
> + * Returns: 0 if the exception has been handled, < 0 otherwise
> + */
> +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> +                            uint64_t fault_ipa);
> +/**
>   * its_class_name:
>   *
>   * Return the ITS class name to use depending on whether KVM acceleration
> -- 
> 2.7.4
> 
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
