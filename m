Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0171411E23C
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 11:43:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 798A94A968;
	Fri, 13 Dec 2019 05:43:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2SmZRtRz96i; Fri, 13 Dec 2019 05:43:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7146B4A7FD;
	Fri, 13 Dec 2019 05:43:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2970F4A4E1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 05:43:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4W-JBJRXsDf for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Dec 2019 05:43:25 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 19CCF4005D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 05:43:25 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ifiPq-0003kl-75; Fri, 13 Dec 2019 11:43:22 +0100
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped
 collections
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 13 Dec 2019 10:43:22 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <20191213094237.19627-1-eric.auger@redhat.com>
References: <20191213094237.19627-1-eric.auger@redhat.com>
Message-ID: <2634d1361ac3d5518b3bea62dc40ab06@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, eric.auger.pro@gmail.com,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 eric.auger.pro@gmail.com
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

Hi Eric,

On 2019-12-13 09:42, Eric Auger wrote:
> Saving/restoring an unmapped collection is a valid scenario. For
> example this happens if a MAPTI command was sent, featuring an
> unmapped collection. At the moment the CTE fails to be restored.
> Only compare against the number of online vcpus if the rdist
> base is set.
>
> Cc: stable@vger.kernel.org # v4.11+
> Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table 
> save/restore")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic-its.c 
> b/virt/kvm/arm/vgic/vgic-its.c
> index 98c7360d9fb7..17920d1b350a 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct vgic_its
> *its, gpa_t gpa, int esz)
>  	target_addr = (u32)(val >> KVM_ITS_CTE_RDBASE_SHIFT);
>  	coll_id = val & KVM_ITS_CTE_ICID_MASK;
>
> -	if (target_addr >= atomic_read(&kvm->online_vcpus))
> +	if (target_addr != COLLECTION_NOT_MAPPED &&
> +	    target_addr >= atomic_read(&kvm->online_vcpus))
>  		return -EINVAL;
>
>  	collection = find_collection(its, coll_id);

Looks good to me. Out of curiosity, how was this spotted?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
