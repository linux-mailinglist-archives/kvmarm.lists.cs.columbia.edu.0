Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E9D164254AA
	for <lists+kvmarm@lfdr.de>; Thu,  7 Oct 2021 15:49:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78C204B318;
	Thu,  7 Oct 2021 09:49:33 -0400 (EDT)
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
	with ESMTP id t-m3GQM62Hit; Thu,  7 Oct 2021 09:49:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C4BA4B2D0;
	Thu,  7 Oct 2021 09:49:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6C6B4B2AB
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Oct 2021 09:49:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fXF3SiYMtEv for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 Oct 2021 09:49:29 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E33234B26C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Oct 2021 09:49:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633614569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YV63mS4RpYRoGQSZMwqbE1CRZKLm8qRI0uKOruLtURg=;
 b=F4YyzwurdE862x64FRlDPlf4WTcock3bXoRRZolzp40WDGLJGPaBPQqWOUHiSxSK1i+W6E
 J8P1D6zeHltnuvlbS1jSlBGR2u548SFQr4GeSKkjDhkYlygbTP68fNiy3L0WDa+Gn7rjdV
 BUfhHQXRqkn8AJfMXQVKn3pB0e/MktM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-d2h-_ZZGPjydyYlJ0UYBHQ-1; Thu, 07 Oct 2021 09:49:27 -0400
X-MC-Unique: d2h-_ZZGPjydyYlJ0UYBHQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 q17-20020ad45491000000b003832299965bso3187378qvy.18
 for <kvmarm@lists.cs.columbia.edu>; Thu, 07 Oct 2021 06:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YV63mS4RpYRoGQSZMwqbE1CRZKLm8qRI0uKOruLtURg=;
 b=Dc7YOuQwbV8yFMDhC+t6L6nfGwZpi8Y2wROj/tYPFTEc8SegAr3muN2+SWxfZ2SBzR
 kIM9A1XSpm4CLsVOnBNGsHQ6MIkWLCdAEgqfyxGT8hHqoMtbwqBDdr/xcWR/R8Z/G8tf
 Xecc4IcrzrWoxHJ9WcKgSIXPnjxCvZk+UAWLDnr+tlYF7pUzF/3l+JhSDvXEjY7l8ygb
 YfJFXuzLjxePd5PqFZxkuJelVqxbXQZ/Crg9P09z23a6T1R48BW3f8/Y+ONFCsPKKWjw
 hqYvXIertUzG/NDFp7rYgX+dSahh+wfnJ7U/uzVsSuo50Ua7Puq39JOuDwDXkNduhd0C
 VlYg==
X-Gm-Message-State: AOAM533d4DO5rdTaknXZL8lJ2oYrljL+ve9U/jTkO4kIqmwJfL68fBL2
 HCeUBq1YJcGJO/+zWI2livV8cVqKSziGwyh8P5jQkjcyi9L7Jlct2y57dG5LOfn1mX0aZB1Hazz
 So7H3C0HHYf3xvWR+e+s2jZiM
X-Received: by 2002:a05:6214:a4d:: with SMTP id
 ee13mr4121153qvb.6.1633614567253; 
 Thu, 07 Oct 2021 06:49:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfq2RpXF9UQXSj5gVtwkRFV+YzKin4ZaeJ2Zs5710CY4R+6CVe48FzPtRwNTqzbSzHN22NJA==
X-Received: by 2002:a05:6214:a4d:: with SMTP id
 ee13mr4121130qvb.6.1633614567050; 
 Thu, 07 Oct 2021 06:49:27 -0700 (PDT)
Received: from gator (nat-pool-brq-u.redhat.com. [213.175.37.12])
 by smtp.gmail.com with ESMTPSA id n123sm633770qke.36.2021.10.07.06.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 06:49:26 -0700 (PDT)
Date: Thu, 7 Oct 2021 15:49:22 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 06/16] KVM: arm64: Force a full unmap on vpcu reinit
Message-ID: <20211007134922.sg3b3egpwc2izbi2@gator>
References: <20211004174849.2831548-1-maz@kernel.org>
 <20211004174849.2831548-7-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211004174849.2831548-7-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>,
 Shanker R Donthineni <sdonthineni@nvidia.com>, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Oct 04, 2021 at 06:48:39PM +0100, Marc Zyngier wrote:
> As we now keep information in the S2PT, we must be careful not
> to keep it across a VM reboot, which could otherwise lead to
> interesting problems.
> 
> Make sure that the S2 is completely discarded on reset of
> a vcpu, and remove the flag that enforces the MMIO check.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/psci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index 74c47d420253..6c9cb041f764 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -12,6 +12,7 @@
>  
>  #include <asm/cputype.h>
>  #include <asm/kvm_emulate.h>
> +#include <asm/kvm_mmu.h>
>  
>  #include <kvm/arm_psci.h>
>  #include <kvm/arm_hypercalls.h>
> @@ -180,6 +181,13 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  		tmp->arch.power_off = true;
>  	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
>  
> +	/*
> +	 * If the MMIO guard was enabled, we pay the price of a full
> +	 * unmap to get back to a sane state (and clear the flag).
> +	 */
> +	if (test_and_clear_bit(KVM_ARCH_FLAG_MMIO_GUARD, &vcpu->kvm->arch.flags))
> +		stage2_unmap_vm(vcpu->kvm);
> +
>  	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
>  	vcpu->run->system_event.type = type;
>  	vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
> -- 
> 2.30.2
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
