Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AB7777BEBF
	for <lists+kvmarm@lfdr.de>; Wed, 31 Jul 2019 12:59:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF6CB4A55A;
	Wed, 31 Jul 2019 06:59:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 1.699
X-Spam-Level: *
X-Spam-Status: No, score=1.699 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_NXDOMAIN=0.9, DNS_FROM_AHBL_RHSBL=2.699]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYD72H4aSXK4; Wed, 31 Jul 2019 06:59:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BEE924A535;
	Wed, 31 Jul 2019 06:59:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 92C4B4A535
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Jul 2019 16:58:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0PvW3KzmV-6W for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Jul 2019 16:58:06 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 78DE14A52E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Jul 2019 16:58:06 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED6EF28;
 Tue, 30 Jul 2019 13:58:05 -0700 (PDT)
Received: from why (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518253F575;
 Tue, 30 Jul 2019 13:58:03 -0700 (PDT)
Date: Tue, 30 Jul 2019 21:57:59 +0100
From: Marc Zyngier <maz@kermel.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v4 7/9] arm/arm64: kvm: pmu: Make overflow handler NMI safe
Message-ID: <20190730215759.5b54e45d@why>
In-Reply-To: <1563351432-55652-8-git-send-email-julien.thierry@arm.com>
References: <1563351432-55652-1-git-send-email-julien.thierry@arm.com>
 <1563351432-55652-8-git-send-email-julien.thierry@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 31 Jul 2019 06:59:05 -0400
Cc: peterz@infradead.org, liwei391@huawei.com, will.deacon@arm.com,
 acme@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com,
 namhyung@kernel.org, sthotton@marvell.com, jolsa@redhat.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Wed, 17 Jul 2019 09:17:10 +0100
Julien Thierry <julien.thierry@arm.com> wrote:

> When using an NMI for the PMU interrupt, taking any lock might cause a
> deadlock. The current PMU overflow handler in KVM takes locks when
> trying to wake up a vcpu.
> 
> When overflow handler is called by an NMI, defer the vcpu waking in an
> irq_work queue.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu

Acked-by: Marc Zyngier <maz@kernel.org>

	M.
-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
