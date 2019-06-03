Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0487032E5B
	for <lists+kvmarm@lfdr.de>; Mon,  3 Jun 2019 13:14:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C8544A4CD;
	Mon,  3 Jun 2019 07:14:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39CLl7w+wmxt; Mon,  3 Jun 2019 07:14:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FA4D4A483;
	Mon,  3 Jun 2019 07:14:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A59444A3B2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 07:14:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hVfgREjnVKxx for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 Jun 2019 07:14:23 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 48CFC4A319
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 07:14:23 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE85B15AB;
 Mon,  3 Jun 2019 04:14:22 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB5E3F5AF;
 Mon,  3 Jun 2019 04:14:20 -0700 (PDT)
Date: Mon, 3 Jun 2019 12:14:18 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH kvmtool v3 7/9] arm64: Make ptrauth enable/disable
 diagnostics more user-friendly
Message-ID: <20190603111418.GL28398@e103592.cambridge.arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
 <1559229194-3036-8-git-send-email-Dave.Martin@arm.com>
 <20190531180501.51459aef@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190531180501.51459aef@donnerap.cambridge.arm.com>
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

On Fri, May 31, 2019 at 06:05:01PM +0100, Andre Przywara wrote:
> On Thu, 30 May 2019 16:13:12 +0100
> Dave Martin <Dave.Martin@arm.com> wrote:
> 
> > To help the user understand what is going on, amend ptrauth
> > configuration diagnostic messages to refer to command line options
> > by the exact name used on the command line.
> > 
> > Also, provide a clean diagnostic when ptrauth is requested, but not
> > availble.  The generic "Unable to initialise vcpu" message is
> > rather cryptic for this case.
> 
> Again I don't see much value in having this as a separate patch, as it
> basically just touches code introduced two patches earlier. I think it
> should be merged into 5/9.

Same as with the previous patch, I though it was better to keep it
separate for review purposes for now, since it makes changes on top of
Amit's existing patch.

> > Since we now don't attempt to enable ptrauth at all unless KVM
> > reports the relevant capabilities, remove the error message for
> > that case too: in any case, we can't diagnose precisely why
> > KVM_ARM_VCPU_INIT failed, so the message may be misleading.
> 
> So this leaves the only point where we use .enable_ptrauth to that error
> message about the host not supporting it. Not sure if that's worth this
> separate option?

There is indeed a question to be resolved here.  See my response to the
penultimate patch.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
