Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6067E9B5E2
	for <lists+kvmarm@lfdr.de>; Fri, 23 Aug 2019 19:52:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE6954A609;
	Fri, 23 Aug 2019 13:52:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xaogoW9dDbkK; Fri, 23 Aug 2019 13:52:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C88E4A607;
	Fri, 23 Aug 2019 13:52:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 42C194A5DE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Aug 2019 13:52:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gicVGY1ZtzS5 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Aug 2019 13:52:39 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AF38F4A590
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Aug 2019 13:52:39 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB2FE793C4;
 Fri, 23 Aug 2019 17:52:38 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF20D600C1;
 Fri, 23 Aug 2019 17:52:34 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Use a single IO device per
 redistributor
To: eric.auger.pro@gmail.com, maz@kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20190823173330.23342-1-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f5b47614-de48-f3cb-0e6f-8a667cb951c0@redhat.com>
Date: Fri, 23 Aug 2019 19:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190823173330.23342-1-eric.auger@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 23 Aug 2019 17:52:38 +0000 (UTC)
Cc: zhang.zhanghailiang@huawei.com, andre.przywara@arm.com, qemu-arm@nongnu.org
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

Hi Zenghui, Marc,

On 8/23/19 7:33 PM, Eric Auger wrote:
> At the moment we use 2 IO devices per GICv3 redistributor: one
> one for the RD_base frame and one for the SGI_base frame.
> 
> Instead we can use a single IO device per redistributor (the 2
> frames are contiguous). This saves slots on the KVM_MMIO_BUS
> which is currently limited to NR_IOBUS_DEVS (1000).
> 
> This change allows to instantiate up to 512 redistributors and may
> speed the guest boot with a large number of VCPUs.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

I tested this patch with below kernel and QEMU branches:
kernel: https://github.com/eauger/linux/tree/256fix-v1
(Marc's patch + this patch)
https://github.com/eauger/qemu/tree/v4.1.0-256fix-rfc1-rc0
(header update + kvm_arm_gic_set_irq modification)

On a machine with 224 pcpus, I was able to boot a 512 vcpu guest.

As expected, qemu outputs warnings:

qemu-system-aarch64: warning: Number of SMP cpus requested (512) exceeds
the recommended cpus supported by KVM (224)
qemu-system-aarch64: warning: Number of hotpluggable cpus requested
(512) exceeds the recommended cpus supported by KVM (224)

on the guest: getconf _NPROCESSORS_ONLN returns 512

Then I have no clue about what can be expected of such overcommit config
and I have not further exercised the guest at the moment. But at least
it seems to boot properly. I also tested without overcommit and it seems
to behave as before (boot, migration).

I still need to look at the migration of > 256vcpu guest at qemu level.

Thanks

Eric


> ---
>  include/kvm/arm_vgic.h           |  1 -
>  virt/kvm/arm/vgic/vgic-init.c    |  1 -
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 81 ++++++++++----------------------
>  3 files changed, 24 insertions(+), 59 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 7a30524a80ee..004f6e9d3b05 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -311,7 +311,6 @@ struct vgic_cpu {
>  	 * parts of the redistributor.
>  	 */
>  	struct vgic_io_device	rd_iodev;
> -	struct vgic_io_device	sgi_iodev;
>  	struct vgic_redist_region *rdreg;
>  
>  	/* Contains the attributes and gpa of the LPI pending tables. */
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index bdbc297d06fb..eaff7031a089 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -192,7 +192,6 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  	int i;
>  
>  	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
> -	vgic_cpu->sgi_iodev.base_addr = VGIC_ADDR_UNDEF;
>  
>  	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
>  	raw_spin_lock_init(&vgic_cpu->ap_list_lock);
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index c45e2d7e942f..400067085cab 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -515,7 +515,8 @@ static const struct vgic_register_region vgic_v3_dist_registers[] = {
>  		VGIC_ACCESS_32bit),
>  };
>  
> -static const struct vgic_register_region vgic_v3_rdbase_registers[] = {
> +static const struct vgic_register_region vgic_v3_rd_registers[] = {
> +	/* RD_base registers */
>  	REGISTER_DESC_WITH_LENGTH(GICR_CTLR,
>  		vgic_mmio_read_v3r_ctlr, vgic_mmio_write_v3r_ctlr, 4,
>  		VGIC_ACCESS_32bit),
> @@ -540,44 +541,42 @@ static const struct vgic_register_region vgic_v3_rdbase_registers[] = {
>  	REGISTER_DESC_WITH_LENGTH(GICR_IDREGS,
>  		vgic_mmio_read_v3_idregs, vgic_mmio_write_wi, 48,
>  		VGIC_ACCESS_32bit),
> -};
> -
> -static const struct vgic_register_region vgic_v3_sgibase_registers[] = {
> -	REGISTER_DESC_WITH_LENGTH(GICR_IGROUPR0,
> +	/* SGI_base registers */
> +	REGISTER_DESC_WITH_LENGTH(SZ_64K + GICR_IGROUPR0,
>  		vgic_mmio_read_group, vgic_mmio_write_group, 4,
>  		VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH(GICR_ISENABLER0,
> +	REGISTER_DESC_WITH_LENGTH(SZ_64K + GICR_ISENABLER0,
>  		vgic_mmio_read_enable, vgic_mmio_write_senable, 4,
>  		VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH(GICR_ICENABLER0,
> +	REGISTER_DESC_WITH_LENGTH(SZ_64K + GICR_ICENABLER0,
>  		vgic_mmio_read_enable, vgic_mmio_write_cenable, 4,
>  		VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH_UACCESS(GICR_ISPENDR0,
> +	REGISTER_DESC_WITH_LENGTH_UACCESS(SZ_64K + GICR_ISPENDR0,
>  		vgic_mmio_read_pending, vgic_mmio_write_spending,
>  		vgic_v3_uaccess_read_pending, vgic_v3_uaccess_write_pending, 4,
>  		VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH_UACCESS(GICR_ICPENDR0,
> +	REGISTER_DESC_WITH_LENGTH_UACCESS(SZ_64K + GICR_ICPENDR0,
>  		vgic_mmio_read_pending, vgic_mmio_write_cpending,
>  		vgic_mmio_read_raz, vgic_mmio_uaccess_write_wi, 4,
>  		VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH_UACCESS(GICR_ISACTIVER0,
> +	REGISTER_DESC_WITH_LENGTH_UACCESS(SZ_64K + GICR_ISACTIVER0,
>  		vgic_mmio_read_active, vgic_mmio_write_sactive,
>  		NULL, vgic_mmio_uaccess_write_sactive,
>  		4, VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH_UACCESS(GICR_ICACTIVER0,
> +	REGISTER_DESC_WITH_LENGTH_UACCESS(SZ_64K + GICR_ICACTIVER0,
>  		vgic_mmio_read_active, vgic_mmio_write_cactive,
>  		NULL, vgic_mmio_uaccess_write_cactive,
>  		4, VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH(GICR_IPRIORITYR0,
> +	REGISTER_DESC_WITH_LENGTH(SZ_64K + GICR_IPRIORITYR0,
>  		vgic_mmio_read_priority, vgic_mmio_write_priority, 32,
>  		VGIC_ACCESS_32bit | VGIC_ACCESS_8bit),
> -	REGISTER_DESC_WITH_LENGTH(GICR_ICFGR0,
> +	REGISTER_DESC_WITH_LENGTH(SZ_64K + GICR_ICFGR0,
>  		vgic_mmio_read_config, vgic_mmio_write_config, 8,
>  		VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH(GICR_IGRPMODR0,
> +	REGISTER_DESC_WITH_LENGTH(SZ_64K + GICR_IGRPMODR0,
>  		vgic_mmio_read_raz, vgic_mmio_write_wi, 4,
>  		VGIC_ACCESS_32bit),
> -	REGISTER_DESC_WITH_LENGTH(GICR_NSACR,
> +	REGISTER_DESC_WITH_LENGTH(SZ_64K + GICR_NSACR,
>  		vgic_mmio_read_raz, vgic_mmio_write_wi, 4,
>  		VGIC_ACCESS_32bit),
>  };
> @@ -607,9 +606,8 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
>  	struct vgic_dist *vgic = &kvm->arch.vgic;
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	struct vgic_io_device *rd_dev = &vcpu->arch.vgic_cpu.rd_iodev;
> -	struct vgic_io_device *sgi_dev = &vcpu->arch.vgic_cpu.sgi_iodev;
>  	struct vgic_redist_region *rdreg;
> -	gpa_t rd_base, sgi_base;
> +	gpa_t rd_base;
>  	int ret;
>  
>  	if (!IS_VGIC_ADDR_UNDEF(vgic_cpu->rd_iodev.base_addr))
> @@ -631,52 +629,31 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
>  	vgic_cpu->rdreg = rdreg;
>  
>  	rd_base = rdreg->base + rdreg->free_index * KVM_VGIC_V3_REDIST_SIZE;
> -	sgi_base = rd_base + SZ_64K;
>  
>  	kvm_iodevice_init(&rd_dev->dev, &kvm_io_gic_ops);
>  	rd_dev->base_addr = rd_base;
>  	rd_dev->iodev_type = IODEV_REDIST;
> -	rd_dev->regions = vgic_v3_rdbase_registers;
> -	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rdbase_registers);
> +	rd_dev->regions = vgic_v3_rd_registers;
> +	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
>  	rd_dev->redist_vcpu = vcpu;
>  
>  	mutex_lock(&kvm->slots_lock);
>  	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
> -				      SZ_64K, &rd_dev->dev);
> +				      2 * SZ_64K, &rd_dev->dev);
>  	mutex_unlock(&kvm->slots_lock);
>  
>  	if (ret)
>  		return ret;
>  
> -	kvm_iodevice_init(&sgi_dev->dev, &kvm_io_gic_ops);
> -	sgi_dev->base_addr = sgi_base;
> -	sgi_dev->iodev_type = IODEV_REDIST;
> -	sgi_dev->regions = vgic_v3_sgibase_registers;
> -	sgi_dev->nr_regions = ARRAY_SIZE(vgic_v3_sgibase_registers);
> -	sgi_dev->redist_vcpu = vcpu;
> -
> -	mutex_lock(&kvm->slots_lock);
> -	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, sgi_base,
> -				      SZ_64K, &sgi_dev->dev);
> -	if (ret) {
> -		kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS,
> -					  &rd_dev->dev);
> -		goto out;
> -	}
> -
>  	rdreg->free_index++;
> -out:
> -	mutex_unlock(&kvm->slots_lock);
> -	return ret;
> +	return 0;
>  }
>  
>  static void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_io_device *rd_dev = &vcpu->arch.vgic_cpu.rd_iodev;
> -	struct vgic_io_device *sgi_dev = &vcpu->arch.vgic_cpu.sgi_iodev;
>  
>  	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
> -	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &sgi_dev->dev);
>  }
>  
>  static int vgic_register_all_redist_iodevs(struct kvm *kvm)
> @@ -826,8 +803,8 @@ int vgic_v3_has_attr_regs(struct kvm_device *dev, struct kvm_device_attr *attr)
>  		iodev.base_addr = 0;
>  		break;
>  	case KVM_DEV_ARM_VGIC_GRP_REDIST_REGS:{
> -		iodev.regions = vgic_v3_rdbase_registers;
> -		iodev.nr_regions = ARRAY_SIZE(vgic_v3_rdbase_registers);
> +		iodev.regions = vgic_v3_rd_registers;
> +		iodev.nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
>  		iodev.base_addr = 0;
>  		break;
>  	}
> @@ -985,21 +962,11 @@ int vgic_v3_redist_uaccess(struct kvm_vcpu *vcpu, bool is_write,
>  			   int offset, u32 *val)
>  {
>  	struct vgic_io_device rd_dev = {
> -		.regions = vgic_v3_rdbase_registers,
> -		.nr_regions = ARRAY_SIZE(vgic_v3_rdbase_registers),
> +		.regions = vgic_v3_rd_registers,
> +		.nr_regions = ARRAY_SIZE(vgic_v3_rd_registers),
>  	};
>  
> -	struct vgic_io_device sgi_dev = {
> -		.regions = vgic_v3_sgibase_registers,
> -		.nr_regions = ARRAY_SIZE(vgic_v3_sgibase_registers),
> -	};
> -
> -	/* SGI_base is the next 64K frame after RD_base */
> -	if (offset >= SZ_64K)
> -		return vgic_uaccess(vcpu, &sgi_dev, is_write, offset - SZ_64K,
> -				    val);
> -	else
> -		return vgic_uaccess(vcpu, &rd_dev, is_write, offset, val);
> +	return vgic_uaccess(vcpu, &rd_dev, is_write, offset, val);
>  }
>  
>  int vgic_v3_line_level_info_uaccess(struct kvm_vcpu *vcpu, bool is_write,
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
