Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D98F18CC1C
	for <lists+kvmarm@lfdr.de>; Wed, 14 Aug 2019 08:54:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 370B04A542;
	Wed, 14 Aug 2019 02:54:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4TVYn6jDGse; Wed, 14 Aug 2019 02:54:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC22E4A53B;
	Wed, 14 Aug 2019 02:54:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 63A6F4A52F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Aug 2019 02:54:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zi2whWcFWAOX for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Aug 2019 02:54:20 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A61E14A4AA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Aug 2019 02:54:20 -0400 (EDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 90E81FB5E09DDF8FBDBD;
 Wed, 14 Aug 2019 14:54:16 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 14 Aug 2019
 14:54:06 +0800
Subject: Re: Can we boot a 512U kvm guest?
To: Marc Zyngier <marc.zyngier@arm.com>
References: <86aa9609-7dc9-1461-ae47-f50897cd0875@huawei.com>
 <86d0h9no9j.wl-marc.zyngier@arm.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <1685337f-fc4e-c783-638c-a764270b8006@huawei.com>
Date: Wed, 14 Aug 2019 14:51:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <86d0h9no9j.wl-marc.zyngier@arm.com>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, qemu-arm@nongnu.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2019/8/13 22:17, Marc Zyngier wrote:
> On Tue, 13 Aug 2019 09:50:27 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
> Hi Zenghui,
> 
>>
>> Hi folks,
>>
>> Since commit e25028c8ded0 ("KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to
>> 512"), we seemed to be allowed to boot a 512U guest.  But I failed to
>> start it up with the latest QEMU.  I guess there are at least *two*
>> reasons (limitations).
>>
>> First I got a QEMU abort:
>> 	"kvm_set_irq: Invalid argument"
>>
>> Enable the trace_kvm_irq_line() under debugfs, when it comed with
>> vcpu-256, I got:
>> 	"Inject UNKNOWN interrupt (3), vcpu->idx: 0, num: 23, level: 0"
>> and kvm_vm_ioctl_irq_line() returns -EINVAL to user-space...
>>
>> So the thing is that we only have 8 bits for vcpu_index field ([23:16])
>> in KVM_IRQ_LINE ioctl.  irq_type field will be corrupted if we inject a
>> PPI to vcpu-256, whose vcpu_index will take 9 bits.
> 
> Irk. Not great indeed. Clearly, we have a couple of holes in the way
> we test these ABI changes (/me eyes Eric...).
> 
>>
>> I temporarily patched the KVM and QEMU with the following diff:
>>
>> ---8<---
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h
>> b/arch/arm64/include/uapi/asm/kvm.h
>> index 95516a4..39a0fb1 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -325,10 +325,10 @@ struct kvm_vcpu_events {
>>   #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
>>
>>   /* KVM_IRQ_LINE irq field index values */
>> -#define KVM_ARM_IRQ_TYPE_SHIFT		24
>> -#define KVM_ARM_IRQ_TYPE_MASK		0xff
>> +#define KVM_ARM_IRQ_TYPE_SHIFT		28
>> +#define KVM_ARM_IRQ_TYPE_MASK		0xf
>>   #define KVM_ARM_IRQ_VCPU_SHIFT		16
>> -#define KVM_ARM_IRQ_VCPU_MASK		0xff
>> +#define KVM_ARM_IRQ_VCPU_MASK		0xfff
>>   #define KVM_ARM_IRQ_NUM_SHIFT		0
>>   #define KVM_ARM_IRQ_NUM_MASK		0xffff
>>
>> ---8<---
>>
>> It makes things a bit better, it also immediately BREAKs the api with
>> old versions.
> 
> Yes, and we can't have that (specially if you consider that this API
> is shared between 32 and 64bit). One "get out of jail card" is to
> steal a few bits from the top of the word, and encode things there:
> 
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index 4602464ebdfb..86db092e4c2f 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -254,8 +254,10 @@ struct kvm_vcpu_events {
>   #define   KVM_DEV_ARM_ITS_CTRL_RESET		4
>   
>   /* KVM_IRQ_LINE irq field index values */
> +#define KVM_ARM_IRQ_VCPU2_SHIFT		28
> +#define KVM_ARM_IRQ_VCPU2_MASK		0xf
>   #define KVM_ARM_IRQ_TYPE_SHIFT		24
> -#define KVM_ARM_IRQ_TYPE_MASK		0xff
> +#define KVM_ARM_IRQ_TYPE_MASK		0xf
>   #define KVM_ARM_IRQ_VCPU_SHIFT		16
>   #define KVM_ARM_IRQ_VCPU_MASK		0xff
>   #define KVM_ARM_IRQ_NUM_SHIFT		0
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 7b7ac0f6cec9..44cb25bfc95e 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -308,8 +308,10 @@ struct kvm_vcpu_events {
>   #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
>   
>   /* KVM_IRQ_LINE irq field index values */
> +#define KVM_ARM_IRQ_VCPU2_SHIFT		28
> +#define KVM_ARM_IRQ_VCPU2_MASK		0xf
>   #define KVM_ARM_IRQ_TYPE_SHIFT		24
> -#define KVM_ARM_IRQ_TYPE_MASK		0xff
> +#define KVM_ARM_IRQ_TYPE_MASK		0xf
>   #define KVM_ARM_IRQ_VCPU_SHIFT		16
>   #define KVM_ARM_IRQ_VCPU_MASK		0xff
>   #define KVM_ARM_IRQ_NUM_SHIFT		0
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 90cedebaeb94..fb685c1c0514 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -889,6 +889,7 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
>   
>   	irq_type = (irq >> KVM_ARM_IRQ_TYPE_SHIFT) & KVM_ARM_IRQ_TYPE_MASK;
>   	vcpu_idx = (irq >> KVM_ARM_IRQ_VCPU_SHIFT) & KVM_ARM_IRQ_VCPU_MASK;
> +	vcpu_idx += ((irq >> KVM_ARM_IRQ_VCPU2_SHIFT) & KVM_ARM_IRQ_VCPU2_MASK) * (KVM_ARM_IRQ_VCPU_MASK + 1);
>   	irq_num = (irq >> KVM_ARM_IRQ_NUM_SHIFT) & KVM_ARM_IRQ_NUM_MASK;
>   
>   	trace_kvm_irq_line(irq_type, vcpu_idx, irq_num, irq_level->level);
> 
> It should work because we've been careful not to allow value outside
> of {0, 1, 2} for irq_type. I don't like it, but I really don't feel
> like adding another IRQ related ioctl. We still have 16 irq types
> (which is already a waste of space), and we can go up to 4096 vcpu.

Hi Marc,

Thanks for this. I can test it on my machine once user-space agrees with
this change.

> Peter, what do you think?
> 
>> Next comes one more QEMU abort (with the "fix" above):
>> 	"Failed to set device address: No space left on device"
>>
>> We register two io devices (rd_dev and sgi_dev) on KVM_MMIO_BUS for
>> each redistributor. 512 vcpus take 1024 io devices, which is beyond the
>> maximum limitation of the current kernel - NR_IOBUS_DEVS (1000).
>> So we get a ENOSPC error here.
> 
> I can reproduce that issue here ("499 vcpus on my Chromebook,
> baby"). Not an ABI problem though, and we can bump it up if that's
> needed.
> 
>> I don't know if the similar problems have been discussed before in ML.
>> Is it time to really support the 512U guest?
> 
> The real question is "why the hell would you want to do that?" ;-)
> Seriously, I'm very interested in finding out what is the use case for
> these gigantic VMs, other than debugging the kernel for big machines.

To be honest, I haven't seen any use case yet. In a typical production
environment, *I think* we will not let the guest to have more CPUs than
the host (and currently the maximum we have for host is 128).

(It's just that someone complained that "why can't I start a VM with the
  max supported number of vcpus", and I started investigating yesterday.)


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
