Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3705D27E6AB
	for <lists+kvmarm@lfdr.de>; Wed, 30 Sep 2020 12:30:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6AF24B429;
	Wed, 30 Sep 2020 06:30:10 -0400 (EDT)
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
	with ESMTP id GKjQECCS4brx; Wed, 30 Sep 2020 06:30:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A26DE4B427;
	Wed, 30 Sep 2020 06:30:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 96A5B4B414
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 06:30:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id np1Mx-bVKNPw for <kvmarm@lists.cs.columbia.edu>;
 Wed, 30 Sep 2020 06:30:06 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AB2084B3FB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 06:30:06 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23AE12074A;
 Wed, 30 Sep 2020 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601461805;
 bh=KcOK93l5fC2kmWQcf22L6pyG3jezJMbpRjoKe+SCDvM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KSzAjcbEhRH74NDi+zlAXPeoN1Ay9pchFE6xmNJPAfj5GSuzgTyY6626GILD7Sr71
 mEoJpjun4TjL7+JlI5AgIgu9PpEIFA8A4KtI2cKFU5ys5WDddF1Y52H0Y2lHxw9lQO
 drGWgRPLEgPrBjtCgeXlmYmPd1vMKyCSOnhrTIpQ=
Date: Wed, 30 Sep 2020 11:30:00 +0100
From: Will Deacon <will@kernel.org>
To: maz@kernel.org
Subject: Re: [PATCH] KVM: arm64: Ensure user_mem_abort() return value is
 initialised
Message-ID: <20200930103000.GA15957@willie-the-truck>
References: <20200930102442.16142-1-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930102442.16142-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel test robot <lkp@intel.com>, Will Deacon <willdeacon@google.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Wed, Sep 30, 2020 at 11:24:42AM +0100, Will Deacon wrote:
> From: Will Deacon <willdeacon@google.com>

Bugger, sorry, committed this in the wrong tree and got the wrong address on
it. Patch is still fine, but the author should be my kernel.org address, to
match the SoB.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
