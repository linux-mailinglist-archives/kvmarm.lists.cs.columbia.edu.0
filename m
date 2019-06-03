Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 14044339E2
	for <lists+kvmarm@lfdr.de>; Mon,  3 Jun 2019 23:21:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 80CAA4A36B;
	Mon,  3 Jun 2019 17:21:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kV31evL5Ap+w; Mon,  3 Jun 2019 17:21:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E30C4A4C2;
	Mon,  3 Jun 2019 17:21:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89AC44A319
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 17:21:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5WkM4R6tkkIA for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 Jun 2019 17:21:11 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 168AB4A2E5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 17:21:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5200CA78;
 Mon,  3 Jun 2019 14:21:10 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1326C3F5AF;
 Mon,  3 Jun 2019 14:21:07 -0700 (PDT)
Date: Mon, 3 Jun 2019 22:21:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v5 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190603212104.mhz7vvj7afb2p3yr@mbp>
References: <20190521172139.21277-1-julien.grall@arm.com>
 <20190521172139.21277-4-julien.grall@arm.com>
 <20190603162534.GF63283@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190603162534.GF63283@arrakis.emea.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: kvmarm@lists.cs.columbia.edu, ard.biesheuvel@linaro.org,
 marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Jun 03, 2019 at 05:25:34PM +0100, Catalin Marinas wrote:
> On Tue, May 21, 2019 at 06:21:39PM +0100, Julien Grall wrote:
> > Since a softirq is supposed to check may_use_simd() anyway before
> > attempting to use FPSIMD/SVE, there is limited reason to keep softirq
> > disabled when touching the FPSIMD/SVE context. Instead, we can simply
> > disable preemption and mark the FPSIMD/SVE context as in use by setting
> > CPU's fpsimd_context_busy flag.
> [...]
> > +static void get_cpu_fpsimd_context(void)
> > +{
> > +	preempt_disable();
> > +	__get_cpu_fpsimd_context();
> > +}
> 
> Is there anything that prevents a softirq being invoked between
> preempt_disable() and __get_cpu_fpsimd_context()?

Actually, it shouldn't matter as the softirq finishes using the fpsimd
before the thread is resumed.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
