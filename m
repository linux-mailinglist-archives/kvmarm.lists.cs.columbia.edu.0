Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D83CE332B5A
	for <lists+kvmarm@lfdr.de>; Tue,  9 Mar 2021 17:02:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 68E0F4B533;
	Tue,  9 Mar 2021 11:02:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mLg07LGXHw7; Tue,  9 Mar 2021 11:02:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9C114B4F7;
	Tue,  9 Mar 2021 11:01:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A1CA4B4D6
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 11:01:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iAwZrdcoYTTI for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Mar 2021 11:01:56 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E488A4B4BB
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 11:01:55 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E1E61042;
 Tue,  9 Mar 2021 08:01:55 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59CE83F71B;
 Tue,  9 Mar 2021 08:01:54 -0800 (PST)
Subject: Re: [PATCH kvmtool v2 21/22] hw/serial: ARM/arm64: Use MMIO at higher
 addresses
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20210225005915.26423-1-andre.przywara@arm.com>
 <20210225005915.26423-22-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <cac73e1d-7240-695e-5769-78f191429621@arm.com>
Date: Tue, 9 Mar 2021 16:02:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210225005915.26423-22-andre.przywara@arm.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, Sami Mujawar <sami.mujawar@arm.com>,
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

I think you forgot to change the way the address is generated in
serial8250_generate_fdt_node, it's still KVM_IOPORT_AREA + dev->iobase. It's
technically correct, as KVM_IOPORT_AREA == ARM_IOPORT_AREA == 0x0, but very
confusing (and prone to breakage is something changes in the memory layout).

One more comment below.

On 2/25/21 12:59 AM, Andre Przywara wrote:
> Using the UART devices at their legacy I/O addresses as set by IBM in
> 1981 was a kludge we used for simplicity on ARM platforms as well.
> However this imposes problems due to their missing alignment and overlap
> with the PCI I/O address space.
>
> Now that we can switch a device easily between using ioports and MMIO,
> let's move the UARTs out of the first 4K of memory on ARM platforms.
>
> That should be transparent for well behaved guests, since the change is
> naturally reflected in the device tree. Even "earlycon" keeps working,
> as the stdout-path property is adjusted automatically.
>
> People providing direct earlycon parameters via the command line need to
> adjust it to: "earlycon=uart,mmio,0x1000000".
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/include/arm-common/kvm-arch.h |  3 +++
>  hw/serial.c                       | 45 ++++++++++++++++++++-----------
>  2 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
> index b12255b0..633ea8fa 100644
> --- a/arm/include/arm-common/kvm-arch.h
> +++ b/arm/include/arm-common/kvm-arch.h
> @@ -28,6 +28,9 @@
>  #define ARM_IOPORT_SIZE		(1U << 16)
>  
>  
> +#define ARM_UART_MMIO_BASE	ARM_MMIO_AREA
> +#define ARM_UART_MMIO_SIZE	0x10000
> +
>  #define KVM_FLASH_MMIO_BASE	(ARM_MMIO_AREA + 0x1000000)
>  #define KVM_FLASH_MAX_SIZE	0x1000000
>  
> diff --git a/hw/serial.c b/hw/serial.c
> index 4be188a1..1854add2 100644
> --- a/hw/serial.c
> +++ b/hw/serial.c
> @@ -13,6 +13,17 @@
>  
>  #include <pthread.h>
>  
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +#define serial_iobase(nr)	(ARM_UART_MMIO_BASE + (nr) * 0x1000)
> +#define serial_irq(nr)		(32 + (nr))
> +#define SERIAL8250_BUS_TYPE	DEVICE_BUS_MMIO
> +#else
> +#define serial_iobase(nr)	((((nr) & 1) ? 0x200 : 0x300) +	\
> +				 ((nr) >= 2 ? 0xe8 : 0xf8))
> +#define serial_irq(nr)		(((nr) & 1) ? 3 : 4)

Those two defines are hard to read, is there a reason for changing them from v1?
They looked a lot more readable in v1.

Thanks,

Alex

> +#define SERIAL8250_BUS_TYPE	DEVICE_BUS_IOPORT
> +#endif
> +
>  /*
>   * This fakes a U6_16550A. The fifo len needs to be 64 as the kernel
>   * expects that for autodetection.
> @@ -27,7 +38,7 @@ struct serial8250_device {
>  	struct mutex		mutex;
>  	u8			id;
>  
> -	u16			iobase;
> +	u32			iobase;
>  	u8			irq;
>  	u8			irq_state;
>  	int			txcnt;
> @@ -65,56 +76,56 @@ static struct serial8250_device devices[] = {
>  	/* ttyS0 */
>  	[0]	= {
>  		.dev_hdr = {
> -			.bus_type	= DEVICE_BUS_IOPORT,
> +			.bus_type	= SERIAL8250_BUS_TYPE,
>  			.data		= serial8250_generate_fdt_node,
>  		},
>  		.mutex			= MUTEX_INITIALIZER,
>  
>  		.id			= 0,
> -		.iobase			= 0x3f8,
> -		.irq			= 4,
> +		.iobase			= serial_iobase(0),
> +		.irq			= serial_irq(0),
>  
>  		SERIAL_REGS_SETTING
>  	},
>  	/* ttyS1 */
>  	[1]	= {
>  		.dev_hdr = {
> -			.bus_type	= DEVICE_BUS_IOPORT,
> +			.bus_type	= SERIAL8250_BUS_TYPE,
>  			.data		= serial8250_generate_fdt_node,
>  		},
>  		.mutex			= MUTEX_INITIALIZER,
>  
>  		.id			= 1,
> -		.iobase			= 0x2f8,
> -		.irq			= 3,
> +		.iobase			= serial_iobase(1),
> +		.irq			= serial_irq(1),
>  
>  		SERIAL_REGS_SETTING
>  	},
>  	/* ttyS2 */
>  	[2]	= {
>  		.dev_hdr = {
> -			.bus_type	= DEVICE_BUS_IOPORT,
> +			.bus_type	= SERIAL8250_BUS_TYPE,
>  			.data		= serial8250_generate_fdt_node,
>  		},
>  		.mutex			= MUTEX_INITIALIZER,
>  
>  		.id			= 2,
> -		.iobase			= 0x3e8,
> -		.irq			= 4,
> +		.iobase			= serial_iobase(2),
> +		.irq			= serial_irq(2),
>  
>  		SERIAL_REGS_SETTING
>  	},
>  	/* ttyS3 */
>  	[3]	= {
>  		.dev_hdr = {
> -			.bus_type	= DEVICE_BUS_IOPORT,
> +			.bus_type	= SERIAL8250_BUS_TYPE,
>  			.data		= serial8250_generate_fdt_node,
>  		},
>  		.mutex			= MUTEX_INITIALIZER,
>  
>  		.id			= 3,
> -		.iobase			= 0x2e8,
> -		.irq			= 3,
> +		.iobase			= serial_iobase(3),
> +		.irq			= serial_irq(3),
>  
>  		SERIAL_REGS_SETTING
>  	},
> @@ -439,7 +450,8 @@ static int serial8250__device_init(struct kvm *kvm,
>  		return r;
>  
>  	ioport__map_irq(&dev->irq);
> -	r = kvm__register_pio(kvm, dev->iobase, 8, serial8250_mmio, dev);
> +	r = kvm__register_iotrap(kvm, dev->iobase, 8, serial8250_mmio, dev,
> +				 SERIAL8250_BUS_TYPE);
>  
>  	return r;
>  }
> @@ -462,7 +474,7 @@ cleanup:
>  	for (j = 0; j <= i; j++) {
>  		struct serial8250_device *dev = &devices[j];
>  
> -		kvm__deregister_pio(kvm, dev->iobase);
> +		kvm__deregister_iotrap(kvm, dev->iobase, SERIAL8250_BUS_TYPE);
>  		device__unregister(&dev->dev_hdr);
>  	}
>  
> @@ -478,7 +490,8 @@ int serial8250__exit(struct kvm *kvm)
>  	for (i = 0; i < ARRAY_SIZE(devices); i++) {
>  		struct serial8250_device *dev = &devices[i];
>  
> -		r = kvm__deregister_pio(kvm, dev->iobase);
> +		r = kvm__deregister_iotrap(kvm, dev->iobase,
> +					   SERIAL8250_BUS_TYPE);
>  		if (r < 0)
>  			return r;
>  		device__unregister(&dev->dev_hdr);
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
