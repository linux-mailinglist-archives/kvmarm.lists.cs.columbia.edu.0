Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D37D6353D62
	for <lists+kvmarm@lfdr.de>; Mon,  5 Apr 2021 12:10:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B5FE4BAC4;
	Mon,  5 Apr 2021 06:10:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7iuwuC1vG3A7; Mon,  5 Apr 2021 06:10:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 049664BAAF;
	Mon,  5 Apr 2021 06:10:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 27D0E4BA24
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Apr 2021 06:10:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TpxVDtjB0A0V for <kvmarm@lists.cs.columbia.edu>;
 Mon,  5 Apr 2021 06:10:24 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 18EDD4BAA1
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Apr 2021 06:10:24 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 612AB611CC;
 Mon,  5 Apr 2021 10:10:21 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lTMBX-005eqm-5T; Mon, 05 Apr 2021 11:10:19 +0100
Date: Mon, 05 Apr 2021 11:10:18 +0100
Message-ID: <878s5xf3ed.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v5 7/8] KVM: arm64: vgic-v3: Expose GICR_TYPER.Last for
 userspace
In-Reply-To: <20210404172243.504309-8-eric.auger@redhat.com>
References: <20210404172243.504309-1-eric.auger@redhat.com>
 <20210404172243.504309-8-eric.auger@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, eric.auger.pro@gmail.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, drjones@redhat.com, alexandru.elisei@arm.com,
 james.morse@arm.com, suzuki.poulose@arm.com, shuah@kernel.org,
 pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Sun, 04 Apr 2021 18:22:42 +0100,
Eric Auger <eric.auger@redhat.com> wrote:
> 
> Commit 23bde34771f1 ("KVM: arm64: vgic-v3: Drop the
> reporting of GICR_TYPER.Last for userspace") temporarily fixed
> a bug identified when attempting to access the GICR_TYPER
> register before the redistributor region setting, but dropped
> the support of the LAST bit.
> 
> Emulating the GICR_TYPER.Last bit still makes sense for
> architecture compliance though. This patch restores its support
> (if the redistributor region was set) while keeping the code safe.
> 
> We introduce a new helper, vgic_mmio_vcpu_rdist_is_last() which
> computes whether a redistributor is the highest one of a series
> of redistributor contributor pages.
> 
> With this new implementation we do not need to have a uaccess
> read accessor anymore.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v4 -> v5:
> - redist region list now is sorted by @base
> - change the implementation according to Marc's understanding of
>   the spec
> ---
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c | 58 +++++++++++++++++-------------
>  include/kvm/arm_vgic.h             |  1 +
>  2 files changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> index e1ed0c5a8eaa..03a253785700 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> @@ -251,45 +251,52 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
>  		vgic_enable_lpis(vcpu);
>  }
>  
> +static bool vgic_mmio_vcpu_rdist_is_last(struct kvm_vcpu *vcpu)
> +{
> +	struct vgic_dist *vgic = &vcpu->kvm->arch.vgic;
> +	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +	struct vgic_redist_region *iter, *rdreg = vgic_cpu->rdreg;
> +
> +	if (!rdreg)
> +		return false;
> +
> +	if (vgic_cpu->rdreg_index < rdreg->free_index - 1) {
> +		return false;
> +	} else if (rdreg->count && vgic_cpu->rdreg_index == (rdreg->count - 1)) {
> +		struct list_head *rd_regions = &vgic->rd_regions;
> +		gpa_t end = rdreg->base + rdreg->count * KVM_VGIC_V3_REDIST_SIZE;
> +
> +		/*
> +		 * the rdist is the last one of the redist region,
> +		 * check whether there is no other contiguous rdist region
> +		 */
> +		list_for_each_entry(iter, rd_regions, list) {
> +			if (iter->base == end && iter->free_index > 0)
> +				return false;
> +		}

In the above notes, you state that the region list is now sorted by
base address, but I really can't see what sorts that list. And the
lines above indicate that you are still iterating over the whole RD
regions.

It's not a big deal (the code is now simple enough), but that's just
to confirm that I understand what is going on here.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
