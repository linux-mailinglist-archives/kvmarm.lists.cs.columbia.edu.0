Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C22340F1
	for <lists+kvmarm@lfdr.de>; Fri, 31 Jul 2020 10:14:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 65D494B496;
	Fri, 31 Jul 2020 04:14:44 -0400 (EDT)
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
	with ESMTP id ogMbsa6J32pQ; Fri, 31 Jul 2020 04:14:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BA974B46F;
	Fri, 31 Jul 2020 04:14:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F7164B447
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 04:14:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvDlM0oIk4JJ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 Jul 2020 04:14:41 -0400 (EDT)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 552BC4B413
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 04:14:41 -0400 (EDT)
Received: by mail-wm1-f67.google.com with SMTP id k8so8441073wma.2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mqLvWnowlqi0F/JYgNm/w51Gd43hH6qdoKqkY6IFrjw=;
 b=K+lwN1PP9W4hQIO0DXoR2KOy/67nyhrV5ZmU+SUAtkBHlIUygAj8XyBlvonjFYzDIj
 qq6fWw3/skMxtuILAV7HdWMaVF3LmQTrQRZl7xM3GsEFXGOX/xjQkpuSuGQFPegoRHa9
 /WGLcOWT3p6JNTIGJGWbQlnZ8n63V3B9Btnkb2aqDD2WvxsIHYHsX5PK/lFWdT4tVYMJ
 JTflK7f2yfdPTzDQuxKBM1IfIzVOjmCZh+MepfUV/cYVINX9R2cJHLHkFjQQfNec5qEw
 XTuKtYFmPSq1AXrB3/+3rqSkqpPRW2QMy5UVTUQ8SOpAwySfdx4G5ECWfHOGl7gzmWwD
 vBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mqLvWnowlqi0F/JYgNm/w51Gd43hH6qdoKqkY6IFrjw=;
 b=nJOgc8imwQgxhOMj9LxgQ+fffROJXNpKQshwVlDy9chU/dJGDNW2nyrUIeu0eeDjC7
 YYrOcRn0YHe2uu5H7b1Q8B7j5h2b89dk7PucXT+13oFnSLOFTahg6bFbkjLrwqesm1MY
 jIAYHqcC4MQlDxtwRHpnlYJEbp2UBdwdfcVXTN94Es6VmPOj3VeGFTmlg8NIf2kM1g5R
 CS/nEZx/grURMBzrwpWfzM5Am932e4vCsqhzvO3J8Uo4oIXM2Rx1R4HYi6zuN1d6OdRr
 xduoTfJjhBQDFRGf6Wg27AqJrecG4rtwyni/ydazn9ucDvGHqYhVcd8Rzg72z6YKPWy8
 AvPA==
X-Gm-Message-State: AOAM531S8XYreJ+7Nacb5M/MLBBfE1cSMc89rZPdHbjYBatM1CUrikQ3
 4bbskSpWPhW/C26/za3TtrhoOQ==
X-Google-Smtp-Source: ABdhPJwWsIcLz8f6wgdN4NG7SpBXgChRXZTUblxm4WrA7tYJ6CZPPhsc7ExK18PUUgqMc9n8r5mFmw==
X-Received: by 2002:a05:600c:230e:: with SMTP id
 14mr2661570wmo.3.1596183280121; 
 Fri, 31 Jul 2020 01:14:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
 by smtp.gmail.com with ESMTPSA id 12sm2001488wme.22.2020.07.31.01.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 01:14:39 -0700 (PDT)
Date: Fri, 31 Jul 2020 09:14:36 +0100
From: Quentin Perret <qperret@google.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 02/20] KVM: arm64: Add support for creating
 kernel-agnostic stage-1 page tables
Message-ID: <20200731081436.GA3201636@google.com>
References: <20200730153406.25136-1-will@kernel.org>
 <20200730153406.25136-3-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200730153406.25136-3-will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hey Will,

On Thursday 30 Jul 2020 at 16:33:48 (+0100), Will Deacon wrote:
> +void *kvm_pgtable_hyp_alloc_cookie(u32 va_bits)
> +{
> +	struct kvm_pgtable *pgt = kzalloc(sizeof(*pgt), GFP_KERNEL);
> +
> +	if (!pgt)
> +		return NULL;
> +
> +	pgt->ia_bits = va_bits;
> +	pgt->start_level = kvm_start_level(va_bits);
> +
> +	pgt->pgd = (kvm_pte_t *)get_zeroed_page(GFP_KERNEL);
> +	if (!pgt->pgd) {
> +		kfree(pgt);
> +		pgt = NULL;
> +	}
> +
> +	return pgt;
> +}
> +
> +static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> +			   enum kvm_pgtable_walk_flags flag, void * const arg)
> +{
> +	free_page((unsigned long)kvm_pte_follow(*ptep));
> +	return 0;
> +}
> +
> +void kvm_pgtable_hyp_free_cookie(void *cookie)
> +{
> +	size_t pgd_sz;
> +	struct kvm_pgtable *pgt = cookie;
> +	struct kvm_pgtable_walker walker = {
> +		.cb	= hyp_free_walker,
> +		.flags	= KVM_PGTABLE_WALK_TABLE_POST,
> +	};
> +
> +	if (kvm_pgtable_walk(cookie, 0, BIT(pgt->ia_bits), &walker))
> +		kvm_err("Failed to free page-table pages\n");
> +
> +	pgd_sz = kvm_pgd_pages(pgt) * PAGE_SIZE;
> +	free_pages_exact(pgt->pgd, pgd_sz);

Given that the pgd is unconditionally a single page for the stage 1 case
(as per kvm_pgtable_hyp_alloc_cookie() above), should we simplify this
to a simple free_page()? Or did you want to factorize this with the
stage 2 free path?

> +	kfree(pgt);
> +}

Cheers,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
