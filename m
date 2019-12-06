Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5B115017
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 12:57:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 34D0C4AF47;
	Fri,  6 Dec 2019 06:57:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DN99lu2Sonjg; Fri,  6 Dec 2019 06:57:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B8924AF3E;
	Fri,  6 Dec 2019 06:57:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 65C104AF30
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:57:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nGuw6-FmnqmU for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 06:57:20 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 47C5C4AF23
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:57:20 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902B631B;
 Fri,  6 Dec 2019 03:57:19 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5B3F63F52E; Fri,  6 Dec 2019 03:57:18 -0800 (PST)
Date: Fri, 6 Dec 2019 11:57:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] arm64: KVM: Invoke compute_layout() before
 alternatives are applied
Message-ID: <20191206115716.GC32767@arrakis.emea.arm.com>
References: <20191016165953.o6ogh4fdmsjmd2sw@linutronix.de>
 <ecfbb413-e97e-c3eb-e051-1f218b387edd@arm.com>
 <20191128195805.c2pryug4ohmcoqwd@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191128195805.c2pryug4ohmcoqwd@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
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

On Thu, Nov 28, 2019 at 08:58:05PM +0100, Sebastian Andrzej Siewior wrote:
> @@ -408,6 +410,8 @@ static void __init hyp_mode_check(void)
>  			   "CPU: CPUs started in inconsistent modes");
>  	else
>  		pr_info("CPU: All CPU(s) started at EL1\n");
> +	if (IS_ENABLED(CONFIG_KVM_ARM_HOST))
> +		kvm_compute_layout();
>  }

It looks like we call this unconditionally here even if the kernel was
booted at EL1.

>  void __init smp_cpus_done(unsigned int max_cpus)
> diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
> index 2cf7d4b606c38..dab1fea4752aa 100644
> --- a/arch/arm64/kvm/va_layout.c
> +++ b/arch/arm64/kvm/va_layout.c
> @@ -22,7 +22,7 @@ static u8 tag_lsb;
>  static u64 tag_val;
>  static u64 va_mask;
>  
> -static void compute_layout(void)
> +__init void kvm_compute_layout(void)
>  {
>  	phys_addr_t idmap_addr = __pa_symbol(__hyp_idmap_text_start);
>  	u64 hyp_va_msb;
> @@ -110,9 +110,6 @@ void __init kvm_update_va_mask(struct alt_instr *alt,
>  
>  	BUG_ON(nr_inst != 5);
>  
> -	if (!has_vhe() && !va_mask)
> -		compute_layout();
> -
>  	for (i = 0; i < nr_inst; i++) {
>  		u32 rd, rn, insn, oinsn;
>  
> @@ -156,9 +153,6 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
>  		return;
>  	}
>  
> -	if (!va_mask)
> -		compute_layout();

And here we had a few more checks.

Maybe it's still correct but asking anyway.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
