Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE733F212
	for <lists+kvmarm@lfdr.de>; Wed, 17 Mar 2021 15:01:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C719C4B654;
	Wed, 17 Mar 2021 10:01:29 -0400 (EDT)
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
	with ESMTP id 3roNcX1SpIRX; Wed, 17 Mar 2021 10:01:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA4114B650;
	Wed, 17 Mar 2021 10:01:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6682E4B650
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 10:01:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aoissdopTF0S for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Mar 2021 10:01:22 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9EEAD4B3C3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 10:01:22 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BCF964F6A;
 Wed, 17 Mar 2021 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615989681;
 bh=R6KOf4597iuSM4zPgAf8uid9pCmGJM6V8VLQdYKDtuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AMuPGbX/1Rbfsk9QPCfX1ABnBwbsQubBcaLqciEpZlKtAgiqP48jjGh+q9ue11UFc
 JeLgldqcpVhBn9ZcVzjVr44x/u7Ud8Z7E3oVAajsMohBLdggCeVBxMt5oJf7QxdmH5
 NsX1HJxvy8xCxOzCnQMm90gF5LiyhKSFPTjRX/wIys6PtNWW0Eg3jVjAdNtD2wbd/7
 yF94m1w1jg4yDHW6iz1rbJ1wESGkHHylcdbEk5IfcI76xeqIQm6uYvS1a+0w3pClan
 xuRRdZOwm/yfnaLgeUq/MBEQR2rO8EghdnWRxmry+fKdv0LLCSdLyaE/KmwX75vrQO
 vs6WJ9R7Hocsg==
Date: Wed, 17 Mar 2021 14:01:15 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 04/10] KVM: arm64: Introduce vcpu_sve_vq() helper
Message-ID: <20210317140115.GA5295@willie-the-truck>
References: <20210316101312.102925-1-maz@kernel.org>
 <20210316101312.102925-5-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316101312.102925-5-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, broonie@kernel.org, kernel-team@android.com,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, daniel.kiss@arm.com
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

On Tue, Mar 16, 2021 at 10:13:06AM +0000, Marc Zyngier wrote:
> The KVM code contains a number of "sve_vq_from_vl(vcpu->arch.sve_max_vl)"
> instances, and we are about to add more.
> 
> Introduce vcpu_sve_vq() as a shorthand for this expression.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h       | 4 +++-
>  arch/arm64/kvm/guest.c                  | 6 +++---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index fb1d78299ba0..c4afe3d3397f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -375,6 +375,8 @@ struct kvm_vcpu_arch {
>  #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
>  			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
>  
> +#define vcpu_sve_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)

nit: maybe vcpu_sve_max_vq() would be a better name?

Either way:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
