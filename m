Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 43751321CA4
	for <lists+kvmarm@lfdr.de>; Mon, 22 Feb 2021 17:19:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD2554B16B;
	Mon, 22 Feb 2021 11:19:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGwxv2qNofj9; Mon, 22 Feb 2021 11:19:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A2814B153;
	Mon, 22 Feb 2021 11:19:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DE6234B153
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Feb 2021 11:19:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpILFV7sFBZN for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Feb 2021 11:19:44 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B99F4B0FE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Feb 2021 11:19:44 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 211ED1FB;
 Mon, 22 Feb 2021 08:19:44 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265383F73B;
 Mon, 22 Feb 2021 08:19:43 -0800 (PST)
Subject: Re: [PATCH kvmtool 07/21] hw/i8042: Switch to new trap handlers
To: Andre Przywara <andre.przywara@arm.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
 <20201210142908.169597-8-andre.przywara@arm.com>
 <a995ed28-27c0-888c-c3d4-ecb70c08a13e@arm.com>
 <20210218120902.630dcb2b@slackpad.fritz.box>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <908c3706-75b8-b03e-4c01-88072d02696e@arm.com>
Date: Mon, 22 Feb 2021 16:19:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218120902.630dcb2b@slackpad.fritz.box>
Content-Language: en-US
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

Hi Andre,

On 2/18/21 12:09 PM, Andre Przywara wrote:
> On Fri, 12 Feb 2021 10:41:20 +0000
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
> Hi,
>
>> On 12/10/20 2:28 PM, Andre Przywara wrote:
>>> Now that the PC keyboard has a trap handler adhering to the MMIO fault
>>> handler prototype, let's switch over to the joint registration routine.
>>>
>>> This allows us to get rid of the ioport shim routines.
>>>
>>> Make the kbd_init() function static on the way.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>  hw/i8042.c          | 30 ++++--------------------------
>>>  include/kvm/i8042.h |  1 -
>>>  2 files changed, 4 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/hw/i8042.c b/hw/i8042.c
>>> index eb1f9d28..91d79dc4 100644
>>> --- a/hw/i8042.c
>>> +++ b/hw/i8042.c
>>> @@ -325,40 +325,18 @@ static void kbd_io(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
>>>  		ioport__write8(data, value);
>>>  }
>>>  
>>> -/*
>>> - * Called when the OS has written to one of the keyboard's ports (0x60 or 0x64)
>>> - */
>>> -static bool kbd_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
>>> -{
>>> -	kbd_io(vcpu, port, data, size, false, NULL);
>>> -
>>> -	return true;
>>> -}
>>> -
>>> -static bool kbd_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
>>> -{
>>> -	kbd_io(vcpu, port, data, size, true, NULL);
>>> -
>>> -	return true;
>>> -}
>>> -
>>> -static struct ioport_operations kbd_ops = {
>>> -	.io_in		= kbd_in,
>>> -	.io_out		= kbd_out,
>>> -};
>>> -
>>> -int kbd__init(struct kvm *kvm)
>>> +static int kbd__init(struct kvm *kvm)
>>>  {
>>>  	int r;
>>>  
>>>  	kbd_reset();
>>>  	state.kvm = kvm;
>>> -	r = ioport__register(kvm, I8042_DATA_REG, &kbd_ops, 2, NULL);
>>> +	r = kvm__register_pio(kvm, I8042_DATA_REG, 2, kbd_io, NULL);  
>> I guess you are registering two addresses here to cover I8042_PORT_B_REG, right?
>> Might be worth a comment.
> I am registering two ports because the original code did, and I didn't
> dare to touch this. I guess we put this on the wishlist for the device
> emulation fixup series? ;-)
>
> Maybe the intention was to just *reserve* those ports?

Considering that I8042_DATA_REG = 0x60 and I8042_PORT_B_REG = 0x61, and the
emulation handlers handle both of them, I'm pretty sure the intention was to
reserve memory to cover both ports.

>
>>>  	if (r < 0)
>>>  		return r;
>>> -	r = ioport__register(kvm, I8042_COMMAND_REG, &kbd_ops, 2, NULL);
>>> +	r = kvm__register_pio(kvm, I8042_COMMAND_REG, 2, kbd_io, NULL);  
>> Shouldn't length be 1? The emulation should work only for address 0x64
>> (command/status register), right? Or am I missing something?
> I don't think you are, same as above. Maybe some weird guest is using
> half-word accesses (outw)?

I think you're right, let's not mess with the device emulation right now, after
all that's not the purpose of the series. And I'm fairly confident you know more
about the device and the x86 architecture than me, so I'll trust your judgement on
this.

Thanks,

Alex

>
> Cheers,
> Andre
>
>
>> Thanks,
>>
>> Alex
>>
>>>  	if (r < 0) {
>>> -		ioport__unregister(kvm, I8042_DATA_REG);
>>> +		kvm__deregister_pio(kvm, I8042_DATA_REG);
>>>  		return r;
>>>  	}
>>>  
>>> diff --git a/include/kvm/i8042.h b/include/kvm/i8042.h
>>> index 3b4ab688..cd4ae6bb 100644
>>> --- a/include/kvm/i8042.h
>>> +++ b/include/kvm/i8042.h
>>> @@ -7,6 +7,5 @@ struct kvm;
>>>  
>>>  void mouse_queue(u8 c);
>>>  void kbd_queue(u8 c);
>>> -int kbd__init(struct kvm *kvm);
>>>  
>>>  #endif  
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
