Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87F1782D3
	for <lists+kvmarm@lfdr.de>; Tue,  3 Mar 2020 20:07:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F84D4AF20;
	Tue,  3 Mar 2020 14:07:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPGQNPoL4svR; Tue,  3 Mar 2020 14:07:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F78F4AEFA;
	Tue,  3 Mar 2020 14:07:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEE074AEE4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Mar 2020 14:07:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WF0he-wo-SeO for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Mar 2020 14:07:47 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C38464AEE1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Mar 2020 14:07:47 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B45230E;
 Tue,  3 Mar 2020 11:07:47 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695463F534;
 Tue,  3 Mar 2020 11:07:46 -0800 (PST)
Date: Tue, 3 Mar 2020 19:07:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv6 0/3] arm64: perf: Add support for ARMv8.5-PMU 64-bit
 counters
Message-ID: <20200303190742.GD7649@lakrids.cambridge.arm.com>
References: <20200302181752.14251-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200302181752.14251-1-mark.rutland@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, Mar 02, 2020 at 06:17:49PM +0000, Mark Rutland wrote:
> This is a respin of Andrew Murray's series to enable support for 64-bit
> counters as introduced in ARMv8.5.
> 
> I've given this a spin on (ARMv8.2) hardware, to test that there are no
> regressions, but I have not had the chance to test in an ARMv8.5 model (which I
> beleive Andrew had previously tested).

Bad news; this is broken. :(

While perf-stat works as expected, perf-record doesn't get samples for
any of the programmable counters.

In ARMv8.4 mode I can do:

| / # perf record -a -c 1 -e armv8_pmuv3/inst_retired/ true
| [ perf record: Woken up 1 times to write data ]
| [ perf record: Captured and wrote 0.023 MB perf.data (367 samples) ]
| / # perf record -a -c 1 -e armv8_pmuv3/inst_retired,long/ true
| [ perf record: Woken up 1 times to write data ]
| [ perf record: Captured and wrote 0.022 MB perf.data (353 samples) ]

... so regular 32-bit and chained events work correctly.

But in ARMv8.5 mode I get no samples in either case:

| / # perf record -a -c 1 -e armv8_pmuv3/inst_retired/ true
| [ perf record: Woken up 1 times to write data ]
| [ perf record: Captured and wrote 0.008 MB perf.data ]
| / # perf report | grep samples
| Error:
| The perf.data file has no samples!
| / # perf record -a -c 1 -e armv8_pmuv3/inst_retired,long/ true
| [ perf record: Woken up 1 times to write data ]
| [ perf record: Captured and wrote 0.008 MB perf.data ]
| / # perf report | grep samples
| Error:
| The perf.data file has no samples!

I'll have to trace the driver to see what's going on. I suspect we've
missed some bias handling, but it's possible that this is a model bug.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
