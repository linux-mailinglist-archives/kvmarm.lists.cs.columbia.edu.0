Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F156C2CD323
	for <lists+kvmarm@lfdr.de>; Thu,  3 Dec 2020 11:05:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8796D4B1E0;
	Thu,  3 Dec 2020 05:05:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APceFsNslrDV; Thu,  3 Dec 2020 05:05:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 377694B1E8;
	Thu,  3 Dec 2020 05:05:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14CBD4B1E0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 05:05:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cpljt0xIx08P for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Dec 2020 05:05:52 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ACC654B1DF
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 05:05:52 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A53113E;
 Thu,  3 Dec 2020 02:05:52 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B283F575;
 Thu,  3 Dec 2020 02:05:51 -0800 (PST)
Subject: Re: [RFC PATCH v3 04/16] arm64: Introduce CPU SPE feature
To: Will Deacon <will@kernel.org>
References: <20201027172705.15181-1-alexandru.elisei@arm.com>
 <20201027172705.15181-5-alexandru.elisei@arm.com>
 <418e3bf6-159c-6d1f-2b84-2fdb10c3cddd@arm.com>
 <906a02c2-3923-3542-ffb8-43d856498e07@arm.com>
 <20201202172353.GB29813@willie-the-truck>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <c103cf1d-786d-4151-04be-adaa19432ed5@arm.com>
Date: Thu, 3 Dec 2020 10:07:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201202172353.GB29813@willie-the-truck>
Content-Language: en-US
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
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

Hi Will,

On 12/2/20 5:23 PM, Will Deacon wrote:
> On Wed, Dec 02, 2020 at 02:29:31PM +0000, Alexandru Elisei wrote:
>> On 11/19/20 4:58 PM, James Morse wrote:
>>> On 27/10/2020 17:26, Alexandru Elisei wrote:
>>>> Detect Statistical Profiling Extension (SPE) support using the cpufeatures
>>>> framework. The presence of SPE is reported via the ARM64_SPE capability.
>>>>
>>>> The feature will be necessary for emulating SPE in KVM, because KVM needs
>>>> that all CPUs have SPE hardware to avoid scheduling a VCPU on a CPU without
>>>> support. For this reason, the feature type ARM64_CPUCAP_SYSTEM_FEATURE has
>>>> been selected to disallow hotplugging a CPU which doesn't support SPE.
>>> Can you mention the existing driver in the commit message? Surprisingly it doesn't use
>>> cpufeature at all. It looks like arm_spe_pmu_dev_init() goes out of its way to support
>>> mismatched systems. (otherwise the significance of the new behaviour isn't clear!)
>>>
>>> I read it as: the host is fine with mismatched systems, and the existing drivers supports
>>> this. But KVM is not. After this patch you can't make the system mismatched 'late'.
>> That was exactly my intention. Certainly, I'll try to make the commit message
>> clearer by mentioning the SPE driver.
> Hmm, so are you saying that with this patch applied, a machine where KVM
> isn't even being used can no longer late-online CPUs without SPE if the boot
> CPUs had it? If so, then I don't think that's acceptable, unfortunately.

Yes, the idea was to prevent hotplugging CPUs that don't have the capability so
the kernel won't schedule a SPE-enabled guest on a CPU which doesn't have SPE.

>
> As James points out, the current driver is very careful to support
> big.LITTLE misconfigurations and I don't see why KVM support should change
> that.

That makes sense, thank you for making it clear from the start that this approach
is not the right one.

There was a discussion for supporting KVM SPE on heterogeneous systems [1]. I
chose to use a capability because the focus for this iteration was to ensure the
correctness of SPE emulation, and the capability looked like the easiest way to
get KVM SPE up and running for testing.

The idea discussed previously [1] was to have userspace configure the VM with a
cpumask representing the CPUs the VM is allowed to run on. KVM detects if the VCPU
is scheduled on a physical CPU not in the cpumask, and returns from KVM_RUN with
an error code. That looks like a good solution to me and generic enough that it
can be used for all sorts of mismatched features. I will try to implement it in
the next iteration, after I get more feedback on the current series.

[1] https://www.spinics.net/lists/arm-kernel/msg778477.html

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
