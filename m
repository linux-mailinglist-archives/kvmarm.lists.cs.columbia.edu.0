Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F434298159
	for <lists+kvmarm@lfdr.de>; Sun, 25 Oct 2020 11:48:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCD304BA88;
	Sun, 25 Oct 2020 06:48:34 -0400 (EDT)
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
	with ESMTP id bJsQR8WmG-+x; Sun, 25 Oct 2020 06:48:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AC924BA2E;
	Sun, 25 Oct 2020 06:48:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 732C24B902
 for <kvmarm@lists.cs.columbia.edu>; Sun, 25 Oct 2020 06:48:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NL7e08rTUlOu for <kvmarm@lists.cs.columbia.edu>;
 Sun, 25 Oct 2020 06:48:31 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 47D6E4B8F2
 for <kvmarm@lists.cs.columbia.edu>; Sun, 25 Oct 2020 06:48:31 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D03D222D9;
 Sun, 25 Oct 2020 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603622910;
 bh=zEZv+ZNBF+WLM11Idj/nftgE/O9ylhR81K3Yn2chkKs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Pxv8mT386ya9ViOoESPjvo/evUhJWVNTWQbTb6x3v1OTjDWsDVY/zuzO1vzSteNp8
 /ftdUuJmDbhLucMIcPJddvcR+mZEwbQXvXC755cEW2rU50BKhZRMB4Jmh/Cyh66umY
 biLsm5KLTEp8DuBmUMiugX5ytXoffq3nAqC0V4sI=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kWdZc-0042bs-6J; Sun, 25 Oct 2020 10:48:28 +0000
Date: Sun, 25 Oct 2020 10:48:27 +0000
Message-ID: <87y2juoa2s.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 3/3] KVM: arm64: Failback on unsupported huge page sizes
In-Reply-To: <20201025002739.5804-4-gshan@redhat.com>
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-4-gshan@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26.3
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: gshan@redhat.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, will@kernel.org, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
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

On Sun, 25 Oct 2020 01:27:39 +0100,
Gavin Shan <gshan@redhat.com> wrote:
> 
> The huge page could be mapped through multiple contiguous PMDs or PTEs.
> The corresponding huge page sizes aren't supported by the page table
> walker currently.
> 
> This fails the unsupported huge page sizes to the near one. Otherwise,
> the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
> fail back to PMD_SHIFT and PAGE_SHIFT separately.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0f51585adc04..81cbdc368246 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -793,12 +793,20 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		vma_shift = PMD_SHIFT;
>  #endif
>  
> +	if (vma_shift == CONT_PMD_SHIFT)
> +		vma_shift = PMD_SHIFT;
> +
>  	if (vma_shift == PMD_SHIFT &&
>  	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
>  		force_pte = true;
>  		vma_shift = PAGE_SHIFT;
>  	}
>  
> +	if (vma_shift == CONT_PTE_SHIFT) {
> +		force_pte = true;
> +		vma_shift = PAGE_SHIFT;
> +	}
> +
>  	vma_pagesize = 1UL << vma_shift;
>  	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
>  		fault_ipa &= ~(vma_pagesize - 1);

Yup, nice catch. However, I think we should take this opportunity to
rationalise the logic here, and catch future discrepancies (should
someone add contiguous PUD or something similarly silly). How about
something like this (untested):

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index cc323d96c9d4..d9a13a8a82e0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -787,14 +787,31 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_shift = PAGE_SHIFT;
 	}
 
-	if (vma_shift == PUD_SHIFT &&
-	    !fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
-	       vma_shift = PMD_SHIFT;
+	switch (vma_shift) {
+	case PUD_SHIFT:
+		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
+			break;
+		fallthrough;
 
-	if (vma_shift == PMD_SHIFT &&
-	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
-		force_pte = true;
+	case CONT_PMD_SHIFT:
+		vma_shift = PMD_SHIFT;
+		fallthrough;
+
+	case PMD_SHIFT:
+		if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE))
+			break;
+		fallthrough;
+
+	case CONT_PTE_SHIFT:
 		vma_shift = PAGE_SHIFT;
+		force_pte = true;
+		fallthrough;
+
+	case PAGE_SHIFT:
+		break;
+
+	default:
+		WARN_ONCE(1, "Unknown vma_shift %d", vma_shift);
 	}
 
 	vma_pagesize = 1UL << vma_shift;


Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
