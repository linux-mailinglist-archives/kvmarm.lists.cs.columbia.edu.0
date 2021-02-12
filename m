Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 268A2319D1E
	for <lists+kvmarm@lfdr.de>; Fri, 12 Feb 2021 12:14:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AB7DE4B4C3;
	Fri, 12 Feb 2021 06:14:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C658DQGlSLuu; Fri, 12 Feb 2021 06:14:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74E364B4B8;
	Fri, 12 Feb 2021 06:14:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B71804B491
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Feb 2021 06:14:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c-WRMBBLnrqN for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Feb 2021 06:14:24 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CD204B466
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Feb 2021 06:14:24 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB1D6113E;
 Fri, 12 Feb 2021 03:14:23 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D91A53F719;
 Fri, 12 Feb 2021 03:14:22 -0800 (PST)
Subject: Re: [PATCH kvmtool 08/21] x86/ioport: Refactor trap handlers
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
 <20201210142908.169597-9-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <9089a68a-39ca-5047-24da-f1e2c1d52d22@arm.com>
Date: Fri, 12 Feb 2021 11:14:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201210142908.169597-9-andre.przywara@arm.com>
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

On 12/10/20 2:28 PM, Andre Przywara wrote:
> With the planned retirement of the special ioport emulation code, we
> need to provide emulation functions compatible with the MMIO
> prototype.
>
> Adjust the trap handlers to use that new function, and provide shims to
> implement the old ioport interface, for now.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  x86/ioport.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/x86/ioport.c b/x86/ioport.c
> index 8c5c7699..932da20a 100644
> --- a/x86/ioport.c
> +++ b/x86/ioport.c
> @@ -3,8 +3,14 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  
> +static void dummy_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> +		       u8 is_write, void *ptr)
> +{
> +}
> +
>  static bool debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
>  {
> +	dummy_mmio(vcpu, port, data, size, true, NULL);
>  	return 0;
>  }
>  
> @@ -12,15 +18,23 @@ static struct ioport_operations debug_ops = {
>  	.io_out		= debug_io_out,
>  };
>  
> -static bool seabios_debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> +static void seabios_debug_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data,
> +			       u32 len, u8 is_write, void *ptr)
>  {
>  	char ch;
>  
> +	if (!is_write)
> +		return;
> +
>  	ch = ioport__read8(data);
>  
>  	putchar(ch);
> +}
>  
> -	return true;
> +static bool seabios_debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> +{
> +	seabios_debug_mmio(vcpu, port, data, size, true, NULL);
> +	return 0;
>  }
>  
>  static struct ioport_operations seabios_debug_ops = {
> @@ -29,11 +43,13 @@ static struct ioport_operations seabios_debug_ops = {
>  
>  static bool dummy_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
>  {
> +	dummy_mmio(vcpu, port, data, size, false, NULL);
>  	return true;
>  }
>  
>  static bool dummy_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
>  {
> +	dummy_mmio(vcpu, port, data, size, true, NULL);
>  	return true;
>  }
>  
> @@ -50,13 +66,19 @@ static struct ioport_operations dummy_write_only_ioport_ops = {
>   * The "fast A20 gate"
>   */
>  
> -static bool ps2_control_a_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> +static void ps2_control_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> +			     u8 is_write, void *ptr)
>  {
>  	/*
>  	 * A20 is always enabled.
>  	 */
> -	ioport__write8(data, 0x02);
> +	if (!is_write)
> +		ioport__write8(data, 0x02);
> +}
>  
> +static bool ps2_control_a_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> +{
> +	ps2_control_mmio(vcpu, port, data, size, false, NULL);
>  	return true;
>  }
>  

Looks correct to me, if not particularly pretty; thankfully the next patch removes
all of these dummy functions. It compiles, so:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
