Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 503E8418D6D
	for <lists+kvmarm@lfdr.de>; Mon, 27 Sep 2021 03:16:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5A564B089;
	Sun, 26 Sep 2021 21:16:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C37fwI2kfkrN; Sun, 26 Sep 2021 21:16:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27F764B0A0;
	Sun, 26 Sep 2021 21:16:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D86574B089
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 Sep 2021 21:16:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VFB0OF8zjBUb for <kvmarm@lists.cs.columbia.edu>;
 Sun, 26 Sep 2021 21:16:47 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 62BA7407F1
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 Sep 2021 21:16:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632705407;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzY8M8YXu+iYLKxkUwpPuQgNMZXmHBvkZNhdt51C1c8=;
 b=Vks+ScZhF+CPRwx8BAUzjIz2ryGpYst+8s8O1XDQ7/GH0DdY2dDV0wUL+36IMQNr+mNmhk
 DtY4A7A004zQ+m7TNe1kD4YW10SexeLTXMpWV0JFIT+25rKEZqk0eXJrRz2ZlIUK9kf036
 5EQEE0bhLwKWhbk15LAgSs2luzhgJJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-QfnfAssDNqOUHVJTHwCbxg-1; Sun, 26 Sep 2021 21:16:45 -0400
X-MC-Unique: QfnfAssDNqOUHVJTHwCbxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A2A1802C88;
 Mon, 27 Sep 2021 01:16:43 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7243060C13;
 Mon, 27 Sep 2021 01:16:36 +0000 (UTC)
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To: Rob Herring <robh@kernel.org>
References: <20210906041424.115473-1-gshan@redhat.com>
 <CAL_JsqLccwTEhzonvdOOox+D6=3gHxbDbtsXTJpqtQfuxA4xvg@mail.gmail.com>
 <CAMj1kXFgnbuQzqf4rnpzn+Ez-sL3859q=1z_PkE1Mgd3SL19rA@mail.gmail.com>
 <197ced59-49b0-a981-6e04-96405164daba@redhat.com>
 <CAL_JsqLRH_Vn7u7b_yXgC=jBE8sZ2ax_yyueA3umbhQtbjW0TA@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <6aa8dd66-7910-4227-709a-8d0bbc2939ee@redhat.com>
Date: Mon, 27 Sep 2021 11:16:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLRH_Vn7u7b_yXgC=jBE8sZ2ax_yyueA3umbhQtbjW0TA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 shan.gavin@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

Hi Rob,

> On 9/24/21 1:17 AM, Rob Herring wrote:
> On Thu, Sep 23, 2021 at 1:32 AM Gavin Shan <gshan@redhat.com> wrote:
>> On 9/22/21 9:05 PM, Ard Biesheuvel wrote:
>>> On Tue, 21 Sept 2021 at 21:45, Rob Herring <robh@kernel.org> wrote:
>>>> On Sun, Sep 5, 2021 at 11:16 PM Gavin Shan <gshan@redhat.com> wrote:
>>>>>
>>>>> The empty memory nodes, where no memory resides in, are allowed.
>>>>> For these empty memory nodes, the 'len' of 'reg' property is zero.
>>>>> The NUMA node IDs are still valid and parsed, but memory may be
>>>>> added to them through hotplug afterwards. Currently, QEMU fails
>>>>> to boot when multiple empty memory nodes are specified. It's
>>>>> caused by device-tree population failure and duplicated memory
>>>>> node names.
>>>
>>> Those memory regions are known in advance, right? So wouldn't it be
>>> better to use something like 'status = "disabled"' here?
>>>
>>
>> Yes, these memory regions are known in advance. For the empty nodes,
>> their 'len' property is zero and it's equal to disabled state.
>>
>>>>
>>>> I still don't like the fake addresses. I can't really give suggestions
>>>> on alternative ways to fix this with you just presenting a solution.
>>>>
>>>
>>> Agreed. Please try to explain what the problem is, and why this is the
>>> best way to solve it. Please include other solutions that were
>>> considered and rejected if any exist.
>>>
>>>> What is the failure you see? Can we relax the kernel's expectations?
>>>> What about UEFI boot as the memory nodes aren't used (or maybe they
>>>> are for NUMA?) How does this work with ACPI?
>>>>
>>>
>>> The EFI memory map only needs to describe the memory that was present
>>> at boot. More memory can be represented as ACPI objects, including
>>> coldplugged memory that is already present at boot. None of this
>>> involves the memory nodes in DT.
>>>
>>
>> I'm using the following command line to start a virtual machine (VM).
>> There are 4 NUMA nodes specified, but the last two are empty. In QEMU,
>> the device-tree nodes are populated to represent these 4 NUMA nodes.
>> Unfortunately, QEMU fails to start because of the conflicting names
>> for the empty node are found, as the following error message indicates.
>>
>>      /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64        \
>>      -accel kvm -machine virt,gic-version=host                      \
>>      -cpu host -smp 4,sockets=2,cores=2,threads=1                   \
>>      -m 1024M,slots=16,maxmem=64G                                   \
>>      -object memory-backend-ram,id=mem0,size=512M                   \
>>      -object memory-backend-ram,id=mem1,size=512M                   \
>>      -numa node,nodeid=0,cpus=0-1,memdev=mem0                       \
>>      -numa node,nodeid=1,cpus=2-3,memdev=mem1                       \
>>      -numa node,nodeid=2                                            \
>>      -numa node,nodeid=3                                            \
>>        :
>>      -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>>        :
>>        :
>>      qemu-system-aarch64: FDT: Failed to create subnode /memory@80000000: FDT_ERR_EXISTS
>>
>> According to device-tree specification, the memory device-tree node's
>> name is following the format 'memory@base-address'. For the empty
>> NUMA nodes, their base addresses aren't determined. The device-tree
>> specification doesn't indicate what 'base-address' should be assigned
>> for the empty nodes. So I proposed this patch because I think the
>> linux device-tree binding documentation is best place to get this
>> documented.
> 
> Why even create the node?
> 
> What does IBM pSeries do here. AIUI, those platforms create/remove
> nodes for hotplug. That's the reason CONFIG_OF_DYNAMIC existed
> originally. Unfortunately, that's the extent of my knowledge on that.
> 

It has been long time that I didn't read pSeries related code. I
spent some time on that and you're correct. On pSeries, the device-tree
node is added dynamically. However, the IBM private nodes or properties,
whose names start with "ibm", are used for the memory hotplug. So
ARM64 can't follow without adaption.

I agree on your suggestion, which will be reflected in v2:

(a) the memory device-tree nodes are added and removed on memory hot
     add and removal.
(b) the supported NUMA nodes, including the empty ones, are identified
     through "numa-distance-map" compatible device-tree node. It's
     exactly same to what you suggested below.

In this way, we won't have the issue of the conflicting memory node
names, introduced by the empty NUMA nodes.

>> ACPI is different story. The NUMA nodes are represented by SRAT
>> (System Resource Affinity Table). In the above example, there are
>> 4 SRATs. We needn't assign names to the tables and we don't have
>> the conflicting names as we do in device-tree case.
>>
>> By the way, QEMU currently prevents to expose SRATs for empty NUMA
>> nodes. I need submit QEMU patch to break the limitation in future.
>> With the limitation, the hot-added memory is always put into the
>> last NUMA node and it's not exactly customer wants.
>>
>>>>> As device-tree specification indicates, the 'unit-address' of
>>>>> these empty memory nodes, part of their names, are the equivalents
>>>>> to 'base-address'. Unfortunately, I finds difficulty to get where
>>>>> the assignment of 'base-address' is properly documented for these
>>>>> empty memory nodes. So lets add a section for empty memory nodes
>>>>> to cover this in NUMA binding document. The 'unit-address',
>>>>> equivalent to 'base-address' in the 'reg' property of these empty
>>>>> memory nodes is specified to be the summation of highest memory
>>>>> address plus the NUMA node ID.
>>>>>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/numa.txt | 60 +++++++++++++++++++++-
>>>>>    1 file changed, 59 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>>>> index 21b35053ca5a..82f047bc8dd6 100644
>>>>> --- a/Documentation/devicetree/bindings/numa.txt
>>>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>>>> @@ -103,7 +103,65 @@ Example:
>>>>>                   };
>>>>>
>>>>>    ==============================================================================
>>>>> -4 - Example dts
>>>>> +4 - Empty memory nodes
>>>>> +==============================================================================
>>>>> +
>>>>> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
>>>>> +field of the 'reg' property is zero. However, the 'base-address' is a
>>>>> +dummy and invalid address, which is the summation of highest memory address
>>>>> +plus the NUMA node ID. The NUMA node IDs and distance maps are still valid
>>>>> +and memory may be added into them through hotplug afterwards.
>>>>> +
>>>>> +Example:
>>>>> +
>>>>> +       memory@0 {
>>>>> +               device_type = "memory";
>>>>> +               reg = <0x0 0x0 0x0 0x80000000>;
>>>>> +               numa-node-id = <0>;
>>>>> +       };
>>>>> +
>>>>> +       memory@80000000 {
>>>>> +               device_type = "memory";
>>>>> +               reg = <0x0 0x80000000 0x0 0x80000000>;
>>>>> +               numa-node-id = <1>;
>>>>> +       };
>>>>> +
>>>>> +       /* Empty memory node */
>>>>> +       memory@100000002 {
>>>>> +               device_type = "memory";
>>>>> +               reg = <0x1 0x2 0x0 0x0>;
>>>>> +               numa-node-id = <2>;
>>>>> +       };
>>>>> +
>>>>> +       /* Empty memory node */
>>>>> +       memory@100000003 {
>>>>> +               device_type = "memory";
>>>>> +               reg = <0x1 0x3 0x0 0x0>;
>>>>> +               numa-node-id = <3>;
>>>>> +       };
>>>>
>>>> Do you really need the memory nodes here or just some way to define
>>>> numa node id's 2 and 3 as valid?
>>>>
>>
>> It's the way to define NUMA node IDs are valid. Besides, the 'reg'
>> property provides 'base-address', which is part of the device-tree
>> node's name, as described in this patch.
> 
> The distance-matrix already lists all possible NUMA node IDs. That
> should be enough information for the kernel. If not, fix the kernel.
> 

Thanks, Rob. An extra patch will address the issue in v2.

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
