Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C77611BA722
	for <lists+kvmarm@lfdr.de>; Mon, 27 Apr 2020 17:00:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 45C674B148;
	Mon, 27 Apr 2020 11:00:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TwHtkZ7caD6R; Mon, 27 Apr 2020 11:00:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E581F4B151;
	Mon, 27 Apr 2020 11:00:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB9B34B146
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 11:00:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0YqjbQdw-wP for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Apr 2020 11:00:27 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C5B3F4B117
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 11:00:27 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6746331B;
 Mon, 27 Apr 2020 08:00:27 -0700 (PDT)
Received: from [10.37.8.240] (unknown [10.37.8.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5FCE3F68F;
 Mon, 27 Apr 2020 08:00:25 -0700 (PDT)
Subject: Re: [PATCH][kvmtool] kvm: Request VM specific limits instead of
 system-wide ones
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20200427141738.285217-1-maz@kernel.org>
 <d27e4a14-34b8-7f3d-1e58-ef2ae13e443b@arm.com>
Message-ID: <7ac17890-72d1-1c81-e513-5d4f7841ca9d@arm.com>
Date: Mon, 27 Apr 2020 16:00:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d27e4a14-34b8-7f3d-1e58-ef2ae13e443b@arm.com>
Content-Language: en-US
Cc: Andre Przywara <Andre.Przywara@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

Hi,

On 4/27/20 3:44 PM, Alexandru Elisei wrote:
> Hi,
>
> On 4/27/20 3:17 PM, Marc Zyngier wrote:
>> On arm64, the maximum number of vcpus is constrained by the type
>> of interrupt controller that has been selected (GICv2 imposes a
>> limit of 8 vcpus, while GICv3 currently has a limit of 512).
>>
>> It is thus important to request this limit on the VM file descriptor
>> rather than on the one that corresponds to /dev/kvm, as the latter
>> is likely to return something that doesn't take the constraints into
>> account.
>>
>> Reported-by: Ard Biesheuvel <ardb@kernel.org>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  kvm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kvm.c b/kvm.c
>> index e327541..3d5173d 100644
>> --- a/kvm.c
>> +++ b/kvm.c
>> @@ -406,7 +406,7 @@ int kvm__recommended_cpus(struct kvm *kvm)
>>  {
>>  	int ret;
>>  
>> -	ret = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION, KVM_CAP_NR_VCPUS);
>> +	ret = ioctl(kvm->vm_fd, KVM_CHECK_EXTENSION, KVM_CAP_NR_VCPUS);
>>  	if (ret <= 0)
>>  		/*
>>  		 * api.txt states that if KVM_CAP_NR_VCPUS does not exist,
>> @@ -421,7 +421,7 @@ int kvm__max_cpus(struct kvm *kvm)
>>  {
>>  	int ret;
>>  
>> -	ret = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION, KVM_CAP_MAX_VCPUS);
>> +	ret = ioctl(kvm->vm_fd, KVM_CHECK_EXTENSION, KVM_CAP_MAX_VCPUS);
>>  	if (ret <= 0)
>>  		ret = kvm__recommended_cpus(kvm);
>>  
> I've checked that gic__create comes before the call kvm__recommended_capus:
> gic__create is in core_init (called via kvm__init->kvm_arch_init), and
> kvm__recommended_cpus is in base_init (called via kvm__cpu_init ->
> kvm__{recommended,max}_cpus).
>
> The KVM api documentation states that KVM_CHECK_EXTENSION is available for the vm
> fd only if the system capability KVM_CAP_CHECK_EXTENSION_VM is present. kvmtool
> already has a function for checking extensions on the vm fd, it's called
> kvm__supports_vm_extension. Can we use that instead of doing the ioctl directly on
> the vm fd?

Scratch that, kvm__supports_vm_extension returns a bool, not an int. How about we
write kvm__check_vm_extension that returns an int, and kvm__supports_vm_extension
calls it?

>
> Thanks,
> Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
