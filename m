Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBE3ACDB6
	for <lists+kvmarm@lfdr.de>; Fri, 18 Jun 2021 16:40:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1231E4B085;
	Fri, 18 Jun 2021 10:40:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzx7X2B5kCWL; Fri, 18 Jun 2021 10:40:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D83094B09C;
	Fri, 18 Jun 2021 10:40:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DEF84B085
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 10:40:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yPQMRYy0sdT9 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Jun 2021 10:40:20 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 020BD407E7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 10:40:19 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF63061260;
 Fri, 18 Jun 2021 14:40:15 +0000 (UTC)
Date: Fri, 18 Jun 2021 15:40:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v16 1/7] arm64: mte: Handle race when synchronising tags
Message-ID: <20210618144013.GE16116@arm.com>
References: <20210618132826.54670-1-steven.price@arm.com>
 <20210618132826.54670-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210618132826.54670-2-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On Fri, Jun 18, 2021 at 02:28:20PM +0100, Steven Price wrote:
> mte_sync_tags() used test_and_set_bit() to set the PG_mte_tagged flag
> before restoring/zeroing the MTE tags. However if another thread were to
> race and attempt to sync the tags on the same page before the first
> thread had completed restoring/zeroing then it would see the flag is
> already set and continue without waiting. This would potentially expose
> the previous contents of the tags to user space, and cause any updates
> that user space makes before the restoring/zeroing has completed to
> potentially be lost.
> 
> Since this code is run from atomic contexts we can't just lock the page
> during the process. Instead implement a new (global) spinlock to protect
> the mte_sync_page_tags() function.
> 
> Fixes: 34bfeea4a9e9 ("arm64: mte: Clear the tags when a page is mapped in user-space with PROT_MTE")
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>

Although I reviewed this patch, I think we should drop it from this
series and restart the discussion with the Chromium guys on what/if they
need PROT_MTE with MAP_SHARED. It currently breaks if you have two
PROT_MTE mappings but if they are ok with only one of the mappings being
PROT_MTE, I'm happy to just document it.

Not sure whether subsequent patches depend on it though.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
