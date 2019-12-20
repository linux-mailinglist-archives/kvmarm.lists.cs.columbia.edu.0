Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5C983127B7C
	for <lists+kvmarm@lfdr.de>; Fri, 20 Dec 2019 14:07:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E49554ACB8;
	Fri, 20 Dec 2019 08:07:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L-iozktE+l2H; Fri, 20 Dec 2019 08:07:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A97624ACDB;
	Fri, 20 Dec 2019 08:07:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 188B64ACB8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 08:07:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4mrPXRtm+k0t for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Dec 2019 08:07:12 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EC9DA4AC89
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 08:07:11 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iiHzl-0005uV-GW; Fri, 20 Dec 2019 14:07:05 +0100
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle =?UTF-8?Q?GICR=5FPENDBAS?=
 =?UTF-8?Q?ER=2EPTZ=20filed=20as=20RAZ?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 20 Dec 2019 13:07:05 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <20191220111833.1422-1-yuzenghui@huawei.com>
References: <20191220111833.1422-1-yuzenghui@huawei.com>
Message-ID: <71e3dcc00ad5ab8dffd732bfe7381705@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, andre.przywara@arm.com,
 eric.auger@redhat.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
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

On 2019-12-20 11:18, Zenghui Yu wrote:
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

This is a useless HW optimization, where it can avoid reading the
pending table the very first time you write to this register if
it is told that it is all zero. A decent ITS implementation
already has a mechanism to find out about the pending bits by
looking into the IMPDEF area (the first 1kB) of the pending table.
PTZ is just yet another way to do the same thing.

This can only happen once in the lifetime of the system (when 
allocating
the table), and Linux doesn't really care. As usual, the GIC is setting
the level of useless complexity pretty high...

>
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 7dfd15dbb308..ebc218840fc2 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -414,8 +414,11 @@ static unsigned long
> vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>  					     gpa_t addr, unsigned int len)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +	u64 value = vgic_cpu->pendbaser;
>
> -	return extract_bytes(vgic_cpu->pendbaser, addr & 7, len);
> +	value &= ~GICR_PENDBASER_PTZ;
> +
> +	return extract_bytes(value, addr & 7, len);
>  }
>
>  static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,

Otherwise looks good. I'll queue it with Eric's correction
to the subject line.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
