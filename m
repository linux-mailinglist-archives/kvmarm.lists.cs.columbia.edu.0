Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 260582C07F7
	for <lists+kvmarm@lfdr.de>; Mon, 23 Nov 2020 13:52:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7E184B909;
	Mon, 23 Nov 2020 07:52:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCMMzOQ+Q6Hm; Mon, 23 Nov 2020 07:52:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 17A4E4BAE7;
	Mon, 23 Nov 2020 07:52:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B0734B88E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Nov 2020 07:52:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IFKsJ-SEBGBK for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Nov 2020 07:52:00 -0500 (EST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A186D4BB18
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Nov 2020 07:51:59 -0500 (EST)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Cfn8p44BTzQjKf;
 Mon, 23 Nov 2020 20:51:38 +0800 (CST)
Received: from dggema763-chm.china.huawei.com (10.1.198.205) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 23 Nov 2020 20:51:54 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema763-chm.china.huawei.com (10.1.198.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 23 Nov 2020 20:51:53 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Mon, 23 Nov 2020 12:51:51 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "maz@kernel.org" <maz@kernel.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v11 08/13] vfio/pci: Add framework for custom interrupt
 indices
Thread-Topic: [PATCH v11 08/13] vfio/pci: Add framework for custom interrupt
 indices
Thread-Index: AQHWvAf127Ebzpr/3UCDZWCpMyV4FKnVsyVg
Date: Mon, 23 Nov 2020 12:51:51 +0000
Message-ID: <d938eaf119c441359b1c30fe1b7c58ef@huawei.com>
References: <20201116110030.32335-1-eric.auger@redhat.com>
 <20201116110030.32335-9-eric.auger@redhat.com>
In-Reply-To: <20201116110030.32335-9-eric.auger@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.9.102]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Linuxarm <linuxarm@huawei.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 qubingbing <qubingbing@hisilicon.com>
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

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 16 November 2020 11:00
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; kvmarm@lists.cs.columbia.edu; will@kernel.org;
> joro@8bytes.org; maz@kernel.org; robin.murphy@arm.com;
> alex.williamson@redhat.com
> Cc: jean-philippe@linaro.org; zhangfei.gao@linaro.org;
> zhangfei.gao@gmail.com; vivek.gautam@arm.com; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>;
> jacob.jun.pan@linux.intel.com; yi.l.liu@intel.com; tn@semihalf.com;
> nicoleotsuka@gmail.com; yuzenghui <yuzenghui@huawei.com>
> Subject: [PATCH v11 08/13] vfio/pci: Add framework for custom interrupt
> indices
> 
> Implement IRQ capability chain infrastructure. All interrupt
> indexes beyond VFIO_PCI_NUM_IRQS are handled as extended
> interrupts. They are registered with a specific type/subtype
> and supported flags.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         | 99 +++++++++++++++++++++++------
>  drivers/vfio/pci/vfio_pci_intrs.c   | 62 ++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_private.h | 14 ++++
>  3 files changed, 157 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 2a6cc1a87323..93e03a4a5f32 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -608,6 +608,14 @@ static void vfio_pci_disable(struct vfio_pci_device
> *vdev)
> 
>  	WARN_ON(iommu_unregister_device_fault_handler(&vdev->pdev->dev));
> 
> +	for (i = 0; i < vdev->num_ext_irqs; i++)
> +		vfio_pci_set_irqs_ioctl(vdev, VFIO_IRQ_SET_DATA_NONE |
> +					VFIO_IRQ_SET_ACTION_TRIGGER,
> +					VFIO_PCI_NUM_IRQS + i, 0, 0, NULL);
> +	vdev->num_ext_irqs = 0;
> +	kfree(vdev->ext_irqs);
> +	vdev->ext_irqs = NULL;
> +
>  	/* Device closed, don't need mutex here */
>  	list_for_each_entry_safe(ioeventfd, ioeventfd_tmp,
>  				 &vdev->ioeventfds_list, next) {
> @@ -823,6 +831,9 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device
> *vdev, int irq_type)
>  			return 1;
>  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
>  		return 1;
> +	} else if (irq_type >= VFIO_PCI_NUM_IRQS &&
> +		   irq_type < VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs) {
> +		return 1;
>  	}
> 
>  	return 0;
> @@ -1008,7 +1019,7 @@ static long vfio_pci_ioctl(void *device_data,
>  			info.flags |= VFIO_DEVICE_FLAGS_RESET;
> 
>  		info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
> -		info.num_irqs = VFIO_PCI_NUM_IRQS;
> +		info.num_irqs = VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs;
> 
>  		if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV)) {
>  			int ret = vfio_pci_info_zdev_add_caps(vdev, &caps);
> @@ -1187,36 +1198,87 @@ static long vfio_pci_ioctl(void *device_data,
> 
>  	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
>  		struct vfio_irq_info info;
> +		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> +		unsigned long capsz;
> 
>  		minsz = offsetofend(struct vfio_irq_info, count);
> 
> +		/* For backward compatibility, cannot require this */
> +		capsz = offsetofend(struct vfio_irq_info, cap_offset);
> +
>  		if (copy_from_user(&info, (void __user *)arg, minsz))
>  			return -EFAULT;
> 
> -		if (info.argsz < minsz || info.index >= VFIO_PCI_NUM_IRQS)
> +		if (info.argsz < minsz ||
> +			info.index >= VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs)
>  			return -EINVAL;
> 
> -		switch (info.index) {
> -		case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
> -		case VFIO_PCI_REQ_IRQ_INDEX:
> -			break;
> -		case VFIO_PCI_ERR_IRQ_INDEX:
> -			if (pci_is_pcie(vdev->pdev))
> -				break;
> -			fallthrough;
> -		default:
> -			return -EINVAL;
> -		}
> +		if (info.argsz >= capsz)
> +			minsz = capsz;
> 
>  		info.flags = VFIO_IRQ_INFO_EVENTFD;
> 
> -		info.count = vfio_pci_get_irq_count(vdev, info.index);
> -
> -		if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
> +		switch (info.index) {
> +		case VFIO_PCI_INTX_IRQ_INDEX:
>  			info.flags |= (VFIO_IRQ_INFO_MASKABLE |
>  				       VFIO_IRQ_INFO_AUTOMASKED);
> -		else
> +			break;
> +		case VFIO_PCI_MSI_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
> +		case VFIO_PCI_REQ_IRQ_INDEX:
>  			info.flags |= VFIO_IRQ_INFO_NORESIZE;
> +			break;
> +		case VFIO_PCI_ERR_IRQ_INDEX:
> +			info.flags |= VFIO_IRQ_INFO_NORESIZE;
> +			if (!pci_is_pcie(vdev->pdev))
> +				return -EINVAL;
> +			break;
> +		default:
> +		{
> +			struct vfio_irq_info_cap_type cap_type = {
> +				.header.id = VFIO_IRQ_INFO_CAP_TYPE,
> +				.header.version = 1 };
> +			int ret, i;
> +
> +			if (info.index >= VFIO_PCI_NUM_IRQS +
> +						vdev->num_ext_irqs)
> +				return -EINVAL;
> +			info.index = array_index_nospec(info.index,
> +							VFIO_PCI_NUM_IRQS +
> +							vdev->num_ext_irqs);
> +			i = info.index - VFIO_PCI_NUM_IRQS;
> +
> +			info.flags = vdev->ext_irqs[i].flags;
> +			cap_type.type = vdev->ext_irqs[i].type;
> +			cap_type.subtype = vdev->ext_irqs[i].subtype;
> +
> +			ret = vfio_info_add_capability(&caps,
> +					&cap_type.header,
> +					sizeof(cap_type));
> +			if (ret)
> +				return ret;
> +		}
> +		}
> +
> +		info.count = vfio_pci_get_irq_count(vdev, info.index);
> +
> +		if (caps.size) {
> +			info.flags |= VFIO_IRQ_INFO_FLAG_CAPS;
> +			if (info.argsz < sizeof(info) + caps.size) {
> +				info.argsz = sizeof(info) + caps.size;
> +				info.cap_offset = 0;
> +			} else {
> +				vfio_info_cap_shift(&caps, sizeof(info));
> +				if (copy_to_user((void __user *)arg +
> +						  sizeof(info), caps.buf,
> +						  caps.size)) {
> +					kfree(caps.buf);
> +					return -EFAULT;
> +				}
> +				info.cap_offset = sizeof(info);
> +			}
> +
> +			kfree(caps.buf);
> +		}
> 
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
> @@ -1235,7 +1297,8 @@ static long vfio_pci_ioctl(void *device_data,
>  		max = vfio_pci_get_irq_count(vdev, hdr.index);
> 
>  		ret = vfio_set_irqs_validate_and_prepare(&hdr, max,
> -						 VFIO_PCI_NUM_IRQS, &data_size);
> +				VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs,
> +				&data_size);
>  		if (ret)
>  			return ret;
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 869dce5f134d..1e785a5f5fb2 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -19,6 +19,7 @@
>  #include <linux/vfio.h>
>  #include <linux/wait.h>
>  #include <linux/slab.h>
> +#include <linux/nospec.h>
> 
>  #include "vfio_pci_private.h"
> 
> @@ -635,6 +636,24 @@ static int vfio_pci_set_req_trigger(struct
> vfio_pci_device *vdev,
>  					       count, flags, data);
>  }
> 
> +static int vfio_pci_set_ext_irq_trigger(struct vfio_pci_device *vdev,
> +					unsigned int index, unsigned int start,
> +					unsigned int count, uint32_t flags,
> +					void *data)
> +{
> +	int i;
> +
> +	if (start != 0 || count > 1)
> +		return -EINVAL;

It looks like we need to add ! vdev->num_ext_irqs check above
as the vdev->ext_irqs is allocated for "nested" case only.

Thanks to qubingbing for reporting the below crash,

[ 5034.902114] Unable to handle kernel paging request at virtual address ffffffffffffff98
[ 5034.927645] Mem abort info:
...
[ 5035.088409] pc : vfio_pci_set_ctx_trigger_single+0x2c/0x108 [vfio_pci]
[ 5035.102140] lr : vfio_pci_set_ext_irq_trigger+0x84/0xa0 [vfio_pci]
...
[ 5035.289655] Call trace:
[ 5035.294796]  vfio_pci_set_ctx_trigger_single+0x2c/0x108 [vfio_pci]
[ 5035.307795]  vfio_pci_set_ext_irq_trigger+0x84/0xa0 [vfio_pci]
[ 5035.320062]  vfio_pci_set_irqs_ioctl+0xf0/0x120 [vfio_pci]
[ 5035.331601]  vfio_pci_disable+0x60/0x4e0 [vfio_pci]
[ 5035.341859]  vfio_pci_release+0x74/0xb0 [vfio_pci]

This is observed when the Guest is launched without vsmmu and then "poweroff".

estuary:/home/vsmmu$ ./qemu-system-aarch64_vsmmu5.20 \
> -machine virt,gic-version=3 \
> -cpu host \
> -smp 1 \
> -m 1024 \
> -kernel Image_vsmmu  \
> -initrd rootfs_vsmmu.cpio.gz  \
> -device vfio-pci,host=7d:01.0,id=net0 \
> -net none  \
> -nographic -D -d -enable-kvm   \
> -append "rdinit=init console=ttyAMA0 ealycon=pl0ll,0x90000000"

estuary:/$ poweroff

Could you please take a look.

Thanks,
Shameer
 

> +	index = array_index_nospec(index,
> +				   VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs);
> +	i = index - VFIO_PCI_NUM_IRQS;
> +
> +	return vfio_pci_set_ctx_trigger_single(&vdev->ext_irqs[i].trigger,
> +					       count, flags, data);
> +}
> +
>  int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
>  			    unsigned index, unsigned start, unsigned count,
>  			    void *data)
> @@ -684,6 +703,13 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device
> *vdev, uint32_t flags,
>  			break;
>  		}
>  		break;
> +	default:
> +		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> +		case VFIO_IRQ_SET_ACTION_TRIGGER:
> +			func = vfio_pci_set_ext_irq_trigger;
> +			break;
> +		}
> +		break;
>  	}
> 
>  	if (!func)
> @@ -691,3 +717,39 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device
> *vdev, uint32_t flags,
> 
>  	return func(vdev, index, start, count, flags, data);
>  }
> +
> +int vfio_pci_get_ext_irq_index(struct vfio_pci_device *vdev,
> +			       unsigned int type, unsigned int subtype)
> +{
> +	int i;
> +
> +	for (i = 0; i <  vdev->num_ext_irqs; i++) {
> +		if (vdev->ext_irqs[i].type == type &&
> +		    vdev->ext_irqs[i].subtype == subtype) {
> +			return i;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +int vfio_pci_register_irq(struct vfio_pci_device *vdev,
> +			  unsigned int type, unsigned int subtype,
> +			  u32 flags)
> +{
> +	struct vfio_ext_irq *ext_irqs;
> +
> +	ext_irqs = krealloc(vdev->ext_irqs,
> +			    (vdev->num_ext_irqs + 1) * sizeof(*ext_irqs),
> +			    GFP_KERNEL);
> +	if (!ext_irqs)
> +		return -ENOMEM;
> +
> +	vdev->ext_irqs = ext_irqs;
> +
> +	vdev->ext_irqs[vdev->num_ext_irqs].type = type;
> +	vdev->ext_irqs[vdev->num_ext_irqs].subtype = subtype;
> +	vdev->ext_irqs[vdev->num_ext_irqs].flags = flags;
> +	vdev->ext_irqs[vdev->num_ext_irqs].trigger = NULL;
> +	vdev->num_ext_irqs++;
> +	return 0;
> +}
> diff --git a/drivers/vfio/pci/vfio_pci_private.h
> b/drivers/vfio/pci/vfio_pci_private.h
> index 1d9b0f648133..e180b5435c8f 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -77,6 +77,13 @@ struct vfio_pci_region {
>  	u32				flags;
>  };
> 
> +struct vfio_ext_irq {
> +	u32				type;
> +	u32				subtype;
> +	u32				flags;
> +	struct eventfd_ctx		*trigger;
> +};
> +
>  struct vfio_pci_dummy_resource {
>  	struct resource		resource;
>  	int			index;
> @@ -111,6 +118,8 @@ struct vfio_pci_device {
>  	struct vfio_pci_irq_ctx	*ctx;
>  	int			num_ctx;
>  	int			irq_type;
> +	struct vfio_ext_irq	*ext_irqs;
> +	int			num_ext_irqs;
>  	int			num_regions;
>  	struct vfio_pci_region	*region;
>  	u8			msi_qmax;
> @@ -154,6 +163,11 @@ struct vfio_pci_device {
> 
>  extern void vfio_pci_intx_mask(struct vfio_pci_device *vdev);
>  extern void vfio_pci_intx_unmask(struct vfio_pci_device *vdev);
> +extern int vfio_pci_register_irq(struct vfio_pci_device *vdev,
> +				 unsigned int type, unsigned int subtype,
> +				 u32 flags);
> +extern int vfio_pci_get_ext_irq_index(struct vfio_pci_device *vdev,
> +				      unsigned int type, unsigned int subtype);
> 
>  extern int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev,
>  				   uint32_t flags, unsigned index,
> --
> 2.21.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
