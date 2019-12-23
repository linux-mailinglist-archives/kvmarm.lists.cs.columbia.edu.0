Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C01BA12969B
	for <lists+kvmarm@lfdr.de>; Mon, 23 Dec 2019 14:44:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2430A4AF62;
	Mon, 23 Dec 2019 08:44:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulk5uB6oJpaF; Mon, 23 Dec 2019 08:44:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 035774AF5F;
	Mon, 23 Dec 2019 08:44:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB5144AF53
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Dec 2019 08:44:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z9zpKSe8+KnH for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Dec 2019 08:43:58 -0500 (EST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 465B14AF25
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Dec 2019 08:43:58 -0500 (EST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1E959C499F930DB2F9D9;
 Mon, 23 Dec 2019 21:43:54 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Dec 2019
 21:43:44 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
To: <maz@kernel.org>
References: <20191220111833.1422-1-yuzenghui@huawei.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
Date: Mon, 23 Dec 2019 21:43:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191220111833.1422-1-yuzenghui@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: andre.przywara@arm.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2019/12/20 19:18, Zenghui Yu wrote:
> Although guest will hardly read and use the PTZ (Pending Table Zero)
> bit in GICR_PENDBASER, let us emulate the architecture strictly.
> As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> Noticed when checking all fields of GICR_PENDBASER register.
> But _not_ sure whether it's worth a fix, as Linux never sets
> the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).
> 
> And I wonder under which scenarios can this bit be written as 1.
> It seems difficult for software to determine whether the pending
> table contains all zeros when writing this bit.
> 
>   virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 7dfd15dbb308..ebc218840fc2 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -414,8 +414,11 @@ static unsigned long vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>   					     gpa_t addr, unsigned int len)
>   {
>   	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +	u64 value = vgic_cpu->pendbaser;
>   
> -	return extract_bytes(vgic_cpu->pendbaser, addr & 7, len);
> +	value &= ~GICR_PENDBASER_PTZ;
> +
> +	return extract_bytes(value, addr & 7, len);
>   }
>   
>   static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
> 

I noticed there is no userspace access callbacks for GICR_PENDBASER,
so this patch will make the PTZ field also 'Read As Zero' by userspace.
Should we consider adding a uaccess_read callback for GICR_PENDBASER
which just returns the unchanged vgic_cpu->pendbaser to userspace?
(Though this is really not a big deal. We now always emulate the PTZ
field to guest as RAZ. And 'vgic_cpu->pendbaser & GICR_PENDBASER_PTZ'
only indicates whether KVM will optimize the LPI enabling process,
where Read As Zero indicates never optimize..)


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
