Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1486F46DA59
	for <lists+kvmarm@lfdr.de>; Wed,  8 Dec 2021 18:49:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BED74B1C1;
	Wed,  8 Dec 2021 12:49:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GkgnAV2cBGPx; Wed,  8 Dec 2021 12:49:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 81B1A4B19D;
	Wed,  8 Dec 2021 12:49:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E87E54B126
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Dec 2021 12:49:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ADz4NwFWWHF9 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Dec 2021 12:49:17 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8154F4B12C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Dec 2021 12:49:17 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 47D8FCE2291;
 Wed,  8 Dec 2021 17:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF2EC00446;
 Wed,  8 Dec 2021 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638985752;
 bh=eSGWmUYDabFMwKqG3Chvgj52S+6K8S0+wchgsln66Fs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FVmbuBVeHGA+t64aKKCQOwctestVgv+cfhL7/r35fiX8zZB3uJURgeSJ7dHVxN2Gk
 aDzKJ/pmK12DTEPigcRtOzASHbVbl/6ENj+4/EPq+4KZ0oz4DgNiEYHAxAxUpsJhD7
 o51f+yGvq8oPCbCgtfwoS0tMm2EFXSOT59VWXNT/Egzvtor5jg89SNSgMNezUUWxKg
 H6Dgf/MNSrEXbo7szXz7gyIW8OkSLT7P2NXyMCOwc0gypZDsAdkRrheMVScy3G/nGO
 2O9YmzKL+wHhQSTU3Whi2kgOlzMR3hiawKJbt+Tn6VZHy3X43CIsmlT+xICA2uU0WS
 nohonXYIn9Pjw==
Date: Wed, 8 Dec 2021 17:49:07 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 5/6] KVM: arm64: pkvm: Stub io map functions
Message-ID: <20211208174906.GE820@willie-the-truck>
References: <20211208152300.2478542-1-qperret@google.com>
 <20211208152300.2478542-6-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211208152300.2478542-6-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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

On Wed, Dec 08, 2021 at 03:22:58PM +0000, Quentin Perret wrote:
> Now that GICv2 is disabled in nVHE protected mode there should be no
> other reason for the host to use create_hyp_io_mappings() or
> kvm_phys_addr_ioremap(). Add sanity checks to make sure that assumption
> remains true looking forward.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 326cdfec74a1..605c104eb030 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -407,6 +407,9 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
>  	unsigned long addr;
>  	int ret;
>  
> +	if (is_protected_kvm_enabled())
> +		return -EPERM;

Looks like the vGIC is the only caller, so no need to worry about anybody
relying on *kaddr being zeroed on failure.

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
