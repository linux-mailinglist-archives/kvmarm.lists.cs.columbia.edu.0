Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA42647BB
	for <lists+kvmarm@lfdr.de>; Thu, 10 Sep 2020 16:07:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A508A4B2C3;
	Thu, 10 Sep 2020 10:07:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NyTK-jhD9mzB; Thu, 10 Sep 2020 10:07:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F1814B2C7;
	Thu, 10 Sep 2020 10:07:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B84244B2C1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 10:07:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gw3Z50ZBKUYa for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Sep 2020 10:07:45 -0400 (EDT)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 930794B22C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 10:07:45 -0400 (EDT)
Received: by mail-wm1-f65.google.com with SMTP id x23so178410wmi.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QJ5xEB2z11c85j6v+J4UJJ6T/KCHaYAOj5sVJT9cY58=;
 b=cYL3QKW0nMiKASGS3CJTqYRW4EJhwjV95TkNT0tAhERyHlIVcKujnsUZ992Tgt805x
 3uuPEFEzZ6VgoEVJunPO22PvL1THHkv0rx45qgLJ5V4frgzv84ZS4X4awVwGcqp6sl2v
 zR1Fglj6zs5XzvZseqGJun2dk9bpkq3nUYWLNEEqA+T0eMTr23JSl7M9K0Ok+jnduwEj
 /eZHnRWGDiVRXE8KK+upeUUGtW6Y/g7j8relgaZTHwu0oIF4TJHUCIUCUAvmS6x/EDXI
 nevfOC1kp/P7s7F8psEC35HXkrbOLNy0uO6x8SSD50eVqa4iYCMPePAxogexL4gtbNlP
 ESIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QJ5xEB2z11c85j6v+J4UJJ6T/KCHaYAOj5sVJT9cY58=;
 b=nR6c10s5anlOeqOHRmpTX3ATt+3y/oWkgqVgqn3xp8OUe8vyYdYkVlZ0ssidT3M45p
 1fgwsexBcpy3P4fDKWcZO78p2T3iYr+9sl8enXDNLVDNgvs36E8fZXj9zeyX1pXbU/La
 85yx0JhpFZTQcgcRawJuHzTOIs5YIII8urXjOEEGH6yJ3x3Z9KCbllS3PNcspv72Ybb0
 yyu78iQcD9T9sQ/M1JOEfKGsz3sEzpEDPeAR4zfiAjW94rdx9kXvGW8O0apJENjwIsM8
 M0EbyxLNki5KrnD7Ix0u4oCMKCvUqCNI1ClgqBjktMwhfeM1p1HRRTqQJdivUJbZ91PY
 BjlQ==
X-Gm-Message-State: AOAM530dlS3Z9YqlRDCgU+/tx70RdIciykLUDIU6LjPfhiPvmVFTGVWI
 ucDDdaxe/SLowpfYFvNaeKts6A==
X-Google-Smtp-Source: ABdhPJxlhCOonhA/QUW6OuXk1EjfpUKr/GIkLwPXiWKB30qBaOqPGDH5pFin00r8M+FnE6NxmcHIbg==
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr149856wmj.107.1599746864225; 
 Thu, 10 Sep 2020 07:07:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 by smtp.gmail.com with ESMTPSA id v128sm3801248wme.2.2020.09.10.07.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 07:07:43 -0700 (PDT)
Date: Thu, 10 Sep 2020 15:07:38 +0100
From: Andrew Scull <ascull@google.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v2 10/10] kvm: arm64: Remove unnecessary hyp mappings
Message-ID: <20200910140738.GE93664@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-11-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903091712.46456-11-dbrazdil@google.com>
Cc: linux-arch@vger.kernel.org, kernel-team@android.com,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Thu, Sep 03, 2020 at 11:17:12AM +0200, 'David Brazdil' via kernel-team wrote:
> With all nVHE per-CPU variables being part of the hyp per-CPU region,
> mapping them individual is not necessary any longer. They are mapped to hyp
> as part of the overall per-CPU region.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Acked-by: Andrew Scull<ascull@google.com>

> ---
>  arch/arm64/include/asm/kvm_mmu.h | 25 +++++++------------------
>  arch/arm64/kvm/arm.c             | 17 +----------------
>  2 files changed, 8 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 9db93da35606..bbe9df76ff42 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -531,28 +531,17 @@ static inline int kvm_map_vectors(void)
>  DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>  DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
>  
> -static inline int hyp_init_aux_data(void)
> +static inline void hyp_init_aux_data(void)
>  {
> -	int cpu, err;
> +	int cpu;
>  
> -	for_each_possible_cpu(cpu) {
> -		u64 *ptr;
> -
> -		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
> -		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
> -		if (err)
> -			return err;
> -
> -		/* Copy value from kernel to hyp. */
> -		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
> -	}
> -	return 0;
> +	/* Copy arm64_ssbd_callback_required values from kernel to hyp. */
> +	for_each_possible_cpu(cpu)
> +		*(per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu)) =
> +			per_cpu(arm64_ssbd_callback_required, cpu);

Careful with breaking allocations across lines, that seems to be taboo
in this subsystem.

>  }
>  #else
> -static inline int hyp_init_aux_data(void)
> -{
> -	return 0;
> -}
> +static inline void hyp_init_aux_data(void) {}
>  #endif
>  
>  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index df7d133056ce..dfe1baa5bbb7 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1631,22 +1631,7 @@ static int init_hyp_mode(void)
>  		}
>  	}
>  
> -	for_each_possible_cpu(cpu) {
> -		kvm_host_data_t *cpu_data;
> -
> -		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
> -		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
> -
> -		if (err) {
> -			kvm_err("Cannot map host CPU state: %d\n", err);
> -			goto out_err;
> -		}
> -	}
> -
> -	err = hyp_init_aux_data();
> -	if (err)
> -		kvm_err("Cannot map host auxiliary data: %d\n", err);
> -
> +	hyp_init_aux_data();
>  	return 0;
>  
>  out_err:
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
