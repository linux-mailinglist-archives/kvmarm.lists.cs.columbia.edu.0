Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8C08548318B
	for <lists+kvmarm@lfdr.de>; Mon,  3 Jan 2022 14:46:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0ECE4B0B6;
	Mon,  3 Jan 2022 08:46:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ld9nqpKTN0y4; Mon,  3 Jan 2022 08:46:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F4E24B12C;
	Mon,  3 Jan 2022 08:46:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 73EA04B0B6
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jan 2022 08:46:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eWqE0Tkeycmq for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 Jan 2022 08:46:07 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F3CF64B0B4
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jan 2022 08:46:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641217566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m9tKNmguGwQHV4c8HM4LhwbPDmiYg4NQViyqROyOzb0=;
 b=L3hOtSionFEfTPNxBmuoZzscNCdTBN6rypF/tPSLb0uIP39Ik3nlLU2CbyFcvQDi/atIIt
 zVpLpMLRoFru/MIYImqyv0lgBkwexB7HRj+x0EgTY0VidxFwBVgATKIB0cKMuvI4yoQVaY
 pTLixuM0q2vFjTaCteVa0oWGresFVtE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-TkblVRIgMZOuVfP6e6Xgwg-1; Mon, 03 Jan 2022 08:46:05 -0500
X-MC-Unique: TkblVRIgMZOuVfP6e6Xgwg-1
Received: by mail-ed1-f69.google.com with SMTP id
 b8-20020a056402350800b003f8f42a883dso15664788edd.16
 for <kvmarm@lists.cs.columbia.edu>; Mon, 03 Jan 2022 05:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m9tKNmguGwQHV4c8HM4LhwbPDmiYg4NQViyqROyOzb0=;
 b=RfNAuSWvI5kLEoTl7K21ovF0vnNW9rD5qbSHttuYqUypx7yqjl7aYNA8Sinq/6G1ly
 UiXTVuNf6HkRIzEDzBkRnur0amSpoMQ4wMB59KKmc+25ySdn4udb7d+gNmHyAIG9uZHY
 j4y4EOl/Rm4al3OFAzHIWf+CmK4pBYK+QCl/46NwNNNIWVgckQM/nNVpaNp8pSdW8ZFD
 inaC2rw4BGfyhi3o5ngKZEnAUlLKaLw6w1PS3/NXBzKMoO66kxv/DxLeGIXBoJ6qbOnv
 OQxKm/d3HBF5nTODh31nHAk9ns8+X6JFgyEIZzWORnILr54ATQkilbjrSY73cDKEhyIn
 42Lw==
X-Gm-Message-State: AOAM530+KRJZ0Bd2Zm137McU+ME6m/5Vlukd3SE7+uILeF91+boiGrbg
 DSIXS1h7Uc8kdvMLwg8bIBfcJ+D4f2H5N4KS2qLO/lBSyP253lXNOOJBMA9QY8UAmhjnBJSbWpS
 v85QqvJC7fLWEC3XLz+XLSg5Y
X-Received: by 2002:a17:907:9808:: with SMTP id
 ji8mr36339806ejc.751.1641217563898; 
 Mon, 03 Jan 2022 05:46:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8eeWuKUx9ItDdI27ssC7uVHwYjv+J0uZkjR9f5ux5q9swt42Ct+yubxq2zLvBYc7Ymbpb4Q==
X-Received: by 2002:a17:907:9808:: with SMTP id
 ji8mr36339789ejc.751.1641217563636; 
 Mon, 03 Jan 2022 05:46:03 -0800 (PST)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
 by smtp.gmail.com with ESMTPSA id k12sm2610001ejk.188.2022.01.03.05.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jan 2022 05:46:03 -0800 (PST)
Date: Mon, 3 Jan 2022 14:46:01 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] hw/arm/virt: KVM: Enable PAuth when supported by the host
Message-ID: <20220103134601.7cumwbza32wja3ei@gator>
References: <20211228182347.1025501-1-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211228182347.1025501-1-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

Hi Marc,

On Tue, Dec 28, 2021 at 06:23:47PM +0000, Marc Zyngier wrote:
> Add basic support for Pointer Authentication when running a KVM
> guest and that the host supports it, loosely based on the SVE
> support.
> 
> Although the feature is enabled by default when the host advertises
> it, it is possible to disable it by setting the 'pauth=off' CPU
> property.
> 
> Tested on an Apple M1 running 5.16-rc6.
> 
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  docs/system/arm/cpu-features.rst |  5 +++++
>  target/arm/cpu.c                 |  1 +
>  target/arm/cpu.h                 |  1 +
>  target/arm/cpu64.c               | 36 ++++++++++++++++++++++++++++++++
>  target/arm/kvm.c                 | 13 ++++++++++++
>  target/arm/kvm64.c               | 10 +++++++++
>  target/arm/kvm_arm.h             |  7 +++++++
>  7 files changed, 73 insertions(+)
> 
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 584eb17097..c9e39546a5 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -211,6 +211,11 @@ the list of KVM VCPU features and their descriptions.
>                             influence the guest scheduler behavior and/or be
>                             exposed to the guest userspace.
>  
> +  pauth                    Enable or disable ``FEAT_Pauth``, pointer
> +                           authentication.  By default, the feature is enabled
> +                           with ``-cpu host`` if supported by both the host
> +                           kernel and the hardware.
> +

Thanks for considering a documentation update. In this case, though, I
think we should delete the "TCG VCPU Features" pauth paragraph, rather
than add a new "KVM VCPU Features" pauth paragraph. We don't need to
document each CPU feature. We just document complex ones, like sve*,
KVM specific ones (kvm-*), and TCG specific ones (now only pauth-impdef).

>  TCG VCPU Features
>  =================
>  
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a211804fd3..68b09cbc6a 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2091,6 +2091,7 @@ static void arm_host_initfn(Object *obj)
>      kvm_arm_set_cpu_features_from_host(cpu);
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          aarch64_add_sve_properties(obj);
> +        aarch64_add_pauth_properties(obj);
>      }
>  #else
>      hvf_arm_set_cpu_features_from_host(cpu);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e33f37b70a..c6a4d50e82 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1076,6 +1076,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>  void aarch64_sve_change_el(CPUARMState *env, int old_el,
>                             int new_el, bool el0_a64);
>  void aarch64_add_sve_properties(Object *obj);
> +void aarch64_add_pauth_properties(Object *obj);
>  
>  /*
>   * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 15245a60a8..305c0e19fe 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -625,6 +625,42 @@ void aarch64_add_sve_properties(Object *obj)
>  #endif
>  }
>  
> +static bool cpu_arm_get_pauth(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    return cpu_isar_feature(aa64_pauth, cpu);
> +}
> +
> +static void cpu_arm_set_pauth(Object *obj, bool value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t t;
> +
> +    if (value) {
> +        if (!kvm_arm_pauth_supported()) {
> +            error_setg(errp, "'pauth' feature not supported by KVM on this host");
> +        }
> +
> +        return;
> +    }
> +
> +    /*
> +     * If the host supports PAuth, we only end-up here if the user has
> +     * disabled the support, and value is false.
> +     */
> +    t = cpu->isar.id_aa64isar1;
> +    t = FIELD_DP64(t, ID_AA64ISAR1, APA, value);
> +    t = FIELD_DP64(t, ID_AA64ISAR1, GPA, value);
> +    t = FIELD_DP64(t, ID_AA64ISAR1, API, value);
> +    t = FIELD_DP64(t, ID_AA64ISAR1, GPI, value);
> +    cpu->isar.id_aa64isar1 = t;
> +}
> +
> +void aarch64_add_pauth_properties(Object *obj)
> +{
> +    object_property_add_bool(obj, "pauth", cpu_arm_get_pauth, cpu_arm_set_pauth);
> +}

I think we should try to merge as much as possible between the TCG and KVM
pauth property handling. I think we just need to move the
qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property) call into
KVM/TCG common code and then modify arm_cpu_pauth_finalize() to
handle checking KVM for support when KVM is enabled and also to not
look at the impdef property.

> +
>  void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
>  {
>      int arch_val = 0, impdef_val = 0;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index bbf1ce7ba3..71e2f46ce8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -84,6 +84,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>      if (vmfd < 0) {
>          goto err;
>      }
> +
>      cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>      if (cpufd < 0) {
>          goto err;
> @@ -94,6 +95,18 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>          goto finish;
>      }
>  
> +    /*
> +     * Ask for Pointer Authentication if supported. We can't play the
> +     * SVE trick of synthetising the ID reg as KVM won't tell us
> +     * whether we have the architected or IMPDEF version of PAuth, so
> +     * we have to use the actual ID regs.
> +     */
> +    if (ioctl(vmfd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_PTRAUTH_ADDRESS) > 0 &&
> +        ioctl(vmfd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_PTRAUTH_GENERIC) > 0) {
> +        init->features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
> +                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
> +    }
> +

I think kvm_init() is called prior to kvm_arm_get_host_cpu_features(),
which means we can do this instead

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e790d6c9a573..d1512035ac5b 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -521,6 +521,17 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     struct kvm_vcpu_init init = { .target = -1, };
 
+   /*
+    * Ask for Pointer Authentication if supported. We can't play the
+    * SVE trick of synthetising the ID reg as KVM won't tell us
+    * whether we have the architected or IMPDEF version of PAuth, so
+    * we have to use the actual ID regs.
+    */
+    if (kvm_arm_pauth_supported()) {
+        init->features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
+                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
+    }
+
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
         return false;
     }

Assuming I'm right about the call order, then I think I'd like that more.


>      if (init->target == -1) {
>          struct kvm_vcpu_init preferred;
>  
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index e790d6c9a5..95b6902ca0 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -725,6 +725,12 @@ bool kvm_arm_sve_supported(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
>  }
>  
> +bool kvm_arm_pauth_supported(void)
> +{
> +    return (kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
> +            kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
> +}
> +
>  bool kvm_arm_steal_time_supported(void)
>  {
>      return kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
> @@ -865,6 +871,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          assert(kvm_arm_sve_supported());
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>      }
> +    if (cpu_isar_feature(aa64_pauth, cpu)) {
> +	    cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
> +					  1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
> +    }
>  
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cs);
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index b7f78b5215..c26acf7866 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -306,6 +306,13 @@ bool kvm_arm_pmu_supported(void);
>   */
>  bool kvm_arm_sve_supported(void);
>  
> +/**
> + * kvm_arm_pauth_supported:
> + *
> + * Returns true if KVM can enable Pointer Authentication and false otherwise.
> + */
> +bool kvm_arm_pauth_supported(void);
> +

If we merge more of the pauth property handling with the TCG code, then
we'll also need a stub in the !CONFIG_KVM section for compiling without
kvm support.

>  /**
>   * kvm_arm_get_max_vm_ipa_size:
>   * @ms: Machine state handle
> -- 
> 2.30.2
>

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
