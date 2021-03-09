Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6B499332B6E
	for <lists+kvmarm@lfdr.de>; Tue,  9 Mar 2021 17:06:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 00BD14B2EF;
	Tue,  9 Mar 2021 11:06:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0WQPkL0tiZsU; Tue,  9 Mar 2021 11:06:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B5834B4F0;
	Tue,  9 Mar 2021 11:06:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 63A674B2CB
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 11:06:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nA2yL7oQYn1m for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Mar 2021 11:06:27 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 070094B2C4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 11:06:27 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6523E1042;
 Tue,  9 Mar 2021 08:06:26 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606873F71B;
 Tue,  9 Mar 2021 08:06:25 -0800 (PST)
Subject: Re: [PATCH kvmtool v2 22/22] hw/rtc: ARM/arm64: Use MMIO at higher
 addresses
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20210225005915.26423-1-andre.przywara@arm.com>
 <20210225005915.26423-23-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <606d032e-d1f1-257f-eb1c-c471f2f20935@arm.com>
Date: Tue, 9 Mar 2021 16:06:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210225005915.26423-23-andre.przywara@arm.com>
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

On 2/25/21 12:59 AM, Andre Przywara wrote:
> Using the RTC device at its legacy I/O address as set by IBM in 1981
> was a kludge we used for simplicity on ARM platforms as well.
> However this imposes problems due to their missing alignment and overlap
> with the PCI I/O address space.
>
> Now that we can switch a device easily between using ioports and
> MMIO, let's move the RTC out of the first 4K of memory on ARM platforms.
>
> That should be transparent for well behaved guests, since the change is
> naturally reflected in the device tree.

Everything looks correct, compile tested for arm64 and x86-64. Also grep'ed for
0x70 (device ioport address) and DEVICE_BUS_IOPORT, no occurrence in the file
other than in the defines:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/include/arm-common/kvm-arch.h |  3 +++
>  hw/rtc.c                          | 24 ++++++++++++++++--------
>  2 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
> index 633ea8fa..02100c48 100644
> --- a/arm/include/arm-common/kvm-arch.h
> +++ b/arm/include/arm-common/kvm-arch.h
> @@ -31,6 +31,9 @@
>  #define ARM_UART_MMIO_BASE	ARM_MMIO_AREA
>  #define ARM_UART_MMIO_SIZE	0x10000
>  
> +#define ARM_RTC_MMIO_BASE	(ARM_UART_MMIO_BASE + ARM_UART_MMIO_SIZE)
> +#define ARM_RTC_MMIO_SIZE	0x10000
> +
>  #define KVM_FLASH_MMIO_BASE	(ARM_MMIO_AREA + 0x1000000)
>  #define KVM_FLASH_MAX_SIZE	0x1000000
>  
> diff --git a/hw/rtc.c b/hw/rtc.c
> index ee4c9102..aec31c52 100644
> --- a/hw/rtc.c
> +++ b/hw/rtc.c
> @@ -5,6 +5,15 @@
>  
>  #include <time.h>
>  
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +#define RTC_BUS_TYPE		DEVICE_BUS_MMIO
> +#define RTC_BASE_ADDRESS	ARM_RTC_MMIO_BASE
> +#else
> +/* PORT 0070-007F - CMOS RAM/RTC (REAL TIME CLOCK) */
> +#define RTC_BUS_TYPE		DEVICE_BUS_IOPORT
> +#define RTC_BASE_ADDRESS	0x70
> +#endif
> +
>  /*
>   * MC146818 RTC registers
>   */
> @@ -49,7 +58,7 @@ static void cmos_ram_io(struct kvm_cpu *vcpu, u64 addr, u8 *data,
>  	time_t ti;
>  
>  	if (is_write) {
> -		if (addr == 0x70) {	/* index register */
> +		if (addr == RTC_BASE_ADDRESS) {	/* index register */
>  			u8 value = ioport__read8(data);
>  
>  			vcpu->kvm->nmi_disabled	= value & (1UL << 7);
> @@ -70,7 +79,7 @@ static void cmos_ram_io(struct kvm_cpu *vcpu, u64 addr, u8 *data,
>  		return;
>  	}
>  
> -	if (addr == 0x70)
> +	if (addr == RTC_BASE_ADDRESS)	/* index register is write-only */
>  		return;
>  
>  	time(&ti);
> @@ -127,7 +136,7 @@ static void generate_rtc_fdt_node(void *fdt,
>  							    u8 irq,
>  							    enum irq_type))
>  {
> -	u64 reg_prop[2] = { cpu_to_fdt64(0x70), cpu_to_fdt64(2) };
> +	u64 reg_prop[2] = { cpu_to_fdt64(RTC_BASE_ADDRESS), cpu_to_fdt64(2) };
>  
>  	_FDT(fdt_begin_node(fdt, "rtc"));
>  	_FDT(fdt_property_string(fdt, "compatible", "motorola,mc146818"));
> @@ -139,7 +148,7 @@ static void generate_rtc_fdt_node(void *fdt,
>  #endif
>  
>  struct device_header rtc_dev_hdr = {
> -	.bus_type = DEVICE_BUS_IOPORT,
> +	.bus_type = RTC_BUS_TYPE,
>  	.data = generate_rtc_fdt_node,
>  };
>  
> @@ -151,8 +160,8 @@ int rtc__init(struct kvm *kvm)
>  	if (r < 0)
>  		return r;
>  
> -	/* PORT 0070-007F - CMOS RAM/RTC (REAL TIME CLOCK) */
> -	r = kvm__register_pio(kvm, 0x0070, 2, cmos_ram_io, NULL);
> +	r = kvm__register_iotrap(kvm, RTC_BASE_ADDRESS, 2, cmos_ram_io, NULL,
> +				 RTC_BUS_TYPE);
>  	if (r < 0)
>  		goto out_device;
>  
> @@ -170,8 +179,7 @@ dev_init(rtc__init);
>  
>  int rtc__exit(struct kvm *kvm)
>  {
> -	/* PORT 0070-007F - CMOS RAM/RTC (REAL TIME CLOCK) */
> -	kvm__deregister_pio(kvm, 0x0070);
> +	kvm__deregister_iotrap(kvm, RTC_BASE_ADDRESS, RTC_BUS_TYPE);
>  
>  	return 0;
>  }
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
