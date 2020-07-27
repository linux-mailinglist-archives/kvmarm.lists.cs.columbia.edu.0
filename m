Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DB33322EA10
	for <lists+kvmarm@lfdr.de>; Mon, 27 Jul 2020 12:31:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DD654B9F6;
	Mon, 27 Jul 2020 06:31:20 -0400 (EDT)
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
	with ESMTP id GohIzxDqeUeN; Mon, 27 Jul 2020 06:31:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73FB84B9BF;
	Mon, 27 Jul 2020 06:31:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AB984B9BF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:31:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jySdteFDhPDA for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Jul 2020 06:31:17 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 203EB4B993
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:31:17 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F2F02075A;
 Mon, 27 Jul 2020 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595845876;
 bh=gFsKnq68arx7uyGJT0U7KSFl713ND7lsGfyGjx11ItA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uwIMIdLnlGXO0bOCjJjri9FeYIe0UMEyFS6IqXf252xOQDUToxwdY3ZQXDdGQqsrB
 UWiiuyVABCbLlslFB2zdOYPFyEtvs1dR150VNx4QK/gopv17VagJXsaWJfXNw7nAnA
 auh6qFVZ9BDlreZTCAxrN8A7Jv8SFUdfW1M1c9QA=
Date: Mon, 27 Jul 2020 11:31:12 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 5/7] KVM: arm64: Move 'invalid syndrome' logic out of
 io_mem_abort()
Message-ID: <20200727103111.GD20194@willie-the-truck>
References: <20200724143506.17772-1-will@kernel.org>
 <20200724143506.17772-6-will@kernel.org>
 <87sgdewkwr.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sgdewkwr.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Sun, Jul 26, 2020 at 12:55:16PM +0100, Marc Zyngier wrote:
> On Fri, 24 Jul 2020 15:35:04 +0100,
> Will Deacon <will@kernel.org> wrote:
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 73e62d360a36..adb933ecd177 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -2046,6 +2046,20 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
> >  		kvm_set_pfn_accessed(pfn);
> >  }
> >  
> > +static int handle_error_invalid_dabt(struct kvm_vcpu *vcpu, struct kvm_run *run,
> 
> Nit: why the "_error_"? There isn't any error here, only an awkward
> part of the architecture. I'd rather see something like
> handle_nisv_dabt(), which matches what this function actually does.

I chose "_error_" because this handling the case when kvm_is_error_hva() is
true (but I agree that "error" is misleading in both cases).

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
