Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACF331DC
	for <lists+kvmarm@lfdr.de>; Mon,  3 Jun 2019 16:17:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D45E4A4F1;
	Mon,  3 Jun 2019 10:17:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1lWdSGyzb5g3; Mon,  3 Jun 2019 10:17:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF9664A3BF;
	Mon,  3 Jun 2019 10:17:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 33A7E4A3BF
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 10:17:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfohofGBVzpv for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 Jun 2019 10:17:44 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E9024A319
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 10:17:44 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 100BB15A2;
 Mon,  3 Jun 2019 07:17:44 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655103F246;
 Mon,  3 Jun 2019 07:17:42 -0700 (PDT)
Date: Mon, 3 Jun 2019 15:17:39 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH kvmtool v3 5/9] KVM: arm/arm64: Add a vcpu feature for
 pointer authentication
Message-ID: <20190603141739.GP28398@e103592.cambridge.arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
 <1559229194-3036-6-git-send-email-Dave.Martin@arm.com>
 <20190531180416.3e87f5ad@donnerap.cambridge.arm.com>
 <20190603112302.GN28398@e103592.cambridge.arm.com>
 <20190603140706.GB28296@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190603140706.GB28296@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
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

On Mon, Jun 03, 2019 at 03:07:06PM +0100, Will Deacon wrote:
> On Mon, Jun 03, 2019 at 12:23:03PM +0100, Dave Martin wrote:
> > On Fri, May 31, 2019 at 06:04:16PM +0100, Andre Przywara wrote:
> > > On Thu, 30 May 2019 16:13:10 +0100
> > > Dave Martin <Dave.Martin@arm.com> wrote:
> > > 
> > > > From: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > > > 
> > > > This patch adds a runtime capabality for KVM tool to enable Arm64 8.3
> > > > Pointer Authentication in guest kernel. Two vcpu features
> > > > KVM_ARM_VCPU_PTRAUTH_[ADDRESS/GENERIC] are supplied together to enable
> > > > Pointer Authentication in KVM guest after checking the capability.
> > > > 
> > > > Command line options --enable-ptrauth and --disable-ptrauth are added
> > > > to use this feature. However, if those options are not provided then
> > > > also this feature is enabled if host supports this capability.
> > > 
> > > I don't really get the purpose of two options, I think that's quite
> > > confusing. Should the first one either be dropped at all or called
> > > something with "force"?
> > > 
> > > I guess the idea is to fail if pointer auth isn't available, but the
> > > option is supplied?
> > > 
> > > Or maybe have one option with parameters?
> > > --ptrauth[,=enable,=disable]
> > 
> > So, I was following two principles here, either or both of which may be
> > bogus:
> > 
> > 1) There should be a way to determine whether KVM turns a given feature
> > on or off (instead of magically defaulting to something).
> > 
> > 2) To a first approaximation, kvmtool should allow each major KVM ABI
> > feature to be exercised.
> > 
> > 3) By default, kvmtool should offer the maximum feature set possible to
> > the guest.
> > 
> > 
> > (3) is well established, but (1) and (2) may be open to question?
> > 
> > If we hold to both principles, it makes sense to have options
> > functionally equivalent to what I suggested (where KVM provides the
> > control in the first place), but there may be more convenient ways
> > to respell the options.
> > 
> > If we really can't decide, maybe it's better to drop the options
> > altogether until we have a real use case.
> > 
> > I've found the options very useful for testing and debugging on the SVE
> > side, but I can't comment on ptrauth.  Maybe someone else has a view?
> 
> I'd prefer to drop them, to be honest. Whilst they may have been useful
> during SVE development, it's not clear to me that they will continue to
> be as useful now that things should be settling down. It's probably useful
> to print out any features that we've explicitly enabled (or failed to
> enable), but I'd stop there for the time being.

I don't have a strong view on this.

I'm happy to respin dropping the command line options and defaulting
everthing to on: for hacking purposes, it's easy to keep a local branch.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
