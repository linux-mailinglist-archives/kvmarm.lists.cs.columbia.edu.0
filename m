Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A36C3398533
	for <lists+kvmarm@lfdr.de>; Wed,  2 Jun 2021 11:23:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2610149FA6;
	Wed,  2 Jun 2021 05:23:44 -0400 (EDT)
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
	with ESMTP id hi-23A3UhSgb; Wed,  2 Jun 2021 05:23:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F17E49F92;
	Wed,  2 Jun 2021 05:23:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDA54402DB
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Jun 2021 05:23:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmf2xk-mds2q for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Jun 2021 05:23:37 -0400 (EDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 90317406D3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Jun 2021 05:23:37 -0400 (EDT)
Received: by mail-wm1-f54.google.com with SMTP id
 f20-20020a05600c4e94b0290181f6edda88so3322649wmq.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Jun 2021 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WmVa2b7NUFKbzMkhRQoxLzdNVa4IgoT+niyCi15lBaU=;
 b=fJRU2AeKIPcQx11KLen+Ij89vZ+kwU0B8R7ieQATn/S0NLwL1fvRl5LLh3ACQr34HC
 O/8C0RF/0XjOPLbaQwJxsyQTmFiVL+Csf6hhVR3MNdjIKQDCPOwwgZZMoGIc35TOnpPe
 pYii0GAXsOF3dYFSG/Q0zJeCb6QtDpn02L6GGQSwx7MZ9E9s317Gsikz/vHIA3HLacl9
 3ZZRtTIXdgDwIgatsDJ1EBqZI7eZWxX4fgyowEP5VzxlJvcFR/j5QGj3pUgUr+hlWyY5
 d0JiS7tPfNQp6xOkVawGkmAOHWLu632QX4JEKAoYuAX+6eVgjx1gIPD/QQsd63szgsgx
 218A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WmVa2b7NUFKbzMkhRQoxLzdNVa4IgoT+niyCi15lBaU=;
 b=iJK+5e1WvJo8CXT1+uawIm9CpGy0PNjf5mRBf4vDijIQ3hLwUduIKWQ2+bBJYlEC9h
 5zFik3dcqurNPJ47fenReSVX+rsOYj3SIsl3Tll71s0bZ72jzWeYKIjU3TyG4fLS/By3
 DGg1fjnBEzJCxDnkIulh4L35cFTxMldu1MEarrkdboVJL5WucCvyPSU5gIKZHg8DQelh
 BZuyi1/tvMmfrX1lp3zNP1m8NfDqkHwkD88+5U3/FE+7LBwGXCEIUcHi25RJdN1PQbgs
 aAJ2B3OXksZdQpV1UPL8YNwYt0GAVmuYQgB8WX24wMJpH4z3CZ/Y//A/Xcm72A3a8VRS
 T+PQ==
X-Gm-Message-State: AOAM531h4otxOUSrPPkwocZSvrjq8Md0/AOU1lv0gZ1lmYtyI2KkpllY
 CYe2CC5lj07iAhWgpEZl2iq4Dw==
X-Google-Smtp-Source: ABdhPJxrBmcIQdy1jyLXdbeY8xm3r2YATiuKPsOu+SRZUU2eDFxWBsAmhIOgoXGcJfVGwfjPxAVmew==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr31888176wmb.65.1622625816371; 
 Wed, 02 Jun 2021 02:23:36 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com.
 [35.195.168.105])
 by smtp.gmail.com with ESMTPSA id h14sm2009325wmb.1.2021.06.02.02.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 02:23:35 -0700 (PDT)
Date: Wed, 2 Jun 2021 09:23:33 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/7] KVM: arm64: Remove list_head from hyp_page
Message-ID: <YLdOFUPjgCK33Vd5@google.com>
References: <20210527125134.2116404-1-qperret@google.com>
 <20210527125134.2116404-4-qperret@google.com>
 <87k0nd1wgx.wl-maz@kernel.org> <YLZWtnGVQSguI1P6@google.com>
 <87fsy11nz6.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fsy11nz6.wl-maz@kernel.org>
Cc: kernel-team@android.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Tuesday 01 Jun 2021 at 18:41:49 (+0100), Marc Zyngier wrote:
> On Tue, 01 Jun 2021 16:48:06 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > On Tuesday 01 Jun 2021 at 15:38:22 (+0100), Marc Zyngier wrote:
> > > On Thu, 27 May 2021 13:51:30 +0100,
> > > Quentin Perret <qperret@google.com> wrote:
> > > > +/*
> > > > + * Pages that are available for allocation are tracked in free-lists, so we use
> > > > + * the pages themselves to store the list nodes to avoid wasting space. As the
> > > > + * allocator always returns zeroed pages (which are zeroed on the hyp_put_page()
> > > > + * path to optimize allocation speed), we also need to clean-up the list node in
> > > > + * each page when we take it out of the list.
> > > > + */
> > > > +static inline void page_remove_from_list(struct hyp_page *p)
> > > > +{
> > > > +	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);
> > > 
> > > Nit: How about changing hyp_page_to_virt() so that it returns a
> > > convenient 'void *', and get rid of the ugly casts?
> > 
> > It should already return void *, but I kind of liked the explicit cast
> > here for documentation purpose. We're turning a 'random' piece of unused
> > memory into a typed object, so that felt like a useful annotation. Happy
> > to get rid of it though.
> 
> My expectations were that using hyp_page_to_virt() already serves as a
> pretty big warning that we're doing something unusual.
> 
> I guess that if we want to be really careful about those, we should
> then be consistent and make it return a uintptr_t (or unsigned long)
> instead, actively making use of the cast, consistently, everywhere.

Right, so I'd prefer keeping it void * for consistency with the EL1
equivalent -- much of this aims to be API compatible with the Linux
stuff. I'll get rid of the cast and post a v2 shortly.

Cheers,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
