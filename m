Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EDA90A15AA
	for <lists+kvmarm@lfdr.de>; Thu, 29 Aug 2019 12:19:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A3B24A4E5;
	Thu, 29 Aug 2019 06:19:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X5ET+zLZkdbl; Thu, 29 Aug 2019 06:19:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 399B54A57B;
	Thu, 29 Aug 2019 06:19:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 51D154A563
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Aug 2019 06:19:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mEJOyYvJmR6d for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Aug 2019 06:19:46 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F3BFF4A4E5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Aug 2019 06:19:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4B628;
 Thu, 29 Aug 2019 03:19:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D073F59C;
 Thu, 29 Aug 2019 03:19:44 -0700 (PDT)
Date: Thu, 29 Aug 2019 11:19:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests RFC PATCH 04/16] arm/arm64: selftest: Add
 prefetch abort test
Message-ID: <20190829101942.GC44575@lakrids.cambridge.arm.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
 <1566999511-24916-5-git-send-email-alexandru.elisei@arm.com>
 <20190828140925.GC41023@lakrids.cambridge.arm.com>
 <e6b8a3c9-2e11-c806-da5b-8b66d8f63ce3@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e6b8a3c9-2e11-c806-da5b-8b66d8f63ce3@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: maz@kernel.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, andre.przywara@arm.com
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

On Thu, Aug 29, 2019 at 09:18:35AM +0100, Alexandru Elisei wrote:
> On 8/28/19 3:09 PM, Mark Rutland wrote:
> > On Wed, Aug 28, 2019 at 02:38:19PM +0100, Alexandru Elisei wrote:
> >> +	/*
> >> +	 * AArch64 treats all regions writable at EL0 as PXN.
> > I didn't think that was the case, and I can't find wording to that
> > effect in the ARM ARM (looking at ARM DDI 0487E.a). Where is that
> > stated?
> 
> It's in ARM DDI 0487E.a, table D5-33, footnote c: "Not executable, because
> AArch64 execution treats all regions writable at EL0 as being PXN". I'll update
> the comment to include the quote.

Interesting; I was not aware of that particular behaviour. Thanks
for the pointer!

Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
