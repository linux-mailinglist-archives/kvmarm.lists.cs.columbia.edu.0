Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A87AF24E6D0
	for <lists+kvmarm@lfdr.de>; Sat, 22 Aug 2020 12:01:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7612A4C97D;
	Sat, 22 Aug 2020 06:01:48 -0400 (EDT)
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
	with ESMTP id rn1fUNdav+TD; Sat, 22 Aug 2020 06:01:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C92A4C718;
	Sat, 22 Aug 2020 06:01:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB27F4C666
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Aug 2020 06:01:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gIaI6Xevqa7i for <kvmarm@lists.cs.columbia.edu>;
 Sat, 22 Aug 2020 06:01:44 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8FC974C520
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Aug 2020 06:01:44 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 34752207C3;
 Sat, 22 Aug 2020 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598090503;
 bh=CY4X9/e7cUk+6T4E0hQMk+pXKeuJVADK8FD+qHpfQfM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=1MeNnNU6itHystDyD0OAKjy/iinVG/VcEi95Y6jupneG27DYKQEaVI1U81rIsgZ52
 xM0VHyECe8yio1qwygJYvJc3+fnYu/Qt1OI5JX6T1JA5tU/N7r//CwhSiZYzoxVlY7
 jk8Tt2cYrYXlnATI1efxel/VQNdCbHnosRJ+vGzU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k9QLF-0058Zs-Gd; Sat, 22 Aug 2020 11:01:41 +0100
Date: Sat, 22 Aug 2020 11:01:40 +0100
Message-ID: <87imdbm22j.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/kvm: Fix zapping stage2 page table wrongly
In-Reply-To: <20200822024444.28132-1-gshan@redhat.com>
References: <20200822024444.28132-1-gshan@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26.3
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: gshan@redhat.com, kvmarm@lists.cs.columbia.edu,
 eric.auger@redhat.com, shan.gavin@gmail.com, suzuki.poulose@arm.com,
 james.morse@arm.com, qperret@google.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
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

Hi Gavin,

Adding the usual suspects to the Cc list.

On Sat, 22 Aug 2020 03:44:44 +0100,
Gavin Shan <gshan@redhat.com> wrote:
> 
> Depending on the kernel configuration, PUD_SIZE could be equal to
> PMD_SIZE. For example, both of them are 512MB with the following
> kernel configuration. In this case, both PUD and PMD are folded
> to PGD.
> 
>    CONFIG_ARM64_64K_PAGES   y
>    CONFIG_ARM64_VA_BITS     42
>    CONFIG_PGTABLE_LEVELS    2
> 
> With the above configuration, the stage2 PUD is used to backup the
> 512MB huge page when the stage2 mapping is built. During the mapping,
> the PUD and its subordinate levels of page table entries are unmapped
> if the PUD is present and not huge page sensitive in stage2_set_pud_huge().
> Unfornately, the @addr isn't aligned to S2_PUD_SIZE and wrong page table
> entries are zapped. It eventually leads to PUD's present bit can't be
> cleared successfully and infinite loop in stage2_set_pud_huge().
> 
> This fixes the issue by checking with S2_{PUD, PMD}_SIZE instead of
> {PUD, PMD}_SIZE to determine if stage2 PUD or PMD is used to back the
> huge page. For this particular case, the stage2 PMD entry should be
> used to backup the 512MB huge page with stage2_set_pmd_huge().

It isn't obvious to me how S2_PMD_SIZE can be different from PMD_SIZE,
and the current code certainly expects both to be equal (just look at
how often S2_*_SIZE is used in the current code to convince yourself).

My guess is that some lesser tested configurations (such as 64k pages)
break that assumption, and result in the wrong thing happening. Could
you please shed some light on it?

> Fixes: 3c3736cd32bf ("KVM: arm/arm64: Fix handling of stage2 huge mappings")

This commit doesn't seem to match the code your changing (it doesn't
even come near user_mem_abort()). Are there any intermediate commits
that would better explain the problem?

> Cc: stable@vger.kernel.org # v5.1+
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arch/arm64/kvm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0121ef2c7c8d..deb1819ba9e2 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1964,7 +1964,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		(fault_status == FSC_PERM &&
>  		 stage2_is_exec(mmu, fault_ipa, vma_pagesize));
>  
> -	if (vma_pagesize == PUD_SIZE) {
> +	if (vma_pagesize == S2_PUD_SIZE) {
>  		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);
>  
>  		new_pud = kvm_pud_mkhuge(new_pud);
> @@ -1975,7 +1975,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			new_pud = kvm_s2pud_mkexec(new_pud);
>  
>  		ret = stage2_set_pud_huge(mmu, memcache, fault_ipa, &new_pud);
> -	} else if (vma_pagesize == PMD_SIZE) {
> +	} else if (vma_pagesize == S2_PMD_SIZE) {
>  		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
>  
>  		new_pmd = kvm_pmd_mkhuge(new_pmd);
> -- 
> 2.23.0
> 
> 

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
