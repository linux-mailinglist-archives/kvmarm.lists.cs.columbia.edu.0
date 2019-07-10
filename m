Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A264B26
	for <lists+kvmarm@lfdr.de>; Wed, 10 Jul 2019 19:02:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6C994A54D;
	Wed, 10 Jul 2019 13:02:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nQQnj9NvQqBb; Wed, 10 Jul 2019 13:02:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5860B4A547;
	Wed, 10 Jul 2019 13:02:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A6E624A4E1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jul 2019 13:02:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HBxsLgduRg3N for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Jul 2019 13:02:39 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 47AC94A4C1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jul 2019 13:02:39 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0A3A344;
 Wed, 10 Jul 2019 10:02:38 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F16C3F246;
 Wed, 10 Jul 2019 10:02:38 -0700 (PDT)
Date: Wed, 10 Jul 2019 18:02:35 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH kvm-unit-tests] arm: Add PL031 test
Message-ID: <20190710180235.25c54b84@donnerap.cambridge.arm.com>
In-Reply-To: <20190710132724.28350-1-graf@amazon.com>
References: <20190710132724.28350-1-graf@amazon.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: Marc Zyngier <marc.zyngier@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Wed, 10 Jul 2019 15:27:24 +0200
Alexander Graf <graf@amazon.com> wrote:

Hi,

> This patch adds a unit test for the PL031 RTC that is used in the virt machine.
> It just pokes basic functionality. I've mostly written it to familiarize myself
> with the device, but I suppose having the test around does not hurt, as it also
> exercises the GIC SPI interrupt path.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  arm/Makefile.common |   1 +
>  arm/pl031.c         | 227 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/arm/asm/gic.h   |   1 +
>  3 files changed, 229 insertions(+)
>  create mode 100644 arm/pl031.c
> 
> diff --git a/arm/Makefile.common b/arm/Makefile.common
> index f0c4b5d..b8988f2 100644
> --- a/arm/Makefile.common
> +++ b/arm/Makefile.common
> @@ -11,6 +11,7 @@ tests-common += $(TEST_DIR)/pmu.flat
>  tests-common += $(TEST_DIR)/gic.flat
>  tests-common += $(TEST_DIR)/psci.flat
>  tests-common += $(TEST_DIR)/sieve.flat
> +tests-common += $(TEST_DIR)/pl031.flat
>  
>  tests-all = $(tests-common) $(tests)
>  all: directories $(tests-all)
> diff --git a/arm/pl031.c b/arm/pl031.c
> new file mode 100644
> index 0000000..a364a1a
> --- /dev/null
> +++ b/arm/pl031.c
> @@ -0,0 +1,227 @@
> +/*
> + * Verify PL031 functionality
> + *
> + * This test verifies whether the emulated PL031 behaves correctly.

                                     ^^^^^^^^

While I appreciate the effort and like the fact that this actually triggers an SPI, I wonder if this actually belongs into kvm-unit-tests.
After all this just test a device purely emulated in (QEMU) userland, so it's not really KVM related.

What is the general opinion on this?
Don't we care about this hair-splitting as long as it helps testing?
Do we even want to extend kvm-unit-tests coverage to more emulated devices, for instance virtio?

Cheers,
Andre.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
