Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8D3438E
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 11:57:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 723A84A4E6;
	Tue,  4 Jun 2019 05:57:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7YSKLpJtyjb; Tue,  4 Jun 2019 05:57:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 277254A4DF;
	Tue,  4 Jun 2019 05:57:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB40A4A3A5
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 05:57:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8akC9dKXpbsh for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 05:57:18 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C8604A389
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 05:57:18 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB0B80D;
 Tue,  4 Jun 2019 02:57:17 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFFB3F246;
 Tue,  4 Jun 2019 02:57:16 -0700 (PDT)
Date: Tue, 4 Jun 2019 10:57:14 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190604095713.GV28398@e103592.cambridge.arm.com>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <20190604084349.prnnvjvjaeuhsmgs@mbp>
 <20190604085545.hsmxfqkpt2cbrhtw@vireshk-i7>
 <20190604092639.GS28398@e103592.cambridge.arm.com>
 <20190604093153.2pzv55knl6axugrv@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190604093153.2pzv55knl6axugrv@vireshk-i7>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
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

On Tue, Jun 04, 2019 at 03:01:53PM +0530, Viresh Kumar wrote:
> On 04-06-19, 10:26, Dave Martin wrote:
> > I'm in two minds about whether this is worth fixing, but if you want to
> > post a patch to remove the extra const (or convert vq_present() to a
> > macro), I'll take a look at it.
> 
> This patch already does what you are asking for (remove the extra
> const), isn't it ?

Yes, sorry -- I didn't scroll back far enough.

> I looked at my textbook (The C programming Language, By Brian W.
> Kernighan and Dennis M. Ritchie.) and it says:
> 
> "
> The const declaration can also be used with array arguments, to
> indicate that the function does not change that array:
> 
> int strlen(const char[]);
> "
> 
> and so this patch isn't necessary for sure.

This is an array to which a pointer argument points, not an array
argument.  I think that's how we hit the constified double-indirection
problem.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
