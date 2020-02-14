Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7192015F92B
	for <lists+kvmarm@lfdr.de>; Fri, 14 Feb 2020 23:01:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96F8E4AECE;
	Fri, 14 Feb 2020 17:01:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rx+3k3Sfm0wo; Fri, 14 Feb 2020 17:01:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 832DD4AEC4;
	Fri, 14 Feb 2020 17:01:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CB754AE8E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 17:01:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BxHIbutYsT05 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Feb 2020 17:01:04 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D6524ACB8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 17:01:04 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF41A328;
 Fri, 14 Feb 2020 14:01:03 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FA693F68E;
 Fri, 14 Feb 2020 14:01:02 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: arm64: Add PMU event filtering infrastructure
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20200214183615.25498-1-maz@kernel.org>
 <20200214183615.25498-2-maz@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ac2a8a87-3a90-1abb-30a5-00c20667cd14@arm.com>
Date: Fri, 14 Feb 2020 22:01:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214183615.25498-2-maz@kernel.org>
Content-Language: en-GB
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

Hi Marc,

On 2020-02-14 6:36 pm, Marc Zyngier wrote:
[...]
> @@ -585,6 +585,14 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>   	    pmc->idx != ARMV8_PMU_CYCLE_IDX)
>   		return;
>   
> +	/*
> +	 * If we have a filter in place and that the event isn't allowed, do
> +	 * not install a perf event either.
> +	 */
> +	if (vcpu->kvm->arch.pmu_filter &&
> +	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
> +		return;

If I'm reading the derivation of eventsel right, this will end up 
treating cycle counter events (aliased to SW_INCR) differently from 
CPU_CYCLES, which doesn't seem desirable.

Also, if the user did try to blacklist SW_INCR for ridiculous reasons, 
we'd need to special-case kvm_pmu_software_increment() to make it (not) 
work as expected, right?

Robin.

> +
>   	memset(&attr, 0, sizeof(struct perf_event_attr));
>   	attr.type = PERF_TYPE_RAW;
>   	attr.size = sizeof(attr);
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
