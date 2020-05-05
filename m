Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09FAF1C5B0D
	for <lists+kvmarm@lfdr.de>; Tue,  5 May 2020 17:27:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51C094B373;
	Tue,  5 May 2020 11:26:59 -0400 (EDT)
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
	with ESMTP id oTcyukqlWaPh; Tue,  5 May 2020 11:26:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 35C384B35F;
	Tue,  5 May 2020 11:26:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D9D94B359
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 May 2020 11:26:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ien43RZOv-mF for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 May 2020 11:26:56 -0400 (EDT)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E3AA64B27D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 May 2020 11:26:55 -0400 (EDT)
Received: by mail-wr1-f68.google.com with SMTP id i10so3222826wrv.10
 for <kvmarm@lists.cs.columbia.edu>; Tue, 05 May 2020 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zXzR1aUk2ZPbhK+lz+Dt3JwzZZ+Iz4WfBlkdVh6bKZ4=;
 b=D5EdbvAamPv1DrL3nw+DFrCk7yJ0oA0Pk0KLYgu30csT1pr6SXwD2SFPhq9b16Ree2
 ++nyPqcQTRhY6O4Ye2ZkZKT+PA8UYEWVNv+b5qGz096S1/6vAu7jppfCqUeBXoXr8RWO
 7tT1K1i1KFaSNwEvHVV4zEVWWxTxTC6RU4M0UrpLdzS9mv1Ck3AD1JaFPaB6R96xWoUo
 7vbzFotV8dB2owsQUB3g107Y3UnKh3b+dNwJi2k5zB7wZ4dZtkbsPmJXAjeEXX3qKG7C
 qMjHiL1zRDXFin/CH1nE4zNhx93UIfsgjKsB3VPBYiSt0+6KZCaoets0e7sCsJDWqVcP
 LYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zXzR1aUk2ZPbhK+lz+Dt3JwzZZ+Iz4WfBlkdVh6bKZ4=;
 b=JXCIvvoeZlhXDYahyk4RNr96Kl9eOwAyEiMW/nHY0CE31FOtAR8UTs8wTPMGuI0kQn
 5WDUay6aldA+0LDdFlrUnVo580GIxYFxPRItdKvKf2JGCIZe4xrMRmAIn7x/91rPy/Jg
 JXF8AykZxGLSK2R9d7xfJVzUMPbAkJF5afi/2N/FYFgcfpCUNjcfZaNbqSoPD1WIpt9y
 zpu9fm6NPEJTktXWSLu4whYo1zkibF7yY8iGDL/H8J5GjJi4FdQyd9y3HkUB2LfO7qbG
 zzhhr6dJtpwMoJu4PKuUsL845Q98wvwDbVIgTHDjhjxqIyrruWh196uqrgtyeiNFJj6Z
 PEVg==
X-Gm-Message-State: AGi0PuaY7lJPZgL5UWvJn1EioN/teHvRLg1piWEjCItHQJB+AdnXRb0+
 t3uMrf4Jh/g6br4NiiIFc+m8oQ==
X-Google-Smtp-Source: APiQypI8heCYBzq/jyvWYkJRjjg6bf3eXOCslINaHp7aVsym9o41pg4+cPoZ+kh2dtXuR1lVzqzCkg==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr4216171wrv.84.1588692414526;
 Tue, 05 May 2020 08:26:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:355c:447d:ad3d:ac5c])
 by smtp.gmail.com with ESMTPSA id a13sm3733889wrv.67.2020.05.05.08.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 08:26:53 -0700 (PDT)
Date: Tue, 5 May 2020 16:26:48 +0100
From: Andrew Scull <ascull@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 03/26] KVM: arm64: Factor out stage 2 page table data
 from struct kvm
Message-ID: <20200505152648.GA237572@google.com>
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-4-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422120050.3693593-4-maz@kernel.org>
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 kvmarm@lists.cs.columbia.edu, George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
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

Having a go at reviewing. Might turn out to be more useful as a learning
exercise for me rather than useful feedback but we've got to start
somewhere..

> -struct kvm_arch {
> +struct kvm_s2_mmu {
>  	struct kvm_vmid vmid;
>  
> -	/* stage2 entry level table */
> -	pgd_t *pgd;
> -	phys_addr_t pgd_phys;
> -
> -	/* VTCR_EL2 value for this VM */
> -	u64    vtcr;
> +	/*
> +	 * stage2 entry level table
> +	 *
> +	 * Two kvm_s2_mmu structures in the same VM can point to the same pgd
> +	 * here.  This happens when running a non-VHE guest hypervisor which
> +	 * uses the canonical stage 2 page table for both vEL2 and for vEL1/0
> +	 * with vHCR_EL2.VM == 0.
> +	 */
> +	pgd_t		*pgd;
> +	phys_addr_t	pgd_phys;
>  
>  	/* The last vcpu id that ran on each physical CPU */
>  	int __percpu *last_vcpu_ran;
>  
> +	struct kvm *kvm;
> +};
> +
> +struct kvm_arch {
> +	struct kvm_s2_mmu mmu;
> +
> +	/* VTCR_EL2 value for this VM */
> +	u64    vtcr;

VTCR seems quite strongly tied to the MMU config. Is it not controlled
independently for the nested MMUs and so remains in this struct?

> -static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
> +static void stage2_dissolve_pmd(struct kvm_s2_mmu *mmu, phys_addr_t addr, pmd_t *pmd)

How strictly is the long line style rule enforced? checkpatch has 16
such warnings on this patch.

> -static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
> +static void stage2_dissolve_pud(struct kvm_s2_mmu *mmu, phys_addr_t addr, pud_t *pudp)
>  {
> +	struct kvm *kvm __maybe_unused = mmu->kvm;
> +
>  	if (!stage2_pud_huge(kvm, *pudp))
>  		return;

There're a couple places with `__maybe_unused` on variables that are
then used soon after. Can they be dropped in these cases so as not to
hide legitimate warning?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
