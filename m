Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2395A4702F3
	for <lists+kvmarm@lfdr.de>; Fri, 10 Dec 2021 15:37:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 93D104B203;
	Fri, 10 Dec 2021 09:37:30 -0500 (EST)
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
	with ESMTP id lGydj-KXnF8X; Fri, 10 Dec 2021 09:37:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 185704B1EF;
	Fri, 10 Dec 2021 09:37:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B60F44B1C1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Dec 2021 09:37:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6B7IZUABpN6Y for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Dec 2021 09:37:26 -0500 (EST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2E1A34B16C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Dec 2021 09:37:26 -0500 (EST)
Received: by mail-wm1-f41.google.com with SMTP id
 r9-20020a7bc089000000b00332f4abf43fso7307539wmh.0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Dec 2021 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iT+nRlkqP8ujdkhR1yHcmqTSB9Hb9nBGvw1m1PwYrU4=;
 b=LJW+Qg/MN2vlQ4hC5d84O4HWpmjzzbl+hwt4dYAELPT880hHpRFAZikcPqMVDWcaW5
 JtAe4D8wz5kZWyjyAB/+4xUZrgpNpozYFtRRLLKkMoU6/EmouGTvY6FPkA77kQoyvs/v
 aFr3sL11apWy0rCQjdfNzXf7eDGBYaG1f36x9tlciYdd8W99tguVUtOddHdFZoXklmgR
 9YEkIUxD3OWUv4I+T0ggbI7kTKXI2RtL7uOBPtbJhCb7AGimn/5ScmHknajg8CHl0fKD
 arVUYOpYX5UgcPQV8y9cCLcRZwdZQQrt5Sny0Bc2WwyHMnHoqBa3R++EnZ4LEG0SoY/p
 xrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iT+nRlkqP8ujdkhR1yHcmqTSB9Hb9nBGvw1m1PwYrU4=;
 b=XBIFI8HP348TyrOvTdo1wakpjiy9h2SjgNZBBd9pmTepli3f/Pi7RGXuStlzKOtz+s
 LMMyJxBif70PuWVqXzmCncbXhJOQ5URdtv8kLoK3Ul4a7Tb/8g8pCAGDxT13AWugpKJa
 ttrhTV89zFFyp6UmOOA/mNuwPOu39yPOjN/eDcT0pII8UuHNdBafMLtd6NKlEpkIfk/W
 s/H0R2pP+IyijG+RfDuCXfzJ4h1Zl40h2K2J+zgCplzVk9PF6L1HWuG2dAkyh4pujcBR
 QOrJDryz9E0N4asNzR+aZEe4C/2zMyBDEHbenYJMjGePzgUfQR4ATYeKXpYg7bvwJtjU
 7qwA==
X-Gm-Message-State: AOAM53364QSCsv1S4Lv8go00hTP6cep0F/wFChywFtgC6adGQikg7vvX
 CViG6GcFvd10mMqXYpmSZ47Tgw==
X-Google-Smtp-Source: ABdhPJzpmKQ+A4NRlPF6u1SVizDawCpgts4j/A6org/QHTlhW19yx/bTp0VUSDuxuLTJUFIurktC1A==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr17315115wmk.135.1639147044652; 
 Fri, 10 Dec 2021 06:37:24 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:76c1:fb36:1e22:8677])
 by smtp.gmail.com with ESMTPSA id g5sm3758412wri.45.2021.12.10.06.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 06:37:24 -0800 (PST)
Date: Fri, 10 Dec 2021 14:37:21 +0000
From: Quentin Perret <qperret@google.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 07/15] KVM: arm64: Introduce kvm_share_hyp()
Message-ID: <YbNmIfeRdgaQNf+l@google.com>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-8-qperret@google.com>
 <20211209111309.GB1912@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211209111309.GB1912@willie-the-truck>
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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

On Thursday 09 Dec 2021 at 11:13:10 (+0000), Will Deacon wrote:
> On Wed, Dec 01, 2021 at 05:04:01PM +0000, Quentin Perret wrote:
> > The create_hyp_mappings() function can currently be called at any point
> > in time. However, its behaviour in protected mode changes widely
> > depending on when it is being called. Prior to KVM init, it is used to
> > create the temporary page-table used to bring-up the hypervisor, and
> > later on it is transparently turned into a 'share' hypercall when the
> > kernel has lost control over the hypervisor stage-1. In order to prepare
> > the ground for also unsharing pages with the hypervisor during guest
> > teardown, introduce a kvm_share_hyp() function to make it clear in which
> > places a share hypercall should be expected, as we will soon need a
> > matching unshare hypercall in all those places.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_mmu.h |  1 +
> >  arch/arm64/kvm/arm.c             |  4 ++--
> >  arch/arm64/kvm/fpsimd.c          |  2 +-
> >  arch/arm64/kvm/mmu.c             | 27 +++++++++++++++++++++------
> >  arch/arm64/kvm/reset.c           |  2 +-
> >  5 files changed, 26 insertions(+), 10 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index f8f1096a297f..fd868fb9d922 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -299,6 +299,25 @@ static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
> >  	return 0;
> >  }
> >  
> > +int kvm_share_hyp(void *from, void *to)
> > +{
> > +	if (is_kernel_in_hyp_mode())
> > +		return 0;
> > +
> > +	/*
> > +	 * The share hcall maps things in the 'fixed-offset' region of the hyp
> > +	 * VA space, so we can only share physically contiguous data-structures
> > +	 * for now.
> > +	 */
> > +	if (is_vmalloc_addr(from) || is_vmalloc_addr(to))
> > +		return -EINVAL;
> 
> If we're adding these sanity checks, perhaps is_vmalloc_or_module_addr()
> would be worth using instead?

Ack, I'll fix that up.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
