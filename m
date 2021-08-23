Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2354B3F4721
	for <lists+kvmarm@lfdr.de>; Mon, 23 Aug 2021 11:08:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 88C684B273;
	Mon, 23 Aug 2021 05:08:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZFnxOkyLrNp; Mon, 23 Aug 2021 05:08:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DBEE44B267;
	Mon, 23 Aug 2021 05:08:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A54C64B25D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Aug 2021 05:08:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A7sk6juHLxOM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Aug 2021 05:07:57 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AEC34B1DC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Aug 2021 05:07:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629709676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aISp5M1izx4NH4v0Hn06V3ODxv34YeYXayvZgVqi7XI=;
 b=VVC0xQ88CHPih/Hasxu6hGx0QckDyJoNwYwMGrvYnFDEy5DtbU3KQ7PeM1oJuW+GnzhcI1
 5IIBpbZ9sBPsSlyEE0iAteqBgUr3Cd9tblZCM9U/gBwGw6qdR2R1R8w3/IJBfonqCpMeGY
 zW5FCYvq3kvwQwR/VP9mBF0NzDoYzUg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-ZkaRe2kBNiaMk4I3uAf99Q-1; Mon, 23 Aug 2021 05:07:55 -0400
X-MC-Unique: ZkaRe2kBNiaMk4I3uAf99Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 h17-20020a1709070b11b02905b5ced62193so5421966ejl.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Aug 2021 02:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aISp5M1izx4NH4v0Hn06V3ODxv34YeYXayvZgVqi7XI=;
 b=hYD7TD5Gi8ZM2OCdwiaKTHPxGFGZ589ahmhHDCQsWNHdCzt/khE6tSmopLSGhvYQps
 ZvQ/JLLRqptLWKxPwOnzCxZajyd4sT2WyP1jAE3J/+sZ6/uw9M5uxde5CJr5u3KdtCsN
 9pvYe8j+hJFdX0bbEWBuDYRkQ6DgGjgSLmHNqMVLDGQ6DX4aPIfQtZj9K8ggJdTITIKD
 ls68pQUy/1/3LqU6nlkARS3j1mhRamnlpJtkpaQ+C1d9DchQIrymNUSd1l+ETek11c6h
 uZBmYOq6oe9bgR8qxwGL4NjFTP4hUDO5Uggzl3ig6m0sYlsFNoP+hQkqepN8Yr5uwwsg
 aI4w==
X-Gm-Message-State: AOAM530aEQvk+6AyCRAjtpvW5jJCfTKV1SEGSbGEuGkYx5UxsPGuZN2P
 9Lqk8gL9xW2ZLbjjY3RQFqZR5ABTgipghgiVI8rrWrXHRunJqRQa15jjVnGL7Z25JanspfDQBN8
 rtGMzFrGyxudTMYhTOWHNrmdu
X-Received: by 2002:a05:6402:1907:: with SMTP id
 e7mr8322341edz.201.1629709674295; 
 Mon, 23 Aug 2021 02:07:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB8djTuJSNghEDmXQfwZUrFrUJ+XhpXaA6T6sK1VZ2LMR5UNf4tuXRgxUvxp5oivYQUoq5rg==
X-Received: by 2002:a05:6402:1907:: with SMTP id
 e7mr8322319edz.201.1629709674115; 
 Mon, 23 Aug 2021 02:07:54 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id ks20sm6977968ejb.101.2021.08.23.02.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 02:07:53 -0700 (PDT)
Date: Mon, 23 Aug 2021 11:07:52 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/3] hw/arm/virt: KVM: Probe for KVM_CAP_ARM_VM_IPA_SIZE
 when creating scratch VM
Message-ID: <20210823090752.nanm4wttyefg3txh@gator.home>
References: <20210822144441.1290891-1-maz@kernel.org>
 <20210822144441.1290891-2-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210822144441.1290891-2-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, kernel-team@android.com,
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

On Sun, Aug 22, 2021 at 03:44:39PM +0100, Marc Zyngier wrote:
> Although we probe for the IPA limits imposed by KVM (and the hardware)
> when computing the memory map, we still use the old style '0' when
> creating a scratch VM in kvm_arm_create_scratch_host_vcpu().
> 
> On systems that are severely IPA challenged (such as the Apple M1),
> this results in a failure as KVM cannot use the default 40bit that
> '0' represents.
> 
> Instead, probe for the extension and use the reported IPA limit
> if available.
> 
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/kvm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index d8381ba224..cc3371a99b 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -70,12 +70,17 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>                                        struct kvm_vcpu_init *init)
>  {
>      int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> +    int max_vm_pa_size;
>  
>      kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
>      if (kvmfd < 0) {
>          goto err;
>      }
> -    vmfd = ioctl(kvmfd, KVM_CREATE_VM, 0);
> +    max_vm_pa_size = ioctl(kvmfd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_IPA_SIZE);
> +    if (max_vm_pa_size < 0) {
> +        max_vm_pa_size = 0;
> +    }
> +    vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
>      if (vmfd < 0) {
>          goto err;
>      }
> -- 
> 2.30.2
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
