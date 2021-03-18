Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 984553408A4
	for <lists+kvmarm@lfdr.de>; Thu, 18 Mar 2021 16:19:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 35C9E4B72B;
	Thu, 18 Mar 2021 11:19:37 -0400 (EDT)
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
	with ESMTP id q+z77kO8J1-a; Thu, 18 Mar 2021 11:19:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D4B44B73C;
	Thu, 18 Mar 2021 11:19:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 475394B5F2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 11:19:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcoogWuBTP5Y for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Mar 2021 11:19:33 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5B8AB4B5DB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 11:19:33 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D106264ED2;
 Thu, 18 Mar 2021 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616080771;
 bh=0MYEUmBbhr9eIhiz3lMGc1V5J/rcpdrZTUMtkY49ykQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qP1wjtiLRTqTEIHkzqyxgdt5QHtPeXGbsxCaQNh9gY2170ilsm3ilQSEPdqCWIAyF
 9X7KWrIrpoDEDLMFAvvQHB4PMUcAZeb8d1nZUjRiJRll+4nuKuQmatJyrMzwrYA95K
 USKbHfUMaofxVF+52sP+q4MBhZJerJF0+d+zd9r7ti129Okgh9OHCtNYNvuC+oSS7Y
 9OjkY2EP90moX45O0XLoLYF+72Njfy5pdXWQfBUui018ZiKdBiiUCOwRkQrHkOKgoi
 xEiW0oJ7Ffk7OCuI2+BbRlP6FYQ9P8SaBSwHhKRNLnuljIaVoRIXWd58Bnr0yQ6Mt5
 bJlsCpSqjr8Aw==
Date: Thu, 18 Mar 2021 15:19:26 +0000
From: Will Deacon <will@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 2/5] bug: Factor out a getter for a bug's file line
Message-ID: <20210318151926.GB7531@willie-the-truck>
References: <20210318143311.839894-1-ascull@google.com>
 <20210318143311.839894-3-ascull@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318143311.839894-3-ascull@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Peter Zijlstra <peterz@infradead.org>, catalin.marinas@arm.com,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>, maz@kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Thu, Mar 18, 2021 at 02:33:08PM +0000, Andrew Scull wrote:
> There is some non-trivial config-based logic to get the file name and
> line number associated with a bug. Factor this out to a getter that can
> be resused.

typo: "resused"

> 
> Signed-off-by: Andrew Scull <ascull@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/bug.h |  3 +++
>  lib/bug.c           | 27 +++++++++++++++++----------
>  2 files changed, 20 insertions(+), 10 deletions(-)

Patch looks fine:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
