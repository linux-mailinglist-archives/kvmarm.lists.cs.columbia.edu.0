Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 28A292F34FB
	for <lists+kvmarm@lfdr.de>; Tue, 12 Jan 2021 17:04:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A671B4B229;
	Tue, 12 Jan 2021 11:04:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zWEJ9aIsVczZ; Tue, 12 Jan 2021 11:04:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 830004B21B;
	Tue, 12 Jan 2021 11:04:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 60B1A4B1DD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Jan 2021 11:04:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HmPZxounpk6 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Jan 2021 11:04:20 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 138AF4B198
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Jan 2021 11:04:20 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1DD51FB;
 Tue, 12 Jan 2021 08:04:19 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29ADD3F719;
 Tue, 12 Jan 2021 08:04:18 -0800 (PST)
Subject: Re: [PATCH 7/9] KVM: arm64: Simplify argument passing to
 vgic_uaccess_[read|write]
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com
References: <20201212185010.26579-1-eric.auger@redhat.com>
 <20201212185010.26579-8-eric.auger@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <ee2ec95e-4262-a364-b037-c43f3d396760@arm.com>
Date: Tue, 12 Jan 2021 16:04:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201212185010.26579-8-eric.auger@redhat.com>
Content-Language: en-US
Cc: shuah@kernel.org, pbonzini@redhat.com
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

On 12/12/20 6:50 PM, Eric Auger wrote:
> Instead of converting the vgic_io_device handle to a kvm_io_device
> handled and then do the oppositive, pass a vgic_io_device pointer all
> along the call chain.

To me, it looks like the commit message describes what the patch does instead of
why it does it.

What are "vgic_io_device handle" and "kvm_io_device handled"?

Thanks,
Alex
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arch/arm64/kvm/vgic/vgic-mmio.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
> index b2d73fc0d1ef..48c6067fc5ec 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio.c
> @@ -938,10 +938,9 @@ vgic_get_mmio_region(struct kvm_vcpu *vcpu, struct vgic_io_device *iodev,
>  	return region;
>  }
>  
> -static int vgic_uaccess_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
> +static int vgic_uaccess_read(struct kvm_vcpu *vcpu, struct vgic_io_device *iodev,
>  			     gpa_t addr, u32 *val)
>  {
> -	struct vgic_io_device *iodev = kvm_to_vgic_iodev(dev);
>  	const struct vgic_register_region *region;
>  	struct kvm_vcpu *r_vcpu;
>  
> @@ -960,10 +959,9 @@ static int vgic_uaccess_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>  	return 0;
>  }
>  
> -static int vgic_uaccess_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
> +static int vgic_uaccess_write(struct kvm_vcpu *vcpu, struct vgic_io_device *iodev,
>  			      gpa_t addr, const u32 *val)
>  {
> -	struct vgic_io_device *iodev = kvm_to_vgic_iodev(dev);
>  	const struct vgic_register_region *region;
>  	struct kvm_vcpu *r_vcpu;
>  
> @@ -986,9 +984,9 @@ int vgic_uaccess(struct kvm_vcpu *vcpu, struct vgic_io_device *dev,
>  		 bool is_write, int offset, u32 *val)
>  {
>  	if (is_write)
> -		return vgic_uaccess_write(vcpu, &dev->dev, offset, val);
> +		return vgic_uaccess_write(vcpu, dev, offset, val);
>  	else
> -		return vgic_uaccess_read(vcpu, &dev->dev, offset, val);
> +		return vgic_uaccess_read(vcpu, dev, offset, val);
>  }
>  
>  static int dispatch_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
