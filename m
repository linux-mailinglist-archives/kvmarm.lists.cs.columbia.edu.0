Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D168F1C593
	for <lists+kvmarm@lfdr.de>; Tue, 14 May 2019 11:02:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ABAA4A4F6;
	Tue, 14 May 2019 05:02:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRABRGlx7HIh; Tue, 14 May 2019 05:02:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3592F4A4E9;
	Tue, 14 May 2019 05:02:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B42A14A418
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 May 2019 05:02:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I2akZBwu3mNl for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 May 2019 05:02:44 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0DFFF4A417
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 May 2019 05:02:44 -0400 (EDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3FDCEC449AF04FC2B0DD;
 Tue, 14 May 2019 17:02:40 +0800 (CST)
Received: from [127.0.0.1] (10.67.78.74) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
 17:02:29 +0800
Subject: Re: [RFC] Question about enable doorbell irq and halt_poll process
From: "Tangnianyao (ICT)" <tangnianyao@huawei.com>
To: Marc Zyngier <marc.zyngier@arm.com>
References: <0fb3c9ba-8428-ea6c-2973-952624f601cc@huawei.com>
 <20190320170219.510f2e1e@why.wild-wind.fr.eu.org>
 <5df934fd-06d5-55f2-68a5-6f4985e4ac1b@huawei.com>
 <86zhpc66jl.wl-marc.zyngier@arm.com>
 <e32d81ed-d1f5-ce0b-7845-d4b680d556df@huawei.com>
 <86imvu3uje.wl-marc.zyngier@arm.com>
 <6547b80a-f0c1-b74e-f37f-59c1ad96c8b3@huawei.com>
 <861s1tavn0.wl-marc.zyngier@arm.com>
 <5910533f-c6ac-6350-370f-bd218bba3fd8@huawei.com>
Message-ID: <53a525e5-c9a7-0d98-ff7a-ca5be0ea381a@huawei.com>
Date: Tue, 14 May 2019 17:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5910533f-c6ac-6350-370f-bd218bba3fd8@huawei.com>
X-Originating-IP: [10.67.78.74]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 xuwei5@huawei.com, guoheyi@huawei.com, kvmarm@lists.cs.columbia.edu
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



On 2019/4/29 10:29, Tangnianyao (ICT) wrote:

Hi, Marc

> On 2019/4/23 18:00, Marc Zyngier wrote:
> 
> Hi, Marc
> 
>> On Tue, 23 Apr 2019 08:44:17 +0100,
>> "Tangnianyao (ICT)" <tangnianyao@huawei.com> wrote:
>>>
>>> Hi, Marc
>>
>> [...]
>>
>>> I've learned that there's some implementation problem for the PCIe
>>> controller of Hi1616, the processor of D05. The PCIe ACS was not
>>> implemented properly and D05 doesn't support VM using pcie vf.
>>
>> My D05 completely disagrees with you:
>>
>> root@unassigned-hostname:~# lspci -v
>> 00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
>> 	Subsystem: Red Hat, Inc QEMU PCIe Host bridge
>> 	Flags: fast devsel
>> lspci: Unable to load libkmod resources: error -12
>>
>> 00:01.0 Ethernet controller: Red Hat, Inc Virtio network device (rev 01)
>> 	Subsystem: Red Hat, Inc Virtio network device
>> 	Flags: bus master, fast devsel, latency 0, IRQ 40
>> 	Memory at 10040000 (32-bit, non-prefetchable) [size=4K]
>> 	Memory at 8000000000 (64-bit, prefetchable) [size=16K]
>> 	Expansion ROM at 10000000 [disabled] [size=256K]
>> 	Capabilities: [98] MSI-X: Enable+ Count=3 Masked-
>> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
>> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
>> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
>> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
>> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
>> 	Kernel driver in use: virtio-pci
>>
>> 00:02.0 SCSI storage controller: Red Hat, Inc Virtio block device (rev 01)
>> 	Subsystem: Red Hat, Inc Virtio block device
>> 	Flags: bus master, fast devsel, latency 0, IRQ 41
>> 	Memory at 10041000 (32-bit, non-prefetchable) [size=4K]
>> 	Memory at 8000004000 (64-bit, prefetchable) [size=16K]
>> 	Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
>> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
>> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
>> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
>> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
>> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
>> 	Kernel driver in use: virtio-pci
>>
>> 00:03.0 SCSI storage controller: Red Hat, Inc Virtio SCSI (rev 01)
>> 	Subsystem: Red Hat, Inc Virtio SCSI
>> 	Flags: bus master, fast devsel, latency 0, IRQ 42
>> 	Memory at 10042000 (32-bit, non-prefetchable) [size=4K]
>> 	Memory at 8000008000 (64-bit, prefetchable) [size=16K]
>> 	Capabilities: [98] MSI-X: Enable+ Count=4 Masked-
>> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
>> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
>> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
>> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
>> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
>> 	Kernel driver in use: virtio-pci
>>
>> 00:04.0 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
>> 	Subsystem: Intel Corporation I350 Ethernet Controller Virtual Function
>> 	Flags: bus master, fast devsel, latency 0
>> 	Memory at 800000c000 (64-bit, prefetchable) [size=16K]
>> 	Memory at 8000010000 (64-bit, prefetchable) [size=16K]
>> 	Capabilities: [70] MSI-X: Enable+ Count=3 Masked-
>> 	Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [1a0] Transaction Processing Hints
>> 	Capabilities: [1d0] Access Control Services
>> 	Kernel driver in use: igbvf
>>
>> root@unassigned-hostname:~# uptime
>>  05:40:45 up 27 days, 17:16,  1 user,  load average: 4.10, 4.05, 4.01
>>
> 
> I have make a new quirk to fix ACS problem on Hi1616, to enable VM using
> pcie vf.
> 
>> For something that isn't supposed to work, it is pretty good. So
>> please test it and let me know how it fares. At this stage, not
>> regressing deployed HW is more important than improving the situation
>> on HW that nobody has.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> Compared to default halt_poll_ns, 500000ns, enabling doorbells is not
>>>>>>> large at all.
>>>>>>
>>>>>> Sure. But I'm not sure this is a universal figure.
>>>>>>
>>>>>>>
>>>>>>>> Frankly, you want to be careful with that. I'd rather enable them late
>>>>>>>> and have a chance of not blocking because of another (virtual)
>>>>>>>> interrupt, which saves us the doorbell business.
>>>>>>>>
>>>>>>>> I wonder if you wouldn't be in a better position by drastically
>>>>>>>> reducing halt_poll_ns for vcpu that can have directly injected
>>>>>>>> interrupts.
>>>>>>>>
>>>>>>>
>>>>>>> If we set halt_poll_ns to a small value, the chance of
>>>>>>> not blocking and vcpu scheduled out becomes larger. The cost
>>>>>>> of vcpu scheduled out is quite expensive.
>>>>>>> In many cases, one pcpu is assigned to only
>>>>>>> one vcpu, and halt_poll_ns is set quite large, to increase
>>>>>>> chance of halt_poll process got terminated. This is the
>>>>>>> reason we want to set halt_poll_ns large. And We hope vlpi
>>>>>>> stop halt_poll process in time.
>>>>>>
>>>>>> Fair enough. It is certainly realistic to strictly partition the
>>>>>> system when GICv4 is in use, so I can see some potential benefit.
>>>>>>
>>>>>>> Though it will check whether vcpu is runnable again by
>>>>>>> kvm_vcpu_check_block. Vlpi can prevent scheduling vcpu out.
>>>>>>> However it's somewhat later if halt_poll_ns is larger.
>>>>>>>
>>>>>>>> In any case, this is something that we should measure, not guess.
>>>>>>
>>>>>> Please post results of realistic benchmarks that we can reproduce,
>>>>>> with and without this change. I'm willing to entertain the idea, but I
>>>>>> need more than just a vague number.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> 	M.
>>>>>>
>>>>>
>>>>> I tested it with and without change (patch attached in the last).
>>>>> halt_poll_ns is keep default, 500000ns.
>>>>> I have merged the patch "arm64: KVM: Always set ICH_HCR_EL2.EN if GICv4 is enabled"
>>>>> to my test kernel, to make sure ICH_HCR_EL2.EN=1 in guest.
>>>>>
>>>>> netperf result:
>>>>> D06 as server, intel 8180 server as client
>>>>> with change:
>>>>> package 512 bytes - 5400 Mbits/s
>>>>> package 64 bytes - 740 Mbits/s
>>>>> without change:
>>>>> package 512 bytes - 5000 Mbits/s
>>>>> package 64 bytes - 710 Mbits/s
>>>>>
>>>>> Also I have tested D06 as client, intel machine as server,
>>>>> with the change, the result remains the same.
>>>>
>>>> So anywhere between 4% and 8% improvement. Please post results for D05
>>>> once you've found one.
>>>>
>>>>>
>>>>>
>>>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>>>> index 55fe8e2..0f56904 100644
>>>>> --- a/virt/kvm/kvm_main.c
>>>>> +++ b/virt/kvm/kvm_main.c
>>>>> @@ -2256,6 +2256,16 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>>>>>  	if (vcpu->halt_poll_ns) {
>>>>>  		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
>>>>>
>>>>> +#ifdef CONFIG_ARM64
>>>>> +		/*
>>>>> +		 * When using gicv4, enable doorbell before halt pool wait
>>>>> +		 * so that direct vlpi can stop halt poll.
>>>>> +		 */
>>>>> +		if (vcpu->arch.vgic_cpu.vgic_v3.its_vpe.its_vm) {
>>>>> +			kvm_vgic_v4_enable_doorbell(vcpu);
>>>>> +		}
>>>>> +#endif
>>>>> +
>>>>
>>>> Irk. No. You're now leaving doorbells enabled when going back to the
>>>> guest, and that's pretty bad as the whole logic relies on doorbells
>>>> being disabled if the guest can run.
>>>>
>>>> So please try this instead on top of mainline. And it has to be on top
>>>> of mainline as we've changed the way timer interrupts work in 5.1 --
>>>> see accb99bcd0ca ("KVM: arm/arm64: Simplify bg_timer programming").
>>>>
>>
>> [...]
>>
>>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>>> index f25aa98a94df..0ae4ad5dcb12 100644
>>>> --- a/virt/kvm/kvm_main.c
>>>> +++ b/virt/kvm/kvm_main.c
>>>> @@ -2252,6 +2252,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>>>>  	bool waited = false;
>>>>  	u64 block_ns;
>>>>  
>>>> +	kvm_arch_vcpu_blocking(vcpu);
>>>> +
>>>>  	start = cur = ktime_get();
>>>>  	if (vcpu->halt_poll_ns) {
>>>>  		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
>>>> @@ -2272,8 +2274,6 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>>>>  		} while (single_task_running() && ktime_before(cur, stop));
>>>>  	}
>>>>  
>>>> -	kvm_arch_vcpu_blocking(vcpu);
>>>> -
>>>>  	for (;;) {
>>>>  		prepare_to_swait_exclusive(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
>>>>  
>>>> @@ -2287,8 +2287,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>>>>  	finish_swait(&vcpu->wq, &wait);
>>>>  	cur = ktime_get();
>>>>  
>>>> -	kvm_arch_vcpu_unblocking(vcpu);
>>>>  out:
>>>> +	kvm_arch_vcpu_unblocking(vcpu);
>>>>  	block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
>>>>  
>>>>  	if (!vcpu_valid_wakeup(vcpu))
>>>>
>>>> Thanks,
>>>>
>>>> 	M.
>>>>
>>>
>>> I've tested your patch and the results showed as follow:
>>>
>>> netperf result:
>>> D06 as server, intel 8180 server as client
>>> with change:
>>> package 512 bytes - 5500 Mbits/s
>>> package 64 bytes - 760 Mbits/s
>>> without change:
>>> package 512 bytes - 5000 Mbits/s
>>> package 64 bytes - 710 Mbits/s
>>
>> OK, that's pretty good. Let me know once you've tested it on D05.
>>
>> Thanks,
>>
>> 	M.
>>
> 
> The average cost of kvm_vgic_v4_enable_doorbell on D05 is 0.74us,
> while it is 0.35us on D06.
> 
> netperf result:
> server: D05 vm using 82599 vf,
> client: intel 8180
> 5.0.0-rc3, have merged the patch "arm64: KVM: Always set ICH_HCR_EL2.EN
> if GICv4 is enabled"
> 
> with change:
> package 512 bytes - 7150 Mbits/s
> package 64 bytes - 1080 Mbits/s
> without change:
> package 512 bytes - 7050 Mbits/s
> package 64 bytes - 1080 Mbits/s
> 
> It seems not work on D05, as the doorbell enable process costs more than
> that on D06.
> 
> Thanks,
> Tang
> 
> 
> .
> 

On D05, Hi1616, ACS extended capability was not implemented standardly, it
has to fix it by making a new quirk. And this change results to about 1.5%
performance drop on D05, while it improves 5% to 8% on D06. D06 will be
more commercially used than D05. We think it may be reasonable to change
this process.
If you need to verify this process,  you may use our D06 machine. I will
shows how you can use it with another email. As I know, James.Morse@arm.com
has ever used it too.

Thanks,
Tang


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
