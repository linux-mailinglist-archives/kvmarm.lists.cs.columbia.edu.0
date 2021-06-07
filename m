Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0606339E4E8
	for <lists+kvmarm@lfdr.de>; Mon,  7 Jun 2021 19:07:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D4194B09C;
	Mon,  7 Jun 2021 13:07:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LbAf4OuBwk6R; Mon,  7 Jun 2021 13:07:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D8ECC4B088;
	Mon,  7 Jun 2021 13:07:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95DB249E8C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Jun 2021 13:07:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GUyAPdx9+5hN for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Jun 2021 13:07:21 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3A8A840617
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Jun 2021 13:07:21 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48E3B6101A;
 Mon,  7 Jun 2021 17:07:17 +0000 (UTC)
Date: Mon, 7 Jun 2021 18:07:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v14 2/8] arm64: Handle MTE tags zeroing in
 __alloc_zeroed_user_highpage()
Message-ID: <20210607170714.GA17957@arm.com>
References: <20210607110816.25762-1-steven.price@arm.com>
 <20210607110816.25762-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607110816.25762-3-steven.price@arm.com>
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

On Mon, Jun 07, 2021 at 12:08:10PM +0100, Steven Price wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Currently, on an anonymous page fault, the kernel allocates a zeroed
> page and maps it in user space. If the mapping is tagged (PROT_MTE),
> set_pte_at() additionally clears the tags under a spinlock to avoid a
> race on the page->flags. In order to optimise the lock, clear the page
> tags on allocation in __alloc_zeroed_user_highpage() if the vma flags
> have VM_MTE set.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>

I think you can drop this patch now that Peter's series has been queued
via the arm64 tree:

https://lore.kernel.org/r/20210602235230.3928842-4-pcc@google.com

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
