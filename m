Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2239F31CC6E
	for <lists+kvmarm@lfdr.de>; Tue, 16 Feb 2021 15:52:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A76FA4B636;
	Tue, 16 Feb 2021 09:52:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E9d+YE6k72do; Tue, 16 Feb 2021 09:52:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 507EA4B61E;
	Tue, 16 Feb 2021 09:52:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C58A14B2B2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 09:52:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4zQVCG9n+GnQ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Feb 2021 09:52:55 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B65434B289
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 09:52:55 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D8431B;
 Tue, 16 Feb 2021 06:52:55 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3677B3F694;
 Tue, 16 Feb 2021 06:52:54 -0800 (PST)
Subject: Re: [PATCH kvmtool 16/21] vfio: Switch to new ioport trap handlers
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
 <20201210142908.169597-17-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <797e9b63-2e0b-b2b0-f291-97f722f4a64d@arm.com>
Date: Tue, 16 Feb 2021 14:52:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201210142908.169597-17-andre.przywara@arm.com>
Content-Language: en-US
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

Hi Andre,

Looks good, _vfio_ioport_{in,out} could have been renamed to vfio_ioport_{in,out},
but it's fine either way:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

On 12/10/20 2:29 PM, Andre Przywara wrote:
> Now that the vfio device has a trap handler adhering to the MMIO fault
> handler prototype, let's switch over to the joint registration routine.
>
> This allows us to get rid of the ioport shim routines.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  vfio/core.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/vfio/core.c b/vfio/core.c
> index f55f1f87..10919101 100644
> --- a/vfio/core.c
> +++ b/vfio/core.c
> @@ -160,25 +160,6 @@ static void vfio_ioport_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
>  		_vfio_ioport_in(region, offset, data, len);
>  }
>  
> -static bool vfio_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
> -			    u16 port, void *data, int len)
> -{
> -	vfio_ioport_mmio(vcpu, port, data, len, true, ioport->priv);
> -	return true;
> -}
> -
> -static bool vfio_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
> -			   u16 port, void *data, int len)
> -{
> -	vfio_ioport_mmio(vcpu, port, data, len, false, ioport->priv);
> -	return true;
> -}
> -
> -static struct ioport_operations vfio_ioport_ops = {
> -	.io_in	= vfio_ioport_in,
> -	.io_out	= vfio_ioport_out,
> -};
> -
>  static void vfio_mmio_access(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
>  			     u8 is_write, void *ptr)
>  {
> @@ -223,9 +204,11 @@ static int vfio_setup_trap_region(struct kvm *kvm, struct vfio_device *vdev,
>  				  struct vfio_region *region)
>  {
>  	if (region->is_ioport) {
> -		int port = ioport__register(kvm, region->port_base,
> -					   &vfio_ioport_ops, region->info.size,
> -					   region);
> +		int port;
> +
> +		port = kvm__register_pio(kvm, region->port_base,
> +					 region->info.size, vfio_ioport_mmio,
> +					 region);
>  		if (port < 0)
>  			return port;
>  		return 0;
> @@ -292,7 +275,7 @@ void vfio_unmap_region(struct kvm *kvm, struct vfio_region *region)
>  		munmap(region->host_addr, region->info.size);
>  		region->host_addr = NULL;
>  	} else if (region->is_ioport) {
> -		ioport__unregister(kvm, region->port_base);
> +		kvm__deregister_pio(kvm, region->port_base);
>  	} else {
>  		kvm__deregister_mmio(kvm, region->guest_phys_addr);
>  	}
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
