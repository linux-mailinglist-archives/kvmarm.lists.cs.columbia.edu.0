Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 346C927B3C3
	for <lists+kvmarm@lfdr.de>; Mon, 28 Sep 2020 19:57:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C62424B179;
	Mon, 28 Sep 2020 13:57:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aD9twOgd895N; Mon, 28 Sep 2020 13:57:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 991354B16D;
	Mon, 28 Sep 2020 13:57:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 199E74B107
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Sep 2020 13:57:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ObJyei2POc7Y for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Sep 2020 13:57:33 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 14E764B102
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Sep 2020 13:57:33 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5277121548;
 Mon, 28 Sep 2020 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601315851;
 bh=FiszVX2X8aJ3JQctQxAoRVYSBkNKuAV65IqHDIVEDrc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UgVhqWZrdi8d79p/SWmzNIKWAx9QY2xxFutpMs2SAKlkY/0GIzKc+JxKnxdBuFB6x
 9OT11LaaBlPGY87mYS0o64wfRW1lATLgsh5WOGTW9SBu2UE75JH+0WdgGGqPWROjxA
 cYdRwSOinofw/TDgdBAoCMVzsDC5BTKWRj/BAdJI=
Date: Mon, 28 Sep 2020 18:57:25 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v7 5/7] KVM: arm64: pmu: Make overflow handler NMI safe
Message-ID: <20200928175725.GB11792@willie-the-truck>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
 <20200924110706.254996-6-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924110706.254996-6-alexandru.elisei@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: sumit.garg@linaro.org, kvm@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, maz@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 24, 2020 at 12:07:04PM +0100, Alexandru Elisei wrote:
> From: Julien Thierry <julien.thierry@arm.com>
> 
> kvm_vcpu_kick() is not NMI safe. When the overflow handler is called from
> NMI context, defer waking the vcpu to an irq_work queue.
> 
> A vcpu can be freed while it's not running by kvm_destroy_vm(). Prevent
> running the irq_work for a non-existent vcpu by calling irq_work_sync() on
> the PMU destroy path.
> 
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
> Cc: kvm@vger.kernel.org
> Cc: kvmarm@lists.cs.columbia.edu
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)
> [Alexandru E.: Added irq_work_sync()]
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> I suggested in v6 that I will add an irq_work_sync() to
> kvm_pmu_vcpu_reset(). It turns out it's not necessary: a vcpu reset is done
> by the vcpu being reset with interrupts enabled, which means all the work
> has had a chance to run before the reset takes place.

I don't understand this ^^

But the patch itself looks good, so I'm going to queue this lot anyway!

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
