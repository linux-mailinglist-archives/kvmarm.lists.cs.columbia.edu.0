Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 415BA3D8D8D
	for <lists+kvmarm@lfdr.de>; Wed, 28 Jul 2021 14:15:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE0514B089;
	Wed, 28 Jul 2021 08:15:03 -0400 (EDT)
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
	with ESMTP id rY4Q+wPy8aVi; Wed, 28 Jul 2021 08:15:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A7254B092;
	Wed, 28 Jul 2021 08:15:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EE314A2E5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 08:15:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NiOWnFvs4gw8 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Jul 2021 08:15:00 -0400 (EDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F31834A195
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 08:14:59 -0400 (EDT)
Received: by mail-wm1-f53.google.com with SMTP id
 f14-20020a05600c154eb02902519e4abe10so4131209wmg.4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mYbbIZoMD/b/Fq8e37HailMl4O7MY4m6Mt2gCBpEuDQ=;
 b=fqTrQ4uuHUeFCXJuKjWrrRZAjUSahCTgoWavfLLB4lOMC3ZYN+qMijBsymlR1rNoOv
 TZENLRhzK4CaipcXK90ge4PAAy3XlMGEgLugd/1FTgGlOw6NaMgGePd5Qq1wb60j8pOC
 V6T6u5XHmCmvkGD7Yu1lE/8Du+eMRUZUJNr84DGYfrJM5gBPbCL0lf5PgJJ3gU29r2Hn
 MApOPtQ30W4H8J/wz8oBgYYzwxVUYeroWafjX0hvAUzv7cxlXyTNPNpQ0SCBMhhX059q
 ahNwTVnKTF2LsmLZh5a2sEQOjMwzLrRA1gNMstiSvYy/TIEcVzg7CYhY0Rks1j+Zj41+
 stiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mYbbIZoMD/b/Fq8e37HailMl4O7MY4m6Mt2gCBpEuDQ=;
 b=gE/ou8wLPtSfdyeYgjOOeTE+dSR1syiHr7XwT8Za6wMZZdcyQXHRrL3gSv3C2LBbp4
 1D5kDCByjP1kXFSvFgJySrHYGzIQJbDuM1EgfLx8sR/F4YsDkhqRjulR2kQU5bVHOvzJ
 fSzYtNNK7+2eZccpkqVz0OfiAPvZlFTW6ZX/S3eA1/RaWr6OXDh4/vP6dFDYllTbu3Ng
 5u2ASAQsSOppYmNBmdwYTsUDsYqfSEGhF0X8vok7IRDIbdCS1gSmoKLYqiDI84HoqJ8m
 a/BJZLRIdCrdJRjWZej7Cxe6dmPdw77gKBOjwuX9xH5jYLwFYWldXyHN8syAbzX/cflt
 sEsw==
X-Gm-Message-State: AOAM532euGkA2NevBW5dN0W4sjVM2/Xenc0NMSeolXJ/95z+eB3/x6RU
 65n4htDi45seCTkIPEBIX6vVSw==
X-Google-Smtp-Source: ABdhPJzgNbqRIxzd4hehDTC+KCWYXXRYwck4YjYrAzMJP5c35Whvluz0sZ3AKraerAUjQbY5ud0c6g==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr23388587wmk.5.1627474498601;
 Wed, 28 Jul 2021 05:14:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ff6f:6a8e:935d:3f53])
 by smtp.gmail.com with ESMTPSA id w5sm1534611wro.45.2021.07.28.05.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jul 2021 05:14:58 -0700 (PDT)
Date: Wed, 28 Jul 2021 13:14:54 +0100
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH v2 12/16] KVM: arm64: Mark host bss and rodata section as
 shared
Message-ID: <YQFKPoUUjJyceVjR@google.com>
References: <20210726092905.2198501-1-qperret@google.com>
 <20210726092905.2198501-13-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210726092905.2198501-13-qperret@google.com>
Cc: qwandor@google.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
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

On Monday 26 Jul 2021 at 10:29:01 (+0100), Quentin Perret wrote:
> +static int finalize_mappings(void)
> +{
> +	enum kvm_pgtable_prot prot;
> +	int ret;
> +
> +	/*
> +	 * The host's .bss and .rodata sections are now conceptually owned by
> +	 * the hypervisor, so mark them as 'borrowed' in the host stage-2. We
> +	 * can safely use host_stage2_idmap_locked() at this point since the
> +	 * host stage-2 has not been enabled yet.
> +	 */
> +	prot = pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_BORROWED);
> +	ret = host_stage2_idmap_locked(__hyp_pa(__start_rodata),
> +				       __hyp_pa(__end_rodata), prot);
> +	if (ret)
> +		return ret;
> +
> +	return host_stage2_idmap_locked(__hyp_pa(__hyp_bss_end),
> +					__hyp_pa(__bss_stop), prot);
> +}
> +
>  void __noreturn __pkvm_init_finalise(void)
>  {
>  	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
> @@ -167,6 +199,10 @@ void __noreturn __pkvm_init_finalise(void)
>  	if (ret)
>  		goto out;
>  
> +	ret = finalize_mappings();
> +	if (ret)
> +		goto out;

While working on v3 of this series it occurred to me that we can
actually do vastly better than this. Specifically, the annotation of
shared pages currently happens in two places (recreate_hyp_mappings()
and finalize_mappings()) with nothing to guarantee they are in sync. At
the same time, the annotation of pages owned by the hypervisor is left
to the host itself using the __pkvm_mark_hyp hypercall. But clearly, by
the point we arrive to finalize_mappings() above, all the information I
need is already stored in the hyp pgtable. That is, it should be fairly
easy to walk the hyp stage-1, and for each valid mapping create a
matching annotation in the host stage-2 to mark the page shared or owned
by the hypervisor.

I'll have a go at implementing this in v3, which would guarantee
consistency across page-tables once the hypervisor is initialized, and
also allow to get rid of __pkvm_mark_hyp entirely. But if anybody thinks
this is a bad idea in the meantime, please shout!

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
