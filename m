Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C943D3CF8B0
	for <lists+kvmarm@lfdr.de>; Tue, 20 Jul 2021 13:16:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DFB24B0C5;
	Tue, 20 Jul 2021 07:16:28 -0400 (EDT)
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
	with ESMTP id ZWSjqA84IrbM; Tue, 20 Jul 2021 07:16:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B024A4B0BF;
	Tue, 20 Jul 2021 07:16:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 58FED4A193
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 07:16:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QiI6Zy5QQgJ1 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Jul 2021 07:16:22 -0400 (EDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4AC0440808
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 07:16:22 -0400 (EDT)
Received: by mail-wr1-f42.google.com with SMTP id l7so25561691wrv.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lpz51H3kvzr0DXJiE5RSxJNphxVtTP/JsLlCDtT69nE=;
 b=qIC8S+W4YEqX+/j1F2FfOOKMPB60fsBSS7jpd0cT0fUpSNivYVwV9Lc7AMV3WoXmMw
 v9CgSh/vI2qWbAPurBZw5TN+KhWhe340MqIv4ApDr2YkuHg+Csl3bWm9i8QeClaaikDF
 uMaiwpDXgtAjXyOpfnmR2iYIblGFLYIY3j+yTDSwccOVQiIL8S3kXlqDClfWK41H+kgw
 kmra3575DBZwkejSgK4e4RWzFoz1f0sOdv7uO07ytjh1dww1naA5hdZhhZFRFHVDi3Yj
 hQdxBPLQFqiPS5CCQ0OE+yh0ewTntdOyy+voxTzTeMDdMan7IlXYk0lQLYB1dMXeHg6A
 /60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lpz51H3kvzr0DXJiE5RSxJNphxVtTP/JsLlCDtT69nE=;
 b=qH9L5V6J7uup0596RzOS7kHHT5Urt0EDn/ZYQCRQfPemLWDLWTe+v9OE1UEF2/jvgW
 r9iMUC3rYp+Ncvnv+BKtQNq/KL6ZutDlDKZ6NdWVWTw40HPJmvcOvJjcVvFu0nsmXfsK
 X3RscXawwAn8/nWlTEXmWddlxde4lXS8uYOBzsAdp6ULwYvXB76ZcDKiEeozyIW0gFoB
 qvEQ7TiiBN1A4M1idPlUi8icgYq29ttJAf3Dqpa1IIFms/lz8HsMRGso5z55W5oYOuBR
 n4haezGd9ge2Yat4z7skNdeI2qfB3ICSZ6rmsKw9RG8INWzQVlb/4WekKE+wmuP6AKL1
 stqQ==
X-Gm-Message-State: AOAM533MEJixE9b90YNi4bVROHDUCfFHuCOkFr9UTriPPw7j/VboVEsD
 XDwPDutBlDLiJb0pNHYiLn/vYA==
X-Google-Smtp-Source: ABdhPJzyDbPtX+5Q7MPnRmTCUDtOQw0hbyz28e4E5BQ9dsfjysvHdxUpebOfYRKz9mVC05s+yeb7VQ==
X-Received: by 2002:a05:6000:102:: with SMTP id
 o2mr35120793wrx.299.1626779781184; 
 Tue, 20 Jul 2021 04:16:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
 by smtp.gmail.com with ESMTPSA id a8sm23462978wrt.61.2021.07.20.04.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jul 2021 04:16:20 -0700 (PDT)
Date: Tue, 20 Jul 2021 12:16:17 +0100
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 15/16] arm64: Add a helper to retrieve the PTE of a fixmap
Message-ID: <YPawgYJYfD+EfXBW@google.com>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-16-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715163159.1480168-16-maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, linux-kernel@vger.kernel.org,
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

On Thursday 15 Jul 2021 at 17:31:58 (+0100), Marc Zyngier wrote:
> In order to transfer the early mapping state into KVM's MMIO
> guard infrastucture, provide a small helper that will retrieve
> the associated PTE.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/fixmap.h |  2 ++
>  arch/arm64/mm/mmu.c             | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 4335800201c9..1aae625b944f 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -105,6 +105,8 @@ void __init early_fixmap_init(void);
>  
>  extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
>  
> +extern pte_t *__get_fixmap_pte(enum fixed_addresses idx);
> +
>  #include <asm-generic/fixmap.h>
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d74586508448..f1b7abd04025 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1286,6 +1286,21 @@ void __set_fixmap(enum fixed_addresses idx,
>  	}
>  }
>  
> +pte_t *__get_fixmap_pte(enum fixed_addresses idx)
> +{
> +	unsigned long 	addr = __fix_to_virt(idx);

Nit: odd spacing here.

> +	pte_t *ptep;
> +
> +	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
> +
> +	ptep = fixmap_pte(addr);
> +
> +	if (!pte_valid(*ptep))
> +		return NULL;
> +
> +	return ptep;
> +}
> +
>  void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>  {
>  	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
> -- 
> 2.30.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
