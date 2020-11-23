Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BA2C0A5E
	for <lists+kvmarm@lfdr.de>; Mon, 23 Nov 2020 14:22:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 13DEC4BB3B;
	Mon, 23 Nov 2020 08:22:33 -0500 (EST)
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
	with ESMTP id qZqneiNF+mbs; Mon, 23 Nov 2020 08:22:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02DBF4BAF2;
	Mon, 23 Nov 2020 08:22:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D8B94BAD4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Nov 2020 08:22:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tux7khC3S8GI for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Nov 2020 08:22:28 -0500 (EST)
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C5FA64BAC1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Nov 2020 08:22:28 -0500 (EST)
Received: by mail-oi1-f193.google.com with SMTP id l206so19558521oif.12
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Nov 2020 05:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/kdqFZeAVjbR1EcrIlFEOxJOMeoTF+Ogzz6G56OSu8M=;
 b=rTTjlgTIUFSWUW/IC4OxUfYnSqKXdJJ9kqYLU/ZqrJAAi87J+7NiREj6ube4ANvu1g
 LsHbqdqUqsv1WvcxkWTewmx3DHXB3cakd8AOodJlcSbrVphhStsCFNaDA0bWkye3lKjm
 AcQllA7rtoChNr8xdo732cLNI+Hy+0pe5oXbIrBYCjn3BPQmXgi82/O1h35cWJqz9T2/
 edQbz0xLSKOG16+/9MKx49RjIACs+K8INOB7JtBQwPP8geXDKG9gyx9eckuCQ6gpNpdk
 Y9AZ333KWpIZr4Kza7TJAOnmVPkXgStofyfEhZK7IKJCMoly0/9ynQdr/CGbnQIOU6mh
 C0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/kdqFZeAVjbR1EcrIlFEOxJOMeoTF+Ogzz6G56OSu8M=;
 b=GXOY82UxkTtPixAVQT/pxK63EQyW9XOetw8hSrgEcKFWy7OsOkhqi/k8ss34ewtjZ2
 gbUfgFkWuR88ZvR1EEYqe17uD76KHXmRLarn/nWeJQ3Y4tAGTWbdRDUaNs1jpoHIEkpZ
 MIOpIQDsNJUKDqbEhhTUWMizvoKGZzS5Xt9S1pK7C56P88Hba8IQgQgsY5xEvX9uH9BO
 t9Cymh8FVO2RCltBNT0VMjNa74+/0C6F66+nkm6izYKf7gcoJ2ph8kGYToGHD//Cp13r
 k5Wil6Xvu7bP59LW7WlGrzd/28hmvY9rpLNXKaYbpOCmIbAx8H/1caBpgWe57abNi3ww
 WPiQ==
X-Gm-Message-State: AOAM532LYKJnMOisScmn1uJpRtzZChzlI3+i//VaF3D2zxRlCy2cqvpu
 KPS5sJRjVIORfjwEvME6bo84uQ==
X-Google-Smtp-Source: ABdhPJzEhLvMoLTH89tN1wdaa8/gjQDGQFbkETdg1TT2tpDZ6ILozNTF3nqBtpBt76eWvVSRF6fAZg==
X-Received: by 2002:a05:6808:301:: with SMTP id
 i1mr15073703oie.49.1606137747765; 
 Mon, 23 Nov 2020 05:22:27 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:acac:b2ef:c7d:fd8a])
 by smtp.gmail.com with ESMTPSA id s185sm7344774oia.18.2020.11.23.05.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 05:22:26 -0800 (PST)
Date: Mon, 23 Nov 2020 13:22:23 +0000
From: David Brazdil <dbrazdil@google.com>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH 13/27] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <20201123132223.oohevce4izuoaqi3@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-14-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201117181607.1761516-14-qperret@google.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, kernel-team@android.com,
 Frank Rowand <frowand.list@gmail.com>, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>
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

> +int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst)
> +{
> +	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
> +
> +	if (!regp)
> +		return -EINVAL;
> +
> +	memcpy(dst, regp, sizeof(*regp));
> +
> +	return 0;
> +}
> +
>  #define read_sysreg_case(r)	\
>  	case r:		return read_sysreg_s(r)
>  
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index dd8ccc9efb6a..c35d768672eb 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -116,6 +116,8 @@ __kvm_nvhe___memcpy			= __kvm_nvhe___pi_memcpy;
>  __kvm_nvhe___memset			= __kvm_nvhe___pi_memset;
>  #endif
>  
> +_kvm_nvhe___flush_dcache_area		= __kvm_nvhe___pi___flush_dcache_area;
> +

Could you help my understand why we need this?
* Why do we need PI routines in the first place? Would my series that fixes
  relocations in hyp code remove the need?
* You added these aliases for the string routines because you were worried
  somebody would change the implementation in arch/arm64/lib, right? But this
  cache flush function is defined in hyp/nvhe. So why do we need to point to
  the PI alias if we control the implementation?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
