Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD631E87D
	for <lists+kvmarm@lfdr.de>; Thu, 18 Feb 2021 11:35:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D44564B3D6;
	Thu, 18 Feb 2021 05:35:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XE1-s-MaCxFJ; Thu, 18 Feb 2021 05:35:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E9D14B3CE;
	Thu, 18 Feb 2021 05:35:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2868F4B397
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Feb 2021 05:35:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KD8HifhRPjUz for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Feb 2021 05:35:24 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C97424B38E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Feb 2021 05:35:24 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42CAFED1;
 Thu, 18 Feb 2021 02:35:24 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9D03F73B;
 Thu, 18 Feb 2021 02:35:22 -0800 (PST)
Date: Thu, 18 Feb 2021 10:34:25 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH kvmtool 06/21] hw/i8042: Refactor trap handler
Message-ID: <20210218103425.26a27000@slackpad.fritz.box>
In-Reply-To: <288df0e8-997c-7691-2dda-017876dba3f4@arm.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
 <20201210142908.169597-7-andre.przywara@arm.com>
 <288df0e8-997c-7691-2dda-017876dba3f4@arm.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 11 Feb 2021 17:23:13 +0000
Alexandru Elisei <alexandru.elisei@arm.com> wrote:

> Hi Andre,
> 
> On 12/10/20 2:28 PM, Andre Przywara wrote:
> > With the planned retirement of the special ioport emulation code, we
> > need to provide an emulation function compatible with the MMIO
> > prototype.
> >
> > Adjust the trap handler to use that new function, and provide shims to
> > implement the old ioport interface, for now.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  hw/i8042.c | 68 +++++++++++++++++++++++++++---------------------------
> >  1 file changed, 34 insertions(+), 34 deletions(-)
> >
> > diff --git a/hw/i8042.c b/hw/i8042.c
> > index 36ee183f..eb1f9d28 100644
> > --- a/hw/i8042.c
> > +++ b/hw/i8042.c
> > @@ -292,52 +292,52 @@ static void kbd_reset(void)
> >  	};
> >  }
> >  
> > -/*
> > - * Called when the OS has written to one of the keyboard's ports (0x60 or 0x64)
> > - */
> > -static bool kbd_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> > +static void kbd_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
> > +		   u8 is_write, void *ptr)
> >  {
> > -	switch (port) {
> > -	case I8042_COMMAND_REG: {
> > -		u8 value = kbd_read_status();
> > -		ioport__write8(data, value);
> > +	u8 value;
> > +
> > +	if (is_write)
> > +		value = ioport__read8(data);
> > +
> > +	switch (addr) {
> > +	case I8042_COMMAND_REG:
> > +		if (is_write)
> > +			kbd_write_command(vcpu->kvm, value);
> > +		else
> > +			value = kbd_read_status();
> >  		break;
> > -	}
> > -	case I8042_DATA_REG: {
> > -		u8 value = kbd_read_data();
> > -		ioport__write8(data, value);
> > +	case I8042_DATA_REG:
> > +		if (is_write)
> > +			kbd_write_data(value);
> > +		else
> > +			value = kbd_read_data();
> >  		break;
> > -	}
> > -	case I8042_PORT_B_REG: {
> > -		ioport__write8(data, 0x20);
> > +	case I8042_PORT_B_REG:
> > +		if (!is_write)
> > +			value = 0x20;
> >  		break;
> > -	}
> >  	default:
> > -		return false;
> > +		return;  
> 
> Any particular reason for removing the false return value? I don't see it
> mentioned in the commit message. Otherwise this is identical to the two functions
> it replaces.

Because the MMIO handler prototype is void, in contrast to the PIO one.
Since on returning "false" we only seem to panic kvmtool, this is of
quite limited use, I'd say.

> >  	}
> >  
> > +	if (!is_write)
> > +		ioport__write8(data, value);
> > +}
> > +
> > +/*
> > + * Called when the OS has written to one of the keyboard's ports (0x60 or 0x64)
> > + */
> > +static bool kbd_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> > +{
> > +	kbd_io(vcpu, port, data, size, false, NULL);  
> 
> is_write is an u8, not a bool.

Right, will fix this.

> I never could wrap my head around the ioport convention of "in" (read) and "out"
> (write). To be honest, changing is_write changed to an enum so it's crystal clear
> what is happening would help with that a lot, but I guess that's a separate patch.

"in" and "out" are the x86 assembly mnemonics, but it's indeed
confusing, because the device side has a different view (CPU "in" means
pushing data "out" of the device). I usually look at the code to see
what it's actually meant to do.
So yeah, I feel like a lot of those device emulations could use
some update. but that's indeed something for another day.

Cheers,
Andre

> > +
> >  	return true;
> >  }
> >  
> >  static bool kbd_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
> >  {
> > -	switch (port) {
> > -	case I8042_COMMAND_REG: {
> > -		u8 value = ioport__read8(data);
> > -		kbd_write_command(vcpu->kvm, value);
> > -		break;
> > -	}
> > -	case I8042_DATA_REG: {
> > -		u8 value = ioport__read8(data);
> > -		kbd_write_data(value);
> > -		break;
> > -	}
> > -	case I8042_PORT_B_REG: {
> > -		break;
> > -	}
> > -	default:
> > -		return false;
> > -	}
> > +	kbd_io(vcpu, port, data, size, true, NULL);
> >  
> >  	return true;
> >  }  

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
