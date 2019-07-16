Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7506A34E
	for <lists+kvmarm@lfdr.de>; Tue, 16 Jul 2019 09:52:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73AB74A54C;
	Tue, 16 Jul 2019 03:52:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEofvPAJUerq; Tue, 16 Jul 2019 03:52:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 572594A538;
	Tue, 16 Jul 2019 03:52:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D69064A524
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jul 2019 03:52:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i3QlNqVQj-CM for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Jul 2019 03:52:43 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C87EC4A4C1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jul 2019 03:52:42 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8D4F24C29AFC5FF4B6B7;
 Tue, 16 Jul 2019 15:52:38 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 16 Jul 2019
 15:52:28 +0800
Subject: Re: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
To: James Morse <james.morse@arm.com>
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
 <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <8a8cd9d2-684e-2246-c1f9-5cf21aa2defc@huawei.com>
Date: Tue, 16 Jul 2019 15:52:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
Content-Language: en-US
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Cc: jonathan.cameron@huawei.com, john.garry@huawei.com, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 huawei.libin@huawei.com, guohanjun@huawei.com, kvmarm@lists.cs.columbia.edu,
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



On 2019/7/5 18:12, James Morse wrote:
> Hi guys,
> 
> (CC: +kvmarm list)
> 
> On 29/06/2019 03:42, Xiongfeng Wang wrote:
>> This patchset mark all the GICC node in MADT as possible CPUs even though it
>> is disabled. But only those enabled GICC node are marked as present CPUs.
>> So that kernel will initialize some CPU related data structure in advance before
>> the CPU is actually hot added into the system. This patchset also implement 
>> 'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
>> needed to enable CPU hotplug.
>>
>> To support CPU hotplug, we need to add all the possible GICC node in MADT
>> including those CPUs that are not present but may be hot added later. Those
>> CPUs are marked as disabled in GICC nodes.
> 
> ... what do you need this for?
> 
> (The term cpu-hotplug in the arm world almost never means hot-adding a new package/die to
> the platform, we usually mean taking CPUs online/offline for power management. e.g.
> cpuhp_offline_cpu_device())
> 
> It looks like you're adding support for hot-adding a new package/die to the platform ...
> but only for virtualisation.

I read the GIC driver these days. It is a lot of work to configure the GIC at runtime,
and this patchset doesn't support this.
Actually, my original idea is hot-adding cores to the platform, and it is only for virtualisation.
These cores need to be on the same physical package. The GIC is initialized when
the kernel boots and GICR is initialized when the core is hot-added and brought up.

> 
> I don't see why this is needed for virtualisation. The in-kernel irqchip needs to know
> these vcpu exist before you can enter the guest for the first time. You can't create them
> late. At best you're saving the host scheduling a vcpu that is offline. Is this really a
> problem?
> 
> If we moved PSCI support to user-space, you could avoid creating host vcpu threads until
> the guest brings the vcpu online, which would solve that problem, and save the host
> resources for the thread too. (and its acpi/dt agnostic)
> 
> I don't see the difference here between booting the guest with 'maxcpus=1', and bringing
> the vcpu online later. The only real difference seems to be moving the can-be-online
> policy into the hypervisor/VMM...
> 
> 
> I think physical package/die hotadd is a much bigger, uglier problem than doing the same
> under virtualisation. Its best to do this on real hardware first so we don't miss
> something. (cpu-topology, numa, memory, errata, timers?)
> I'm worried that doing virtualisation first means the firmware-requirements for physical
> hotadd stuff is "whatever Qemu does".
> 
> 
> Thanks,
> 
> James
> 
> .
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
