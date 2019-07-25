Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5F75403
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jul 2019 18:28:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E74F14A5E0;
	Thu, 25 Jul 2019 12:28:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z7-97F-Bvqkp; Thu, 25 Jul 2019 12:28:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ACE924A5DE;
	Thu, 25 Jul 2019 12:28:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 70D974A5E0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 12:28:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M92JUzg6QXNI for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jul 2019 12:28:31 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C0EC4A54E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 12:28:31 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D9F9174E;
 Thu, 25 Jul 2019 09:28:31 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 158293F71A; Thu, 25 Jul 2019 09:28:29 -0700 (PDT)
Date: Thu, 25 Jul 2019 17:28:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v3 09/15] arm64/mm: Split the function
 check_and_switch_context in 3 parts
Message-ID: <20190725162827.GE4113@arrakis.emea.arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
 <20190724162534.7390-10-julien.grall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190724162534.7390-10-julien.grall@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
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

On Wed, Jul 24, 2019 at 05:25:28PM +0100, Julien Grall wrote:
> The function check_and_switch_context is used to:
>     1) Check whether the ASID is still valid
>     2) Generate a new one if it is not valid
>     3) Switch the context
> 
> While the latter is specific to the MM subsystem, the rest could be part
> of the generic ASID allocator.
> 
> After this patch, the function is now split in 3 parts which corresponds
> to the use of the functions:
>     1) asid_check_context: Check if the ASID is still valid
>     2) asid_new_context: Generate a new ASID for the context
>     3) check_and_switch_context: Call 1) and 2) and switch the context
> 
> 1) and 2) have not been merged in a single function because we want to
> avoid to add a branch in when the ASID is still valid. This will matter
> when the code will be moved in separate file later on as 1) will reside
> in the header as a static inline function.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>     Will wants to avoid to add a branch when the ASID is still valid. So
>     1) and 2) are in separates function. The former will move to a new
>     header and make static inline.

Was this discussion logged somewhere, just to get the context?

I presume by "branch" you meant the function call to
asid_check_context(). Personally, I don't like the duplication of this
function in patch 13. This is part of the ASID allocation algorithm and
I prefer to keep them together (we even had a bug in here with the xchg
use).

Do you have any numbers to show how non-inlining this function affects
the performance (hackbench -P would do).

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
