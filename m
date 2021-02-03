Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC730DF4E
	for <lists+kvmarm@lfdr.de>; Wed,  3 Feb 2021 17:11:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DCE624B285;
	Wed,  3 Feb 2021 11:11:58 -0500 (EST)
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
	with ESMTP id mQTMGV6pYYtw; Wed,  3 Feb 2021 11:11:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C5AC44B28C;
	Wed,  3 Feb 2021 11:11:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AFD9C4B285
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 11:11:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-ZBxuewo0JX for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Feb 2021 11:11:54 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B46BC4B282
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 11:11:54 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 690FD64F7C;
 Wed,  3 Feb 2021 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612368713;
 bh=7199PDpVTlqOjnCdGa1C2okl1sOKmVDKqDkYKIiqhaY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FuYblYiB5DXGGToKuosdQ/gmxLGmdtzvKntyOdRlqdN9qhhWUAJE3kHa1bOGTmwEQ
 eL22cLZgiqYFp8YZ3pXeNnElHV48a5UgvsULX6qQ/CuwARYwT47Wo3OGbf4Ek/AGPi
 I4ohHWcS3JCZPpjDxIlDKePYxucDjQOocD904+jEK/wCPRvIObio8zUzXUIs663RgM
 FQKTWIjoMnJOVQTdYo+QNvPTnrdR65aYKZNvwGhPMT2QgBfubvcsxh2DXt+s4Tx08N
 HohfrVM09LweAR6hGFGzdhkee7ZJe5u6AQS46++V8sJY3Z3YefUQLyqyIaDIC18wsc
 nAnjbTO03hiYw==
Date: Wed, 3 Feb 2021 16:11:47 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 26/26] KVM: arm64: Wrap the host with a stage 2
Message-ID: <20210203161146.GJ18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-27-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-27-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Fri, Jan 08, 2021 at 12:15:24PM +0000, Quentin Perret wrote:
> When KVM runs in protected nVHE mode, make use of a stage 2 page-table
> to give the hypervisor some control over the host memory accesses. At
> the moment all memory aborts from the host will be instantly idmapped
> RWX at stage 2 in a lazy fashion. Later patches will make use of that
> infrastructure to implement access control restrictions to e.g. protect
> guest memory from the host.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_cpufeature.h       |   2 +
>  arch/arm64/kernel/image-vars.h                |   3 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  33 +++
>  arch/arm64/kvm/hyp/nvhe/Makefile              |   2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S            |   1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   6 +
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 191 ++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/setup.c               |   6 +
>  arch/arm64/kvm/hyp/nvhe/switch.c              |   7 +-
>  arch/arm64/kvm/hyp/nvhe/tlb.c                 |   4 +-
>  10 files changed, 248 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/mem_protect.c

[...]

> +void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
> +{
> +	enum kvm_pgtable_prot prot;
> +	u64 far, hpfar, esr, ipa;
> +	int ret;
> +
> +	esr = read_sysreg_el2(SYS_ESR);
> +	if (!__get_fault_info(esr, &far, &hpfar))
> +		hyp_panic();
> +
> +	prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W | KVM_PGTABLE_PROT_X;
> +	ipa = (hpfar & HPFAR_MASK) << 8;
> +	ret = host_stage2_map(ipa, PAGE_SIZE, prot);

Can we try to put down a block mapping if the whole thing falls within
memory?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
