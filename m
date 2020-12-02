Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 405632CBF96
	for <lists+kvmarm@lfdr.de>; Wed,  2 Dec 2020 15:28:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF89B4B396;
	Wed,  2 Dec 2020 09:28:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qs5-oK5aGTyf; Wed,  2 Dec 2020 09:28:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B22604B3BB;
	Wed,  2 Dec 2020 09:28:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C9FCC4B333
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 09:28:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5SfbIvJWmeM4 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Dec 2020 09:28:10 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B3E674B354
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 09:28:10 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597E230E;
 Wed,  2 Dec 2020 06:28:10 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0EA3F718;
 Wed,  2 Dec 2020 06:28:09 -0800 (PST)
Subject: Re: [RFC PATCH v3 04/16] arm64: Introduce CPU SPE feature
To: James Morse <james.morse@arm.com>
References: <20201027172705.15181-1-alexandru.elisei@arm.com>
 <20201027172705.15181-5-alexandru.elisei@arm.com>
 <418e3bf6-159c-6d1f-2b84-2fdb10c3cddd@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <906a02c2-3923-3542-ffb8-43d856498e07@arm.com>
Date: Wed, 2 Dec 2020 14:29:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <418e3bf6-159c-6d1f-2b84-2fdb10c3cddd@arm.com>
Content-Language: en-US
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org,
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

Hi James,

On 11/19/20 4:58 PM, James Morse wrote:
> Hi Alex,
>
> On 27/10/2020 17:26, Alexandru Elisei wrote:
>> Detect Statistical Profiling Extension (SPE) support using the cpufeatures
>> framework. The presence of SPE is reported via the ARM64_SPE capability.
>>
>> The feature will be necessary for emulating SPE in KVM, because KVM needs
>> that all CPUs have SPE hardware to avoid scheduling a VCPU on a CPU without
>> support. For this reason, the feature type ARM64_CPUCAP_SYSTEM_FEATURE has
>> been selected to disallow hotplugging a CPU which doesn't support SPE.
> Can you mention the existing driver in the commit message? Surprisingly it doesn't use
> cpufeature at all. It looks like arm_spe_pmu_dev_init() goes out of its way to support
> mismatched systems. (otherwise the significance of the new behaviour isn't clear!)
>
> I read it as: the host is fine with mismatched systems, and the existing drivers supports
> this. But KVM is not. After this patch you can't make the system mismatched 'late'.

That was exactly my intention. Certainly, I'll try to make the commit message
clearer by mentioning the SPE driver.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
