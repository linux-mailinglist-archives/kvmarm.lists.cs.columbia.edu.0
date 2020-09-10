Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 017972647EA
	for <lists+kvmarm@lfdr.de>; Thu, 10 Sep 2020 16:22:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AAD554B2EC;
	Thu, 10 Sep 2020 10:22:09 -0400 (EDT)
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
	with ESMTP id pVT-FeiygI0D; Thu, 10 Sep 2020 10:22:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9890C4B279;
	Thu, 10 Sep 2020 10:22:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C1D74B22A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 10:22:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8EFIQ6JONMqp for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Sep 2020 10:22:06 -0400 (EDT)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4C0F64B20F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 10:22:06 -0400 (EDT)
Received: by mail-wm1-f67.google.com with SMTP id e17so245927wme.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=faHnn3MDZ+o9Yt7AhxvgCkCqk4LhPuX7FJChBWAArPk=;
 b=cb3uloxdvwDRe1Sjp2o7cqbmLdkpq2ufE0pjVaV1dWp5qCvy5zlFIvhpm883bFnLIT
 1q4QTgYiVhnSxHVJTyfNOU6smrDj+oyO2cBAh3N8iOiZWI3l25SUciqg9ZFltGfmr/QX
 Ujw4WvAbxZJQ+KKu6L4R0KLT0yJGXyTXIAJcwQ6B7OYaz64MMko5jJ1/maUiAiGLtP22
 M/zfmMDq4Xpvurfwazz0NLIZn2eTmAADRcSDSNbI/n01lYf4PKFMv64ST1d9NM59dYaw
 rod3ewihgvQwnjVwLZL502kCEM3ajgLG05sm0s+qcLpNiTSAt63eX34YkrpCd4icYYc+
 PExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=faHnn3MDZ+o9Yt7AhxvgCkCqk4LhPuX7FJChBWAArPk=;
 b=MCu62grta4sEtigptWIbowVLBCqDgOJuEE0Nor7UsUuwOFN5ktl+A4RFcvpAOQUZ2G
 aWUr17luBc/J3UNVc01YMRAcRqqT11m++sELvxZ03tcfI1w/m/tHIDKX0get5Z+dMpHD
 lmaQ2rR4FQ9Jh0ajLmgSDES0OIlO1Ue8tjxkVoDBYrQ0NPeDJEEXqPsNt5mkHE7NXELJ
 Qn1Me+k5/7osupDSWBRPBa9rzUYm/6XYhah3OcixSzmVwSgLnepr140tuicL987AmoE2
 J4+ufJO5gSfSNHLvypYgQSowv/Jx78KAI/lt4feBCMdceQLSfNnlJgIo0OEIfdaFGyMp
 fvZg==
X-Gm-Message-State: AOAM531hPnYwv543O5DLPjV4lx84YvQXoGhJrmq9Zoe3TewO4Esay79C
 ybDK+EGcbLzBKig2B/Z7HSUhsw==
X-Google-Smtp-Source: ABdhPJy1RpoPFKJBj75sNw3IPmQZKuNc0NIWCWdeXX7q+xyNsbP63rvzsXVnG2fdXWLtmVOPSbWbzQ==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr200648wmj.169.1599747724967; 
 Thu, 10 Sep 2020 07:22:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 by smtp.gmail.com with ESMTPSA id c10sm3851717wmk.30.2020.09.10.07.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 07:22:04 -0700 (PDT)
Date: Thu, 10 Sep 2020 15:21:59 +0100
From: Andrew Scull <ascull@google.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 02/21] KVM: arm64: Add stand-alone page-table walker
 infrastructure
Message-ID: <20200910142159.GF93664@google.com>
References: <20200907152344.12978-1-will@kernel.org>
 <20200907152344.12978-3-will@kernel.org>
 <4ef01cff-71ac-7f3c-2404-af184f5a5cb4@arm.com>
 <20200910123712.GB18100@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910123712.GB18100@willie-the-truck>
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Thu, Sep 10, 2020 at 01:37:13PM +0100, Will Deacon wrote:
> On Wed, Sep 09, 2020 at 04:29:26PM +0100, Alexandru Elisei wrote:
> > On 9/7/20 4:23 PM, Will Deacon wrote:
> > > [..]
> > > +
> > > +int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > > +		     struct kvm_pgtable_walker *walker)
> > > +{
> > > +	struct kvm_pgtable_walk_data walk_data = {
> > > +		.pgt	= pgt,
> > > +		.addr	= ALIGN_DOWN(addr, PAGE_SIZE),
> > > +		.end	= PAGE_ALIGN(walk_data.addr + size),
> > > +		.walker	= walker,
> > > +	};
> > 
> > If the caller wants to walk [0x500, 0x1500), for PAGE_SIZE = 0x1000 (4K), the
> > function walks the range [0x0, 0x1000). Is that intentional?
> 
> Yes, although the caller specifies a base and a *size*, rather than an end
> address. As a concrete example, much of the hypervisor stage-1 mapping
> is created using PAGE_SIZE mappings of random ELF symbols, which correspond
> to arbitrary addresses. In these cases, we really do want to round-down the
> address and perform a PAGE_SIZE mapping.

I think Alexandru has a point here. Turning his example into something
equivalent that maps a random ELF symbol:

    struct some_hyp_state s = { ... };
    // &s == 0x500
    // sizeof(s) == PAGE_SIZE
    kvm_pgtable_walk(&s, sizeof(s), walker);

Given `s` straddles the two pages, the part in the second page won't be
mapped.

Should the end address instead be calculated as:

   .end = PAGE_ALIGN(addr + size),

> 
> The alternative would be to return an error if the size is not page-aligned,
> but I don't think that's really necessary, especially since we accept an
> unaligned base.
> 
> Will
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
