Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1E73633B29A
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 13:26:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C5E5C4B511;
	Mon, 15 Mar 2021 08:26:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-OmtnnKwyYK; Mon, 15 Mar 2021 08:26:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5980A4B522;
	Mon, 15 Mar 2021 08:26:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A7D54B4FE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 08:26:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mD6b7j5czoo4 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 08:26:44 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DAE14B47A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 08:26:44 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87ABD6E;
 Mon, 15 Mar 2021 05:26:43 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AE0F3F792;
 Mon, 15 Mar 2021 05:26:42 -0700 (PDT)
Date: Mon, 15 Mar 2021 12:26:20 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH kvmtool v2 09/22] x86/ioport: Switch to new trap handlers
Message-ID: <20210315122620.1b30415e@slackpad.fritz.box>
In-Reply-To: <fb420e89-da92-2100-a12c-475152ff30d4@arm.com>
References: <20210225005915.26423-1-andre.przywara@arm.com>
 <20210225005915.26423-10-andre.przywara@arm.com>
 <fb420e89-da92-2100-a12c-475152ff30d4@arm.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Sami Mujawar <sami.mujawar@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On Tue, 9 Mar 2021 12:09:52 +0000
Alexandru Elisei <alexandru.elisei@arm.com> wrote:

> Hi Andre,
> 
> On 2/25/21 12:59 AM, Andre Przywara wrote:
> > Now that the x86 I/O ports have trap handlers adhering to the MMIO fault
> > handler prototype, let's switch over to the joint registration routine.
> >
> > This allows us to get rid of the ioport shim routines.
> >
> > Since the debug output was done in ioport.c, we would lose this
> > functionality when moving over to the MMIO handlers. So bring this back
> > here explicitly, by introducing debug_mmio().
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  x86/ioport.c | 102 +++++++++++++++++++--------------------------------
> >  1 file changed, 37 insertions(+), 65 deletions(-)
> >
> > diff --git a/x86/ioport.c b/x86/ioport.c
> > index 78f9a863..9fcbb6c9 100644
> > --- a/x86/ioport.c
> > +++ b/x86/ioport.c
> > @@ -3,21 +3,35 @@
> >  #include <stdlib.h>
> >  #include <stdio.h>
> >  
> > -static void dummy_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> > +static void debug_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> >  		       u8 is_write, void *ptr)  
> 
> Since the function is about ioports (it even checks cfg.ioport_debug), shouldn't
> something like debug_io/debug_pio/debug_ioport/<something else ioport related> be
> more appropriate?

Yes, I changed the function to debug_io(), to be in line with the other
functions and the names in the other devices.

> Otherwise looks good: the only emulation callback that could fail was
> debug_ops->debug_io_out, which triggered a print if cfg.ioport_debug was set, and
> the callback is replaced by debug_mmio. With the name change:
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks!

Andre

> >  {
> > +	if (!vcpu->kvm->cfg.ioport_debug)
> > +		return;
> > +
> > +	fprintf(stderr, "debug port %s from VCPU%lu: port=0x%lx, size=%u",
> > +		is_write ? "write" : "read", vcpu->cpu_id,
> > +		(unsigned long)addr, len);
> > +	if (is_write) {
> > +		u32 value;
> > +
> > +		switch (len) {
> > +		case 1: value = ioport__read8(data); break;
> > +		case 2: value = ioport__read16((u16*)data); break;
> > +		case 4: value = ioport__read32((u32*)data); break;
> > +		default: value = 0; break;
> > +		}
> > +		fprintf(stderr, ", data: 0x%x\n", value);
> > +	} else {
> > +		fprintf(stderr, "\n");
> > +	}
> >  }
> >  
> > -static bool debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> > +static void dummy_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> > +		       u8 is_write, void *ptr)
> >  {
> > -	dummy_mmio(vcpu, port, data, size, true, NULL);
> > -	return 0;
> >  }
> >  
> > -static struct ioport_operations debug_ops = {
> > -	.io_out		= debug_io_out,
> > -};
> > -
> >  static void seabios_debug_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data,
> >  			       u32 len, u8 is_write, void *ptr)
> >  {
> > @@ -31,37 +45,6 @@ static void seabios_debug_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data,
> >  	putchar(ch);
> >  }
> >  
> > -static bool seabios_debug_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> > -{
> > -	seabios_debug_mmio(vcpu, port, data, size, true, NULL);
> > -	return 0;
> > -}
> > -
> > -static struct ioport_operations seabios_debug_ops = {
> > -	.io_out		= seabios_debug_io_out,
> > -};
> > -
> > -static bool dummy_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> > -{
> > -	dummy_mmio(vcpu, port, data, size, false, NULL);
> > -	return true;
> > -}
> > -
> > -static bool dummy_io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> > -{
> > -	dummy_mmio(vcpu, port, data, size, true, NULL);
> > -	return true;
> > -}
> > -
> > -static struct ioport_operations dummy_read_write_ioport_ops = {
> > -	.io_in		= dummy_io_in,
> > -	.io_out		= dummy_io_out,
> > -};
> > -
> > -static struct ioport_operations dummy_write_only_ioport_ops = {
> > -	.io_out		= dummy_io_out,
> > -};
> > -
> >  /*
> >   * The "fast A20 gate"
> >   */
> > @@ -76,17 +59,6 @@ static void ps2_control_mmio(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> >  		ioport__write8(data, 0x02);
> >  }
> >  
> > -static bool ps2_control_a_io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> > -{
> > -	ps2_control_mmio(vcpu, port, data, size, false, NULL);
> > -	return true;
> > -}
> > -
> > -static struct ioport_operations ps2_control_a_ops = {
> > -	.io_in		= ps2_control_a_io_in,
> > -	.io_out		= dummy_io_out,
> > -};
> > -
> >  void ioport__map_irq(u8 *irq)
> >  {
> >  }
> > @@ -98,75 +70,75 @@ static int ioport__setup_arch(struct kvm *kvm)
> >  	/* Legacy ioport setup */
> >  
> >  	/* 0000 - 001F - DMA1 controller */
> > -	r = ioport__register(kvm, 0x0000, &dummy_read_write_ioport_ops, 32, NULL);
> > +	r = kvm__register_pio(kvm, 0x0000, 32, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* 0x0020 - 0x003F - 8259A PIC 1 */
> > -	r = ioport__register(kvm, 0x0020, &dummy_read_write_ioport_ops, 2, NULL);
> > +	r = kvm__register_pio(kvm, 0x0020, 2, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* PORT 0040-005F - PIT - PROGRAMMABLE INTERVAL TIMER (8253, 8254) */
> > -	r = ioport__register(kvm, 0x0040, &dummy_read_write_ioport_ops, 4, NULL);
> > +	r = kvm__register_pio(kvm, 0x0040, 4, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* 0092 - PS/2 system control port A */
> > -	r = ioport__register(kvm, 0x0092, &ps2_control_a_ops, 1, NULL);
> > +	r = kvm__register_pio(kvm, 0x0092, 1, ps2_control_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* 0x00A0 - 0x00AF - 8259A PIC 2 */
> > -	r = ioport__register(kvm, 0x00A0, &dummy_read_write_ioport_ops, 2, NULL);
> > +	r = kvm__register_pio(kvm, 0x00A0, 2, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* 00C0 - 001F - DMA2 controller */
> > -	r = ioport__register(kvm, 0x00C0, &dummy_read_write_ioport_ops, 32, NULL);
> > +	r = kvm__register_pio(kvm, 0x00c0, 32, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* PORT 00E0-00EF are 'motherboard specific' so we use them for our
> >  	   internal debugging purposes.  */
> > -	r = ioport__register(kvm, IOPORT_DBG, &debug_ops, 1, NULL);
> > +	r = kvm__register_pio(kvm, IOPORT_DBG, 1, debug_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* PORT 00ED - DUMMY PORT FOR DELAY??? */
> > -	r = ioport__register(kvm, 0x00ED, &dummy_write_only_ioport_ops, 1, NULL);
> > +	r = kvm__register_pio(kvm, 0x00ed, 1, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* 0x00F0 - 0x00FF - Math co-processor */
> > -	r = ioport__register(kvm, 0x00F0, &dummy_write_only_ioport_ops, 2, NULL);
> > +	r = kvm__register_pio(kvm, 0x00f0, 2, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* PORT 0278-027A - PARALLEL PRINTER PORT (usually LPT1, sometimes LPT2) */
> > -	r = ioport__register(kvm, 0x0278, &dummy_read_write_ioport_ops, 3, NULL);
> > +	r = kvm__register_pio(kvm, 0x0278, 3, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* PORT 0378-037A - PARALLEL PRINTER PORT (usually LPT2, sometimes LPT3) */
> > -	r = ioport__register(kvm, 0x0378, &dummy_read_write_ioport_ops, 3, NULL);
> > +	r = kvm__register_pio(kvm, 0x0378, 3, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* PORT 03D4-03D5 - COLOR VIDEO - CRT CONTROL REGISTERS */
> > -	r = ioport__register(kvm, 0x03D4, &dummy_read_write_ioport_ops, 1, NULL);
> > +	r = kvm__register_pio(kvm, 0x03d4, 1, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> > -	r = ioport__register(kvm, 0x03D5, &dummy_write_only_ioport_ops, 1, NULL);
> > +	r = kvm__register_pio(kvm, 0x03d5, 1, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> > -	r = ioport__register(kvm, 0x402, &seabios_debug_ops, 1, NULL);
> > +	r = kvm__register_pio(kvm, 0x0402, 1, seabios_debug_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >  
> >  	/* 0510 - QEMU BIOS configuration register */
> > -	r = ioport__register(kvm, 0x510, &dummy_read_write_ioport_ops, 2, NULL);
> > +	r = kvm__register_pio(kvm, 0x0510, 2, dummy_mmio, NULL);
> >  	if (r < 0)
> >  		return r;
> >    

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
