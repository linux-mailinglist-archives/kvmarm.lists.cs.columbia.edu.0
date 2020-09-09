Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8092629FD
	for <lists+kvmarm@lfdr.de>; Wed,  9 Sep 2020 10:18:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED80A4B619;
	Wed,  9 Sep 2020 04:18:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.098
X-Spam-Level: 
X-Spam-Status: No, score=0.098 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U-+IYVFRHCJo; Wed,  9 Sep 2020 04:18:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 469D14B5B6;
	Wed,  9 Sep 2020 04:18:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DC924B3C2
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 23:23:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rBk2ZWvjFjsx for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Sep 2020 23:23:27 -0400 (EDT)
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 21D234B385
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 23:23:26 -0400 (EDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0893NC1k019288;
 Wed, 9 Sep 2020 12:23:12 +0900
X-Iguazu-Qid: 2wGqu78fjgdqsiLAfO
X-Iguazu-QSIG: v=2; s=0; t=1599621791; q=2wGqu78fjgdqsiLAfO;
 m=DYT0UINKyeExPjuDuIYDWKRawt8iW+J/bc7NgKefQbM=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1110) id 0893N9Bd019173;
 Wed, 9 Sep 2020 12:23:09 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 0893N9Ae003824;
 Wed, 9 Sep 2020 12:23:09 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 0893N8um023841;
 Wed, 9 Sep 2020 12:23:08 +0900
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 7/9] KVM: arm64: Do not try to map PUDs when they are
 folded into PMD
References: <20200904104530.1082676-1-maz@kernel.org>
 <20200904104530.1082676-8-maz@kernel.org>
Date: Wed, 09 Sep 2020 12:23:07 +0900
In-Reply-To: <20200904104530.1082676-8-maz@kernel.org> (Marc Zyngier's message
 of "Fri, 4 Sep 2020 11:45:28 +0100")
X-TSB-HOP: ON
Message-ID: <874ko7prac.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 09 Sep 2020 04:18:03 -0400
Cc: kvm@vger.kernel.org, kernel-team@android.com, stable@vger.kernel.org,
 Steven Price <steven.price@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

Hi Marc,

Noticed this patch while catching up with the lists.

Marc Zyngier <maz@kernel.org> writes:

> For the obscure cases where PMD and PUD are the same size
> (64kB pages with 42bit VA, for example, which results in only
> two levels of page tables), we can't map anything as a PUD,
> because there is... erm... no PUD to speak of. Everything is
> either a PMD or a PTE.
>
> So let's only try and map a PUD when its size is different from
> that of a PMD.
>
> Cc: stable@vger.kernel.org
> Fixes: b8e0ba7c8bea ("KVM: arm64: Add support for creating PUD hugepages at stage 2")
> Reported-by: Gavin Shan <gshan@redhat.com>
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/mmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0121ef2c7c8d..16b8660ddbcc 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1964,7 +1964,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		(fault_status == FSC_PERM &&
>  		 stage2_is_exec(mmu, fault_ipa, vma_pagesize));
>  
> -	if (vma_pagesize == PUD_SIZE) {
> +	/*
> +	 * If PUD_SIZE == PMD_SIZE, there is no real PUD level, and
> +	 * all we have is a 2-level page table. Trying to map a PUD in
> +	 * this case would be fatally wrong.
> +	 */
> +	if (PUD_SIZE != PMD_SIZE && vma_pagesize == PUD_SIZE) {
>  		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);
>  
>  		new_pud = kvm_pud_mkhuge(new_pud);

Good catch!
Missed the 64kb / 42b VA case while adding the initial support.

Thanks for fixing it.

Punit
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
