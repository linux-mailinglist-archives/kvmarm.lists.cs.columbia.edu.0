Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2811E265
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 11:54:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9ED64A955;
	Fri, 13 Dec 2019 05:54:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDvn0xLcAlGy; Fri, 13 Dec 2019 05:54:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C5B514A598;
	Fri, 13 Dec 2019 05:54:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 851F14A4F6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 05:54:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZbKSnmtlOPNi for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Dec 2019 05:54:07 -0500 (EST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F414F4A4C0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 05:54:06 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2A6E91B35A79113B855B;
 Fri, 13 Dec 2019 18:54:01 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 18:53:55 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped
 collections
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>
References: <20191213094237.19627-1-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
Date: Fri, 13 Dec 2019 18:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191213094237.19627-1-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
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

On 2019/12/13 17:42, Eric Auger wrote:
> Saving/restoring an unmapped collection is a valid scenario. For
> example this happens if a MAPTI command was sent, featuring an
> unmapped collection. At the moment the CTE fails to be restored.
> Only compare against the number of online vcpus if the rdist
> base is set.

Have you actually seen a problem and this patch fixed it? To be honest,
I'm surprised to find that we can map a LPI to an unmapped collection ;)
(and prevent it to be delivered to vcpu with an INT_UNMAPPED_INTERRUPT
error, until someone had actually mapped the collection).
After a quick glance of spec (MAPTI), just as you said, this is valid.

If Marc has no objection to this fix, please add

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks,
Zenghui

> 
> Cc: stable@vger.kernel.org # v4.11+
> Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table save/restore")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   virt/kvm/arm/vgic/vgic-its.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 98c7360d9fb7..17920d1b350a 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
>   	target_addr = (u32)(val >> KVM_ITS_CTE_RDBASE_SHIFT);
>   	coll_id = val & KVM_ITS_CTE_ICID_MASK;
>   
> -	if (target_addr >= atomic_read(&kvm->online_vcpus))
> +	if (target_addr != COLLECTION_NOT_MAPPED &&
> +	    target_addr >= atomic_read(&kvm->online_vcpus))
>   		return -EINVAL;
>   
>   	collection = find_collection(its, coll_id);
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
