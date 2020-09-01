Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAAE259786
	for <lists+kvmarm@lfdr.de>; Tue,  1 Sep 2020 18:16:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD94D4B1A0;
	Tue,  1 Sep 2020 12:15:59 -0400 (EDT)
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
	with ESMTP id DZ98Gs5Ul+VT; Tue,  1 Sep 2020 12:15:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 92D9E4B198;
	Tue,  1 Sep 2020 12:15:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D7A1D4B193
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 12:15:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ljeAT2mNZMuc for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Sep 2020 12:15:56 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B839E4B154
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 12:15:56 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D2C92065F;
 Tue,  1 Sep 2020 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598976955;
 bh=bKeHGlZbZGIL+a/FdUFc88qZYq5BIskiAYcHOMYOexw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eG6NZAgNJlyew5H7w6AS6v+nRVSN0wyrbwEFFmxXc9pNH++6+ayNbfzc38UfRm4yH
 HVwx4szsG7ChJbdiQXp027J0hjzhskZpYT7RK+Cp+Rgj/x69dtJ2vRN+xHUDTPzIZl
 QHwU7hbGuVhFgkewcJjMOFHXCa0HAp1kQRT6TeW8=
Date: Tue, 1 Sep 2020 17:15:51 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v3 00/21] KVM: arm64: Rewrite page-table code and fault
 handling
Message-ID: <20200901161550.GA4421@willie-the-truck>
References: <20200825093953.26493-1-will@kernel.org>
 <2281278d-03fe-d824-2a51-b494417f7c8b@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2281278d-03fe-d824-2a51-b494417f7c8b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>
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

Hi Alex,

On Thu, Aug 27, 2020 at 05:26:01PM +0100, Alexandru Elisei wrote:
> I've been looking into pinning guest memory for KVM SPE, so I like to think that
> the stage 2 page table code is not entirely alien to me. I'll do my best to review
> the series, I hope you'll find it useful.

Just wanted to say a huge "thank you!" for having a look. I'll get to your
comments later this week, but I'm a bit snowed under after LPC and the
bank holiday at the moment, so please bear with me.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
