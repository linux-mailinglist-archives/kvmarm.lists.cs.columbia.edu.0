Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 00002258B6B
	for <lists+kvmarm@lfdr.de>; Tue,  1 Sep 2020 11:24:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F2D94AED4;
	Tue,  1 Sep 2020 05:24:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hhpJ5ZjQ9nVb; Tue,  1 Sep 2020 05:24:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 326234B125;
	Tue,  1 Sep 2020 05:24:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 91F4D4B0D2
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 05:24:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sinii1dioVxR for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Sep 2020 05:24:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 515C54B0BE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 05:24:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC94D30E;
 Tue,  1 Sep 2020 02:24:00 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E6123F71F;
 Tue,  1 Sep 2020 02:23:59 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC 0/4] KVM: arm64: Statistical Profiling
 Extension Tests
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org,
 drjones@redhat.com, andrew.murray@arm.com, sudeep.holla@arm.com,
 maz@kernel.org, will@kernel.org, haibo.xu@linaro.org
References: <20200831193414.6951-1-eric.auger@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <b5eb2cd0-9798-6e40-7690-78992eca30fd@arm.com>
Date: Tue, 1 Sep 2020 10:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831193414.6951-1-eric.auger@redhat.com>
Content-Language: en-US
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

Hi Eric,

These patches are extremely welcome! I took over the KVM SPE patches from Andrew
Murray, and I was working on something similar to help with development.

The KVM series on the public mailing list work only by chance because it is
impossible to reliably map the SPE buffer at EL2 when profiling triggers a stage 2
data abort. That's because the DABT is reported asynchronously via the buffer
management interrupt and the faulting IPA is not reported anywhere. I'm trying to
fix this issue in the next iteration of the series, and then I'll come back to
your patches for review and testing.

Thanks,

Alex

On 8/31/20 8:34 PM, Eric Auger wrote:
> This series implements tests exercising the Statistical Profiling
> Extensions.
>
> This was tested with associated unmerged kernel [1] and QEMU [2]
> series.
>
> Depending on the comments, I can easily add other tests checking
> more configs, additional events and testing migration too. I hope
> this can be useful when respinning both series.
>
> All SPE tests can be launched with:
> ./run_tests.sh -g spe
> Tests also can be launched individually. For example:
> ./arm-run arm/spe.flat -append 'spe-buffer'
>
> The series can be found at:
> https://github.com/eauger/kut/tree/spe_rfc
>
> References:
> [1] [PATCH v2 00/18] arm64: KVM: add SPE profiling support
> [2] [PATCH 0/7] target/arm: Add vSPE support to KVM guest
>
> Eric Auger (4):
>   arm64: Move get_id_aa64dfr0() in processor.h
>   spe: Probing and Introspection Test
>   spe: Add profiling buffer test
>   spe: Test Profiling Buffer Events
>
>  arm/Makefile.common       |   1 +
>  arm/pmu.c                 |   1 -
>  arm/spe.c                 | 463 ++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg         |  24 ++
>  lib/arm64/asm/barrier.h   |   1 +
>  lib/arm64/asm/processor.h |   5 +
>  6 files changed, 494 insertions(+), 1 deletion(-)
>  create mode 100644 arm/spe.c
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
