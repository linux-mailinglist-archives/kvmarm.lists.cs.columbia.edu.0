Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1208611500F
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 12:53:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C9874AF46;
	Fri,  6 Dec 2019 06:53:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O5kxvBn6gEaT; Fri,  6 Dec 2019 06:53:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FFB24AF30;
	Fri,  6 Dec 2019 06:53:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D2FA4AF24
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:53:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ylDkOfOpuy6I for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 06:53:47 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5CE474AF23
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:53:47 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1idCAz-00025P-1c; Fri, 06 Dec 2019 12:53:37 +0100
To: linmiaohe <linmiaohe@huawei.com>
Subject: Re: [PATCH] KVM: vgic: Fix potential double free dist->spis in
 =?UTF-8?Q?=5F=5Fkvm=5Fvgic=5Fdestroy=28=29?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 06 Dec 2019 11:53:36 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <1574923128-19956-1-git-send-email-linmiaohe@huawei.com>
References: <1574923128-19956-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <c786fec1d39fc8beae4bc4fe4269add9@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linmiaohe@huawei.com, pbonzini@redhat.com,
 rkrcmar@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, christoffer.dall@arm.com, catalin.marinas@arm.com,
 eric.auger@redhat.com, gregkh@linuxfoundation.org, will@kernel.org,
 andre.przywara@arm.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org, pbonzini@redhat.com, tglx@linutronix.de,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2019-11-28 06:38, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> In kvm_vgic_dist_init() called from kvm_vgic_map_resources(), if
> dist->vgic_model is invalid, dist->spis will be freed without set
> dist->spis = NULL. And in vgicv2 resources clean up path,
> __kvm_vgic_destroy() will be called to free allocated resources.
> And dist->spis will be freed again in clean up chain because we
> forget to set dist->spis = NULL in kvm_vgic_dist_init() failed
> path. So double free would happen.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/arm/vgic/vgic-init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/virt/kvm/arm/vgic/vgic-init.c 
> b/virt/kvm/arm/vgic/vgic-init.c
> index 53e3969dfb52..c17c29beeb72 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -171,6 +171,7 @@ static int kvm_vgic_dist_init(struct kvm *kvm,
> unsigned int nr_spis)
>  			break;
>  		default:
>  			kfree(dist->spis);
> +			dist->spis = NULL;
>  			return -EINVAL;
>  		}
>  	}

Applied, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
