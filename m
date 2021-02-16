Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4518F31CBC4
	for <lists+kvmarm@lfdr.de>; Tue, 16 Feb 2021 15:22:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5464A4B5D7;
	Tue, 16 Feb 2021 09:22:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-cj7inSanIO; Tue, 16 Feb 2021 09:22:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF2214B5DB;
	Tue, 16 Feb 2021 09:22:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 94B744B5CE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 09:22:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Ubnn36OCICA for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Feb 2021 09:22:01 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AB714B4FC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 09:22:01 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E120A31B;
 Tue, 16 Feb 2021 06:22:00 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E571D3F694;
 Tue, 16 Feb 2021 06:21:59 -0800 (PST)
Subject: Re: [PATCH kvmtool 13/21] hw/serial: Refactor trap handler
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
 <20201210142908.169597-14-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <5c91e8f2-7bdf-4c4a-1da3-08dac79fd9a4@arm.com>
Date: Tue, 16 Feb 2021 14:22:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201210142908.169597-14-andre.przywara@arm.com>
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

Patch looks good, nitpicks below.

On 12/10/20 2:29 PM, Andre Przywara wrote:
> With the planned retirement of the special ioport emulation code, we
> need to provide an emulation function compatible with the MMIO prototype.
>
> Adjust the trap handler to use that new function, and provide shims to
> implement the old ioport interface, for now.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  hw/serial.c | 97 +++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 65 insertions(+), 32 deletions(-)
>
> diff --git a/hw/serial.c b/hw/serial.c
> index b0465d99..2907089c 100644
> --- a/hw/serial.c
> +++ b/hw/serial.c
> @@ -242,36 +242,31 @@ void serial8250__inject_sysrq(struct kvm *kvm, char sysrq)
>  	sysrq_pending = sysrq;
>  }
>  
> -static bool serial8250_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port,
> -			   void *data, int size)
> +static bool serial8250_out(struct serial8250_device *dev, struct kvm_cpu *vcpu,
> +			   u16 offset, u8 data)
>  {
> -	struct serial8250_device *dev = ioport->priv;
> -	u16 offset;
>  	bool ret = true;
> -	char *addr = data;
>  
>  	mutex_lock(&dev->mutex);
>  
> -	offset = port - dev->iobase;
> -
>  	switch (offset) {
>  	case UART_TX:
>  		if (dev->lcr & UART_LCR_DLAB) {
> -			dev->dll = ioport__read8(data);
> +			dev->dll = data;
>  			break;
>  		}
>  
>  		/* Loopback mode */
>  		if (dev->mcr & UART_MCR_LOOP) {
>  			if (dev->rxcnt < FIFO_LEN) {
> -				dev->rxbuf[dev->rxcnt++] = *addr;
> +				dev->rxbuf[dev->rxcnt++] = data;
>  				dev->lsr |= UART_LSR_DR;
>  			}
>  			break;
>  		}
>  
>  		if (dev->txcnt < FIFO_LEN) {
> -			dev->txbuf[dev->txcnt++] = *addr;
> +			dev->txbuf[dev->txcnt++] = data;
>  			dev->lsr &= ~UART_LSR_TEMT;
>  			if (dev->txcnt == FIFO_LEN / 2)
>  				dev->lsr &= ~UART_LSR_THRE;
> @@ -283,18 +278,18 @@ static bool serial8250_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port
>  		break;
>  	case UART_IER:
>  		if (!(dev->lcr & UART_LCR_DLAB))
> -			dev->ier = ioport__read8(data) & 0x0f;
> +			dev->ier = data & 0x0f;
>  		else
> -			dev->dlm = ioport__read8(data);
> +			dev->dlm = data;
>  		break;
>  	case UART_FCR:
> -		dev->fcr = ioport__read8(data);
> +		dev->fcr = data;
>  		break;
>  	case UART_LCR:
> -		dev->lcr = ioport__read8(data);
> +		dev->lcr = data;
>  		break;
>  	case UART_MCR:
> -		dev->mcr = ioport__read8(data);
> +		dev->mcr = data;
>  		break;
>  	case UART_LSR:
>  		/* Factory test */
> @@ -303,7 +298,7 @@ static bool serial8250_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port
>  		/* Not used */
>  		break;
>  	case UART_SCR:
> -		dev->scr = ioport__read8(data);
> +		dev->scr = data;
>  		break;
>  	default:
>  		ret = false;
> @@ -336,46 +331,43 @@ static void serial8250_rx(struct serial8250_device *dev, void *data)
>  	}
>  }
>  
> -static bool serial8250_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> +static bool serial8250_in(struct serial8250_device *dev, struct kvm_cpu *vcpu,
> +			  u16 offset, u8 *data)
>  {
> -	struct serial8250_device *dev = ioport->priv;
> -	u16 offset;
>  	bool ret = true;
>  
>  	mutex_lock(&dev->mutex);
>  
> -	offset = port - dev->iobase;
> -
>  	switch (offset) {
>  	case UART_RX:
>  		if (dev->lcr & UART_LCR_DLAB)
> -			ioport__write8(data, dev->dll);
> +			*data = dev->dll;
>  		else
>  			serial8250_rx(dev, data);
>  		break;
>  	case UART_IER:
>  		if (dev->lcr & UART_LCR_DLAB)
> -			ioport__write8(data, dev->dlm);
> +			*data = dev->dlm;
>  		else
> -			ioport__write8(data, dev->ier);
> +			*data = dev->ier;
>  		break;
>  	case UART_IIR:
> -		ioport__write8(data, dev->iir | UART_IIR_TYPE_BITS);
> +		*data = dev->iir | UART_IIR_TYPE_BITS;
>  		break;
>  	case UART_LCR:
> -		ioport__write8(data, dev->lcr);
> +		*data = dev->lcr;
>  		break;
>  	case UART_MCR:
> -		ioport__write8(data, dev->mcr);
> +		*data = dev->mcr;
>  		break;
>  	case UART_LSR:
> -		ioport__write8(data, dev->lsr);
> +		*data = dev->lsr;
>  		break;
>  	case UART_MSR:
> -		ioport__write8(data, dev->msr);
> +		*data = dev->msr;
>  		break;
>  	case UART_SCR:
> -		ioport__write8(data, dev->scr);
> +		*data = dev->scr;
>  		break;
>  	default:
>  		ret = false;
> @@ -389,6 +381,47 @@ static bool serial8250_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port,
>  	return ret;
>  }
>  
> +static void serial8250_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> +			    u8 is_write, void *ptr)
> +{
> +	struct serial8250_device *dev = ptr;
> +	u8 value = 0;
> +
> +	if (is_write) {
> +		 value = *data;

Extra space before value.

> +
> +		serial8250_out(dev, vcpu, addr - dev->iobase, value);
> +	} else {
> +		if (serial8250_in(dev, vcpu, addr - dev->iobase, &value))
> +			*data = value;
> +	}
> +}
> +
> +static bool serial8250_ioport_out(struct ioport *ioport, struct kvm_cpu *vcpu,
> +				  u16 port, void *data, int size)
> +{
> +	struct serial8250_device *dev = ioport->priv;
> +	u8 value = ioport__read8(data);
> +
> +	serial8250_mmio(vcpu, port, &value, 1, true, dev);
> +
> +	return true;
> +}
> +
> +static bool serial8250_ioport_in(struct ioport *ioport, struct kvm_cpu *vcpu,
> +				 u16 port, void *data, int size)
> +{
> +	struct serial8250_device *dev = ioport->priv;
> +	u8 value = 0;
> +
> +
> +	serial8250_mmio(vcpu, port, &value, 1, false, dev);
> +
> +	ioport__write8(data, value);

This is correct, but confusing. You pass the address of a local variable as *data
to serial8250_mmio, serial8250_mmio conditionally updates the value at data (which
is &value from here), and then here we update the *data unconditionally. Why not
pass data directly to serial8250_mmio and skip the local variable? Am I missing
something?

Thanks,

Alex

> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_HAS_LIBFDT
>  
>  char *fdt_stdout_path = NULL;
> @@ -427,8 +460,8 @@ void serial8250_generate_fdt_node(void *fdt, struct device_header *dev_hdr,
>  #endif
>  
>  static struct ioport_operations serial8250_ops = {
> -	.io_in			= serial8250_in,
> -	.io_out			= serial8250_out,
> +	.io_in			= serial8250_ioport_in,
> +	.io_out			= serial8250_ioport_out,
>  };
>  
>  static int serial8250__device_init(struct kvm *kvm,
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
