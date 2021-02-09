Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D60FF314EDA
	for <lists+kvmarm@lfdr.de>; Tue,  9 Feb 2021 13:23:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 404DD4B717;
	Tue,  9 Feb 2021 07:23:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTL5yNfqL367; Tue,  9 Feb 2021 07:23:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11F5D4B740;
	Tue,  9 Feb 2021 07:23:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F13794B6D9
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Feb 2021 07:23:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwfy9HBQ7meB for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Feb 2021 07:23:12 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 09A454B6C8
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Feb 2021 07:23:12 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFB4664EB4;
 Tue,  9 Feb 2021 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612873390;
 bh=L+CvYP2l7yxFcu390LciJ5wzeQ4zlYr5y+5yTYVenYA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LDSUx5Wy/6WXXiafzKEK/f2JAMCSwNDd8U9cvhpFPM6vk0Mg9SCYWzpf41Fw00BNT
 NuiGBA6Fxs4ZBiRYT7xF28QYktSPLVTV0Qu9MxT9SFh35axTZGqekyQrTtRkIhOFPC
 2N8+Re1ScL4ZFotJE4gNLw/5KZo5FqGXIG6S8nyCGVQFwe46xsZbi275T6tRngYX5o
 635JJP4Nh2sRTaUfygmLKAzzXF3EPHnWdUjwgzQL/tGfUYXzpHENg6mtfhmzfYCnCz
 aElTv+gkpGxAPFlb6u8nxWqDH9daBoPGppZZbCziF4YVldt+9Eev+4UKyrY9o5VhAo
 jPRrXPoki0DnQ==
Date: Tue, 9 Feb 2021 12:23:04 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 16/26] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20210209122303.GA27058@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-17-qperret@google.com>
 <20210203143709.GA18907@willie-the-truck>
 <YBvQrHdbiNTSLQq6@google.com> <YCJdPXuGr9kCIKVM@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCJdPXuGr9kCIKVM@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Tue, Feb 09, 2021 at 10:00:29AM +0000, Quentin Perret wrote:
> On Thursday 04 Feb 2021 at 10:47:08 (+0000), Quentin Perret wrote:
> > On Wednesday 03 Feb 2021 at 14:37:10 (+0000), Will Deacon wrote:
> > > > +static void handle___pkvm_init(struct kvm_cpu_context *host_ctxt)
> > > > +{
> > > > +	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
> > > > +	DECLARE_REG(unsigned long, size, host_ctxt, 2);
> > > > +	DECLARE_REG(unsigned long, nr_cpus, host_ctxt, 3);
> > > > +	DECLARE_REG(unsigned long *, per_cpu_base, host_ctxt, 4);
> > > > +
> > > > +	cpu_reg(host_ctxt, 1) = __pkvm_init(phys, size, nr_cpus, per_cpu_base);
> > > 
> > > __pkvm_init() doesn't return, so I think this assignment back into host_ctxt
> > > is confusing.
> > 
> > Very good point, I'll get rid of this.
> 
> Actually not, I think I'll leave it like that. __pkvm_init can return an
> error, which is why I did this in the first place And it is useful for
> debugging to have it propagated back to the host.

Good point, but please add a comment!

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
