Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 056E62CD81C
	for <lists+kvmarm@lfdr.de>; Thu,  3 Dec 2020 14:46:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CAC04B0DD;
	Thu,  3 Dec 2020 08:46:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CjysVmJFbhlB; Thu,  3 Dec 2020 08:46:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E1274B155;
	Thu,  3 Dec 2020 08:46:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C4524B0FD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 08:46:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWt+3eot3GEA for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Dec 2020 08:46:18 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1F21A4B0DD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 08:46:18 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C413A206D8;
 Thu,  3 Dec 2020 13:46:16 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kkow2-00Ffsk-Il; Thu, 03 Dec 2020 13:46:14 +0000
MIME-Version: 1.0
Date: Thu, 03 Dec 2020 13:46:14 +0000
From: Marc Zyngier <maz@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v4 16/26] kvm: arm64: Bootstrap PSCI SMC handler in nVHE
 EL2
In-Reply-To: <20201202184122.26046-17-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-17-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3ac00cc2e2887f85e250288a7b6b5e4f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, dennis@kernel.org,
 tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
 sudeep.holla@arm.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

A couple of cosmetic comments below, none of which require immediate
addressing.

[...]

> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> new file mode 100644
> index 000000000000..61375d4571c2
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 - Google LLC
> + * Author: David Brazdil <dbrazdil@google.com>
> + */
> +
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_hyp.h>
> +#include <asm/kvm_mmu.h>
> +#include <kvm/arm_hypercalls.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/psci.h>
> +#include <kvm/arm_psci.h>

nit: is there an ordering issue that requires this to be out
of order?

> +#include <uapi/linux/psci.h>
> +
> +#include <nvhe/trap_handler.h>
> +
> +/* Config options set by the host. */
> +__ro_after_init u32 kvm_host_psci_version;
> +__ro_after_init struct psci_0_1_function_ids 
> kvm_host_psci_0_1_function_ids;

nit: we usually place attributes after the type.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
