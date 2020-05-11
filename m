Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A51CD68E
	for <lists+kvmarm@lfdr.de>; Mon, 11 May 2020 12:29:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E48C4B10E;
	Mon, 11 May 2020 06:29:31 -0400 (EDT)
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
	with ESMTP id geu5XMxzLrIS; Mon, 11 May 2020 06:29:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E86E34B0E3;
	Mon, 11 May 2020 06:29:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6EB364B0E0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 May 2020 06:29:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o4VRs7kCgSS2 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 11 May 2020 06:29:27 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 772504B0DF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 May 2020 06:29:27 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E97C02080C;
 Mon, 11 May 2020 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589192966;
 bh=/HtkDEUSJNCGLykcJeF51FbbiEEPPZDAt/jaVHdhRWc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J0vuf+ZotQeRxth/qHzk0monizmO/oZrY0XlTEMp3GOvKC2C9ZGzbBQsmEje6tfhV
 drhODojTl9CKLTGN3jGxEvkg0amm8cChelSejV1audJqLmta+BCdVclouAv4z/FqLZ
 5UsKODnRShHCuOk9nIvWvHXpIdZ2tVePfXGqPstU=
Date: Mon, 11 May 2020 11:29:21 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 06/15] arm64: kvm: Move __smccc_workaround_1_smc to .rodata
Message-ID: <20200511102921.GA18310@willie-the-truck>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-7-dbrazdil@google.com>
 <20200511110459.1fcf4db7@why>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200511110459.1fcf4db7@why>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On Mon, May 11, 2020 at 11:04:59AM +0100, Marc Zyngier wrote:
> On Thu, 30 Apr 2020 15:48:22 +0100
> David Brazdil <dbrazdil@google.com> wrote:
> 
> > This snippet of assembly is used by cpu_errata.c to overwrite parts of KVM hyp
> > vector. It is never directly executed, so move it from .text to .rodata.
> > 
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  arch/arm64/kvm/hyp/hyp-entry.S | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> > index 5986e1d78d3f..7e5f386c5c2d 100644
> > --- a/arch/arm64/kvm/hyp/hyp-entry.S
> > +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> > @@ -364,6 +364,11 @@ SYM_CODE_END(__bp_harden_hyp_vecs)
> >  	.popsection
> >  
> >  #ifndef __HYPERVISOR__
> > +	/*
> > +	 * This is not executed directly and is instead copied into the vectors
> > +	 * by install_bp_hardening_cb().
> > +	 */
> > +	.pushsection	.rodata
> >  SYM_CODE_START(__smccc_workaround_1_smc)
> 
> I wonder whether we should keep the SYM_CODE_START() annotation or not.
> It feels weird to say "code" in a rodata section, and the alignment
> doesn't matter as we copy it in place, as you noticed.

The BTI patches hook these, but I don't see that being relevant for a
vector entry as PSTATE.BTYPE is zapped to 0.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
