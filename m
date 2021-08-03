Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CC1173DF197
	for <lists+kvmarm@lfdr.de>; Tue,  3 Aug 2021 17:32:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 688374A17F;
	Tue,  3 Aug 2021 11:32:33 -0400 (EDT)
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
	with ESMTP id uMV5a8uz9Z9E; Tue,  3 Aug 2021 11:32:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5515B49F82;
	Tue,  3 Aug 2021 11:32:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A1BCF4086C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Aug 2021 11:32:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h00vs1OpL9Q4 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Aug 2021 11:32:29 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A3AB04057F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Aug 2021 11:32:29 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D53C60EC0;
 Tue,  3 Aug 2021 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628004748;
 bh=NFlhqOplTZXAI0Dyb+KjHTbgLHGA5lnFEt+p2z6v+iM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oMjfeRMxIT3SvO+bti5OjoKO6PpmEsNLCtlzo44iZnfZsZofDvb7xoPDD4mkX4OJ+
 Vn1gECcUm5dFIKbOty+raoD0bQ2mGIpg0mn2LhKlxihBKhFQHpf/Wa+04Lhcun2RV9
 +jLyYBAEyDfgAZcWaCKrrOB5xsYz/SLLNIhSI2PZqCefhYdhJIPa43GLPh6pd9Fpcl
 lvrLTNw2bXyyb4O3A4EgZi+Ca9VP56F2sajgBUbOlye7o/a7IwSNtvu4yxNafAnO81
 32FjyCa5SeOQJFqM1E8kSYM4HddZQ6G4LUIiTEVCwLS4gYLq3hh8bKATjTG26qsYPO
 IvChdLdqlxrtw==
Date: Tue, 3 Aug 2021 16:32:22 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 10/15] KVM: arm64: Guest exit handlers for nVHE hyp
Message-ID: <20210803153222.GB31125@willie-the-truck>
References: <20210719160346.609914-1-tabba@google.com>
 <20210719160346.609914-11-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719160346.609914-11-tabba@google.com>
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

On Mon, Jul 19, 2021 at 05:03:41PM +0100, Fuad Tabba wrote:
> Add an array of pointers to handlers for various trap reasons in
> nVHE code.
> 
> The current code selects how to fixup a guest on exit based on a
> series of if/else statements. Future patches will also require
> different handling for guest exists. Create an array of handlers
> to consolidate them.
> 
> No functional change intended as the array isn't populated yet.
> 
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 43 +++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c        | 35 ++++++++++++++++++++
>  2 files changed, 78 insertions(+)

Definitely keep my Ack on this, but Clang just chucked out a warning due to:

> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index a0e78a6027be..5a2b89b96c67 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -409,6 +409,46 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
>  	return true;
>  }
>  
> +typedef int (*exit_handle_fn)(struct kvm_vcpu *);
> +
> +exit_handle_fn kvm_get_nvhe_exit_handler(struct kvm_vcpu *vcpu);

and:

> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 86f3d6482935..36da423006bd 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -158,6 +158,41 @@ static void __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
>  		write_sysreg(pmu->events_host, pmcntenset_el0);
>  }
>  
> +typedef int (*exit_handle_fn)(struct kvm_vcpu *);

Which leads to:

arch/arm64/kvm/hyp/nvhe/switch.c:189:15: warning: redefinition of typedef 'exit_handle_fn' is a C11 feature [-Wtypedef-redefinition]
typedef int (*exit_handle_fn)(struct kvm_vcpu *);
              ^
./arch/arm64/kvm/hyp/include/hyp/switch.h:416:15: note: previous definition is here
typedef int (*exit_handle_fn)(struct kvm_vcpu *);
              ^
1 warning generated.

So I guess just pick your favourite?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
