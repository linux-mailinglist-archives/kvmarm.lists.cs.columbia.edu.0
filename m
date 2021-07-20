Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0550F3CF8E5
	for <lists+kvmarm@lfdr.de>; Tue, 20 Jul 2021 13:36:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87C7F4B0DE;
	Tue, 20 Jul 2021 07:36:29 -0400 (EDT)
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
	with ESMTP id P4y1orOS+Qcw; Tue, 20 Jul 2021 07:36:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E8DB4B0D7;
	Tue, 20 Jul 2021 07:36:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F07D4B0C0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 07:36:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRIJwBNCXyBn for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Jul 2021 07:36:26 -0400 (EDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 812914B0BF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 07:36:26 -0400 (EDT)
Received: by mail-wr1-f47.google.com with SMTP id m2so25665857wrq.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=d5WGGczUDQ+z5x6mRYmC5MZD9AX2DybKW9Ucl1ZZ5x4=;
 b=GGHkZUBInNS2eawKVqyh2dZiBgqBA0ZAt6XqWzq6FhWyVhlXFPbnrSHWOAFPS8Z9ZR
 dVibOwR1wemIROQr4YCp1xwVf64z1Rg6WMpiGmIbfEBFWPrx7MmRdjb8gV3/SgBP2ZFz
 a9equnKu6rHXrtF1/q3vcbOQPyLeVxfwNuL+UDob2YQyCPEw22TnPSzcp86A1o8wmep8
 1ovlB+LtfWokYN7bMc5KLPeyi/66y6j4HTX1EvxJshk2q4Z+Mrbh6HeBmZDHYOODRsRw
 ktVTLWOHs/HMh+a+mLrAgjBio5S/1PCoIAKLdzp+GyxBK5Ra+Tjpp58IHq5VCMfwp/Vd
 YXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d5WGGczUDQ+z5x6mRYmC5MZD9AX2DybKW9Ucl1ZZ5x4=;
 b=CRFUz8Yk5+5rRDiVC0b6A1mFY/7iimRcdvqMNQPORQ6Ye+0iyISlNaXDz3qFUX3lQf
 WwIhMW/MGFgwmONdYRDCae64iDxasQwcz7vzqpT6Ea3lEvLKzejsQwAY8EhrSF0DnyBR
 XH1Sp0z+c5tcfaUUUU9ZRR12tP9+PEWMmwBxggnvrDbN/Cxk+se42XBtJqczaTb2AlwJ
 4NGoj2d7XXq00m5HsR+t7f72oKievaVeMmNq+4GCuDGf58+R7vqpSugPJY2kZIdH5/a5
 6Ga/BqzfqFPH5u0Lc141HYyP9p/bUF2jIK/3thPziKLtxiJ7gk8Q4Zv+pMr6VvpT/OHv
 aQJw==
X-Gm-Message-State: AOAM530AcKnSJ4P1Mvxb0FtFLndXxoVlIYBfiDfffATCM6ffTMn/3KsS
 EFlTXACBLiDNP1PIcV2uJa7o2A==
X-Google-Smtp-Source: ABdhPJxWCOn5XF/Z6Scsndh/Ax3SBXXxu2JEXA+6Z/V9aXahHy5B6KiYzK39pJgPk6HYOKcI6cp8rA==
X-Received: by 2002:a5d:6589:: with SMTP id q9mr2297646wru.284.1626780985461; 
 Tue, 20 Jul 2021 04:36:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
 by smtp.gmail.com with ESMTPSA id d9sm23135294wrx.76.2021.07.20.04.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jul 2021 04:36:25 -0700 (PDT)
Date: Tue, 20 Jul 2021 12:36:21 +0100
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 03/16] KVM: arm64: Turn kvm_pgtable_stage2_set_owner into
 kvm_pgtable_stage2_annotate
Message-ID: <YPa1NfbEDY3kVHzr@google.com>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-4-maz@kernel.org>
 <YPag0YQHB0nph5ji@google.com> <871r7t9tgi.wl-maz@kernel.org>
 <YPanmXfdr9rqnICK@google.com> <87zguh8c4l.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zguh8c4l.wl-maz@kernel.org>
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

On Tuesday 20 Jul 2021 at 12:20:58 (+0100), Marc Zyngier wrote:
> On Tue, 20 Jul 2021 11:38:17 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > On Tuesday 20 Jul 2021 at 11:21:17 (+0100), Marc Zyngier wrote:
> > > On Tue, 20 Jul 2021 11:09:21 +0100,
> > > Quentin Perret <qperret@google.com> wrote:
> > > > 
> > > > On Thursday 15 Jul 2021 at 17:31:46 (+0100), Marc Zyngier wrote:
> > > > > @@ -815,7 +807,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > > > >  		.arg		= &map_data,
> > > > >  	};
> > > > >  
> > > > > -	if (owner_id > KVM_MAX_OWNER_ID)
> > > > > +	if (!annotation || (annotation & PTE_VALID))
> > > > >  		return -EINVAL;
> > > > 
> > > > Why do you consider annotation==0 invalid? The assumption so far has
> > > > been that the owner_id for the host is 0, so annotating a range with 0s
> > > > should be a valid operation -- this will be required when e.g.
> > > > transferring ownership of a page back to the host.
> > > 
> > > How do you then distinguish it from an empty entry that doesn't map to
> > > anything at all?
> > 
> > You don't, but that's beauty of it :)
> > 
> > The host starts with a PGD full of zeroes, which in terms of ownership
> > means that it owns the entire (I)PA space. And it loses ownership of a
> > page only when we explicitly annotate it with an owner id != 0.
> 
> Right. But this scheme doesn't apply to the guests, does it?

Right, the meaning of a NULL PTE in guests will clearly be something
different, but I guess the interpretation of what invalid mappings mean
is up to the caller.

> Don't we
> need something that is non-null to preserve the table refcounting?

Sure, but do we care? If the table entry gets zeroed we're then
basically using an 'invalid block' mapping to annotate the entire block
range with '0', whatever that means. For guests it won't mean much, but
for the host that would mean sole ownership of the entire range.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
