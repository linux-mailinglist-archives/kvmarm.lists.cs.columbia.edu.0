Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9387542E
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jul 2019 18:38:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE4634A604;
	Thu, 25 Jul 2019 12:38:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIwL8wOG0s9j; Thu, 25 Jul 2019 12:38:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AC4C4A5F8;
	Thu, 25 Jul 2019 12:38:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A485F4A5B4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 12:37:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxnCUMqgVuyF for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jul 2019 12:37:58 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8C2574A5A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 12:37:58 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6F3B30860DC;
 Thu, 25 Jul 2019 16:37:56 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7004E17B12;
 Thu, 25 Jul 2019 16:37:53 +0000 (UTC)
Subject: Re: [PATCH v3 07/10] KVM: arm/arm64: vgic-its: Invalidate MSI-LPI
 translation cache on vgic teardown
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20190725153543.24386-1-maz@kernel.org>
 <20190725153543.24386-8-maz@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7b226f82-5000-58f6-0cdf-d0be1f1ddb84@redhat.com>
Date: Thu, 25 Jul 2019 18:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190725153543.24386-8-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 25 Jul 2019 16:37:57 +0000 (UTC)
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <Andre.Przywara@arm.com>, "Raslan,
 KarimAllah" <karahmed@amazon.de>, "Saidi, Ali" <alisaidi@amazon.com>
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

On 7/25/19 5:35 PM, Marc Zyngier wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> In order to avoid leaking vgic_irq structures on teardown, we need to
> drop all references to LPIs before deallocating the cache itself.
> 
> This is done by invalidating the cache on vgic teardown.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 05406bd92ce9..d3e90a9d0a7a 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -1731,6 +1731,8 @@ void vgic_lpi_translation_cache_destroy(struct kvm *kvm)
>  	struct vgic_dist *dist = &kvm->arch.vgic;
>  	struct vgic_translation_cache_entry *cte, *tmp;
>  
> +	vgic_its_invalidate_cache(kvm);
> +
>  	list_for_each_entry_safe(cte, tmp,
>  				 &dist->lpi_translation_cache, entry) {
>  		list_del(&cte->entry);
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
