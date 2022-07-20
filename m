Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46557B938
	for <lists+kvmarm@lfdr.de>; Wed, 20 Jul 2022 17:11:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73FEE4D803;
	Wed, 20 Jul 2022 11:11:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kuidykmIDt1; Wed, 20 Jul 2022 11:11:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 068E94D7DD;
	Wed, 20 Jul 2022 11:11:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2666D4D771
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Jul 2022 11:11:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UfEiHRFAj9Zl for <kvmarm@lists.cs.columbia.edu>;
 Wed, 20 Jul 2022 11:11:11 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 183534D770
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Jul 2022 11:11:11 -0400 (EDT)
Date: Wed, 20 Jul 2022 15:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1658329869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFnDRJW8SXwUP1HZqonS92uu/YoL0Hk0zC9PiQKiK7Y=;
 b=t8HCSRCOircfKNTjXQPibLbkf3dGU8b1N/fhA1M+gEhIcEuOgZmaGt+wpUGulo4ywjeCfR
 CfOExbN2WW4kIQqeSx1m9WLPXSJyiTTWXFPeiJDwqnDhmqqqYIY4XZt7ATi+kssHAlQbJN
 uqeHqdXLh54XRJ759q3mn8x7G1ih978=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 06/24] KVM: arm64: Unify identifiers used to
 distinguish host and hypervisor
Message-ID: <YtgbCEOMze8N4TPW@google.com>
References: <20220630135747.26983-1-will@kernel.org>
 <20220630135747.26983-7-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220630135747.26983-7-will@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-arm-kernel@lists.infradead.org,
 Michael Roth <michael.roth@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, kvmarm@lists.cs.columbia.edu
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

Hi Will,

On Thu, Jun 30, 2022 at 02:57:29PM +0100, Will Deacon wrote:
> The 'pkvm_component_id' enum type provides constants to refer to the
> host and the hypervisor, yet this information is duplicated by the
> 'pkvm_hyp_id' constant.
> 
> Remove the definition of 'pkvm_hyp_id' and move the 'pkvm_component_id'
> type definition to 'mem_protect.h' so that it can be used outside of
> the memory protection code.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 6 +++++-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 8 --------
>  arch/arm64/kvm/hyp/nvhe/setup.c               | 2 +-
>  3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 80e99836eac7..f5705a1e972f 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -51,7 +51,11 @@ struct host_kvm {
>  };
>  extern struct host_kvm host_kvm;
>  
> -extern const u8 pkvm_hyp_id;
> +/* This corresponds to page-table locking order */
> +enum pkvm_component_id {
> +	PKVM_ID_HOST,
> +	PKVM_ID_HYP,
> +};

Since we have the concept of PTE ownership in pgtable.c, WDYT about
moving the owner ID enumeration there? KVM_MAX_OWNER_ID should be
incorporated in the enum too.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
