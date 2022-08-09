Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B36B558DAFC
	for <lists+kvmarm@lfdr.de>; Tue,  9 Aug 2022 17:21:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D38824C5EF;
	Tue,  9 Aug 2022 11:21:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zc-fcP0FtPhC; Tue,  9 Aug 2022 11:21:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D9244C571;
	Tue,  9 Aug 2022 11:21:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21A434C4E6
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Aug 2022 11:21:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kQVViPalSSYR for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Aug 2022 11:20:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C0B944C4C0
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Aug 2022 11:20:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE18E23A;
 Tue,  9 Aug 2022 08:20:58 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C4D83F5A1;
 Tue,  9 Aug 2022 08:20:56 -0700 (PDT)
Date: Tue, 9 Aug 2022 16:21:41 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 1/3] arm: pmu: Add missing isb()'s
 after sys register writing
Message-ID: <YvJ7hbMZ+FLkxuc4@monolith.localdoman>
References: <20220805004139.990531-1-ricarkol@google.com>
 <20220805004139.990531-2-ricarkol@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220805004139.990531-2-ricarkol@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, andrew.jones@linux.dev,
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

Hi,

On Thu, Aug 04, 2022 at 05:41:37PM -0700, Ricardo Koller wrote:
> There are various pmu tests that require an isb() between enabling
> counting and the actual counting. This can lead to count registers
> reporting less events than expected; the actual enabling happens after
> some events have happened.  For example, some missing isb()'s in the
> pmu-sw-incr test lead to the following errors on bare-metal:
> 
> 	INFO: pmu: pmu-sw-incr: SW_INCR counter #0 has value 4294967280
> 	PASS: pmu: pmu-sw-incr: PWSYNC does not increment if PMCR.E is unset
> 	FAIL: pmu: pmu-sw-incr: counter #1 after + 100 SW_INCR
> 	FAIL: pmu: pmu-sw-incr: counter #0 after + 100 SW_INCR
> 	INFO: pmu: pmu-sw-incr: counter values after 100 SW_INCR #0=82 #1=98
> 	PASS: pmu: pmu-sw-incr: overflow on counter #0 after 100 SW_INCR
> 	SUMMARY: 4 tests, 2 unexpected failures
> 
> Add the missing isb()'s on all failing tests, plus some others that seem
> required:
> - after clearing the overflow signal in the IRQ handler to make spurious
>   interrupts less likely.
> - after direct writes to PMSWINC_EL0 for software to read the correct
>   value for PMEVNCTR0_EL0 (from ARM DDI 0487H.a, page D13-5237).
> 
> Signed-off-by: Ricardo Koller <ricarkol@google.com>

Looks good to me:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
