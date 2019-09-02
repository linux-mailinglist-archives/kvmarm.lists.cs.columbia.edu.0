Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E2013A5090
	for <lists+kvmarm@lfdr.de>; Mon,  2 Sep 2019 10:01:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CEF54A4E1;
	Mon,  2 Sep 2019 04:01:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9mvgcvNpBP7t; Mon,  2 Sep 2019 04:01:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D4AF4A4F4;
	Mon,  2 Sep 2019 04:01:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BF5D4A4C1
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Sep 2019 04:01:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIIrq16goB6y for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Sep 2019 04:00:57 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 647A34A4C0
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Sep 2019 04:00:57 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E19D728;
 Mon,  2 Sep 2019 01:00:56 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73D583F71A;
 Mon,  2 Sep 2019 01:00:56 -0700 (PDT)
Date: Mon, 2 Sep 2019 10:00:55 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 0/3] arm64: KVM: Kiss hyp_alternate_select() goodbye
Message-ID: <20190902080055.GA4320@e113682-lin.lund.arm.com>
References: <20190901211237.11673-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190901211237.11673-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

On Sun, Sep 01, 2019 at 10:12:34PM +0100, Marc Zyngier wrote:
> hyp_alternate_select() is a leftover from the my second attempt at
> supporting VHE (the first one was never merged, thankfully), and is
> now an irrelevant relic. It was a way to patch function pointers
> without having to dereference memory, a bit like static keys for
> function calls.
> 
> Lovely idea, but since Christoffer mostly separated the VHE and !VHE
> hypervisor paths, most of the uses of hyp_alternate_select() are
> gone. What is left is two instances that are better replaced by
> already existing static keys. One of the instances becomes
> cpus_have_const_cap(), and the rest is a light sprinkling of
> has_vhe().
> 
> So off it goes.

I'm not sure I want to kiss hyp_alternate_select() at all, but away it
must go!

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
