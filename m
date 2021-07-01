Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38F3B9225
	for <lists+kvmarm@lfdr.de>; Thu,  1 Jul 2021 15:17:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EFD74AEF8;
	Thu,  1 Jul 2021 09:17:43 -0400 (EDT)
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
	with ESMTP id 2m-QscfosLri; Thu,  1 Jul 2021 09:17:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 547214ACC9;
	Thu,  1 Jul 2021 09:17:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2083F4A523
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Jul 2021 09:17:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WlyB66oQYbfe for <kvmarm@lists.cs.columbia.edu>;
 Thu,  1 Jul 2021 09:17:40 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 10CD049D50
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Jul 2021 09:17:40 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD17B61413;
 Thu,  1 Jul 2021 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625145459;
 bh=cI1lm4mozxs4nIm/KqNPIglmKNb4tX+KV0h6fmFP+R0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R5cjISF1eh/5/Hdbdvebd57RmqEqbIoCtFhWl86CkgdEzBKPr+OL0Fr8r4Ec61kDo
 FK7jDUp3Mjw5PslrKZVxhD8wFRQsQWe9lB/3F2oXnQELml/J7RlJauoXYH4zoScrRo
 acm2I1wkol2WzxF99j2mZ/vHSOJDSia0orfn1cshIADREzPPRfKI0Z3G9zaoecLU2h
 Fs58SRA/m3xEDJbVgxsYRAMs8MYS+RFNQILw+87y5S9p3NF8at+WPyNPaPjljFWlbb
 ocr5c8SkjGyVFnrX17tTY466zjDovMnMJq3O6DyVPqbxBLi8T9LKK+7b4ZRQxp/O8E
 JPDZDqgo1uU2Q==
Date: Thu, 1 Jul 2021 14:17:33 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v2 05/13] KVM: arm64: Restore mdcr_el2 from vcpu
Message-ID: <20210701131733.GE9757@willie-the-truck>
References: <20210615133950.693489-1-tabba@google.com>
 <20210615133950.693489-6-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615133950.693489-6-tabba@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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

On Tue, Jun 15, 2021 at 02:39:42PM +0100, Fuad Tabba wrote:
> On deactivating traps, restore the value of mdcr_el2 from the
> vcpu context, rather than directly reading the hardware register.
> Currently, the two values are the same, i.e., the hardware
> register and the vcpu one. A future patch will be changing the
> value of mdcr_el2 on activating traps, and this ensures that its
> value will be restored.
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/switch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index f7af9688c1f7..430b5bae8761 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -73,7 +73,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
>  
>  	___deactivate_traps(vcpu);
>  
> -	mdcr_el2 = read_sysreg(mdcr_el2);
> +	mdcr_el2 = vcpu->arch.mdcr_el2;

Do you need to change the VHE code too?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
