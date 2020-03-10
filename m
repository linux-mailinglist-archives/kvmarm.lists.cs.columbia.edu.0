Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE881804C3
	for <lists+kvmarm@lfdr.de>; Tue, 10 Mar 2020 18:28:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D160F4A54B;
	Tue, 10 Mar 2020 13:28:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eoaw4TGKl2Xb; Tue, 10 Mar 2020 13:28:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9DD7C4A4C0;
	Tue, 10 Mar 2020 13:28:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D92894A32E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 13:28:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pDducI50o6aP for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Mar 2020 13:28:18 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 84A8F40A52
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 13:28:18 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD8A1FB;
 Tue, 10 Mar 2020 10:28:17 -0700 (PDT)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8AC13F67D;
 Tue, 10 Mar 2020 10:28:16 -0700 (PDT)
Subject: Re: [PATCHv6 0/3] arm64: perf: Add support for ARMv8.5-PMU 64-bit
 counters
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20200302181752.14251-1-mark.rutland@arm.com>
 <20200303190742.GD7649@lakrids.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2713672f-bd82-ba8d-5fae-777ef5e754eb@arm.com>
Date: Tue, 10 Mar 2020 17:28:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200303190742.GD7649@lakrids.cambridge.arm.com>
Content-Language: en-GB
Cc: catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 maz@kernel.org
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

On 03/03/2020 7:07 pm, Mark Rutland wrote:
> On Mon, Mar 02, 2020 at 06:17:49PM +0000, Mark Rutland wrote:
>> This is a respin of Andrew Murray's series to enable support for 64-bit
>> counters as introduced in ARMv8.5.
>>
>> I've given this a spin on (ARMv8.2) hardware, to test that there are no
>> regressions, but I have not had the chance to test in an ARMv8.5 model (which I
>> beleive Andrew had previously tested).
> 
> Bad news; this is broken. :(
> 
> While perf-stat works as expected, perf-record doesn't get samples for
> any of the programmable counters.
> 
> In ARMv8.4 mode I can do:
> 
> | / # perf record -a -c 1 -e armv8_pmuv3/inst_retired/ true
> | [ perf record: Woken up 1 times to write data ]
> | [ perf record: Captured and wrote 0.023 MB perf.data (367 samples) ]
> | / # perf record -a -c 1 -e armv8_pmuv3/inst_retired,long/ true
> | [ perf record: Woken up 1 times to write data ]
> | [ perf record: Captured and wrote 0.022 MB perf.data (353 samples) ]
> 
> ... so regular 32-bit and chained events work correctly.
> 
> But in ARMv8.5 mode I get no samples in either case:
> 
> | / # perf record -a -c 1 -e armv8_pmuv3/inst_retired/ true
> | [ perf record: Woken up 1 times to write data ]
> | [ perf record: Captured and wrote 0.008 MB perf.data ]
> | / # perf report | grep samples
> | Error:
> | The perf.data file has no samples!
> | / # perf record -a -c 1 -e armv8_pmuv3/inst_retired,long/ true
> | [ perf record: Woken up 1 times to write data ]
> | [ perf record: Captured and wrote 0.008 MB perf.data ]
> | / # perf report | grep samples
> | Error:
> | The perf.data file has no samples!
> 
> I'll have to trace the driver to see what's going on. I suspect we've
> missed some bias handling, but it's possible that this is a model bug.

For the record, further evidence has indeed pointed to there being a bug 
in the model's implementation of ARMv8.5-PMU. It's been raised with the 
models team, so we'll have wait and see what they say...

Robin.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
