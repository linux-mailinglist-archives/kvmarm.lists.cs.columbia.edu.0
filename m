Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 122C82730B0
	for <lists+kvmarm@lfdr.de>; Mon, 21 Sep 2020 19:15:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73F174B5A0;
	Mon, 21 Sep 2020 13:15:15 -0400 (EDT)
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
	with ESMTP id etaPhhTSfC+o; Mon, 21 Sep 2020 13:15:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 41F884B54E;
	Mon, 21 Sep 2020 13:15:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C3F9A4B51D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 13:15:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rqCet9PTXCFX for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Sep 2020 13:15:11 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C9D5F4B4AF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 13:15:11 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63B7A20758;
 Mon, 21 Sep 2020 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600708510;
 bh=oNl21GKbETxspIUiGd6NDudHCGJOD0WlSYjrtXePsT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZryhrD874sShofTk0rTnQKhsxe5vhXg2Uc0l76zhVlL43CNGinRt1Tmca5p4p5c88
 k+nRlUPhwlqlluWbpD3RsHOc4PubKpcwCDazHBD6eda+rgc8HupCJTCIharrUtuNGS
 pRqj+BOsrJtKboJxXSxVPfvrZfqAaXVX6vqw1/rs=
Date: Mon, 21 Sep 2020 18:15:05 +0100
From: Will Deacon <will@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 05/11] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200921171503.GB2822@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-6-dbrazdil@google.com>
 <20200918090533.GE30834@willie-the-truck>
 <20200921145320.2b2ipdj6w4morjc3@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921145320.2b2ipdj6w4morjc3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Christoph Lameter <cl@linux.com>, kernel-team@android.com,
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

On Mon, Sep 21, 2020 at 03:53:20PM +0100, David Brazdil wrote:
> > Cosmetic, but I think it would be cleaner just to define two variants of the
> > macro here:
> > 
> > #if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
> > 	.macro  this_cpu_offset, dst
> > 	mrs     \dst, tpidr_el2
> > 	.endm
> > #else
> > 	.macro  this_cpu_offset, dst
> > alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
> > 	mrs     \dst, tpidr_el1
> > alternative_else
> > 	mrs     \dst, tpidr_el2
> > alternative_endif
> > 	.endm
> > #endif
> 
> Sure.

Ta.

> > (and should we have a shorthand __HYPERVISOR define to avoid the NVHE || VHE
> > logic?)
> 
> Happy to add this but let's agree on the details.
>  * name: just __HYPERVISOR or __KVM_HYPERVISOR__?

Hey, I leave the hard decisions to others!

>  * defined where? I'm wary of defining it in a header file because then sombody
>    will forget to add it and 'ifdef HYP' will be skipped. So I'd put this as
>    another '-D__HYPERVISOR' in the build rules. Do you agree?

Hmm, that's a good point. Leave that part as-is for now then and we can
tackle it separately if it comes up again.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
