Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C644E3D207C
	for <lists+kvmarm@lfdr.de>; Thu, 22 Jul 2021 11:12:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 415C74B0E1;
	Thu, 22 Jul 2021 05:12:09 -0400 (EDT)
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
	with ESMTP id Onv+pTQLd1WH; Thu, 22 Jul 2021 05:12:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 50E8B4B0D2;
	Thu, 22 Jul 2021 05:12:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 13E6D4B0B1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Jul 2021 05:12:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnbGYSJPQ3QW for <kvmarm@lists.cs.columbia.edu>;
 Thu, 22 Jul 2021 05:12:02 -0400 (EDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B94754A4CD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Jul 2021 05:12:02 -0400 (EDT)
Received: by mail-wr1-f46.google.com with SMTP id m2so5142762wrq.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Jul 2021 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NaNS9AMgRmwWpk7IwOuTN+Dqg/nfKEvds147rH9Tsw4=;
 b=ecOgwWM0pxO8mzTAh4/Y9NmnUmrXKIT5LaCzZ6YB70MqSZc0e2QHL4FSMP/Cs70w71
 Ur5QgKQQr5sD1sSbh/MO/Y1K1b3JmBpFyxtSX8JKjxNlzPtdQUIQFCtpPh4MgPMaNI9J
 6U6SnNmQQ2n+xayFQbhYElJ3CYfYnE2pkowTi2ZIsJM7lyiug/9KoE7fly4mp3uddkFW
 GNC496bmEs61CWvpFoFpFZmXdcQMUMP9MqRZYnmhYUG+IWztvLd2Kn3z01attIDw7zl1
 A6jjXrbGH/PXNwY93OuFBHFGKmxWI5l+QIRigCPrc5YLVDdDFo0ziiuYJa7DFXmruZx4
 BEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NaNS9AMgRmwWpk7IwOuTN+Dqg/nfKEvds147rH9Tsw4=;
 b=p6j8DuWmxPQYWgMjGRaeRBTDDP8hXkXs7eKWwO5S6t2Xm2b9v0OKPjQb39n/NXaG1Y
 0iTj5aq9I1ul2ev+38aGLaNiV0ip8kILYJf9sTXHOL67izvAQ1Eydcn9W6jRlIvKyPxD
 E49p5PPX13C5hilEOensD2Nbrs4g5dFPsxSeB8ejbaAuVrghO9CnfvDVh864gv2E89or
 vW95VWAm5fVusvq7Tr0CPudxQzzAYpe1lzCpzXxKhK8R2SEkc5Jw3VXKeefAfjmVxbgZ
 HNIUr3dzcECoxyl9/gdk5U+gRprt5vQgsgYEZiJu4RoGYwZxT8y82KFIUno9x9BTT4ng
 3m9Q==
X-Gm-Message-State: AOAM533B5TW+oTeyklIx5kYOa/9osMmcs0jEfbSbmfyq2y4qgWTg7d3U
 EHorR/1tNnbahJniJ6JzfoVjzw==
X-Google-Smtp-Source: ABdhPJyLWiHBnDA36VBmChvvNm3hWvX+VZpa3Rz7wOqMiZ8+/dewGGLnMKuFbyZcmEza8fsTByf6lg==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr28245004wrv.293.1626945121506; 
 Thu, 22 Jul 2021 02:12:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:efb1:2fcc:e84:52ad])
 by smtp.gmail.com with ESMTPSA id f26sm24174882wmc.29.2021.07.22.02.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 02:12:01 -0700 (PDT)
Date: Thu, 22 Jul 2021 10:11:58 +0100
From: Quentin Perret <qperret@google.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Message-ID: <YPk2XqrOeP6dEtPL@google.com>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
 <f7d708704fb84380af85298a98f7a48c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f7d708704fb84380af85298a98f7a48c@huawei.com>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>, "maz@kernel.org" <maz@kernel.org>,
 Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Thursday 22 Jul 2021 at 06:45:14 (+0000), Shameerali Kolothum Thodi wrote:
> > From: Will Deacon [mailto:will@kernel.org]
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > index 4b60c0056c04..a02c4877a055 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > @@ -106,8 +106,7 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool,
> > void *dev_pgt_pool)
> > >  	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
> > >  	mmu->arch = &host_kvm.arch;
> > >  	mmu->pgt = &host_kvm.pgt;
> > > -	mmu->vmid.vmid_gen = 0;
> > > -	mmu->vmid.vmid = 0;
> > > +	atomic64_set(&mmu->vmid.id, 0);
> > 
> > I think this is the first atomic64 use in the EL2 object, which may pull in
> > some fatal KCSAN instrumentation. Quentin, have you run into this before?
> > 
> > Might be simple just to zero-initialise mmu for now, if it isn't already.
> 
> I will check that.

Yes I think what saves us here is that, AFAICT. arm64 doesn't support
KCSAN yet. But the day it does, this should fail to link (hopefully)
because of out-of-line calls into e.g. __kasan_check_write().

So yes, a simple zeroing here is probably preferable.

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
