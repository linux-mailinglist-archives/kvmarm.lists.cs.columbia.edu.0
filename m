Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 10AFA32E89
	for <lists+kvmarm@lfdr.de>; Mon,  3 Jun 2019 13:23:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BAC34A4EB;
	Mon,  3 Jun 2019 07:23:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0DvWGPvX3ve; Mon,  3 Jun 2019 07:23:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E09D4A4C9;
	Mon,  3 Jun 2019 07:23:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 590084A3B2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 07:23:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pUfDUPXaaN-j for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 Jun 2019 07:23:07 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B7B954A319
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 07:23:07 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B817A78;
 Mon,  3 Jun 2019 04:23:07 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E43B3F5AF;
 Mon,  3 Jun 2019 04:23:05 -0700 (PDT)
Date: Mon, 3 Jun 2019 12:23:03 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH kvmtool v3 5/9] KVM: arm/arm64: Add a vcpu feature for
 pointer authentication
Message-ID: <20190603112302.GN28398@e103592.cambridge.arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
 <1559229194-3036-6-git-send-email-Dave.Martin@arm.com>
 <20190531180416.3e87f5ad@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190531180416.3e87f5ad@donnerap.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Fri, May 31, 2019 at 06:04:16PM +0100, Andre Przywara wrote:
> On Thu, 30 May 2019 16:13:10 +0100
> Dave Martin <Dave.Martin@arm.com> wrote:
> 
> > From: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > 
> > This patch adds a runtime capabality for KVM tool to enable Arm64 8.3
> > Pointer Authentication in guest kernel. Two vcpu features
> > KVM_ARM_VCPU_PTRAUTH_[ADDRESS/GENERIC] are supplied together to enable
> > Pointer Authentication in KVM guest after checking the capability.
> > 
> > Command line options --enable-ptrauth and --disable-ptrauth are added
> > to use this feature. However, if those options are not provided then
> > also this feature is enabled if host supports this capability.
> 
> I don't really get the purpose of two options, I think that's quite
> confusing. Should the first one either be dropped at all or called
> something with "force"?
> 
> I guess the idea is to fail if pointer auth isn't available, but the
> option is supplied?
> 
> Or maybe have one option with parameters?
> --ptrauth[,=enable,=disable]

So, I was following two principles here, either or both of which may be
bogus:

1) There should be a way to determine whether KVM turns a given feature
on or off (instead of magically defaulting to something).

2) To a first approaximation, kvmtool should allow each major KVM ABI
feature to be exercised.

3) By default, kvmtool should offer the maximum feature set possible to
the guest.


(3) is well established, but (1) and (2) may be open to question?

If we hold to both principles, it makes sense to have options
functionally equivalent to what I suggested (where KVM provides the
control in the first place), but there may be more convenient ways
to respell the options.

If we really can't decide, maybe it's better to drop the options
altogether until we have a real use case.

I've found the options very useful for testing and debugging on the SVE
side, but I can't comment on ptrauth.  Maybe someone else has a view?

> > The macros defined in the headers are not in sync and should be replaced
> > from the upstream.
> 
> This is no longer true, I guess?

Ah yes, that comment can go.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
